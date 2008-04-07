From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] virtio_net: remove overzealous printk
Date: Mon,  7 Apr 2008 15:33:16 -0500
Message-ID: <1207600396-28454-1-git-send-email-aliguori__9745.57249942354$1207600586$gmane$org@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: netdev@vger.kernel.org, Anthony Liguori <aliguori@us.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The 'disable_cb' is really just a hint and as such, it's possible for more
work to get queued up while callbacks are disabled.  Under stress with an
SMP guest, this printk triggers very frequently.  There is no race here, this
is how things are designed to work so let's just remove the printk.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b58472c..d1a200f 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -284,7 +284,6 @@ again:
 		/* Activate callback for using skbs: if this returns false it
 		 * means some were used in the meantime. */
 		if (unlikely(!vi->svq->vq_ops->enable_cb(vi->svq))) {
-			printk("Unlikely: restart svq race\n");
 			vi->svq->vq_ops->disable_cb(vi->svq);
 			netif_start_queue(dev);
 			goto again;
