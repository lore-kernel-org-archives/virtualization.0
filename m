Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A25EC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 17:17:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAE56812DB;
	Mon,  4 Jul 2022 17:17:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DAE56812DB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=APwHpzRL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rthrDY0sPpyj; Mon,  4 Jul 2022 17:17:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 870F981297;
	Mon,  4 Jul 2022 17:17:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 870F981297
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4084EC0032;
	Mon,  4 Jul 2022 17:17:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2162C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEA2C408C0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AEA2C408C0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=APwHpzRL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ba4OxjERKpIH
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F23104000B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F23104000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 17:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656955032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKnKGcPQx2M8z8doipgVBVXWw9daoK1UODE6Y0G/spw=;
 b=APwHpzRLemvWDKpjK3QENGhFkSDSyuWH9h/A4Teak2K3oPQYcX+wCUUZVS4nWAues81fyt
 6bxxJ2q3RrRecJmqzZI7WGInkLEjtoL+W9XJmS0VBOgJrWNbRrnSfhVvVPpN37yCJPMblr
 RyJibm8/hCklc/JKyEc69yWuiCndU9g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-7PLM8YnfOqaGHuTs7Sl1UA-1; Mon, 04 Jul 2022 13:17:12 -0400
X-MC-Unique: 7PLM8YnfOqaGHuTs7Sl1UA-1
Received: by mail-qk1-f197.google.com with SMTP id
 g194-20020a379dcb000000b006aef700d954so9163964qke.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Jul 2022 10:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tKnKGcPQx2M8z8doipgVBVXWw9daoK1UODE6Y0G/spw=;
 b=llLZ+cOBN0WVmyBpHAtlJiZIAbvV4symOGZMEAXQsnSotU7rGWaHHNVw9EMIriRT+K
 fTX/iaUyr1L8GtwS5BB0hHPH8sCNrd9fAgc7xLklkrMiuQ13iEKnX7+Gg9VGIwt55g4W
 F81DYp8EfmHSV+QrqEDGo0/p6bo4qNPKAvNyeQGR4JqUHkofgPp6PQInTn0ocb/mE+AX
 8MRtRdueCogegkqZ2DcKIFf84phNMYtUA2D9kIm38tw1Axp4klxIVxjgcUY9CJib7G0C
 AcVN0NHp112mrpU+aukFRAvvYf2/119PBaOZSl15qevZW5NIMCGiUwOok0RLh4bNsOkp
 h/xQ==
X-Gm-Message-State: AJIora90XZfo4JleKiF4g3oKUNEr3+aGjzsgJ3zCOXJcceidzCV6A4In
 Ipa9db5Z2JxvcYQFJ+HJXFVVQXUtBGXMQbm+WcFSX7s+donOvH3dVj6YYhnRsdQ2zHAOQ46kl/C
 AupOsEfQmMTfbsPZVtiZvqgH65hu4sPWtPCCp2emTmpzwJkXrx01FDmZq9Yne2PNpD2LmBfTs5p
 vilDdPDQQFRMlWRWXJwQ==
X-Received: by 2002:a05:620a:f89:b0:6ae:d418:f478 with SMTP id
 b9-20020a05620a0f8900b006aed418f478mr20154060qkn.344.1656955031166; 
 Mon, 04 Jul 2022 10:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v5kru0aGtinN6uCz+3PHhaYe1+jzHnVC9+Cwzy5758LJyRQ9emh0kO9BDMsxacR8UMuY7ZQw==
X-Received: by 2002:a05:620a:f89:b0:6ae:d418:f478 with SMTP id
 b9-20020a05620a0f8900b006aed418f478mr20154038qkn.344.1656955030805; 
 Mon, 04 Jul 2022 10:17:10 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it.
 [79.46.200.206]) by smtp.gmail.com with ESMTPSA id
 o16-20020a05620a2a1000b006a68fdc2d18sm21656078qkp.130.2022.07.04.10.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jul 2022 10:17:10 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 2/6] vhost_test: add $(srctree) on the included path
Date: Mon,  4 Jul 2022 19:16:57 +0200
Message-Id: <20220704171701.127665-3-sgarzare@redhat.com>
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

Adding $(srctree) on the included path we can build vhost_test
also when the kernel is not built in the source tree (make O=...).

Use of EXTRA_CFLAGS is deprecated, so let's use ccflags-y.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/virtio/vhost_test/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtio/vhost_test/Makefile b/tools/virtio/vhost_test/Makefile
index 94d3aff987dc..df5ad39e2520 100644
--- a/tools/virtio/vhost_test/Makefile
+++ b/tools/virtio/vhost_test/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-m += vhost_test.o
-EXTRA_CFLAGS += -Idrivers/vhost
+ccflags-y += -I$(srctree)/drivers/vhost
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
