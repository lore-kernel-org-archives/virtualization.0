Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF48C00140
	for <virtualization@archiver.kernel.org>; Fri, 12 Aug 2022 22:39:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E945883DF1;
	Fri, 12 Aug 2022 22:39:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E945883DF1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=kCH5GDRZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MTIQW2-9GKYi; Fri, 12 Aug 2022 22:39:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 508D7831D6;
	Fri, 12 Aug 2022 22:39:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 508D7831D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D608C0033;
	Fri, 12 Aug 2022 22:39:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E970EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 22:39:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BAEA8418E2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 22:39:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BAEA8418E2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=kCH5GDRZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ju4DUOpB4S_e
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 22:39:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB7A041839
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB7A041839
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 22:39:27 +0000 (UTC)
Received: by mail-pf1-x42b.google.com with SMTP id f30so2103176pfq.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 15:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=WoqjtI8/PDq4XLeCuA4BUU9vOzNcEPwvP6PaF9+jchw=;
 b=kCH5GDRZUrtkc7wWNsc5nuqbMku7NBjt44npkV7Va47a7utj6FA4TomD1TL+NsJMVK
 iSP2uNzTV+S5agOwMfCzu8BIwfzHY21+IKiEpcfPq3bCaxllz5hpz5y4prNqvAa8Uzk8
 HVihG7IleZ+dcCwz9GI1Pfep9EMwK0bI04WDrv8pz/3TULKedlTuuMzsdyVqhhJr1foG
 254E7QnrI2TAiX+gXbn6O8c51AYcyFN4ubCJ6EQFRt9moTLwQjlhkjWEGOcbf9Bl68fR
 lv0St731bY5X959cZgFEwn0Y9tORv+mtnoIHxaWYOB0mAjVWst+yaVCw5BGZVVZ9W0IL
 PllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=WoqjtI8/PDq4XLeCuA4BUU9vOzNcEPwvP6PaF9+jchw=;
 b=PKtaYeac5cESti3XKDom8PR0fGJw6SJUYv0yhsb7AADLlMsjXphDCwX+hKDeBCLgB6
 t7b4di0h3Em8Jg9t6mVJy4GlbRFiVQRd7MVGH9qYALmmox3nAsF1IZkkBZ5Qn5QJACn5
 95tffGS069cHPl6WNCdl78wXAN3UzD1sG+vz858Ulm4N87umH2vHUuGkx2W1NTPCteou
 pai8DzJS2WqTexfHHBe+W24jWsxqV+XQ+TzL9dJOFIdUfLcVN1PrlGb2SoisBbi0q3y4
 D1Vy+1FXwRnZ2wCaO7sGYWvzaUmjEux7oNjXNqtoheGjX5Rg2mKYzjeJWMwZnHOPdEmC
 OYaQ==
X-Gm-Message-State: ACgBeo0FqkSK/ifRyklujjWrMKAJ9r/eebWZ00yq5J3b+nmsvluzegtv
 ra8lR4ahkf4hx8JEw/KIwLE=
X-Google-Smtp-Source: AA6agR5c193Q2KiScRnuf+nXAXJspANTuNt8azcyAEmzHXLvouKJGN9t8xNlwdLZp0TstxxFt+2jUQ==
X-Received: by 2002:a63:6b87:0:b0:41c:2fb4:24f1 with SMTP id
 g129-20020a636b87000000b0041c2fb424f1mr4913613pgc.452.1660343967087; 
 Fri, 12 Aug 2022 15:39:27 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
 by smtp.gmail.com with ESMTPSA id
 fh3-20020a17090b034300b001ef87123615sm315731pjb.37.2022.08.12.15.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Aug 2022 15:39:25 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/virtio: Fix same-context optimization
Date: Fri, 12 Aug 2022 15:40:00 -0700
Message-Id: <20220812224001.2806463-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, David Airlie <airlied@linux.ie>,
 open list <linux-kernel@vger.kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Lingfeng Yang <lfy@google.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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

From: Rob Clark <robdclark@chromium.org>

When VIRTGPU_EXECBUF_RING_IDX is used, we should be considering the
timeline that the EB if running on rather than the global driver fence
context.

Fixes: 85c83ea915ed ("drm/virtio: implement context init: allocate an array of fence contexts")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index fa2f757583f7..9e6cb3c2666e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -168,7 +168,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		 * array contains any fence from a foreign context.
 		 */
 		ret = 0;
-		if (!dma_fence_match_context(in_fence, vgdev->fence_drv.context))
+		if (!dma_fence_match_context(in_fence, fence_ctx + ring_idx))
 			ret = dma_fence_wait(in_fence, true);
 
 		dma_fence_put(in_fence);
-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
