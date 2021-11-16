Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC69DC433F5
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 19:18:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D12663227
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 19:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D12663227
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15FA8607F9;
	Tue, 16 Nov 2021 19:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b3OzzH-6oXNg; Tue, 16 Nov 2021 19:18:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B70C0607F7;
	Tue, 16 Nov 2021 19:18:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96E1AC001E;
	Tue, 16 Nov 2021 19:18:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 689B4C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 19:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4367480F5D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 19:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ql074wWJWq2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 19:18:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86C4280F5B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 19:18:15 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38CD363222;
 Tue, 16 Nov 2021 19:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637090295;
 bh=pUC+/2H427L7tAVUY+8YM20rMCV65nBnq4xSfR84FZc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JCYF0xNMcHupOKf6Hr+F6U5NfWBleIffhW0+44H/V9ffQkJ1IXwiRD0NJ3wUDdxa6
 XaqtSN9guUF7nX1EvzKRqR9w2PaocSCa6nGd86S77iUjhSS5OONB0XFMY748WxNFO+
 +RfTCHfU4xVLWjyz9sk+oDOOU2UHNwaBGhak487XgRc56KBg1gf8h/vHcEYxnXJu5u
 uSc4qqag99QggJWHPGbbw8/KWZygXeHw6uL/rkVm94Qo50Ni7p/lfVY7HBugEAM/Rg
 5GxliFPB+HT1EZaG5LG9LQ4AQkFIwvqfQpOM1xi/nq6oSvVWjFKrM//XD2A6D9FO/l
 SNDzoaDSQ0rLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/65] drm/virtio: fix the missed
 drm_gem_object_put() in virtio_gpu_user_framebuffer_create()
Date: Tue, 16 Nov 2021 14:16:53 -0500
Message-Id: <20211116191754.2419097-8-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211116191754.2419097-1-sashal@kernel.org>
References: <20211116191754.2419097-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, airlied@linux.ie,
 dri-devel@lists.freedesktop.org, Jing Xiangfeng <jingxiangfeng@huawei.com>,
 daniel@ffwll.ch, virtualization@lists.linux-foundation.org
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

From: Jing Xiangfeng <jingxiangfeng@huawei.com>

[ Upstream commit a63f393dd7e1ebee707c9dee1d197fdc33d6486b ]

virtio_gpu_user_framebuffer_create() misses to call drm_gem_object_put()
in an error path. Add the missed function call to fix it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
Link: http://patchwork.freedesktop.org/patch/msgid/1633770560-11658-1-git-send-email-jingxiangfeng@huawei.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index a6caebd4a0dd6..5b00310ac4cd4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -308,8 +308,10 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 		return ERR_PTR(-EINVAL);
 
 	virtio_gpu_fb = kzalloc(sizeof(*virtio_gpu_fb), GFP_KERNEL);
-	if (virtio_gpu_fb == NULL)
+	if (virtio_gpu_fb == NULL) {
+		drm_gem_object_put(obj);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	ret = virtio_gpu_framebuffer_init(dev, virtio_gpu_fb, mode_cmd, obj);
 	if (ret) {
-- 
2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
