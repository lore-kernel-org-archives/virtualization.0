From: Cong Wang <cwang@twopensource.com>
Subject: BUG kmalloc-64 (Not tainted): Poison overwritten
Date: Tue, 25 Aug 2015 14:11:23 -0700
Message-ID: <CAHA+R7OtN5AyGS-hXwfAj4cfediu0i6+L6K+Z_DcnYaQJj6bhg__43152.0430291586$1440691144$gmane$org@mail.gmail.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi, Michael

I just got the following kernel bug while working on Dave's net tree
in a KVM guest. It looks like a bug in virtio.

Let me know if you need more information.


[   69.816089] BUG kmalloc-64 (Not tainted): Poison overwritten
[   69.816089] -----------------------------------------------------------------------------
[   69.816089]
[   69.816089] Disabling lock debugging due to kernel taint
[   69.816089] INFO: 0xffff8800d480c7c0-0xffff8800d480c7c0. First byte
0x6a instead of 0x6b
[   69.816089] INFO: Allocated in virtqueue_add+0x6b/0x2a2 age=423 cpu=3 pid=128
[   69.816089]  __slab_alloc+0x44b/0x4d2
[   69.816089]  __kmalloc+0xa3/0x14e
[   69.816089]  virtqueue_add+0x6b/0x2a2
[   69.816089]  virtqueue_add_sgs+0x78/0x87
[   69.816089]  __virtblk_add_req+0x139/0x14b
[   69.816089]  virtio_queue_rq+0x14e/0x1f0
[   69.816089]  __blk_mq_run_hw_queue+0x1ac/0x2b9
[   69.816089]  blk_mq_run_hw_queue+0x59/0xb8
[   69.816089]  blk_mq_insert_requests+0x136/0x1ab
[   69.816089]  blk_mq_flush_plug_list+0xd4/0xe3
[   69.816089]  blk_flush_plug_list+0x9b/0x1b9
[   69.816089]  blk_finish_plug+0x24/0x33
[   69.816089]  generic_writepages+0x4c/0x59
[   69.816089]  do_writepages+0x21/0x2f
[   69.816089]  __writeback_single_inode+0xd6/0x5ca
[   69.816089]  writeback_sb_inodes+0x28c/0x458
[   69.816089] INFO: Freed in detach_buf+0x3d/0x6e age=469 cpu=3 pid=128
[   69.816089]  __slab_free+0x35/0x283
[   69.816089]  kfree+0x153/0x1ac
[   69.816089]  detach_buf+0x3d/0x6e
[   69.816089]  virtqueue_get_buf+0xac/0xdd
[   69.816089]  virtblk_done+0x61/0xcb
[   69.816089]  vring_interrupt+0x2d/0x3c
[   69.816089]  handle_irq_event_percpu+0xbd/0x2c0
[   69.816089]  handle_irq_event+0x4a/0x6e
[   69.816089]  handle_edge_irq+0xc0/0xe3
[   69.816089]  handle_irq+0x11b/0x128
[   69.816089]  do_IRQ+0x4d/0xc1
[   69.816089]  ret_from_intr+0x0/0x1d
[   70.780063]  kmem_cache_free+0xb2/0x248
[   70.780063]  ext4_release_io_end+0x78/0xa9
[   70.780063]  ext4_put_io_end+0x50/0x5f
[   70.780063]  ext4_writepages+0x662/0xb62
[   70.780063] INFO: Slab 0xffffea0003520300 objects=20 used=20 fp=0x
        (null) flags=0x1ffff8000004080
[   70.780063] INFO: Object 0xffff8800d480c7a8 @offset=1960
fp=0xffff8800d480db90
[   70.780063]
[   70.780063] Bytes b4 ffff8800d480c798: 00 00 00 00 00 00 00 00 5a
5a 5a 5a 5a 5a 5a 5a  ........ZZZZZZZZ
[   70.780063] Object ffff8800d480c7a8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[   70.780063] Object ffff8800d480c7b8: 6b 6b 6b 6b 6b 6b 6b 6b 6a 6b
6b 6b 6b 6b 6b 6b  kkkkkkkkjkkkkkkk
[   70.780063] Object ffff8800d480c7c8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
[   70.780063] Object ffff8800d480c7d8: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
[   70.780063] Redzone ffff8800d480c7e8: bb bb bb bb bb bb bb bb
                   ........
[   70.780063] Padding ffff8800d480c928: 5a 5a 5a 5a 5a 5a 5a 5a
                   ZZZZZZZZ
[   70.780063] CPU: 1 PID: 780 Comm: u32_del.sh Tainted: G    B
   4.2.0-rc7+ #1097
[   70.780063] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   70.780063]  ffff8800d480c7a8 ffff8800d5a47aa8 ffffffff81a64274
0000000000000000
[   70.780063]  ffff88011a007700 ffff8800d5a47ad8 ffffffff81187587
ffff8800d480c7c0
[   70.780063]  000000000000006b ffff88011a007700 ffff8800d480c7c0
ffff8800d5a47b38
[   70.780063] Call Trace:
[   70.780063]  [<ffffffff81a64274>] dump_stack+0x4c/0x65
[   70.780063]  [<ffffffff81187587>] print_trailer+0x12b/0x134
[   70.780063]  [<ffffffff81187636>] check_bytes_and_report+0xa6/0xf3
[   70.780063]  [<ffffffff811b8111>] ? alloc_fdmem+0x2b/0x34
[   70.780063]  [<ffffffff81187b5a>] check_object+0x111/0x1ac
[   70.780063]  [<ffffffff811b8111>] ? alloc_fdmem+0x2b/0x34
[   70.780063]  [<ffffffff81a5ef08>] alloc_debug_processing+0x67/0x109
[   70.780063]  [<ffffffff81a5f3f5>] __slab_alloc+0x44b/0x4d2
[   70.780063]  [<ffffffff811b8111>] ? alloc_fdmem+0x2b/0x34
[   70.780063]  [<ffffffff810a34aa>] ? __might_sleep+0x78/0x80
[   70.780063]  [<ffffffff81189388>] __kmalloc+0xa3/0x14e
[   70.780063]  [<ffffffff811b8111>] ? alloc_fdmem+0x2b/0x34
[   70.780063]  [<ffffffff811b8111>] alloc_fdmem+0x2b/0x34
[   70.780063]  [<ffffffff811b81ab>] alloc_fdtable+0x91/0xc2
[   70.780063]  [<ffffffff811b8aca>] dup_fd+0x15d/0x2fc
[   70.780063]  [<ffffffff8107866a>] copy_process.part.33+0x704/0x1837
[   70.780063]  [<ffffffff810a43b4>] ? sched_clock_cpu+0x9e/0xb7
[   70.780063]  [<ffffffff810a44a7>] ? local_clock+0x19/0x22
[   70.780063]  [<ffffffff810e41cb>] ? current_kernel_time+0xe/0x32
[   70.780063]  [<ffffffff8107994f>] _do_fork+0xd3/0x371
[   70.780063]  [<ffffffff810e41cb>] ? current_kernel_time+0xe/0x32
[   70.780063]  [<ffffffff81106d79>] ? __audit_syscall_entry+0xbf/0xe1
[   70.780063]  [<ffffffff8100e658>] ? do_audit_syscall_entry+0x63/0x65
[   70.780063]  [<ffffffff8100f429>] ? syscall_trace_enter_phase1+0x11a/0x125
[   70.780063]  [<ffffffff81079c73>] SyS_clone+0x19/0x1b
[   70.780063]  [<ffffffff81a703d7>] entry_SYSCALL_64_fastpath+0x12/0x6f
[   70.780063] FIX kmalloc-64: Restoring
0xffff8800d480c7c0-0xffff8800d480c7c0=0x6b
[   70.780063]
[   70.780063] FIX kmalloc-64: Marking all objects used
