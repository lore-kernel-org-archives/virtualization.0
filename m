Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038E3C636CD
	for <virtualization@archiver.kernel.org>; Wed,  1 Feb 2023 15:20:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96D59409FC;
	Wed,  1 Feb 2023 15:20:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 96D59409FC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=V4mEjI+8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TrhF6b_jqfJD; Wed,  1 Feb 2023 15:20:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C4E7E409DE;
	Wed,  1 Feb 2023 15:20:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4E7E409DE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DC2BC0032;
	Wed,  1 Feb 2023 15:20:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81391C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 15:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C31661033
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 15:20:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C31661033
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=V4mEjI+8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FlTWOLymroTo
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 15:20:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5060E60FB0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5060E60FB0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Feb 2023 15:20:25 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 d4-20020a05600c3ac400b003db1de2aef0so1730196wms.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Feb 2023 07:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xtQsA13TYlM+mmZKq9X5QpwAzWCUp9nY5OqJW5BvJSo=;
 b=V4mEjI+8F3GWC1TCXZpEOZ0CI26JRAa0F3GJUk/W6DP4KCMDu7cyfBCAufQXbIGjWZ
 tHLX2Xpk9quZ7ESXwv9ejpCLK9b30Wq2kGs/M0siK2nd3ttwKC6zmyHBHRtrWd9myvw+
 smY2/Ik8nVlMVR/FnRRm467qPNoKsvxeEMHI72Qb2a/fFpwQAq1LFmQrSsUEk1SZdYPd
 dWfvYResNkC0D+WDzP2zAYUg2WoNymUGZbxcuB6aM0myWLP5sOXgoTmZULWOcb/wW2cJ
 F8RVIUs7JW/reSiyi3zipC+MxNV1fhus3+uRU2yECF/F0F5CWQPnT6DDbLyXSAkWFmge
 m6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xtQsA13TYlM+mmZKq9X5QpwAzWCUp9nY5OqJW5BvJSo=;
 b=xvq9uwboW91J3wvQiFh3MZRQ71vHFREdtmR+7oMkuXil9rqw3JMZJfXPaoUyZjk7w4
 W0OiN79olIog9tegw+sOGqkQHBIxqHcLLxnJE4x3lpkmMN5FI0TuFvp3Ow+6Q7ODeBiN
 6idqSdmr18egKzexm8T/C8mhZTrkwx3gfYD6U6lZMGHaLOhexm5UiJSscp/rItD43x35
 us+tY/oKej7sUMgfaV5MX7jLbwDYknJdgaqNonhF1+qxnMFtA3hQPrFyWCtFnjJp+3Tt
 5dhRbTbOiQXasDDNDnvgKUgJw7GZlAf728Du14mh95KsBv7eyYW52I+N6s+gimyqPZz6
 kKBQ==
X-Gm-Message-State: AO0yUKUhkKOIOAIRuo4cWmGAEfx/A/6GaW1geFZGGwjpWCB8eDjo/ENF
 pCJJKV8SZomuoh8IDHBgKjnEcw==
X-Google-Smtp-Source: AK7set9t1SgmvFnQjp4ReDU4prkBxyvzV48+Z/jCzTTH3kq298LLTJyBb6i4/+9FKg0INz7ZndYTgg==
X-Received: by 2002:a05:600c:198f:b0:3dc:4355:25f6 with SMTP id
 t15-20020a05600c198f00b003dc435525f6mr8076594wmq.26.1675264823357; 
 Wed, 01 Feb 2023 07:20:23 -0800 (PST)
Received: from alvaro-dell.. (bzq-84-110-153-254.static-ip.bezeqint.net.
 [84.110.153.254]) by smtp.gmail.com with ESMTPSA id
 v10-20020a05600c12ca00b003dc0cb5e3f1sm2022801wmd.46.2023.02.01.07.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Feb 2023 07:20:22 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] vhost-vdpa: print error when vhost_vdpa_alloc_domain fails
Date: Wed,  1 Feb 2023 17:20:18 +0200
Message-Id: <20230201152018.1270226-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: netdev@vger.kernel.org, Eugenio Perez Martin <eperezma@redhat.com>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Add a print explaining why vhost_vdpa_alloc_domain failed if the device
is not IOMMU cache coherent capable.

Without this print, we have no hint why the operation failed.

For example:

$ virsh start <domain>
	error: Failed to start domain <domain>
	error: Unable to open '/dev/vhost-vdpa-<idx>' for vdpa device:
	       Unknown error 524

Suggested-by: Eugenio Perez Martin <eperezma@redhat.com>
Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 drivers/vhost/vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 23db92388393..56287506aa0d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1151,8 +1151,11 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 	if (!bus)
 		return -EFAULT;
 
-	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY))
+	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY)) {
+		dev_err(&v->dev,
+			"Failed to allocate domain, device is not IOMMU cache coherent capable\n");
 		return -ENOTSUPP;
+	}
 
 	v->domain = iommu_domain_alloc(bus);
 	if (!v->domain)
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
