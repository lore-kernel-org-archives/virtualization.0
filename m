Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4509DC433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:19:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D33CC64E24
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 06:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33CC64E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AD066F5D7;
	Wed, 24 Feb 2021 06:19:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sr-onphpC6SW; Wed, 24 Feb 2021 06:19:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42EFA6F5D3;
	Wed, 24 Feb 2021 06:19:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2058EC000A;
	Wed, 24 Feb 2021 06:19:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 430F0C0017
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AB4960673
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bLclFktEp2mS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 990796F5C2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 06:19:05 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6035efd90000>; Tue, 23 Feb 2021 22:19:05 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 24 Feb 2021 06:19:04 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated random MAC
 address
Date: Wed, 24 Feb 2021 08:18:42 +0200
Message-ID: <20210224061844.137776-8-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210224061844.137776-1-parav@nvidia.com>
References: <20210224061844.137776-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614147545; bh=K1HRCLG8SKfHAmbxkvmRS8tRknlUPYrarw76ahCao88=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=Wa/TGRTJvILwcjQr7xm8WEyxUBwBV6n03BoCfp6oejy1rcwGXY+67zPR18gQr0JSs
 5oXoTv3/M2yPjUz8cJXQJRLl+JUhR8xV2aG2kQU0URBgSIBRvltyCtvP9Jebk6RNEF
 qMWJGgcAlyLBlkSkDDEl33bIy67C6tqvrA4/9w4WqjPMFWYyIIWQOcL2oixKoV9dQi
 3ByueUe3Xl/X7AqmJZTRzYWkoHTIZYZL86NSMhG8+mdqgTJNpfJ64VvC++IAb/5FZG
 QjPrMDP2BVg0MN0/Bzu0VTkISRsxVjhc1I6y7mxNqU9zmbn5cTN6xV8aJdmmdvDZgZ
 dj5NVFNtlBIuQ==
Cc: Eli Cohen <elic@nvidia.com>, mst@redhat.com
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

From: Eli Cohen <elic@nvidia.com>

Use a randomly generated MAC address to be applied in case it is not
configured by management tool.

The value queried through mlx5_query_nic_vport_mac_address() is not
relelavnt to vdpa since it is the mac that should be used by the regular
NIC driver.

Signed-off-by: Eli Cohen <elic@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b67bba581dfd..ece2183e7b20 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2005,10 +2005,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
 	if (err)
 		goto err_mtu;
 
-	err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
-	if (err)
-		goto err_mtu;
-
+	eth_random_addr(config->mac);
 	mvdev->vdev.dma_dev = mdev->device;
 	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
 	if (err)
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
