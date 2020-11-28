Return-Path: <SRS0=/B29=FC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE15C63777
	for <virtualization@archiver.kernel.org>; Sat, 28 Nov 2020 21:39:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D1A20857
	for <virtualization@archiver.kernel.org>; Sat, 28 Nov 2020 21:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RmXEmFKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D1A20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 59FE78759A;
	Sat, 28 Nov 2020 21:39:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5asjXcZZ7adt; Sat, 28 Nov 2020 21:39:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C1BF987618;
	Sat, 28 Nov 2020 21:39:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5C9DC0891;
	Sat, 28 Nov 2020 21:39:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B162C0052
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Nov 2020 21:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5F58A87618
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Nov 2020 21:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G7U5p+Q045dk
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Nov 2020 21:39:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 53A208759A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Nov 2020 21:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=cLViv87Sd5/WI1F3sh0RUkFslM622GS1dHyu4cz2mHc=; b=RmXEmFKUkit0IQMFSSYtrynDQV
 x0Kb0z1oiAxxbC7tWYH0UmZyPJlUUPrmg1ciyyWuHgVnxtDIe8hQuX1ArHBGOT1DQvgraRCLbZulU
 ZNVmxJLVEyFCsFUB/l4aQF4HPHBcBZyACeMi0PsDo01RPMH7FVwofJtGZzWhlzTUMGutYz6YxV7ko
 a6YUYBkcFBBv1IF2b2r+0b4rSYLCCwfWXHknuGSrliO9b2ZPJzpVw7AU9vbLe97TGaJBtwQl67X/Y
 W/CoZbOyJwDDvoxyruHZkNrZP765HhUgQ3rBCcrYdhAfsIxttZgr1czN+GkD3KPmKqu7ggsqe75yx
 rTmydCAQ==;
Received: from [2601:1c0:6280:3f0::cc1f] (helo=smtpauth.infradead.org)
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kj7vz-0002PT-6P; Sat, 28 Nov 2020 21:39:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4] vdpa: mlx5: fix vdpa/vhost dependencies
Date: Sat, 28 Nov 2020 13:39:05 -0800
Message-Id: <20201128213905.27409-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Cc: kernel test robot <lkp@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leon Romanovsky <leonro@nvidia.com>, Randy Dunlap <rdunlap@infradead.org>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 Eli Cohen <eli@mellanox.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Parav Pandit <parav@mellanox.com>
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

drivers/vdpa/mlx5/ uses vhost_iotlb*() interfaces, so select
VHOST_IOTLB to make them be built.

However, if VHOST_IOTLB is the only VHOST symbol that is
set/enabled, the object file still won't be built because
drivers/Makefile won't descend into drivers/vhost/ to build it,
so make drivers/Makefile build the needed binary whenever
VHOST_IOTLB is set, like it does for VHOST_RING.

Fixes these build errors:
ERROR: modpost: "vhost_iotlb_itree_next" [drivers/vdpa/mlx5/mlx5_vdpa.ko] undefined!
ERROR: modpost: "vhost_iotlb_itree_first" [drivers/vdpa/mlx5/mlx5_vdpa.ko] undefined!

Fixes: 29064bfdabd5 ("vdpa/mlx5: Add support library for mlx5 VDPA implementation")
Fixes: aff90770e54c ("vdpa/mlx5: Fix dependency on MLX5_CORE")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Eli Cohen <eli@mellanox.com>
Cc: Parav Pandit <parav@mellanox.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>
Cc: netdev@vger.kernel.org
---
v2: change from select to depends on VHOST (Saeed)
v3: change to depends on VHOST_IOTLB (Jason)
v4: use select VHOST_IOTLB (Michael); also add to drivers/Makefile

 drivers/Makefile     |    1 +
 drivers/vdpa/Kconfig |    1 +
 2 files changed, 2 insertions(+)

--- linux-next-20201127.orig/drivers/vdpa/Kconfig
+++ linux-next-20201127/drivers/vdpa/Kconfig
@@ -32,6 +32,7 @@ config IFCVF
 
 config MLX5_VDPA
 	bool
+	select VHOST_IOTLB
 	help
 	  Support library for Mellanox VDPA drivers. Provides code that is
 	  common for all types of VDPA drivers. The following drivers are planned:
--- linux-next-20201127.orig/drivers/Makefile
+++ linux-next-20201127/drivers/Makefile
@@ -143,6 +143,7 @@ obj-$(CONFIG_OF)		+= of/
 obj-$(CONFIG_SSB)		+= ssb/
 obj-$(CONFIG_BCMA)		+= bcma/
 obj-$(CONFIG_VHOST_RING)	+= vhost/
+obj-$(CONFIG_VHOST_IOTLB)	+= vhost/
 obj-$(CONFIG_VHOST)		+= vhost/
 obj-$(CONFIG_VLYNQ)		+= vlynq/
 obj-$(CONFIG_GREYBUS)		+= greybus/
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
