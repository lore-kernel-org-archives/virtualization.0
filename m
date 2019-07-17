From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 12/15] vhost: vhost_put_user() can accept metadata type
Date: Wed, 17 Jul 2019 06:52:52 -0400
Message-ID: <20190717105255.63488-13-jasowang__27892.1598963038$1563360936$gmane$org@redhat.com>
References: <20190717105255.63488-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717105255.63488-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

We assumes used ring update is the only user for vhost_put_user() in
the past. This may not be the case for the incoming packed ring which
may update the descriptor ring for used. So introduce a new type
parameter.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6044cdea124f..3fa1adf2cb90 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1178,7 +1178,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	return __vhost_get_user_slow(vq, addr, size, type);
 }
 
-#define vhost_put_user(vq, x, ptr)		\
+#define vhost_put_user(vq, x, ptr, type)		\
 ({ \
 	int ret = -EFAULT; \
 	if (!vq->iotlb) { \
@@ -1186,7 +1186,7 @@ static inline void __user *__vhost_get_user(struct vhost_virtqueue *vq,
 	} else { \
 		__typeof__(ptr) to = \
 			(__typeof__(ptr)) __vhost_get_user(vq, ptr,	\
-					  sizeof(*ptr), VHOST_ADDR_USED); \
+					  sizeof(*ptr), type); \
 		if (to != NULL) \
 			ret = __put_user(x, to); \
 		else \
@@ -1230,7 +1230,7 @@ static inline int vhost_put_avail_event(struct vhost_virtqueue *vq)
 #endif
 
 	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->avail_idx),
-			      vhost_avail_event(vq));
+			      vhost_avail_event(vq), VHOST_ADDR_USED);
 }
 
 static inline int vhost_put_used(struct vhost_virtqueue *vq,
@@ -1267,7 +1267,7 @@ static inline int vhost_put_used_flags(struct vhost_virtqueue *vq)
 #endif
 
 	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->used_flags),
-			      &vq->used->flags);
+			      &vq->used->flags, VHOST_ADDR_USED);
 }
 
 static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
@@ -1284,7 +1284,7 @@ static inline int vhost_put_used_idx(struct vhost_virtqueue *vq)
 #endif
 
 	return vhost_put_user(vq, cpu_to_vhost16(vq, vq->last_used_idx),
-			      &vq->used->idx);
+			      &vq->used->idx, VHOST_ADDR_USED);
 }
 
 #define vhost_get_user(vq, x, ptr, type)		\
-- 
2.18.1
