From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 04/22] virtio: use u32,
	not bitmap for struct virtio_device's features
Date: Fri, 22 Mar 2013 11:18:27 +1030
Message-ID: <878v5gfeec.fsf@rustcorp.com.au>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-5-git-send-email-rusty@rustcorp.com.au>
	<20130321110011.687c8ac4@gondolin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130321110011.687c8ac4@gondolin>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Brian Swetland <swetland@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> On Thu, 21 Mar 2013 18:59:25 +1030
> Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>> It seemed like a good idea, but it's actually a pain when we get more
>> than 32 feature bits.  Just change it to a u32 for now.
>> 
...
> I didn't try this patch, but wouldn't virtio_ccw need something like
> the change below as well?

Ah, yes, when I refreshed this pre-ccw patch, I didn't re-do the grep.

And thanks, this made me look at lguest, too.  Which is actually fine,
but now has a misleading comment.

Here'st the net change on top of this patch (I've rolled into the
patch in my git tree).

Thanks,
Rusty.

diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index 48bd2ad..6203562 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -137,9 +137,9 @@ static void lg_finalize_features(struct virtio_device *vdev)
 	vring_transport_features(vdev);
 
 	/*
-	 * The vdev->feature array is a Linux bitmask: this isn't the same as a
-	 * the simple array of bits used by lguest devices for features.  So we
-	 * do this slow, manual conversion which is completely general.
+	 * Since lguest is currently x86-only, we're little-endian.  That
+	 * means we could just memcpy.  But it's not time critical, and in
+	 * case someone copies this code, we do it the slow, obvious way.
 	 */
 	memset(out_features, 0, desc->feature_len);
 	bits = min_t(unsigned, desc->feature_len, sizeof(vdev->features)) * 8;
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 3652473..8c564bf 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -440,7 +440,6 @@ static void virtio_ccw_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct virtio_feature_desc *features;
-	int i;
 	struct ccw1 *ccw;
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
@@ -454,19 +453,15 @@ static void virtio_ccw_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
-	for (i = 0; i < sizeof(*vdev->features) / sizeof(features->features);
-	     i++) {
-		int highbits = i % 2 ? 32 : 0;
-		features->index = i;
-		features->features = cpu_to_le32(vdev->features[i / 2]
-						 >> highbits);
-		/* Write the feature bits to the host. */
-		ccw->cmd_code = CCW_CMD_WRITE_FEAT;
-		ccw->flags = 0;
-		ccw->count = sizeof(*features);
-		ccw->cda = (__u32)(unsigned long)features;
-		ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_FEAT);
-	}
+	features->index = 0;
+	features->features = cpu_to_le32(vdev->features);
+	/* Write the feature bits to the host. */
+	ccw->cmd_code = CCW_CMD_WRITE_FEAT;
+	ccw->flags = 0;
+	ccw->count = sizeof(*features);
+	ccw->cda = (__u32)(unsigned long)features;
+	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_FEAT);
+
 out_free:
 	kfree(features);
 	kfree(ccw);
