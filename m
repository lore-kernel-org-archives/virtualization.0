From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY feature bit to virtio_net
Date: Mon,  7 May 2018 16:09:54 -0700
Message-ID: <1525734594-11134-1-git-send-email-sridhar.samudrala__12877.6696431034$1525734495$gmane$org@intel.com>
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
To: mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

This feature bit can be used by hypervisor to indicate virtio_net device to
act as a standby for another device with the same MAC address.

I tested this with a small change to the patch to mark the STANDBY feature 'true'
by default as i am using libvirt to start the VMs.
Is there a way to pass the newly added feature bit 'standby' to qemu via libvirt
XML file?

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 hw/net/virtio-net.c                         | 2 ++
 include/standard-headers/linux/virtio_net.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 90502fca7c..38b3140670 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
                      true),
     DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
     DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
+    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
+                      false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index e9f255ea3f..01ec09684c 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -57,6 +57,9 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for another device
+                                         * with the same MAC.
+                                         */
 #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
 
 #ifndef VIRTIO_NET_NO_LEGACY
-- 
2.14.3
