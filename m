From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 29/50] vhost: make features 64 bit
Date: Mon, 1 Dec 2014 18:05:09 +0200
Message-ID: <1417449619-24896-30-git-send-email-mst__28899.7889067561$1417449997$gmane$org@redhat.com>
References: <1417449619-24896-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417449619-24896-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, rusty@au1.ibm.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, kvm@vger.kernel.org, pbonzini@redhat.com, Ben Hutchings <ben@decadent.org.uk>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

We need to use bit 32 for virtio 1.0.
Make vhost_has_feature bool to avoid discarding high bits.

Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 3eda654..55a95c9 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -106,7 +106,7 @@ struct vhost_virtqueue {
 	/* Protected by virtqueue mutex. */
 	struct vhost_memory *memory;
 	void *private_data;
-	unsigned acked_features;
+	u64 acked_features;
 	/* Log write descriptors */
 	void __user *log_base;
 	struct vhost_log *log;
@@ -172,8 +172,8 @@ enum {
 			 (1ULL << VHOST_F_LOG_ALL),
 };
 
-static inline int vhost_has_feature(struct vhost_virtqueue *vq, int bit)
+static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int bit)
 {
-	return vq->acked_features & (1 << bit);
+	return vq->acked_features & (1ULL << bit);
 }
 #endif
-- 
MST
