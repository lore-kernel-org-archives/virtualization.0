Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FF1C7EE22
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 10:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 888F481F40;
	Mon,  8 May 2023 10:05:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 888F481F40
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kSSCYgcA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VWevcjkz9eoV; Mon,  8 May 2023 10:05:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D62281F24;
	Mon,  8 May 2023 10:05:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0D62281F24
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDD86C0037;
	Mon,  8 May 2023 10:05:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5A3CC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A5E12418D9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5E12418D9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=kSSCYgcA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dsm_5GqAgIsN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 868EF41739
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 868EF41739
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683540317; x=1715076317;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=aNcF/1v1QaBon+UAqPein4ithDsgQ8+4Iu8nxhwxNMk=;
 b=kSSCYgcAgD+KF8basyeSk7yT0mvFXsCb/RSecluxbtMMNOPUmaoe6oGF
 HkW2PcVfWsJkq1WDtRuct2pVvqC0UI19rK6IUpDqpE+BplR0vWnRGW6jq
 zx9aez+wLShVUtWAom9nTb25RbOVBa66lK7IAcpUrny5rDFKesE4EEYgj
 zmoKxTYOcejiftj2yU3kDoxviZqC+I5odoL8vojhOH/73qjhpxiZDJrWK
 CyAwCSilubdLGLnXO+ShYCwcN0el4w15PCEtkfqKERdmaKFyDPJJPInsF
 FEzYhJVciVFgFX4ZsJJsm+Pkp9jKZ+ies4EKxeviTRWNshBsM68d9O22/ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="338827991"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; d="scan'208";a="338827991"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 03:05:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="842639001"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; d="scan'208";a="842639001"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga001.fm.intel.com with ESMTP; 08 May 2023 03:05:13 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
Date: Tue,  9 May 2023 02:05:07 +0800
Message-Id: <20230508180512.17371-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org
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

Formerly, ifcvf driver has implemented a lazy-initialization mechanism
for the virtqueues and other config space contents,
it would store all configurations that passed down from the userspace,
then load them to the device config space upon DRIVER_OK.

This can not serve live migration, so this series implement an
immediate initialization mechanism, which means rather than the
former store-load process, the virtio operations like vq ops
would take immediate actions by access the virtio registers.

This series also implement irq synchronization in the reset
routine

Changes from V1:
1)pull device status in devce_reset (Jason)
2)simplify the procedure which sycn irqs (Jason)
3)fix typos(Michael)

Zhu Lingshan (5):
  vDPA/ifcvf: virt queue ops take immediate actions
  vDPA/ifcvf: get_driver_features from virtio registers
  vDPA/ifcvf: retire ifcvf_start_datapath and ifcvf_add_status
  vDPA/ifcvf: synchronize irqs in the reset routine
  vDPA/ifcvf: a vendor driver should not set _CONFIG_S_FAILED

 drivers/vdpa/ifcvf/ifcvf_base.c | 146 ++++++++++++++++++--------------
 drivers/vdpa/ifcvf/ifcvf_base.h |  17 ++--
 drivers/vdpa/ifcvf/ifcvf_main.c |  98 ++++-----------------
 3 files changed, 108 insertions(+), 153 deletions(-)

-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
