Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9969C54EAA
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 20:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34E7D82D0F;
	Fri, 27 Jan 2023 20:50:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34E7D82D0F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z0BUrbDJN-oO; Fri, 27 Jan 2023 20:50:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C00D582D0C;
	Fri, 27 Jan 2023 20:50:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C00D582D0C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEE19C007D;
	Fri, 27 Jan 2023 20:50:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A93DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 20:50:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 166528219A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 20:50:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 166528219A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z5VByZl-LAhV
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 20:50:55 +0000 (UTC)
X-Greylist: delayed 00:05:23 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E267282D0F
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E267282D0F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 20:50:54 +0000 (UTC)
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M58OQ-1pKP8G3WNA-0018pB; Fri, 27 Jan 2023 21:45:05 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] virtio_net: disable VIRTIO_NET_F_STANDBY if
 VIRTIO_NET_F_MAC is not set
Date: Fri, 27 Jan 2023 21:44:59 +0100
Message-Id: <20230127204500.51930-2-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127204500.51930-1-lvivier@redhat.com>
References: <20230127204500.51930-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Provags-ID: V03:K1:dDynSjXZJgzJ6rJ90EiWqku5tMQFKKlPs/g0iszfvcj489W0tYY
 M/vXu6qUMHmP17ThNfHhcYYFzfce031ZX/FXDX2fIw3STSTDtsdSwqOe39QsY052PmuEEde
 WJ0jKGPMCZbtNnc6HsuayP4zSzWRJTYtAlbHwoJj+CEsZQv6zSuqnvqpKCrgX7Fz/Cjwc9f
 bKayJwTW1BtSunSJ/1GDQ==
UI-OutboundReport: notjunk:1;M01:P0:2lSz4ud/tes=;xK9JVStCp3XuYx29VCFKWCWUq5q
 sFtTAtkeyvKoNx7cYQzuOxTVeZAOS9w2OQcLJhidziYe8emlEfXbDv31FA16QxSubhdq1Dbnh
 be1IWgnHnHZqU84e4trOGMH1lihFDKMFSImDLtTRvp6UeswM1cqKZfGk3rItAmdKo+fEuCuyZ
 ParbmZK0ZEorwzzXzDq4yzpsuiszbCMbF1JJUggBtktVzKAuVd3CVQdwMpZcBlkRk7uBfpeSe
 UhLf1pDJgA7+SQJhVphmJtlzZ0nOmouWDMn+dTcuyiWboJT30QZfLKqOGQ9klgQdXb3xQIMJv
 Aw3TRhUsQMvkS8hmzDX3NwoAV56R3OkxfinDRwjl8jVXc8ZvaiQHTrrkhNkMGOin6qTu1T+Bl
 sSaQiq1+aDZblkw92K96qL1Bt+kCzw+AZdVsE0Q1bdmkyVJ0Lo/szjBv5RamsckshLUp1hGX4
 0RJNYQBZSFaFXmz2zW96hX03bipnE+UNuWU7GaZ6mgfJ9CyBIA1I+zpAUbb3Elb3fuR1oP5HP
 BzY/cHmZcA05hQwnUsONI3M5RHUEJx3j2E2cl56CGtfGRhD1p/Ldes+Q+0EkYlS3Zh3ve1OyR
 sLLD9P6PISX8kQzsCoVtGEreoauR5ByvvhkLlOX2W15l7BTp/QYnifHOawQudXacic2yuWo7T
 uV3ziv9EK3kB3U21FrXTvBCLdCL6Qndli6ROBLse7Q==
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

failover relies on the MAC address to pair the primary and the standby
devices:

  "[...] the hypervisor needs to enable VIRTIO_NET_F_STANDBY
   feature on the virtio-net interface and assign the same MAC address
   to both virtio-net and VF interfaces."

  Documentation/networking/net_failover.rst

This patch disables the STANDBY feature if the MAC address is not
provided by the hypervisor.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/net/virtio_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7723b2a49d8e..7d700f8e545a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3688,6 +3688,12 @@ static int virtnet_validate(struct virtio_device *vdev)
 			__virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);
 	}
 
+	if (virtio_has_feature(vdev, VIRTIO_NET_F_STANDBY) &&
+	    !virtio_has_feature(vdev, VIRTIO_NET_F_MAC)) {
+		dev_warn(&vdev->dev, "device advertises feature VIRTIO_NET_F_STANDBY but not VIRTIO_NET_F_MAC, disabling standby");
+		__virtio_clear_bit(vdev, VIRTIO_NET_F_STANDBY);
+	}
+
 	return 0;
 }
 
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
