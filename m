From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] virtio_ccw: future-proof finalize_features
Date: Tue, 9 Dec 2014 15:53:34 +0200
Message-ID: <1418133187-12436-2-git-send-email-mst@redhat.com>
References: <1418133187-12436-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418133187-12436-1-git-send-email-mst@redhat.com>
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
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

We never negotiate revision > 1, but just to
make this code more likely to work when we do,
require VERSION_1 with any revision >= 1.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/s390/kvm/virtio_ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index f9f87ba..f92b9e6 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -758,7 +758,7 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 	struct virtio_feature_desc *features;
 	struct ccw1 *ccw;
 
-	if (vcdev->revision == 1 &&
+	if (vcdev->revision >= 1 &&
 	    !__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
 		dev_err(&vdev->dev, "virtio: device uses revision 1 "
 			"but does not have VIRTIO_F_VERSION_1\n");
-- 
MST
