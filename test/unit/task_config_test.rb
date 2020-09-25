# frozen_string_literal: true
require 'test_helper'

class TaskConfigTest < Krane::TestCase
  def test_responds_to_namespace
    namespace = "test-namespace"
    assert_equal(task_config(namespace: namespace).namespace, namespace)
  end

  def test_responds_to_context
    context = "test-context"
    assert_equal(task_config(context: "test-context").context, context)
  end

  def test_builds_a_logger_if_none_provided
    assert_equal(task_config(logger: nil).logger.class, Krane::FormattedLogger)
  end

  def test_uses_provided_logger
    logger = Krane::FormattedLogger.build(nil, nil)
    assert_equal(task_config(logger: logger).logger, logger)
  end

  def test_kubeconfig_configured_correctly
    test_task_config = Krane::TaskConfig.new(
      KubeclientHelper::TEST_CONTEXT,
      "something",
      logger,
      '/some/path.yml',
    )
    assert_equal('/some/path.yml', test_task_config.kubeconfig)
    assert_equal(['/some/path.yml'], test_task_config.kubeclient_builder.kubeconfig_files)
  end
end
