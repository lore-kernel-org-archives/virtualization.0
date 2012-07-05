From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] virtio-blk: add back VIRTIO_BLK_F_FLUSH
Date: Thu,  5 Jul 2012 12:08:22 +0200
Message-ID: <1341482902-13318-1-git-send-email-pbonzini@redhat.com>
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
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: levinsasha928@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The old name is part of the userspace API, add it back for compatibility.

Reported-by: Sasha Levin <levinsasha928@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/virtio_blk.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/virtio_blk.h b/include/linux/virtio_blk.h
index 18a1027..83a3116 100644
--- a/include/linux/virtio_blk.h
+++ b/include/linux/virtio_blk.h
@@ -41,6 +41,9 @@
 #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is available */
 #define VIRTIO_BLK_F_CONFIG_WCE	11	/* Writeback mode available in config */
 
+/* Backwards-compatibility #defines for renamed features.  */
+#define VIRTIO_BLK_F_FLUSH	VIRTIO_BLK_F_WCE
+
 #define VIRTIO_BLK_ID_BYTES	20	/* ID string length */
 
 struct virtio_blk_config {
-- 
1.7.1
