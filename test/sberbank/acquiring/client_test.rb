# frozen_string_literal: true

require 'test_helper'

module Sberbank
  module Acquiring
    class ClientTest < Minitest::Test
      COMMAND_PATH_MAPPING = {
        deposit: 'deposit',
        get_order_status_extended: 'getOrderStatusExtended',
        payment: 'payment',
        payment_sber_pay: 'paymentSberPay',
        refund: 'refund',
        register: 'register',
        register_pre_auth: 'registerPreAuth',
        reverse: 'reverse',
        verify_enrollment: 'verifyEnrollment'
      }.freeze

      def test_initialize_builds_parameters_convertor_with_username_and_password
        expected_username = Object.new
        expected_password = Object.new
        client = Client.new(username: expected_username, password: expected_password)
        convertor = client.instance_variable_get(:@parameters_convertor)

        assert_kind_of CommandParametersConvertor, convertor
        assert convertor.default_params,
               {
                 'userName' => expected_username,
                 'password' => expected_password
               }
      end

      def test_initialize_builds_parameters_convertor_with_token
        expected_token = Object.new
        client = Client.new(token: expected_token)

        convertor = client.instance_variable_get(:@parameters_convertor)
        assert_kind_of CommandParametersConvertor, convertor
        assert convertor.default_params, { 'token' => expected_token }
      end

      def test_test_default
        client = Client.new(token: Object.new)

        refute client.test?
        refute client.test
      end

      def test_test
        client = Client.new(token: Object.new, test: true)
        assert client.test?
        assert client.test
      end

      COMMAND_PATH_MAPPING.each do |command, path|
        define_method "test_#{command}" do
          client = Client.new
          expected_params = Object.new

          execute_mock = Minitest::Mock.new
          execute_mock.expect(:call, nil, [{ path: path, params: expected_params }])

          client.stub(:execute, execute_mock) do
            client.public_send(command, expected_params)
          end
        end
      end

      def test_execute
        fail
      end
    end
  end
end
