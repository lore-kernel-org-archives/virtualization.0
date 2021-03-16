Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD781C433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 19:18:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C7F65028
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 19:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C7F65028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2D9F6068D;
	Tue, 16 Mar 2021 19:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kyGBZTXenuk6; Tue, 16 Mar 2021 19:18:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86BEA60647;
	Tue, 16 Mar 2021 19:18:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5439EC000B;
	Tue, 16 Mar 2021 19:18:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5AC1C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 19:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90ED04C65F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 19:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vot_Zw0XPrS0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 19:18:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ED36547489
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 19:18:39 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 w203-20020a1c49d40000b029010c706d0642so4350917wma.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zdXuSq1MtFWEH67XusLrQERuO71IBN9bklER821sqN8=;
 b=s4NVtxjbXpVnGlId4ipIw5iTpHWbiL/Y/fXzzQ9WAq1M9jTjr8hJmD+u0Y1X2a7D0d
 TNJp1Pog2bUKGIxCsrUlpVLY9/HVfrn6QKfZ5Rj4Dxd8AMivBRKXlXbKHbZH+P0KWOEY
 Sz8nGP+cJLgyR6mklJnqesgsS47g9cq9EIn/j0AoAJ0tyTbGBn8q3JTouZH41Fz4gJBS
 4PpEoKbfSjoDSEnF4uqWL1STLzC5v6fT+VTAsTAD5fvQ15cdq1e6By6PtCjN91nYu6Br
 2s2gl2BgknygB1PCinbKXJKkw9Sj2iIn+K4I1gbzAWXN/bz+Hmn754PN3i9NmC8jkZlI
 2JVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zdXuSq1MtFWEH67XusLrQERuO71IBN9bklER821sqN8=;
 b=eaejw/d5SQOy8IOInbnJNz0exGWYKr+4o+qyzhyZdl2fVIXbCyOstuBP2S7w7sxM7F
 WjoIQHk4gCIZ53APoohZVeSNhiOzk6QY5TZ86uCD/a+vQdVX9/Uqaf1WXzNUA1ZbkKoa
 QQfSuiWRRMqb90OBJRIeHritObhU87D8/1NRJE6y6hE/MkkEiF/7n6nl4l/PSWPoDFEY
 QIvovWKgLKp3vjdOraPBhMWSXRG6xqhKDE3fItXSxUQBZ0/5dFqAaW1MYDGawZnMPcyJ
 ZyMjMtjK3HxVdqktsKU9KvJ8uGPyM8t6NuiDfasAZfGPkxoLu1TAj1qIYBJljts+AUG3
 Iwmw==
X-Gm-Message-State: AOAM5307yBRumBVRuSRHzaq4Fv4aSH0rP5tmD8zRheH4PufEvS4OG3yz
 lXUXA7gUpQA6ZVLWjy1PIk8DKA==
X-Google-Smtp-Source: ABdhPJz0jcae/+Uzho0TthFbPf4pqfFt1iIHk4l3M0JPfNdoif7RmtFH7kwM8PaGGtYtJPuUlNO8uA==
X-Received: by 2002:a7b:c34a:: with SMTP id l10mr364692wmj.46.1615922318165;
 Tue, 16 Mar 2021 12:18:38 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id p12sm22690438wrx.28.2021.03.16.12.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 12:18:37 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: rjw@rjwysocki.net,
	lenb@kernel.org,
	joro@8bytes.org,
	mst@redhat.com
Subject: [PATCH 0/3] Add support for ACPI VIOT
Date: Tue, 16 Mar 2021 20:16:50 +0100
Message-Id: <20210316191652.3401335-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, lorenzo.pieralisi@arm.com, eric.auger@redhat.com,
 robin.murphy@arm.com, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, will@kernel.org
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

Add a driver for the ACPI VIOT table, which enables virtio-iommu on
non-devicetree platforms, including x86. This series depends on the
ACPICA changes of patch 1, which will be included in next release [1]
and pulled into Linux.

The Virtual I/O Translation table (VIOT) describes the topology of
para-virtual I/O translation devices and the endpoints they manage.
It was recently approved for inclusion into the ACPI standard [2].
A provisional version of the specification can be found at [3].

After discussing non-devicetree support for virtio-iommu at length
[4][5][6] we concluded that it should use this new ACPI table. And for
platforms that don't implement either devicetree or ACPI, a structure
that uses roughly the same format [6] can be built into the device.

[1] https://github.com/acpica/acpica/pull/666
[2] https://lore.kernel.org/linux-iommu/20210218233943.GH702808@redhat.com/
[3] https://jpbrucker.net/virtio-iommu/viot/viot-v9.pdf
[4] https://lore.kernel.org/linux-iommu/20191122105000.800410-1-jean-philippe@linaro.org/
[5] https://lore.kernel.org/linux-iommu/20200228172537.377327-1-jean-philippe@linaro.org/
[6] https://lore.kernel.org/linux-iommu/20200821131540.2801801-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (3):
  ACPICA: iASL: Add definitions for the VIOT table
  ACPI: Add driver for the VIOT table
  iommu/virtio: Enable x86 support

 drivers/acpi/Kconfig         |   3 +
 drivers/iommu/Kconfig        |   4 +-
 drivers/acpi/Makefile        |   2 +
 include/acpi/actbl3.h        |  67 ++++++
 include/linux/acpi_viot.h    |  26 +++
 drivers/acpi/bus.c           |   2 +
 drivers/acpi/scan.c          |   6 +
 drivers/acpi/viot.c          | 406 +++++++++++++++++++++++++++++++++++
 drivers/iommu/virtio-iommu.c |   3 +
 MAINTAINERS                  |   8 +
 10 files changed, 526 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/viot.c

-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
