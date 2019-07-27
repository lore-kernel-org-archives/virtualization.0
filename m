From: Hillf Danton <hdanton@sina.com>
Subject: Re: INFO: rcu detected stall in vhost_worker
Date: Sat, 27 Jul 2019 16:23:23 +0800
Message-ID: <000000000000e87d14058e9728d7__46228.1058354833$1564215838$gmane$org@google.com>
References: <000000000000b4358f058e924c6d@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <000000000000b4358f058e924c6d@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: syzbot <syzbot+36e93b425cd6eb54fcc1@syzkaller.appspotmail.com>
Cc: michal.lkml@markovi.net, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kbuild@vger.kernel.org, syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, yamada.masahiro@socionext.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Fri, 26 Jul 2019 08:26:01 -0700 (PDT)
> syzbot has bisected this bug to:
> 
> commit 0ecfebd2b52404ae0c54a878c872bb93363ada36
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Jul 7 22:41:56 2019 +0000
> 
>      Linux 5.2
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=118810bfa00000
> start commit:   13bf6d6a Add linux-next specific files for 20190725
> git tree:       linux-next
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8ae987d803395886
> dashboard link: https://syzkaller.appspot.com/bug?extid=36e93b425cd6eb54fcc1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15112f3fa00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131ab578600000
> 
> Reported-by: syzbot+36e93b425cd6eb54fcc1@syzkaller.appspotmail.com
> Fixes: 0ecfebd2b524 ("Linux 5.2")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -787,7 +787,6 @@ static void vhost_setup_uaddr(struct vho
 			      size_t size, bool write)
 {
 	struct vhost_uaddr *addr = &vq->uaddrs[index];
-	spin_lock(&vq->mmu_lock);
 
 	addr->uaddr = uaddr;
 	addr->size = size;
@@ -797,7 +796,10 @@ static void vhost_setup_uaddr(struct vho
 static void vhost_setup_vq_uaddr(struct vhost_virtqueue *vq)
 {
 	spin_lock(&vq->mmu_lock);
-
+	/*
+	 * deadlock if managing to take mmu_lock again while
+	 * setting up uaddr
+	 */
 	vhost_setup_uaddr(vq, VHOST_ADDR_DESC,
 			  (unsigned long)vq->desc,
 			  vhost_get_desc_size(vq, vq->num),
--
