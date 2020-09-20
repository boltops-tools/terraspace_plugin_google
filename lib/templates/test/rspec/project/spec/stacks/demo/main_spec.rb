describe "main" do
  before(:all) do
    # Build terraspace project to use as a test harness
    # Will be located at: /tmp/terraspace/test-harnesses/demo-harness
    terraspace.build_test_harness(
      name:    "demo-harness",
      modules: "app/modules",          # include all modules in this folder
      stacks:  "app/stacks",           # include all stacks in this folder
      # override demo stack tfvars for testing
      # copied over to test harness' app/stacks/demo/tfvars/test.tfvars
      tfvars:  {demo: "spec/fixtures/tfvars/demo.tfvars"},
      # create config if needed. The folder will be copied over
      # config:  "spec/fixtures/config",
    )
    terraspace.up("demo") # provision real resources
  end
  after(:all) do
    terraspace.down("demo") # destroy real resources
  end

  it "successful deploy" do
    # Example
    bucket_url = terraspace.output("demo", "bucket_url") # IE: gs://bucket-free-coyote
    expect(bucket_url).to include("gs://bucket-")
  end
end
