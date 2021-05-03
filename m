Return-Path: <SRS0=lx0b=J6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0BBC18E0D
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 16:38:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D07B61415
	for <virtualization@archiver.kernel.org>; Mon,  3 May 2021 16:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D07B61415
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4445A40EA2;
	Mon,  3 May 2021 16:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJsnOiDwAxwK; Mon,  3 May 2021 16:38:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B092640E9D;
	Mon,  3 May 2021 16:38:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A4ECC000D;
	Mon,  3 May 2021 16:38:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF1AC000D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 16:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2ED3E40EA2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 16:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sw0cYmtrasQG
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 16:38:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4942740E9D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 May 2021 16:38:35 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C92DF613EC;
 Mon,  3 May 2021 16:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620059914;
 bh=FQ95+PVS9jyQVavZhWJcRl4uzYy8iOsxHCq9oDkNd8E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EcCjSIycO2uEQuwYqFWYT9cuN4PhBp9SXiS0kZLnqrtM1uMw03+nc5Y4kOxAwo0FA
 jrYnk4y2aOOw6A2gBo+aUcE6Q7cFYp/eWIzQkboDaoJwNi9SWkEHB+38lICr4If+mu
 b6r5SnewyJzYWEfXnqUvNvrZw4eppPKbzrN9lQ5IJCx8qfwfc9deUWYW7QZbfJbvJq
 jNtd1+mmzdsuKn5wJCofeUBu5HbAsfSYWHti6/OduSgakYK6Dezdp7c0K4kV5P79Ef
 WjJd9R8XnbfR3I5TpgRmIbRb39puTVC7oErq0h90/nzSWQPRMmqRkgDcMiGyLMVdT2
 9ZRIQCxcq6bQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 003/100] drm/qxl: release shadow on shutdown
Date: Mon,  3 May 2021 12:36:52 -0400
Message-Id: <20210503163829.2852775-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163829.2852775-1-sashal@kernel.org>
References: <20210503163829.2852775-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 Thomas Zimmermann <tzimmermann@suse.de>, spice-devel@lists.freedesktop.org
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

From: Gerd Hoffmann <kraxel@redhat.com>

[ Upstream commit 4ca77c513537700d3fae69030879f781dde1904c ]

In case we have a shadow surface on shutdown release
it so it doesn't leak.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: http://patchwork.freedesktop.org/patch/msgid/20210204145712.1531203-6-kraxel@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/qxl/qxl_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 862ef59d4d03..1f0802f5d84e 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1224,6 +1224,10 @@ int qxl_modeset_init(struct qxl_device *qdev)
 
 void qxl_modeset_fini(struct qxl_device *qdev)
 {
+	if (qdev->dumb_shadow_bo) {
+		drm_gem_object_put(&qdev->dumb_shadow_bo->tbo.base);
+		qdev->dumb_shadow_bo = NULL;
+	}
 	qxl_destroy_monitors_object(qdev);
 	drm_mode_config_cleanup(&qdev->ddev);
 }
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
