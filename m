From: Hillf Danton <hdanton@sina.com>
Subject: Re: memory leak in vhost_net_ioctl
Date: Thu, 13 Jun 2019 22:15:21 +0800
Message-ID: <20190613141521.424-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1492352524324346751=="
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
To: Dmitry Vyukov <dvyukov@google.com>
Cc: "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>, Hillf Danton <hdanton@sina.com>, "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>, "hawk@kernel.org" <hawk@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>, syzbot <syzbot+0789f0c7e45efd7bb643@syzkaller.appspotmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "ast@kernel.org" <ast@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, Asias He <asias@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "davem@davemloft.net" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

--===============1492352524324346751==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


Hello Dmitry

On Thu, 13 Jun 2019 20:12:06 +0800 Dmitry Vyukov wrote:
> On Thu, Jun 13, 2019 at 2:07 PM Hillf Danton <hdanton@sina.com> wrote:
> >
> > Hello Jason
> >
> > On Thu, 13 Jun 2019 17:10:39 +0800 Jason Wang wrote:
> > >
> > > This is basically a kfree(ubuf) after the second vhost_net_flush() in
> > > vhost_net_release().
> > >
> > Fairly good catch.
> >
> > > Could you please post a formal patch?
> > >
> > I'd like very much to do that; but I wont, I am afraid, until I collect a
> > Tested-by because of reproducer without a cutting edge.
>
> You can easily collect Tested-by from syzbot for any bug with a reproducer;)
> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#testing-patches
>
Thank you for the light you are casting.

Here it goes.
--->8--------
From: Hillf Danton <hdanton@sina.com>
Subject: [PATCH] vhost: fix memory leak in vhost_net_release

syzbot found the following crash on:

HEAD commit:    788a0249 Merge tag 'arc-5.2-rc4' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?xdc9ea6a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x’c73825cbdc7326
dashboard link: https://syzkaller.appspot.com/bug?extid89f0c7e45efd7bb643
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?xb31761a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x4892c1a00000


udit: type00 audit(1559768703.229:36): avc:  denied  { map } for
pidq16 comm="syz-executor330" path="/root/syz-executor330334897"
dev="sda1" ino461 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
executing program
executing program

BUG: memory leak
unreferenced object 0xffff88812421fe40 (size 64):
   comm "syz-executor330", pid 7117, jiffies 4294949245 (age 13.030s)
   hex dump (first 32 bytes):
     01 00 00 00 20 69 6f 63 00 00 00 00 64 65 76 2f  .... ioc....dev/
     50 fe 21 24 81 88 ff ff 50 fe 21 24 81 88 ff ff  P.!$....P.!$....
   backtrace:
     [<00000000ae0c4ae0>] kmemleak_alloc_recursive include/linux/kmemleak.h:55 [inline]
     [<00000000ae0c4ae0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000ae0c4ae0>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000ae0c4ae0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000079ebab38>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000079ebab38>] vhost_net_ubuf_alloc drivers/vhost/net.c:241 [inline]
     [<0000000079ebab38>] vhost_net_set_backend drivers/vhost/net.c:1534 [inline]
     [<0000000079ebab38>] vhost_net_ioctl+0xb43/0xc10 drivers/vhost/net.c:1716
     [<000000009f6204a2>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000009f6204a2>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000009f6204a2>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000b45866de>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000dfb41eb8>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000dfb41eb8>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000dfb41eb8>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000049c1f547>] do_syscall_64+0x76/0x1a0 arch/x86/entry/common.c:301
     [<0000000029cc8ca7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88812421fa80 (size 64):
   comm "syz-executor330", pid 7130, jiffies 4294949755 (age 7.930s)
   hex dump (first 32 bytes):
     01 00 00 00 01 00 00 00 00 00 00 00 2f 76 69 72  ............/vir
     90 fa 21 24 81 88 ff ff 90 fa 21 24 81 88 ff ff  ..!$......!$....
   backtrace:
     [<00000000ae0c4ae0>] kmemleak_alloc_recursive  include/linux/kmemleak.h:55 [inline]
     [<00000000ae0c4ae0>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000ae0c4ae0>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000ae0c4ae0>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<0000000079ebab38>] kmalloc include/linux/slab.h:547 [inline]
     [<0000000079ebab38>] vhost_net_ubuf_alloc drivers/vhost/net.c:241  [inline]
     [<0000000079ebab38>] vhost_net_set_backend drivers/vhost/net.c:1534  [inline]
     [<0000000079ebab38>] vhost_net_ioctl+0xb43/0xc10  drivers/vhost/net.c:1716
     [<000000009f6204a2>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<000000009f6204a2>] file_ioctl fs/ioctl.c:509 [inline]
     [<000000009f6204a2>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000b45866de>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000dfb41eb8>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000dfb41eb8>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000dfb41eb8>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<0000000049c1f547>] do_syscall_64+0x76/0x1a0  arch/x86/entry/common.c:301
     [<0000000029cc8ca7>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

End of syzbot report.

The function vhost_net_ubuf_alloc() appears in the two cases of dump info, for
pid 7130 and 7117, suggesting that it is ubuf leak.

Since commit c38e39c378f4 ("vhost-net: fix use-after-free in vhost_net_flush")
the function vhost_net_flush() had been no longer releasing ubuf.

Freeing the slab after the last flush in the release path fixes it.


Fixes: c38e39c378f4 ("vhost-net: fix use-after-free in vhost_net_flush")
Reported-by: Syzbot <syzbot+0789f0c7e45efd7bb643@syzkaller.appspotmail.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Asias He <asias@redhat.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
---
This is sent only for collecting Tested-by.

 drivers/vhost/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 3beb401..22fae0a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1404,6 +1404,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	/* We do an extra flush before freeing memory,
 	 * since jobs can re-queue themselves. */
 	vhost_net_flush(n);
+	kfree(n->vqs[VHOST_NET_VQ_TX].ubufs);
 	kfree(n->vqs[VHOST_NET_VQ_RX].rxq.queue);
 	kfree(n->vqs[VHOST_NET_VQ_TX].xdp);
 	kfree(n->dev.vqs);
--


--===============1492352524324346751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1492352524324346751==--
