Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7848CC77B62
	for <virtualization@archiver.kernel.org>; Tue, 28 Mar 2023 09:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EB8741901;
	Tue, 28 Mar 2023 09:29:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EB8741901
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SuRxm8S9JWlk; Tue, 28 Mar 2023 09:29:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 48C5C4190C;
	Tue, 28 Mar 2023 09:29:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 48C5C4190C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C3E8C008B;
	Tue, 28 Mar 2023 09:29:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E8B5C008F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 115D2611DE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 115D2611DE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yZuDiSbmRN9f
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C22E061190
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C22E061190
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Mar 2023 09:29:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VeseIEJ_1679995744; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeseIEJ_1679995744) by smtp.aliyun-inc.com;
 Tue, 28 Mar 2023 17:29:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 15/16] virtio_net: add APIs to register/unregister virtio
 driver
Date: Tue, 28 Mar 2023 17:28:46 +0800
Message-Id: <20230328092847.91643-16-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: e880b402863c
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

This is prepare for separating vortio-related funcs.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtnet.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/virtnet.c b/drivers/net/virtio/virtnet.c
index 75a74864c3fe..02989cace0fb 100644
--- a/drivers/net/virtio/virtnet.c
+++ b/drivers/net/virtio/virtnet.c
@@ -3146,6 +3146,16 @@ static struct virtio_driver virtio_net_driver = {
 #endif
 };
 
+int virtnet_register_virtio_driver(void)
+{
+	return register_virtio_driver(&virtio_net_driver);
+}
+
+void virtnet_unregister_virtio_driver(void)
+{
+	unregister_virtio_driver(&virtio_net_driver);
+}
+
 static __init int virtio_net_driver_init(void)
 {
 	int ret;
@@ -3154,7 +3164,7 @@ static __init int virtio_net_driver_init(void)
 	if (ret)
 		return ret;
 
-	ret = register_virtio_driver(&virtio_net_driver);
+	ret = virtnet_register_virtio_driver();
 	if (ret) {
 		virtnet_cpuhp_remove();
 		return ret;
@@ -3166,7 +3176,7 @@ module_init(virtio_net_driver_init);
 
 static __exit void virtio_net_driver_exit(void)
 {
-	unregister_virtio_driver(&virtio_net_driver);
+	virtnet_unregister_virtio_driver();
 	virtnet_cpuhp_remove();
 }
 module_exit(virtio_net_driver_exit);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
