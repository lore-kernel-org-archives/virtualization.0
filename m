Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40697C433EF
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 05:27:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD65060EB4
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 05:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD65060EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 965CC6069D;
	Mon,  1 Nov 2021 05:27:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GsErkwYKhfyO; Mon,  1 Nov 2021 05:27:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 504EA6061E;
	Mon,  1 Nov 2021 05:27:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2979EC0012;
	Mon,  1 Nov 2021 05:27:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF950C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 05:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C95AF4022A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 05:27:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3LyhXVXPYITI
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 05:27:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7E8D40229
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 05:27:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="291787620"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; d="scan'208";a="291787620"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2021 22:27:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; d="scan'208";a="666605822"
Received: from jiedeng-optiplex-7050.sh.intel.com ([10.239.154.104])
 by orsmga005.jf.intel.com with ESMTP; 31 Oct 2021 22:27:25 -0700
From: Jie Deng <jie.deng@intel.com>
To: linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: virtio: update the maintainer to Conghui
Date: Mon,  1 Nov 2021 13:24:50 +0800
Message-Id: <00fadb64713aebd752dca3156e37c8f01c5ac184.1635736816.git.jie.deng@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: vincent.whitchurch@axis.com, mst@redhat.com, viresh.kumar@linaro.org,
 jiedeng@alumni.sjtu.edu.cn, wsa@kernel.org, conghui.chen@intel.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Due to changes in my work, I'm passing the virtio-i2c driver
maintenance to Conghui.

Signed-off-by: Jie Deng <jie.deng@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b79fd4..8c9a677 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19944,7 +19944,7 @@ F:	include/uapi/linux/virtio_snd.h
 F:	sound/virtio/*
 
 VIRTIO I2C DRIVER
-M:	Jie Deng <jie.deng@intel.com>
+M:	Conghui Chen <conghui.chen@intel.com>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 L:	linux-i2c@vger.kernel.org
 L:	virtualization@lists.linux-foundation.org
-- 
2.7.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
