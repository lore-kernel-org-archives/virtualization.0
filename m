From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: bochs_drm: failed bochs_hw_init() results in panic
Date: Fri, 10 Jan 2020 02:33:28 +0100
Message-ID: <20200110013328.GA12596@mail-itl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8583934754208163184=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============8583934754208163184==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline


--CE+1k2dSO48ffgeK
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: bochs_drm: failed bochs_hw_init() results in panic

Hi,

It looks like bochs_kms_fini() don't like being called if
bochs_kms_init() wasn't. Regardless of the reason for the
bochs_hw_init() failure (that's another story), it shouldn't cause a
panic. Any idea how to fix it?

Full message:
[   33.032576] [drm:bochs_hw_init [bochs_drm]] *ERROR* Cannot request frame=
buffer
[   33.069435] ------------[ cut here ]------------
[   33.070920] WARNING: CPU: 1 PID: 879 at drivers/gpu/drm/drm_modeset_lock=
=2Ec:266 drm_modeset_lock+0xef/0x100 [drm]
[   33.073719] Modules linked in: amd64_edac_mod(-) snd_ac97_codec edac_mce=
_amd ac97_bus snd_seq snd_seq_device bochs_drm(+) drm_vram_helper snd_pcm p=
cspkr ttm parport_pc drm_kms_helper parport drm i2c_piix4 snd_timer e1000e =
snd soundcore xenfs ip_tables dm_thin_pool dm_persistent_data dm_bio_prison=
 libcrc32c dm_crypt serio_raw ehci_pci ata_generic virtio_console virtio_sc=
si pata_acpi ehci_hcd floppy qemu_fw_cfg xen_privcmd xen_pciback xen_blkbac=
k xen_gntalloc xen_gntdev xen_evtchn uinput pkcs8_key_parser
[   33.085969] CPU: 1 PID: 879 Comm: systemd-udevd Tainted: G        W     =
    5.4.5-1.qubes.x86_64 #1
[   33.088483] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
0.0.0 02/06/2015
[   33.090762] RIP: e030:drm_modeset_lock+0xef/0x100 [drm]
[   33.092213] Code: ff ff eb de e8 22 31 7e c1 41 89 c4 e9 75 ff ff ff 0f =
0b e9 4c ff ff ff 41 83 fc 8e 74 c1 41 83 fc dd 75 be 48 89 6b 18 eb b8 <0f=
> 0b e9 6f ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[   33.097304] RSP: e02b:ffffc90000f379d0 EFLAGS: 00010286
[   33.098741] RAX: 0000000000000000 RBX: ffffc90000f37a40 RCX: 00000000000=
00000
[   33.100728] RDX: ffff88813bba2540 RSI: 0000000000000000 RDI: ffff8881401=
28a00
[   33.102677] RBP: ffff888133931198 R08: 0000000000000000 R09: ffff88813bb=
a4b30
[   33.104613] R10: 0000000000007ff0 R11: 0000000000000000 R12: 00000000000=
00000
[   33.106592] R13: ffff8881339311c0 R14: 0000000000000010 R15: 00000000000=
00000
[   33.108555] FS:  00007e279f5e7940(0000) GS:ffff888140100000(0000) knlGS:=
0000000000000000
[   33.110654] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.112210] CR2: 000058a34b0d8774 CR3: 0000000138ff0000 CR4: 00000000000=
00660
[   33.114124] Call Trace:
[   33.114866]  drm_modeset_lock_all_ctx+0x1f/0xe0 [drm]
[   33.116284]  drm_atomic_helper_shutdown+0x43/0xc0 [drm_kms_helper]
[   33.118033]  bochs_kms_fini+0x12/0x20 [bochs_drm]
[   33.119252]  bochs_unload+0x16/0x40 [bochs_drm]
[   33.120570]  bochs_pci_probe+0xe8/0x160 [bochs_drm]
[   33.121967]  local_pci_probe+0x42/0x80
[   33.123041]  pci_device_probe+0x107/0x1a0
[   33.124190]  really_probe+0x147/0x3c0
[   33.125233]  driver_probe_device+0xb6/0x100
[   33.126384]  device_driver_attach+0x53/0x60
[   33.127533]  __driver_attach+0x8a/0x150
[   33.128603]  ? device_driver_attach+0x60/0x60
[   33.129830]  bus_for_each_dev+0x89/0xd0
[   33.130920]  bus_add_driver+0x14d/0x1f0
[   33.131990]  driver_register+0x6c/0xc0
[   33.133074]  ? 0xffffffffc02a8000
[   33.134003]  do_one_initcall+0x59/0x214
[   33.135038]  do_init_module+0x5c/0x230
[   33.135044] hrtimer: interrupt took 7595223 ns
[   33.137336]  load_module+0x1129/0x1260
[   33.138355]  ? __do_sys_finit_module+0xbb/0x120
[   33.139656]  __do_sys_finit_module+0xbb/0x120
[   33.140873]  do_syscall_64+0x5b/0x1a0
[   33.141917]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   33.143329] RIP: 0033:0x7e27a058d1ad
[   33.144329] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab 5c 0c 00 f7 d8 64 89 01 48
[   33.150780] RSP: 002b:00007fff32c25888 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   33.152850] RAX: ffffffffffffffda RBX: 00005ef4b82f7e90 RCX: 00007e27a05=
8d1ad
[   33.154721] RDX: 0000000000000000 RSI: 00007e27a01b484d RDI: 00000000000=
00012
[   33.156695] RBP: 0000000000020000 R08: 0000000000000000 R09: 00000000000=
00007
[   33.158651] R10: 0000000000000012 R11: 0000000000000246 R12: 00007e27a01=
b484d
[   33.160635] R13: 0000000000000000 R14: 00005ef4b8311570 R15: 00005ef4b82=
f7e90
[   33.162572] ---[ end trace 688bd10d7416ac12 ]---
[   33.430995] ppdev: user-space parallel port driver
[   33.597636] Already setup the GSI :10
[   33.607033] snd_intel8x0 0000:00:03.0: enable KVM optimization
[   33.752121] BUG: kernel NULL pointer dereference, address: 0000000000000=
018
[   33.754174] #PF: supervisor write access in kernel mode
[   33.755600] #PF: error_code(0x0002) - not-present page
[   33.757036] PGD 0 P4D 0=20
[   33.757779] Oops: 0002 [#1] SMP NOPTI
[   33.758811] CPU: 1 PID: 879 Comm: systemd-udevd Tainted: G        W     =
    5.4.5-1.qubes.x86_64 #1
[   33.761352] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
0.0.0 02/06/2015
[   33.763587] RIP: e030:ww_mutex_lock+0x20/0x80
[   33.764813] Code: 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 41 55 41 =
54 49 89 f4 55 48 89 fd e8 9b e2 ff ff 31 c0 65 48 8b 14 25 c0 6b 01 00 <f0=
> 48 0f b1 55 00 74 0d 4c 89 e6 48 89 ef 5d 41 5c 41 5d eb ab 4d
[   33.770009] RSP: e02b:ffffc90000f379b0 EFLAGS: 00010246
[   33.771434] RAX: 0000000000000000 RBX: ffffc90000f37a40 RCX: 00000000000=
00000
[   33.773412] RDX: ffff88813bba2540 RSI: 0000000000000000 RDI: ffff8881401=
28a00
[   33.775359] RBP: 0000000000000018 R08: 0000000000000000 R09: ffff8881401=
29450
[   33.777334] R10: 0000000000007ff0 R11: 0000000000000000 R12: ffffc90000f=
37a40
[   33.779305] R13: 0000000000000000 R14: fffffffffffffff0 R15: 00000000000=
00000
[   33.781263] FS:  00007e279f5e7940(0000) GS:ffff888140100000(0000) knlGS:=
0000000000000000
[   33.783492] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.785083] CR2: 0000000000000018 CR3: 0000000138ff0000 CR4: 00000000000=
00660
[   33.787039] Call Trace:
[   33.787786]  drm_modeset_lock+0x48/0x100 [drm]
[   33.789052]  drm_modeset_lock_all_ctx+0x58/0xe0 [drm]
[   33.790476]  drm_atomic_helper_shutdown+0x43/0xc0 [drm_kms_helper]
[   33.792196]  bochs_kms_fini+0x12/0x20 [bochs_drm]
[   33.793491]  bochs_unload+0x16/0x40 [bochs_drm]
[   33.794749]  bochs_pci_probe+0xe8/0x160 [bochs_drm]
[   33.796107]  local_pci_probe+0x42/0x80
[   33.797180]  pci_device_probe+0x107/0x1a0
[   33.798276]  really_probe+0x147/0x3c0
[   33.799317]  driver_probe_device+0xb6/0x100
[   33.800504]  device_driver_attach+0x53/0x60
[   33.801670]  __driver_attach+0x8a/0x150
[   33.802759]  ? device_driver_attach+0x60/0x60
[   33.803972]  bus_for_each_dev+0x89/0xd0
[   33.805038]  bus_add_driver+0x14d/0x1f0
[   33.806112]  driver_register+0x6c/0xc0
[   33.807159]  ? 0xffffffffc02a8000
[   33.808098]  do_one_initcall+0x59/0x214
[   33.809161]  do_init_module+0x5c/0x230
[   33.810235]  load_module+0x1129/0x1260
[   33.811269]  ? __do_sys_finit_module+0xbb/0x120
[   33.812543]  __do_sys_finit_module+0xbb/0x120
[   33.813768]  do_syscall_64+0x5b/0x1a0
[   33.814772]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   33.816111] RIP: 0033:0x7e27a058d1ad
[   33.817080] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab 5c 0c 00 f7 d8 64 89 01 48
[   33.822091] RSP: 002b:00007fff32c25888 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   33.824104] RAX: ffffffffffffffda RBX: 00005ef4b82f7e90 RCX: 00007e27a05=
8d1ad
[   33.826023] RDX: 0000000000000000 RSI: 00007e27a01b484d RDI: 00000000000=
00012
[   33.827948] RBP: 0000000000020000 R08: 0000000000000000 R09: 00000000000=
00007
[   33.829914] R10: 0000000000000012 R11: 0000000000000246 R12: 00007e27a01=
b484d
[   33.831824] R13: 0000000000000000 R14: 00005ef4b8311570 R15: 00005ef4b82=
f7e90
[   33.833746] Modules linked in: joydev ppdev snd_intel8x0(+) snd_ac97_cod=
ec edac_mce_amd ac97_bus snd_seq snd_seq_device bochs_drm(+) drm_vram_helpe=
r snd_pcm pcspkr ttm parport_pc drm_kms_helper parport drm i2c_piix4 snd_ti=
mer e1000e snd soundcore xenfs ip_tables dm_thin_pool dm_persistent_data dm=
_bio_prison libcrc32c dm_crypt serio_raw ehci_pci ata_generic virtio_consol=
e virtio_scsi pata_acpi ehci_hcd floppy qemu_fw_cfg xen_privcmd xen_pciback=
 xen_blkback xen_gntalloc xen_gntdev xen_evtchn uinput pkcs8_key_parser
[   33.845935] CR2: 0000000000000018
[   33.847042] ---[ end trace 688bd10d7416ac13 ]---
[   33.848388] RIP: e030:ww_mutex_lock+0x20/0x80
[   33.849666] Code: 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00 00 41 55 41 =
54 49 89 f4 55 48 89 fd e8 9b e2 ff ff 31 c0 65 48 8b 14 25 c0 6b 01 00 <f0=
> 48 0f b1 55 00 74 0d 4c 89 e6 48 89 ef 5d 41 5c 41 5d eb ab 4d
[   33.854831] RSP: e02b:ffffc90000f379b0 EFLAGS: 00010246
[   33.856378] RAX: 0000000000000000 RBX: ffffc90000f37a40 RCX: 00000000000=
00000
[   33.858349] RDX: ffff88813bba2540 RSI: 0000000000000000 RDI: ffff8881401=
28a00
[   33.860344] RBP: 0000000000000018 R08: 0000000000000000 R09: ffff8881401=
29450
[   33.862299] R10: 0000000000007ff0 R11: 0000000000000000 R12: ffffc90000f=
37a40
[   33.864294] R13: 0000000000000000 R14: fffffffffffffff0 R15: 00000000000=
00000
[   33.866296] FS:  00007e279f5e7940(0000) GS:ffff888140100000(0000) knlGS:=
0000000000000000
[   33.868544] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.870179] CR2: 0000000000000018 CR3: 0000000138ff0000 CR4: 00000000000=
00660
[   33.872141] Kernel panic - not syncing: Fatal exception
[   33.873609] Kernel Offset: disabled


--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl4X1GgACgkQ24/THMrX
1ywNuQf/fWKeDFV1MgocCBRDbaUI7isNcySgB/XNQkcpIR0RByPOUR6QKj+9R2kP
RUi03w2rC/OIsCZq4LTOpy9xknyO0hnJ2WMe+8iZ0qaSnviLBWiU1J2c03S9V9xd
E9wZDyhXp0R2ojbEEYtCynbfXDlOnsnhUhY+OEYagBJ75LxJYnuVlMieABnx1TwH
gnzmS1k6aXjzafnaP7XgfFkVoWTjZlZu8/9gs8wvknc1ojL+yl61j4FSnFgliZ2j
MWJ8lofHMwkzbH0geWgByZLKSejDKxAs8Hg2W5YVp4iUGeJt9vlZ/yP3lXKR9OiJ
uQEUWX7Lo+VZC7+/+ITMoZwBWCUmKg==
=SIsl
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--

--===============8583934754208163184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============8583934754208163184==--
