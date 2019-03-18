From: Peter Xu <peterx@redhat.com>
Subject: [PATCH] virtio_net: remove hcpu from virtnet_clean_affinity
Date: Mon, 18 Mar 2019 14:56:06 +0800
Message-ID: <20190318065606.17100-1-peterx__9823.55857720307$1552892219$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The variable is never used.

CC: Michael S. Tsirkin <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: virtualization@lists.linux-foundation.org
CC: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/net/virtio_net.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7eb38ea9ba56..1b03c4b6ebff 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1925,7 +1925,7 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
 	return 0;
 }
 
-static void virtnet_clean_affinity(struct virtnet_info *vi, long hcpu)
+static void virtnet_clean_affinity(struct virtnet_info *vi)
 {
 	int i;
 
@@ -1949,7 +1949,7 @@ static void virtnet_set_affinity(struct virtnet_info *vi)
 	int stride;
 
 	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
-		virtnet_clean_affinity(vi, -1);
+		virtnet_clean_affinity(vi);
 		return;
 	}
 
@@ -1999,7 +1999,7 @@ static int virtnet_cpu_down_prep(unsigned int cpu, struct hlist_node *node)
 	struct virtnet_info *vi = hlist_entry_safe(node, struct virtnet_info,
 						   node);
 
-	virtnet_clean_affinity(vi, cpu);
+	virtnet_clean_affinity(vi);
 	return 0;
 }
 
@@ -2735,7 +2735,7 @@ static void virtnet_del_vqs(struct virtnet_info *vi)
 {
 	struct virtio_device *vdev = vi->vdev;
 
-	virtnet_clean_affinity(vi, -1);
+	virtnet_clean_affinity(vi);
 
 	vdev->config->del_vqs(vdev);
 
-- 
2.17.1
