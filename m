Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBE1C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 08:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 593988188D;
	Thu,  2 Feb 2023 08:42:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 593988188D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=JagVYhvz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s2DdZVgX1Ggf; Thu,  2 Feb 2023 08:42:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E7FAB81336;
	Thu,  2 Feb 2023 08:42:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7FAB81336
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4245C0032;
	Thu,  2 Feb 2023 08:42:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B56CEC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 08:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81FB781435
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 08:42:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81FB781435
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jbvERc0V5dsI
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 08:42:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 999A481336
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 999A481336
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 08:42:18 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 k8-20020a05600c1c8800b003dc57ea0dfeso3168048wms.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 00:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJ2h1ZaU/GcFk31wHwXi/YmcM59nhFndu/IEhvHklgU=;
 b=JagVYhvz8pDF2iKIQuwL52O/DMXrNq67WmS2Ysg5mBspm6Zf8s2/AQKlykE1CtDrve
 F0RYnEng7c0b4oazJF+xUwLeqwvyj2lYJYi+Y534DnWMgwgxSqbBOueBiCVkM/X5CPjt
 hnxIvTMYbUoZgPpki9SXVTpE8hvicKxkrZ964jCqnG0GflrwMvYQXDjVqrc5xgCiRDVb
 QadV0/HE8flOC0K3cBAFbpYqqux4xuzJiH9wttkEHnFRnS8Evz+DsdHUhy76G6c/kcUc
 NXxs3L4XwebUUg47uv3kfnC5ECntYGcG4t1oKc2Re7DIadqy63CoJL7jJqKouexsrAdz
 2lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJ2h1ZaU/GcFk31wHwXi/YmcM59nhFndu/IEhvHklgU=;
 b=CG4oZscMlgHfqvSupV10HjFIS3AeFENuppWXZTpJm5nDxKV94vWZdTenttc9t2S3xZ
 7/9oQJ9tP0lfVQIltjGMLBafcaCphAGpKGuse4lyHB43c8Tsq2AohJllG+yyyTgfFiir
 10AKwUQx0UiyzmJ3RPmeATWYwEm/8asonr3YlyrohtcUCluIrWX9iqQtTKikzQmJFU/T
 F+YIqBSPwkCBDCB9Z+MY7T6N2a4er5oih3X3bB2opR+5PiCBOMOYyku8KuYUPQqxAAqh
 PAaj8oSbQ8t6vlNGzNBwul9xOckjKiwzkt5bvExjQSQlbH5m49+JieJuNqWCEhVuBBtU
 f/LA==
X-Gm-Message-State: AO0yUKU/LbWpmIEXt09H9ZymGsz4i1/+OYE1UB+7AGpBDxClt42jgXYD
 hPu6uebt4utgXx+HqFGIkvaY7g==
X-Google-Smtp-Source: AK7set/dZBeBiTxve1zjMeO7wkX4uitN6ccr1VJ/0ayaitBMBYYqDoBhGZzUzubT3kffRhTh0I1vbA==
X-Received: by 2002:a05:600c:3b9d:b0:3d2:3be4:2d9a with SMTP id
 n29-20020a05600c3b9d00b003d23be42d9amr5141708wms.20.1675327336811; 
 Thu, 02 Feb 2023 00:42:16 -0800 (PST)
Received: from alvaro-dell.. (bzq-84-110-153-254.static-ip.bezeqint.net.
 [84.110.153.254]) by smtp.gmail.com with ESMTPSA id
 i13-20020a1c540d000000b003db03725e86sm4170906wmb.8.2023.02.02.00.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 00:42:15 -0800 (PST)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2] vhost-vdpa: print warning when vhost_vdpa_alloc_domain
 fails
Date: Thu,  2 Feb 2023 10:42:12 +0200
Message-Id: <20230202084212.1328530-1-alvaro.karsz@solid-run.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201152018.1270226-1-alvaro.karsz@solid-run.com>
References: <20230201152018.1270226-1-alvaro.karsz@solid-run.com>
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
v2:
	- replace dev_err with dev_warn_once.

 drivers/vhost/vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 23db92388393..135f8aa70fb2 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1151,8 +1151,11 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
 	if (!bus)
 		return -EFAULT;
 
-	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY))
+	if (!device_iommu_capable(dma_dev, IOMMU_CAP_CACHE_COHERENCY)) {
+		dev_warn_once(&v->dev,
+			      "Failed to allocate domain, device is not IOMMU cache coherent capable\n");
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
