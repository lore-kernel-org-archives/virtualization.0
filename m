Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E1BC433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Nov 2022 10:25:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B9F2F40B3F;
	Wed,  9 Nov 2022 10:25:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B9F2F40B3F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Cubzxsp/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7we_zAM5jbWw; Wed,  9 Nov 2022 10:25:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5AE6240B15;
	Wed,  9 Nov 2022 10:25:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5AE6240B15
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3810AC0033;
	Wed,  9 Nov 2022 10:25:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 032C9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D29A540B42
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D29A540B42
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lTt7Xljk2FGv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1D8C4019D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1D8C4019D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Nov 2022 10:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667989512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yog0hcuy+DRZPETd9YkKxOoct4jxmNsATV6V9Xx3MWc=;
 b=Cubzxsp/FhdnicGCbhVeu3i8DFdv7sJKe48wsnkZMoQp7Hvgc1+gTA+spZ+aO3T13aChYp
 XCqZeEC9QcOT8MOzop+Pwni7Qv2zkK7Cpq4grURXR2I38IACB64iJgShINi3+0gf+4AT3X
 seVrIsp9h3SN0sk9trc1CdPCY0fFV7g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-642g7PYwP-SWBcsTYHJT-A-1; Wed, 09 Nov 2022 05:25:11 -0500
X-MC-Unique: 642g7PYwP-SWBcsTYHJT-A-1
Received: by mail-qk1-f198.google.com with SMTP id
 bl21-20020a05620a1a9500b006fa35db066aso15381185qkb.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Nov 2022 02:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yog0hcuy+DRZPETd9YkKxOoct4jxmNsATV6V9Xx3MWc=;
 b=wdUK/xhqsQYUQMxLPBwVzQEuHacSmAWym/EhNatF2UPj+g8xnIHE85sjZjxiGLqFnT
 lQWCt7iHF2xwWPk/3L+Yqw8H7o848Ka+K9h7crM+aHKkUZLLqQawOEQCTqI2s9b0PhHh
 F0dS9x3NI60zQNXkU7Wh3nE8R/HAZRls7qVyL5aWVuydJirGxfKFX3uFsQJvZgi+9Ga3
 SMnIaUa1w/J8GfCQw/YzkiQmUQ90rdFCfMIoxskkVaLjOMjzRPdA8+/gM+GatJrES8Sb
 jsEG7jqHlTWzeLZlSGWh0/3KZWX1pAe2RZT7dro00oWztAaOZ7OG+TOePf7UH9QOwbhS
 6Y5Q==
X-Gm-Message-State: ACrzQf3UqU39yTbmDpuX4pcxTSD99rB6Kk9SdPgXA4aId0EeIblw8n2n
 6QJ4zetz+4vsegQYNfBdjQkuXeTSzbFforqUfQzr+BGNxc89rZ09X+wLjMhKk2m9liJ9rKWZQ5x
 lkT4Cy9y9LPwjWelAvOpIdZZZl5UQ2UBdMnh0ucKVlpji/59KKQyxLH4GPOSwixAHcJpDxCxhap
 qyNqBksNffNo0WGCeJsQ==
X-Received: by 2002:a05:622a:12:b0:3a5:6899:5add with SMTP id
 x18-20020a05622a001200b003a568995addmr20183673qtw.629.1667989510838; 
 Wed, 09 Nov 2022 02:25:10 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7dHRvHahxNPyxd5cXNPDwYDthvEkrvK4CouVYmtTTQjEql4SHBFw0gbhGAtAaO5z7i7a0AnQ==
X-Received: by 2002:a05:622a:12:b0:3a5:6899:5add with SMTP id
 x18-20020a05622a001200b003a568995addmr20183656qtw.629.1667989510546; 
 Wed, 09 Nov 2022 02:25:10 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 bj10-20020a05620a190a00b006fa313bf185sm10827522qkb.8.2022.11.09.02.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Nov 2022 02:25:09 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/2] vringh: fix range used in iotlb_translate()
Date: Wed,  9 Nov 2022 11:25:02 +0100
Message-Id: <20221109102503.18816-2-sgarzare@redhat.com>
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

In iotlb_translate() we cyclically call vhost_iotlb_itree_first(),
incrementing `addr` by the amount already translated, so rightly
we move the `start` parameter passed to vhost_iotlb_itree_first(),
but we should hold the `last` parameter constant.

Let's fix it by saving the `last` parameter value before incrementing
`addr` in the loop.

Fixes: 9ad9c49cfe97 ("vringh: IOTLB support")
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vhost/vringh.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 11f59dd06a74..828c29306565 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1102,7 +1102,7 @@ static int iotlb_translate(const struct vringh *vrh,
 	struct vhost_iotlb_map *map;
 	struct vhost_iotlb *iotlb = vrh->iotlb;
 	int ret = 0;
-	u64 s = 0;
+	u64 s = 0, last = addr + len - 1;
 
 	spin_lock(vrh->iotlb_lock);
 
@@ -1114,8 +1114,7 @@ static int iotlb_translate(const struct vringh *vrh,
 			break;
 		}
 
-		map = vhost_iotlb_itree_first(iotlb, addr,
-					      addr + len - 1);
+		map = vhost_iotlb_itree_first(iotlb, addr, last);
 		if (!map || map->start > addr) {
 			ret = -EINVAL;
 			break;
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
