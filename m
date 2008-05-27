From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio_rng: dont use vmalloced addresses for virtio
Date: Tue, 27 May 2008 11:26:45 +1000
Message-ID: <200805271126.46194.rusty__23001.5787798495$1211854332$gmane$org@rustcorp.com.au>
References: <200805261625.28419.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805261625.28419.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 27 May 2008 00:25:28 Christian Borntraeger wrote:
> If virtio_rng is build as a module, random_data is an address in vmalloc
> space. As virtio expects guest real addresses, this can cause any kind of
> funny behaviour, so lets allocate random_data dynamically with kmalloc.
>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Erk, nasty trap...

> -	sg_init_one(&sg, &random_data, sizeof(random_data));
> +	sg_init_one(&sg, random_data, 64);

Constant in two places, I've moved to a #define.

>  static int __init init(void)
>  {
> +	random_data = kmalloc(64, GFP_KERNEL);
> +	if (!random_data)
> +		return -ENOMEM;
>  	return register_virtio_driver(&virtio_rng);

And added cleanup on register_virtio_driver fail (a tiny leak. but still).

Cheers,
Rusty.

Subject: virtio_rng: dont use vmalloced addresses for virtio
Date: Mon, 26 May 2008 16:25:28 +0200
From: Christian Borntraeger <borntraeger@de.ibm.com>

If virtio_rng is build as a module, random_data is an address in vmalloc
space. As virtio expects guest real addresses, this can cause any kind of
funny behaviour, so lets allocate random_data dynamically with kmalloc.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/hw_random/virtio-rng.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff -r 82ce499b3321 drivers/char/hw_random/virtio-rng.c
--- a/drivers/char/hw_random/virtio-rng.c	Tue May 27 11:22:18 2008 +1000
+++ b/drivers/char/hw_random/virtio-rng.c	Tue May 27 11:25:32 2008 +1000
@@ -26,8 +26,10 @@
 /* The host will fill any buffer we give it with sweet, sweet randomness.  We
  * give it 64 bytes at a time, and the hwrng framework takes it 4 bytes at a
  * time. */
+#define RANDOM_DATA_SIZE 64
+
 static struct virtqueue *vq;
-static u32 random_data[16];
+static u32 *random_data;
 static unsigned int data_left;
 static DECLARE_COMPLETION(have_data);
 
@@ -47,9 +49,9 @@ static void register_buffer(void)
 {
 	struct scatterlist sg;
 
-	sg_init_one(&sg, &random_data, sizeof(random_data));
+	sg_init_one(&sg, random_data, RANDOM_DATA_SIZE);
 	/* There should always be room for one buffer. */
-	if (vq->vq_ops->add_buf(vq, &sg, 0, 1, &random_data) != 0)
+	if (vq->vq_ops->add_buf(vq, &sg, 0, 1, random_data) != 0)
 		BUG();
 	vq->vq_ops->kick(vq);
 }
@@ -128,11 +130,21 @@ static struct virtio_driver virtio_rng =
 
 static int __init init(void)
 {
-	return register_virtio_driver(&virtio_rng);
+	int err;
+
+	random_data = kmalloc(RANDOM_DATA_SIZE, GFP_KERNEL);
+	if (!random_data)
+		return -ENOMEM;
+
+	err = register_virtio_driver(&virtio_rng);
+	if (err)
+		kfree(random_data);
+	return err;
 }
 
 static void __exit fini(void)
 {
+	kfree(random_data);
 	unregister_virtio_driver(&virtio_rng);
 }
 module_init(init);
