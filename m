Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8372C433EF
	for <virtualization@archiver.kernel.org>; Thu, 14 Jul 2022 11:14:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F2E640443;
	Thu, 14 Jul 2022 11:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F2E640443
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A0fZCQUj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sZKhhyukYaiP; Thu, 14 Jul 2022 11:14:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BAB74416D0;
	Thu, 14 Jul 2022 11:14:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BAB74416D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 998F7C0035;
	Thu, 14 Jul 2022 11:14:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BD60C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 11:14:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 73DF840510
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 11:14:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73DF840510
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IhzpX4GnXk-y
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 11:14:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7FD3B40443
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FD3B40443
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 11:14:13 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id b6so295711wmq.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 14 Jul 2022 04:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1mXResJww73UpBUgXzU26mfeHumFONoVe1fD4+eidgY=;
 b=A0fZCQUjeq/rnKRmKsFqQikxnljB0/oTNVfWBPFQQ840VUkpTS5fWUl/5L+rCXf7Hm
 AikKqmPcSJSZAEwCWh4LQCHP5j6HOzz5AA7t6vJfQ/IAB8Opt5PAzalXMoHTNnxDTh2z
 JU/GlYXx6OCGVBY1F0XpsnrE7PA2IYvudA4RUi4rAz4ecUSN8LwoufL75PXZKnUo+Lcg
 tuOIWx7p4AUWrhIa3o9i+G4PS/JmVsC4qAHnb0qCE8HTuUyBkfdo6UEzOklU4xUwyl8f
 ObGzdQw0PvBpl7WrkTa+ns6aiNp2CR2KK/fSrXdyrV8j5qjvhqoZiUGDVwFa92y9kVDQ
 n8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1mXResJww73UpBUgXzU26mfeHumFONoVe1fD4+eidgY=;
 b=Cxo+0f2Ft5lWZNCS4J8wsv2/DhtGstybjkNvAWmuwfPPkw/3EP6NeJdbHhCcR8pNoP
 8S61YSCUe8kD0OZ4onfiSWEhjjBdSkdCx5rVi/GKZor3UOdmwQXV9yNQ1j8OOTzwb/ZH
 DNujru3ueYU/QJjNoatM1NZzDEbA0tf0tNoYU5ICNCuwPG+6bfxPvRMtqixtVdbM7SCF
 bWKFrDLjrf5A+dpAs2Xa9BnIdJDbFjMlEciIRhNp+LTm3LobZX6jnzVb1m7AacsIBOCn
 WF+iuoBsnrYyLDuCUQ0Xt05l9MHJ1umIfMJqT2i0eUxOEpWckDCUDF8CEjiaFx+NtUFW
 8Pdg==
X-Gm-Message-State: AJIora9rJyMGpxgiypxFmZj/Xh8mlfvMhmRLD2B0xRZL7thuDHtFHE4z
 mkGzS79h1OceHnO6r/BL7dcU3g==
X-Google-Smtp-Source: AGRyM1uIAChlItXoVW28WYAYQc/hahdPbVdJHphRVg5mE36QmQZpgZSceexJEoWn6QBcqzQFpoiNvg==
X-Received: by 2002:a05:600c:41c2:b0:3a2:dc9f:959e with SMTP id
 t2-20020a05600c41c200b003a2dc9f959emr8797324wmh.166.1657797251503; 
 Thu, 14 Jul 2022 04:14:11 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id
 a8-20020a056000100800b0021db2dcd0aasm1357609wrx.108.2022.07.14.04.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 04:14:11 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org
Subject: [PATCH] iommu/virtio: Advertise IOMMU_CAP_CACHE_COHERENCY
Date: Thu, 14 Jul 2022 12:11:01 +0100
Message-Id: <20220714111059.708735-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: eric.auger@redhat.com, iommu@lists.linux.dev, will@kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 virtualization@lists.linux-foundation.org
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

Fix virtio-iommu interaction with VFIO, as VFIO now requires
IOMMU_CAP_CACHE_COHERENCY. virtio-iommu does not support non-cacheable
mappings, and always expects to be called with IOMMU_CACHE.

Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 25be4b822aa0..bf340d779c10 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1006,7 +1006,18 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
+static bool viommu_capable(enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static struct iommu_ops viommu_ops = {
+	.capable		= viommu_capable,
 	.domain_alloc		= viommu_domain_alloc,
 	.probe_device		= viommu_probe_device,
 	.probe_finalize		= viommu_probe_finalize,
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
