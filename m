From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: kernel BUG at drivers/block/virtio_blk.c:172
Date: Thu, 30 Oct 2014 15:33:18 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1410301517090.2372@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: axboe@kernel.dk, hch@lst.de
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I've just hit this BUG at drivers/block/virtio_blk.c when updated to
the kernel from the top of the Linus git tree.

commit a7ca10f263d7e673c74d8e0946d6b9993405cc9c

This is my virtual machine running on RHEL7 guest

qemu-kvm-1.5.3-60.el7.x86_64

The last upstream kernel (3.17.0-rc4) worked well. I'll try to
bisect, but meanwhile this is a backtrace I got very early in the boot.
The root fs on that guest is xfs and I am using raw disk image and virtio
driver.

Let me know if you need more information.

Thanks!
-Lukas


[    2.806242] ------------[ cut here ]------------
[    2.807018] kernel BUG at drivers/block/virtio_blk.c:172!
[    2.807018] invalid opcode: 0000 [#1] SMP
[    2.807018] Modules linked in: xfs libcrc32c sd_mod qxl ata_generic pata_acpi drm_kms_helper ttm drm ata_piix virtio_net virtio_blk libata virtio_pci floppy virtio_ring i2c_core virtio dm_mirror dm_region_hash dm_log dm_mod
[    2.807018] CPU: 2 PID: 580 Comm: mount Not tainted 3.18.0-rc2+ #4
[    2.807018] Hardware name: Red Hat KVM, BIOS Bochs 01/01/2011
[    2.807018] task: ffff880035e3b640 ti: ffff880034d24000 task.ti: ffff880034d24000
[    2.807018] RIP: 0010:[<ffffffffa0034737>]  [<ffffffffa0034737>] virtio_queue_rq+0x277/0x280 [virtio_blk]
[    2.807018] RSP: 0018:ffff880034d277b8  EFLAGS: 00010202
[    2.807018] RAX: 0000000000000082 RBX: ffff88022f2f0000 RCX: dead000000200200
[    2.807018] RDX: 0000000000000001 RSI: ffff88022f2f0000 RDI: ffff88022f2e3400
[    2.807018] RBP: ffff880034d277f8 R08: ffff88022f2f0000 R09: ffff880034d27820
[    2.807018] R10: 0000000000000000 R11: 0000000000001000 R12: ffff880034d27820
[    2.807018] R13: ffff88022f2e3400 R14: ffff880035dca480 R15: 0000000000000000
[    2.807018] FS:  00007f23686e0880(0000) GS:ffff880237240000(0000) knlGS:0000000000000000
[    2.807018] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.807018] CR2: 00007f8c71668000 CR3: 0000000035d8e000 CR4: 00000000000006e0
[    2.807018] Stack:
[    2.807018]  ffff880000000001 ffff88022f2f0170 0000000000000000 ffff88022f2e3400
[    2.807018]  ffff880034d27820 0000000000000000 ffff88022f2f0000 ffff88022f2e3408
[    2.807018]  ffff880034d27868 ffffffff812e0628 ffff88022e8c0000 0000000000000003
[    2.807018] Call Trace:
[    2.807018]  [<ffffffff812e0628>] __blk_mq_run_hw_queue+0x1c8/0x330
[    2.807018]  [<ffffffff812d233f>] ? part_round_stats+0x4f/0x60
[    2.807018]  [<ffffffff812e0da0>] blk_mq_run_hw_queue+0x70/0xa0
[    2.807018]  [<ffffffff812e1e68>] blk_sq_make_request+0x258/0x380
[    2.807018]  [<ffffffff812d32e0>] generic_make_request+0xe0/0x130
[    2.807018]  [<ffffffff812d33a8>] submit_bio+0x78/0x160
[    2.807018]  [<ffffffffa01c3516>] _xfs_buf_ioapply+0x2e6/0x430 [xfs]
[    2.807018]  [<ffffffffa01eacd8>] ? xlog_bread_noalign+0xa8/0xe0 [xfs]
[    2.807018]  [<ffffffffa01c5081>] xfs_buf_submit_wait+0x61/0x1d0 [xfs]
[    2.807018]  [<ffffffffa01eacd8>] xlog_bread_noalign+0xa8/0xe0 [xfs]
[    2.807018]  [<ffffffffa01eb6e7>] xlog_bread+0x27/0x60 [xfs]
[    2.807018]  [<ffffffffa01efd01>] xlog_find_verify_cycle+0xf1/0x1b0 [xfs]
[    2.807018]  [<ffffffffa01f02d1>] xlog_find_head+0x2f1/0x3e0 [xfs]
[    2.807018]  [<ffffffffa01f03fc>] xlog_find_tail+0x3c/0x410 [xfs]
[    2.807018]  [<ffffffffa01f07fd>] xlog_recover+0x2d/0x130 [xfs]
[    2.807018]  [<ffffffffa01f199f>] ? xfs_trans_ail_init+0xaf/0xe0 [xfs]
[    2.807018]  [<ffffffffa01e444a>] xfs_log_mount+0xea/0x2c0 [xfs]
[    2.807018]  [<ffffffffa01dbbfc>] xfs_mountfs+0x46c/0x7a0 [xfs]
[    2.807018]  [<ffffffffa01df10a>] xfs_fs_fill_super+0x2ba/0x330 [xfs]
[    2.807018]  [<ffffffff811ee510>] mount_bdev+0x1b0/0x1f0
[    2.807018]  [<ffffffffa01dee50>] ? xfs_parseargs+0xbf0/0xbf0 [xfs]
[    2.807018]  [<ffffffffa01dd085>] xfs_fs_mount+0x15/0x20 [xfs]
[    2.807018]  [<ffffffff811eee89>] mount_fs+0x39/0x1b0
[    2.807018]  [<ffffffff81194505>] ? __alloc_percpu+0x15/0x20
[    2.807018]  [<ffffffff8120ab2b>] vfs_kern_mount+0x6b/0x110
[    2.807018]  [<ffffffff8120d91c>] do_mount+0x22c/0xb30
[    2.807018]  [<ffffffff8118f2b6>] ? memdup_user+0x46/0x80
[    2.807018]  [<ffffffff8120e562>] SyS_mount+0xa2/0x110
[    2.807018]  [<ffffffff81671269>] system_call_fastpath+0x12/0x17
[    2.807018] Code: fe ff ff 90 0f b7 86 f4 00 00 00 c7 86 78 01 00 00 02 00 00 00 48 c7 86 80 01 00 00 00 00 00 00 89 86 7c 01 00 00 e9 12 fe ff ff <0f> 0b 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 31 f6 b9 08 00 00
[    2.807018] RIP  [<ffffffffa0034737>] virtio_queue_rq+0x277/0x280 [virtio_blk]
[    2.807018]  RSP <ffff880034d277b8>
[    2.887706] ---[ end trace e667b0f035973c7a ]---
[    2.888781] Kernel panic - not syncing: Fatal exception
[    2.889765] Kernel Offset: 0x0 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffff9fffffff)
