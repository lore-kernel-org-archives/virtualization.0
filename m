From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: [PATCH net-next v11 2/5] netvsc: refactor notifier/event handling
	code to use the failover framework
Date: Mon, 21 May 2018 19:06:18 -0700
Message-ID: <1526954781-35359-3-git-send-email-sridhar.samudrala__6018.81081606752$1526954838$gmane$org@intel.com>
References: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1526954781-35359-1-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, sridhar.samudrala@intel.com, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Use the registration/notification framework supported by the generic
failover infrastructure.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 drivers/net/hyperv/Kconfig      |   1 +
 drivers/net/hyperv/hyperv_net.h |   2 +
 drivers/net/hyperv/netvsc_drv.c | 133 +++++++---------------------------------
 3 files changed, 25 insertions(+), 111 deletions(-)

diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
index 0765d5f61714..23a2d145813a 100644
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -2,5 +2,6 @@ config HYPERV_NET
 	tristate "Microsoft Hyper-V virtual network driver"
 	depends on HYPERV
 	select UCS2_STRING
+	select FAILOVER
 	help
 	  Select this option to enable the Hyper-V virtual network driver.
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 1be34d2e3563..99d8e7398a5b 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -932,6 +932,8 @@ struct net_device_context {
 	u32 vf_alloc;
 	/* Serial number of the VF to team with */
 	u32 vf_serial;
+
+	struct failover *failover;
 };
 
 /* Per channel data */
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index da07ccdf84bf..6c77a81b7266 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -43,6 +43,7 @@
 #include <net/pkt_sched.h>
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
+#include <net/failover.h>
 
 #include "hyperv_net.h"
 
@@ -1763,46 +1764,6 @@ static void netvsc_link_change(struct work_struct *w)
 	rtnl_unlock();
 }
 
-static struct net_device *get_netvsc_bymac(const u8 *mac)
-{
-	struct net_device *dev;
-
-	ASSERT_RTNL();
-
-	for_each_netdev(&init_net, dev) {
-		if (dev->netdev_ops != &device_ops)
-			continue;	/* not a netvsc device */
-
-		if (ether_addr_equal(mac, dev->perm_addr))
-			return dev;
-	}
-
-	return NULL;
-}
-
-static struct net_device *get_netvsc_byref(struct net_device *vf_netdev)
-{
-	struct net_device *dev;
-
-	ASSERT_RTNL();
-
-	for_each_netdev(&init_net, dev) {
-		struct net_device_context *net_device_ctx;
-
-		if (dev->netdev_ops != &device_ops)
-			continue;	/* not a netvsc device */
-
-		net_device_ctx = netdev_priv(dev);
-		if (!rtnl_dereference(net_device_ctx->nvdev))
-			continue;	/* device is removed */
-
-		if (rtnl_dereference(net_device_ctx->vf_netdev) == vf_netdev)
-			return dev;	/* a match */
-	}
-
-	return NULL;
-}
-
 /* Called when VF is injecting data into network stack.
  * Change the associated network device from VF to netvsc.
  * note: already called with rcu_read_lock
@@ -1915,24 +1876,15 @@ static void netvsc_vf_setup(struct work_struct *w)
 	rtnl_unlock();
 }
 
-static int netvsc_register_vf(struct net_device *vf_netdev)
+static int netvsc_register_vf(struct net_device *vf_netdev,
+			      struct net_device *ndev)
 {
-	struct net_device *ndev;
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
 
 	if (vf_netdev->addr_len != ETH_ALEN)
 		return NOTIFY_DONE;
 
-	/*
-	 * We will use the MAC address to locate the synthetic interface to
-	 * associate with the VF interface. If we don't find a matching
-	 * synthetic interface, move on.
-	 */
-	ndev = get_netvsc_bymac(vf_netdev->perm_addr);
-	if (!ndev)
-		return NOTIFY_DONE;
-
 	net_device_ctx = netdev_priv(ndev);
 	netvsc_dev = rtnl_dereference(net_device_ctx->nvdev);
 	if (!netvsc_dev || rtnl_dereference(net_device_ctx->vf_netdev))
@@ -1949,17 +1901,13 @@ static int netvsc_register_vf(struct net_device *vf_netdev)
 }
 
 /* VF up/down change detected, schedule to change data path */
-static int netvsc_vf_changed(struct net_device *vf_netdev)
+static int netvsc_vf_changed(struct net_device *vf_netdev,
+			     struct net_device *ndev)
 {
 	struct net_device_context *net_device_ctx;
 	struct netvsc_device *netvsc_dev;
-	struct net_device *ndev;
 	bool vf_is_up = netif_running(vf_netdev);
 
-	ndev = get_netvsc_byref(vf_netdev);
-	if (!ndev)
-		return NOTIFY_DONE;
-
 	net_device_ctx = netdev_priv(ndev);
 	netvsc_dev = rtnl_dereference(net_device_ctx->nvdev);
 	if (!netvsc_dev)
@@ -1972,15 +1920,11 @@ static int netvsc_vf_changed(struct net_device *vf_netdev)
 	return NOTIFY_OK;
 }
 
-static int netvsc_unregister_vf(struct net_device *vf_netdev)
+static int netvsc_unregister_vf(struct net_device *vf_netdev,
+				struct net_device *ndev)
 {
-	struct net_device *ndev;
 	struct net_device_context *net_device_ctx;
 
-	ndev = get_netvsc_byref(vf_netdev);
-	if (!ndev)
-		return NOTIFY_DONE;
-
 	net_device_ctx = netdev_priv(ndev);
 	cancel_delayed_work_sync(&net_device_ctx->vf_takeover);
 
@@ -1994,6 +1938,12 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
 	return NOTIFY_OK;
 }
 
+static struct failover_ops netvsc_failover_ops = {
+	.slave_register		= netvsc_register_vf,
+	.slave_unregister	= netvsc_unregister_vf,
+	.slave_link_change	= netvsc_vf_changed,
+};
+
 static int netvsc_probe(struct hv_device *dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
@@ -2083,8 +2033,14 @@ static int netvsc_probe(struct hv_device *dev,
 		goto register_failed;
 	}
 
+	net_device_ctx->failover = failover_register(net, &netvsc_failover_ops);
+	if (IS_ERR(net_device_ctx->failover))
+		goto err_failover;
+
 	return ret;
 
+err_failover:
+	unregister_netdev(net);
 register_failed:
 	rndis_filter_device_remove(dev, nvdev);
 rndis_failed:
@@ -2125,13 +2081,15 @@ static int netvsc_remove(struct hv_device *dev)
 	rtnl_lock();
 	vf_netdev = rtnl_dereference(ndev_ctx->vf_netdev);
 	if (vf_netdev)
-		netvsc_unregister_vf(vf_netdev);
+		failover_slave_unregister(vf_netdev);
 
 	if (nvdev)
 		rndis_filter_device_remove(dev, nvdev);
 
 	unregister_netdevice(net);
 
+	failover_unregister(ndev_ctx->failover);
+
 	rtnl_unlock();
 	rcu_read_unlock();
 
@@ -2158,54 +2116,8 @@ static struct  hv_driver netvsc_drv = {
 	.remove = netvsc_remove,
 };
 
-/*
- * On Hyper-V, every VF interface is matched with a corresponding
- * synthetic interface. The synthetic interface is presented first
- * to the guest. When the corresponding VF instance is registered,
- * we will take care of switching the data path.
- */
-static int netvsc_netdev_event(struct notifier_block *this,
-			       unsigned long event, void *ptr)
-{
-	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
-
-	/* Skip our own events */
-	if (event_dev->netdev_ops == &device_ops)
-		return NOTIFY_DONE;
-
-	/* Avoid non-Ethernet type devices */
-	if (event_dev->type != ARPHRD_ETHER)
-		return NOTIFY_DONE;
-
-	/* Avoid Vlan dev with same MAC registering as VF */
-	if (is_vlan_dev(event_dev))
-		return NOTIFY_DONE;
-
-	/* Avoid Bonding master dev with same MAC registering as VF */
-	if ((event_dev->priv_flags & IFF_BONDING) &&
-	    (event_dev->flags & IFF_MASTER))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_REGISTER:
-		return netvsc_register_vf(event_dev);
-	case NETDEV_UNREGISTER:
-		return netvsc_unregister_vf(event_dev);
-	case NETDEV_UP:
-	case NETDEV_DOWN:
-		return netvsc_vf_changed(event_dev);
-	default:
-		return NOTIFY_DONE;
-	}
-}
-
-static struct notifier_block netvsc_netdev_notifier = {
-	.notifier_call = netvsc_netdev_event,
-};
-
 static void __exit netvsc_drv_exit(void)
 {
-	unregister_netdevice_notifier(&netvsc_netdev_notifier);
 	vmbus_driver_unregister(&netvsc_drv);
 }
 
@@ -2225,7 +2137,6 @@ static int __init netvsc_drv_init(void)
 	if (ret)
 		return ret;
 
-	register_netdevice_notifier(&netvsc_netdev_notifier);
 	return 0;
 }
 
-- 
2.14.3
