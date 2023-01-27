Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5172C38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 20:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46B0182D2F;
	Fri, 27 Jan 2023 20:50:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 46B0182D2F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ZP0TFUk6frM; Fri, 27 Jan 2023 20:50:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D5DD08219A;
	Fri, 27 Jan 2023 20:50:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D5DD08219A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BEB58C0032;
	Fri, 27 Jan 2023 20:50:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E970FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 20:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B050D82D14
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 20:50:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B050D82D14
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7p-KdR0gwnBc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 20:50:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A180982D0C
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A180982D0C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 20:50:54 +0000 (UTC)
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MWSJJ-1pBMAk2xND-00XusM; Fri, 27 Jan 2023 21:45:05 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] virtio_net: notify MAC address change on device
 initialization
Date: Fri, 27 Jan 2023 21:45:00 +0100
Message-Id: <20230127204500.51930-3-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127204500.51930-1-lvivier@redhat.com>
References: <20230127204500.51930-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Provags-ID: V03:K1:vDP/sU3WbWB3aipv6spulG2sZ/1/Qx0NRvtEbQ/95jvDYBrgqmv
 ZN3NrtTNEg7/lbeTe7M8RMTYDDBTb50tIFBE5sKC1+dGcykmefRnplHi5Jj2SuoDef9L+k8
 JsT+qgN5H7TdT7yYUGdVrw20FOcRMzLIMrLttqxHXylaSE9B0r6WpmSiZaB3QykOyrbZxc9
 8csVaeU/XH5gJCpVVFPig==
UI-OutboundReport: notjunk:1;M01:P0:6VfygLwysx0=;9x0E10L2BVjqy0ocRSKJGyPERL0
 OqjcbeRcM/0zNxbwEdedpjPtfEw9GNYyChhauUJ7JgOHNQPsSO02aFBFIqjyRiukS1oTrTNtO
 Q42xZpW3eTebApCSq7JKYs4FZSXq9zmjtsWv6rI+l0f5NLBSvWs0SJS2dZzkwvRWG73YcoLPp
 iZNqBxgnfMLs91mJ1NcoXZpwaoDkzE9JCP6QRtRemYRZMvYFtabvSNtueNsyj/q4BI2/vbeQk
 mYDNS4MqpXER4m6IGRc8jHGzsqWomOBTKCpAzeBTQ0Zcy27ruq25FwoCk8yg+gZt6qAG71AJ1
 qixLw8/Ua0lWMezZAZiruodFFH5ghl63jzAJk9Q4g5Hs8JnVPNmfrwLv4wYiFh/hOxaDx6PKv
 609BvKIGBpMJ4E4QwgFdTCFO6O6T3ZAnrxBj8aq72Og84+rI2+QD4g315i6laJN5yaX4M+4lf
 UI2R/Ad3S9+6PUY7z6/Nb0x0cCpuEqoIBqIk20lEnmjnnIoSexkARoJe8x4WwSCJmGyD7g8nf
 nPJpvNuktaDPvlFG/RQJuJ3vSI6HF1aAMJ35wGtbVxArOIlCE7a5EWUFYg8+JQiiROiNFT1M8
 phgqTkY+CIKeAK4H5+quHumTTDyE9H74Lvb7VIo+xIqVx46RMM1DIh4kYq2P/izG6hMTyhDIK
 op7OYs47W4feaVPGPLXl8U5WakUtXhFfgE63VpuAYg==
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org,
 Gautam Dawar <gautam.dawar@xilinx.com>
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
new MAC address has not been provided to the hardware:
RX packets are dropped since they don't go through the receive filters,
TX packets go through unaffected.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/virtio_net.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7d700f8e545a..704a05f1c279 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3806,6 +3806,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 		eth_hw_addr_set(dev, addr);
 	} else {
 		eth_hw_addr_random(dev);
+		dev_info(&vdev->dev, "Assigned random MAC address %pM\n",
+			 dev->dev_addr);
 	}
 
 	/* Set up our device-specific information */
@@ -3933,6 +3935,24 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	/* a random MAC address has been assigned, notify the device.
+	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there
+	 * because many devices work fine without getting MAC explicitly
+	 */
+	if (!virtio_has_feature(vdev, VIRTIO_NET_F_MAC) &&
+	    virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_MAC_ADDR)) {
+		struct scatterlist sg;
+
+		sg_init_one(&sg, dev->dev_addr, dev->addr_len);
+		if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_MAC,
+					  VIRTIO_NET_CTRL_MAC_ADDR_SET, &sg)) {
+			pr_debug("virtio_net: setting MAC address failed\n");
+			rtnl_unlock();
+			err = -EINVAL;
+			goto free_unregister_netdev;
+		}
+	}
+
 	rtnl_unlock();
 
 	err = virtnet_cpu_notif_add(vi);
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
