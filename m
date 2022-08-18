Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A45C00140
	for <virtualization@archiver.kernel.org>; Thu, 18 Aug 2022 16:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9C92240982;
	Thu, 18 Aug 2022 16:41:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C92240982
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=b3NJ2nA6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P4DNa83PnDQ1; Thu, 18 Aug 2022 16:41:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 242D940204;
	Thu, 18 Aug 2022 16:41:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 242D940204
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0DDBC0032;
	Thu, 18 Aug 2022 16:41:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3407BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 16:41:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E27DA4052F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 16:41:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E27DA4052F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S8kFNOZYjMMh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 16:41:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AFED840204
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AFED840204
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 16:41:24 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id n7so2373792wrv.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Aug 2022 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=MXyQadycSW2ULYdTGoQf6CZwWJMvopdm7mnwbDqDU4k=;
 b=b3NJ2nA6Hn9K6jVpwhUv7RrDifXBH7gCiRJZDFaYPq/D65aokMakF7oxNDYgUk6JW+
 K95341oIrsUfIulL07viiix72Twogc/kq9yUocGflKsoG4pnMy2RqkFhcTe9lPLB3eX7
 mgIJ4FlRLQZTB7zsVl4Rr2iYCtVIEH6szuBvWmBSXvSyDfoqrvTy24vnnzLyugVafui7
 0QMGyE1Af1uHjKcmtSUBTjnAa2fxLUh1v4KirROKraFsxFDA4VQG8vh7sOQzDRPvIQUq
 I+As7zvcQTaTJsxe7c0h48sMDsTZwI3vuL8iA9PfoH5EeFqPek9N9Jq7OP5mOjVL+D2F
 Z6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=MXyQadycSW2ULYdTGoQf6CZwWJMvopdm7mnwbDqDU4k=;
 b=4J75SC9ysnCDlop5g5S41iKsWRJXT1f/hXpF11W35AnoHHy4PCAqncpX2xr85th01g
 y7WcGX7YK4TzuAfj5gCkWt/1jhy2n4s5QxuzJoT7PE7/IbyYhwVVe8gWCL/t6iqgDBqx
 6vhbvn4ivOk5dHUy6UZl4/7fPUF77Zz52Pjj7tME4YxpX3ShiTK+4IJf5d4CxhSi9/al
 bSGYK+lRRvyd/akcyVhLEq2INCgM84OZ/Y5rJ3wYvHu2G7YXzcVaW4ZQxPVEOHRD4ZlZ
 LFwZvhw5s9bEUxQ3cBiWY0w18u80zqVMwb4TkTIjSGFBlHAOtwukLUk0zJfaUIsaJFzB
 Osaw==
X-Gm-Message-State: ACgBeo3mAJ6X1fpkm7nQYYr/pD0R/4zeaQH983PTMmbGf7tQQb1PZfT1
 mLSrdzToZamUBq01yUZQebFrHg==
X-Google-Smtp-Source: AA6agR6od6rLFSL/zujQkbO88Lm0pedoWzhYujK4YUvLhNtmnryovQbA2GDR6qGmQsWd6MvdqOHWIg==
X-Received: by 2002:a05:6000:a09:b0:220:638f:3b4a with SMTP id
 co9-20020a0560000a0900b00220638f3b4amr2117675wrb.626.1660840882893; 
 Thu, 18 Aug 2022 09:41:22 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c4ecb00b003a4c6e67f01sm7169598wmq.6.2022.08.18.09.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Aug 2022 09:41:22 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org
Subject: [PATCH v2] iommu/virtio: Fix interaction with VFIO
Date: Thu, 18 Aug 2022 17:38:04 +0100
Message-Id: <20220818163801.1011548-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Cc: robin.murphy@arm.com, iommu@lists.linux.dev, will@kernel.org,
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

Commit e8ae0e140c05 ("vfio: Require that devices support DMA cache
coherence") requires IOMMU drivers to advertise
IOMMU_CAP_CACHE_COHERENCY, in order to be used by VFIO. Since VFIO does
not provide to userspace the ability to maintain coherency through cache
invalidations, it requires hardware coherency. Advertise the capability
in order to restore VFIO support.

The meaning of IOMMU_CAP_CACHE_COHERENCY also changed from "IOMMU can
enforce cache coherent DMA transactions" to "IOMMU_CACHE is supported".
While virtio-iommu cannot enforce coherency (of PCIe no-snoop
transactions), it does support IOMMU_CACHE.

Non-coherent accesses are not currently a concern for virtio-iommu
because host OSes only assign coherent devices, and the guest does not
enable PCIe no-snoop. Nevertheless, we can summarize here the possible
support for non-coherent DMA:

(1) When accesses from a hardware endpoint are not coherent. The host
    would describe such a device using firmware methods ('dma-coherent'
    in device-tree, '_CCA' in ACPI), since they are also needed without
    a vIOMMU. In this case mappings are created without IOMMU_CACHE.
    virtio-iommu doesn't need any additional support. It sends the same
    requests as for coherent devices.

(2) When the physical IOMMU supports non-cacheable mappings. Supporting
    those would require a new feature in virtio-iommu, new PROBE request
    property and MAP flags. Device drivers would use a new API to
    discover this since it depends on the architecture and the physical
    IOMMU.

(3) When the hardware supports PCIe no-snoop. Some architecture do not
    support this either (whether no-snoop is supported by an Arm system
    is not discoverable by software). If Linux did enable no-snoop in
    endpoints on x86, then virtio-iommu would need additional feature,
    PROBE property, ATTACH and/or MAP flags to support enforcing snoop.

Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---

Since v1 [1], I added some details to the commit message. This fix is
still needed for v5.19 and v6.0.

I can improve the check once Robin's change [2] is merged:
capable(IOMMU_CAP_CACHE_COHERENCY) could return dev->dma_coherent for
case (1) above.

[1] https://lore.kernel.org/linux-iommu/20220714111059.708735-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-iommu/d8bd8777d06929ad8f49df7fc80e1b9af32a41b5.1660574547.git.robin.murphy@arm.com/
---
 drivers/iommu/virtio-iommu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 08eeafc9529f..80151176ba12 100644
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
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
