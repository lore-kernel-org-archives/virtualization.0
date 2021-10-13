Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8F6C4332F
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99ECB60F23
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 99ECB60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 939C5404E3;
	Wed, 13 Oct 2021 12:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 79aSK0KPqz-O; Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D29B2404E0;
	Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB52C0030;
	Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4D53C0025
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 780284079A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B5l21QU3usit
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B2F3440786
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:26 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id e12so7719165wra.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A6DSifL4Yts5kTfmPDnFhvGppRKiGXEIVl3BMBlbPaI=;
 b=XwFWojMRjL9F42Ltl6vOSbC6mDSbQHYslhSn4DrOPGXtgKjRAmyQRQHg+oS1y5eBCM
 0b2XoxV49nrQqpFqmQKqLGqIJz4H1NmQLDoFSMQgJBAhEacqR9xquR5ATjXJNcjxq1C2
 nBdHn/b8lj8lAdJjE6EBdbxr1VIEDoZ3BHHx+zxwZULFrgevtWQisIWMV/SWW/4cAcI/
 38U2kuqYux25OqEPpRHtIw9WXGRddlNG0iJccWCHXtsVcf4zK6dukzux/lP1bKJOqHvL
 uM6LoMGIkTzh6efprmZNExeQ5ohOAMqRZ8vK0OJH9Irn4+6Ht3ebfnX1VbVkpQ6pxtE6
 KhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A6DSifL4Yts5kTfmPDnFhvGppRKiGXEIVl3BMBlbPaI=;
 b=R4NVwg17WeM/kHLpbZYLNuauJQnEmmdse0lMkAgxNXxi6Hh/ANUQ0Jp1OUhuMc3zYF
 H2fjOgfSS492S12zQ8q/R8ietsPzu4GqAlgb2vtgYjWjI8ARfF64E/StTIMSGuEw+AFG
 54Q6hrPOeLhviowKpNfmn5g+4LmMJp2ePI8UoXbCG+lHXqZpocrKDD69XZk7xKWi+WEm
 qpDNMFBWzMDWZNdI76XFzR3D0PkDeBMWNyK8NPRoVvjN7yiVN4dz7vdK+lydM9k2MBfK
 qpHKMGqDcHZdyAV0SimmlGEzsI1yqbYggnEdwsSobqaL8m3zjT7cLaAp5RbGXvNBwS84
 IeQQ==
X-Gm-Message-State: AOAM533WcfB4IX+jdADJ25mK9RxEjOg4A7qbXWgNAKK51krqPoCh5g2y
 MRh0HXsP+RF/rwjpWq4dS9JmcnlJdy3ztg==
X-Google-Smtp-Source: ABdhPJzuyyIKeSGKy7OC7iVyaV0ex8ARCzd0cydlGVme6JFrJzpiB1GAGb0RVJjN+AeqZunJDQpJLQ==
X-Received: by 2002:a1c:2586:: with SMTP id
 l128mr12429236wml.109.1634127504800; 
 Wed, 13 Oct 2021 05:18:24 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id j13sm4116091wro.97.2021.10.13.05.18.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:18:24 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
Subject: [PATCH 3/5] iommu/virtio: Sort reserved regions
Date: Wed, 13 Oct 2021 13:10:51 +0100
Message-Id: <20211013121052.518113-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013121052.518113-1-jean-philippe@linaro.org>
References: <20211013121052.518113-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 joro@8bytes.org, eric.auger@redhat.com, sebastien.boeuf@intel.com,
 will@kernel.org
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

To ease identity mapping support, keep the list of reserved regions
sorted.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/virtio-iommu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index ee8a7afd667b..d63ec4d11b00 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -423,7 +423,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	size_t size;
 	u64 start64, end64;
 	phys_addr_t start, end;
-	struct iommu_resv_region *region = NULL;
+	struct iommu_resv_region *region = NULL, *next;
 	unsigned long prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
 	start = start64 = le64_to_cpu(mem->start);
@@ -454,7 +454,12 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	if (!region)
 		return -ENOMEM;
 
-	list_add(&region->list, &vdev->resv_regions);
+	/* Keep the list sorted */
+	list_for_each_entry(next, &vdev->resv_regions, list) {
+		if (next->start > region->start)
+			break;
+	}
+	list_add_tail(&region->list, &next->list);
 	return 0;
 }
 
-- 
2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
