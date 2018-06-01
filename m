From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [PATCH v3] virtio: update the comments for transport features
Date: Fri,  1 Jun 2018 19:26:32 +0800
Message-ID: <20180601112632.12651-1-tiwei.bie__17269.3492648706$1527852286$gmane$org@intel.com>
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
To: mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com, cohuck@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

The existing comments for transport features are outdated.
So update them to address the latest changes in the spec.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
This patch is generated on top of below patch:
https://lists.oasis-open.org/archives/virtio-dev/201805/msg00212.html

v3:
- Fix a typo in the commit message (Cornelia);

v2:
- Improve the comments (Cornelia);
- Improve the commit message;

 include/uapi/linux/virtio_config.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index b7c1f4e7d59e..449132c76b1c 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -45,9 +45,12 @@
 /* We've given up on this device. */
 #define VIRTIO_CONFIG_S_FAILED		0x80
 
-/* Some virtio feature bits (currently bits 28 through 32) are reserved for the
- * transport being used (eg. virtio_ring), the rest are per-device feature
- * bits. */
+/*
+ * Virtio feature bits VIRTIO_TRANSPORT_F_START through
+ * VIRTIO_TRANSPORT_F_END are reserved for the transport
+ * being used (e.g. virtio_ring, virtio_pci etc.), the
+ * rest are per-device feature bits.
+ */
 #define VIRTIO_TRANSPORT_F_START	28
 #define VIRTIO_TRANSPORT_F_END		38
 
-- 
2.17.0
