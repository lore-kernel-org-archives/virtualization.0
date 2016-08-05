From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH for-4.8] virtio-vsock: fix include guard typo
Date: Fri,  5 Aug 2016 13:52:09 +0100
Message-ID: <1470401529-28288-1-git-send-email-stefanha@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/uapi/linux/virtio_vsock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 6b011c1..1d57ed3 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -32,7 +32,7 @@
  */
 
 #ifndef _UAPI_LINUX_VIRTIO_VSOCK_H
-#define _UAPI_LINUX_VIRTIO_VOSCK_H
+#define _UAPI_LINUX_VIRTIO_VSOCK_H
 
 #include <linux/types.h>
 #include <linux/virtio_ids.h>
-- 
2.7.4
