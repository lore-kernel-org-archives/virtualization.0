Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8A8C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E5A60F23
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96E5A60F23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 659CD404DC;
	Wed, 13 Oct 2021 12:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RSIxktbEHcen; Wed, 13 Oct 2021 12:18:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0326C40151;
	Wed, 13 Oct 2021 12:18:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92735C0024;
	Wed, 13 Oct 2021 12:18:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 459CAC000F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 350A740796
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KZN9fgwhZ8bG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E6C7C40786
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:18:23 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id r7so7667843wrc.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pPjIam660Z4qDFDZ5/ARiDHZwWgLyql5+D5+sLh4+Po=;
 b=yNEqjtVKyZ4/RDUd2a6SaFQoKLMVweQ6TH+Tt8GtGKj38F1bnOqmRzvAt9Rxfxy0P+
 VpQ5BhYjzuiiAj2YM7VHgCguH643OjqBeeZNGg/66YMZCebMIdcjq6v1KKc+fUcgL62A
 nu3zjkNrMHdrsWq70FHmjPyl4xQ2a1Pz/GbLoezx5PzmaFHL2O1v0RfndXwlumIKhd6g
 WAj245n4B/FV3Kyenv+Slf2rz2f0djl6X9vjdLmH9vgPqKJXtXe+hI4s3o0+6ZOepLlB
 EX+0YxYDQIc0y2Q20UkpTcjXgF3G2bTfH45j+Seb8EAZf6YqgAyCbIN4yZNeBckPafAy
 3vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pPjIam660Z4qDFDZ5/ARiDHZwWgLyql5+D5+sLh4+Po=;
 b=XihUakyOQ7L2eWeLkmGUQLg7cmRygcd6iLq5kilFjST4ziwxib//Uk66BpOt7Lzkvy
 I+nTY4EjMS6Xkr3g1AMK1IjdX9cUbN0EQeE/JlgCY+2xoPUFiSWg7crMWDMCrnn3SH95
 h4ASlX0XBPskdBjLsC0xcZZqMzZc8bl7VhRrUzKH537Caoq3dOZCx5Ttj7O/yte64eZJ
 c0Z8Do6mkWSr5GqD6G6KiDCKsrbQ81NbAEMN83/YLCDfb/Cy8K7/bNiUBKv/nUhCPKGX
 eN+WY3ov1x0bchi6QvLEg0r8UPmw5K1SDIodZBIE+sx7wR4XtXRMEVoXU/05nBaCtWPc
 v6dA==
X-Gm-Message-State: AOAM531AqpeD1BoADbIzbzQ7dl9pDu7JH+DUUD6JEAW45hdGPTgma/yF
 UA/QjyQbElfQ7bRxeCtVnQwkXfm2gTKWxg==
X-Google-Smtp-Source: ABdhPJy70dJr4E78NxlZf8k2zjCDPphm0DXUgU5+Ywi58CgaHuivt9Wd/yazR3X5gVDT112y1HekXg==
X-Received: by 2002:a5d:47cb:: with SMTP id o11mr39182621wrc.184.1634127502066; 
 Wed, 13 Oct 2021 05:18:22 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id j13sm4116091wro.97.2021.10.13.05.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:18:21 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org
Subject: [PATCH 0/5] iommu/virtio: Add identity domains
Date: Wed, 13 Oct 2021 13:10:48 +0100
Message-Id: <20211013121052.518113-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.0
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

Support identity domains, allowing to only enable IOMMU protection for a
subset of endpoints (those assigned to userspace, for example). Users
may enable identity domains at compile time
(CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time (iommu.passthrough=1) or
runtime (/sys/kernel/iommu_groups/*/type = identity).

Patches 1-2 support identity domains using the optional
VIRTIO_IOMMU_F_BYPASS_CONFIG feature. The feature bit is not yet in the
spec, see [1] for the latest proposal.

Patches 3-5 add a fallback to identity mappings, when the feature is not
supported.

Note that this series doesn't touch the global bypass bit added by
VIRTIO_IOMMU_F_BYPASS_CONFIG. All endpoints managed by the IOMMU should
be attached to a domain, so global bypass isn't in use after endpoints
are probed. Before that, the global bypass policy is decided by the
hypervisor and firmware. So I don't think Linux needs to touch the
global bypass bit, but there are some patches available on my
virtio-iommu/bypass branch [2] to test it.

QEMU patches are on my virtio-iommu/bypass branch [3] (and the list)

[1] https://www.mail-archive.com/virtio-dev@lists.oasis-open.org/msg07898.html
[2] https://jpbrucker.net/git/linux/log/?h=virtio-iommu/bypass
[3] https://jpbrucker.net/git/qemu/log/?h=virtio-iommu/bypass

Jean-Philippe Brucker (5):
  iommu/virtio: Add definitions for VIRTIO_IOMMU_F_BYPASS_CONFIG
  iommu/virtio: Support bypass domains
  iommu/virtio: Sort reserved regions
  iommu/virtio: Pass end address to viommu_add_mapping()
  iommu/virtio: Support identity-mapped domains

 include/uapi/linux/virtio_iommu.h |   8 ++-
 drivers/iommu/virtio-iommu.c      | 113 +++++++++++++++++++++++++-----
 2 files changed, 101 insertions(+), 20 deletions(-)

-- 
2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
