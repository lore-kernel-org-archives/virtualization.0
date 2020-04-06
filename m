From: Andrew Melnichenko <andrew@daynix.com>
Subject: Re: [PATCH] Fix: buffer overflow during hvc_alloc().
Date: Mon, 6 Apr 2020 11:05:53 +0300
Message-ID: <CABcq3pHMSN9vZRrV1xL6nA7HOK-+wnFSEQsqTqFVvKr4usNbOg@mail.gmail.com>
References: <20200405204024.1007843-1-andrew@daynix.com>
 <a8ab8fe3-3200-9591-7572-abbbd2d505ff@linux.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1140697360709449189=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <a8ab8fe3-3200-9591-7572-abbbd2d505ff@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Andrew Donnellan <ajd@linux.ibm.com>
Cc: gregkh@linuxfoundation.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jslaby@suse.com
List-Id: virtualization@lists.linuxfoundation.org

--===============1140697360709449189==
Content-Type: multipart/alternative; boundary="0000000000004e7fae05a29ab4e9"

--0000000000004e7fae05a29ab4e9
Content-Type: text/plain; charset="UTF-8"

>
> Description of problem:
> Guest get 'Call Trace' when loading module "virtio_console" and unloading
> it frequently
>
>
> Version-Release number of selected component (if applicable):
>   Guest
>      kernel-4.18.0-167.el8.x86_64
>      seabios-bin-1.11.1-4.module+el8.1.0+4066+0f1aadab.noarch
>      # modinfo virtio_console
>        filename:       /lib/modules/4.18.0-
>        167.el8.x86_64/kernel/drivers/char/virtio_console.ko.xz
>        license:        GPL
>        description:    Virtio console driver
>        rhelversion:    8.2
>        srcversion:     55224090DD07750FAD75C9C
>        alias:          virtio:d00000003v*
>        depends:
>        intree:         Y
>        name:           virtio_console
>        vermagic:       4.18.0-167.el8.x86_64 SMP mod_unload modversions
>   Host:
>      qemu-kvm-4.2.0-2.scrmod+el8.2.0+5159+d8aa4d83.x86_64
>      kernel-4.18.0-165.el8.x86_64
>      seabios-bin-1.12.0-5.scrmod+el8.2.0+5159+d8aa4d83.noarch
>
>
>
> How reproducible: 100%
>
>
> Steps to Reproduce:
>
> 1. boot guest with command [1]
> 2. load and unload virtio_console inside guest with loop.sh
>    # cat loop.sh
>     while [ 1 ]
>     do
> modprobe virtio_console
> lsmod | grep virt
> modprobe -r virtio_console
> lsmod | grep virt
>     done
>
>
>
> Actual results:
> Guest reboot and can get vmcore-dmesg.txt file
>
>
> Expected results:
> Guest works well without error
>
>
> Additional info:
> The whole log will attach to the attachments.
>
> Call Trace:
> [   22.974500] fuse: init (API version 7.31)
> [   81.498208] ------------[ cut here ]------------
> [   81.499263] pvqspinlock: lock 0xffffffff92080020 has corrupted value
> 0xc0774ca0!
> [   81.501000] WARNING: CPU: 0 PID: 785 at
> kernel/locking/qspinlock_paravirt.h:500
> __pv_queued_spin_unlock_slowpath+0xc0/0xd0
> [   81.503173] Modules linked in: virtio_console fuse xt_CHECKSUM
> ipt_MASQUERADE xt_conntrack ipt_REJECT nft_counter nf_nat_tftp nft_objref
> nf_conntrack_tftp tun bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6
> nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
> nf_tables_set nft_chain_nat_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6
> nf_nat_ipv6 nft_chain_route_ipv6 nft_chain_nat_ipv4 nf_conntrack_ipv4
> nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack nft_chain_route_ipv4
> ip6_tables nft_compat ip_set nf_tables nfnetlink sunrpc bochs_drm
> drm_vram_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt
> fb_sys_fops drm i2c_piix4 pcspkr crct10dif_pclmul crc32_pclmul joydev
> ghash_clmulni_intel ip_tables xfs libcrc32c sd_mod sg ata_generic ata_piix
> virtio_net libata crc32c_intel net_failover failover serio_raw virtio_scsi
> dm_mirror dm_region_hash dm_log dm_mod [last unloaded: virtio_console]
> [   81.517019] CPU: 0 PID: 785 Comm: kworker/0:2 Kdump: loaded Not tainted
> 4.18.0-167.el8.x86_64 #1
> [   81.518639] Hardware name: Red Hat KVM, BIOS
> 1.12.0-5.scrmod+el8.2.0+5159+d8aa4d83 04/01/2014
> [   81.520205] Workqueue: events control_work_handler [virtio_console]
> [   81.521354] RIP: 0010:__pv_queued_spin_unlock_slowpath+0xc0/0xd0
> [   81.522450] Code: 07 00 48 63 7a 10 e8 bf 64 f5 ff 66 90 c3 8b 05 e6 cf
> d6 01 85 c0 74 01 c3 8b 17 48 89 fe 48 c7 c7 38 4b 29 91 e8 3a 6c fa ff
> <0f> 0b c3 0f 0b 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48
> [   81.525830] RSP: 0018:ffffb51a01ffbd70 EFLAGS: 00010282
> [   81.526798] RAX: 0000000000000000 RBX: 0000000000000010 RCX:
> 0000000000000000
> [   81.528110] RDX: ffff9e66f1826480 RSI: ffff9e66f1816a08 RDI:
> ffff9e66f1816a08
> [   81.529437] RBP: ffffffff9153ff10 R08: 000000000000026c R09:
> 0000000000000053
> [   81.530732] R10: 0000000000000000 R11: ffffb51a01ffbc18 R12:
> ffff9e66cd682200
> [   81.532133] R13: ffffffff9153ff10 R14: ffff9e6685569500 R15:
> ffff9e66cd682000
> [   81.533442] FS:  0000000000000000(0000) GS:ffff9e66f1800000(0000)
> knlGS:0000000000000000
> [   81.534914] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   81.535971] CR2: 00005624c55b14d0 CR3: 00000003a023c000 CR4:
> 00000000003406f0
> [   81.537283] Call Trace:
> [   81.537763]
>  __raw_callee_save___pv_queued_spin_unlock_slowpath+0x11/0x20
> [   81.539011]  .slowpath+0x9/0xe
> [   81.539585]  hvc_alloc+0x25e/0x300
> [   81.540237]  init_port_console+0x28/0x100 [virtio_console]
> [   81.541251]  handle_control_message.constprop.27+0x1c4/0x310
> [virtio_console]
> [   81.542546]  control_work_handler+0x70/0x10c [virtio_console]
> [   81.543601]  process_one_work+0x1a7/0x3b0
> [   81.544356]  worker_thread+0x30/0x390
> [   81.545025]  ? create_worker+0x1a0/0x1a0
> [   81.545749]  kthread+0x112/0x130
> [   81.546358]  ? kthread_flush_work_fn+0x10/0x10
> [   81.547183]  ret_from_fork+0x22/0x40
> [   81.547842] ---[ end trace aa97649bd16c8655 ]---
> [   83.546539] general protection fault: 0000 [#1] SMP NOPTI
> [   83.547422] CPU: 5 PID: 3225 Comm: modprobe Kdump: loaded Tainted: G
>      W        --------- -  - 4.18.0-167.el8.x86_64 #1
> [   83.549191] Hardware name: Red Hat KVM, BIOS
> 1.12.0-5.scrmod+el8.2.0+5159+d8aa4d83 04/01/2014
> [   83.550544] RIP: 0010:__pv_queued_spin_lock_slowpath+0x19a/0x2a0
> [   83.551504] Code: c4 c1 ea 12 41 be 01 00 00 00 4c 8d 6d 14 41 83 e4 03
> 8d 42 ff 49 c1 e4 05 48 98 49 81 c4 40 a5 02 00 4c 03 24 c5 60 48 34 91
> <49> 89 2c 24 b8 00 80 00 00 eb 15 84 c0 75 0a 41 0f b6 54 24 14 84
> [   83.554449] RSP: 0018:ffffb51a0323fdb0 EFLAGS: 00010202
> [   83.555290] RAX: 000000000000301c RBX: ffffffff92080020 RCX:
> 0000000000000001
> [   83.556426] RDX: 000000000000301d RSI: 0000000000000000 RDI:
> 0000000000000000
> [   83.557556] RBP: ffff9e66f196a540 R08: 000000000000028a R09:
> ffff9e66d2757788
> [   83.558688] R10: 0000000000000000 R11: 0000000000000000 R12:
> 646e61725f770b07
> [   83.559821] R13: ffff9e66f196a554 R14: 0000000000000001 R15:
> 0000000000180000
> [   83.560958] FS:  00007fd5032e8740(0000) GS:ffff9e66f1940000(0000)
> knlGS:0000000000000000
> [   83.562233] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   83.563149] CR2: 00007fd5022b0da0 CR3: 000000038c334000 CR4:
> 00000000003406e0
>
>
>
> Command[1]
> /usr/libexec/qemu-kvm \
>     -S  \
>     -name 'avocado-vt-vm1'  \
>     -sandbox on  \
>     -machine pc  \
>     -nodefaults \
>     -device VGA,bus=pci.0,addr=0x2 \
>     -m 14336  \
>     -smp 16,maxcpus=16,cores=8,threads=1,dies=1,sockets=2  \
>     -cpu 'EPYC',+kvm_pv_unhalt  \
>     -chardev
> socket,id=qmp_id_qmpmonitor1,path=/var/tmp/avocado_6ae2tn_f/monitor-qmpmonitor1-20191223-061943-73qpR3NF,server,nowait
> \
>     -mon chardev=qmp_id_qmpmonitor1,mode=control  \
>     -chardev
> socket,id=qmp_id_catch_monitor,path=/var/tmp/avocado_6ae2tn_f/monitor-catch_monitor-20191223-061943-73qpR3NF,server,nowait
> \
>     -mon chardev=qmp_id_catch_monitor,mode=control \
>     -device pvpanic,ioport=0x505,id=idhlgw9I \
>     -chardev
> socket,id=chardev_serial0,path=/var/tmp/avocado_6ae2tn_f/serial-serial0-20191223-061943-73qpR3NF,server,nowait
> \
>     -device isa-serial,id=serial0,chardev=chardev_serial0 \
>     -chardev
> socket,id=chardev_vc1,path=/var/tmp/avocado_6ae2tn_f/serial-vc1-20191223-061943-73qpR3NF,server,nowait
> \
>     -device virtio-serial-pci,id=virtio_serial_pci0,bus=pci.0,addr=0x3 \
>     -device
> virtserialport,id=vc1,name=vc1,chardev=chardev_vc1,bus=virtio_serial_pci0.0,nr=1
> \
>     -chardev
> socket,id=chardev_vc2,path=/var/tmp/avocado_6ae2tn_f/serial-vc2-20191223-061943-73qpR3NF,server,nowait
> \
>     -device virtio-serial-pci,id=virtio_serial_pci1,bus=pci.0,addr=0x4 \
>     -device
> virtconsole,id=vc2,name=vc2,chardev=chardev_vc2,bus=virtio_serial_pci1.0,nr=1
>  \
>     -chardev
> socket,id=seabioslog_id_20191223-061943-73qpR3NF,path=/var/tmp/avocado_6ae2tn_f/seabios-20191223-061943-73qpR3NF,server,nowait
> \
>     -device
> isa-debugcon,chardev=seabioslog_id_20191223-061943-73qpR3NF,iobase=0x402 \
>     -device qemu-xhci,id=usb1,bus=pci.0,addr=0x5 \
>     -device virtio-scsi-pci,id=virtio_scsi_pci0,bus=pci.0,addr=0x6 \
>     -drive
> id=drive_image1,if=none,snapshot=off,aio=threads,cache=none,format=qcow2,file=/home/kvm_autotest_root/images/rhel820-64-virtio-scsi.qcow2
> \
>     -device scsi-hd,id=image1,drive=drive_image1 \
>     -device
> virtio-net-pci,mac=9a:43:0d:1d:8d:d1,id=idmHPkFv,netdev=idTPtFdd,bus=pci.0,addr=0x7
>  \
>     -netdev tap,id=idTPtFdd,vhost=on \
>     -device usb-tablet,id=usb-tablet1,bus=usb1.0,port=1  \
>     -vnc :0  \
>     -rtc base=utc,clock=host,driftfix=slew  \
>     -boot menu=off,order=cdn,once=c,strict=off \
>     -enable-kvm \
>     -monitor stdio \
>     -qmp tcp:0:4444,server,nowait \


On Mon, Apr 6, 2020 at 3:32 AM Andrew Donnellan <ajd@linux.ibm.com> wrote:

> On 6/4/20 6:40 am, andrew@daynix.com wrote:
> > From: Andrew Melnychenko <andrew@daynix.com>
> >
> > If there is a lot(more then 16) of virtio-console devices
> > or virtio_console module is reloaded
> > - buffers 'vtermnos' and 'cons_ops' are overflowed.
> > In older kernels it overruns spinlock which leads to kernel freezing:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1786239
> >
>
> This Bugzilla report isn't publicly accessible. Can you include a
> relevant summary here and/or make the report publicly viewable?
>
> If it does indeed lead to a kernel freeze, this should be tagged with a
> Fixes: and a Cc: stable@vger.kernel.org.
>
> --
> Andrew Donnellan              OzLabs, ADL Canberra
> ajd@linux.ibm.com             IBM Australia Limited
>
>

--0000000000004e7fae05a29ab4e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Descript=
ion of problem:<br>Guest get &#39;Call Trace&#39; when loading module &quot=
;virtio_console&quot; and unloading it frequently<br><br><br>Version-Releas=
e number of selected component (if applicable):<br>=C2=A0 Guest<br>=C2=A0 =
=C2=A0 =C2=A0kernel-4.18.0-167.el8.x86_64<br>=C2=A0 =C2=A0 =C2=A0seabios-bi=
n-1.11.1-4.module+el8.1.0+4066+0f1aadab.noarch<br>=C2=A0 =C2=A0 =C2=A0# mod=
info virtio_console<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0filename: =C2=A0 =C2=A0 =
=C2=A0 /lib/modules/4.18.0- <br>=C2=A0 =C2=A0 =C2=A0 =C2=A0167.el8.x86_64/k=
ernel/drivers/char/virtio_console.ko.xz<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0licen=
se: =C2=A0 =C2=A0 =C2=A0 =C2=A0GPL<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0descriptio=
n: =C2=A0 =C2=A0Virtio console driver<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0rhelver=
sion: =C2=A0 =C2=A08.2<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0srcversion: =C2=A0 =C2=
=A0 55224090DD07750FAD75C9C<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0alias: =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0virtio:d00000003v*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0de=
pends: =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0intree: =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Y<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0name: =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_console<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0ve=
rmagic: =C2=A0 =C2=A0 =C2=A0 4.18.0-167.el8.x86_64 SMP mod_unload modversio=
ns <br>=C2=A0 Host:<br>=C2=A0 =C2=A0 =C2=A0qemu-kvm-4.2.0-2.scrmod+el8.2.0+=
5159+d8aa4d83.x86_64<br>=C2=A0 =C2=A0 =C2=A0kernel-4.18.0-165.el8.x86_64<br=
>=C2=A0 =C2=A0 =C2=A0seabios-bin-1.12.0-5.scrmod+el8.2.0+5159+d8aa4d83.noar=
ch<br><br>=C2=A0 =C2=A0 <br><br>How reproducible: 100%<br><br><br>Steps to =
Reproduce:<br><br>1. boot guest with command [1]<br>2. load and unload virt=
io_console inside guest with loop.sh<br>=C2=A0 =C2=A0# cat loop.sh<br>=C2=
=A0 =C2=A0 while [ 1 ]<br>=C2=A0 =C2=A0 do<br>	modprobe virtio_console<br>	=
lsmod | grep virt<br>	modprobe -r virtio_console<br>	lsmod | grep virt<br>=
=C2=A0 =C2=A0 done<br><br><br><br>Actual results:<br>Guest reboot and can g=
et vmcore-dmesg.txt file<br><br><br>Expected results:<br>Guest works well w=
ithout error<br><br><br>Additional info:<br>The whole log will attach to th=
e attachments.<br><br>Call Trace:<br>[ =C2=A0 22.974500] fuse: init (API ve=
rsion 7.31)<br>[ =C2=A0 81.498208] ------------[ cut here ]------------<br>=
[ =C2=A0 81.499263] pvqspinlock: lock 0xffffffff92080020 has corrupted valu=
e 0xc0774ca0!<br>[ =C2=A0 81.501000] WARNING: CPU: 0 PID: 785 at kernel/loc=
king/qspinlock_paravirt.h:500 __pv_queued_spin_unlock_slowpath+0xc0/0xd0<br=
>[ =C2=A0 81.503173] Modules linked in: virtio_console fuse xt_CHECKSUM ipt=
_MASQUERADE xt_conntrack ipt_REJECT nft_counter nf_nat_tftp nft_objref nf_c=
onntrack_tftp tun bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft=
_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_tab=
les_set nft_chain_nat_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 nft=
_chain_route_ipv6 nft_chain_nat_ipv4 nf_conntrack_ipv4 nf_defrag_ipv4 nf_na=
t_ipv4 nf_nat nf_conntrack nft_chain_route_ipv4 ip6_tables nft_compat ip_se=
t nf_tables nfnetlink sunrpc bochs_drm drm_vram_helper ttm drm_kms_helper s=
yscopyarea sysfillrect sysimgblt fb_sys_fops drm i2c_piix4 pcspkr crct10dif=
_pclmul crc32_pclmul joydev ghash_clmulni_intel ip_tables xfs libcrc32c sd_=
mod sg ata_generic ata_piix virtio_net libata crc32c_intel net_failover fai=
lover serio_raw virtio_scsi dm_mirror dm_region_hash dm_log dm_mod [last un=
loaded: virtio_console]<br>[ =C2=A0 81.517019] CPU: 0 PID: 785 Comm: kworke=
r/0:2 Kdump: loaded Not tainted 4.18.0-167.el8.x86_64 #1<br>[ =C2=A0 81.518=
639] Hardware name: Red Hat KVM, BIOS 1.12.0-5.scrmod+el8.2.0+5159+d8aa4d83=
 04/01/2014<br>[ =C2=A0 81.520205] Workqueue: events control_work_handler [=
virtio_console]<br>[ =C2=A0 81.521354] RIP: 0010:__pv_queued_spin_unlock_sl=
owpath+0xc0/0xd0<br>[ =C2=A0 81.522450] Code: 07 00 48 63 7a 10 e8 bf 64 f5=
 ff 66 90 c3 8b 05 e6 cf d6 01 85 c0 74 01 c3 8b 17 48 89 fe 48 c7 c7 38 4b=
 29 91 e8 3a 6c fa ff &lt;0f&gt; 0b c3 0f 0b 90 90 90 90 90 90 90 90 90 90 =
90 0f 1f 44 00 00 48<br>[ =C2=A0 81.525830] RSP: 0018:ffffb51a01ffbd70 EFLA=
GS: 00010282<br>[ =C2=A0 81.526798] RAX: 0000000000000000 RBX: 000000000000=
0010 RCX: 0000000000000000<br>[ =C2=A0 81.528110] RDX: ffff9e66f1826480 RSI=
: ffff9e66f1816a08 RDI: ffff9e66f1816a08<br>[ =C2=A0 81.529437] RBP: ffffff=
ff9153ff10 R08: 000000000000026c R09: 0000000000000053<br>[ =C2=A0 81.53073=
2] R10: 0000000000000000 R11: ffffb51a01ffbc18 R12: ffff9e66cd682200<br>[ =
=C2=A0 81.532133] R13: ffffffff9153ff10 R14: ffff9e6685569500 R15: ffff9e66=
cd682000<br>[ =C2=A0 81.533442] FS: =C2=A00000000000000000(0000) GS:ffff9e6=
6f1800000(0000) knlGS:0000000000000000<br>[ =C2=A0 81.534914] CS: =C2=A0001=
0 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ =C2=A0 81.535971] CR2: 00005=
624c55b14d0 CR3: 00000003a023c000 CR4: 00000000003406f0<br>[ =C2=A0 81.5372=
83] Call Trace:<br>[ =C2=A0 81.537763] =C2=A0__raw_callee_save___pv_queued_=
spin_unlock_slowpath+0x11/0x20<br>[ =C2=A0 81.539011] =C2=A0.slowpath+0x9/0=
xe<br>[ =C2=A0 81.539585] =C2=A0hvc_alloc+0x25e/0x300<br>[ =C2=A0 81.540237=
] =C2=A0init_port_console+0x28/0x100 [virtio_console]<br>[ =C2=A0 81.541251=
] =C2=A0handle_control_message.constprop.27+0x1c4/0x310 [virtio_console]<br=
>[ =C2=A0 81.542546] =C2=A0control_work_handler+0x70/0x10c [virtio_console]=
<br>[ =C2=A0 81.543601] =C2=A0process_one_work+0x1a7/0x3b0<br>[ =C2=A0 81.5=
44356] =C2=A0worker_thread+0x30/0x390<br>[ =C2=A0 81.545025] =C2=A0? create=
_worker+0x1a0/0x1a0<br>[ =C2=A0 81.545749] =C2=A0kthread+0x112/0x130<br>[ =
=C2=A0 81.546358] =C2=A0? kthread_flush_work_fn+0x10/0x10<br>[ =C2=A0 81.54=
7183] =C2=A0ret_from_fork+0x22/0x40<br>[ =C2=A0 81.547842] ---[ end trace a=
a97649bd16c8655 ]---<br>[ =C2=A0 83.546539] general protection fault: 0000 =
[#1] SMP NOPTI<br>[ =C2=A0 83.547422] CPU: 5 PID: 3225 Comm: modprobe Kdump=
: loaded Tainted: G =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0 =C2=A0 =C2=A0 =C2=
=A0--------- - =C2=A0- 4.18.0-167.el8.x86_64 #1<br>[ =C2=A0 83.549191] Hard=
ware name: Red Hat KVM, BIOS 1.12.0-5.scrmod+el8.2.0+5159+d8aa4d83 04/01/20=
14<br>[ =C2=A0 83.550544] RIP: 0010:__pv_queued_spin_lock_slowpath+0x19a/0x=
2a0<br>[ =C2=A0 83.551504] Code: c4 c1 ea 12 41 be 01 00 00 00 4c 8d 6d 14 =
41 83 e4 03 8d 42 ff 49 c1 e4 05 48 98 49 81 c4 40 a5 02 00 4c 03 24 c5 60 =
48 34 91 &lt;49&gt; 89 2c 24 b8 00 80 00 00 eb 15 84 c0 75 0a 41 0f b6 54 2=
4 14 84<br>[ =C2=A0 83.554449] RSP: 0018:ffffb51a0323fdb0 EFLAGS: 00010202<=
br>[ =C2=A0 83.555290] RAX: 000000000000301c RBX: ffffffff92080020 RCX: 000=
0000000000001<br>[ =C2=A0 83.556426] RDX: 000000000000301d RSI: 00000000000=
00000 RDI: 0000000000000000<br>[ =C2=A0 83.557556] RBP: ffff9e66f196a540 R0=
8: 000000000000028a R09: ffff9e66d2757788<br>[ =C2=A0 83.558688] R10: 00000=
00000000000 R11: 0000000000000000 R12: 646e61725f770b07<br>[ =C2=A0 83.5598=
21] R13: ffff9e66f196a554 R14: 0000000000000001 R15: 0000000000180000<br>[ =
=C2=A0 83.560958] FS: =C2=A000007fd5032e8740(0000) GS:ffff9e66f1940000(0000=
) knlGS:0000000000000000<br>[ =C2=A0 83.562233] CS: =C2=A00010 DS: 0000 ES:=
 0000 CR0: 0000000080050033<br>[ =C2=A0 83.563149] CR2: 00007fd5022b0da0 CR=
3: 000000038c334000 CR4: 00000000003406e0<br><br><br><br>Command[1]<br>/usr=
/libexec/qemu-kvm \<br>=C2=A0 =C2=A0 -S =C2=A0\<br>=C2=A0 =C2=A0 -name &#39=
;avocado-vt-vm1&#39; =C2=A0\<br>=C2=A0 =C2=A0 -sandbox on =C2=A0\<br>=C2=A0=
 =C2=A0 -machine pc =C2=A0\<br>=C2=A0 =C2=A0 -nodefaults \<br>=C2=A0 =C2=A0=
 -device VGA,bus=3Dpci.0,addr=3D0x2 \<br>=C2=A0 =C2=A0 -m 14336 =C2=A0\<br>=
=C2=A0 =C2=A0 -smp 16,maxcpus=3D16,cores=3D8,threads=3D1,dies=3D1,sockets=
=3D2 =C2=A0\<br>=C2=A0 =C2=A0 -cpu &#39;EPYC&#39;,+kvm_pv_unhalt =C2=A0\<br=
>=C2=A0 =C2=A0 -chardev socket,id=3Dqmp_id_qmpmonitor1,path=3D/var/tmp/avoc=
ado_6ae2tn_f/monitor-qmpmonitor1-20191223-061943-73qpR3NF,server,nowait \<b=
r>=C2=A0 =C2=A0 -mon chardev=3Dqmp_id_qmpmonitor1,mode=3Dcontrol =C2=A0\<br=
>=C2=A0 =C2=A0 -chardev socket,id=3Dqmp_id_catch_monitor,path=3D/var/tmp/av=
ocado_6ae2tn_f/monitor-catch_monitor-20191223-061943-73qpR3NF,server,nowait=
 \<br>=C2=A0 =C2=A0 -mon chardev=3Dqmp_id_catch_monitor,mode=3Dcontrol \<br=
>=C2=A0 =C2=A0 -device pvpanic,ioport=3D0x505,id=3Didhlgw9I \<br>=C2=A0 =C2=
=A0 -chardev socket,id=3Dchardev_serial0,path=3D/var/tmp/avocado_6ae2tn_f/s=
erial-serial0-20191223-061943-73qpR3NF,server,nowait \<br>=C2=A0 =C2=A0 -de=
vice isa-serial,id=3Dserial0,chardev=3Dchardev_serial0 \<br>=C2=A0 =C2=A0 -=
chardev socket,id=3Dchardev_vc1,path=3D/var/tmp/avocado_6ae2tn_f/serial-vc1=
-20191223-061943-73qpR3NF,server,nowait \<br>=C2=A0 =C2=A0 -device virtio-s=
erial-pci,id=3Dvirtio_serial_pci0,bus=3Dpci.0,addr=3D0x3 \<br>=C2=A0 =C2=A0=
 -device virtserialport,id=3Dvc1,name=3Dvc1,chardev=3Dchardev_vc1,bus=3Dvir=
tio_serial_pci0.0,nr=3D1 \<br>=C2=A0 =C2=A0 -chardev socket,id=3Dchardev_vc=
2,path=3D/var/tmp/avocado_6ae2tn_f/serial-vc2-20191223-061943-73qpR3NF,serv=
er,nowait \<br>=C2=A0 =C2=A0 -device virtio-serial-pci,id=3Dvirtio_serial_p=
ci1,bus=3Dpci.0,addr=3D0x4 \<br>=C2=A0 =C2=A0 -device virtconsole,id=3Dvc2,=
name=3Dvc2,chardev=3Dchardev_vc2,bus=3Dvirtio_serial_pci1.0,nr=3D1 =C2=A0\<=
br>=C2=A0 =C2=A0 -chardev socket,id=3Dseabioslog_id_20191223-061943-73qpR3N=
F,path=3D/var/tmp/avocado_6ae2tn_f/seabios-20191223-061943-73qpR3NF,server,=
nowait \<br>=C2=A0 =C2=A0 -device isa-debugcon,chardev=3Dseabioslog_id_2019=
1223-061943-73qpR3NF,iobase=3D0x402 \<br>=C2=A0 =C2=A0 -device qemu-xhci,id=
=3Dusb1,bus=3Dpci.0,addr=3D0x5 \<br>=C2=A0 =C2=A0 -device virtio-scsi-pci,i=
d=3Dvirtio_scsi_pci0,bus=3Dpci.0,addr=3D0x6 \<br>=C2=A0 =C2=A0 -drive id=3D=
drive_image1,if=3Dnone,snapshot=3Doff,aio=3Dthreads,cache=3Dnone,format=3Dq=
cow2,file=3D/home/kvm_autotest_root/images/rhel820-64-virtio-scsi.qcow2 \<b=
r>=C2=A0 =C2=A0 -device scsi-hd,id=3Dimage1,drive=3Ddrive_image1 \<br>=C2=
=A0 =C2=A0 -device virtio-net-pci,mac=3D9a:43:0d:1d:8d:d1,id=3DidmHPkFv,net=
dev=3DidTPtFdd,bus=3Dpci.0,addr=3D0x7 =C2=A0\<br>=C2=A0 =C2=A0 -netdev tap,=
id=3DidTPtFdd,vhost=3Don \<br>=C2=A0 =C2=A0 -device usb-tablet,id=3Dusb-tab=
let1,bus=3Dusb1.0,port=3D1 =C2=A0\<br>=C2=A0 =C2=A0 -vnc :0 =C2=A0\<br>=C2=
=A0 =C2=A0 -rtc base=3Dutc,clock=3Dhost,driftfix=3Dslew =C2=A0\<br>=C2=A0 =
=C2=A0 -boot menu=3Doff,order=3Dcdn,once=3Dc,strict=3Doff \<br>=C2=A0 =C2=
=A0 -enable-kvm \<br>=C2=A0 =C2=A0 -monitor stdio \<br>=C2=A0 =C2=A0 -qmp t=
cp:0:4444,server,nowait \</blockquote></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 6, 2020 at 3:32 AM Andrew=
 Donnellan &lt;<a href=3D"mailto:ajd@linux.ibm.com">ajd@linux.ibm.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 6/4=
/20 6:40 am, <a href=3D"mailto:andrew@daynix.com" target=3D"_blank">andrew@=
daynix.com</a> wrote:<br>
&gt; From: Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.com" targ=
et=3D"_blank">andrew@daynix.com</a>&gt;<br>
&gt; <br>
&gt; If there is a lot(more then 16) of virtio-console devices<br>
&gt; or virtio_console module is reloaded<br>
&gt; - buffers &#39;vtermnos&#39; and &#39;cons_ops&#39; are overflowed.<br=
>
&gt; In older kernels it overruns spinlock which leads to kernel freezing:<=
br>
&gt; <a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1786239" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?=
id=3D1786239</a><br>
&gt; <br>
<br>
This Bugzilla report isn&#39;t publicly accessible. Can you include a <br>
relevant summary here and/or make the report publicly viewable?<br>
<br>
If it does indeed lead to a kernel freeze, this should be tagged with a <br=
>
Fixes: and a Cc: <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank=
">stable@vger.kernel.org</a>.<br>
<br>
-- <br>
Andrew Donnellan=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OzLabs, AD=
L Canberra<br>
<a href=3D"mailto:ajd@linux.ibm.com" target=3D"_blank">ajd@linux.ibm.com</a=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IBM Australia Limited<br>
<br>
</blockquote></div>

--0000000000004e7fae05a29ab4e9--

--===============1140697360709449189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1140697360709449189==--
