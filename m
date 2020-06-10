From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v7 08/14] fixup! vhost: use batched get_vq_desc version
Date: Wed, 10 Jun 2020 07:36:16 -0400
Message-ID: <20200610113515.1497099-9-mst@redhat.com>
References: <20200610113515.1497099-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200610113515.1497099-1-mst@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, eperezma@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

---
 drivers/vhost/vhost.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 7a587b13095c..03e6bca02288 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2205,10 +2205,6 @@ static int fetch_buf(struct vhost_virtqueue *vq)
 	last_avail_idx = vq->last_avail_idx;
 
 	if (unlikely(vq->avail_idx == vq->last_avail_idx)) {
-		/* If we already have work to do, don't bother re-checking. */
-		if (likely(vq->ndescs))
-			return 1;
-
 		if (unlikely(vhost_get_avail_idx(vq, &avail_idx))) {
 			vq_err(vq, "Failed to access avail idx at %p\n",
 				&vq->avail->idx);
-- 
MST
