From: Asias He <asias.hejun@gmail.com>
Subject: Re: virtio_blk BUG on detach-disk/attach-disk of mounted vd
Date: Mon, 19 Nov 2012 09:24:50 +0800
Message-ID: <CAFO3S409epPBuh+CThcAFajuQ3Ow+yv0FZ2foESPNLBxfF+2ng@mail.gmail.com>
References: <50A5534C.1080204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50A5534C.1080204@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Brian Foster <bfoster@redhat.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hello Brian,

On Fri, Nov 16, 2012 at 4:40 AM, Brian Foster <bfoster@redhat.com> wrote:
> Hi,
>
> I know this isn't a valid use case or generally sane thing to do, but we
> have a bug (link, with details, below) filed for a panic against a
> detach-disk/attach-disk sequence of an ext4 mounted vd device on a rhel
> kernel.
>
> The same sequence leads to the following BUG on an upstream kernel
> (3.7.0-rc5+ SMP x86_64 GNU/Linux):
>
> [   75.114951] BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000090
> [   75.114957] IP: [<ffffffff8136ae35>]
> virtio_check_driver_offered_feature+0x5/0x50
> [   75.114986] PGD 117b99067 PUD 114daa067 PMD 0
> [   75.114992] Oops: 0000 [#1] SMP
> [   75.115006] Modules linked in: be2iscsi iscsi_boot_sysfs bnx2i fcoe
> libfcoe libfc cnic uio lockd cxgb4i cxgb4 scsi_transport_fc cxgb3i
> scsi_tgt libcxgbi cxgb3 8021q garp stp llc mdio ib_iser rdma_cm ib_cm
> iw_cm ib_sa ib_mad ib_core ib_addr iscsi_tcp libiscsi_tcp libiscsi
> scsi_transport_iscsi snd_hda_intel snd_hda_codec snd_hwdep snd_seq
> snd_seq_device snd_pcm joydev snd_timer snd microcode soundcore pcspkr
> virtio_net virtio_balloon 9pnet_virtio 9pnet snd_page_alloc i2c_piix4
> i2c_core uinput sunrpc floppy
> [   75.115042] CPU 0
> [   75.115047] Pid: 1264, comm: blkid Not tainted 3.7.0-rc5+ #149 Bochs
> Bochs
> [   75.115049] RIP: 0010:[<ffffffff8136ae35>]  [<ffffffff8136ae35>]
> virtio_check_driver_offered_feature+0x5/0x50
> [   75.115055] RSP: 0018:ffff880118c6bde0  EFLAGS: 00010286
> [   75.115055] RAX: ffff880117838000 RBX: ffff88011ac28680 RCX:
> 0000000000000000
> [   75.115058] RDX: 0000000000005331 RSI: 0000000000000007 RDI:
> 0000000000000000
> [   75.115058] RBP: ffff880118c6be18 R08: 0000000000005331 R09:
> 000000000000101d
> [   75.115060] R10: 0000000000000000 R11: 0000000000000246 R12:
> 000000000000101d
> [   75.115060] R13: 0000000000005331 R14: 0000000000000000 R15:
> 0000000000000000
> [   75.115063] FS:  00007fb5ccf80740(0000) GS:ffff88011fc00000(0000)
> knlGS:0000000000000000
> [   75.115064] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   75.115066] CR2: 0000000000000090 CR3: 000000011786b000 CR4:
> 00000000000006f0
> [   75.115073] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   75.115077] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [   75.115079] Process blkid (pid: 1264, threadinfo ffff880118c6a000,
> task ffff880115a3c530)
> [   75.115080] Stack:
> [   75.115081]  ffffffff813d0bfb ffff880118c6bf58 0000000000005331
> 00000000ffffffe7
> [   75.115084]  0000000000000000 ffff88011ac28680 ffff88011ab5d000
> ffff880118c6be78
> [   75.115087]  ffffffff812bd1be ffff880115a85180 ffff88011ac28680
> ffff880118c6bee8
> [   75.115090] Call Trace:
> [   75.115101]  [<ffffffff813d0bfb>] ? virtblk_ioctl+0x4b/0x90
> [   75.115118]  [<ffffffff812bd1be>] blkdev_ioctl+0xde/0x830
> [   75.115130]  [<ffffffff8118b406>] ? cp_new_stat+0x116/0x130
> [   75.115140]  [<ffffffff811bc940>] block_ioctl+0x40/0x50
> [   75.115146]  [<ffffffff81197ac8>] do_vfs_ioctl+0x98/0x550
> [   75.115149]  [<ffffffff81198011>] sys_ioctl+0x91/0xb0
> [   75.115162]  [<ffffffff810db086>] ? __audit_syscall_exit+0x3d6/0x410
> [   75.115175]  [<ffffffff81625519>] system_call_fastpath+0x16/0x1b
> [   75.115176] Code: 4c 8b 60 18 ff 50 10 83 c8 80 48 89 df 0f b6 f0 41
> ff d4 eb cb 90 0f 1f 44 00 00 55 48 89 e5 e8 d2 18 05 00 5d c3 0f 1f 44
> 00 00 <48> 8b 87 90 00 00 00 55 48 89 e5 8b 88 80 00 00 00 85 c9 74 26
> [   75.115203] RIP  [<ffffffff8136ae35>]
> virtio_check_driver_offered_feature+0x5/0x50
> [   75.115206]  RSP <ffff880118c6bde0>
> [   75.115207] CR2: 0000000000000090
> [   75.115247] ---[ end trace f2226e229a762cf5 ]---
>
> I suppose it's not a critical issue, but I'm reporting in the event that
> there are any thoughts on improved error handling in this scenario. Thanks.
>
> (Please CC me on replies).

Thanks for reporting.  I have fixed similar hot-unplug issue a few months ago.
I will look into this.

2c95a32 virtio-blk: Use block layer provided spinlock
483001c virtio-blk: Reset device after blk_cleanup_queue()
02e2b12 virtio-blk: Call del_gendisk() before disable guest kick
f65ca1d virtio_blk: Drop unused request tracking list
b79d866 virtio-blk: Fix hot-unplug race in remove method

-- 
Asias He
