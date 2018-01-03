From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: [PATCH net-next 1/2] virtio_net: Introduce VIRTIO_NET_F_MASTER
	feature bit
Date: Tue,  2 Jan 2018 16:35:37 -0800
Message-ID: <1514939738-22423-2-git-send-email-sridhar.samudrala__24721.3405943059$1515606636$gmane$org@intel.com>
References: <1514939738-22423-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1514939738-22423-1-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, stephen@networkplumber.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, sridhar.samudrala@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This feature bit can be used by hypervisor to indicate virtio_net device to
act as a master for a directly attached passthru device with the same MAC
address.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/virtio_net.c        | 3 ++-
 include/uapi/linux/virtio_net.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6fb7b658a6cc..46844a1d9a62 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2796,7 +2796,8 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
-	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
+	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
+	VIRTIO_NET_F_MASTER
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index fc353b518288..a9b4e0836786 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -56,6 +56,7 @@
 #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
+#define VIRTIO_NET_F_MASTER	62	/* act as master for a VF device */
 
 #ifndef VIRTIO_NET_NO_LEGACY
 #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
-- 
2.14.3
