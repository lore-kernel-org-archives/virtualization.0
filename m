Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D07C7EE2E
	for <virtualization@archiver.kernel.org>; Mon, 12 Jun 2023 07:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ACCC60BC9;
	Mon, 12 Jun 2023 07:14:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1ACCC60BC9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AAOLHQjX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7TUj0MnufQrD; Mon, 12 Jun 2023 07:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A20DC60B73;
	Mon, 12 Jun 2023 07:14:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A20DC60B73
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C785C0037;
	Mon, 12 Jun 2023 07:14:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCB42C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B398140BF0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B398140BF0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AAOLHQjX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZPGqn5Cam2iG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A932403E5
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A932403E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686554083; x=1718090083;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+hWVRnB9cPHWUJ+u5iuBJzAiEQ7xYgIFD5JyqFc0hb8=;
 b=AAOLHQjXFjebJRDSgWN45ec4hO2eJ/BmWWA1quEwp2Wh4q9PMLUAN+10
 3JWSAyF5ZxZGBmLUvTMnkjpphoorfHImLNquDXS4Mw4P1N2DmIRLxv5b4
 utm2iRhNTd8zviYexvdEdva6LoRf1K2FFgd7x1VcEKIkTIdm+Sn5PVqv1
 U6swaFs+PY2OdLRIch9yKXVI4DHObDXLcbW5eg4sahSYpcOS5aQnrq0nE
 gLHB3SAMQuMWDtubcO4bil2Hv6pvSjnQ0whgi53+nqoezPI/nJLDGjmf8
 kaA7KDMeNs4QN2i83DLv/1ajRqjujEtJYZsmIwo5vf3kBzLN509xo+haX w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="444339929"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="444339929"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2023 00:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="661470831"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="661470831"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 00:14:40 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 0/3] vDPA/ifcvf: enable virtio-net on Intel F2000X-PL
Date: Mon, 12 Jun 2023 23:14:17 +0800
Message-Id: <20230612151420.1019504-1-lingshan.zhu@intel.com>
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

This series is rebased on MST's vhost tree, linux-next branch

Please help review

Thanks!

Changes from V1:
1)Rebased on MST's tree
2)Remove IFCVF_MAX_QUEUES and other minor improvements

Zhu Lingshan (3):
  vDPA/ifcvf: dynamic allocate vq data stores
  vDPA/ifcvf: detect and report max allowed vq size
  vDPA/ifcvf: implement new accessors for vq_state

 drivers/vdpa/ifcvf/ifcvf_base.c | 55 +++++++++++++++++++++++----------
 drivers/vdpa/ifcvf/ifcvf_base.h | 29 +++++++----------
 drivers/vdpa/ifcvf/ifcvf_main.c | 10 ++++--
 3 files changed, 58 insertions(+), 36 deletions(-)

-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
