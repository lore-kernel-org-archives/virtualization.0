Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7A8C11F66
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:45:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAEE61370
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 02:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAEE61370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E79A460905;
	Wed, 14 Jul 2021 02:45:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZveUFv8ZuJh3; Wed, 14 Jul 2021 02:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8973D60A57;
	Wed, 14 Jul 2021 02:45:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60994C0010;
	Wed, 14 Jul 2021 02:45:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFB3DC001C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:45:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCEB382FA2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jonjOc_QTich
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:45:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from baidu.com (usmx01.baidu.com [12.0.243.41])
 by smtp1.osuosl.org (Postfix) with ESMTP id E90C183A5C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 02:45:06 +0000 (UTC)
Received: from BC-Mail-HQEX01.internal.baidu.com (unknown [172.31.51.57])
 by Forcepoint Email with ESMTPS id BC7D8C3915508456CFA2;
 Tue, 13 Jul 2021 19:29:09 -0700 (PDT)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-HQEX01.internal.baidu.com (172.31.51.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.10; Wed, 14 Jul 2021 10:29:07 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Wed, 14 Jul 2021 10:29:07 +0800
From: Cai Huoqing <caihuoqing@baidu.com>
To: <sgarzare@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>
Subject: [PATCH 2/2] virtio_ring: fix error - 'prev' and 'head_flags' may be
 used uninitialized in this function
Date: Wed, 14 Jul 2021 10:28:54 +0800
Message-ID: <20210714022854.1077-3-caihuoqing@baidu.com>
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
the error: "'prev' and 'head_flags' may be used
uninitialized in this function" occurs

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/virtio/virtio_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 89bfe46a8a7f..290bdf8a3d36 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -486,7 +486,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
        struct vring_virtqueue *vq = to_vvq(_vq);
        struct scatterlist *sg;
        struct vring_desc *desc;
-       unsigned int i, n, avail, descs_used, prev, err_idx;
+       unsigned int i, n, avail, descs_used, prev = 0, err_idx;
        int head;
        bool indirect;

@@ -1173,8 +1173,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
        struct vring_packed_desc *desc;
        struct scatterlist *sg;
        unsigned int i, n, c, descs_used, err_idx;
-       __le16 head_flags, flags;
-       u16 head, id, prev, curr, avail_used_flags;
+       __le16 head_flags = 0, flags;
+       u16 head, id, prev = 0, curr, avail_used_flags;

        START_USE(vq);

--
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
