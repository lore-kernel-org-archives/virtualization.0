Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EDEC433FE
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 09:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 939334033C;
	Mon,  7 Nov 2022 09:42:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 939334033C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=juh4APVY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fLg4ae7QrfF7; Mon,  7 Nov 2022 09:42:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F169E40325;
	Mon,  7 Nov 2022 09:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F169E40325
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D35A3C0032;
	Mon,  7 Nov 2022 09:42:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 026A9C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CFF30404FC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFF30404FC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=juh4APVY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tVuJZ6D6pGd9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6C56C40391
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6C56C40391
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667814139; x=1699350139;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fiKv0pdnXdluc73wvAqeI7JGHQLm9IbFYrJKBmjYOz4=;
 b=juh4APVY4egRN14E44T5Gcar/P509dprpMjxoH4RjAkWikwZHT///Irm
 TeCEiyjbbr5Uvdf1Kde4OVn/Mqu74NTLhWdHJmDFf9tR9okJFV1WlLOrl
 BtNAnb7VGutv3Z32dzXXJ3dFgXQLaz+tAgb+u/YKTzO2hPoxis++WiIMV
 aLC9ECsVaG+NSq+z7TSw5Iue8mXQljz5iJplIo14axmdig399RqXDaCd3
 5H632HCtd4FiPgp1SAEm8q0MiKOsJiBEUzBElBh22B/DKOtb6Lr4E47Oi
 OwQadkc4a86nRps1M6szuss4W2Xj/3QJWq2g7I+PDxaDw1UjsNn63X9WP Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="396668843"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; d="scan'208";a="396668843"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2022 01:42:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="704810795"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; d="scan'208";a="704810795"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2022 01:42:16 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH 0/4] ifcvf/vDPA implement features provisioning
Date: Mon,  7 Nov 2022 17:33:41 +0800
Message-Id: <20221107093345.121648-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: piotr.uminski@intel.com, hang.yuan@intel.com, kvm@vger.kernel.org,
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

This series implements features provisioning for ifcvf.
By applying this series, we allow userspace to create
a vDPA device with selected (management device supported)
feature bits and mask out others.

Please help review

Thanks

Zhu Lingshan (4):
  vDPA/ifcvf: ifcvf base layer interfaces work on struct ifcvf_hw
  vDPA/ifcvf: IRQ interfaces work on ifcvf_hw
  vDPA/ifcvf: allocate ifcvf_adapter in dev_add()
  vDPA/ifcvf: implement features provisioning

 drivers/vdpa/ifcvf/ifcvf_base.c |  32 ++-----
 drivers/vdpa/ifcvf/ifcvf_base.h |  10 +-
 drivers/vdpa/ifcvf/ifcvf_main.c | 156 +++++++++++++++-----------------
 3 files changed, 89 insertions(+), 109 deletions(-)

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
