Return-Path: <SRS0=x/cL=HV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E7C433DB
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 08:45:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67D4C64E38
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 08:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D4C64E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC77E606C5
	for <virtualization@archiver.kernel.org>; Fri, 19 Feb 2021 08:45:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mKqeV_74hSz0 for <virtualization@archiver.kernel.org>;
	Fri, 19 Feb 2021 08:45:36 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id E5B3F606CC; Fri, 19 Feb 2021 08:45:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id C87A860689;
	Fri, 19 Feb 2021 08:45:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89223C000E;
	Fri, 19 Feb 2021 08:45:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34689C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 08:45:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 15EC260689
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 08:45:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q6-lUlr9Ap2J
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 08:45:30 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 3836E606AF; Fri, 19 Feb 2021 08:45:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7CD9A60689
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Feb 2021 08:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613724327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc; bh=/buFKeI9CtoxyX4nukMARJ+1vltPsaW0sfkWh7oknSY=;
 b=GMpt92IqMmvulxgTfiN2IvvDkf/j2+QtKEQFV9os+akdJ42L70iBirrtpGoPv2Y5cWH82M
 1IXJ1GkULIKa1DZ/p3EKgy/rk2FuBpkPCo8RFComWRkFKkfR/Ad1A5zIn1lfhD1wV2kiI0
 8++rfe5Pz+GTuYKr3h4mv2fV7F4C8Bw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-Zp71jxVWOmWJmIfbjgXXMA-1; Fri, 19 Feb 2021 03:45:20 -0500
X-MC-Unique: Zp71jxVWOmWJmIfbjgXXMA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE1D0192CC40;
 Fri, 19 Feb 2021 08:45:18 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B6AB6F95B;
 Fri, 19 Feb 2021 08:45:13 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
Date: Fri, 19 Feb 2021 03:45:09 -0500
Message-Id: <20210219084509.48269-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Guenter Roeck <linux@roeck-us.net>,
 Anders Roxell <anders.roxell@linaro.org>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
lot of confusion. E.g it may break various default configs which want
virtio devices.

So this patch fixes this by hide the prompot and document the
dependency.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 6b9b81f4b8c2..be7df369bc2b 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -13,12 +13,12 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	  VIRTIO_F_ACCESS_PLATFORM
 
 config VIRTIO_PCI_MODERN
-	tristate "Modern Virtio PCI Device"
-	depends on PCI
+	tristate
 	help
 	  Modern PCI device implementation. This module implements the
 	  basic probe and control for devices which are based on modern
-	  PCI device with possible vendor specific extensions.
+	  PCI device with possible vendor specific extensions. Any
+	  module that selects this module must depend on PCI.
 
 menuconfig VIRTIO_MENU
 	bool "Virtio drivers"
@@ -28,7 +28,8 @@ if VIRTIO_MENU
 
 config VIRTIO_PCI
 	tristate "PCI driver for virtio devices"
-	depends on VIRTIO_PCI_MODERN
+	depends on PCI
+	select VIRTIO_PCI_MODERN
 	select VIRTIO
 	help
 	  This driver provides support for virtio based paravirtual device
-- 
2.18.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
