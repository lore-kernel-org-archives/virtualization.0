From: Asias He <asias@redhat.com>
Subject: [PATCH 2/3] vhost: Move VHOST_NET_FEATURES to net.c
Date: Fri,  3 May 2013 13:34:28 +0800
Message-ID: <1367559269-8325-3-git-send-email-asias__21812.9152934582$1367559316$gmane$org@redhat.com>
References: <1367559269-8325-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367559269-8325-1-git-send-email-asias@redhat.com>
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
index a3645bd..b2f6b41 100644
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
index 4330209..cc9ebf0 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -177,9 +177,6 @@ enum {
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
