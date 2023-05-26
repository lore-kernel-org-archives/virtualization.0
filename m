Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52F7C7EE23
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 06:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C50540341;
	Fri, 26 May 2023 06:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C50540341
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KvxyawKX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzDhQziziCmc; Fri, 26 May 2023 06:53:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8CBD14026C;
	Fri, 26 May 2023 06:53:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CBD14026C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 615B4C0036;
	Fri, 26 May 2023 06:53:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6E8AC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B51742A7A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7B51742A7A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=KvxyawKX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yvvOjtmXH6sW
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9EC094016B
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9EC094016B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685083993; x=1716619993;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2JEOvI9j75yXFStYsmTj4914VVEl9d41zHRmarAi4Lk=;
 b=KvxyawKX/LZP6alTNOG+9EBGmGl2KPoNfLT32VUjzBI3jieOr+Q6hgnR
 BIJsn8n3BgI2eGwmwfxxpbkuJoruFk7YNYKgAFibqXoj+EvxRtzRl+g5c
 wZGQtjyYK2QmeSUIwabs7oDiLmiBuWj0qiyeh51HQVKHXpMfWull4GEvR
 ztNdEgWGEKAUkBlgpUqHcBv47Zb/uKDJ4hb1mjPDkE1+yTOtQozl7LdNo
 gMYE5jFeivhgSPsueyjVLT8rUV0XLKzBfE/OAxYBY3x8INsvo2Y5d63Rz
 9xUkmGqSkiXLGCc9QAW7WSaRubp1rPSQlZ3BbAVKMH7Y8wXRtN+nf5FE4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="333763355"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="333763355"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 23:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="770241638"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="770241638"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga008.fm.intel.com with ESMTP; 25 May 2023 23:53:11 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V3 0/5] vDPA/ifcvf: implement immediate initialization
 mechanism
Date: Fri, 26 May 2023 22:52:49 +0800
Message-Id: <20230526145254.39537-1-lingshan.zhu@intel.com>
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

Changes from V2:
rename function ifcvf_stop_hw to ifcvf_stop (Jason)

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

 drivers/vdpa/ifcvf/ifcvf_base.c | 148 ++++++++++++++++++--------------
 drivers/vdpa/ifcvf/ifcvf_base.h |  19 ++--
 drivers/vdpa/ifcvf/ifcvf_main.c |  98 ++++-----------------
 3 files changed, 110 insertions(+), 155 deletions(-)

-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
