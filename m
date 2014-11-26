From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v3 04/12] s390x/virtio-ccw: fix check for WRITE_FEAT
Date: Wed, 26 Nov 2014 18:28:35 +0100
Message-ID: <1417022923-1654-5-git-send-email-cornelia.huck@de.ibm.com>
References: <1417022923-1654-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417022923-1654-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

We need to check guest feature size, not host feature size to find
out whether we should call virtio_set_features(). This check is
possible now that vdev->guest_features is an array.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 2f52b82..62ec852 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -399,7 +399,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             features.index = ldub_phys(&address_space_memory,
                                        ccw.cda + sizeof(features.features));
             features.features = ldl_le_phys(&address_space_memory, ccw.cda);
-            if (features.index < ARRAY_SIZE(dev->host_features)) {
+            if (features.index < ARRAY_SIZE(vdev->guest_features)) {
                 virtio_set_features(vdev, features.index, features.features);
             } else {
                 /*
-- 
1.7.9.5
