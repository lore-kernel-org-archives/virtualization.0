From: Hillf Danton <hdanton@sina.com>
Subject: Re: memory leak in vhost_net_ioctl
Date: Fri, 14 Jun 2019 10:45:19 +0800
Message-ID: <20190614024519.6224-1-hdanton@sina.com>
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
To: syzbot <syzbot+0789f0c7e45efd7bb643@syzkaller.appspotmail.com>
Cc: "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>, "hdanton@sina.com" <hdanton@sina.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "hawk@kernel.org" <hawk@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "mst@redhat.com" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "ast@kernel.org" <ast@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>, "dvyukov@google.com" <dvyukov@google.com>
List-Id: virtualization@lists.linuxfoundation.org


Hello Syzbot

On Fri, 14 Jun 2019 02:26:02 +0800 syzbot wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer still triggered crash:
> memory leak in vhost_net_ioctl
>
Oh sorry for my poor patch.

> ANGE): hsr_slave_1: link becomes ready
> 2019/06/13 18:24:57 executed programs: 18
> BUG: memory leak
> unreferenced object 0xffff88811cbc6ac0 (size 64):
>    comm "syz-executor.0", pid 7196, jiffies 4294943804 (age 14.770s)
>    hex dump (first 32 bytes):
>      01 00 00 00 81 88 ff ff 00 00 00 00 82 88 ff ff  ................
>      d0 6a bc 1c 81 88 ff ff d0 6a bc 1c 81 88 ff ff  .j.......j......
>    backtrace:
>      [<000000006c752978>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>      [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
>      [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
>      [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
>      [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241 [inline]
>      [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535 [inline]
>      [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10 drivers/vhost/net.c:1717
>      [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
>      [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
>      [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>      [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>      [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>      [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>      [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>      [<00000000e4407a23>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
>      [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88810b1365c0 (size 64):
>    comm "syz-executor.2", pid 7193, jiffies 4294943823 (age 14.580s)
>    hex dump (first 32 bytes):
>      01 00 00 00 81 88 ff ff 00 00 00 00 81 88 ff ff  ................
>      d0 65 13 0b 81 88 ff ff d0 65 13 0b 81 88 ff ff  .e.......e......
>    backtrace:
>      [<000000006c752978>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>      [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
>
>      [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
>      [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241 [inline]
>      [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535 [inline]
>      [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10 drivers/vhost/net.c:1717
>      [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
>      [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
>      [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>      [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>      [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>      [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>      [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>      [<00000000e4407a23>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
>      [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88810be23700 (size 64):
>    comm "syz-executor.3", pid 7194, jiffies 4294943823 (age 14.580s)
>    hex dump (first 32 bytes):
>      01 00 00 00 00 00 00 00 00 00 00 00 00 c9 ff ff  ................
>      10 37 e2 0b 81 88 ff ff 10 37 e2 0b 81 88 ff ff  .7.......7......
>    backtrace:
>      [<000000006c752978>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>      [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
>      [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
>      [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
>      [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241 [inline]
>      [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535 [inline]
>      [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10 drivers/vhost/net.c:1717
>      [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
>      [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
>      [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>      [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>      [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>      [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>      [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>      [<00000000e4407a23>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
>      [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88810b136500 (size 64):
>    comm "syz-executor.6", pid 7228, jiffies 4294943827 (age 14.540s)
>    hex dump (first 32 bytes):
>      01 00 00 00 20 69 6f 63 00 00 00 00 64 65 76 2f  .... ioc....dev/
>      10 65 13 0b 81 88 ff ff 10 65 13 0b 81 88 ff ff  .e.......e......
>    backtrace:
>      [<000000006c752978>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>      [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
>      [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
>      [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
>      [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241 [inline]
>      [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535 [inline]
>      [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10 drivers/vhost/net.c:1717
>      [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
>      [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
>      [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>      [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>      [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>      [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>      [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>      [<00000000e4407a23>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
>      [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88810b9cfec0 (size 64):
>    comm "syz-executor.7", pid 7236, jiffies 4294943829 (age 14.520s)
>    hex dump (first 32 bytes):
>      01 00 00 00 20 69 6f 63 00 00 00 00 64 65 76 2f  .... ioc....dev/
>      d0 fe 9c 0b 81 88 ff ff d0 fe 9c 0b 81 88 ff ff  ................
>    backtrace:
>      [<000000006c752978>] kmemleak_alloc_recursive
> include/linux/kmemleak.h:43 [inline]
>      [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
>      [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
>      [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
>      [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241 [inline]
>      [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535 [inline]
>      [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10 drivers/vhost/net.c:1717
>      [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
>      [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
>      [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>      [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>      [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>      [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>      [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>      [<00000000e4407a23>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
>      [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88810b9cd380 (size 64):
>    comm "syz-executor.4", pid 7218, jiffies 4294943834 (age 14.470s)
>    hex dump (first 32 bytes):
>      01 00 00 00 81 88 ff ff 00 00 00 00 81 88 ff ff  ................
>      90 d3 9c 0b 81 88 ff ff 90 d3 9c 0b 81 88 ff ff  ................
>    backtrace:
>      [<000000006c752978>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>      [<000000006c752978>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<000000006c752978>] slab_alloc mm/slab.c:3326 [inline]
>      [<000000006c752978>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
>      [<00000000b3825d52>] kmalloc include/linux/slab.h:547 [inline]
>      [<00000000b3825d52>] vhost_net_ubuf_alloc drivers/vhost/net.c:241 [inline]
>      [<00000000b3825d52>] vhost_net_set_backend drivers/vhost/net.c:1535 [inline]
>      [<00000000b3825d52>] vhost_net_ioctl+0xb43/0xc10 drivers/vhost/net.c:1717
>      [<00000000700f02d7>] vfs_ioctl fs/ioctl.c:46 [inline]
>      [<00000000700f02d7>] file_ioctl fs/ioctl.c:509 [inline]
>      [<00000000700f02d7>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>      [<000000009a0ec0a7>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>      [<00000000d9416323>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>      [<00000000d9416323>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>      [<00000000d9416323>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>      [<00000000e4407a23>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
>      [<000000008715c149>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>
>
> Tested on:
>
> commit:         c11fb13a Merge branch 'for-linus' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11c6b666a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb38d33cd06d8d48
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=11ff0de1a00000
>

And I want to try again the following tiny diff made based on the logic:

1_> vhost_net_ubuf_alloc() in the dump info suggests that it is ubuf leak.

2_> commit c38e39c378f4 ("vhost-net: fix use-after-free in vhost_net_flush")
makes vhost_net_flush() no longer release ubuf.

3_> in both reset_owner and release pathes, see vhost_net_reset_owner() and
vhost_net_release() please, vq is reset in wake of flush:

        vhost_net_flush(n);
        vhost_dev_stop(&n->dev);
        vhost_dev_cleanup(&n->dev);
        vhost_net_vq_reset(n);

4_> the ubufs pointer is cleared in vhost_net_vq_reset()


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

Can you give it a shoot please if there is not anything missed in the
above logic?


Thanks
Hillf
------->8---
---
 drivers/vhost/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 3beb401..87db9b3 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -309,6 +309,8 @@ static void vhost_net_vq_reset(struct vhost_net *n)
 	for (i = 0; i < VHOST_NET_VQ_MAX; i++) {
 		n->vqs[i].done_idx = 0;
 		n->vqs[i].upend_idx = 0;
+		if (n->vqs[i].ubufs)
+			vhost_net_ubuf_put_wait_and_free(n->vqs[i].ubufs);
 		n->vqs[i].ubufs = NULL;
 		n->vqs[i].vhost_hlen = 0;
 		n->vqs[i].sock_hlen = 0;
--
