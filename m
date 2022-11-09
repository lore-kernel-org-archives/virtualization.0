Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9FBC4321E
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 10:25:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC75881A30;
	Wed,  9 Nov 2022 10:25:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC75881A30
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zm66+uF3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WI--4Jn-M1au; Wed,  9 Nov 2022 10:25:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8492C81358;
	Wed,  9 Nov 2022 10:25:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8492C81358
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 614E9C0033;
	Wed,  9 Nov 2022 10:25:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F32F5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9F0A401EA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9F0A401EA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zm66+uF3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qw0AvDli4m67
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D84EC401BD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D84EC401BD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667989515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XonZz/B2W6BqtiPIn1XQ7dqlSI0WP9PGZyzmQRe2lsc=;
 b=Zm66+uF3sVBCczxY4QxIbu3wMYa/qP6OSuU8ZFH1AP6Sme9s+jaSiD39xcrO+9WL9OUvQv
 v8Jn2hIMwxR336G358pkdYyN8yL/7YfJ5a0wZSliEdHUYkAKhZeuHG40C69es8/KywTNO3
 Xdkz0fFz26filpd0q8dEbaNnwFwVxK8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-670-HIR9sv_qPK-XVhyAHEn3Iw-1; Wed, 09 Nov 2022 05:25:14 -0500
X-MC-Unique: HIR9sv_qPK-XVhyAHEn3Iw-1
Received: by mail-qv1-f69.google.com with SMTP id
 g1-20020ad45101000000b004bb5eb9913fso11455255qvp.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 02:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XonZz/B2W6BqtiPIn1XQ7dqlSI0WP9PGZyzmQRe2lsc=;
 b=jSAvfwmkkp36tpdU1TJOCN9Xn3nIx+PRRpGqB6suw3zaN4MHbZKqlvxnEoayx4RlIc
 fOS9CM8GcdgF0tKU3cZZ5AlXQXA9CIjsNIyKPY/3OTRPVNDKD3MvgHsSK6+E2dp3BvCJ
 HNAjlFl/jnYmbYcGrx19MoMw3PSRiOL8pp3sgTj7ki56aNBYLhPKV6YpwFro5E41PHzG
 vWRyowCAnpFayTSTE5HZURnzOmWZA22lCndKhnSDnJtstv0ys6fHJBllxczP8KDInNhb
 JtENd/jVuQE+t6t8vOHCxVgQxeqsCYywoSux575kpvRqC+a4YLNy4RPmaA85fCWdEHoP
 7EFw==
X-Gm-Message-State: ACrzQf0PZiwCsk566YN4fbOmWA6Jhwvr1wBSWQOUT/mr7RDMbxPCWzIm
 Fs3J0FLmAZGvwOTTfuEPCTS2giO2QQxW3ck3PVtxcebr5cP/szMfIwF8JijMacWaQzuPmsMu7Tk
 fyPGzrQUcpYcqWYN8gcGKQWaS84CSJrhqC92Y7OkqZDRpIp4+x5Cd/STboZOm3/9ZZj7a3yEnVp
 AzcGAHDhx6YIm9V8KUoQ==
X-Received: by 2002:a37:8943:0:b0:6fa:a454:c8d2 with SMTP id
 l64-20020a378943000000b006faa454c8d2mr16840226qkd.534.1667989513434; 
 Wed, 09 Nov 2022 02:25:13 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7bgS44r6yW8TpTmUka6iM1lFnyLysINGmhFPYaKUR8f+8FNUgnbq7sR8Utx2EfXdQOWtRelQ==
X-Received: by 2002:a37:8943:0:b0:6fa:a454:c8d2 with SMTP id
 l64-20020a378943000000b006faa454c8d2mr16840207qkd.534.1667989513122; 
 Wed, 09 Nov 2022 02:25:13 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 bj10-20020a05620a190a00b006fa313bf185sm10827522qkb.8.2022.11.09.02.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 02:25:12 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 2/2] vhost: fix range used in translate_desc()
Date: Wed,  9 Nov 2022 11:25:03 +0100
Message-Id: <20221109102503.18816-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221109102503.18816-1-sgarzare@redhat.com>
References: <20221109102503.18816-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

vhost_iotlb_itree_first() requires `start` and `last` parameters
to search for a mapping that overlaps the range.

In translate_desc() we cyclically call vhost_iotlb_itree_first(),
incrementing `addr` by the amount already translated, so rightly
we move the `start` parameter passed to vhost_iotlb_itree_first(),
but we should hold the `last` parameter constant.

Let's fix it by saving the `last` parameter value before incrementing
`addr` in the loop.

Fixes: a9709d6874d5 ("vhost: convert pre sorted vhost memory array to interval tree")
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- Replaced Fixes tag with the right one [Jason]
---
 drivers/vhost/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 40097826cff0..3c2359570df9 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2053,7 +2053,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 	struct vhost_dev *dev = vq->dev;
 	struct vhost_iotlb *umem = dev->iotlb ? dev->iotlb : dev->umem;
 	struct iovec *_iov;
-	u64 s = 0;
+	u64 s = 0, last = addr + len - 1;
 	int ret = 0;
 
 	while ((u64)len > s) {
@@ -2063,7 +2063,7 @@ static int translate_desc(struct vhost_virtqueue *vq, u64 addr, u32 len,
 			break;
 		}
 
-		map = vhost_iotlb_itree_first(umem, addr, addr + len - 1);
+		map = vhost_iotlb_itree_first(umem, addr, last);
 		if (map == NULL || map->start > addr) {
 			if (umem != dev->iotlb) {
 				ret = -EFAULT;
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
