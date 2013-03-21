From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 04/22] virtio: use u32, not bitmap for struct
	virtio_device's features
Date: Thu, 21 Mar 2013 11:00:11 +0100
Message-ID: <20130321110011.687c8ac4@gondolin>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-5-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363854584-25795-5-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Brian Swetland <swetland@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 21 Mar 2013 18:59:25 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:

> It seemed like a good idea, but it's actually a pain when we get more
> than 32 feature bits.  Just change it to a u32 for now.
> 
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Brian Swetland <swetland@google.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/char/virtio_console.c          |    2 +-
>  drivers/lguest/lguest_device.c         |    2 +-
>  drivers/remoteproc/remoteproc_virtio.c |    2 +-
>  drivers/s390/kvm/kvm_virtio.c          |    2 +-
>  drivers/virtio/virtio.c                |   10 +++++-----
>  drivers/virtio/virtio_mmio.c           |    8 ++------
>  drivers/virtio/virtio_pci.c            |    3 +--
>  drivers/virtio/virtio_ring.c           |    2 +-
>  include/linux/virtio.h                 |    3 +--
>  include/linux/virtio_config.h          |    2 +-
>  tools/virtio/linux/virtio.h            |   22 +---------------------
>  tools/virtio/linux/virtio_config.h     |    2 +-
>  tools/virtio/virtio_test.c             |    5 ++---
>  tools/virtio/vringh_test.c             |   16 ++++++++--------
>  14 files changed, 27 insertions(+), 54 deletions(-)

I didn't try this patch, but wouldn't virtio_ccw need something like
the change below as well?

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
