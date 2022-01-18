Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFB7C433EF
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 08:49:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 616C440439;
	Tue, 18 Jan 2022 08:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wi_UETqyswCk; Tue, 18 Jan 2022 08:49:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B671240286;
	Tue, 18 Jan 2022 08:49:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7501EC0039;
	Tue, 18 Jan 2022 08:49:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DBEDC002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA46B817F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6GhwQ1aEufOS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:49:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 59650817A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 08:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642495761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ydAA78jFcBWpHvfrXwcUk/5JrjZlBrB9O0tO63nyWw0=;
 b=CEIq6MvqiqHYV64PlHia718g2jywLiMHGMrPvqnfjndZR1RV/H4w9lt7/wCPcjQquiMEa/
 hd1CofSGEnaX5jFX6VFotSCc8sLhhO2ZW/8C7Iu+eMN/pn5xa4qB6H0iWzB8ztNaRAkgM/
 KbwylCPp7q10DNYDu8D3eqEbui7ctvs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-D91XLgRvMf-PIEimC9k5lw-1; Tue, 18 Jan 2022 03:49:17 -0500
X-MC-Unique: D91XLgRvMf-PIEimC9k5lw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFCE08144E8;
 Tue, 18 Jan 2022 08:49:16 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-13-118.pek2.redhat.com [10.72.13.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC2197B03C;
 Tue, 18 Jan 2022 08:49:04 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2] drivers/virtio: Enable virtio mem for ARM64
Date: Tue, 18 Jan 2022 16:48:58 +0800
Message-Id: <20220118084858.175305-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gshan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: shan.gavin@gmail.com
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

This enables virtio-mem device support by allowing to enable the
corresponding kernel config option (CONFIG_VIRTIO_MEM) on the
architecture.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
v2: Improved the comments about the kernel config option (David)
---
 drivers/virtio/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 34f80b7a8a64..74c8b0c7bc33 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -106,7 +106,7 @@ config VIRTIO_BALLOON
 config VIRTIO_MEM
 	tristate "Virtio mem driver"
 	default m
-	depends on X86_64
+	depends on X86_64 || ARM64
 	depends on VIRTIO
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
@@ -116,8 +116,9 @@ config VIRTIO_MEM
 	 This driver provides access to virtio-mem paravirtualized memory
 	 devices, allowing to hotplug and hotunplug memory.
 
-	 This driver was only tested under x86-64, but should theoretically
-	 work on all architectures that support memory hotplug and hotremove.
+	 This driver was only tested under x86-64 and arm64, but should
+	 theoretically work on all architectures that support memory hotplug
+	 and hotremove.
 
 	 If unsure, say M.
 
-- 
2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
