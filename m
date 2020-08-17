Return-Path: <SRS0=WgBq=B3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368FC433E1
	for <virtualization@archiver.kernel.org>; Mon, 17 Aug 2020 21:52:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC8D2072E
	for <virtualization@archiver.kernel.org>; Mon, 17 Aug 2020 21:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="tQ0FE9hL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC8D2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A35B86A70;
	Mon, 17 Aug 2020 21:52:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ldMRBbW03aw; Mon, 17 Aug 2020 21:52:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D784286A14;
	Mon, 17 Aug 2020 21:52:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD61EC088B;
	Mon, 17 Aug 2020 21:52:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C60AFC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 21:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 91676203DE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 21:52:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KdpKZ16AfhyS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 21:52:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by silver.osuosl.org (Postfix) with ESMTPS id 40CE52035C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 21:52:49 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id a24so16149376oia.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 14:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a6SU4e7qioZa1MSGn21iWR1ma/iTKUTYpUuysCGcy14=;
 b=tQ0FE9hLvaMYPBTVoFLMvapqE3NmtNzvVLom8ama2749kqs+FHz9nxs7AHIJO7mDBv
 K8Q+pQ4G/b4TMv1DEEAJUykFiG2bIYGrU3nC3oR7j6f2NPSzKfCcVFaY4kOAcXUttSVT
 FcQd5pxyrvBzc1oQk+/2JMAu6G+p7dtknI9bruysURWXuQybraU9AWYk41P2rQ/Ugs1V
 KCxO0AsJuqMRVrwiHYTBB1bwM8dzGrwTw+I2FuHbRzUP2Mdhb2OLUMXYWcNu2LS9HUSM
 o/iArU0Mr099iYvhHaRGgPLkM2XevIGWNnpUQKOQ1d+f4UwWeBsVd7zpHvgp1Gst8iud
 sCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a6SU4e7qioZa1MSGn21iWR1ma/iTKUTYpUuysCGcy14=;
 b=OZzoEiTfCVsTeQ2r0tCXIMbBUFNr3xch15OcuwkLFm4wtKee7HYVShBPNP8Df9C8jB
 V127r0Bh4yivyfLGreakCIjCq4l8/Z0i7deuQa5TaqpAYrqunKS+uKcr1p6Ib7Wpvrtc
 dauzF8Rzk6h41TOg2fklU86lYbxmvdcwGVpfL0weQcJpbh34z7iS6Cb3Qk56KCC8FjLq
 zLMSs3sAZnH/rADGV8lEJbIwL0jSUgwppauLZlpPtOA7BqYiMfv30EjbJ6ekf96v+P0E
 STqGS1rszWb7fT0hag0bUGQuqpMydMapEJZ1BnM0vM0ZYOSE//uj2yXHQZ94cFSuBTFA
 Mb6Q==
X-Gm-Message-State: AOAM532mdLzPHeMbslMyr8JU6JCUgGicQUdpflKkTZQjDtE6X5aV6Ln5
 0yWT7nlvJ23+tu82bIq6sdlsAZi8pkp5TlSpEQM=
X-Google-Smtp-Source: ABdhPJxLpxYOD9HqJyjPsE+aMSLqEST9f99mfp5IwRRr6pkeOH6GEyp42pRMo63jP9uxCJQN7toCzQ==
X-Received: by 2002:a17:90b:128e:: with SMTP id
 fw14mr14318007pjb.66.1597699202157; 
 Mon, 17 Aug 2020 14:20:02 -0700 (PDT)
Received: from localhost.localdomain (S0106ac17c8c0ce82.vc.shawcable.net.
 [24.87.214.6])
 by smtp.googlemail.com with ESMTPSA id q10sm20733468pfs.75.2020.08.17.14.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 14:20:01 -0700 (PDT)
From: Tom Murphy <murphyt7@tcd.ie>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] Handle init_iova_flush_queue failure in dma-iommu path
Date: Mon, 17 Aug 2020 22:19:50 +0100
Message-Id: <20200817211951.14794-2-murphyt7@tcd.ie>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200817211951.14794-1-murphyt7@tcd.ie>
References: <20200817211951.14794-1-murphyt7@tcd.ie>
MIME-Version: 1.0
Cc: Heiko Stuebner <heiko@sntech.de>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org,
 Chen-Yu Tsai <wens@csie.org>, Andy Gross <agross@kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>, Rob Clark <robdclark@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lu Baolu <baolu.lu@linux.intel.com>
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

init_iova_flush_queue can fail if we run out of memory. Fall back to no
flush queue if it fails.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
---
 drivers/iommu/dma-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7433f74d921a..5445e2be08b5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -356,9 +356,11 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
 			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
-		cookie->fq_domain = domain;
-		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
-				iommu_dma_entry_dtor);
+		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
+				iommu_dma_entry_dtor))
+			pr_warn("iova flush queue initialization failed\n");
+		else
+			cookie->fq_domain = domain;
 	}
 
 	if (!dev)
-- 
2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
