From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible
Date: Thu, 16 Jan 2020 03:52:32 +0100
Message-ID: <20200116025232.GN2507@mail-itl>
References: <20200110163211.GB29736@mail-itl>
 <20200113071939.rtqb7yw45zi63fqy@sirius.home.kraxel.org>
 <20200115003356.GL2507@mail-itl>
 <20200115100821.qcdraolkoki6e5tz@sirius.home.kraxel.org>
 <20200115134119.GP1314@mail-itl>
 <20200115141353.3kse3uj2mg6ik6k5@sirius.home.kraxel.org>
 <20200115142741.GM2507@mail-itl>
 <20200115161635.ekrnk5rmjqbxxu77@sirius.home.kraxel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3649461132038554781=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200115161635.ekrnk5rmjqbxxu77@sirius.home.kraxel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============3649461132038554781==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oSMU0HVueUMCAvn0"
Content-Disposition: inline


--oSMU0HVueUMCAvn0
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: bochs_hw_init fails to request framebuffer on EFI boot with
 plymouth visible

On Wed, Jan 15, 2020 at 05:16:35PM +0100, Gerd Hoffmann wrote:
> On Wed, Jan 15, 2020 at 03:27:41PM +0100, Marek Marczykowski-G=C3=B3recki=
 wrote:
> > On Wed, Jan 15, 2020 at 03:13:53PM +0100, Gerd Hoffmann wrote:
> > >   Hi,
> > >=20
> > > > > And "grep -A1 0000:00:02.0 /proc/iomem" ?
> > > >=20
> > > >   c0000000-c0ffffff : 0000:00:02.0
> > > >   c1000000-c103ffff : 0000:00:04.0
> > >=20
> > > So no reservation left.  Whatever blocked the pci bar resource (efifb
> > > probably) is gone now.
> > >=20
> > > So the interesting question is why that reservation sticked long enou=
gh
> > > to prevent bochs-drm from initializing.  In theory efifb de-init shou=
ld
> > > be completed when drm_fb_helper_remove_conflicting_pci_framebuffers()
> > > returns.
> >=20
> > Maybe the fact that switching to text mode plymouth help, gives some
> > hint?
>=20
> Maybe plymouth having a /dev/fb0 file handle open in gfx mode has
> something to do with it.  But if that is the case I should be able to
> reproduce it in theory.  Which is not the case though ...

Yes, looks like plymouthd is holding some file handle open. It may
depend on a specific plymouth configuration, or some timing, I don't
know...
I've added WARN in put_fb_info() (and few more printks) and got output
like the one below. As you can see, first put_fb_info() exit early
(before actual destroy) and only second one (in plymouthd context) do
the destroy - but too late.
Should switching to bochsdrmfb be deferred until efifb gets properly
destroyed? How?

[   29.475736] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers:=
 bar 0: 0xc0000000 -> 0xc0ffffff
[   29.475740] bochs-drm 0000:00:02.0: remove_conflicting_pci_framebuffers:=
 bar 2: 0xc1087000 -> 0xc1087fff
[   29.475743] checking generic (c0000000 1000000) vs hw (c0000000 1000000)
[   29.475745] fb0: switching to bochsdrmfb from EFI VGA
[   29.475828] ------------[ cut here ]------------
[   29.475829] EFI VGA
[   29.475883] WARNING: CPU: 1 PID: 863 at drivers/video/fbdev/core/fbmem.c=
:77 put_fb_info+0x1a/0x30
[   29.475884] Modules linked in: bochs_drm(+) drm_vram_helper ttm edac_mce=
_amd pcspkr snd_timer drm_kms_helper snd e1000e soundcore drm i2c_piix4 par=
port_pc parport xenfs ip_tables dm_thin_pool dm_persistent_data libcrc32c d=
m_bio_prison dm_crypt ehci_pci serio_raw virtio_console ehci_hcd virtio_scs=
i ata_generic pata_acpi qemu_fw_cfg floppy xen_privcmd xen_pciback xen_blkb=
ack xen_gntalloc xen_gntdev xen_evtchn uinput pkcs8_key_parser
[   29.475901] CPU: 1 PID: 863 Comm: systemd-udevd Tainted: G        W     =
    5.4.5-1.qubes.x86_64+ #4
[   29.475902] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
0.0.0 02/06/2015
[   29.475905] RIP: e030:put_fb_info+0x1a/0x30
[   29.475907] Code: 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f =
44 00 00 41 54 4c 8d a7 f0 00 00 00 55 48 89 fd 4c 89 e7 e8 24 41 b6 ff <0f=
> 0b f0 ff 4d 00 0f 84 ab 23 00 00 e9 d3 23 00 00 0f 1f 44 00 00
[   29.475908] RSP: e02b:ffffc90000d8fa00 EFLAGS: 00010286
[   29.475910] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   29.475911] RDX: 0000000000000007 RSI: ffffffff82d03247 RDI: 00000000000=
00200
[   29.475912] RBP: ffff8881360a4800 R08: 00000006dce5772f R09: 00000000000=
00007
[   29.475913] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8881360=
a48f0
[   29.475913] R13: ffff888135a62d40 R14: 0000000000000000 R15: 00000000000=
00001
[   29.475926] FS:  000077896532d940(0000) GS:ffff888140100000(0000) knlGS:=
0000000000000000
[   29.475927] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.475928] CR2: 000075109e9ce008 CR3: 000000013b2e8000 CR4: 00000000000=
00660
[   29.475931] Call Trace:
[   29.475962]  do_remove_conflicting_framebuffers.cold+0xc2/0x112
[   29.475966]  remove_conflicting_framebuffers+0x30/0xc0
[   29.475968]  remove_conflicting_pci_framebuffers+0xb4/0xe0
[   29.475973]  bochs_pci_probe+0x49/0x160 [bochs_drm]
[   29.475978]  local_pci_probe+0x42/0x80
[   29.475981]  pci_device_probe+0x107/0x1a0
[   29.475985]  really_probe+0x147/0x3c0
[   29.475988]  driver_probe_device+0xb6/0x100
[   29.475991]  device_driver_attach+0x53/0x60
[   29.475993]  __driver_attach+0x8a/0x150
[   29.475995]  ? device_driver_attach+0x60/0x60
[   29.475997]  bus_for_each_dev+0x78/0xc0
[   29.475999]  bus_add_driver+0x14d/0x1f0
[   29.476002]  driver_register+0x6c/0xc0
[   29.476004]  ? 0xffffffffc02cf000
[   29.476008]  do_one_initcall+0x46/0x1f4
[   29.476012]  ? free_unref_page_commit+0x95/0x110
[   29.476016]  ? _cond_resched+0x15/0x30
[   29.476018]  ? kmem_cache_alloc_trace+0x162/0x220
[   29.476021]  ? do_init_module+0x23/0x230
[   29.476023]  do_init_module+0x5c/0x230
[   29.476026]  load_module+0x28c9/0x2b20
[   29.476032]  ? ima_post_read_file+0xf0/0x100
[   29.476034]  ? __do_sys_finit_module+0xaa/0x110
[   29.476036]  __do_sys_finit_module+0xaa/0x110
[   29.476039]  do_syscall_64+0x5b/0x1a0
[   29.476042]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   29.476045] RIP: 0033:0x7789662d31ad
[   29.476047] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ab 5c 0c 00 f7 d8 64 89 01 48
[   29.476048] RSP: 002b:00007ffcd6612318 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000139
[   29.476049] RAX: ffffffffffffffda RBX: 00006395e6ee4e90 RCX: 00007789662=
d31ad
[   29.476050] RDX: 0000000000000000 RSI: 0000778965efa84d RDI: 00000000000=
00012
[   29.476051] RBP: 0000000000020000 R08: 0000000000000000 R09: 00000000000=
00007
[   29.476052] R10: 0000000000000012 R11: 0000000000000246 R12: 0000778965e=
fa84d
[   29.476053] R13: 0000000000000000 R14: 00006395e6ef8be0 R15: 00006395e6e=
e4e90
[   29.476055] ---[ end trace 688bd10d7416ac12 ]---
[   29.476057] put_fb_info: EFI VGA - deferring destroy
[   29.476059] bochs-drm 0000:00:02.0: vgaarb: deactivate vga console
[   29.503578] bochs-drm 0000:00:02.0: BAR 0: can't reserve [mem 0xc0000000=
-0xc0ffffff pref]
[   29.503586] [drm:bochs_hw_init [bochs_drm]] *ERROR* Cannot request frame=
buffer
[   29.503629] bochs-drm: probe of 0000:00:02.0 failed with error -16
[   29.802210] ppdev: user-space parallel port driver
[   29.935199] ------------[ cut here ]------------
[   29.935202] EFI VGA
[   29.935290] WARNING: CPU: 1 PID: 357 at drivers/video/fbdev/core/fbmem.c=
:77 put_fb_info+0x1a/0x30
[   29.935291] Modules linked in: ppdev snd_intel8x0(+) joydev snd_ac97_cod=
ec ac97_bus snd_seq snd_seq_device snd_pcm bochs_drm drm_vram_helper ttm ed=
ac_mce_amd pcspkr snd_timer drm_kms_helper snd e1000e soundcore drm i2c_pii=
x4 parport_pc parport xenfs ip_tables dm_thin_pool dm_persistent_data libcr=
c32c dm_bio_prison dm_crypt ehci_pci serio_raw virtio_console ehci_hcd virt=
io_scsi ata_generic pata_acpi qemu_fw_cfg floppy xen_privcmd xen_pciback xe=
n_blkback xen_gntalloc xen_gntdev xen_evtchn uinput pkcs8_key_parser
[   29.935347] CPU: 1 PID: 357 Comm: plymouthd Tainted: G        W         =
5.4.5-1.qubes.x86_64+ #4
[   29.935348] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
0.0.0 02/06/2015
[   29.935351] RIP: e030:put_fb_info+0x1a/0x30
[   29.935354] Code: 00 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f =
44 00 00 41 54 4c 8d a7 f0 00 00 00 55 48 89 fd 4c 89 e7 e8 24 41 b6 ff <0f=
> 0b f0 ff 4d 00 0f 84 ab 23 00 00 e9 d3 23 00 00 0f 1f 44 00 00
[   29.935355] RSP: e02b:ffffc90000ed7e58 EFLAGS: 00010282
[   29.935356] RAX: 0000000000000000 RBX: 00000000000e001f RCX: 00000000000=
00000
[   29.935357] RDX: 0000000000000007 RSI: ffffffff82d03247 RDI: 00000000000=
00200
[   29.935358] RBP: ffff8881360a4800 R08: 00000006f846f211 R09: 00000000000=
00007
[   29.935359] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8881360=
a48f0
[   29.935376] R13: ffff88813b242fb8 R14: ffff88813625a160 R15: ffff88813a9=
02a80
[   29.935390] FS:  00007857d81d1f00(0000) GS:ffff888140100000(0000) knlGS:=
0000000000000000
[   29.935391] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   29.935392] CR2: 00006395e6ed0180 CR3: 0000000135b62000 CR4: 00000000000=
00660
[   29.935412] Call Trace:
[   29.935423]  fb_release+0x57/0x60
[   29.935428]  __fput+0xc1/0x250
[   29.935432]  task_work_run+0x8a/0xb0
[   29.935437]  exit_to_usermode_loop+0x102/0x130
[   29.935440]  do_syscall_64+0x17e/0x1a0
[   29.935444]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   29.935448] RIP: 0033:0x7857d8489c57
[   29.935449] Code: ff ff e8 fc e8 01 00 66 2e 0f 1f 84 00 00 00 00 00 66 =
90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 a3 41 f9 ff
[   29.935450] RSP: 002b:00007ffcf4c872b8 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000003
[   29.935452] RAX: 0000000000000000 RBX: 000056802e2207d0 RCX: 00007857d84=
89c57
[   29.935453] RDX: 000056802e221b50 RSI: 0000000000000000 RDI: 00000000000=
0000a
[   29.935453] RBP: 0000000000000000 R08: 0000000000000007 R09: 00000000000=
00000
[   29.935454] R10: 00007ffcf4c870d4 R11: 0000000000000246 R12: 000056802e2=
21c20
[   29.935455] R13: 000056802e2ae2d0 R14: 0000000000000001 R15: 000056802e2=
22d40
[   29.935457] ---[ end trace 688bd10d7416ac13 ]---
[   29.935459] put_fb_info: EFI VGA - calling destroy
[   29.935460] efifb_destroy
[   29.935461] efifb_destroy: iounmap/memunmap
[   29.939559] efifb_destroy: release_mem_region 0xc0000000-0xc1000000
[   29.939562] Trying to free nonexistent resource <00000000c0000000-000000=
00c0ffffff>


--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--oSMU0HVueUMCAvn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl4fz/AACgkQ24/THMrX
1yzIRwgAhV+KI+oehxfCrMZFaqUVfOU0k9D3/nsWqGg+4pHtS6amclF8u+ZzPoP/
qQKdvHv/FEfMD7IlZieRQ+AN/ATKFxvbh8OVc2Zckt+5Y+++Sw6lkFYXbXhty0nS
NvfL9l7ey/HTVZ+iI+o6JpbXF67EyYCdfZk+vzsl+1wVmVmwMrm5plxLAi5LLf6N
gJABjma6DJV92ojTjHW99rURn1AzOjWWB7vdPofhrokrUFYSZOEFWv0D9rsQyVK7
+GmaUyXbjfkGGYBrEeCEl7lINYQHm05vAJ/yHsGs0Yl0SwDCIlAlU3TzOk1r4sEa
GaII6ccoAS7+xDYSv4MTSlcAUTB8PQ==
=T6Vx
-----END PGP SIGNATURE-----

--oSMU0HVueUMCAvn0--

--===============3649461132038554781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3649461132038554781==--
