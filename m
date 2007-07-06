From: arnd@arndb.de
Subject: [RFC 2/4] Convert virtio_net to new virtio bus
Date: Fri, 06 Jul 2007 14:42:02 +0200
Message-ID: <20070706125717.630165348@arndb.de>
References: <20070706124200.988637662@arndb.de>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=virtnet-iobus.diff
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This converts the virtio_net driver from Rusty's
draft III implementation to use the generic bus.

Since every device needs to get its MAC address from
somewhere, we read it from the virtio configuration
space. It's up to the virtio host to fill in valid
data here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/drivers/net/virtio_net.c
===================================================================
--- linux-2.6.orig/drivers/net/virtio_net.c
+++ linux-2.6/drivers/net/virtio_net.c
@@ -43,7 +43,7 @@ struct virtnet_info
 
 static bool skb_xmit_done(struct virtio_device *vdev)
 {
-	struct virtnet_info *vi = vdev->priv;
+	struct virtnet_info *vi = vdev->dev.driver_data;
 
 	/* In case we were waiting for output buffers. */
 	netif_wake_queue(vi->ndev);
@@ -100,7 +100,7 @@ static void try_fill_recv(struct virtnet
 
 static bool skb_recv_done(struct virtio_device *vdev)
 {
-	struct virtnet_info *vi = vdev->priv;
+	struct virtnet_info *vi = vdev->dev.driver_data;
 
 	netif_rx_schedule(vi->ndev);
 	/* Suppress further interrupts. */
@@ -217,21 +217,17 @@ static int virtnet_close(struct net_devi
 	return 0;
 }
 
-static struct virtio_driver_ops virtnet_ops = {
-	.in = skb_recv_done,
-	.out = skb_xmit_done,
-};
-
-struct net_device *virtnet_probe(struct virtio_device *vdev,
-				 const u8 mac[ETH_ALEN])
+static int virtnet_probe(struct device *self)
 {
+	struct virtio_device *vdev = to_virtio_dev(self);
+	const u8 *mac = (void *)&vdev->config.driver;
 	int err;
 	struct net_device *dev;
 	struct virtnet_info *vi;
 
 	dev = alloc_etherdev(sizeof(struct virtnet_info));
 	if (!dev)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	SET_MODULE_OWNER(dev);
 
@@ -242,13 +238,12 @@ struct net_device *virtnet_probe(struct 
 	dev->poll = virtnet_poll;
 	dev->hard_start_xmit = start_xmit;
 	dev->weight = 16;
-	SET_NETDEV_DEV(dev, vdev->dev);
+	SET_NETDEV_DEV(dev, &vdev->dev);
 
 	vi = netdev_priv(dev);
 	vi->vdev = vdev;
 	vi->ndev = dev;
-	vdev->priv = vi;
-	vdev->driver_ops = &virtnet_ops;
+	vdev->dev.driver_data = vi;
 	skb_queue_head_init(&vi->recv);
 	skb_queue_head_init(&vi->send);
 
@@ -258,20 +253,49 @@ struct net_device *virtnet_probe(struct 
 		goto free;
 	}
 	pr_debug("virtnet: registered device %s\n", dev->name);
-	return dev;
+	return 0;
 
 free:
 	free_netdev(dev);
-	return ERR_PTR(err);
+	return err;
 }
-EXPORT_SYMBOL_GPL(virtnet_probe);
 
-void virtnet_remove(struct net_device *dev)
+int virtnet_remove(struct device *dev)
 {
-	unregister_netdev(dev);
-	free_netdev(dev);
+	struct virtnet_info *vi = dev->driver_data;
+	unregister_netdev(vi->ndev);
+	free_netdev(vi->ndev);
+	return 0;
+}
+
+static struct virtio_device_id virtnet_device_ids[] = {
+	{ .device_type = "virtnet" },
+	{ },
+};
+
+static struct virtio_driver virtio_net = {
+	.ids = virtnet_device_ids,
+	.drv = {
+		.name = "virtnet",
+		.owner = THIS_MODULE,
+		.probe = virtnet_probe,
+		.remove = virtnet_remove,
+	},
+	.in = skb_recv_done,
+	.out = skb_xmit_done,
+};
+
+static int __init virtnet_init(void)
+{
+	return virtio_driver_register(&virtio_net);
+}
+module_init(virtnet_init);
+
+static void __exit virtnet_exit(void)
+{
+	return virtio_driver_unregister(&virtio_net);
 }
-EXPORT_SYMBOL_GPL(virtnet_remove);
+module_exit(virtnet_exit);
 
 MODULE_DESCRIPTION("Virtio network driver");
 MODULE_LICENSE("GPL");
Index: linux-2.6/include/linux/virtio_net.h
===================================================================
--- linux-2.6.orig/include/linux/virtio_net.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef _LINUX_VIRTIO_NET_H
-#define _LINUX_VIRTIO_NET_H
-#include <linux/types.h>
-#include <linux/etherdevice.h>
-struct net_device;
-struct virtio_device;
-
-struct net_device *virtnet_probe(struct virtio_device *vdev,
-				 const u8 mac[ETH_ALEN]);
-void virtnet_remove(struct net_device *dev);
-
-#endif /* _LINUX_VIRTIO_NET_H */

--
