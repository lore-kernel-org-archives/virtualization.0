Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CDAC07E96
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:45:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDE4606A5
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDE4606A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63E93406A4;
	Wed, 14 Jul 2021 02:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oZeD1BBg4SII; Wed, 14 Jul 2021 02:45:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B6D93406AA;
	Wed, 14 Jul 2021 02:45:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B7ABC0020;
	Wed, 14 Jul 2021 02:45:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7344C0010
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9B9883AEF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nv5rBHJxKLfh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:45:06 +0000 (UTC)
X-Greylist: delayed 00:16:00 by SQLgrey-1.8.0
Received: from baidu.com (usmx01.baidu.com [12.0.243.41])
 by smtp1.osuosl.org (Postfix) with ESMTP id E43D282FA2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:45:06 +0000 (UTC)
Received: from BC-Mail-HQEx02.internal.baidu.com (unknown [172.31.51.58])
 by Forcepoint Email with ESMTPS id 482C4258739D676063E3;
 Tue, 13 Jul 2021 19:29:07 -0700 (PDT)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEx02.internal.baidu.com (172.31.51.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.10; Wed, 14 Jul 2021 10:29:05 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Wed, 14 Jul 2021 10:29:04 +0800
From: Cai Huoqing <caihuoqing@baidu.com>
To: <sgarzare@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>
Subject: [PATCH 1/2] virtio_ring: fix error - unknown type name 'spinlock_t'
Date: Wed, 14 Jul 2021 10:28:53 +0800
Message-ID: <20210714022854.1077-2-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714022854.1077-1-caihuoqing@baidu.com>
References: <20210714022854.1077-1-caihuoqing@baidu.com>
MIME-Version: 1.0
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex16.internal.baidu.com (10.127.64.39) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

when run "make virtio" in linux/tools,
the error: unknown type name 'spinlock_t' occurs

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 include/linux/vringh.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/vringh.h b/include/linux/vringh.h
index 84db7b8f912f..ff21c2643792 100644
--- a/include/linux/vringh.h
+++ b/include/linux/vringh.h
@@ -43,11 +43,13 @@ struct vringh {
        /* The vring (note: it may contain user pointers!) */
        struct vring vring;

+#if IS_REACHABLE(CONFIG_VHOST_IOTLB)
        /* IOTLB for this vring */
        struct vhost_iotlb *iotlb;

        /* spinlock to synchronize IOTLB accesses */
        spinlock_t *iotlb_lock;
+#endif

        /* The function to call to notify the guest about added buffers */
        void (*notify)(struct vringh *);
--
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
