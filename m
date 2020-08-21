Return-Path: <SRS0=hbIa=B7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7ABC433DF
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:18 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26FF20724
	for <virtualization@archiver.kernel.org>; Fri, 21 Aug 2020 13:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7qrOUgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26FF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C093186D94;
	Fri, 21 Aug 2020 13:16:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kywoZxxbELo8; Fri, 21 Aug 2020 13:16:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 39D8A86493;
	Fri, 21 Aug 2020 13:16:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 205EFC0889;
	Fri, 21 Aug 2020 13:16:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90C5AC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7FA9D8867E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pjRuTVymf7r9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3EA1188615
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 13:16:13 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id l23so1369520edv.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mFxcuowFu0Jv3evIc1dad6n3ZhAX6nITskxpnaVl5+I=;
 b=F7qrOUgTT3E74XyC9jWEuKSCWozpJkqtVAUNfrVyQYb7KuFQaRifAbrV29U+QTgdO7
 svaPN2mULjuJmM9GzglZwFzOSgvsCjum3Skmnma0ZxZOa0TjXvzHG00pItNlS0o+yHHb
 DHKfdTgv1Vsra0RFLIHnHM3PWZPg1i4t79wJcD/ye7C4kl6emXJwM47EZ2fqK9NjHU8Z
 7l+LTNCupWNFida4Mq7tKvQSx5gdmvST6bW+kSiDnNAhy1j/RRW6vu0KYRZKH8ouJXsm
 8/+XKVKeZNzd+4C8Jbsu4oNNebPMyjg8aTlotZFno4GFpdtboKUIpaIYzxudSgt9xQLD
 ZQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mFxcuowFu0Jv3evIc1dad6n3ZhAX6nITskxpnaVl5+I=;
 b=WkctFnGU1AgzQlzVyqrVmkbFHj8cOxgEVBiQqfCY/FBPCBoF6xzDzncR5RGlF7R/jW
 LzY4NWFR+IsFrQ6or2gSG3tGlTvUot1P7y371Mn2EHaekraw8KF3mhXPK5gdP2CZiOzH
 Suht0r7nMt3FnOm25zY1ThUYqghNPJRpRpq4JR/JXVQkr+a3JknmL6PsW860deQ7m7/E
 EfQDQhPmvnlmSgbr6KxCw7mgRi5FTvmj4qwa4qc+hi+AEu65pmuZs6sFujNd05G6yD1V
 pRnQr9/PrwFpXP+wlBjv65zTpM0kmMC15fmWKGdtw1Fav9FdRDoonyU7XHRep1ORazM3
 qgHQ==
X-Gm-Message-State: AOAM530T3dZgCLuL2KpMJT1x8eKtEMyt+Ij9p2sYfQcl3h9NO0lwfitE
 5q+ifYp05kH9GzH8ixzyhnmDJA==
X-Google-Smtp-Source: ABdhPJxSuluZjkQxfsXp9THILY+NXbkzKwWS5DVjT4ygD1u7SdXIMGmAG5nqsAUF8rJME9RMD8pSxg==
X-Received: by 2002:a50:a2e6:: with SMTP id 93mr2650226edm.147.1598015771724; 
 Fri, 21 Aug 2020 06:16:11 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id v4sm1299748eje.39.2020.08.21.06.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 06:16:11 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: iommu@lists.linux-foundation.org,
 virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org,
 linux-pci@vger.kernel.org
Subject: [PATCH v3 4/6] iommu/virtio: Add topology definitions
Date: Fri, 21 Aug 2020 15:15:38 +0200
Message-Id: <20200821131540.2801801-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821131540.2801801-1-jean-philippe@linaro.org>
References: <20200821131540.2801801-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, lorenzo.pieralisi@arm.com,
 mst@redhat.com, joro@8bytes.org, eric.auger@redhat.com,
 sebastien.boeuf@intel.com, bhelgaas@google.com
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

Add struct definitions for describing endpoints managed by the
virtio-iommu. When VIRTIO_IOMMU_F_TOPOLOGY is offered, an array of
virtio_iommu_topo_* structures in config space describes the endpoints,
identified either by their PCI BDF or their physical MMIO address.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/uapi/linux/virtio_iommu.h | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/uapi/linux/virtio_iommu.h b/include/uapi/linux/virtio_iommu.h
index 237e36a280cb..70cba30644d5 100644
--- a/include/uapi/linux/virtio_iommu.h
+++ b/include/uapi/linux/virtio_iommu.h
@@ -16,6 +16,7 @@
 #define VIRTIO_IOMMU_F_BYPASS			3
 #define VIRTIO_IOMMU_F_PROBE			4
 #define VIRTIO_IOMMU_F_MMIO			5
+#define VIRTIO_IOMMU_F_TOPOLOGY			6
 
 struct virtio_iommu_range_64 {
 	__le64					start;
@@ -27,6 +28,17 @@ struct virtio_iommu_range_32 {
 	__le32					end;
 };
 
+struct virtio_iommu_topo_config {
+	/* Number of topology description structures */
+	__le16					count;
+	/*
+	 * Offset to the first topology description structure
+	 * (virtio_iommu_topo_*) from the start of the virtio_iommu config
+	 * space. Aligned on 8 bytes.
+	 */
+	__le16					offset;
+};
+
 struct virtio_iommu_config {
 	/* Supported page sizes */
 	__le64					page_size_mask;
@@ -36,6 +48,38 @@ struct virtio_iommu_config {
 	struct virtio_iommu_range_32		domain_range;
 	/* Probe buffer size */
 	__le32					probe_size;
+	struct virtio_iommu_topo_config		topo_config;
+};
+
+#define VIRTIO_IOMMU_TOPO_PCI_RANGE		0x1
+#define VIRTIO_IOMMU_TOPO_MMIO			0x2
+
+struct virtio_iommu_topo_pci_range {
+	/* VIRTIO_IOMMU_TOPO_PCI_RANGE */
+	__u8					type;
+	__u8					reserved;
+	/* Length of this structure */
+	__le16					length;
+	/* First endpoint ID in the range */
+	__le32					endpoint_start;
+	/* PCI domain number */
+	__le16					segment;
+	/* PCI Bus:Device.Function range */
+	__le16					bdf_start;
+	__le16					bdf_end;
+	__le16					padding;
+};
+
+struct virtio_iommu_topo_mmio {
+	/* VIRTIO_IOMMU_TOPO_MMIO */
+	__u8					type;
+	__u8					reserved;
+	/* Length of this structure */
+	__le16					length;
+	/* Endpoint ID */
+	__le32					endpoint;
+	/* Address of the first MMIO region */
+	__le64					address;
 };
 
 /* Request types */
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
