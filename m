From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio-rng: Remove false BUG for spurious callbacks
Date: Thu, 23 Apr 2009 16:42:59 +0930
Message-ID: <200904231642.59939.rusty__21486.6048343994$1240471042$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, stable@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

The virtio-rng drivers checks for spurious callbacks. Since
callbacks can be implemented via shared interrupts (e.g. PCI) this
could lead to guest kernel oopses with lots of virtio devices.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/char/hw_random/virtio-rng.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/char/hw_random/virtio-rng.c
===================================================================
--- linux-2.6.orig/drivers/char/hw_random/virtio-rng.c
+++ linux-2.6/drivers/char/hw_random/virtio-rng.c
@@ -37,9 +37,9 @@ static void random_recv_done(struct virt
 {
 	int len;
 
-	/* We never get spurious callbacks. */
+	/* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
 	if (!vq->vq_ops->get_buf(vq, &len))
-		BUG();
+		return;
 
 	data_left = len / sizeof(random_data[0]);
 	complete(&have_data);
