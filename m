From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/2] tools/virtio: make barriers stronger.
Date: Wed, 06 Mar 2013 15:54:42 +1100
Message-ID: <87vc95b019.fsf@rustcorp.com.au>
References: <1362491468-16681-1-git-send-email-sjur.brandeland@stericsson.com>
	<871ubtcezb.fsf@rustcorp.com.au> <87y5e1b03l.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87y5e1b03l.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

In the coming vringh_test, we share an mmap with another userspace process
for testing.  This requires real barriers.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
index aff61e1..7a63693 100644
--- a/tools/virtio/asm/barrier.h
+++ b/tools/virtio/asm/barrier.h
@@ -3,8 +3,8 @@
 #define mb() __sync_synchronize()
 
 #define smp_mb()	mb()
-# define smp_rmb()	barrier()
-# define smp_wmb()	barrier()
+# define smp_rmb()	mb()
+# define smp_wmb()	mb()
 /* Weak barriers should be used. If not - it's a bug */
 # define rmb()	abort()
 # define wmb()	abort()
