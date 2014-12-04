From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 3/3] virtio_ccw: rev 1 devices set VIRTIO_F_VERSION_1
Date: Thu, 4 Dec 2014 19:26:50 +0200
Message-ID: <1417713984-23771-3-git-send-email-mst@redhat.com>
References: <1417713984-23771-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417713984-23771-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

What does it mean if rev 1 device does not set
VIRTIO_F_VERSION_1? E.g. is it native endian?

Let's not even try to drive such devices:
skip attempts to finalize features or set status.
virtio core will detect this and bail out.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/s390/kvm/virtio_ccw.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 088bdf1..0ceeb25 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -65,6 +65,7 @@ struct virtio_ccw_device {
 	bool is_thinint;
 	bool going_away;
 	bool device_lost;
+	bool features_invalid;
 	void *airq_info;
 };
 
@@ -746,6 +747,12 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 	if (ret == 0)
 		rc |= (u64)le32_to_cpu(features->features) << 32;
 
+	/* Devices MUST set VIRTIO_F_VERSION_1 */
+	if (!(rc & BIT_ULL(VIRTIO_F_VERSION_1))) {
+		vcdev->features_invalid = true;
+		rc |= BIT_ULL(VIRTIO_F_VERSION_1);
+	}
+
 out_free:
 	kfree(features);
 	kfree(ccw);
@@ -758,6 +765,10 @@ static void virtio_ccw_finalize_features(struct virtio_device *vdev)
 	struct virtio_feature_desc *features;
 	struct ccw1 *ccw;
 
+	/* Invalid features? Let's not try to drive this device. */
+	if (vcdev->features_invalid)
+		return;
+
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
 		return;
@@ -869,6 +880,10 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 	struct ccw1 *ccw;
 	int ret;
 
+	/* Invalid features? Let's not try to drive this device. */
+	if (vcdev->features_invalid)
+		return;
+
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
 		return;
-- 
MST
