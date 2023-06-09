Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFC1C7EE2E
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 08:22:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6EBF8402DC;
	Fri,  9 Jun 2023 08:22:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6EBF8402DC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UfOc9h69
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZ2XlnuFjz1Q; Fri,  9 Jun 2023 08:22:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0BA2E4015E;
	Fri,  9 Jun 2023 08:22:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BA2E4015E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D766EC007A;
	Fri,  9 Jun 2023 08:22:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FA17C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 666D7402DC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 666D7402DC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FD08cFGAcj-t
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3978D4015E
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3978D4015E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686298939; x=1717834939;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lOEZo56z5dpwqItP2zsKo9eL1v0moR1zXALkXEFrjbg=;
 b=UfOc9h69e3IW/RPiwPqr3pobme15aL9B0x21Xc3B3P7MsLRLg8822brc
 /soi050NNiDT5hYf8HW+Ol0PcWg7gNCaHHSMqY57REuHXq9Dz7uumdAnx
 jNA/7SJwEMrTR97OYbu01VFXi5nT9rN8QW8+jLpn+bqPQ08akLUUts0eg
 ai5aD9Ia6nw59yIvraVCshpW0e2ZUA6h/DRTEqqSoypZmlBf0NwkFDkyZ
 lcAcdFDUWNxlebRz4b5Z3M4crKm00GpOftbwrYP6IHU1yAat5ouCgrLCc
 9zu0ZIKIgpt1i3UMroTxqRqYxU8ECzT4GsQd8AicYBXTt5NLMFf44yJR7 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342221800"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="342221800"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2023 01:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713423253"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="713423253"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 01:22:16 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 0/3] vDPA/ifcvf: enable virtio-net on Intel F2000X-PL
Date: Sat, 10 Jun 2023 00:21:57 +0800
Message-Id: <20230609162200.875433-1-lingshan.zhu@intel.com>
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

Hi

This series enables vDPA/ifcvf support for virtio-net devices
on Intel F2000X-PL Infrastructure Processing Unit.

Please help review

Thanks!

Zhu Lingshan (3):
  vDPA/ifcvf: dynamic allocate vq data stores
  vDPA/ifcvf: detect and report max allowed vq size
  vDPA/ifcvf: implement new accessors for vq_state

 drivers/vdpa/ifcvf/ifcvf_base.c | 55 +++++++++++++++++++++++----------
 drivers/vdpa/ifcvf/ifcvf_base.h | 26 +++++++---------
 drivers/vdpa/ifcvf/ifcvf_main.c | 10 ++++--
 3 files changed, 58 insertions(+), 33 deletions(-)

-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
