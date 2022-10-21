Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44A4C4332F
	for <virtualization@archiver.kernel.org>; Fri, 21 Oct 2022 06:27:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43D57843F7;
	Fri, 21 Oct 2022 06:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 43D57843F7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=loSRt9ok
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X54Ey0ZjGHfw; Fri, 21 Oct 2022 06:27:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E23C3843D9;
	Fri, 21 Oct 2022 06:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E23C3843D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC4A4C0032;
	Fri, 21 Oct 2022 06:27:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA2ABC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 06:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9798B843EB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 06:27:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9798B843EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1izfVcCbHAJO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 06:27:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECCE8843D9
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECCE8843D9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Oct 2022 06:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666333659; x=1697869659;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JR2Ej9sMDTPdzXZaqlO8V8artslbt8VzaADI4VUIdSo=;
 b=loSRt9ok+i7w/m1NERwALAJhASf94hpXLkxoYdCB+YCPvhRjvZtHXv4k
 RZ0odjgxNWvn/ACfxe9jahkySXBoB6y3IufPIcM4DCRPl6GW2+QQYPBvh
 +chNPRWMvkKS9/4T9kTNpae+FNnSDlx/g4ndTtMrm4aX0CTIARCLSm8Qd
 WstRmJlC/GImHusuLDc2kZtQOGBume64N/YLINClkL4oWn72AdxEA34Pz
 TkKm71+eKzl72hwbvpYZshlDDjIJnQmteB6mZ7isgM3NVXwNphvqXv4Ge
 4J36KpfYpPdI2KGsFygC/fUWx2BhQXxiNDrswNAOR0ma2irbXPGGliBW9 A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="294321575"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; d="scan'208";a="294321575"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2022 23:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="735358026"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; d="scan'208";a="735358026"
Received: from d8bbc18b98c6.jf.intel.com ([10.54.241.152])
 by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2022 23:27:38 -0700
From: shaoqin.huang@intel.com
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 0/2] virtio: use helper function is_power_of_2()
Date: Thu, 20 Oct 2022 23:27:32 -0700
Message-Id: <20221021062734.228881-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

From: Shaoqin Huang <shaoqin.huang@intel.com>

Use helper function is_power_of_2() to check if num is power of two.
Minor readability improvement.

Shaoqin Huang (2):
  virtio_pci: use helper function is_power_of_2()
  virtio_ring: use helper function is_power_of_2()

 drivers/virtio/virtio_pci_modern.c | 2 +-
 drivers/virtio/virtio_ring.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
