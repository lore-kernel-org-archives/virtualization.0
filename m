Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0471BC433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 15:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CF51E400E1;
	Tue, 23 Nov 2021 15:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xVnTLxHFqWuK; Tue, 23 Nov 2021 15:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CAEB140428;
	Tue, 23 Nov 2021 15:56:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0845C002E;
	Tue, 23 Nov 2021 15:56:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84CD0C0039
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E174440222
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 47JZp-L4FmGx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1D3E400E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:40 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id d24so39846212wra.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 07:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ugWhUFc1gcRf18XNXQ74oVCZakMGTKA95AYpxgViHMc=;
 b=x+M+8EL5my60gL5G09sniiQ8J8uguHVYoYCOvljil6+LePL9FCGa7Igef6Qocog/H8
 rEVgDMf7bkAXYeoisiNRVZ1mvqX9tzd9c0h6xiLIgJq+GUzO3b1kXNsKeob9laPaswPv
 JpDOKgfBpCfNTehsQW1tS6urZx+IUPylvHdZMH+ABYcDceir8KyogKBmTvGmL57BRUn1
 zCWjRE/co3OFF29xQQX0Lf/4j33+t0oaSJo9HXEtu7lF1WvNMHMrBLVDib6ZfIB9/TYk
 wyt/P7EfWmf3doK4cSCMjyLJ/23K5P4U67FBDa7s2CwNCmGYFgqANTdPjccUbc2zGm2F
 wEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ugWhUFc1gcRf18XNXQ74oVCZakMGTKA95AYpxgViHMc=;
 b=M3QCI75UxcbwsTLANp4AHP0xe/ukCGTRhwCSs6q4JlcW8Oy23EuLVkS/j8GsWigHNl
 hdzAfN7yC2OnFpYj68wcMrvXbnWdTVIFHFIgJsjAYkbNfvajefzR/cy4yWKA9rfY60qr
 mvDhCM63Y8hDHwzslEHymb4qWXmVwKdbe0IVTE41Ig3Ps07+jK0eSR0in1a0j6b3Egni
 80JP90wmN76ByzmDc3pzF+la0MuQ+Yto8/SOBJmT3lQ5b/38ZD+2Sk+zesGqG4GmQ3bB
 9p/YALcheRVETx/NzfHgaoKHSxfi6+8zhxmhF3vh1ab9r1bC1i+O3R+arE+YJxEvrUS8
 R/JQ==
X-Gm-Message-State: AOAM533YbKXSavcOlCW3JTCdKv00+eoj/mRM0YvlHwKwSEK+TOlrCtVa
 KuALwg0DJPH1so4le+M0E4rE6A==
X-Google-Smtp-Source: ABdhPJz9diLXnunaItvUS4rIsQW2xdw0sxXrVOX+/drk2+7p/TRCGNxIosdJPSGo1HNkd+rDd/zYJg==
X-Received: by 2002:a5d:604b:: with SMTP id j11mr8849450wrt.22.1637682999201; 
 Tue, 23 Nov 2021 07:56:39 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 07:56:38 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 2/5] iommu/virtio: Support bypass domains
Date: Tue, 23 Nov 2021 15:52:59 +0000
Message-Id: <20211123155301.1047943-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211123155301.1047943-1-jean-philippe@linaro.org>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, eric.auger@redhat.com, iommu@lists.linux-foundation.org,
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
index 80930ce04a16..ee8a7afd667b 100644
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
+			vdomain->viommu = 0;
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
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
