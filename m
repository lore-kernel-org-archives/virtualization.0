From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: [PATCH net-next v10 1/4] virtio_net: Introduce VIRTIO_NET_F_STANDBY
	feature bit
Date: Mon,  7 May 2018 15:10:43 -0700
Message-ID: <1525731046-10989-2-git-send-email-sridhar.samudrala__25382.0798396648$1525730942$gmane$org@intel.com>
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This feature bit can be used by hypervisor to indicate virtio_net device to
act as a standby for another device with the same MAC address.

VIRTIO_NET_F_STANDBY is defined as bit 62 as it is a device feature bit.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/virtio_net.c        | 2 +-
 include/uapi/linux/virtio_net.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f34794a76c4d..213fddc70fd0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2999,7 +2999,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
 	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
-	VIRTIO_NET_F_SPEED_DUPLEX
+	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
index 5de6ed37695b..a3715a3224c1 100644
--- a/include/uapi/linux/virtio_net.h
+++ b/include/uapi/linux/virtio_net.h
@@ -57,6 +57,9 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
+					 * with the same MAC.
+					 */
 #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
 
 #ifndef VIRTIO_NET_NO_LEGACY
-- 
2.14.3
