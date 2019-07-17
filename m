From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 15/15] vhost: enable packed virtqueues
Date: Wed, 17 Jul 2019 06:52:55 -0400
Message-ID: <20190717105255.63488-16-jasowang__39226.2524737575$1563360988$gmane$org@redhat.com>
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

This patch enables packed virtqueue support for vhost.

Testpmd (virtio-user) + vhost_net shows about 2.6% improvemetn on TX
PPS:

Before: 5.75Mpps
After : 5.90Mpps

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index bb3f8bb763b9..5483eea84a5c 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -326,7 +326,8 @@ enum {
 			 (1ULL << VIRTIO_RING_F_EVENT_IDX) |
 			 (1ULL << VHOST_F_LOG_ALL) |
 			 (1ULL << VIRTIO_F_ANY_LAYOUT) |
-			 (1ULL << VIRTIO_F_VERSION_1)
+			 (1ULL << VIRTIO_F_VERSION_1) |
+			 (1ULL << VIRTIO_F_RING_PACKED)
 };
 
 static inline bool vhost_has_feature(struct vhost_virtqueue *vq, int bit)
-- 
2.18.1
