Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635A2C38142
	for <virtualization@archiver.kernel.org>; Sun, 22 Jan 2023 10:11:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEBB660E5C;
	Sun, 22 Jan 2023 10:11:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DEBB660E5C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlbYBcZDxnDQ; Sun, 22 Jan 2023 10:11:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 85E0A60E3D;
	Sun, 22 Jan 2023 10:11:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85E0A60E3D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62506C0032;
	Sun, 22 Jan 2023 10:11:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3230C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4FD2841745
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4FD2841745
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tPkJRYibGjwC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:03 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 501AA415DD
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 501AA415DD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:03 +0000 (UTC)
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mv3M8-1oSwdn1I24-00r0FP; Sun, 22 Jan 2023 11:05:31 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] virtio_net: add a timeout in virtnet_send_command()
Date: Sun, 22 Jan 2023 11:05:24 +0100
Message-Id: <20230122100526.2302556-3-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230122100526.2302556-1-lvivier@redhat.com>
References: <20230122100526.2302556-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Provags-ID: V03:K1:Q/I/cga4nZOLWJZ6626JLw2DTN8BqDTEy/TTN7AmLPPbAvv4s/x
 3Mb+7W/tWh2hPzaySdoOxxbH2k0Iq67YvdoSX7Dy/+p2/8WeDpQc94lfaAGKtjv1tyBixOT
 y23u7MmcoQ0e7tZLyBsqOQfI0xHlC5Abzxl7uPydBZiPyOdJhnFQarIJhyt9uTi0wD/VXiK
 DrR/t3vOSm/bCjw6SHx7w==
UI-OutboundReport: notjunk:1;M01:P0:F4ttttqsL4U=;/iW2ogV/MkMxMhKGFzp/w0JZbh8
 FsSA7MIyUDyaiWvAeE+NtLmvaVf1kQ2n2phdf6bMy2uOeepdLbtsHq0cVfRgN8AF5/WqBPhyS
 3HD8AXIMODQZTn4nMgfQ8X/n0Jy4k70iYhyzcpsxb340AwV2EwxfuylPwJkslwv7Q5ZqlCg6V
 mWek9OkHybWhgp+rwgrffS43tvTRjZkrVM/YWR/MRDL2yipBcRmI7pO79jAVo/VvPioz9+2On
 K4l0n81Tv6gHjbamAgMoqORCPMzMi+UbyzVSAJ5mLoitzEANV/CaxJvW0To9ul50+apWAGlry
 Ch2dH4iiJU5MOQYYeqG+n1TWP5TbmROgUwIpqm25Lc54/ezewBKxvHDbayI/qOV1dAPSZRMvY
 TrNwjhrRqDXKpas8n5bqevaakZ1PpJ3woVo60j2ruCdifBOI1kbCHG5RyoZesXRIiA7FGTJlH
 N4b/0eFHuIN5jpvM6deGJ8NlgEaq8b414Zk/ua2raNAQ7kuTpVAO8g7/xn9ZdzjtkCezcBeTA
 tuDgbPjij4Hu9Uqyd3dz9o9YP/aJW4kC9Wwcox8878Ou/hyNXM28HS6AH3FeU4t/39hQ3hacR
 LkanHyHRL3Oqzvnhm95QooiSB04b6ejmecst2urI3xyYnPlBY4TMTSfpMpOBFCXTHBqEMWTK6
 kWqrV8zeMGCumdTMqFkk3AIlrIulDY0uB7ZjF2NqNQ==
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

if the device control queue is buggy, don't crash the kernel by
waiting for ever the response.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 25511a86590e..29b3cc72082d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1974,6 +1974,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	struct scatterlist *sgs[4], hdr, stat;
 	unsigned out_num = 0, tmp;
 	int ret;
+	unsigned long timeout;
 
 	/* Caller should know better */
 	BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
@@ -2006,8 +2007,10 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
 	/* Spin for a response, the kick causes an ioport write, trapping
 	 * into the hypervisor, so the request should be handled immediately.
 	 */
+	timeout = jiffies + 20 * HZ;
 	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
-	       !virtqueue_is_broken(vi->cvq))
+	       !virtqueue_is_broken(vi->cvq) &&
+	       !time_after(jiffies, timeout))
 		cpu_relax();
 
 	return vi->ctrl->status == VIRTIO_NET_OK;
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
