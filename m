From: Hillf Danton <hdanton@sina.com>
Subject: Re: memory leak in vhost_net_ioctl
Date: Thu,  6 Jun 2019 22:40:13 +0800
Message-ID: <20190606144013.9884-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
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
Cc: xdp-newbies@vger.kernel.org, jakub.kicinski@netronome.com, hawk@kernel.org, daniel@iogearbox.net, mst@redhat.com, netdev@vger.kernel.org, john.fastabend@gmail.com, ast@kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, kvm@vger.kernel.org, bpf@vger.kernel.org, virtualization@lists.linux-foundation.org, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org


On Wed, 05 Jun 2019 16:42:05 -0700 (PDT) syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    788a0249 Merge tag 'arc-5.2-rc4' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=15dc9ea6a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d5c73825cbdc7326
> dashboard link: https://syzkaller.appspot.com/bug?extid=0789f0c7e45efd7bb643
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b31761a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124892c1a00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0789f0c7e45efd7bb643@syzkaller.appspotmail.com
> 
> udit: type=1400 audit(1559768703.229:36): avc:  denied  { map } for   
> pid=7116 comm="syz-executor330" path="/root/syz-executor330334897"  
> dev="sda1" ino=16461 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
> tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> executing program
> executing program
> BUG: memory leak
> unreferenced object 0xffff88812421fe40 (size 64):
>    comm "syz-executor330", pid 7117, jiffies 4294949245 (age 13.030s)
>    hex dump (first 32 bytes):
>      01 00 00 00 20 69 6f 63 00 00 00 00 64 65 76 2f  .... ioc....dev/
>      50 fe 21 24 81 88 ff ff 50 fe 21 24 81 88 ff ff  P.!$....P.!$....
>    backtrace:
>      [<00000000ae0c4ae0>] kmemleak_alloc_recursive include/linux/kmemleak.h:55 [inline]
>      [<00000000ae0c4ae0>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<00000000ae0c4ae0>] slab_alloc mm/slab.c:3326 [inline]
>      [<00000000ae0c4ae0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
>      [<0000000079ebab38>] kmalloc include/linux/slab.h:547 [inline]
>      [<0000000079ebab38>] vhost_net_ubuf_alloc drivers/vhost/net.c:241 [inline]
>      [<0000000079ebab38>] vhost_net_set_backend drivers/vhost/net.c:1534 [inline]
>      [<0000000079ebab38>] vhost_net_ioctl+0xb43/0xc10 drivers/vhost/net.c:1716
>      [<000000009f6204a2>] vfs_ioctl fs/ioctl.c:46 [inline]
>      [<000000009f6204a2>] file_ioctl fs/ioctl.c:509 [inline]
>      [<000000009f6204a2>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>      [<00000000b45866de>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>      [<00000000dfb41eb8>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>      [<00000000dfb41eb8>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>      [<00000000dfb41eb8>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>      [<0000000049c1f547>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
>      [<0000000029cc8ca7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> BUG: memory leak
> unreferenced object 0xffff88812421fa80 (size 64):
>    comm "syz-executor330", pid 7130, jiffies 4294949755 (age 7.930s)
>    hex dump (first 32 bytes):
>      01 00 00 00 01 00 00 00 00 00 00 00 2f 76 69 72  ............/vir
>      90 fa 21 24 81 88 ff ff 90 fa 21 24 81 88 ff ff  ..!$......!$....
>    backtrace:
>      [<00000000ae0c4ae0>] kmemleak_alloc_recursive include/linux/kmemleak.h:55 [inline]
>      [<00000000ae0c4ae0>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<00000000ae0c4ae0>] slab_alloc mm/slab.c:3326 [inline]
>      [<00000000ae0c4ae0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
>      [<0000000079ebab38>] kmalloc include/linux/slab.h:547 [inline]
>      [<0000000079ebab38>] vhost_net_ubuf_alloc drivers/vhost/net.c:241 [inline]
>      [<0000000079ebab38>] vhost_net_set_backend drivers/vhost/net.c:1534 [inline]
>      [<0000000079ebab38>] vhost_net_ioctl+0xb43/0xc10 drivers/vhost/net.c:1716
>      [<000000009f6204a2>] vfs_ioctl fs/ioctl.c:46 [inline]
>      [<000000009f6204a2>] file_ioctl fs/ioctl.c:509 [inline]
>      [<000000009f6204a2>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>      [<00000000b45866de>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>      [<00000000dfb41eb8>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>      [<00000000dfb41eb8>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>      [<00000000dfb41eb8>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>      [<0000000049c1f547>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
>      [<0000000029cc8ca7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
> 
Ignore my noise if you have no interest seeing the syzbot report.

After commit c38e39c378f46f ("vhost-net: fix use-after-free in
vhost_net_flush") flush would no longer free ubuf, just wait until ubuf users
disappear instead.

The following diff, in hope that may perhaps help you handle the memory leak,
makes flush able to free ubuf in the path of file release.

Thanks
Hillf
---
 drivers/vhost/net.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 3beb401..dcf20b6 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -141,6 +141,7 @@ struct vhost_net {
 	unsigned tx_zcopy_err;
 	/* Flush in progress. Protected by tx vq lock. */
 	bool tx_flush;
+	bool ld;	/* Last dinner */
 	/* Private page frag */
 	struct page_frag page_frag;
 	/* Refcount bias of page frag */
@@ -1283,6 +1284,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	n = kvmalloc(sizeof *n, GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 	if (!n)
 		return -ENOMEM;
+	n->ld = false;
 	vqs = kmalloc_array(VHOST_NET_VQ_MAX, sizeof(*vqs), GFP_KERNEL);
 	if (!vqs) {
 		kvfree(n);
@@ -1376,7 +1378,10 @@ static void vhost_net_flush(struct vhost_net *n)
 		n->tx_flush = true;
 		mutex_unlock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		/* Wait for all lower device DMAs done. */
-		vhost_net_ubuf_put_and_wait(n->vqs[VHOST_NET_VQ_TX].ubufs);
+		if (n->ld)
+			vhost_net_ubuf_put_wait_and_free(n->vqs[VHOST_NET_VQ_TX].ubufs);
+		else
+			vhost_net_ubuf_put_and_wait(n->vqs[VHOST_NET_VQ_TX].ubufs);
 		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		n->tx_flush = false;
 		atomic_set(&n->vqs[VHOST_NET_VQ_TX].ubufs->refcount, 1);
@@ -1403,6 +1408,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	synchronize_rcu();
 	/* We do an extra flush before freeing memory,
 	 * since jobs can re-queue themselves. */
+	n->ld = true;
 	vhost_net_flush(n);
 	kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
 	kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
--
