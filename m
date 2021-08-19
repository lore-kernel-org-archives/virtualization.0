Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3332CC4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 00:50:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DCC610D2
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 00:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C0DCC610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84A2E80CE8;
	Thu, 19 Aug 2021 00:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UnkrazL8mTJj; Thu, 19 Aug 2021 00:50:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0448380CFE;
	Thu, 19 Aug 2021 00:50:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCEE8C0010;
	Thu, 19 Aug 2021 00:50:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A3FDC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 00:50:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 21BBD60649
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 00:50:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2ohfif0qXhRp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 00:50:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7AD2E605E3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 00:50:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10080"; a="203657798"
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; d="scan'208";a="203657798"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 17:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,333,1620716400"; d="scan'208";a="678768847"
Received: from jiedeng-optiplex-7050.sh.intel.com ([10.239.154.104])
 by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2021 17:50:24 -0700
From: Jie Deng <jie.deng@intel.com>
To: linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: virtio: Fix the compiler warning when CONFIG_ACPI is not
 set
Date: Thu, 19 Aug 2021 08:48:41 +0800
Message-Id: <4309f869890e70810f2c40a8d60495240e318303.1629333590.git.jie.deng@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: wsa@kernel.org, viresh.kumar@linaro.org, conghui.chen@intel.com,
 sfr@canb.auug.org.au
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

Fix the compiler warning "drivers/i2c/busses/i2c-virtio.c:208:17:
warning: unused variable 'pdev' [-Wunused-variable]" when CONFIG_ACPI
is not set.

Fixes: 8fb12751ac78 ("i2c: virtio: add a virtio i2c frontend driver")
Signed-off-by: Jie Deng <jie.deng@intel.com>
---
 drivers/i2c/busses/i2c-virtio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index d3e60d9..964c601 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -205,7 +205,6 @@ static const struct i2c_adapter_quirks virtio_i2c_quirks = {
 
 static int virtio_i2c_probe(struct virtio_device *vdev)
 {
-	struct device *pdev = vdev->dev.parent;
 	struct virtio_i2c *vi;
 	int ret;
 
@@ -234,7 +233,7 @@ static int virtio_i2c_probe(struct virtio_device *vdev)
 	 * Setup ACPI node for controlled devices which will be probed through
 	 * ACPI.
 	 */
-	ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(pdev));
+	ACPI_COMPANION_SET(&vi->adap.dev, ACPI_COMPANION(vdev->dev.parent));
 
 	ret = i2c_add_adapter(&vi->adap);
 	if (ret)
-- 
2.7.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
