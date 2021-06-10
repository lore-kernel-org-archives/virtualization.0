Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03570C48BD1
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:02:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B019C613DF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 08:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B019C613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87DBA60A40;
	Thu, 10 Jun 2021 08:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s61o55BeB43G; Thu, 10 Jun 2021 08:02:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 29D4560786;
	Thu, 10 Jun 2021 08:02:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5158AC002A;
	Thu, 10 Jun 2021 08:02:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F87FC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B4C18333F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:02:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iak0_6lQb96j
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:02:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44B1983276
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 08:02:48 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id f2so1120069wri.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6d64EfMmKjBsLXuufmWEUBLj9XWA4YjPbU9Y/1wt2B8=;
 b=ObI/IzUukEYxx+7H8+Qf0c5GsgYSNdbZSErulQp+S5M095cDQ63LAs4nqiCOr4OSe0
 i/FNuhtV6CsQXPFO7XOQ6EM/eQxQDqwiYBae+RKq3EOIgwxnwJUnU7d09ygRpJh0rbiS
 WmfD13dPCc27InjhoUw07zaBwR0qqlRJMZrskGrqVpjWJEuhLHcy7PnYvSBzEkMk7Y4C
 X/nPyuSTqbaIwiPMZbeIP5zs4ELOKDWw4c7/dWuPyF1U172DTBtgjmadVm4nASZWRfbM
 M0tjl+lcuIZQH59VeO5Eb0JfSz8aylyM0XkCrZmSE6BhddflN5ZkTX1nTFcqksk8IJHb
 gIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6d64EfMmKjBsLXuufmWEUBLj9XWA4YjPbU9Y/1wt2B8=;
 b=X+iA5ylRgdBtyxzEmk9Fb+3ujT73eqauo4+7w7xIfph1aql43YBpkbM2Z9poqpDxKE
 9CegggFnp5SIhfAnZ07/cpcWJ3ElGzQVk4cGgjLLOpKMh4Yj8AgRehAWU/T2Q1Qf8ZrL
 LhnHoyXcmx4GI7TUs3bOyLBzVMHPCq6FPxi4KsGLzkAyhYEDhaKYo5hifGv85Ggd802w
 IxPVHHqp7gXeXMgYjTByO7NI4JwUOAZ3X3+RPNy/4NoqjwLAzq7UKcrMZZw3cOaKnzz7
 updIV5KGCPJcGqxYw1COLPBBbM1wO5bJeoIqr+cQ2ZxwBJQ/sy4XSA3khKzlU6pC96EN
 LsNg==
X-Gm-Message-State: AOAM5320PAQGKmKiKQkPVrAJPIjsz5WuduSKAzWrOOyQyrYgwciMwedB
 l0PVLINQroCbd9n9SpimTNAPBQ==
X-Google-Smtp-Source: ABdhPJz3GLvas2zyoO7uIAb3y7v6qAeWCy4E0Q2PobZGKURJL4xC2/JOv5xITetYPC0Kt6UtuqclGw==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr3885872wrx.144.1623312166388; 
 Thu, 10 Jun 2021 01:02:46 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch.
 [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id o3sm2715059wrm.78.2021.06.10.01.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 01:02:45 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v4 0/6] Add support for ACPI VIOT
Date: Thu, 10 Jun 2021 09:51:27 +0200
Message-Id: <20210610075130.67517-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, lorenzo.pieralisi@arm.com, eric.auger@redhat.com,
 catalin.marinas@arm.com, sudeep.holla@arm.com, robin.murphy@arm.com,
 virtualization@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com,
 guohanjun@huawei.com, will@kernel.org, dwmw2@infradead.org,
 linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com
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

Add a driver for the ACPI VIOT table, which provides topology
information for para-virtual IOMMUs. Enable virtio-iommu on
non-devicetree platforms, including x86.

Since v3 [1] I fixed a build bug for !CONFIG_IOMMU_API. Joerg offered to
take this series through the IOMMU tree, which requires Acks for patches
1-3.

You can find a QEMU implementation at [2], with extra support for
testing all VIOT nodes including MMIO-based endpoints and IOMMU.
This series is at [3].

[1] https://lore.kernel.org/linux-iommu/20210602154444.1077006-1-jean-philippe@linaro.org/
[2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
[3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi


Jean-Philippe Brucker (6):
  ACPI: arm64: Move DMA setup operations out of IORT
  ACPI: Move IOMMU setup code out of IORT
  ACPI: Add driver for the VIOT table
  iommu/dma: Pass address limit rather than size to
    iommu_setup_dma_ops()
  iommu/dma: Simplify calls to iommu_setup_dma_ops()
  iommu/virtio: Enable x86 support

 drivers/acpi/Kconfig         |   3 +
 drivers/iommu/Kconfig        |   4 +-
 drivers/acpi/Makefile        |   2 +
 drivers/acpi/arm64/Makefile  |   1 +
 include/acpi/acpi_bus.h      |   3 +
 include/linux/acpi.h         |   3 +
 include/linux/acpi_iort.h    |  14 +-
 include/linux/acpi_viot.h    |  19 ++
 include/linux/dma-iommu.h    |   4 +-
 arch/arm64/mm/dma-mapping.c  |   2 +-
 drivers/acpi/arm64/dma.c     |  50 +++++
 drivers/acpi/arm64/iort.c    | 129 ++-----------
 drivers/acpi/bus.c           |   2 +
 drivers/acpi/scan.c          |  78 +++++++-
 drivers/acpi/viot.c          | 364 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c    |   9 +-
 drivers/iommu/dma-iommu.c    |  17 +-
 drivers/iommu/intel/iommu.c  |  10 +-
 drivers/iommu/virtio-iommu.c |   8 +
 MAINTAINERS                  |   8 +
 20 files changed, 580 insertions(+), 150 deletions(-)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/arm64/dma.c
 create mode 100644 drivers/acpi/viot.c

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
