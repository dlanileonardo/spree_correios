module SpreeCorreios
  class Engine < Rails::Engine
    engine_name 'spree_correios'

    def self.activate
      Dir[File.join(File.dirname(__FILE__), "../../app/models/spree/calculator/**/correios_base_calculator.rb")].sort.each do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "spree.register.correios_calculator", after: "spree.register.calculators" do |app|
      if app.config.spree.calculators.shipping_methods
        classes = Dir.chdir File.join(File.dirname(__FILE__), "../../app/models") do
          Dir["spree/calculator/**/*.rb"].reject {|path| path =~ /correios_base_calculator.rb$/ }.map do |path|
            path.gsub('.rb', '').camelize.constantize
          end
        end
      end

      app.config.spree.calculators.shipping_methods.concat classes
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.to_prepare &method(:activate).to_proc
  end
end
