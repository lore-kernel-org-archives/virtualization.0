Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC59C43217
	for <virtualization@archiver.kernel.org>; Wed,  1 Dec 2021 17:34:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64D7561BD9;
	Wed,  1 Dec 2021 17:34:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9k0L6Q1vKH8f; Wed,  1 Dec 2021 17:34:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AB9F261BEC;
	Wed,  1 Dec 2021 17:34:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 733D4C0054;
	Wed,  1 Dec 2021 17:34:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 909D3C003C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C089607AF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZoPVKnHO2_tz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C225360603
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Dec 2021 17:34:38 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 m25-20020a7bcb99000000b0033aa12cdd33so1283279wmi.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 01 Dec 2021 09:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CuxPNkV5O41/fQWApY7GOUejWwlTjPj2H7KROS4AAs0=;
 b=k3kt73jz9Ej9cg40gvNq6Sm+28bMVp3RuJ4Ddb3lhBc1oRgSK8ma1vTKCUpLJZqRWe
 lnakREec67NZLL++opcdFNIztfR9ktKc+xnhgk/jvfMI0cU83oe8nD9BdnHlBIH3/nW7
 hSstkNtDEDqH/l7dMUzu5jTFiEwPEseV98TVr7Iy9+uSVgSz+MsB2jm1b2+IDMXsjbq7
 JCW8GAosrVZj28K8PQhOIVjjqGub52B+AgROZrczlPnEdnIVcGpBW8A3/7O8wcE3Gfbx
 cfz8UuVOB3GOLNqB+/dkU1ft91gOHnoK2WzwzG436uJ2ya+BGneuIhHzqzd5f52qNExo
 rwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CuxPNkV5O41/fQWApY7GOUejWwlTjPj2H7KROS4AAs0=;
 b=mIY+ylgvnq7FWRMfv2tUASaykGDKzBm3bdrrisO+iOlI+iFxhunDimFf6kZHOQ/ArM
 ciN+cncpQHLxU3Z4Jf8VEPOxQEmGKGIlgOM6GEHENT08KelnkurzxFHG81nScQGpgkAh
 NInSESfQ7M3jWph0Rx3EtyuOxa8EBezOIxXR8IglemjwBAL2F7jeC6uA97QJGGNfA3aQ
 iYnpT/Cc//eSbyOp9gV8jKyAH3hqfJOOfSpAvhn/7p06LnEYsS8LbyD8yE1J3uqGzksb
 lChlsgIjBPV+qy2otoa5r9z400CSDe5waKlot4wEe+vz0YxUkEb6yq9E27zLYwYdn3Vf
 LXcg==
X-Gm-Message-State: AOAM531tGUW+ChIoGjQPHgg4PCLNutmUf7+XyWJJ7U+c+4ufnChDaRPJ
 2jdVN1s3aPBSlY2JF2iIuuRLjQ==
X-Google-Smtp-Source: ABdhPJxjvQH4n954NGc7bg/b/K18KAGI535/RUn+oiM3FYXP2dcDSlVLZQlDmLuXxK3u6G7Lwf/goA==
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr8703977wmj.156.1638380076881; 
 Wed, 01 Dec 2021 09:34:36 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id q8sm360023wrx.71.2021.12.01.09.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 09:34:36 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 2/5] iommu/virtio: Support bypass domains
Date: Wed,  1 Dec 2021 17:33:22 +0000
Message-Id: <20211201173323.1045819-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211201173323.1045819-1-jean-philippe@linaro.org>
References: <20211201173323.1045819-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 eric.auger@redhat.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com
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

The VIRTIO_IOMMU_F_BYPASS_CONFIG feature adds a new flag to the ATTACH
request, that creates a bypass domain. Use it to enable identity
domains.

When VIRTIO_IOMMU_F_BYPASS_CONFIG is not supported by the device, we
currently fail attaching to an identity domain. Future patches will
instead create identity mappings in this case.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 80930ce04a16..14dfee76fd19 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -71,6 +71,7 @@ struct viommu_domain {
 	struct rb_root_cached		mappings;
 
 	unsigned long			nr_endpoints;
+	bool				bypass;
 };
 
 struct viommu_endpoint {
@@ -587,7 +588,9 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
 {
 	struct viommu_domain *vdomain;
 
-	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
+	if (type != IOMMU_DOMAIN_UNMANAGED &&
+	    type != IOMMU_DOMAIN_DMA &&
+	    type != IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
 	vdomain = kzalloc(sizeof(*vdomain), GFP_KERNEL);
@@ -630,6 +633,17 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
 	vdomain->map_flags	= viommu->map_flags;
 	vdomain->viommu		= viommu;
 
+	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
+		if (!virtio_has_feature(viommu->vdev,
+					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
+			ida_free(&viommu->domain_ids, vdomain->id);
+			vdomain->viommu = NULL;
+			return -EOPNOTSUPP;
+		}
+
+		vdomain->bypass = true;
+	}
+
 	return 0;
 }
 
@@ -691,6 +705,9 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		.domain		= cpu_to_le32(vdomain->id),
 	};
 
+	if (vdomain->bypass)
+		req.flags |= cpu_to_le32(VIRTIO_IOMMU_ATTACH_F_BYPASS);
+
 	for (i = 0; i < fwspec->num_ids; i++) {
 		req.endpoint = cpu_to_le32(fwspec->ids[i]);
 
@@ -1132,6 +1149,7 @@ static unsigned int features[] = {
 	VIRTIO_IOMMU_F_DOMAIN_RANGE,
 	VIRTIO_IOMMU_F_PROBE,
 	VIRTIO_IOMMU_F_MMIO,
+	VIRTIO_IOMMU_F_BYPASS_CONFIG,
 };
 
 static struct virtio_device_id id_table[] = {
-- 
2.34.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
