From: Maciek Fijalkowski <macfij7@wp.pl>
Subject: [PATCH 2/3] Fix ERROR: Macros with complex values should be enclosed
	in parentheses
Date: Sun, 14 May 2017 19:51:29 +0200
Message-ID: <20170514175130.18664-2-macfij7__36817.1554561288$1494947314$gmane$org@wp.pl>
References: <20170514175130.18664-1-macfij7@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170514175130.18664-1-macfij7@wp.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: Maciej Fijalkowski <macfij7@wp.pl>, jasonwang@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Maciej Fijalkowski <macfij7@wp.pl>

Signed-off-by: Maciej Fijalkowski <macfij7@wp.pl>
---
 drivers/net/virtio_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f20dfb8..6c8170c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2663,7 +2663,7 @@ static struct virtio_device_id id_table[] = {
 };
 
 #define VIRTNET_FEATURES \
-	VIRTIO_NET_F_CSUM, VIRTIO_NET_F_GUEST_CSUM, \
+	(VIRTIO_NET_F_CSUM, VIRTIO_NET_F_GUEST_CSUM, \
 	VIRTIO_NET_F_MAC, \
 	VIRTIO_NET_F_HOST_TSO4, VIRTIO_NET_F_HOST_UFO, VIRTIO_NET_F_HOST_TSO6, \
 	VIRTIO_NET_F_HOST_ECN, VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6, \
@@ -2672,7 +2672,7 @@ static struct virtio_device_id id_table[] = {
 	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
 	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
 	VIRTIO_NET_F_CTRL_MAC_ADDR, \
-	VIRTIO_NET_F_MTU
+	VIRTIO_NET_F_MTU)
 
 static unsigned int features[] = {
 	VIRTNET_FEATURES,
-- 
2.4.11
