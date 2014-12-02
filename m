From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v5 14/19] s390x/virtio-ccw: enable virtio 1.0
Date: Tue,  2 Dec 2014 14:00:22 +0100
Message-ID: <1417525227-14051-15-git-send-email-cornelia.huck__659.505200064991$1417525417$gmane$org@de.ibm.com>
References: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417525227-14051-1-git-send-email-cornelia.huck@de.ibm.com>
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

virtio-ccw should now have everything in place to operate virtio 1.0
devices, so let's enable revision 1.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index fe5c782..d40e3be 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -70,7 +70,7 @@ typedef struct VirtIOCCWDeviceClass {
 } VirtIOCCWDeviceClass;
 
 /* The maximum virtio revision we support. */
-#define VIRTIO_CCW_REV_MAX 0
+#define VIRTIO_CCW_REV_MAX 1
 
 /* Performance improves when virtqueue kick processing is decoupled from the
  * vcpu thread using ioeventfd for some devices. */
-- 
1.7.9.5
