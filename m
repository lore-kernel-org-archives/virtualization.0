From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 04/11] s390x/virtio-ccw: fix check for WRITE_FEAT
Date: Tue,  7 Oct 2014 16:40:00 +0200
Message-ID: <1412692807-12398-5-git-send-email-cornelia.huck__37941.4045172327$1412708741$gmane$org@de.ibm.com>
References: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412692807-12398-1-git-send-email-cornelia.huck@de.ibm.com>
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
Cc: thuth@linux.vnet.ibm.com
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
index 8aa79a7..69add47 100644
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
