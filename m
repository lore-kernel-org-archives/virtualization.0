Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB7AC433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 06:19:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A371064E60
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 06:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A371064E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7960B857C1;
	Tue, 23 Feb 2021 06:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kJoMsRc8GRH7; Tue, 23 Feb 2021 06:19:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F2F32847C5;
	Tue, 23 Feb 2021 06:19:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE49EC000B;
	Tue, 23 Feb 2021 06:19:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C256C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69ABA82EFC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oBVaD7NhUtN1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 457DA82EB5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614061164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0W8Iouaiv+280rcLPUAIdqALHz0RUbDwkNLOs2EfjZw=;
 b=ZRNoBDZZYXZPs/9ivAcb/MgFxFk3LIFobuX31nfojmZGo4RhWXAKCkWLsmrYFg2CUw0xjF
 EV2caHRzrAhHYB84YuMMdK3Cmi5irSirJHANfBxvPx+Cboy1O8wbSzCLdlEMDZSMZa5uLz
 lUSGBS6Zt/FoiT5Smh59w6MI1MIFZw4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-LnAMAtx-OFGtUaYucVyweA-1; Tue, 23 Feb 2021 01:19:20 -0500
X-MC-Unique: LnAMAtx-OFGtUaYucVyweA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 085298030B7;
 Tue, 23 Feb 2021 06:19:19 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-6.pek2.redhat.com [10.72.13.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D4D75D9D0;
 Tue, 23 Feb 2021 06:19:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V4 1/3] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
Date: Tue, 23 Feb 2021 14:19:03 +0800
Message-Id: <20210223061905.422659-2-jasowang@redhat.com>
In-Reply-To: <20210223061905.422659-1-jasowang@redhat.com>
References: <20210223061905.422659-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: shahafs@mellanox.com, Anders Roxell <anders.roxell@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju <naresh.kamboju@linaro.org>,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Guenter Roeck <linux@roeck-us.net>
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

We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
lot of confusion. E.g it may break various default configs which want
virtio devices.

So this patch fixes this by hiding the prompot and documenting the
dependency. While at it, rename the module to VIRTIO_PCI_LIB.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 86b87c9d858b6 ("virtio-pci: introduce modern device module")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/Kconfig  | 11 ++++++-----
 drivers/virtio/Makefile |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 6b9b81f4b8c2..ce1b3f6ec325 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -12,13 +12,13 @@ config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	  This option is selected if the architecture may need to enforce
 	  VIRTIO_F_ACCESS_PLATFORM
 
-config VIRTIO_PCI_MODERN
-	tristate "Modern Virtio PCI Device"
-	depends on PCI
+config VIRTIO_PCI_LIB
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
+	select VIRTIO_PCI_LIB
 	select VIRTIO
 	help
 	  This driver provides support for virtio based paravirtual device
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index f097578aaa8f..699bbea0465f 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
-obj-$(CONFIG_VIRTIO_PCI_MODERN) += virtio_pci_modern_dev.o
+obj-$(CONFIG_VIRTIO_PCI_LIB) += virtio_pci_modern_dev.o
 obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
 virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
