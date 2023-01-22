Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AAFC54EAA
	for <virtualization@archiver.kernel.org>; Sun, 22 Jan 2023 10:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 85E2F40153;
	Sun, 22 Jan 2023 10:11:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85E2F40153
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYiFJRHH-RFC; Sun, 22 Jan 2023 10:11:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E8488405A0;
	Sun, 22 Jan 2023 10:11:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8488405A0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AFDEC002D;
	Sun, 22 Jan 2023 10:11:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAF7FC0078
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B2C5281F75
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2C5281F75
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C9HG-4LGmhSf
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A78781F5D
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A78781F5D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:04 +0000 (UTC)
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRVy9-1p53Hj1ciT-00NSmk; Sun, 22 Jan 2023 11:05:30 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] virtio_net: notify MAC address change on device
 initialization
Date: Sun, 22 Jan 2023 11:05:23 +0100
Message-Id: <20230122100526.2302556-2-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230122100526.2302556-1-lvivier@redhat.com>
References: <20230122100526.2302556-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Provags-ID: V03:K1:OvJkQJpHxHaDCPIk3W9i4eIYijK92aR7qOa7YFbWU4FKa/YfJkR
 E/a6z8dxmCPAKztm0ukyh/oHdFFG7zYa7NElzj3pnNbO1BMzo/7IgFa9I1NikV6ZzztbCV3
 E2fJahWqrWBM5gzAUbZWhNFFhiRGzyTdLzqCq6fUs9xJ4pp7Ki6jrCSc0gh3nZNZ5YSb5mm
 D7PIF++SRA45BlYtN3wpw==
UI-OutboundReport: notjunk:1;M01:P0:e2GDlv/Tq3Q=;MNZ+MrUpOuDl9rJiIDNCnKL2keJ
 ypaVzrhPxdSTVqAqADzcFJzLe2j6WoQAal+GcWfv6w0krl8LHR+WDG4zAcH7UvI8JzKg1J4Ch
 xyJnZcJep1bUZO2dt2a7ysP6lHoS/OkhZBBXMiKL2Rx9zWjP7wtCM8TPcYYZ8+hPtlTzGI9be
 AOFpqCTvIviw5KOPKaIVOfDdAgBqcjEiYZiaPKKRLlMkmoBt00SUXgb4OdE7N7pVpb15Vo/12
 RQFT1uropnnEWeNlVCdBgoSsu7tlYILE0B2W2h2KYbymZeE4hPieyFNzbgYcax8l0i+W+74rk
 4vTXes05MJ2KmXsnZ3LuzWgy9lr8c1ddlJNkhMtgmcs/F/Jit7LREno3bZF6ou3EdfqOms9MS
 wskh3xsSUhF3Evr4hhhGQPwynQ64bX9VPX2vqTcykxD9QpOLsf761QXQSjos9pOI+j6KvIJ/g
 AlK+Ya6Mo9G6SFCGmmdMVSQA7/UVK5gB/MUvmaEG8x5J1Pkw69zxUrTWJf7NpjVpkCpSyHgOC
 AgoGx3tFZd6FmRPXuCrDDYRxIgfmAPTghu/UkpZGNfTn+4MrjCQwsaIdMbeqN8T/qAyc2jqE1
 BnhqFd533pYmxopovHxPI39c6jzoT6kNIXGoq1MZky+IBslBnTCVZd4j5/VbKf2YH0hmemVnt
 UpWI7gBjFxThAzgQcDmaRfUCt//70XpkTtzbX4uImw==
Cc: Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eli Cohen <elic@nvidia.com>,
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
new MAC address has not been provided to the hardware.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/virtio_net.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7723b2a49d8e..25511a86590e 100644
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
+	if (dev->addr_assign_type == NET_ADDR_RANDOM &&
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
