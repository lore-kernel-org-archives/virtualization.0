From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 2/2] s390x/virtio-ccw: set revision 2 as maximum revision
	number
Date: Fri, 11 Sep 2015 15:58:15 +0200
Message-ID: <1441979895-36990-3-git-send-email-cornelia.huck__5956.57808376036$1441979947$gmane$org@de.ibm.com>
References: <1441979895-36990-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1441979895-36990-1-git-send-email-cornelia.huck@de.ibm.com>
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
index 453fdf7..da07bfa 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -104,7 +104,7 @@ struct VirtioCcwDevice {
 };
 
 /* The maximum virtio revision we support. */
-#define VIRTIO_CCW_MAX_REV 1
+#define VIRTIO_CCW_MAX_REV 2
 static inline int virtio_ccw_rev_max(VirtioCcwDevice *dev)
 {
     return dev->max_rev;
-- 
2.3.8
