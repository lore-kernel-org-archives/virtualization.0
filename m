Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7C0C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 09:08:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A23360E29;
	Tue, 20 Dec 2022 09:08:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A23360E29
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=tIB4RjRy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tGoqYgxvKQb; Tue, 20 Dec 2022 09:08:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ED17060BDD;
	Tue, 20 Dec 2022 09:08:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ED17060BDD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F001C0032;
	Tue, 20 Dec 2022 09:08:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69F8CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 09:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 453EE819BE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 09:07:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 453EE819BE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=tIB4RjRy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z-cj8Wjj0GcX
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 09:07:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61BBE81948
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 61BBE81948
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 09:07:38 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id ja17so8152008wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 01:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VN+qjN9i4ulv1KBS052q4NHF7ExpCWjz2iD1ltDk0nA=;
 b=tIB4RjRyQ3qIVg1sCV1QV9By3kjpd9y+YrDJ1ic07CDo2unZ/xbfm2Mp5nrUi7Qb+I
 kHUogzhyCChhIxosjgW1kswWtyqCj6P+EJV5P0xj2KQMDOWJiBwLeZ5sQo6DgRb3bSMk
 qW1JGQAurc0jmmRRkg8fvS8l69GtCiSxcK1YVuVmzqaqjmWvkg9vZoq5gQlVV95FdNEM
 2sC4h3xkDH5v036EEthPRMzgZmam4dv+9+wjBUEeLHkz0MNcRyKBcKyIrhq/Bg0q5Hze
 GlpP/p50hspWdEbUOKT2WuCZEUMWf17f2mHmcrok8sU5C8KoPzb+cn/0JJqB2sJ5E6xK
 zbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VN+qjN9i4ulv1KBS052q4NHF7ExpCWjz2iD1ltDk0nA=;
 b=LYtBq8vxcZd3zxm7GURl5tCOz/bId+NpP+EpsHowV6456Ti9/h7PiODahG2plb/369
 qmMUfScSk+6kjx908kXBsq9YUl/dqMIE1tVm9LKo45x5SYQm3QyZyMCisnYkVar2coaE
 ksWMEfn+YwbN+rTbkijzUcs0Fv95gx7WUW/gixf9aRUG8i55Y38Dq68MkfYfmaNLosjn
 Dg2QhJGpdycM7eJV2o4ftngC109RCIFxcxTYnzCp2co/AZwazeZHf+CeWaFCT+ojfPBn
 Xn0lZR/0TxK4Y3/lHyTRH/uf7GFzlZQGNbXxW0low6KhhFe3rKYGlwRBibnssq/DiKeG
 Y1PA==
X-Gm-Message-State: AFqh2kps+LdVGu49AlObeuqQOspkAqrrDMH0jeyYXlDF4maHhuKWS8CX
 DJMNWxiqh0SrvO3boMvBStCSTncCKwv+Eq9rmSc=
X-Google-Smtp-Source: AMrXdXtsMjYIh3rg637s5jOFvYi8nZNQ0fyp544haQ4vGde2GZdAyQzI5Pf7ITWCUuB8dZinfO8pPA==
X-Received: by 2002:a05:600c:502c:b0:3d3:49db:9b25 with SMTP id
 n44-20020a05600c502c00b003d349db9b25mr933479wmr.26.1671527255911; 
 Tue, 20 Dec 2022 01:07:35 -0800 (PST)
Received: from localhost.localdomain
 (bzq-84-110-153-254.static-ip.bezeqint.net. [84.110.153.254])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a05600c0a4600b003d1e3b1624dsm24585401wmq.2.2022.12.20.01.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 01:07:35 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio: vdpa: explain the dependency of SNET_VDPA on HWMON
Date: Tue, 20 Dec 2022 11:07:32 +0200
Message-Id: <20221220090732.409004-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

Add a comment in Kconfig explaining the
"depends on .. && (HWMON || HWMON=n)" part.

This patch should be applied on top of the following patch:

virtio: vdpa: new SolidNET DPU driver,
by Alvaro Karsz alvaro.karsz@solid-run.com

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vdpa/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 79625c7cc46..7396e92b485 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -89,6 +89,14 @@ config ALIBABA_ENI_VDPA
  config SNET_VDPA
 	tristate "SolidRun's vDPA driver for SolidNET"
 	depends on PCI_MSI && PCI_IOV && (HWMON || HWMON=n)
+
+	# This driver MAY create a HWMON device.
+	# Depending on (HWMON || HWMON=n) ensures that:
+	# If HWMON=n the driver can be compiled either as a module or built-in.
+	# If HWMON=y the driver can be compiled either as a module or built-in.
+	# If HWMON=m the driver is forced to be compiled as a module.
+	# By doing so, IS_ENABLED can be used instead of IS_REACHABLE
+
 	help
 	  vDPA driver for SolidNET DPU.
 	  With this driver, the VirtIO dataplane can be
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
