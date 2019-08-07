From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 07/10] vhost: don't do synchronize_rcu() in
	vhost_uninit_vq_maps()
Date: Wed,  7 Aug 2019 02:54:46 -0400
Message-ID: <20190807065449.23373-8-jasowang__36005.632059981$1565160979$gmane$org@redhat.com>
References: <20190807065449.23373-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190807065449.23373-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
List-Id: virtualization@lists.linuxfoundation.org

There's no need for RCU synchronization in vhost_uninit_vq_maps()
since we've already serialized with readers (memory accessors). This
also avoid the possible userspace DOS through ioctl() because of the
possible high latency caused by synchronize_rcu().

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c12cdadb0855..cfc11f9ed9c9 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -333,7 +333,9 @@ static void vhost_uninit_vq_maps(struct vhost_virtqueue *vq)
 	}
 	spin_unlock(&vq->mmu_lock);
 
-	synchronize_rcu();
+	/* No need for synchronize_rcu() or kfree_rcu() since we are
+	 * serialized with memory accessors (e.g vq mutex held).
+	 */
 
 	for (i = 0; i < VHOST_NUM_ADDRS; i++)
 		if (map[i])
-- 
2.18.1
