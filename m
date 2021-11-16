Return-Path: <SRS0=Mct1=QD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B47C433F5
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 19:05:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75D7663214
	for <virtualization@archiver.kernel.org>; Tue, 16 Nov 2021 19:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 75D7663214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EAD860782;
	Tue, 16 Nov 2021 19:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3xg5aOn92Wug; Tue, 16 Nov 2021 19:05:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E97D0607F7;
	Tue, 16 Nov 2021 19:05:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC3E6C001E;
	Tue, 16 Nov 2021 19:05:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E85DC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 19:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33F6D80F54
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 19:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 33aKTSHX3xoF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 19:05:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E56180F4F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 19:05:05 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 148D56321B;
 Tue, 16 Nov 2021 19:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637089505;
 bh=pUC+/2H427L7tAVUY+8YM20rMCV65nBnq4xSfR84FZc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=arWDxm81MhlbXKoc6f9V25if+gxL5Fjf6hKZbroC6mJOnpdJVyv20RJvFA00Jt/aN
 kDsO78F+7Ueg3j1OE3PMDqmexiiaI+ufVrbBt+aPK+jH8roAZf/fU4vdj9hdgkCh5y
 EBFpR9ZT/vHA/tmAs9Hx0tmmx1svYpssTEDLsf+zO0AFpZLlOPJgXwVoJrK5Ux4Fep
 Yn1hmu6kGH6HuVE8E1+CEROqEV2TEV6XS3Bt74abSMp1JHx9FxGS4QpM3oDObylhyX
 YoZ91Z6NsGnqg4ylp+Mx7BTPV9IEqJxMN9lZLhssmFBTu8xyVYy4VOT86FnqHqRDwx
 9kcz7Dh0DJW1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/65] drm/virtio: fix the missed
 drm_gem_object_put() in virtio_gpu_user_framebuffer_create()
Date: Tue, 16 Nov 2021 14:03:28 -0500
Message-Id: <20211116190443.2418144-8-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211116190443.2418144-1-sashal@kernel.org>
References: <20211116190443.2418144-1-sashal@kernel.org>
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
