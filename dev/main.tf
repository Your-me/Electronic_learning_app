#Provider
provider "aws" {
  region  = "eu-west-2"
 # profile = "default"
}

#create vpc
module "vpc" {
  source              = "../Modules/vpc"
  vpc-cidr-block      = var.vpc-cidr-block
  pubsub1-cidr-block  = var.pubsub1-cidr-block
  pubsub2-cidr-block  = var.pubsub2-cidr-block
  privsub1-cidr-block = var.privsub1-cidr-block
  privsub2-cidr-block = var.privsub2-cidr-block


}

module "ecs" {
  source                    = "../Modules/ecs"
  vpc_id                    = module.vpc.vpc_id
  pub-sub1                  = module.vpc.pub-sub1
  pub-sub2                  = module.vpc.pub-sub2
  priv-sub1                 = module.vpc.priv-sub1
  priv-sub2                 = module.vpc.priv-sub2
  fargate_cpu               = var.fargate_cpu
  fargate_memory            = var.fargate_memory
  app_count                 = var.app_count
  elearning_certificate_arn = module.acm.elearning_cert_arn
  eaz1                      = module.vpc.eaz1
  eaz2                      = module.vpc.eaz2
  #e-learning-cluster        = var.elearning_certificate.id


}


/* module "route53" {
  source       = "../Modules/route53"
  domain_name  = var.domain_name
  alb-hostname = module.ecs.alb-hostname
  alb-zone_id  = module.ecs.alb-zone_id

} */

module "acm" {
  source           = "../Modules/acm"
  alb-hostname     = module.ecs.alb-hostname
  alb-zone_id      = module.ecs.alb-zone_id
  domain_name      = var.domain_name
  alternative_name = var.alternative_name

}


module "postgresRDS" {
  source           = "../Modules/postgresRDS"
  db_user          = var.db_user
  db_password      = var.db_password
}







