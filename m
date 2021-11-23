Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEBFC433EF
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 15:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5BBAB40432;
	Tue, 23 Nov 2021 15:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OA6D-_BgVYAs; Tue, 23 Nov 2021 15:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CD37400E1;
	Tue, 23 Nov 2021 15:56:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E1F8C003E;
	Tue, 23 Nov 2021 15:56:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E38CC0031
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECC9F80D3E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jsNAR1JzkpY2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D993E80D2A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:41 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id a18so3211968wrn.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dQEeEtqyWMKpnKijDTiwXcpp3sArP6LYVWQBTfTX5pw=;
 b=DnORQJb151Y68o1Xq5C1bs+ehBs7egIy8Zf7m9EhobNyNkNltfk9nluQfV6vg+k3af
 erkLDX0T5xUVEXpH5SfY9woZiSaofhLW0KKmsf7S8dCOShjjBwlIh6h9Bg86OM/t9Ys2
 7KUoC8jlteZiEN7JG6PwBNNBv2kBubdv54mskqFP3aA+VlWWZdD6X6xfK3ziJBrOzf0t
 AeMXqPvmhpfwNLuKdrBsRd47bmijs+HtSCPQEjXA5wim33MpmaEy/KwNonOhWvaobqmC
 mNIW0gMTfppFjFp4NdzmviZQSrLvoLeRsA6LvAwHRrHmKIjCkLaG2rk4ezXrAMi6fj7M
 1COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dQEeEtqyWMKpnKijDTiwXcpp3sArP6LYVWQBTfTX5pw=;
 b=k5sl7+BK9+tKWi8jJ/PmdnDIX7zSQ068iT4wz+l1gZGJtLsVZik0flDXA6ag//QLPP
 jWXdYrrfyxssBLuuj07/gNeXDda+yEgjME4n4KUH//uKSQenhqlriExznIiCc3TfHNSr
 w95cUvGrZ0wQwavFym2LGnq42disHMu0SQ8MUyAC5VMxsrbpQ8IPKT38tLuQ7mfWYQ2H
 OEOzX3ioxxS5ovR+9L5toZAMwtRFJGnpBxMNde9FstB03cp9OJ/0BcUOccN6uN+OCYtJ
 WHxQauhSsXf70gXE+tMK+GnGwTeiJt0ouejaVHPYzilnplFqJFPgTmDKYjGps68KIdOn
 LHSg==
X-Gm-Message-State: AOAM5308BR6+qYBizrXhh68pWhDOGfYj8pd3HtvdHLQhMeE/Mg8yfy4y
 kkck8B5VbvbkqdKDv5gcel4fVg==
X-Google-Smtp-Source: ABdhPJxT/I0BtNdu9fjPi/ENgWGb2FgYhYgcB+hKaYupajDlliAWaWM2yGA2SVIFcUq31yQZKtvE0Q==
X-Received: by 2002:a05:6000:120a:: with SMTP id
 e10mr8639359wrx.156.1637683000160; 
 Tue, 23 Nov 2021 07:56:40 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 07:56:39 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 3/5] iommu/virtio: Sort reserved regions
Date: Tue, 23 Nov 2021 15:53:00 +0000
Message-Id: <20211123155301.1047943-4-jean-philippe@linaro.org>
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

To ease identity mapping support, keep the list of reserved regions
sorted.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
