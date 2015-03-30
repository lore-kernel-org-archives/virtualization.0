From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/6] virtio_ccw: support non-legacy balloon devices
Date: Mon, 30 Mar 2015 19:37:18 +0200
Message-ID: <1427737006-23191-4-git-send-email-mst__10707.7005239718$1427737095$gmane$org@redhat.com>
References: <1427737006-23191-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1427737006-23191-1-git-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

virtio_device_is_legacy_only is always false now,
drop the test from virtio ccw.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/s390/kvm/virtio_ccw.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 71d7802..6f1fa17 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -1201,13 +1201,9 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	vcdev->vdev.id.vendor = cdev->id.cu_type;
 	vcdev->vdev.id.device = cdev->id.cu_model;
 
-	if (virtio_device_is_legacy_only(vcdev->vdev.id)) {
-		vcdev->revision = 0;
-	} else {
-		ret = virtio_ccw_set_transport_rev(vcdev);
-		if (ret)
-			goto out_free;
-	}
+	ret = virtio_ccw_set_transport_rev(vcdev);
+	if (ret)
+		goto out_free;
 
 	ret = register_virtio_device(&vcdev->vdev);
 	if (ret) {
-- 
MST
