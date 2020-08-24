Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1361C433E3
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 16:36:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2AB322D02
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 16:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXUzDAG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2AB322D02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8C17320489;
	Mon, 24 Aug 2020 16:36:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O+fcIL+c-3RF; Mon, 24 Aug 2020 16:36:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D5E7520485;
	Mon, 24 Aug 2020 16:36:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8D7CC016F;
	Mon, 24 Aug 2020 16:36:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F077C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 16:36:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2900B876E4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 16:36:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id il20FgGsr12F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 16:36:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A3D5F86FD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 16:36:41 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9DBC522DA9;
 Mon, 24 Aug 2020 16:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598287001;
 bh=yM0adv38uo+NQx7so3B98b2SMvGI1C8RiqcPnmX6+rI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EXUzDAG5QriYH/XVwMMT+nWzkvQnbQPyYVFFJ/KDRNYvpHF22vlxWkj+SCtRmNIva
 KT8DFW33xKGI8b5cGM0JUr1CSXnN504MNXB0Y0II82gBAnzoOYqB6zVtj93GJvvHOz
 zwxdoJ/yhBckxozHJy7lMMvxu0E4JbguPI3uw6R0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 05/54] drm/virtio: fix memory leak in
 virtio_gpu_cleanup_object()
Date: Mon, 24 Aug 2020 12:35:44 -0400
Message-Id: <20200824163634.606093-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163634.606093-1-sashal@kernel.org>
References: <20200824163634.606093-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Xin He <hexin.op@bytedance.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 Qi Liu <liuqi.16@bytedance.com>
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

From: Xin He <hexin.op@bytedance.com>

[ Upstream commit 836b194d65782aaec4485a07d2aab52d3f698505 ]

Before setting shmem->pages to NULL, kfree() should
be called.

Signed-off-by: Xin He <hexin.op@bytedance.com>
Reviewed-by: Qi Liu <liuqi.16@bytedance.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20200722051851.72662-1-hexin.op@bytedance.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index d9039bb7c5e37..1e65c5ac573b1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -79,6 +79,7 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 			}
 
 			sg_free_table(shmem->pages);
+			kfree(shmem->pages);
 			shmem->pages = NULL;
 			drm_gem_shmem_unpin(&bo->base.base);
 		}
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
