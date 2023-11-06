Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C11C4167D
	for <virtualization@archiver.kernel.org>; Mon,  6 Nov 2023 07:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 05B1841DE3;
	Mon,  6 Nov 2023 07:14:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05B1841DE3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NQZxqehO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RFmXTbIrt8iQ; Mon,  6 Nov 2023 07:14:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6F98841DCA;
	Mon,  6 Nov 2023 07:14:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F98841DCA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 485B3C0071;
	Mon,  6 Nov 2023 07:14:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DDCCC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06F3C61043
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:14:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06F3C61043
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NQZxqehO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9TAF6Hl7vG8p
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:13:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 55F1B61038
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Nov 2023 07:13:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55F1B61038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699254839; x=1730790839;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=E6/kgqA9Lo5JBiyk0XaJAk9Nzct4odqOsifYkRlm8ZI=;
 b=NQZxqehOr5giCw/JVIsO+cd6Gz6KO3yg5FbgSEA2VP51gXj5nU8zDfFq
 cBFIEbCFUl3KLgnwpi/TmHfwYN9G9NPLiR9D1l5H/erbJE9Vn4N1EhRhV
 /VyvTosKJvaGSg5VWA2dr8Cs/0Qp4O26dComYRLJfHsSFSQ0hq/0R8jTk
 wCGTGDu5KR4ECfTcfnnJWGQLWXjQHv1Hh+TwEVxsxKYWRm1w8pqp2Vi1G
 C1zGNZMg+lJureajyEe0rEKMAkTVz/B3Eq80EpHtxEw7IrjszU5t/ROFw
 +oepM/bzHkqyVZ03nqIDpE0nAtgoSpLF1uGIBKgwdF5OZ5x8eDkWtQLp7 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10759034"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; d="scan'208";a="10759034"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2023 23:13:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093690826"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; d="scan'208";a="1093690826"
Received: from sqa-gate.sh.intel.com (HELO localhost.localdomain)
 ([10.239.48.212])
 by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 23:13:55 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 joro@8bytes.org, will@kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: [RFC PATCH 0/5] virtio-iommu: Add VT-d IO page table
Date: Mon,  6 Nov 2023 02:12:21 -0500
Message-Id: <20231106071226.9656-1-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

The proposal about virtio-iommu support page tables is being discussed in
the virtio-comment mailing list[1]. This patch-set based on Jean's
virtio-iommu/pgtables branch[2] tries to follow the proposal and add the
basic VT-d IO page table support to virtio-iommu.

On Intel platform with VT-d nested translation enabled, there are two
main benefits for enabling virtual IOMMU support VT-d IO page table:
1) Allowing vSVM (aka vSVA) usage. Virtual Shared Virtual Addressing
   (vSVA) allows the virtual processor and virtual device to use the
   same virtual addresses.
2) Accelerating DMA buffer map operation for vIOVA usage by removing
   the context switch on DMA buffer map operation.
(Note: this patch-set doesn't include the whole patch-set for enabling
vSVM on virtio-iommu, only includes the part for vIOVA case. However,
the vSVM enabling patch-set needs to base on this patch-set.)

There are three changes in this patch-set:
1) The first patch is a bug fixing patch that tries to resolve an issue
   about IOTLB invalidation request with incorrect page size.
2) The next 3 patches are about adding generic IO page table support to
   VT-d driver.
3) The last one introduces the VT-d page format table to virtio-iommu
   driver.

The patch-set is also available at github:
https://github.com/TinaZhangZW/linux/tree/vt-d-pgtable

The QEMU part is available here:
https://github.com/TinaZhangZW/qemu/tree/virtio-iommu/vt-d-pgtable


[1]:https://lists.oasis-open.org/archives/virtio-comment/202310/msg00018.html
[2]:https://jpbrucker.net/git/linux/log/?h=virtio-iommu/pgtables

Tina Zhang (5):
  iommu/virtio-iommu: Correct the values of granule and nr_pages
  iommu/vt-d: Add generic IO page table support
  iommu/io-pgtable: Introduce struct vtd_cfg
  iommu/vt-d: Adapt alloc_pgtable interface to be used by others
  iommu/virtio-iommu: Support attaching VT-d IO pgtable

 drivers/iommu/intel/Kconfig       |   1 +
 drivers/iommu/intel/iommu.c       | 157 ++++++++++++++++++++++++++++++
 drivers/iommu/intel/iommu.h       |   7 ++
 drivers/iommu/io-pgtable.c        |   3 +
 drivers/iommu/virtio-iommu.c      |  27 ++++-
 include/linux/io-pgtable.h        |   7 ++
 include/uapi/linux/virtio_iommu.h |  26 +++++
 7 files changed, 226 insertions(+), 2 deletions(-)

-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
