Return-Path: <SRS0=u9Em=C2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04F6C43461
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 18:59:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27192221E3
	for <virtualization@archiver.kernel.org>; Thu, 17 Sep 2020 18:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a6AAAWT6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27192221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4466D876D2;
	Thu, 17 Sep 2020 18:59:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x9PAbmchRis7; Thu, 17 Sep 2020 18:59:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C09F4876D0;
	Thu, 17 Sep 2020 18:59:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B09E7C0864;
	Thu, 17 Sep 2020 18:59:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83B54C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 18:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 72E1786FCC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 18:59:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OjvBtY7oICML
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 18:59:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6C5F286FC9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 18:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=dCb3Mw8emqdBD/1nF+oUHT3U3i0WT8UHhM2aFDWS07g=; b=a6AAAWT6OpuM+kWcatw3TlS2JP
 +8IS6npgj/d5gENj7cfht68AdE18jEyqNklaqeTUkp7d2dLDMsPPi+veQLTosycBB0vDYDd4A8Yyr
 tznRa1dqP11vzU13o+w8+NI0S2IwbKOxHAR6RHTudrhQhOFeRLJxOB8d7iUlNyWiPZPONYGOMMtMO
 jMNj7kl01I7FnTNmILeOSFXO2K+G4obIYF76n4aWfGHU+4d/ez4I1+WdKfY8QkAIoHxTzeSrtMWgD
 979WzHnWW1wU6ehSV+WMb0E8LWmwYqMzX9Jd9A+0HqijmAVIwP9BMmj4KuLIubgEiqvd+S9pNQk99
 Y9x+AIAw==;
Received: from [2601:1c0:6280:3f0::19c2]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIz7L-0000LU-Rs; Thu, 17 Sep 2020 18:58:52 +0000
To: LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] vdpa: mlx5: select VHOST to fix build errors
Message-ID: <f47e2bab-c19c-fab5-cfb9-e2b5ba1be69a@infradead.org>
Date: Thu, 17 Sep 2020 11:58:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Language: en-US
Cc: Leon Romanovsky <leonro@nvidia.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Saeed Mahameed <saeedm@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

From: Randy Dunlap <rdunlap@infradead.org>

drivers/vdpa/mlx5/ uses vhost_iotlb*() interfaces, so select
VHOST to eliminate build errors.

ld: drivers/vdpa/mlx5/core/mr.o: in function `add_direct_chain':
mr.c:(.text+0x106): undefined reference to `vhost_iotlb_itree_first'
ld: mr.c:(.text+0x1cf): undefined reference to `vhost_iotlb_itree_next'
ld: mr.c:(.text+0x30d): undefined reference to `vhost_iotlb_itree_first'
ld: mr.c:(.text+0x3e8): undefined reference to `vhost_iotlb_itree_next'
ld: drivers/vdpa/mlx5/core/mr.o: in function `_mlx5_vdpa_create_mr':
mr.c:(.text+0x908): undefined reference to `vhost_iotlb_itree_first'
ld: mr.c:(.text+0x9e6): undefined reference to `vhost_iotlb_itree_next'
ld: drivers/vdpa/mlx5/core/mr.o: in function `mlx5_vdpa_handle_set_map':
mr.c:(.text+0xf1d): undefined reference to `vhost_iotlb_itree_first'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: netdev@vger.kernel.org
---
Note: This patch may not be the right thing, but it fixes the build errors.

 drivers/vdpa/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200917.orig/drivers/vdpa/Kconfig
+++ linux-next-20200917/drivers/vdpa/Kconfig
@@ -32,6 +32,7 @@ config IFCVF
 config MLX5_VDPA
 	bool "MLX5 VDPA support library for ConnectX devices"
 	depends on MLX5_CORE
+	select VHOST
 	default n
 	help
 	  Support library for Mellanox VDPA drivers. Provides code that is

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
