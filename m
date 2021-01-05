Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C5C433E6
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 10:32:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FD922525
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 10:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FD922525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1E9FE2152C;
	Tue,  5 Jan 2021 10:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XbYvkaiVGyKy; Tue,  5 Jan 2021 10:32:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C185E214E9;
	Tue,  5 Jan 2021 10:32:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EF1CC088B;
	Tue,  5 Jan 2021 10:32:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09CB1C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 10:32:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ECE8186805
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 10:32:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iPof0Wn8UgkX
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 10:32:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6A7E8867E0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 10:32:24 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5ff440360000>; Tue, 05 Jan 2021 02:32:23 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
 Tue, 5 Jan 2021 10:32:21 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH linux-next v3 1/6] vdpa_sim_net: Make mac address array static
Date: Tue, 5 Jan 2021 12:31:58 +0200
Message-ID: <20210105103203.82508-2-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210105103203.82508-1-parav@nvidia.com>
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210105103203.82508-1-parav@nvidia.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1609842744; bh=jWwmgZDFERslTkegzqs6sCRdRaURErwyVVE3nMqjEcY=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-Originating-IP:X-ClientProxiedBy;
 b=Y+MELtonfPOgcbBs+AIhIuMXl1fFF0q4RoIN2P6S9McN8xKaFobtXx7u0vHGpQAJy
 GXc5u46KzIsXN5vKk8ZFW60rgv6gY2xIeYaOCcYwZlBMEVaLMARuCYwTRPq+7s7ALa
 ui6BjbICvkVATeo8XHCvm9hPL2YjEZy+id5IRWASf21wLVWl07s75DuomiDcDvNVqK
 2VSjveO3oyaYqFVZkt674LwX8EUJZgF9sYE1o4OrqTYMcBlJFE5dOnupiX3inolhQ7
 FnWJoUiLQ4Ap/i744ZPj9D5/aIJ09GVelNsqgmnCJiL5+UOcLaplzsG0NQsAf3qVm6
 KPGcT2LWCsWBQ==
Cc: netdev@vger.kernel.org, elic@nvidia.com, mst@redhat.com
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

MAC address array is used only in vdpa_sim_net.c.
Hence, keep it static.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
Changelog:
v1->v2:
 - new patch
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c10b6981fdab..f0482427186b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -33,7 +33,7 @@ static char *macaddr;
 module_param(macaddr, charp, 0);
 MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
 
-u8 macaddr_buf[ETH_ALEN];
+static u8 macaddr_buf[ETH_ALEN];
 
 static struct vdpasim *vdpasim_net_dev;
 
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
