Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C40C433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 17:17:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FFFB812BD;
	Mon,  4 Jul 2022 17:17:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FFFB812BD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjU8wuQ4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SiOu5gkSauzT; Mon,  4 Jul 2022 17:17:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 23F9981290;
	Mon,  4 Jul 2022 17:17:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23F9981290
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E593EC0032;
	Mon,  4 Jul 2022 17:17:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F241CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B979240382
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B979240382
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cjU8wuQ4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D16728KmiB5N
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AC31A4035A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AC31A4035A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656955030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/ASHfBlGwx6CPom7xa9MrPgEDXvopeeCGbYV8xojNw=;
 b=cjU8wuQ4NDW5GShDIBDWY5xbCgKIGczF9Rt9/bwoGqb5zr+W6Lr08PB5r7XUwJgX2Njij1
 aMESe2VAqSW34vDa/RcmjES4ptFgJ0KA5a6aTYEP223tYuxri7oLfECi2ElspmK9lFJWho
 HSWLqtELk88+VTELCdeqnGuGn6aCRKo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-t3otmXeqO6unw6UiZwlnjQ-1; Mon, 04 Jul 2022 13:17:09 -0400
X-MC-Unique: t3otmXeqO6unw6UiZwlnjQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 bm2-20020a05620a198200b006a5dac37fa2so9205177qkb.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 10:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N/ASHfBlGwx6CPom7xa9MrPgEDXvopeeCGbYV8xojNw=;
 b=4p58xOURMidyG0MTBdf2UkZ30atr03D/E3rztUxMtZLQlmrc4vRavf5E58FG//ViCU
 McKTVCZOOC/SXwj9CAQYDoPLv3M/ZVFr/HMDGabHgxbV4Kx+scGqJgKwp0ZssKNeMuu7
 xBAZHpK5uR12hPvUiDTkyLeb5fo88K5Qru/ytli3Gehkf9G8VuA2Tze+yCgKICwxbiSR
 HjivqTJ5EisMktLkzq9PIw7MfBKat63wp+eAQt9no8LpSgOx96xYrw6XiZE5tuWVXDNb
 0FLdW73ECwCx0KQvSVo39xTkY9LOS1UytYxiiRcRvC+SCQSX931+lyXoBj5L+OaEe2Aw
 NLgw==
X-Gm-Message-State: AJIora9ABsDSDRdD0sHN43RlWfDUc84Fnd0jmjtEYPRLKzYm2sD2TKuA
 J8k9fw01dpm1PJdQUZgb6GifMDV4+AeDl8+X1GNgYL9aZThAidQTarrU/uqIXVXQIDxUxaLY6S/
 cHNmUJyB73NkV1hYysLzDDoNp/9MVj0DvmnnVU2PKO2f9dJCHhDJ1K7FZFaQNElPfBNi+6Dot8A
 duAUayihAsYOjFlaRy4Q==
X-Received: by 2002:a05:620a:469e:b0:6b0:e66a:6bd with SMTP id
 bq30-20020a05620a469e00b006b0e66a06bdmr19691316qkb.285.1656955028449; 
 Mon, 04 Jul 2022 10:17:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1um6olL36YJnCCSnK21iQMhdkBq5wN6w2T59beszRdcjnFkROIHM2UBY5D60rK6HejU80TvYQ==
X-Received: by 2002:a05:620a:469e:b0:6b0:e66a:6bd with SMTP id
 bq30-20020a05620a469e00b006b0e66a06bdmr19691298qkb.285.1656955028170; 
 Mon, 04 Jul 2022 10:17:08 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 o16-20020a05620a2a1000b006a68fdc2d18sm21656078qkp.130.2022.07.04.10.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 10:17:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 1/6] tools/virtio: fix build
Date: Mon,  4 Jul 2022 19:16:56 +0200
Message-Id: <20220704171701.127665-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704171701.127665-1-sgarzare@redhat.com>
References: <20220704171701.127665-1-sgarzare@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

Fix the build caused by the following changes:
- phys_addr_t is now defined in tools/include/linux/types.h
- dev_warn_once() is used in drivers/virtio/virtio_ring.c
- linux/uio.h included by vringh.h use INT_MAX defined in limits.h

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/linux/kernel.h | 2 +-
 tools/virtio/linux/vringh.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 0b493542e61a..21593bf97755 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -29,7 +29,6 @@
 #define READ                    0
 #define WRITE                   1
 
-typedef unsigned long long phys_addr_t;
 typedef unsigned long long dma_addr_t;
 typedef size_t __kernel_size_t;
 typedef unsigned int __wsum;
@@ -136,6 +135,7 @@ static inline void *krealloc_array(void *p, size_t new_n, size_t new_size, gfp_t
 #endif
 #define dev_err(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 #define dev_warn(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
+#define dev_warn_once(dev, format, ...) fprintf (stderr, format, ## __VA_ARGS__)
 
 #define min(x, y) ({				\
 	typeof(x) _min1 = (x);			\
diff --git a/tools/virtio/linux/vringh.h b/tools/virtio/linux/vringh.h
index 9348957be56e..e11c6aece734 100644
--- a/tools/virtio/linux/vringh.h
+++ b/tools/virtio/linux/vringh.h
@@ -1 +1,2 @@
+#include <limits.h>
 #include "../../../include/linux/vringh.h"
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
