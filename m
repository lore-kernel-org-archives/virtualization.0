Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E82C433F5
	for <virtualization@archiver.kernel.org>; Tue, 23 Nov 2021 15:56:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1030480D9B;
	Tue, 23 Nov 2021 15:56:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id crPMHGr8yzzo; Tue, 23 Nov 2021 15:56:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AE5B580D83;
	Tue, 23 Nov 2021 15:56:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 509E3C0039;
	Tue, 23 Nov 2021 15:56:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EEDEC002E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC6E74025E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VfpqzJRdfMRH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 34B3A400E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 15:56:39 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id b12so39774676wrh.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2h9+eOusicYcP8DCFAdl+7wpFRmfX7bffRGLqx4D/2Q=;
 b=FxlITfJ6MxJai1qOMwtzZY1Mwr0qrN2jCa8ZGdbpEEgJ98AYpdKbApJl6Go9hfgqcE
 8YCA6vjP0mfMhtcMfQl95tUkxhKMNEAzTPFDzr6K/zvKHiSzPS+D5pOa1UKhqXtYKewN
 H+a/GM55YSlJ1L+PaDc33vw9yxogKe8+INGI9DqIDELEyBxd+XAQ4w+y9kl+cF2InX6Q
 lOuKRqFJPA6ONElBqRiD7xFGouZ1+uwKQqRnzqzbBHMw/G8C2E4Jt8bEZohWa+OMEIUH
 hx5qNERj9+3fm8uMfMC+d5Hmy0CLcNq9QluVI+wx3ev7HDrK26FawZQGUjA6UPhxE99+
 LsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2h9+eOusicYcP8DCFAdl+7wpFRmfX7bffRGLqx4D/2Q=;
 b=XCcMQvmBonlu8TJS/ck0wZ7BY4xD5FJ2L/tfmszWLgc5oV+MUUmNEtxqQhm/LZV8Qz
 502jtzRRW9nWy21IBpx9wr+v2XT0evnUO9f+FOMnUsBTJ6xXLHcTWzRyFb4Z9Vm0xz8C
 hnKynFqdHYQ3XVaQ5Y8FYq0DxkEGb3TLQGfVs/n+Cjtc85lZ/11TVLaS2+bVslOmhzZJ
 +2kUEq6e0sm5M22YjPSswYJydwFkrVBUj3QAftm+F3Ler2OeIaIKDK9a7TOs9Ktdj2/3
 hiYq+6hR0gsuUsX1kfsahvO8DSqogdmv8kS8xJCPqtyrYkSJ1CJCC65UiaO2cDh9JiDK
 WF0g==
X-Gm-Message-State: AOAM533s6eflVqZDj5/tA1+ox7MtGWXqqesXZqhKT6uv+nChIQRIomKB
 skGMqiBUoIHtJjr5crcXsSwvDQ==
X-Google-Smtp-Source: ABdhPJxE/ueRhpKmoEAe0x7ByieCf1bstJi80kJ8JOsohjcAgrt5vQZPfOlTM4IpVq/jmmdrlS7A9g==
X-Received: by 2002:a05:6000:15c6:: with SMTP id
 y6mr8371349wry.422.1637682997211; 
 Tue, 23 Nov 2021 07:56:37 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r15sm1532572wmh.13.2021.11.23.07.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 07:56:36 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: joro@8bytes.org,
	will@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 0/5] iommu/virtio: Add identity domains
Date: Tue, 23 Nov 2021 15:52:57 +0000
Message-Id: <20211123155301.1047943-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
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

Support identity domains, allowing to only enable IOMMU protection for a
subset of endpoints (those assigned to userspace, for example). Users
may enable identity domains at compile time
(CONFIG_IOMMU_DEFAULT_PASSTHROUGH), boot time (iommu.passthrough=1) or
runtime (/sys/kernel/iommu_groups/*/type = identity).

Since v1 [1] I rebased onto v5.16-rc and added Kevin's review tag.
The specification update for the new feature has now been accepted [2].

Patches 1-2 support identity domains using the optional
VIRTIO_IOMMU_F_BYPASS_CONFIG feature, and patches 3-5 add a fallback to
identity mappings, when the feature is not supported.

QEMU patches are on my virtio-iommu/bypass branch [3], and depend on the
UAPI update.

[1] https://lore.kernel.org/linux-iommu/20211013121052.518113-1-jean-philippe@linaro.org/
[2] https://github.com/oasis-tcs/virtio-spec/issues/119
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
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
