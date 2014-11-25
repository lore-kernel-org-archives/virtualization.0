From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v2 12/12] s390x/virtio-ccw: enable virtio 1.0
Date: Tue, 25 Nov 2014 14:24:23 +0100
Message-ID: <1416921863-16523-13-git-send-email-cornelia.huck__47274.7660628103$1416922003$gmane$org@de.ibm.com>
References: <1416921863-16523-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1416921863-16523-1-git-send-email-cornelia.huck@de.ibm.com>
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
index 03d5955..08edd8d 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -73,7 +73,7 @@ typedef struct VirtIOCCWDeviceClass {
 #define VIRTIO_CCW_FEATURE_SIZE NR_VIRTIO_FEATURE_WORDS
 
 /* The maximum virtio revision we support. */
-#define VIRTIO_CCW_REV_MAX 0
+#define VIRTIO_CCW_REV_MAX 1
 
 /* Performance improves when virtqueue kick processing is decoupled from the
  * vcpu thread using ioeventfd for some devices. */
-- 
1.7.9.5
