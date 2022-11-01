# настройка языка и страны согласно локали.
d-i debian-installer/locale string ru_RU
d-i debian-installer/locale select ru_RU.UTF-8
#d-i debian-installer/language string ru

# Выбор клавиатуры.
d-i console-tools/archs select at
#d-i console-keymaps-at/keymap select ru
d-i console-setup/toggle string Alt+Shift
d-i languagechooser/language-name-fb select Russian
d-i countrychooser/country-name select Russia
d-i keyboard-configuration/xkb-keymap select us



# Пример другой архитектуры клавиатуры
# d-i console-keymaps-usb/keymap select mac-usb-us

# netcfg выберет активный сетевой интерфейс, если такой имеется. Если 
# есть более одного интерфейса, то при данной настройке список
# –∏–Ω—Ç–µ—Ä—Ñ–µ–π—Å–æ–≤ –≤—ã–≤–æ–¥–∏—Ç—Å—è –Ω–µ –±—É–¥–µ—Ç.
d-i netcfg/choose_interface select auto

# интерфейсов выводится не будет.
# d-i netcfg/choose_interface select eth1

# If you have a slow dhcp server and the installer times out waiting for
# it, this might be useful.
# d-i netcfg/dhcp_timeout string 60


#non-free,contrib
d-i apt-setup/non-free boolean true
d-i apt-setup/contrib boolean true



# Имена хоста и домен, назначенные с помощью dhcp имеют приоритет над
# значениями, установленными здесь. Однако, установка значений всё ещё
# предотвращает показ вопросов, даже если значения получены от dhcp.
d-i netcfg/get_hostname string testmachine
d-i netcfg/get_domain string astra

# Выключить показ надоедливого диалога с WEP ключом.
d-i netcfg/wireless_wep string
# Странное имя dhcp сервера, которое используют некоторые провайдеры в
# качестве некоего пароля.
# d-i netcfg/dhcp_hostname string radish


# If non-free firmware is needed for the network or other hardware, you can
# configure the installer to always try to load it, without prompting. Or
# change to false to disable asking.
# d-i hw-detect/load_firmware boolean true

# Если вы выберете ftp, то mirror/country string устанавливать не нужно.
# d-i mirror/protocol string ftp
d-i mirror/country string manual
d-i mirror/http/hostname string 10.0.0.5
d-i mirror/http/directory string /astra
d-i mirror/http/proxy string

# Устанавливаемая версия.
# d-i mirror/suite string testing
# Версия загружаемых компонент (необязательно).
# d-i mirror/udeb/suite string testing



# Задаёт, установлены или нет аппаратные часы по Гринвичу.
d-i clock-setup/utc boolean true

# Здесь вы можете указать любое допустимое значение для $TZ; смотрите
# допустимые значения в файле /usr/share/zoneinfo/.
d-i time/zone string Europe/Moscow

# Определяет, нужно ли использовать NTP для установки часов во время установки
d-i clock-setup/ntp boolean true
# Используемый сервер NTP. Значение по умолчанию указывается здесь.
d-i clock-setup/ntp-server 10.0.0.5



# Или же, вы можете задать размечаемый диск. Имя устройства
# должно задаваться в обычном не-devfs формате.
# Например, для использования первого жёсткого диска SCSI/SATA:
d-i partman-auto/disk string /dev/sda
# Замечание: если вы хотите использовать любой доступный диск, не важно
# какое у него имя, закоммерируйте строку выше. Она работает только если
# в системе один жёсткий диск.
# Также, вы можете указать какой метод использовать.
# Доступные методы: "regular", "lvm" и "crypto" d-i partman-auto/method string regular
d-i partman-auto/method string regular

# Если один из дисков, который нужно разметить с помощью автоматической
# разметки, содержит старую конфигурацию LVM, то пользователю выдаётся
# предупреждение. Ответ можно автоматизировать...
d-i partman-auto/purge_lvm_from_device boolean true
# И подтвердить запись lvm разделов.
d-i partman-lvm/confirm boolean true

# Вы можете выбрать любой из имеющихся наборов разметки.
# Замечание: он должен содержать локализованные (переведённые) значения.
d-i partman-auto/choose_recipe select atomic
# d-i partman-auto/choose_recipe \
# select Отдельный раздел для /home
# d-i partman-auto/choose_recipe \
# select Отдельные разделы для /home, /usr, /var и /tmp

# Или создать набор вручную... 
# Формат файла набора описан в файле devel/partman-auto-recipe.txt. 
# Если вы каким-то образом поместили файл набора в окружение d-i, то можно 
# просто указать путь. 
# d-i partman-auto/expert_recipe_file string /hd-media/recipe

# Если нет, то можно записать набор полностью в файле ответов в одну 
# (логическую) строку. В примере ниже создаётся маленький /boot 
# раздел, подходящего размера раздел подкачки,
# а оставшееся место используется под корневой раздел:
# d-i partman-auto/expert_recipe string                         \
#      boot-root ::                                            \
#              40 50 100 ext3                                  \
#                      $primary{ } $bootable{ }                \
#                      method{ format } format{ }              \
#                      use_filesystem{ } filesystem{ ext3 }    \
#                      mountpoint{ /boot }                     \
#              .                                               \
#              500 10000 1000000000 ext3                       \
#                      method{ format } format{ }              \
#                      use_filesystem{ } filesystem{ ext3 }    \
#                      mountpoint{ / }                         \
#              .                                               \
#              64 512 300% linux-swap                          \
#                      method{ swap } format{ }                \
#              .

# Этот параметр заставляет partman выполнить разметку автоматически 
# без подтверждения.

d-i partman/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true

# Выбрать генератор initramfs, используемый для создания initrd для ядер 2.6.
# d-i base-installer/kernel/linux/initramfs-generators string yaird

# Устанавливаемый пакет (мета) с образом ядра; можно указать "none",
# если ядро устанавливать не нужно.
d-i base-installer/kernel/image string linux-image-generic


# Пропустить создание учётной записи суперпользователя (в обычной учётной # записи пользователя можно использовать sudo). 
# d-i passwd/root-login boolean false 
# Или же пропустить создание обычной учётной записи пользователя.
d-i passwd/make-user boolean true

# Пароль суперпользователя, любой открытым текстом
# d-i passwd/root-password password 12345678
# d-i passwd/root-password-again password 12345678
# или в виде MD5 хеша.
d-i passwd/root-password-crypted password $6$cgEbISJ0$kjOvc05.TsfhDuKCl9/1K/sDHyWVU67wPhgu9uyJluWma8lDOhM.dnS8nn7DxVSaokfG9Jr3DkJL19OeBQOd4/

# Создать учётную запись обычного пользователя.
d-i passwd/user-fullname string Astra
d-i passwd/username string astra

# Пароль обычного пользователя, или открытым текстом
# d-i passwd/user-password password 123456
# d-i passwd/user-password-again password 123456

# или в виде MD5 хеша.
d-i passwd/user-password-crypted password $6$cgEbISJ0$kjOvc05.TsfhDuKCl9/1K/sDHyWVU67wPhgu9uyJluWma8lDOhM.dnS8nn7DxVSaokfG9Jr3DkJL19OeBQOd4/
# Создать первую учётную запись с заданным UID вместо значения по
# умолчанию.
#d-i passwd/user-uid string 1010

# Учётная запись будет добавлена в несколько стандартных начальных групп. 
# Чтобы это изменить -- отредактируйте и раскомментируйте строчку ниже.
#d-i passwd/user-default-groups string audio cdrom video

# Вы можете указать нужно ли устанавливать non-free и contrib ПО. 
d-i apt-setup/non-free boolean true 
d-i apt-setup/contrib boolean true
# Раскомментируйте, если не хотите использовать зеркало из сети.
#d-i apt-setup/use_mirror boolean false
# Выберите обновляемые сервисы; задайте используемые зеркала. 
# Значения ниже используются по умолчанию.
#d-i apt-setup/services-select multi-select security, volatile
#d-i apt-setup/security_host string security.debian.org
#d-i apt-setup/volatile_host string volatile.debian.org

# Дополнительные репозитории доступны как local[0-9]
#d-i apt-setup/local0/repository string \
#       http://local.server/debian stable main
#d-i apt-setup/local0/comment string local server
# Активировать строки для deb-src
#d-i apt-setup/local0/source boolean true
# URL публичного ключа локального репозитория; вы должны 
# предоставлять ключ, или apt будет жаловаться о невозможности 
# аутентифицировать репозиторий и закомментирует строку, 
# описывающую этот репозиторий в sources.list 
d-i apt-setup/local0/key string http://10.0.0.5/astra/dists/smolensk/Release.gpg

# По умолчанию программа установки требует, чтобы репозитории 
# аутентифицировались с помощью известного ключа gpg.
# Этот параметр выключает данную аутентификацию. 
# Предупреждение: это небезопасно, рекомендуется не делать этого.
d-i debian-installer/allow_unauthenticated string true



tasksel tasksel/first multiselect Base, Fly, KDE
# Если выбрана задача Рабочий стол, то установить рабочий стол 
# kde и xfce вместо рабочего стола gnome по умолчанию. 
#tasksel tasksel/desktop multiselect kde, xfce

# Отдельные дополнительные пакеты для установки
#d-i pkgsel/include string openssh-server 
d-i pkgsel/include string openssh-server xrdp
# build-essential

tripwire tripwire/use-localkey boolean false
tripwire tripwire/use-sitekey boolean false
tripwire tripwire/installed note ok

mysql-server mysql-server/root_password astra
mysql-server mysql-server/root_password_again astra

portsentry portsentry/warn_no_block note ok




astra-license astra-license/license boolean true

krb5-config krb5-config/kerberos_servers string 

libnss-ldapd libnss-ldapd/ldap-base string 

libnss-ldapd libnss-ldapd/ldap-uris string

libnss-ldapd libnss-ldapd/nsswitch multiselect services

ald-client ald-client/make_config boolean false

ald-client ald-client/manual_configure note

#astra-feat-setup astra-feat-setup/feat multiselect kiosk mode
astra-feat-setup astra-feat-setup/feat  multiselect

d-i console-cyrillic/switch select "Клавиша Menu"

d-i console-cyrillic/toggle select Control+Shift

d-i samba-common/dhcp boolean false

d-i samba-common/workgroup string testgroup1

# Некоторые версии программы установки могут отсылать отчёт 
# об установленных пакетах. По умолчанию данная возможность
# выключена, но отправка отчёта помогает проекту
# определить популярность программ и какие из них включать на CD.
popularity-contest popularity-contest/participate boolean false


# Grub является загрузчиком по умолчанию (для x86). Если вы хотите 
# установить lilo, раскомментируйте следующую строку: 
#d-i grub-installer/skip boolean true 
# Чтобы пропустить установку lilo и вообще не устанавливать системный 
# загрузчик, раскомментируйте: 
#d-i lilo-installer/skip boolean true

# Эту переменную можно безопасно устанавливать, она указывает, что grub 
# должен устанавливаться в MBR, 
# если на машине не найдено другой операционной системы.
d-i grub-installer/only_debian boolean true

# Это заставляет grub-installer устанавливать в MBR, даже если на машине 
# есть другая ОС, что менее безопасно, так как может привести к отказу 
# загрузки этой другой ОС.
d-i grub-installer/with_other_os boolean true

# Или же, если вы хотите установить загрузчик не в mbr, 
# то раскомментируйте и отредактируйте следующие строки: 
#d-i grub-installer/only_debian boolean false 
#d-i grub-installer/with_other_os boolean false 
#d-i grub-installer/bootdev string (hd0,0) 
# Для установки grub на несколько дисков: 
#d-i grub-installer/bootdev string (hd0,0) (hd1,0) (hd2,0)


# Необязательный пароль на grub, или в виде открытого текста
#d-i grub-installer/password password r00tme
#d-i grub-installer/password-again password r00tme
# или в шифрованном виде с помощью хеша MD5, смотрите grub-md5-crypt(8).
#d-i grub-installer/password-crypted password D1EE0CFC00C1727DD0F5E9E28F4585007B3B053765571CFCAE560517C3EC5327DBB850D034CE4989B8D0459F33D41430378E88AD6533DC8ABDC98D289EC40877.97BD2B84F93ECCD843234531726986EBE0EF29DE1E9A81C212718AA84FBB5E6334D3C9B4C5A05ECB4A0DFD0A25F2B802A243A943101D5A53BB26DF7E8EDC59C1
#d-i grub-installer/password-crypted password "password_pbkdf2 astra grub.pbkdf2.sha512.10000.astra"
d-i grub-installer/password-crypted password astra


# При установке с консоли на последовательном порту обычные виртуальные 
# консоли (VT1-VT6) выключаются в /etc/inittab. Раскомментируйте 
# следующую строку, чтобы этого не происходило. 
#d-i finish-install/keep-consoles boolean true


# Не показывать последнее сообщение о том, что установка завершена.
d-i finish-install/reboot_in_progress note

# Эта настройка заставляет программу установки не выдвигать лоток CD при 
# перезагрузке, что иногда полезно.
d-i cdrom-detect/eject boolean false

# Остановить систему после завершения установки, а 
# не перегружаться в установленную систему. 
#d-i debian-installer/exit/halt boolean true 
# Эта настройка позволяет выключить питание машины, а не просто остановить её. 
#d-i debian-installer/exit/poweroff boolean true 

# В зависимости от выбранного для установки ПО, или если что-то идёт 
# неправильно во время процесса установки, существует вероятность появления других 
# вопросов. Естественно, их тоже можно автоматизировать. Чтобы получить список 
# всех возможных вопросов, которые могут быть заданы во время установки, выполните 
# установку, а затем запустите следующие команды: 
# debconf-get-selections --installer > file 
# debconf-get-selections >> file 

#### Дополнительные опции 
### Запуск различных команд в процессе инсталляции 
# Автоматизация d-i по сути небезопасна. Программа установки не выполняет 
# проверок на переполнения буфера или другого использования значений 
# такого направления из файла ответов. Используйте файлы ответов только из 
# надёжных источников! Для использования дома, и потому что это обычно 
# полезно, здесь показано как запускать свои команды оболочки внутри 
# программы установки автоматически.

# Эта команда будет выполнена самой первой, как только 
# будет прочитан
#d-i preseed/early_command string anna-install some-udeb

# Эта команда выполняется перед окончанием установки, пока ещё 
# есть рабочий каталог /target. Вы можете выполнить chroot в /target 
# и непосредственно использовать его, или же воспользоваться командами 
# apt-install и in-target для облегчения задачи установки пакетов и 
# запуска команд в целевой системе. 
#d-i preseed/late_command string apt-install zsh; in-target chsh -s /bin/zsh
