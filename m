From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: [RFC PATCH 1/1] qemu: Introduce VIRTIO_NET_F_BACKUP feature bit to
	virtio_net
Date: Thu, 11 Jan 2018 21:58:40 -0800
Message-ID: <1515736720-39368-4-git-send-email-sridhar.samudrala__21671.9488417313$1515736637$gmane$org@intel.com>
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This feature bit can be used by hypervisor to indicate virtio_net device to
act as a backup for another device with the same MAC address.
    
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index cd63659140..fa47e723b9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2193,6 +2193,8 @@ static Property virtio_net_properties[] = {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_BIT64("backup", VirtIONet, host_features,
+                    VIRTIO_NET_F_BACKUP, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 17c8531a22..6afca6dcaf 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -57,6 +57,9 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_BACKUP	  62   /* Act as backup for another device
+					* with the same MAC.
+					*/
 #define VIRTIO_NET_F_SPEED_DUPLEX 63   /* Device set linkspeed and duplex */
 
 #ifndef VIRTIO_NET_NO_LEGACY
