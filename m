From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio_rng: dont use vmalloced addresses for virtio
Date: Mon, 26 May 2008 16:25:28 +0200
Message-ID: <200805261625.28419.borntraeger__1201.86821227453$1211812192$gmane$org@de.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

If virtio_rng is build as a module, random_data is an address in vmalloc
space. As virtio expects guest real addresses, this can cause any kind of 
funny behaviour, so lets allocate random_data dynamically with kmalloc.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
 drivers/char/hw_random/virtio-rng.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: kvm/drivers/char/hw_random/virtio-rng.c
===================================================================
--- kvm.orig/drivers/char/hw_random/virtio-rng.c
+++ kvm/drivers/char/hw_random/virtio-rng.c
@@ -27,7 +27,7 @@
  * give it 64 bytes at a time, and the hwrng framework takes it 4 bytes at a
  * time. */
 static struct virtqueue *vq;
-static u32 random_data[16];
+static u32 *random_data;
 static unsigned int data_left;
 static DECLARE_COMPLETION(have_data);
 
@@ -47,9 +47,9 @@ static void register_buffer(void)
 {
 	struct scatterlist sg;
 
-	sg_init_one(&sg, &random_data, sizeof(random_data));
+	sg_init_one(&sg, random_data, 64);
 	/* There should always be room for one buffer. */
-	if (vq->vq_ops->add_buf(vq, &sg, 0, 1, &random_data) != 0)
+	if (vq->vq_ops->add_buf(vq, &sg, 0, 1, random_data) != 0)
 		BUG();
 	vq->vq_ops->kick(vq);
 }
@@ -128,11 +128,15 @@ static struct virtio_driver virtio_rng =
 
 static int __init init(void)
 {
+	random_data = kmalloc(64, GFP_KERNEL);
+	if (!random_data)
+		return -ENOMEM;
 	return register_virtio_driver(&virtio_rng);
 }
 
 static void __exit fini(void)
 {
+	kfree(random_data);
 	unregister_virtio_driver(&virtio_rng);
 }
 module_init(init);
