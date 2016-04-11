From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/2] s390x/virtio-ccw: set revision 2 as maximum revision
	number
Date: Mon, 11 Apr 2016 13:23:24 +0200
Message-ID: <1460373804-43477-3-git-send-email-cornelia.huck__3166.68502423472$1460373835$gmane$org@de.ibm.com>
References: <1460373804-43477-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1460373804-43477-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

We have everything needed for virtio-ccw revision 2 wired up now. Bump
the maximum supported revision reported to the guest so they can make
use of it.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 6bc14ee..46b5ee6 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -97,7 +97,7 @@ struct VirtioCcwDevice {
 };
 
 /* The maximum virtio revision we support. */
-#define VIRTIO_CCW_MAX_REV 1
+#define VIRTIO_CCW_MAX_REV 2
 static inline int virtio_ccw_rev_max(VirtioCcwDevice *dev)
 {
     return dev->max_rev;
-- 
2.6.6
