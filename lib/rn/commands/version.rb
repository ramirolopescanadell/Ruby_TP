module RN
  module Commands
    class Version < Dry::CLI::Command
      desc 'Print version'

      def call(*)
        puts RN::VERSION
      end
    end
  end
end
