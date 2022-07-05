Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92605C43334
	for <virtualization@archiver.kernel.org>; Tue,  5 Jul 2022 07:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19078405DC;
	Tue,  5 Jul 2022 07:23:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 19078405DC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OTNLcNcm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eVGhvmh3i0hr; Tue,  5 Jul 2022 07:22:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9294840502;
	Tue,  5 Jul 2022 07:22:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9294840502
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CA73C0032;
	Tue,  5 Jul 2022 07:22:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C061C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D97FF40354
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:22:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D97FF40354
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OTNLcNcm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WStyaCwEsTgA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:22:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0BC14034D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D0BC14034D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 07:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657005774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N/ASHfBlGwx6CPom7xa9MrPgEDXvopeeCGbYV8xojNw=;
 b=OTNLcNcmGbXXiF0FG7/UsiDa/zHmmtTYNzoQuB/eYZ11GAm+Lq6yhVKB3R6lNUounll/Xj
 Z2gTivcLvq8DKJA+kHmLDE4RO1PQCwC6lggTW7jhk78jh3BLiq8gE3x1zPbwGt1/SaRt11
 Q4duFIDAkmZrX2SdOdH7e4FihyMBJZA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-RgYiB3jmP_WhLzZ4awhreQ-1; Tue, 05 Jul 2022 03:22:53 -0400
X-MC-Unique: RgYiB3jmP_WhLzZ4awhreQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 m20-20020a05600c4f5400b003a03aad6bdfso4905633wmq.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jul 2022 00:22:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N/ASHfBlGwx6CPom7xa9MrPgEDXvopeeCGbYV8xojNw=;
 b=5H8Gmi3jrrZq7+2YYHI41RIOIe+MUofOTJnNfM7EAw0974f/AWvpSd7BCmDPbETakq
 eBKYz/FxxH9taAx2rv4xQUN3ih+J+35Ms8BU+ii/mGGeSwySE4OIDyignl0r7X7JrAFj
 f5Z6472D/eVVpblhMz/9mXyeexNwMLR7MCHAr8hzm407CoF6hWT3uQ/EABAlYrmAS+z4
 7Vr99R0XZJTEKIHLO0CeGT3AKwspcU9VPUs4GwI224imo1wkfKmYcGv+WrLOMNRPRDuH
 Uxa7BhnQU2LUbfG4H9CeMFMK7LeVvc1+btXFpxBja2JhwcmsLZJVTvqHlCq3B8w2AJT+
 dUMQ==
X-Gm-Message-State: AJIora/i1Suv6O+R2Dsn8SoZ7BknO5QVELilJY9NvRe6KS2C2nZ/dp6j
 I8jaEN0qIDKPt/0TTzXUaS0g4z0snd6mcRDwRlCesCa91upOAcDLmCbJUYXDxyZBu8a6T5z7xT9
 D5kp6bxisQECejPqY5Ma/Hot+QqfsEycZlXj65Oq8p0p4TMj4b4zEYwMAI0SLCnMqfATdWliu/P
 POAYEGrWwBYryPlnq6EA==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id
 a3-20020a056000188300b00205c0cb33c6mr31999806wri.39.1657005771758; 
 Tue, 05 Jul 2022 00:22:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOyPW1aqWsF8F4WjCUcs8p1xoNBXMowttVXO1mb/z/gmUozhUvn0wR3gSD7sNBb/OBsGi+sQ==
X-Received: by 2002:a05:6000:1883:b0:205:c0cb:33c6 with SMTP id
 a3-20020a056000188300b00205c0cb33c6mr31999786wri.39.1657005771526; 
 Tue, 05 Jul 2022 00:22:51 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 p12-20020a5d638c000000b0021d6dad334bsm3551528wru.4.2022.07.05.00.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jul 2022 00:22:50 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] tools/virtio: fix build
Date: Tue,  5 Jul 2022 09:22:49 +0200
Message-Id: <20220705072249.7867-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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
