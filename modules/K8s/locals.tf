locals {
  tags = merge({
<<<<<<< HEAD
    "module" = "k8s"
=======
    "module" = "aks"
>>>>>>> 46401636ca16c1f6d81f81785db5cc77559cb122
  }, var.tags)
}