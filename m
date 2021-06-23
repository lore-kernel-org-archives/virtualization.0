Return-Path: <SRS0=2EET=LR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B0C4743C
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 07:33:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941C6611AC
	for <virtualization@archiver.kernel.org>; Wed, 23 Jun 2021 07:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941C6611AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40279403DB;
	Wed, 23 Jun 2021 07:33:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zZZH-RW6ZUCE; Wed, 23 Jun 2021 07:33:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C2E3C402E5;
	Wed, 23 Jun 2021 07:33:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72BDCC0010;
	Wed, 23 Jun 2021 07:33:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80F2CC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 07:33:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 575DB402EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 07:33:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EXYtW3q_U6lC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 07:32:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from baidu.com (mx21.baidu.com [220.181.3.85])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2F63402E5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Jun 2021 07:32:58 +0000 (UTC)
Received: from BJHW-Mail-Ex09.internal.baidu.com (unknown [10.127.64.32])
 by Forcepoint Email with ESMTPS id 27950A13896BCEE60EDB;
 Wed, 23 Jun 2021 15:32:52 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex09.internal.baidu.com (10.127.64.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Wed, 23 Jun 2021 15:32:52 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Wed, 23 Jun 2021 15:32:51 +0800
From: Cai Huoqing <caihuoqing@baidu.com>
To: <mst@redhat.com>, <jasowang@redhat.com>, <davem@davemloft.net>,
 <kuba@kernel.org>
Subject: [PATCH] add "else {...}" according coding style
Date: Wed, 23 Jun 2021 15:32:43 +0800
Message-ID: <20210623073243.876-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex16.internal.baidu.com (172.31.51.56) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex09_2021-06-23 15:32:52:172
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

coding-style.rst shows that:
        if (condition) {
                do_this();
                do_that();
        } else {
                otherwise();
        }

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/net/virtio_net.c | 3 ++-
 drivers/vhost/vringh.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 21ff7b9e49c2..7cd062cb468e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -314,8 +314,9 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
                rq->pages = (struct page *)p->private;
                /* clear private here, it is used to chain pages */
                p->private = 0;
-       } else
+       } else {
                p = alloc_page(gfp_mask);
+       }
        return p;
 }

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 4af8fa259d65..79542cad1072 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -454,8 +454,9 @@ static inline int __vringh_complete(struct vringh *vrh,
                if (!err)
                        err = putused(vrh, &used_ring->ring[0], used + part,
                                      num_used - part);
-       } else
+       } else {
                err = putused(vrh, &used_ring->ring[off], used, num_used);
+       }

        if (err) {
                vringh_bad("Failed to write %u used entries %u at %p",
--
2.17.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
