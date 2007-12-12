From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio_net: remove double ether_setup
Date: Wed, 12 Dec 2007 08:34:06 +0100
Message-ID: <200712120834.06281.borntraeger@de.ibm.com>
References: <200712111238.53960.borntraeger@de.ibm.com> <200712121241.48226.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <200712121241.48226.rusty@rustcorp.com.au>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.osdl.org, kvm-devel@lists.sourceforge.net, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch, 12. Dezember 2007 schrieb Rusty Russell:
> Can you send straight to akpm or davem?  I'm supposed to be on vacation at 

this is a small fix for virtio_net.
virtnet_probe already calls alloc_etherdev, which calls ether_setup.
There is no need to do that again.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |    1 -
 1 file changed, 1 deletion(-)

Index: kvm/drivers/net/virtio_net.c
===================================================================
--- kvm.orig/drivers/net/virtio_net.c
+++ kvm/drivers/net/virtio_net.c
@@ -329,11 +329,10 @@ static int virtnet_probe(struct virtio_d
 	dev = alloc_etherdev(sizeof(struct virtnet_info));
 	if (!dev)
 		return -ENOMEM;
 
 	/* Set up network device as normal. */
-	ether_setup(dev);
 	dev->open = virtnet_open;
 	dev->stop = virtnet_close;
 	dev->hard_start_xmit = start_xmit;
 	dev->features = NETIF_F_HIGHDMA;
 	SET_NETDEV_DEV(dev, &vdev->dev);


