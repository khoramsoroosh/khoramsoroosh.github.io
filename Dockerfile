FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential nodejs

# Set working directory
WORKDIR /app

# Copy Gemfiles first (for caching layer)
COPY Gemfile Gemfile.lock ./

# Install Jekyll and Bundler gems
RUN gem install bundler && bundle install

# Copy rest of the application
COPY . .

# Expose the port Jekyll will run on
EXPOSE 4000

# Default command
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--port", "4000", "--livereload"]

