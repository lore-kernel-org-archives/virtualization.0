Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C56DC636D4
	for <virtualization@archiver.kernel.org>; Thu,  9 Feb 2023 11:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0876D41622;
	Thu,  9 Feb 2023 11:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0876D41622
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mrcCgGet
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oTLyrUR39O5G; Thu,  9 Feb 2023 11:16:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 60660410D1;
	Thu,  9 Feb 2023 11:16:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60660410D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3776FC0033;
	Thu,  9 Feb 2023 11:16:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AA46C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Feb 2023 11:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4642F60C06
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Feb 2023 11:16:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4642F60C06
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=mrcCgGet
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lxEiXOqXaal
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Feb 2023 11:16:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F4C960D94
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9F4C960D94
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Feb 2023 11:16:05 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F198461A18;
 Thu,  9 Feb 2023 11:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D01DC433D2;
 Thu,  9 Feb 2023 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675941364;
 bh=YbHyk0Yj5v83mAWPoPN0CrKwF2Uiw38KjLu6b9b2vaY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mrcCgGetn1YAhUWf9vNo3XZJt7S0O9N+RsWrolMGTi4tDmWquJ0JhLSmz0gbBaTL6
 WwY+n/ThBrc/UnYi+Npn/QX39W1qHqrWfcPdPonr/Upk1eySplSdzykb5fDl7cwG4j
 XksI2BNnuiDN72TOk4SHKG1Ib2di27/88suV7oxaqwuApIu67TZH3wJzomRemRdoYx
 6kHlWqZPvOHqgZECe31aeApuZBtliPFcdj3AP1NK0LRafp8FKSZwhe8CglZe4eXgG3
 lGZhGjUphC+T96QwGM6iHa8xpnFvxtphZmHEQqzcvfwBtAZqN0Zh6NsdBYVmCIs/NA
 pQLMq0z3iloNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 14/38] vdpa: ifcvf: Do proper cleanup if IFCVF
 init fails
Date: Thu,  9 Feb 2023 06:14:33 -0500
Message-Id: <20230209111459.1891941-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209111459.1891941-1-sashal@kernel.org>
References: <20230209111459.1891941-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 trix@redhat.com, jiaming@nfschina.com,
 virtualization@lists.linux-foundation.org,
 Tanmay Bhushan <007047221b@gmail.com>, gautam.dawar@xilinx.com
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

From: Tanmay Bhushan <007047221b@gmail.com>

[ Upstream commit 6b04456e248761cf68f562f2fd7c04e591fcac94 ]

ifcvf_mgmt_dev leaks memory if it is not freed before
returning. Call is made to correct return statement
so memory does not leak. ifcvf_init_hw does not take
care of this so it is needed to do it here.

Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
Message-Id: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Zhu Lingshan <lingshan.zhu@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index f9c0044c6442e..44b29289aa193 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -849,7 +849,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = ifcvf_init_hw(vf, pdev);
 	if (ret) {
 		IFCVF_ERR(pdev, "Failed to init IFCVF hw\n");
-		return ret;
+		goto err;
 	}
 
 	for (i = 0; i < vf->nr_vring; i++)
-- 
2.39.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
