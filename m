Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B2BC25B4E
	for <virtualization@archiver.kernel.org>; Sun, 22 Jan 2023 10:11:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D7061416E5;
	Sun, 22 Jan 2023 10:11:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D7061416E5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8WFDoGyYvJk7; Sun, 22 Jan 2023 10:11:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 850154163E;
	Sun, 22 Jan 2023 10:11:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 850154163E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34138C0032;
	Sun, 22 Jan 2023 10:11:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84BFCC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5061260E4C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5061260E4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FCxiMWmGwdKT
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:02 +0000 (UTC)
X-Greylist: delayed 00:05:14 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 64CEF60AC1
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64CEF60AC1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 22 Jan 2023 10:11:01 +0000 (UTC)
Received: from lenovo-t14s.redhat.com ([82.142.8.70]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N62mG-1odzFs1dl2-016Sip; Sun, 22 Jan 2023 11:05:32 +0100
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] vdpa_sim_net: don't always set VIRTIO_NET_F_MAC
Date: Sun, 22 Jan 2023 11:05:25 +0100
Message-Id: <20230122100526.2302556-4-lvivier@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230122100526.2302556-1-lvivier@redhat.com>
References: <20230122100526.2302556-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Provags-ID: V03:K1:C0lmlhI9YjKOrifXTYZOHEY7D8bGXsds0Mu6iD7d1jXwqVaA7WL
 sYcBzy078gS83j0QHDpnJctaFKmGZiLCuxb3AA/tfTBL3PRP12tRjCTniZHuigzDnhw/RSg
 zjJVDPHYnTe+K4n9N8dD0jA0kYx8t+SRt+UppkXo1ECIK5buDQUtx5S8U11UY/uLr7Wbis6
 lxctRwls0pgcX4TTRKSBQ==
UI-OutboundReport: notjunk:1;M01:P0:SkQMJ0VWLMQ=;8pPxbPPxVOf4QTbA6I+V2rreoP0
 JRUgz1YUiAylheEVLk+vB5ZUZRwzZsKxwfdlG8eAC9WwcKLYNK0gXW7e6D67ke53sQbPEeRRq
 8ALCMjO3HcNHNRqXuBfWETviSCQkWlSh1BegcuarqvR/imVNHup+a9oHm7bAy8Wh5d+qfimKF
 cgXgUBYqNmycjWE16nyz4+ff8s73iemGWZ/t81gHlA/wosZc83evMN4zOhbu5NswRv2GilV4y
 KWSV5tkIdjwhopiMySWiNC0r1QZ/6hx0F8p25fvg2bQRpvSxsqk7dQiRqIxLVXohmZ54akVsd
 YMeVKk1yPl15KgxGqquZKwgH/sVDFQpjppqSoLRAsDOaHGtCo7b6qTCTptwjxbmXmLXXE0vrP
 zArJolck2kX7LcED84aaBnozO224ep4emI9bryassH+NQmLnsAFKYSLcVpHTc3Z2FZBusZnNi
 3JA8e4Q2dMEkLTfKKhcqnQzCHAQ6uZcr+v9IOdecgytdZeRFSdq6ONpdxbJhckdjYOf0sfyV5
 EWb/swbh7vwyEstVZ+DK8i0t1obpDknBiW1LSKRfH4VFwE1xKuvuzX7KT/MQFMCD+bAhiWiV5
 tlTyxImqTMP56quzpLolFG29jLQ/YKg1dgEYFZ0dWSQnYvoUzLqJA5LQBmIKauI5empmQ3yUa
 y2QIW5Ay/yxJbvAJqu+kdzMuDWc44XXHAMdp6/Z3IA==
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

if vdpa dev command doesn't set a MAC address, don't report
VIRTIO_NET_F_MAC.

As vdpa_sim_net sets VIRTIO_NET_F_MAC without setting the MAC address,
virtio-net doesn't set a random one and the address appears to be the
zero MAC address.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 584b975a98a7..28e858659b85 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -257,6 +257,12 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	dev_attr.work_fn = vdpasim_net_work;
 	dev_attr.buffer_size = PAGE_SIZE;
 
+	/* if vdpa dev doesn't provide a MAC address,
+	 * don't report we have one
+	 */
+	if (!(config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)))
+		dev_attr.supported_features &= ~(1ULL << VIRTIO_NET_F_MAC);
+
 	simdev = vdpasim_create(&dev_attr, config);
 	if (IS_ERR(simdev))
 		return PTR_ERR(simdev);
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
