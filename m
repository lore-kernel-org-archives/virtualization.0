From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio_rng: adopt driver to newest virtio code
Date: Mon, 14 Jan 2008 16:51:47 +0100
Message-ID: <200801141651.47870.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty,

This patch changes the virtio_rng to a callback without a return value.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
 drivers/char/hw_random/virtio-rng.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: kvm/drivers/char/hw_random/virtio-rng.c
===================================================================
--- kvm.orig/drivers/char/hw_random/virtio-rng.c
+++ kvm/drivers/char/hw_random/virtio-rng.c
@@ -27,13 +27,12 @@ static struct virtqueue *vq;
 static u32 random_data;
 static bool have_data;
 
-static bool random_recv_done(struct virtqueue *vq)
+static void random_recv_done(struct virtqueue *vq)
 {
 	have_data = true;
 
-	/* Don't suppress callbacks: there can't be any more since we
+	/* No need to call disable_cb: there can't be any more since we
 	 * have used up the only buffer. */
-	return true;
 }
 
 static void register_buffer(void)
