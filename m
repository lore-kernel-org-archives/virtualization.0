Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CCCC1B0E9
	for <virtualization@archiver.kernel.org>; Thu, 25 Aug 2022 15:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9766418D2;
	Thu, 25 Aug 2022 15:53:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C9766418D2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f0zrJDDW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dlFALW4a5HqL; Thu, 25 Aug 2022 15:53:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 993134025B;
	Thu, 25 Aug 2022 15:53:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 993134025B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6130CC0033;
	Thu, 25 Aug 2022 15:53:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB2EBC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 15:53:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8ED04610AC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 15:53:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8ED04610AC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=f0zrJDDW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id erTsblVXfxH8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 15:53:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D50D60B4E
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D50D60B4E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 15:53:03 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id h24so25171501wrb.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 08:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=eKDDvB8U6aq+7oIdAo/nTh9Y2n5hFUfH10TaK5bJglk=;
 b=f0zrJDDWE8ShnFKpgy/I8quIyXFiun0CkJ2ecWb//M/rWkjx4yYXXqkL5OdG3VL7DQ
 vWzmt0aUpqVkhJHGedjNyVEpc3064D+LeI+UTULNeUljk9V5pVSvm2+QoV1IgOKIzWoj
 +CJemXitxYgNnhGgNMH48eyLjfMrHUUfPBNEl9HWpxaMwLl9zQOozo5IkOinYQoKMvZO
 xksFratOhr3Q/tCYwVGoGFL/2xdH4GetlKt9h4rjNiyka8q+OsRYoKDi4+mvqbzlU+B2
 VL1tsqpizUxkknbkABQEKeh4QrqK6IWON5Cybr8ydwv5P2Rz9GClhpdo5AmO8mL2Ydhc
 WP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=eKDDvB8U6aq+7oIdAo/nTh9Y2n5hFUfH10TaK5bJglk=;
 b=bcK9HyhT7fRAe/U/kgE/BeWCU4XgqS/cmBk2TTrt0WJ+Tpg6MbPXJxDHGP5CYl2doj
 UpTnrOGilgHG8vmFBLfjfxlazxJ26L4Qb65bLoLLhyII3pm+u6B2tHe3/PsjV1xWfwSh
 Xiceu6TgN/ViFpM2KMGSZn24ttASqYbjQVZVeonZQvFs7I3Uf9tUwabLC7L7fwjAWOaN
 kOlSTxgfA+pybO6E6H/xnRv18Ud3JVcn8ZzqPtM6tM8Vx7JXSSYErJA1cNjil4SLEcLW
 vtr2cnBOKgpAVGMFHUuSHDh8QL7UfWwhITgPU8lS5YKH9KzX1RdKeAcok9778aOyhf9l
 4F7w==
X-Gm-Message-State: ACgBeo1iEOCX9dakq9u0tLTU/BpRh0bPPNnjFshH1ada7fZ0V0pGNHzD
 mSC4WSpWKVxqxqjM7havqUv5pQ==
X-Google-Smtp-Source: AA6agR42in6A0RntamYZB9W+J0IKrhmHNMnAh6YXLyKNSDAp4ArNW922cMcaEHF9fVi6uWHXyxPGaQ==
X-Received: by 2002:a5d:6251:0:b0:222:cd3b:94bc with SMTP id
 m17-20020a5d6251000000b00222cd3b94bcmr2652113wrv.319.1661442782152; 
 Thu, 25 Aug 2022 08:53:02 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id
 p20-20020a05600c419400b003a5ffec0b91sm5378284wmh.30.2022.08.25.08.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 08:53:01 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org
Subject: [PATCH v3] iommu/virtio: Fix interaction with VFIO
Date: Thu, 25 Aug 2022 16:46:24 +0100
Message-Id: <20220825154622.86759-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, robin.murphy@arm.com
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

We can distinguish different cases of non-coherent DMA:

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

(3) When the hardware supports PCIe no-snoop. It is possible for
    assigned PCIe devices to issue no-snoop transactions, and the
    virtio-iommu specification is lacking any mention of this.

    Arm platforms don't necessarily support no-snoop, and those that do
    cannot enforce coherency of no-snoop transactions. Device drivers
    must be careful about assuming that no-snoop transactions won't end
    up cached; see commit e02f5c1bb228 ("drm: disable uncached DMA
    optimization for ARM and arm64"). On x86 platforms, the host may or
    may not enforce coherency of no-snoop transactions with the physical
    IOMMU. But according to the above commit, on x86 a driver which
    assumes that no-snoop DMA is compatible with uncached CPU mappings
    will also work if the host enforces coherency.

    Although these issues are not specific to virtio-iommu, it could be
    used to facilitate discovery and configuration of no-snoop. This
    would require a new feature bit, PROBE property and ATTACH/MAP
    flags.

Cc: stable@vger.kernel.org
Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
Since v2 [1], I tried to refine the commit message.
This fix is needed for v5.19 and v6.0.

I can improve the check once Robin's change [2] is merged:
capable(IOMMU_CAP_CACHE_COHERENCY) could return dev->dma_coherent for
case (1) above.

[1] https://lore.kernel.org/linux-iommu/20220818163801.1011548-1-jean-philippe@linaro.org/
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
