From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Tue, 12 May 2009 10:55:58 +0200
Message-ID: <200905121055.58304.borntraeger__24343.2596479126$1242118639$gmane$org@de.ibm.com>
References: <cover.1242080138.git.mst@redhat.com>
	<20090511221932.GA22915@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090511221932.GA22915@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

Am Tuesday 12 May 2009 00:19:32 schrieb Michael S. Tsirkin:
> This replaces find_vq/del_vq with find_vqs/del_vqs virtio operations,
> and updates all drivers. This is needed for MSI support, because MSI
> needs to know the total number of vectors upfront.
[...]
> diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c

This file contains several copy/paste breakages and needs at least the
patch below to compile.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
 drivers/s390/kvm/kvm_virtio.c |   28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

Index: kvm/drivers/s390/kvm/kvm_virtio.c
===================================================================
--- kvm.orig/drivers/s390/kvm/kvm_virtio.c
+++ kvm/drivers/s390/kvm/kvm_virtio.c
@@ -237,23 +237,23 @@ static void kvm_del_vqs(struct virtio_de
 	int i;
 	if (!kdev->vqs)
 		return;
-	for (i = 0; i < ldev->nvqs; ++i)
+	for (i = 0; i < kdev->nvqs; ++i)
 		kvm_del_vq(kdev->vqs[i]);
-	kfree(ldev->vqs);
-	ldev->vqs = NULL;
-	ldev->nvqs = 0;
+	kfree(kdev->vqs);
+	kdev->vqs = NULL;
+	kdev->nvqs = 0;
 }
 
 static int kvm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-			struct virtqueue *vqs[]
-			void (*callbacks)[](struct virtqueue *))
+			struct virtqueue *vqs[],
+			virtqueue_callback *callbacks[])
 {
 	struct kvm_device *kdev = to_kvmdev(vdev);
 	int i;
 
 	/* We must have this many virtqueues. */
 	if (nvqs > kdev->desc->num_vq)
-		return ERR_PTR(-ENOENT);
+		return -ENOENT;
 
 	kdev->vqs = kmalloc(GFP_KERNEL, nvqs * sizeof *kdev->vqs);
 	if (!kdev->vqs)
@@ -272,20 +272,6 @@ error:
 	return PTR_ERR(vqs[i]);
 }
 
-static void kvm_del_vqs(struct virtio_device *vdev)
-{
-	struct lguest_device *ldev = to_lgdev(vdev);
-	int i;
-
-	if (!ldev->vqs)
-		return;
-	for (i = 0; i < ldev->nvqs; ++i)
-		lg_del_vq(ldev->vqs[i]);
-	kfree(ldev->vqs);
-	ldev->vqs = NULL;
-	ldev->nvqs = 0;
-}
-
 /*
  * The config ops structure as defined by virtio config
  */
