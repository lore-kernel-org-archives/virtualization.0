Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59E1C6FD18
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 12:49:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43A6984634;
	Fri, 31 Mar 2023 12:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43A6984634
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NEQgqF+D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d9EDoETVIsrj; Fri, 31 Mar 2023 12:49:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DE7A28463D;
	Fri, 31 Mar 2023 12:49:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE7A28463D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01C63C008E;
	Fri, 31 Mar 2023 12:49:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 619C1C0096
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E694A4018E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E694A4018E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=NEQgqF+D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rF1zqEoZMgL8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27006420B4
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27006420B4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680266950; x=1711802950;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Eo9ktw9RcBR0AUmVN45QqOpaJXrZnaTXuwkfh+DnAe4=;
 b=NEQgqF+DiVOpLbDpjgUsIx3a1X+Wt5UdCcy6jDjbjBBaioLPGVomnkq9
 NqjHyJswCdl4H4oTAJ6G40kc0LUN2fyjqfopA4Ok40ggI9B5mkYMxp6X6
 s7vcxubKYTIj0foUj9PJZrcPrPpOSHqWAi+plsKSYrYRecfqL2B8LXSNW
 x2xnewhf3dJrbN9NsN/JgMj4Hbgz0ljNgCKPoHASMlo3YHAk6r6Tj8Yqr
 OpTgEEBJHNZrgFn/dcvUaJ//5jmfZg2pnojQGbMqlYFfHWGxobJioXSbX
 7X+/MA4L+VjVaPFu6P7deVGqXSGXeIIPxPjN+LeKxFEFQBRTUG1P1YjbZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404162348"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="404162348"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 05:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="931155950"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="931155950"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2023 05:48:58 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 0/5] vDPA/ifcvf: implement immediate initialization mechanism
Date: Sat,  1 Apr 2023 04:48:49 +0800
Message-Id: <20230331204854.20082-1-lingshan.zhu@intel.com>
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

Zhu Lingshan (5):
  virt queue ops take immediate actions
  get_driver_features from virito registers
  retire ifcvf_start_datapath and ifcvf_add_status
  synchronize irqs in the reset routine
  a vendor driver should not set _CONFIG_S_FAILED

 drivers/vdpa/ifcvf/ifcvf_base.c | 162 +++++++++++++++++++-------------
 drivers/vdpa/ifcvf/ifcvf_base.h |  16 ++--
 drivers/vdpa/ifcvf/ifcvf_main.c |  97 ++++---------------
 3 files changed, 122 insertions(+), 153 deletions(-)

-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
