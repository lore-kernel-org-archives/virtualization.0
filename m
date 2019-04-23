From: Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH V3 1/6] vhost: generalize adding used elem
Date: Tue, 23 Apr 2019 01:54:15 -0400
Message-ID: <20190423055420.26408-2-jasowang__45053.9077793778$1555998895$gmane$org@redhat.com>
References: <20190423055420.26408-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190423055420.26408-1-jasowang@redhat.com>
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
Cc: aarcange@redhat.com, hch@infradead.org, christophe.de.dinechin@gmail.com, linux-parisc@vger.kernel.org, James.Bottomley@hansenpartnership.com, linux-mm@kvack.org, jglisse@redhat.com, jrdr.linux@gmail.com, davem@davemloft.net, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

Use one generic vhost_copy_to_user() instead of two dedicated
accessor. This will simplify the conversion to fine grain
accessors. About 2% improvement of PPS were seen during vitio-user
txonly test.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 351af88231ad..6df76ac8200a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2255,16 +2255,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 
 	start = vq->last_used_idx & (vq->num - 1);
 	used = vq->used->ring + start;
-	if (count == 1) {
-		if (vhost_put_user(vq, heads[0].id, &used->id)) {
-			vq_err(vq, "Failed to write used id");
-			return -EFAULT;
-		}
-		if (vhost_put_user(vq, heads[0].len, &used->len)) {
-			vq_err(vq, "Failed to write used len");
-			return -EFAULT;
-		}
-	} else if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
+	if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
 		vq_err(vq, "Failed to write used");
 		return -EFAULT;
 	}
-- 
2.18.1
