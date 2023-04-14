Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F9CC77B6E
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 15:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 013E160BAB;
	Fri, 14 Apr 2023 15:12:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 013E160BAB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sHOIntrx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2D6gw5Ivvpne; Fri, 14 Apr 2023 15:12:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 873A160C13;
	Fri, 14 Apr 2023 15:12:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 873A160C13
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56F9FC0037;
	Fri, 14 Apr 2023 15:12:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E063FC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 15:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B346060BBB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 15:12:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B346060BBB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SCjg0qs9nBVn
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 15:12:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CF0660B19
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2CF0660B19
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 15:12:03 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 d8-20020a05600c3ac800b003ee6e324b19so9971989wms.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1681485121; x=1684077121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fGndh23ci0NG/qxJMvZcia5Fbbz6IQHdr0UISxwOqvc=;
 b=sHOIntrxl6oK5QB4mGnSAK4orpW3A+vpY0JVxMNpcCRPoBMhQkFB2h121qwblj0sK7
 Fqeco22GrFRtTYFiEyT8BopH4T9fy+/nDcMgmBbTk7vSu9J8i44z61te8oUSwRr3bXl3
 D3qElxC5xoSZ6HIPlFgg5RHJdkN9sxqwhnUcqzJKlOo3DwnLK1f0LiSv8CZiJaCCWGw9
 5RgpBqLdCmuqh9O/YnT0k/ZOJGm2kOKFS+hkMs0vavZrjc53ZKPbbtgpAv237MVJ9V4G
 +WSQIwSnhsdRuG8Pee8KGctF8045xwFUL3Z0Qz9fDnA/6Lvhu47jmmE9ozBTTKxC48Kg
 WFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681485121; x=1684077121;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fGndh23ci0NG/qxJMvZcia5Fbbz6IQHdr0UISxwOqvc=;
 b=KM0EK+QuhozBkdgOS+5tIcUuK40StgS9TV3qAt8arqD1oCh3NQ6zbCVHY6apFfSdA6
 tb35z3fn5r62E+sa/p+xpcSjLSL9vIMMhXrSePG3zOAalcupeP6LX24w+TyHdNJAxKt3
 XimDvb+nNh22YfXuDvDtlKmJQD6W0FduhlBFDikl0jRUKPxxWjQ03wAZtW9rIzEeGfTM
 FqKwjhjQkcvey77PHDMHV85jQshVeyWXLgAZfOOsClXULjIBJK17jaSSE0vmD7adqW49
 3Vltf6piyWTMUdi64w3XVz+Bkvt9osTVMGNI5URYWTr0D50FNzVS1jlzras9v1lOYS7E
 s1+Q==
X-Gm-Message-State: AAQBX9f2WUaFeH2/ItsSqlm+97UrhDFI4Yk37EU9K2cao78NXGwZR3S/
 SG2XXhe7RNavsvgUqjVcwBkNZQ==
X-Google-Smtp-Source: AKy350bO3qOiPJ+Vk7/7iHsWjVOfKH4KpjFVsU11XW/qvxNENhKYYADSOXszgx5+KvjxYLnNqQHe+Q==
X-Received: by 2002:a1c:6a05:0:b0:3ee:42fd:7768 with SMTP id
 f5-20020a1c6a05000000b003ee42fd7768mr4573637wmc.1.1681485121054; 
 Fri, 14 Apr 2023 08:12:01 -0700 (PDT)
Received: from localhost.localdomain (054592b0.skybroadband.com.
 [5.69.146.176]) by smtp.gmail.com with ESMTPSA id
 iz11-20020a05600c554b00b003f09aaf547asm10217839wmb.1.2023.04.14.08.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Apr 2023 08:12:00 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH] iommu/virtio: Detach domain on endpoint release
Date: Fri, 14 Apr 2023 16:07:45 +0100
Message-Id: <20230414150744.562456-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, akihiko.odaki@daynix.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
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

When an endpoint is released, for example a PCIe VF is disabled or a
function hot-unplugged, it should be detached from its domain. Send a
DETACH request.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Link: https://lore.kernel.org/all/15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com/
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 5b8fe9bfa9a5..3d3d4462359e 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -788,6 +788,28 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
+static void viommu_detach_dev(struct viommu_endpoint *vdev)
+{
+	int i;
+	struct virtio_iommu_req_detach req;
+	struct viommu_domain *vdomain = vdev->vdomain;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(vdev->dev);
+
+	if (!vdomain)
+		return;
+
+	req = (struct virtio_iommu_req_detach) {
+		.head.type	= VIRTIO_IOMMU_T_DETACH,
+		.domain		= cpu_to_le32(vdomain->id),
+	};
+
+	for (i = 0; i < fwspec->num_ids; i++) {
+		req.endpoint = cpu_to_le32(fwspec->ids[i]);
+		WARN_ON(viommu_send_req_sync(vdev->viommu, &req, sizeof(req)));
+	}
+	vdev->vdomain = NULL;
+}
+
 static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			    int prot, gfp_t gfp, size_t *mapped)
@@ -990,6 +1012,7 @@ static void viommu_release_device(struct device *dev)
 {
 	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
 
+	viommu_detach_dev(vdev);
 	iommu_put_resv_regions(dev, &vdev->resv_regions);
 	kfree(vdev);
 }
-- 
2.40.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
