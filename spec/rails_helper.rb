require 'database_cleaner'

Shoulda::Matchers.configure do |config|
	config.integrate do |with|
		with.test_framework :rspec
		with.library :rails
	end
end

RSpec.configuration do |config|
	config.include FactoryBot::Syntax::Methods

	config.before(:suite) do
		DatabaseCleaner.clean_wth(:truncate)
		DatabaseCleaner.strategy = :transaction
	end

	config.around(:each) do
		DatabaseCleaner.cleaning do
			example.run
		end
	end

end


