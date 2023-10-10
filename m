Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794B5CD68E3
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 03:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE3CD416C6;
	Tue, 10 Oct 2023 03:11:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE3CD416C6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LynSTlmkoWfP; Tue, 10 Oct 2023 03:11:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3358F4168B;
	Tue, 10 Oct 2023 03:11:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3358F4168B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F551C0039;
	Tue, 10 Oct 2023 03:11:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48F0CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 03:11:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16EC581F47
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 03:11:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 16EC581F47
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2XQUA3jSA8A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 03:11:30 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD9FB81E0C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 03:11:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD9FB81E0C
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0Vtr7VAm_1696907481; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vtr7VAm_1696907481) by smtp.aliyun-inc.com;
 Tue, 10 Oct 2023 11:11:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v3 1/4] virtio: add definition of
 VIRTIO_F_NOTIF_CONFIG_DATA feature bit
Date: Tue, 10 Oct 2023 11:11:17 +0800
Message-Id: <20231010031120.81272-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231010031120.81272-1-xuanzhuo@linux.alibaba.com>
References: <20231010031120.81272-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: e40d16fdf29a
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

This patch adds the definition of VIRTIO_F_NOTIF_CONFIG_DATA feature bit
in the relevant header file.

This feature indicates that the driver uses the data provided by the
device as a virtqueue identifier in available buffer notifications.

It comes from here:
    https://github.com/oasis-tcs/virtio-spec/issues/89

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/uapi/linux/virtio_config.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 2c712c654165..8881aea60f6f 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -105,6 +105,11 @@
  */
 #define VIRTIO_F_NOTIFICATION_DATA	38
 
+/* This feature indicates that the driver uses the data provided by the device
+ * as a virtqueue identifier in available buffer notifications.
+ */
+#define VIRTIO_F_NOTIF_CONFIG_DATA	39
+
 /*
  * This feature indicates that the driver can reset a queue individually.
  */
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
