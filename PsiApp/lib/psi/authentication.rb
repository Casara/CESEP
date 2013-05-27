require 'digest/sha1'

module Psi
  module Authentication
    module Token
      def self.secure_digest(*args)
        Digest::SHA1.hexdigest(args.flatten.join('--'))
      end

      def self.make
        secure_digest(Time.now, (1..10).map { rand.to_s })
      end
    end

    module PasswordManager
      REST_AUTH_DIGEST_STRETCHES = 10

      PASSWORD_MIN_LENGTH = 6
      PASSWORD_MAX_LENGTH = 10

      PASSWORD_WITHIN_LENGTH = PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH

      CHARS = %w(0 1 2 3 4 5 6 7 8 9 ? ! @ # $ % & * _ ç Ç
                 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
                 a b c d e f g h i j k l m n o p q r s t u v w x y z).freeze

      def self.password_digest(password, password_salt)
        digest = REST_AUTH_KEY
        REST_AUTH_DIGEST_STRETCHES.times do
          digest = Token.secure_digest(digest, password_salt, password, REST_AUTH_KEY)
        end
        digest
      end

      def self.check_password(encrypted_password, password, password_salt = '')
        encrypted_password == password_digest(password, password_salt)
      end

      def self.random_password
        password = ''
        1.upto(rand(PASSWORD_WITHIN_LENGTH)) do |i|
          password << CHARS[rand(CHARS.size - 1)]
        end
        password
      end
    end
  end
end