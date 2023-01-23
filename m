Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40002C05027
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 12:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9A43581F47;
	Mon, 23 Jan 2023 12:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A43581F47
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fNL2k635kbX6; Mon, 23 Jan 2023 12:00:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3385F81A99;
	Mon, 23 Jan 2023 12:00:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3385F81A99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 108B4C0033;
	Mon, 23 Jan 2023 12:00:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF58AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 12:00:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8ACD281A99
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 12:00:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8ACD281A99
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id btjWRALQGenP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 12:00:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E47AE81F1E
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E47AE81F1E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 12:00:43 +0000 (UTC)
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8QNs-1pOJD73y9A-004VEn; Mon, 23 Jan 2023 13:00:26 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] virtio_net: notify MAC address change on device
 initialization
Date: Mon, 23 Jan 2023 13:00:22 +0100
Message-Id: <20230123120022.2364889-2-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230123120022.2364889-1-lvivier@redhat.com>
References: <20230123120022.2364889-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Provags-ID: V03:K1:U0OU6mhChXwxhUWbxTYRcj2Ph4Oul09dobjDl8aQ0FSqEgeTUXd
 jdosvrGb4AtJQz0Df17BbboemEU7njqjKZhWLwC+AKhJ+Fs88CSjBVU7WomS3OXXc4zLCaI
 nmCXrP/uY6BLKx2zrFGAG32xUfOoIJmbWzhQQ1uqMey/0SHyWlWdPe+TxbBil97AylNbX23
 14GYG08545QkHihjYhKQg==
UI-OutboundReport: notjunk:1;M01:P0:qEBdQkGMqCk=;GMabZS3iibKazuhA5ggR/ksGTDv
 lDJPpsnMhCK26MmckF6wd0wv4Wh6CCI2msPvKYVXOOWeG+i2fCQl11Gpiy9PYf6o19EsqvmSz
 fp09Eu2Z0NhlCMyA+9z/jgl8DY9MHi/FdQSSbjj6bOiUe+YeaNvLNVNMyOYFRqMcp14SoklZD
 YdIF1qCJBbD0cyguM6FM9N5tORMLZWqZ8xhEOHpAhcyoiANFONWHzJWy3SgfqwilWwEFNY3/C
 hYMUMxxY7sDBbheynrUF5YJ3CqwsBG9wnyOceg1vnn8TeBpW9/5RH7eajpth3Yq9MaHaPq1po
 xQaIDEhOXvQuC82zL7M4oNH3OaibP1sIr1sOUqn3fqkSX6WGs+8Lh6pDN48E2mA8fyettEMRO
 7iWlcAwbBl68EaKSanOaSp9V4XhClGheziTw0+qHZlbEU0kR77fw13/ldAe4Ray6qua/MmSKy
 B42VUCnvywjSOJTXLkD3QxH7yOHvHsFAr1t28D5rd0+uMskwLT4+4LfAKCvaZDLXrga9PqhSl
 f1TVFYarEwJa5NVyUDbyl9DnQztSXfRSp+3kwivp2JosjxHIY9kfW7jMOz0OgX6hzHqotK+xY
 l8nwWIS9qymjaP/fV1O4rzxEwgzLnrLQeJDEL59rUk3ZZxgtLIUfpgNgerwh5w0phZC32h9hM
 m2UITY6L2AW4PwZex9hfT/giI82eTxQoOnooxK1rew==
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Eli Cohen <elic@nvidia.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

In virtnet_probe(), if the device doesn't provide a MAC address the
driver assigns a random one.
As we modify the MAC address we need to notify the device to allow it
to update all the related information.

The problem can be seen with vDPA and mlx5_vdpa driver as it doesn't
assign a MAC address by default. The virtio_net device uses a random
MAC address (we can see it with "ip link"), but we can't ping a net
namespace from another one using the virtio-vdpa device because the
new MAC address has not been provided to the hardware.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/virtio_net.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7723b2a49d8e..4bdc8286678b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3800,6 +3800,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		eth_hw_addr_set(dev, addr);
 	} else {
 		eth_hw_addr_random(dev);
+		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
+			 dev->dev_addr);
 	}
 
 	/* Set up our device-specific information */
@@ -3956,6 +3958,18 @@ static int virtnet_probe(struct virtio_device *vdev)
 	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
 		 dev->name, max_queue_pairs);
 
+	/* a random MAC address has been assigned, notify the device */
+	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
+	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
+		struct scatterlist sg;
+
+		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
+		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
+					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
+			dev_warn(&vdev->dev, "Failed to update MAC address.\n");
+		}
+	}
+
 	return 0;
 
 free_unregister_netdev:
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
