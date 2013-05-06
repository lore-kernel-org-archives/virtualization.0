From: Asias He <asias@redhat.com>
Subject: [PATCH v2 02/11] vhost: Move VHOST_NET_FEATURES to net.c
Date: Mon,  6 May 2013 16:38:20 +0800
Message-ID: <1367829509-5371-3-git-send-email-asias__39903.5399583683$1367829558$gmane$org@redhat.com>
References: <1367829509-5371-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367829509-5371-1-git-send-email-asias@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

vhost.h should not depend on device specific marcos like
VHOST_NET_F_VIRTIO_NET_HDR and VIRTIO_NET_F_MRG_RXBUF.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/net.c   | 6 ++++++
 drivers/vhost/vhost.h | 3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 354665a..06b2447 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -59,6 +59,12 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 #define VHOST_DMA_IS_DONE(len) ((len) >= VHOST_DMA_DONE_LEN)
 
 enum {
+	VHOST_NET_FEATURES = VHOST_FEATURES |
+			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
+			 (1ULL << VIRTIO_NET_F_MRG_RXBUF),
+};
+
+enum {
 	VHOST_NET_VQ_RX = 0,
 	VHOST_NET_VQ_TX = 1,
 	VHOST_NET_VQ_MAX = 2,
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 076c9ac..6bf81a9 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -178,9 +178,6 @@ enum {
 			 (1ULL << VIRTIO_RING_F_INDIRECT_DESC) |
 			 (1ULL << VIRTIO_RING_F_EVENT_IDX) |
 			 (1ULL << VHOST_F_LOG_ALL),
-	VHOST_NET_FEATURES = VHOST_FEATURES |
-			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
-			 (1ULL << VIRTIO_NET_F_MRG_RXBUF),
 };
 
 static inline int vhost_has_feature(struct vhost_dev *dev, int bit)
-- 
1.8.1.4
