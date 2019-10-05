require "../spec_helper"

module Ameba
  describe Config do
    config_sample = "config/ameba.yml"

    it "should have a list of available formatters" do
      Config::AVAILABLE_FORMATTERS.should_not be_nil
    end

    describe ".load" do
      it "loads custom config" do
        config = Config.load config_sample
        config.should_not be_nil
        config.globs.should_not be_nil
        config.formatter.should_not be_nil
      end

      it "loads default config" do
        config = Config.load
        config.should_not be_nil
        config.globs.should_not be_nil
        config.formatter.should_not be_nil
      end
    end

    describe "#globs, #globs=" do
      config = Config.load config_sample

      it "holds source globs" do
        config.globs.should contain "spec/ameba/config_spec.cr"
      end

      it "allows to set globs" do
        config.globs = ["file.cr"]
        config.globs.should eq ["file.cr"]
      end
    end

    describe "#sources" do
      config = Config.load config_sample

      it "returns list of sources" do
        config.sources.size.should be > 0
        config.sources.first.should be_a Source
      end
    end

    describe "#formatter, formatter=" do
      config = Config.load config_sample
      formatter = DummyFormatter.new

      it "contains default formatter" do
        config.formatter.should_not be_nil
      end

      it "allows to set formatter" do
        config.formatter = formatter
        config.formatter.should eq formatter
      end

      it "allows to set formatter using a name" do
        config.formatter = :progress
        config.formatter.should_not be_nil
      end

      it "raises an error if not available formatter is set" do
        expect_raises(Exception) do
          config.formatter = :no_such_formatter
        end
      end
    end

    describe "#update_rule" do
      config = Config.load config_sample

      it "updates enabled property" do
        name = DummyRule.rule_name
        config.update_rule name, enabled: false
        rule = config.rules.find(&.name.== name).not_nil!
        rule.enabled.should be_false
      end

      it "updates excluded property" do
        name = DummyRule.rule_name
        excluded = %w(spec/source.cr)
        config.update_rule name, excluded: excluded
        rule = config.rules.find(&.name.== name).not_nil!
        rule.excluded.should eq excluded
      end
    end

    describe "#update_rules" do
      config = Config.load config_sample

      it "updates multiple rules by enabled property" do
        name = DummyRule.rule_name
        config.update_rules [name], enabled: false
        rule = config.rules.find(&.name.== name).not_nil!
        rule.enabled.should be_false
      end

      it "updates multiple rules by excluded property" do
        name = DummyRule.rule_name
        excluded = %w(spec/source.cr)
        config.update_rules [name], excluded: excluded
        rule = config.rules.find(&.name.== name).not_nil!
        rule.excluded.should eq excluded
      end

      it "updates a group of rules by enabled property" do
        group = DummyRule.group_name
        config.update_rules [group], enabled: false
        rule = config.rules.find(&.name.== DummyRule.rule_name).not_nil!
        rule.enabled.should be_false
      end

      it "updates a group by excluded property" do
        name = DummyRule.group_name
        excluded = %w(spec/source.cr)
        config.update_rules [name], excluded: excluded
        rule = config.rules.find(&.name.== DummyRule.rule_name).not_nil!
        rule.excluded.should eq excluded
      end
    end
  end
end
