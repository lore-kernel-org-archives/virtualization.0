Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B799C433EF
	for <virtualization@archiver.kernel.org>; Sun, 23 Jan 2022 00:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46E2740185;
	Sun, 23 Jan 2022 00:12:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JSl4OZJ4to2c; Sun, 23 Jan 2022 00:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C88CC40177;
	Sun, 23 Jan 2022 00:12:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B00A8C0031;
	Sun, 23 Jan 2022 00:12:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77648C002F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6780240177
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZxdWNQG9UVNV
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E04D740129
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Jan 2022 00:12:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3C4C860F9D;
 Sun, 23 Jan 2022 00:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEFCC340E5;
 Sun, 23 Jan 2022 00:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642896770;
 bh=NKDIU71Wv1t4OtwDwKWo2B6K8ANzo2zJzF4cKqTyu1s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gmtMKNY0CKXZC11Hve+0BTYdMaVJf/+LdZDeIUzB5bkgRfCHsG/iycgH+XhrVdd7f
 o+BECfn/UhPSYVFdFsqy/C8DU5K217bPhV9nAT9HO7AFOLt0ATuKeyNsAMrcpRbUV4
 g79ZcegbPF1ehb1ukcDPSic7brZatuI4NT5C9nPwJOnVYAZ8KTqDXesSog+EsjZbPQ
 /mIVfy029gALcQgUyAsSgpdgHptHbHynCYXi6uzYzpCmmTQa8ml7rxtkb7q32KcK45
 WvULsIyE1dyOOkfTFQRCvJqeF+SnHMS9jObgkoEG60w6ufp5thaTZfTvLVVmdOnckx
 0wTwzrnFfr8Jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/16] vdpa: clean up get_config_size ret value
 handling
Date: Sat, 22 Jan 2022 19:12:12 -0500
Message-Id: <20220123001216.2460383-13-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123001216.2460383-1-sashal@kernel.org>
References: <20220123001216.2460383-1-sashal@kernel.org>
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
index d62f05d056b7b..913cd465f9f1e 100644
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
