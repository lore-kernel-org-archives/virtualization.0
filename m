From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vhost: fix end of range for access_ok
Date: Mon, 21 Aug 2017 22:45:07 +0300
Message-ID: <1503344576-8141-1-git-send-email-mst__24962.9978010946$1503344735$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, Koichiro Den <den@klaipeden.com>, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

During access_ok checks, addr increases as we iterate over the data
structure, thus addr + len - 1 will point beyond the end of region we
are translating.  Harmless since we then verify that the region covers
addr, but let's not waste cpu cycles.

Reported-by: Koichiro Den <den@klaipeden.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Lightly tested, would appreciate an ack from reporter.

 drivers/vhost/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index e4613a3..ecd70e4 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1176,7 +1176,7 @@ static int iotlb_access_ok(struct vhost_virtqueue *vq,
 {
 	const struct vhost_umem_node *node;
 	struct vhost_umem *umem = vq->iotlb;
-	u64 s = 0, size, orig_addr = addr;
+	u64 s = 0, size, orig_addr = addr, last = addr + len - 1;
 
 	if (vhost_vq_meta_fetch(vq, addr, len, type))
 		return true;
@@ -1184,7 +1184,7 @@ static int iotlb_access_ok(struct vhost_virtqueue *vq,
 	while (len > s) {
 		node = vhost_umem_interval_tree_iter_first(&umem->umem_tree,
 							   addr,
-							   addr + len - 1);
+							   last);
 		if (node == NULL || node->start > addr) {
 			vhost_iotlb_miss(vq, addr, access);
 			return false;
-- 
MST
