#!/usr/bin/env ruby

require 'set'

# Get status of the extra container images (in deploy/containers/)
def status_containers
    hashes = Hash.new
    `git ls-tree -z HEAD deploy/containers/`.each_line("\0", chomp: true) do |line|
        line, _, path = line.partition("\t")
        _, type, hash = line.split
        next unless type == 'tree'
        name = path.split('/')[2] # drop deploy/containers/ prefix
        hashes[name] = hash
    end
    dirty = Set.new
    `git status -z deploy/containers/`.each_line("\0", chomp: true) do |line|
        name = line[3..-1].split('/')[2]
        dirty << name
    end

    Hash[
        hashes.map do |key, value|
            value = "#{value}-dirty" if dirty.include? key
            ["STABLE_CONTAINERS_#{key.upcase}", value]
        end
    ]
end

results = Hash.new
results.update status_containers
results.each_pair do |key, value|
    puts "#{key.upcase.tr('^A-Z', '_')} #{value}"
end
