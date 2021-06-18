Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7228C49361
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 15:30:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807A06100A
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 15:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807A06100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EC31839B8;
	Fri, 18 Jun 2021 15:30:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QJwTEC_mmWmr; Fri, 18 Jun 2021 15:30:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DD36783C58;
	Fri, 18 Jun 2021 15:30:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50AACC000B;
	Fri, 18 Jun 2021 15:30:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16929C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0651F839B8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:30:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fdhtqJQPDzde
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:30:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E7668397F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 15:30:20 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id gt18so16474789ejc.11
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eVK2Vu+gdkSV5LfHLO/okFsTWTEsOSEgfh/fTAc+ysQ=;
 b=Uv8r73Tua8U4KIGVT0tadYn9JokQ3OI3UF40iCRRH8Qvy+JxNw6WWAESXCcrpkMZD5
 J9OqykH5gEpxXAEhSSHTNdSIYjDCvQfC/QG8Qn8WOqpOk/qeQwqcYl60Y0zNoDJ5dK9j
 vFVf3RcWUverAnEDhV8qhCSXORG1mEGHmaozp15j3vnM+1mkdqmBUJYcyKYaXKZ8/wX6
 DKVu6y5PKk/i85GATFRvHw3B3h6wkjYcKi++Q057tw7ivkm+LVe+yIYv2dbD8kDGryB8
 pCYO+t5K98NRFj1alr60VtctA8wlN3ilmyWo1HfKQowP1OpJjD8zQHLInL7HqZXFq5Dz
 zsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eVK2Vu+gdkSV5LfHLO/okFsTWTEsOSEgfh/fTAc+ysQ=;
 b=ZWJsAZL1TPSwPI2f1kZ3J27vei36yKhsAvXMGBPlhcIyFWu6iog2VT2QsZcydQn0gX
 vVkvpiC5btClgXBQJ7NO0CxkNpwaiyFuX5uinc+lFFoPE1nK0m2cGvTU8hmaqJepyqOE
 LgHUqw6DRFzbgtLBJ/yMmegWrT+071vl6yJ5EpFFzSTj3POsh84WddaaoO1CsVBZglF4
 beDBceWZIgEfd+vO1CAtE0Ao502CKATqzY8Hz4mAj5Bri/MvyjqmZ++aJz7StvlERhDf
 eCfN6pibLgPWx+9eyjHmJuxEKFt4mhWYw7/8y8+hgpetq6oG1r2L1gBuqnUUT/f0kFeu
 jaQw==
X-Gm-Message-State: AOAM530KmPuwQh7OztM9wE8T7T0furyqW/aWtQjoFp1JX/YEnIlOK93J
 FzTlOkIsf0r8xcR9HypsMILE3Q==
X-Google-Smtp-Source: ABdhPJwqDmkoCnPG0QnncSmTulnYyA+q0tsJhnaPN0fg6rei1NJ1LtMquAgOeQDHr4MnGh/8I10l5Q==
X-Received: by 2002:a17:906:fcaa:: with SMTP id
 qw10mr11511312ejb.233.1624030218335; 
 Fri, 18 Jun 2021 08:30:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch.
 [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id bn7sm1197613ejb.111.2021.06.18.08.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 08:30:17 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH v5 0/5] Add support for ACPI VIOT
Date: Fri, 18 Jun 2021 17:20:55 +0200
Message-Id: <20210618152059.1194210-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.32.0
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

Since v4 [1]:
* Fixes (comments, wrong argument, unused variable)
* Removed patch 5 that wrongly moved set_dma_ops(dev, NULL) into dma-iommu.
  The simplification of limit parameters for x86 callers is now in patch 4.
* Release ACPI table after parsing
* Added review and tested tags, thanks for all the feedback!

You can find a QEMU implementation at [2], with extra support for
testing all VIOT nodes including MMIO-based endpoints and IOMMU.
This series is at [3].

[1] https://lore.kernel.org/linux-iommu/20210610075130.67517-1-jean-philippe@linaro.org/
[2] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/acpi
[3] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/acpi

Jean-Philippe Brucker (5):
  ACPI: arm64: Move DMA setup operations out of IORT
  ACPI: Move IOMMU setup code out of IORT
  ACPI: Add driver for the VIOT table
  iommu/dma: Pass address limit rather than size to
    iommu_setup_dma_ops()
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
 drivers/acpi/arm64/iort.c    | 128 ++----------
 drivers/acpi/bus.c           |   2 +
 drivers/acpi/scan.c          |  78 +++++++-
 drivers/acpi/viot.c          | 366 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c    |   2 +-
 drivers/iommu/dma-iommu.c    |  13 +-
 drivers/iommu/intel/iommu.c  |   5 +-
 drivers/iommu/virtio-iommu.c |  11 ++
 MAINTAINERS                  |   8 +
 20 files changed, 581 insertions(+), 137 deletions(-)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/arm64/dma.c
 create mode 100644 drivers/acpi/viot.c

-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
