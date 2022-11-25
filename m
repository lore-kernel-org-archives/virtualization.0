Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60BBC4332F
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FD3D820CD;
	Fri, 25 Nov 2022 15:06:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FD3D820CD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ex/rhgjS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id koz2GCCEoOoi; Fri, 25 Nov 2022 15:06:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A9BA981EEE;
	Fri, 25 Nov 2022 15:06:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9BA981EEE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77252C0033;
	Fri, 25 Nov 2022 15:06:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65A5DC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32CD381EEE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 32CD381EEE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V1GpQwsDlHbK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C193781ED0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C193781ED0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388783; x=1700924783;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PUaEm/rUny2eMarZqMlMmRul7K0V7EvUBPsD7CJuyYU=;
 b=Ex/rhgjSSC5Fo6oyK3H8/JYgYQEiLlLwftutx7AmEWTY6UsfNDVN2Abd
 9LmgEKL7iR9BXe1xDNY4DsxwKSqJkxzKQUQ6q3kX+3ivAMTCZyiOhGZQd
 FFiyBaEj2PsSkKtPdjK3Y4ZgmEfLFjsAxS/ybwXcbUIMzSmvn5C1cf/zY
 Ha73mN2uJ8huMb04O5QFmbeWFzzDmkYXUIKeog7EARTHfxdAP9wCh4eU5
 xq3uGLxSUmJnGSU1OhJMp5dUfXtbY5WIRsWWbs2s8OvsTNG7YEa408nam
 fwRh0P73lZ4ACl1SNs5u9NETdRP8vVPhNaaQ2rBxQYcjQd9FR7cJKzFr4 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787306"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787306"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240191"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240191"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:20 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 00/12] ifcvf/vDPA implement features provisioning
Date: Fri, 25 Nov 2022 22:57:12 +0800
Message-Id: <20221125145724.1129962-1-lingshan.zhu@intel.com>
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

Examples:
a)The management device supported features:
$ vdpa mgmtdev show pci/0000:01:00.5
pci/0000:01:00.5:
  supported_classes net
  max_supported_vqs 9
  dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

b)Provision a vDPA device with all supported features:
$ vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.5
$ vdpa/vdpa dev config show vdpa0
vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
  negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM

c)Provision a vDPA device with a subset of the supported features:
$ vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.5 device_features 0x300020020
$ vdpa dev config show vdpa0
mac 00:e8:ca:11:be:05 link up link_announce false
  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM

Please help review

Thanks

Changes from V1:
split original patch 1 ~ patch 3 to small patches that are less
than 100 lines, so they can be applied to stalbe kernel(Jason)

Zhu Lingshan (12):
  vDPA/ifcvf: decouple hw features manipulators from the adapter
  vDPA/ifcvf: decouple config space ops from the adapter
  vDPA/ifcvf: alloc the mgmt_dev before the adapter
  vDPA/ifcvf: decouple vq IRQ releasers from the adapter
  vDPA/ifcvf: decouple config IRQ releaser from the adapter
  vDPA/ifcvf: decouple vq irq requester from the adapter
  vDPA/ifcvf: decouple config/dev IRQ requester and vectors allocator
    from the adapter
  vDPA/ifcvf: ifcvf_request_irq works on ifcvf_hw
  vDPA/ifcvf: manage ifcvf_hw in the mgmt_dev
  vDPA/ifcvf: allocate the adapter in dev_add()
  vDPA/ifcvf: retire ifcvf_private_to_vf
  vDPA/ifcvf: implement features provisioning

 drivers/vdpa/ifcvf/ifcvf_base.c |  32 ++-----
 drivers/vdpa/ifcvf/ifcvf_base.h |  10 +-
 drivers/vdpa/ifcvf/ifcvf_main.c | 162 +++++++++++++++-----------------
 3 files changed, 91 insertions(+), 113 deletions(-)

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
