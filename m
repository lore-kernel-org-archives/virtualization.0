From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv6 2/4] virtio: find_vqs/del_vqs virtio operations
Date: Fri, 15 May 2009 14:20:01 +0930
Message-ID: <200905151420.02235.rusty__18445.5194314525$1242363077$gmane$org@rustcorp.com.au>
References: <cover.1242297977.git.mst@redhat.com>
	<20090514105521.GC3120@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090514105521.GC3120@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

And here's the fixup patch I applied:

diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -318,11 +318,11 @@ static void lg_del_vqs(struct virtio_dev
 	struct virtqueue *vq, *n;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
-		kvm_del_vq(vq);
+		lg_del_vq(vq);
 }
 
 static int lg_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-		       struct virtqueue *vqs[]
+		       struct virtqueue *vqs[],
 		       vq_callback_t *callbacks[],
 		       const char *names[])
 {
@@ -331,7 +331,7 @@ static int lg_find_vqs(struct virtio_dev
 
 	/* We must have this many virtqueues. */
 	if (nvqs > ldev->desc->num_vq)
-		return ERR_PTR(-ENOENT);
+		return -ENOENT;
 
 	for (i = 0; i < nvqs; ++i) {
 		vqs[i] = lg_find_vq(vdev, i, callbacks[i], names[i]);
@@ -341,7 +341,7 @@ static int lg_find_vqs(struct virtio_dev
 	return 0;
 
 error:
-	vp_del_vqs(vdev);
+	lg_del_vqs(vdev);
 	return PTR_ERR(vqs[i]);
 }
 
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -260,7 +260,7 @@ static int p9_virtio_probe(struct virtio
 	return 0;
 
 out_free_vq:
-	vdev->config->del_vq(chan->vq);
+	vdev->config->del_vqs(vdev);
 fail:
 	mutex_lock(&virtio_9p_lock);
 	chan_index--;
@@ -331,7 +331,7 @@ static void p9_virtio_remove(struct virt
 	BUG_ON(chan->inuse);
 
 	if (chan->initialized) {
-		vdev->config->del_vq(chan->vq);
+		vdev->config->del_vqs(vdev);
 		chan->initialized = false;
 	}
 }
