######### StanSample Bernoulli example  ###########

using StanSample

bernoulli_model = "
data {
  int<lower=1> N;
  array[N] int y;
}
parameters {
  real<lower=0,upper=1> theta;
}
model {
  theta ~ beta(1,1);
  y ~ bernoulli(theta);
}
";

data = Dict("N" => 10, "y" => [0, 1, 0, 1, 0, 0, 0, 0, 0, 1])
sm = SampleModel("bernoulli", bernoulli_model);
rc = stan_sample(sm; data, thin=4, delta=0.85);

if success(rc)
  (samples, cnames) = read_samples(sm, :array; return_parameters=true)

  ka = read_samples(sm)
  ka |> display
  println()

end
