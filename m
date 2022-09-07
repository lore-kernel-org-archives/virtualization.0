Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46731C6FA86
	for <virtualization@archiver.kernel.org>; Wed,  7 Sep 2022 15:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F37C827A1;
	Wed,  7 Sep 2022 15:12:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F37C827A1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.a=rsa-sha256 header.s=default header.b=tSBsAA5F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cz9yiMH41Wkg; Wed,  7 Sep 2022 15:12:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C2429827A5;
	Wed,  7 Sep 2022 15:11:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2429827A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93AECC0033;
	Wed,  7 Sep 2022 15:11:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B89E7C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 15:11:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F442400E4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 15:11:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F442400E4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org
 header.a=rsa-sha256 header.s=default header.b=tSBsAA5F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5Cx452FJa26q
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 15:11:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8132F40587
Received: from mail.8bytes.org (mail.8bytes.org
 [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8132F40587
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Sep 2022 15:11:57 +0000 (UTC)
Received: from lemmy.home.8bytes.org (p4ff2bb62.dip0.t-ipconnect.de
 [79.242.187.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 8C935240A3E;
 Wed,  7 Sep 2022 17:11:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
 s=default; t=1662563515;
 bh=KmpFpEz/lyHaEET/ThZz16jqJhRrdPrH8I/CQGSh0EE=;
 h=From:To:Cc:Subject:Date:From;
 b=tSBsAA5F/euIUSUVa3hW4mgnDwG/+G9aXFKoTqf1dBUwtIs661DrL6++eaMjQNMkY
 z1K4YABe5aQDz/W4H6ig14SVS+b8dK3JaieCO+WCx3/Jw9Q30GyOdroe1skonkJSqh
 w6Qi9vAdbQmMoTyxNBKDhu4ydZYitsJajoSX/ljQ3FkXR+vdyYDvCqC1c/iEP3uMbe
 b5iBKOFA+Eezm0z6Kcn49MKBCT8SuUx6kjhfEqXb223k1q7oGsIBacGIIwhIPwD7hT
 GFquWshAK15inEjOsUHUncIw7LiIT/pw1ythPAVGsEkd7IKBhT7bzDViCWSMJ5A4Q3
 w5TIWNwYAr8Xw==
From: Joerg Roedel <joro@8bytes.org>
To: Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev
Subject: [PATCH] iommu/virtio: Fix compile error with viommu_capable()
Date: Wed,  7 Sep 2022 17:11:54 +0200
Message-Id: <20220907151154.21911-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

From: Joerg Roedel <jroedel@suse.de>

A recent fix introduced viommu_capable() but other changes
from Robin change the function signature of the call-back it
is used for.

When both changes are merged a compile error will happen
because the function pointer types mismatch. Fix that by
updating the viommu_capable() signature after the merge.

Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/virtio-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index da463db9f12a..1b12825e2df1 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1005,7 +1005,7 @@ static int viommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	return iommu_fwspec_add_ids(dev, args->args, 1);
 }
 
-static bool viommu_capable(enum iommu_cap cap)
+static bool viommu_capable(struct device *dev, enum iommu_cap cap)
 {
 	switch (cap) {
 	case IOMMU_CAP_CACHE_COHERENCY:
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
