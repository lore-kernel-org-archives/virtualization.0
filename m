From: Laura Abbott <labbott@redhat.com>
Subject: Regression in virtio block driver with 4.13.2
Date: Fri, 15 Sep 2017 09:54:08 -0700
Message-ID: <93e65aef-e93d-6a99-854a-f6147f84e3b1__26994.9601767168$1505494711$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Fedora got a bug report on an early version of 4.13.2
https://paste.fedoraproject.org/paste/t-Yx23LN5QwJ7oPZLj3zrg

[    5.913866] usercopy: kernel memory overwrite attempt detected to 
       (null) (<null>) (16 bytes)
[    5.914199] ------------[ cut here ]------------
[    5.914201] kernel BUG at mm/usercopy.c:72!
[    5.914279] invalid opcode: 0000 [#1] SMP
[    5.914293] Modules linked in: ppdev joydev virtio_balloon parport_pc 
parport i2c_piix4 virtio_blk virtio_net virtio_console qxl 
drm_kms_helper ttm drm virtio_pci virtio_ring serio_raw virtio 
ata_generic pata_acpi
[    5.914353] CPU: 1 PID: 916 Comm: hdparm Not tainted 
4.13.2-300.fc27.x86_64 #1
[    5.914372] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[    5.914387] task: ffff930a7a67b1c0 task.stack: ffffacef407b8000
[    5.914411] RIP: 0010:__check_object_size+0x123/0x1b0
[    5.914425] RSP: 0018:ffffacef407bbc20 EFLAGS: 00010282
[    5.914440] RAX: 000000000000005a RBX: 0000000000000010 RCX: 
0000000000000000
[    5.914458] RDX: 0000000000000000 RSI: ffff930a7d5ce348 RDI: 
ffff930a7d5ce348
[    5.914476] RBP: ffffacef407bbc40 R08: 00000005a68f139a R09: 
0000000000000000
[    5.914494] R10: 0000000000000001 R11: 0000000000000000 R12: 
0000000000000000
[    5.914512] R13: 0000000000000010 R14: 0000000000000000 R15: 
0000000000000010
[    5.914531] FS:  00007f03e4008740(0000) GS:ffff930a7d400000(0000) 
knlGS:0000000000000000
[    5.914552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    5.914567] CR2: 00007fff67496fe8 CR3: 0000000079ee2000 CR4: 
00000000000006e0
[    5.914588] Call Trace:
[    5.914599]  sg_io+0xe2/0x400
[    5.914611]  ? __might_fault+0x85/0x90
[    5.914622]  scsi_cmd_ioctl+0x2e0/0x4a0
[    5.914637]  scsi_cmd_blk_ioctl+0x42/0x50
[    5.914651]  virtblk_ioctl+0x56/0x70 [virtio_blk]
[    5.914666]  blkdev_ioctl+0x8f7/0x9b0
[    5.914679]  block_ioctl+0x43/0x50
[    5.914689]  do_vfs_ioctl+0xa6/0x6c0
[    5.914702]  SyS_ioctl+0x79/0x90
[    5.914714]  entry_SYSCALL_64_fastpath+0x1f/0xbe
[    5.914727] RIP: 0033:0x7f03e3b220d7
[    5.914737] RSP: 002b:00007fff674992f8 EFLAGS: 00000202 ORIG_RAX: 
0000000000000010
[    5.914758] RAX: ffffffffffffffda RBX: 000000007af2c337 RCX: 
00007f03e3b220d7
[    5.914776] RDX: 00007fff67499320 RSI: 0000000000002285 RDI: 
0000000000000003
[    5.914794] RBP: 00007fff674971b0 R08: 0000000000000000 R09: 
0000000000000000
[    5.914812] R10: 0000000000000003 R11: 0000000000000202 R12: 
0000000000000000
[    5.914830] R13: 00007f03e401dbd8 R14: 00007fff674971d8 R15: 
00007f03e4021488
[    5.914851] Code: 48 0f 45 d1 48 c7 c6 88 75 cb aa 48 c7 c1 0a ab cc 
aa 48 0f 45 f1 49 89 d9 49 89 c0 4c 89 f1 48 c7 c7 28 ab cc aa e8 4e 14 
e6 ff <0f> 0b f3 c3 48 8b 3d 12 c6 b4 00 48 8b 0d 63 e6 b7 00 be 00 00
[    5.914938] RIP: __check_object_size+0x123/0x1b0 RSP: ffffacef407bbc20
[    5.914955] ---[ end trace 7d2ed87f8ebaa2ce ]---

This is from blk_fill_sghdr_rq (block/scsi_ioctl.c:336) and the cryptic
output is saying that req->cmd is NULL. Is this a known issue? I haven't
attempted a bisect yet as I've been at Linux Plumbers.

Thanks,
Laura

Thanks,
Laura
