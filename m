Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34D6C433EF
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 01:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 572BC40012;
	Tue, 18 Jan 2022 01:34:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bx6O2okBp_VO; Tue, 18 Jan 2022 01:34:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C292D400AB;
	Tue, 18 Jan 2022 01:34:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BEF1C0039;
	Tue, 18 Jan 2022 01:34:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30AF1C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 01:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 099F9400AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 01:34:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uZfEB-lV0Z5Y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 01:34:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F144040012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 01:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642469688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iw6gZA/Ubxgua8sUm6BJOb3R/rdAvTK6ZPxUDv9BXJQ=;
 b=ZicwNn3pmFQevcfMg23OjmDmwoOm9FCrK88AY2IhxN+pE01ipYZTKi1Y6bZAbIc6dmDweW
 yqD27lF2rf+bN7MmSFfDpWeYRvr5YyoLMZM33kKSWLs8KAzxTXY0otwuOSfM/dReUykFwn
 Lmqiy+domARHwkydXuJly8Q/tSfJ78w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-eEzooBaQM6ut9HExSNGQCw-1; Mon, 17 Jan 2022 20:34:45 -0500
X-MC-Unique: eEzooBaQM6ut9HExSNGQCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 606E71083F60;
 Tue, 18 Jan 2022 01:34:44 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-68.pek2.redhat.com [10.72.12.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9A4A60BD8;
 Tue, 18 Jan 2022 01:34:38 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] drivers/virtio: Enable virtio mem for ARM64
Date: Tue, 18 Jan 2022 09:34:31 +0800
Message-Id: <20220118013431.167347-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
---
 drivers/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 34f80b7a8a64..bf3f6ebdaa3b 100644
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
-- 
2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
