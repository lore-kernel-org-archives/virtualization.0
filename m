From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net V2 1/4] vhost: make sure used idx is seen before log in
	vhost_add_used_n()
Date: Wed, 12 Dec 2018 18:08:16 +0800
Message-ID: <20181212100819.21295-2-jasowang__12591.1369258121$1544609492$gmane$org@redhat.com>
References: <20181212100819.21295-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181212100819.21295-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

We miss a write barrier that guarantees used idx is updated and seen
before log. This will let userspace sync and copy used ring before
used idx is update. Fix this by adding a barrier before log_write().

Fixes: 8dd014adfea6f ("vhost-net: mergeable buffers support")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6b98d8e3a5bf..5915f240275a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2220,6 +2220,8 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 		return -EFAULT;
 	}
 	if (unlikely(vq->log_used)) {
+		/* Make sure used idx is seen before log. */
+		smp_wmb();
 		/* Log used index update. */
 		log_write(vq->log_base,
 			  vq->log_addr + offsetof(struct vring_used, idx),
-- 
2.17.1
