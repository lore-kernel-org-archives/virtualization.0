From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: KASAN: use-after-free Read in vhost_work_queue
Date: Tue, 28 Aug 2018 11:11:21 -0400
Message-ID: <20180828111055-mutt-send-email-mst__48844.1880596385$1535468967$gmane$org@kernel.org>
References: <000000000000863e0205747fdfef@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <000000000000863e0205747fdfef@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: syzbot <syzbot+d5a0a170c5069658b141@syzkaller.appspotmail.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 28, 2018 at 07:44:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    33e17876ea4e Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12d8a20a400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=40e5d6b26b73cd5b
> dashboard link: https://syzkaller.appspot.com/bug?extid=d5a0a170c5069658b141
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d5a0a170c5069658b141@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in vhost_work_queue+0xc3/0xe0
> drivers/vhost/vhost.c:258
> Read of size 8 at addr ffff880193862068 by task syz-executor7/22100
> 
> CPU: 0 PID: 22100 Comm: syz-executor7 Not tainted 4.18.0+ #108
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x2b4 lib/dump_stack.c:113
>  print_address_description+0x6c/0x20b mm/kasan/report.c:256
>  kasan_report_error mm/kasan/report.c:354 [inline]
>  kasan_report.cold.7+0x242/0x30d mm/kasan/report.c:412
>  __asan_report_load8_noabort+0x14/0x20 mm/kasan/report.c:433
>  vhost_work_queue+0xc3/0xe0 drivers/vhost/vhost.c:258
>  vhost_transport_send_pkt+0x28a/0x380 drivers/vhost/vsock.c:227
>  virtio_transport_send_pkt_info+0x31d/0x460
> net/vmw_vsock/virtio_transport_common.c:190
>  virtio_transport_shutdown+0x1b1/0x270
> net/vmw_vsock/virtio_transport_common.c:604
>  vsock_send_shutdown net/vmw_vsock/af_vsock.c:451 [inline]
>  vsock_shutdown+0x229/0x290 net/vmw_vsock/af_vsock.c:849
>  __sys_shutdown+0x15c/0x2c0 net/socket.c:1964
>  __do_sys_shutdown net/socket.c:1972 [inline]
>  __se_sys_shutdown net/socket.c:1970 [inline]
>  __ia32_sys_shutdown+0x54/0x80 net/socket.c:1970
>  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7fa4ca9
> Code: 55 08 8b 88 64 cd ff ff 8b 98 68 cd ff ff 89 c8 85 d2 74 02 89 0a 5b
> 5d c3 8b 04 24 c3 8b 1c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90
> 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000f5f7f0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000175
> RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> Allocated by task 22094:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  kasan_kmalloc+0xc4/0xe0 mm/kasan/kasan.c:553
>  __do_kmalloc_node mm/slab.c:3682 [inline]
>  __kmalloc_node+0x47/0x70 mm/slab.c:3689
>  kmalloc_node include/linux/slab.h:555 [inline]
>  kvmalloc_node+0xb9/0xf0 mm/util.c:423
>  kvmalloc include/linux/mm.h:577 [inline]
>  vhost_vsock_dev_open+0xa2/0x5a0 drivers/vhost/vsock.c:511
>  misc_open+0x3ca/0x560 drivers/char/misc.c:141
>  chrdev_open+0x25a/0x770 fs/char_dev.c:417
>  do_dentry_open+0x49c/0x1140 fs/open.c:771
>  vfs_open+0xa0/0xd0 fs/open.c:880
>  do_last fs/namei.c:3418 [inline]
>  path_openat+0x12fb/0x5300 fs/namei.c:3534
>  do_filp_open+0x255/0x380 fs/namei.c:3564
>  do_sys_open+0x584/0x720 fs/open.c:1063
>  __do_compat_sys_openat fs/open.c:1109 [inline]
>  __se_compat_sys_openat fs/open.c:1107 [inline]
>  __ia32_compat_sys_openat+0x98/0xf0 fs/open.c:1107
>  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
>  do_fast_syscall_32+0x34d/0xfb2 arch/x86/entry/common.c:397
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> 
> Freed by task 22093:
>  save_stack+0x43/0xd0 mm/kasan/kasan.c:448
>  set_track mm/kasan/kasan.c:460 [inline]
>  __kasan_slab_free+0x11a/0x170 mm/kasan/kasan.c:521
>  kasan_slab_free+0xe/0x10 mm/kasan/kasan.c:528
>  __cache_free mm/slab.c:3498 [inline]
>  kfree+0xd9/0x210 mm/slab.c:3813
>  kvfree+0x61/0x70 mm/util.c:449
>  vhost_vsock_free drivers/vhost/vsock.c:499 [inline]
>  vhost_vsock_dev_release+0x4fd/0x750 drivers/vhost/vsock.c:604
>  __fput+0x36e/0x8c0 fs/file_table.c:278
>  ____fput+0x15/0x20 fs/file_table.c:309
>  task_work_run+0x1e8/0x2a0 kernel/task_work.c:113
>  tracehook_notify_resume include/linux/tracehook.h:193 [inline]
>  exit_to_usermode_loop+0x318/0x380 arch/x86/entry/common.c:166
>  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
>  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
>  do_syscall_32_irqs_on arch/x86/entry/common.c:341 [inline]
>  do_fast_syscall_32+0xcd5/0xfb2 arch/x86/entry/common.c:397
>  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> 
> The buggy address belongs to the object at ffff880193861fc0
>  which belongs to the cache kmalloc-65536 of size 65536
> The buggy address is located 168 bytes inside of
>  65536-byte region [ffff880193861fc0, ffff880193871fc0)
> The buggy address belongs to the page:
> page:ffffea00064e1800 count:1 mapcount:0 mapping:ffff8801dac02500 index:0x0
> compound_mapcount: 0
> flags: 0x2fffc0000008100(slab|head)
> raw: 02fffc0000008100 ffffea00064c7008 ffffea00064e5008 ffff8801dac02500
> raw: 0000000000000000 ffff880193861fc0 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>  ffff880193861f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff880193861f80: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
> > ffff880193862000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                           ^
>  ffff880193862080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff880193862100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================

Seems like a duplicate of the bug Stefan's working on now.

> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with
> syzbot.
