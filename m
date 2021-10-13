Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C475C4332F
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE17610FB
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4DE17610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FBDD82BC8;
	Wed, 13 Oct 2021 12:18:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A-gkHScOCiBI; Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A4D3C82B94;
	Wed, 13 Oct 2021 12:18:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AD18C0023;
	Wed, 13 Oct 2021 12:18:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5AFDC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 889BF608B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pcXO6FereeLC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CC9896081B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:24 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id e3so7570275wrc.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZD3Ok2TwliENFGvIwPCFSxS2aqiNfZH/LoIWUGMYMKQ=;
 b=s3z9pDFUlv1MO5CAsaxRRjaPrCwv2eo3vMjWabipdZekLL6rB+krS95l5DI0zMzcxO
 Wc3JfWLRNhVIXpUNQOFqDy4QMeMrWd4POurNIWMaNwl3OMY9ejZYcsqEGgzM6WLlB6cg
 Y5wMe/kXxhUeLeL+3s0F1dada5SbJpUqsAIukQy6rMlcxXmBMvbPDvH2nLNQLvGRa8hP
 cHbO/DGgSeoPyMQRuh7DhQP+MgQ10NTxOwAB5CdN64ZzosqdEpin4ZubaZNuiiyOzZlu
 nZFHZneUcqIAIgvACCcu5p+d1+XbqWnhVSG3UvJWpYCbQpJmxEL8oMP4HO1rkkIqQqsY
 JVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZD3Ok2TwliENFGvIwPCFSxS2aqiNfZH/LoIWUGMYMKQ=;
 b=hEIBBvhxDkiRJEOKHvhuJ154kOndAiOmEqYdN9+HzmJPX/YirXfUTJ3HS9AhTkQZDZ
 mZvv3ObNZvqq40738SHLCira3a5rRNRVDjyDdHDvkOJlh6M67j7GSSRdzS5CotHeug0f
 tpl1nVTwIsdsHfUyjM2aropvELmQ88POfNzcovp7yZzXgJsokT4X53NtuL/AAj9DRPHK
 aJC3P5hqjNmFcD4fjP2DWv3k65i9oQP/rOdlxNjkUKhV27ri6unTN6gC7YeXwOTssRwz
 FoG6ItE8DzweT77HWr8PiECSUgAPNDbXYnlVFqY2CwiBQXiOGFYouleNwgeIajaiOgOl
 aFIw==
X-Gm-Message-State: AOAM531ZUad4hlIDD1oI9/0kiO7T/4oGuXVdTvht7/V2RQ2SMsY90Hmf
 r/QkIJhbutRmVqRTOnJ2DjTuy+KYS2sGPQ==
X-Google-Smtp-Source: ABdhPJz8MbguhOLd+szcyryREWwerC5YViQh8/Al2ilQNtNz25jJYyRCE5CNPeIk0mpRCAPzitIwag==
X-Received: by 2002:adf:b355:: with SMTP id k21mr39676160wrd.380.1634127503031; 
 Wed, 13 Oct 2021 05:18:23 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id j13sm4116091wro.97.2021.10.13.05.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:18:22 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
Subject: [PATCH 1/5] iommu/virtio: Add definitions for
 VIRTIO_IOMMU_F_BYPASS_CONFIG
Date: Wed, 13 Oct 2021 13:10:49 +0100
Message-Id: <20211013121052.518113-2-jean-philippe@linaro.org>
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

Add definitions for the VIRTIO_IOMMU_F_BYPASS_CONFIG, which supersedes
VIRTIO_IOMMU_F_BYPASS.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..cafd8cf7febf 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_BYPASS_CONFIG		6
 
 struct virtio_iommu_range_64 {
 	__le64					start;
@@ -36,6 +37,8 @@ struct virtio_iommu_config {
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
 	__le32					probe_size;
+	__u8					bypass;
+	__u8					reserved[7];
 };
 
 /* Request types */
@@ -66,11 +69,14 @@ struct virtio_iommu_req_tail {
 	__u8					reserved[3];
 };
 
+#define VIRTIO_IOMMU_ATTACH_F_BYPASS		(1 << 0)
+
 struct virtio_iommu_req_attach {
 	struct virtio_iommu_req_head		head;
 	__le32					domain;
 	__le32					endpoint;
-	__u8					reserved[8];
+	__le32					flags;
+	__u8					reserved[4];
 	struct virtio_iommu_req_tail		tail;
 };
 
-- 
2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
