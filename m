From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 08/10] virtio/s390: add indirection to indicators access
Date: Fri, 26 Apr 2019 20:32:43 +0200
Message-ID: <20190426183245.37939-9-pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190426183245.37939-1-pasic@linux.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This will come in handy soon when we pull out the indicators from
virtio_ccw_device to a memory area that is shared with the hypervisor
(in particular for protected virtualization guests).

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index bb7a92316fc8..1f3e7d56924f 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -68,6 +68,16 @@ struct virtio_ccw_device {
 	void *airq_info;
 };
 
+static inline unsigned long *indicators(struct virtio_ccw_device *vcdev)
+{
+	return &vcdev->indicators;
+}
+
+static inline unsigned long *indicators2(struct virtio_ccw_device *vcdev)
+{
+	return &vcdev->indicators2;
+}
+
 struct vq_info_block_legacy {
 	__u64 queue;
 	__u32 align;
@@ -337,17 +347,17 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 		ccw->cda = (__u32)(unsigned long) thinint_area;
 	} else {
 		/* payload is the address of the indicators */
-		indicatorp = kmalloc(sizeof(&vcdev->indicators),
+		indicatorp = kmalloc(sizeof(indicators(vcdev)),
 				     GFP_DMA | GFP_KERNEL);
 		if (!indicatorp)
 			return;
 		*indicatorp = 0;
 		ccw->cmd_code = CCW_CMD_SET_IND;
-		ccw->count = sizeof(&vcdev->indicators);
+		ccw->count = sizeof(indicators(vcdev));
 		ccw->cda = (__u32)(unsigned long) indicatorp;
 	}
 	/* Deregister indicators from host. */
-	vcdev->indicators = 0;
+	*indicators(vcdev) = 0;
 	ccw->flags = 0;
 	ret = ccw_io_helper(vcdev, ccw,
 			    vcdev->is_thinint ?
@@ -656,10 +666,10 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	 * We need a data area under 2G to communicate. Our payload is
 	 * the address of the indicators.
 	*/
-	indicatorp = kmalloc(sizeof(&vcdev->indicators), GFP_DMA | GFP_KERNEL);
+	indicatorp = kmalloc(sizeof(indicators(vcdev)), GFP_DMA | GFP_KERNEL);
 	if (!indicatorp)
 		goto out;
-	*indicatorp = (unsigned long) &vcdev->indicators;
+	*indicatorp = (unsigned long) indicators(vcdev);
 	if (vcdev->is_thinint) {
 		ret = virtio_ccw_register_adapter_ind(vcdev, vqs, nvqs, ccw);
 		if (ret)
@@ -668,21 +678,21 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	}
 	if (!vcdev->is_thinint) {
 		/* Register queue indicators with host. */
-		vcdev->indicators = 0;
+		*indicators(vcdev) = 0;
 		ccw->cmd_code = CCW_CMD_SET_IND;
 		ccw->flags = 0;
-		ccw->count = sizeof(&vcdev->indicators);
+		ccw->count = sizeof(indicators(vcdev));
 		ccw->cda = (__u32)(unsigned long) indicatorp;
 		ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND);
 		if (ret)
 			goto out;
 	}
 	/* Register indicators2 with host for config changes */
-	*indicatorp = (unsigned long) &vcdev->indicators2;
-	vcdev->indicators2 = 0;
+	*indicatorp = (unsigned long) indicators2(vcdev);
+	*indicators2(vcdev) = 0;
 	ccw->cmd_code = CCW_CMD_SET_CONF_IND;
 	ccw->flags = 0;
-	ccw->count = sizeof(&vcdev->indicators2);
+	ccw->count = sizeof(indicators2(vcdev));
 	ccw->cda = (__u32)(unsigned long) indicatorp;
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_CONF_IND);
 	if (ret)
@@ -1092,17 +1102,17 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
-	for_each_set_bit(i, &vcdev->indicators,
-			 sizeof(vcdev->indicators) * BITS_PER_BYTE) {
+	for_each_set_bit(i, indicators(vcdev),
+			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
-		clear_bit(i, &vcdev->indicators);
+		clear_bit(i, indicators(vcdev));
 		barrier();
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
-	if (test_bit(0, &vcdev->indicators2)) {
+	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
-		clear_bit(0, &vcdev->indicators2);
+		clear_bit(0, indicators2(vcdev));
 	}
 }
 
-- 
2.16.4
