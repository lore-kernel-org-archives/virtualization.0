Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2148C4332F
	for <virtualization@archiver.kernel.org>; Tue,  8 Nov 2022 10:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F66860D5E;
	Tue,  8 Nov 2022 10:34:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F66860D5E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CVy8Xvpd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oOjDvftFDCWX; Tue,  8 Nov 2022 10:34:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 14CCA600B5;
	Tue,  8 Nov 2022 10:34:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14CCA600B5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E519EC0032;
	Tue,  8 Nov 2022 10:34:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 052FBC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C304440165
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C304440165
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CVy8Xvpd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gHiYHU1JnXVf
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C173402DC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C173402DC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Nov 2022 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667903685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnEQ/6uclYdSedN00zhcPF82VnGpN8n10b9g5MbTnn0=;
 b=CVy8Xvpd6yVBllRxXHMwaZkOzymHzFbHcH6mapNZQS5O62Ey4U0Mmo5Rj1gOsyGgXjB9k9
 cJNZl9WvQ2J8mp4tIEltPFPdga97qUKKxexRZPX9jlga75qDq7Zc+OCH1Yf6cRP3noy/fp
 GE6AF5u3m5RVsVfWbIwkz2wanUZR94s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-fdLwhOLoOiaLnI6l7yMIkA-1; Tue, 08 Nov 2022 05:34:44 -0500
X-MC-Unique: fdLwhOLoOiaLnI6l7yMIkA-1
Received: by mail-wr1-f69.google.com with SMTP id
 l16-20020adfc790000000b00230c2505f96so3807738wrg.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Nov 2022 02:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnEQ/6uclYdSedN00zhcPF82VnGpN8n10b9g5MbTnn0=;
 b=XdWK9o/BKPryhMru6U8V06CnYHf6Cem4WWFWBh/LX8IXiAn7+O5vJEvTSU89YMvP7T
 b9hgNarKEitcHwAoGnyAEInbVXKG5TQumb8z1EMSJ2mxDMOPYnvm1NiN8My7mRH3jqYv
 JV5jsu7AYQHnvyDuLXqhassMt7eg1pVuWMWVvb+T5xzv12l0VM8cjjbAVv5K3WqlQ0fp
 xkQ6TkazPJsbbTknzaDTmtzK7OY5kybSvhNHS92od9eMvPJcG4wSFY7qEM6mUGzgeaXt
 7vJNfD5mwiZy4QbU3QbIyhujIVCWBUL+4w/7jP/4i/TAjToNVhD9d7/9PkrYIYHtkRWu
 GjOw==
X-Gm-Message-State: ACrzQf3XSdqy1GIX0zGWkofyvaNwjRuDMZ2alxShqh1B97NXlby+YDx6
 Yyk7j49ljTPXTcjgIfF3qluaaOOFAPvL8IccQggPnqo3dIvT4n5XX3ynD+EEaiWVr9/O7KWbM9B
 Gy1BfbxVOJC2Vuk/LnkaaL7jSlwWn2VaMGoW1cpuuiXK+yJsqmEeKFPld78ylV0YQ4AyncGHbZc
 Rmm1M0GP2O+hO6GhWClg==
X-Received: by 2002:adf:f303:0:b0:236:d1c0:79dc with SMTP id
 i3-20020adff303000000b00236d1c079dcmr29615260wro.695.1667903682525; 
 Tue, 08 Nov 2022 02:34:42 -0800 (PST)
X-Google-Smtp-Source: AMsMyM60F4oRwRyS4YKIr5SpakIIdGyqUKYKutX+9xZI1DBbeFzrSYNiUGX7Pq6GFACc6ESaUV3XiQ==
X-Received: by 2002:adf:f303:0:b0:236:d1c0:79dc with SMTP id
 i3-20020adff303000000b00236d1c079dcmr29615240wro.695.1667903682285; 
 Tue, 08 Nov 2022 02:34:42 -0800 (PST)
Received: from step1.redhat.com (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 m11-20020a5d4a0b000000b0022ca921dc67sm9632802wrq.88.2022.11.08.02.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Nov 2022 02:34:41 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 2/2] vhost: fix range used in translate_desc()
Date: Tue,  8 Nov 2022 11:34:37 +0100
Message-Id: <20221108103437.105327-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108103437.105327-1-sgarzare@redhat.com>
References: <20221108103437.105327-1-sgarzare@redhat.com>
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

Fixes: 0bbe30668d89 ("vhost: factor out IOTLB")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

I'm not sure about the fixes tag. On the one I used this patch should
apply cleanly, but looking at the latest stable (4.9), maybe we should
use

Fixes: a9709d6874d5 ("vhost: convert pre sorted vhost memory array to interval tree")

Suggestions?
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
