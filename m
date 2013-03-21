From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH 05/22] virtio: add support for 64 bit features.
Date: Thu, 21 Mar 2013 11:06:14 +0100
Message-ID: <20130321110614.24c6ed08@gondolin>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
	<1363854584-25795-6-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363854584-25795-6-git-send-email-rusty@rustcorp.com.au>
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

On Thu, 21 Mar 2013 18:59:26 +1030
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Change the u32 to a u64, and make sure to use 1ULL everywhere!
> 
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: Brian Swetland <swetland@google.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/char/virtio_console.c          |    2 +-
>  drivers/lguest/lguest_device.c         |   10 +++++-----
>  drivers/remoteproc/remoteproc_virtio.c |    6 +++++-
>  drivers/s390/kvm/kvm_virtio.c          |   10 +++++-----
>  drivers/virtio/virtio.c                |   12 ++++++------
>  drivers/virtio/virtio_mmio.c           |   14 +++++++++-----
>  drivers/virtio/virtio_pci.c            |    5 ++---
>  drivers/virtio/virtio_ring.c           |    2 +-
>  include/linux/virtio.h                 |    2 +-
>  include/linux/virtio_config.h          |    8 ++++----
>  tools/virtio/linux/virtio.h            |    2 +-
>  tools/virtio/linux/virtio_config.h     |    2 +-
>  12 files changed, 41 insertions(+), 34 deletions(-)
> 

And a not-even-compiled change for virtio_ccw as well:

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index eb0616b..2ca6dc5 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -454,8 +454,17 @@ static void virtio_ccw_finalize_features(struct virtio_device *vdev)
 	vring_transport_features(vdev);
 
 	features->index = 0;
-	features->features = cpu_to_le32(vdev->features);
-	/* Write the feature bits to the host. */
+	features->features = cpu_to_le32((u32)vdev->features);
+	/* Write the first half of the feature bits to the host. */
+	ccw->cmd_code = CCW_CMD_WRITE_FEAT;
+	ccw->flags = 0;
+	ccw->count = sizeof(*features);
+	ccw->cda = (__u32)(unsigned long)features;
+	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_FEAT);
+
+	features->index = 1;
+	features->features = cpu_to_le32(vdev->features >> 32);
+	/* Write the second half of the feature bits to the host. */
 	ccw->cmd_code = CCW_CMD_WRITE_FEAT;
 	ccw->flags = 0;
 	ccw->count = sizeof(*features);
