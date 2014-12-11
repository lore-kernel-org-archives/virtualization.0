From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 14/20] s390x/virtio-ccw: enable virtio 1.0
Date: Thu, 11 Dec 2014 14:25:16 +0100
Message-ID: <1418304322-7546-15-git-send-email-cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

virtio-ccw should now have everything in place to operate virtio 1.0
devices, so let's enable revision 1.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/virtio-ccw.h b/hw/s390x/virtio-ccw.h
index 778ccb9..37a9840 100644
--- a/hw/s390x/virtio-ccw.h
+++ b/hw/s390x/virtio-ccw.h
@@ -104,7 +104,7 @@ struct VirtioCcwDevice {
 /* The maximum virtio revision we support. */
 static inline int virtio_ccw_rev_max(VirtioCcwDevice *dev)
 {
-    return 0;
+    return dev->host_features & (1ULL << VIRTIO_F_VERSION_1) ? 1 : 0;
 }
 
 /* virtual css bus type */
-- 
1.7.9.5
