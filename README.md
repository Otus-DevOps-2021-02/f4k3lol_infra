# f4k3lol_infra
f4k3lol Infra repository

Jump to internal host via Bastion
ssh -J nschinnikov@84.201.157.229 10.130.0.21

bastion_IP = 84.201.157.229
someinternalhost_IP = 10.130.0.21

testapp_IP = 178.154.203.180
testapp_port = 9292

В задании terraform-1 сделано:
- Основное задание - автоматическое развертывание н-нного количества сервиса reddit
- Создание со * - настройка балансировщика по внутренним ip н-нного количества сервисов reddit при помощи network load balancer/load balancer target group. Конфигурация в файле lb.tf
В outputs у нас имеются внешние адреса самих сервисов, доступных по порту 9292, а так же адрес балансровщика, сервис доступен на порту 80. Настроены зависимости: lb group от инстансов, lb от lb group.

!!Не понимаю как обращаться к элементам множества (в файле outputs) - можно обьяснить как правильно?
