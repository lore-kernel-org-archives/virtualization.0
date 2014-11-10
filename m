From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: Re: kernel BUG at drivers/block/virtio_blk.c:172
Date: Mon, 10 Nov 2014 12:59:37 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1411101252110.24699@localhost.localdomain>
References: <54524D50.50509@kernel.dk> <54524D68.7080509@kernel.dk>
	<CACVXFVPVdTqJ7X6xokq-8X8CTh3A59xwGNdwTm+SW1dOB-xxLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2071266352-1415620780=:24699"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CACVXFVPVdTqJ7X6xokq-8X8CTh3A59xwGNdwTm+SW1dOB-xxLQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2071266352-1415620780=:24699
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2014, Ming Lei wrote:

> Date: Fri, 31 Oct 2014 12:40:00 +0800
> From: Ming Lei <tom.leiming@gmail.com>
> To: Jens Axboe <axboe@kernel.dk>
> Cc: Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.com>,
>     Linux Virtualization <virtualization@lists.linux-foundation.org>,
>     Christoph Hellwig <hch@lst.de>
> Subject: Re: Re: kernel BUG at drivers/block/virtio_blk.c:172
>=20
> On Thu, Oct 30, 2014 at 10:38 PM, Jens Axboe <axboe@kernel.dk> wrote:
> > Forgot to CC you...
> >
> >
> > -------- Forwarded Message --------
> > Subject: Re: kernel BUG at drivers/block/virtio_blk.c:172
> > Date: Thu, 30 Oct 2014 08:38:08 -0600
> > From: Jens Axboe <axboe@kernel.dk>
> > To: Luk=C3=A1=C5=A1 Czerner <lczerner@redhat.com>,
> > virtualization@lists.linux-foundation.org
> > CC: hch@lst.de
> >
> > On 2014-10-30 08:33, Luk=C3=A1=C5=A1 Czerner wrote:
> >>
> >> Hi,
> >>
> >> I've just hit this BUG at drivers/block/virtio_blk.c when updated to
> >> the kernel from the top of the Linus git tree.
> >>
> >> commit a7ca10f263d7e673c74d8e0946d6b9993405cc9c
> >>
> >> This is my virtual machine running on RHEL7 guest
> >>
> >> qemu-kvm-1.5.3-60.el7.x86_64
> >>
> >> The last upstream kernel (3.17.0-rc4) worked well. I'll try to
> >> bisect, but meanwhile this is a backtrace I got very early in the bo=
ot.
> >> The root fs on that guest is xfs and I am using raw disk image and v=
irtio
> >> driver.
> >>
> >> Let me know if you need more information.
> >
> >
> > Ming, looks like this still isn't really fixed. The above upstream
> > commit has the latest fixup as well for the segments being wrong, so
> > nothing else should be pending.
>=20
> That looks weird, and I can't reproduce with mkfs.xfs & mount
> in my environment.
>=20
> Luk=C3=A1=C5=A1, could you reproduce the issue with attached debug patc=
h
> and post the result? BTW, do you pass 'scsi=3Doff' in the qemu
> command line for the virito-blk device?

Hi,

so I encountered it again on 3.17.0-rc4. This output is from the
run with your patch.

I am using libvirt (virt-manager) to configure and run the virtual
machine, but looking at the xml, I do not think it's passing
'scsi=3Doff' at all.

Btw, that xfs file system is a root file system.


[    3.667553] blk_recount_segments: 1-0-1 vcnt-0 segs-128
[    3.668692] blk_recount_segments: 1-0-1 vcnt-0 segs-128
[    3.669897] blk_recount_segments: 1-0-1 vcnt-0 segs-128
[    3.671083] blk_recount_segments: 1-0-1 vcnt-0 segs-128
[    3.672476] ------------[ cut here ]------------
[    3.673439] kernel BUG at drivers/block/virtio_blk.c:172!
[    3.673439] invalid opcode: 0000 [#1] SMP
[    3.673439] Modules linked in: xfs libcrc32c sd_mod ata_generic pata_a=
cpi qxl drm_kms_helper ttm drm ata_piix virtio_net virtio_blk libata virt=
io_pci virtio_ring i2c_core virtio floppy dm_mirror dm_region_hash dm_log=
 dm_mod
[    3.673439] CPU: 1 PID: 596 Comm: mount Not tainted 3.18.0-rc4+ #10
[    3.673439] Hardware name: Red Hat KVM, BIOS Bochs 01/01/2011
[    3.673439] task: ffff880035419b20 ti: ffff88022e71c000 task.ti: ffff8=
8022e71c000
[    3.673439] RIP: 0010:[<ffffffffa005a737>]  [<ffffffffa005a737>] virti=
o_queue_rq+0x277/0x280 [virtio_blk]
[    3.673439] RSP: 0018:ffff88022e71f7d8  EFLAGS: 00010202
[    3.673439] RAX: 0000000000000082 RBX: ffff88022e970000 RCX: dead00000=
0200200
[    3.673439] RDX: 0000000000000000 RSI: ffff88022e970000 RDI: ffff88022=
f2c3c00
[    3.673439] RBP: ffff88022e71f818 R08: ffff88022e970000 R09: ffff88022=
e71f840
[    3.673439] R10: 000000000000028d R11: ffff88022e71f4ee R12: ffff88022=
e71f840
[    3.673439] R13: ffff88022f2c3c00 R14: ffff88022f722d80 R15: 000000000=
0000000
[    3.673439] FS:  00007fb1e8de6880(0000) GS:ffff880237220000(0000) knlG=
S:0000000000000000
[    3.673439] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[    3.673439] CR2: 00007f173410e010 CR3: 000000022e2e1000 CR4: 000000000=
00006e0
[    3.673439] Stack:
[    3.673439]  ffffffff00000000 ffff88022e970170 0000000000000001 ffff88=
022f2c3c00
[    3.673439]  ffff88022e71f840 0000000000000000 ffff88022e970000 ffff88=
022f2c3c08
[    3.673439]  ffff88022e71f888 ffffffff812daa68 ffff88022e8f0000 000000=
0000000003
[    3.673439] Call Trace:
[    3.673439]  [<ffffffff812daa68>] __blk_mq_run_hw_queue+0x1c8/0x330
[    3.673439]  [<ffffffff812db1e0>] blk_mq_run_hw_queue+0x70/0xa0
[    3.673439]  [<ffffffff812dbff5>] blk_mq_insert_requests+0xc5/0x120
[    3.673439]  [<ffffffff812dcbbb>] blk_mq_flush_plug_list+0x13b/0x160
[    3.673439]  [<ffffffff812d2391>] blk_flush_plug_list+0xc1/0x220
[    3.673439]  [<ffffffff812d28a8>] blk_finish_plug+0x18/0x50
[    3.673439]  [<ffffffffa01ce487>] _xfs_buf_ioapply+0x327/0x430 [xfs]
[    3.673439]  [<ffffffff8109ae20>] ? wake_up_state+0x20/0x20
[    3.673439]  [<ffffffffa01d0424>] ? xfs_bwrite+0x24/0x60 [xfs]
[    3.673439]  [<ffffffffa01cffb1>] xfs_buf_submit_wait+0x61/0x1d0 [xfs]
[    3.673439]  [<ffffffffa01d0424>] xfs_bwrite+0x24/0x60 [xfs]
[    3.673439]  [<ffffffffa01f5dc7>] xlog_bwrite+0x87/0x110 [xfs]
[    3.673439]  [<ffffffffa01f6df3>] xlog_write_log_records+0x1b3/0x250 [=
xfs]
[    3.673439]  [<ffffffffa01f6f98>] xlog_clear_stale_blocks+0x108/0x1b0 =
[xfs]
[    3.673439]  [<ffffffffa01f66a3>] ? xlog_bread+0x43/0x60 [xfs]
[    3.673439]  [<ffffffffa01fb68b>] xlog_find_tail+0x32b/0x410 [xfs]
[    3.673439]  [<ffffffffa01fb79d>] xlog_recover+0x2d/0x130 [xfs]
[    3.673439]  [<ffffffffa01ef3ea>] xfs_log_mount+0xea/0x2c0 [xfs]
[    3.673439]  [<ffffffffa01e6b9c>] xfs_mountfs+0x46c/0x7a0 [xfs]
[    3.673439]  [<ffffffffa01ea0aa>] xfs_fs_fill_super+0x2ba/0x330 [xfs]
[    3.673439]  [<ffffffff811e6af0>] mount_bdev+0x1b0/0x1f0
[    3.673439]  [<ffffffffa01e9df0>] ? xfs_parseargs+0xbf0/0xbf0 [xfs]
[    3.673439]  [<ffffffffa01e8025>] xfs_fs_mount+0x15/0x20 [xfs]
[    3.673439]  [<ffffffff811e7469>] mount_fs+0x39/0x1b0
[    3.673439]  [<ffffffff8118c145>] ? __alloc_percpu+0x15/0x20
[    3.673439]  [<ffffffff8120310b>] vfs_kern_mount+0x6b/0x110
[    3.673439]  [<ffffffff81205efc>] do_mount+0x22c/0xb30
[    3.673439]  [<ffffffff81186f06>] ? memdup_user+0x46/0x80
[    3.673439]  [<ffffffff81206b42>] SyS_mount+0xa2/0x110
[    3.673439]  [<ffffffff81661f29>] system_call_fastpath+0x12/0x17
[    3.673439] Code: fe ff ff 90 0f b7 86 f4 00 00 00 c7 86 78 01 00 00 0=
2 00 00 00 48 c7 86 80 01 00 00 00 00 00 00 89 86 7c 01 00 00 e9 12 fe ff=
 ff <0f> 0b 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 31 f6 b9 08 00 00
[    3.673439] RIP  [<ffffffffa005a737>] virtio_queue_rq+0x277/0x280 [vir=
tio_blk]
[    3.673439]  RSP <ffff88022e71f7d8>
[    3.757920] ---[ end trace 530cccacbbb96a99 ]---



Thanks!
-Lukas

>=20
>=20
>=20
> Thanks,
>=20
--8323328-2071266352-1415620780=:24699
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--8323328-2071266352-1415620780=:24699--
