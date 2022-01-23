Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CEAC4332F
	for <virtualization@archiver.kernel.org>; Sun, 23 Jan 2022 00:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51C3A83E02;
	Sun, 23 Jan 2022 00:12:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PuCUm1nDDfJb; Sun, 23 Jan 2022 00:12:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E805783E1A;
	Sun, 23 Jan 2022 00:12:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3AE9C007B;
	Sun, 23 Jan 2022 00:12:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16F59C007B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB5E1605E9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GRsuGoq9bQzR
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D02360ADA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:09 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8D47460F77;
 Sun, 23 Jan 2022 00:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F911C340E5;
 Sun, 23 Jan 2022 00:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642896728;
 bh=1SobhZzR22+/GG1/sdRMJWQ0gBIBcx7Dh8/mbwYVxas=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TrIwIb8X9KNjodYkEEOkjTCAeEAaktzYFE0Fw2ci8bth6jbvznJeotDoYYajVXRlr
 pglC4dUEoOGUXk2l2y08kjHtYqV2GnESphyZlkeud6GA5atJoccz1GlJeVAujzZHRi
 cSUXDTZb5L1vARyy/3rBbEVxN9e/4JGd9p2L/4w+VIM5d44CwjDCMDbW/9J0xu1W3L
 e9RBawU0xYi7f+K0LgkD735yF34l2+Dg6MboZGPGe3Z1BmejPbcFn7Vcth8ilhZORy
 ElVA+NZg0jDmjEfrVW5mQjEXxbOCIRdYtg5F9Hvo7V9imLf9A35hCGh+ZUJ1lBe01y
 PC1k2iklQRDpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 16/19] vdpa: clean up get_config_size ret value
 handling
Date: Sat, 22 Jan 2022 19:11:09 -0500
Message-Id: <20220123001113.2460140-16-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123001113.2460140-1-sashal@kernel.org>
References: <20220123001113.2460140-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
 "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Luo Likang <luolikang@nsfocus.com>,
 Laura Abbott <labbott@kernel.org>
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

From: Laura Abbott <labbott@kernel.org>

[ Upstream commit 870aaff92e959e29d40f9cfdb5ed06ba2fc2dae0 ]

The return type of get_config_size is size_t so it makes
sense to change the type of the variable holding its result.

That said, this already got taken care of (differently, and arguably
not as well) by commit 3ed21c1451a1 ("vdpa: check that offsets are
within bounds").

The added 'c->off > size' test in that commit will be done as an
unsigned comparison on 32-bit (safe due to not being signed).

On a 64-bit platform, it will be done as a signed comparison, but in
that case the comparison will be done in 64-bit, and 'c->off' being an
u32 it will be valid thanks to the extended range (ie both values will
be positive in 64 bits).

So this was a real bug, but it was already addressed and marked for stable.

Signed-off-by: Laura Abbott <labbott@kernel.org>
Reported-by: Luo Likang <luolikang@nsfocus.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vdpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index e3c4f059b21a2..c31737a1da6aa 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -195,7 +195,7 @@ static int vhost_vdpa_config_validate(struct vhost_vdpa *v,
 				      struct vhost_vdpa_config *c)
 {
 	struct vdpa_device *vdpa = v->vdpa;
-	long size = vdpa->config->get_config_size(vdpa);
+	size_t size = vdpa->config->get_config_size(vdpa);
 
 	if (c->len == 0 || c->off > size)
 		return -EINVAL;
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
