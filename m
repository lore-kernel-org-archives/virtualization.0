Return-Path: <SRS0=xhJn=HP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B42C433E0
	for <virtualization@archiver.kernel.org>; Sat, 13 Feb 2021 18:40:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32F364DCC
	for <virtualization@archiver.kernel.org>; Sat, 13 Feb 2021 18:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32F364DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C5577869DE;
	Sat, 13 Feb 2021 18:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T2q4aYXGE8DK; Sat, 13 Feb 2021 18:40:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2722D869C6;
	Sat, 13 Feb 2021 18:40:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E55AC0174;
	Sat, 13 Feb 2021 18:40:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FB8CC013A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 18:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F25BB869D0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 18:40:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Zltu59PbZ0V9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 18:40:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 64D84869C6
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Feb 2021 18:40:05 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60281d050000>; Sat, 13 Feb 2021 10:40:05 -0800
Received: from sw-mtx-036.mtx.labs.mlnx (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sat, 13 Feb 2021 18:40:04 +0000
From: Parav Pandit <parav@nvidia.com>
To: <virtualization@lists.linux-foundation.org>
Subject: [PATCH] vdpa_sim: Skip typecasting from void*
Date: Sat, 13 Feb 2021 20:39:51 +0200
Message-ID: <20210213183951.248324-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1613241605; bh=/b4+40s2/oQJUPbWJVVo0gbdRIUHHgxbM5GBZ2Czkd4=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy;
 b=Iob0sBGoYg7x07W4HzPZsdrRcDZRUPHuYSgetrgyskIsdjaAH1dLKmyJIxVxmvyvU
 Kg0QlxOmuPyg9/jSLykvglzVlHDGRxMxMQytGuo3FhhFBYpyjc6JdFjaO97sLAk2Jt
 GvPhNyYJHUUSrSlnQUAIof42H1A8D3zJMvoGJ8QsGP1k7RISItouy+c0vPGGv0xwZi
 dY2VNtTOkHG3Y1ger79iZ31pNP/DJ1JkPbk+36oXwb+OdCYvqDE9IBDtbY8sb4YWbX
 YWolfdMyBV91i8g4k+vPRAiOhxPi0rhDLZ2j9VLwT6Ap3r5YxoSCx5bgdAxJX4Cmpf
 frstJe0PW1iRA==
Cc: mst@redhat.com
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

Typecasting from void* to virtio_net_config* is not needed.
Remove it.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index 240a5f1306b5..40d4df689b87 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -110,8 +110,7 @@ static void vdpasim_net_work(struct work_struct *work)
 
 static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
 {
-	struct virtio_net_config *net_config =
-		(struct virtio_net_config *)config;
+	struct virtio_net_config *net_config = config;
 
 	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
 	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
