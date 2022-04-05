Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CE7C433F5
	for <virtualization@archiver.kernel.org>; Tue,  5 Apr 2022 17:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77E714023D;
	Tue,  5 Apr 2022 17:38:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oeyeNKLjCqg1; Tue,  5 Apr 2022 17:38:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DD2DC401E5;
	Tue,  5 Apr 2022 17:38:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACDB8C002C;
	Tue,  5 Apr 2022 17:38:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C6410C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC4BB4023D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B1FjAHBQSfuI
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:38:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F4208401E5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 17:38:18 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 g15-20020a17090adb0f00b001caa9a230c7so3254699pjv.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Apr 2022 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Io1IzG6hmJITuaZIDTYDYzvTfnNkY/lRuamDnYEiYog=;
 b=iz/lmMITgXQh0MqUOEQiFr6dsc0sTdIPypLCCvAym9JOaLdEYvr9t3x/gutfUpMmCz
 YB+c3zyDyI9Wl9NnnLHeqzzbgLg5x/vuuv3yvbSQZ617dXn+sAi8kVRb4YiSh8/NjB0Q
 cr2BhhDA/xuNawlnZ0rK+d9gHXVD67lZMQ6rlXU456ABQwE/ClXPwbq7/Cxz6bgfuspc
 OTehuW8IHfKzC8rrjyVr91xIYR4urF/R+UNHsxqcwR71gfvero52Uj+Em5/icX/Vza7x
 0sNNcdda6Nt3Wak7MkP7XRlddpBgHPjxen/fJAFVjChFfKpN3jJ4Wj4F5J1N6rdoJS14
 jQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Io1IzG6hmJITuaZIDTYDYzvTfnNkY/lRuamDnYEiYog=;
 b=Z5uQUHoD+94ox3hWrmYkDrT2e5/MDHiWweHgFDLtu3wM+6HEn0cn3swvC7ezHarxFI
 hDEJ8Nx8EH4BFsLfVKO76/dJiKepM9HaUvCXo0RQBioBizyYaO3WDIczY/GeNOeDA2Vy
 t9oDdz7oPjtZKOO+31bUTPclETrmPejI20LXoCyZPXsLZI3BfA9BQqmPPxuCf8KmJk5B
 QWUSSV9C+WqAdx+u7yXF2VJSFZBoZYIGp7pI5iIOsbaE2YBaSWQR+7ERkn9gNQOARkeE
 xIspIOZHJAAcTAhRe/0BAaZ2ahzDO0QeJENWrB/IXkn9Nrbrp/eJSUfrsEgxRApZMYYp
 zwBw==
X-Gm-Message-State: AOAM532Kmc1Yjmr9jdPJ1BwdL+WpwaDmiSS8W9Z101pgj1vu2cYv9Zkm
 eJf8Hd0jGEBhewqfyoscR9A=
X-Google-Smtp-Source: ABdhPJz8bWFNWl/yMS3gIRE+9LtjVYBYlTCCD9NPyLbTvdXKCpqIJrQ8mAH5ylinjXsk21ZNuzNM7Q==
X-Received: by 2002:a17:902:a9c5:b0:156:32bf:b526 with SMTP id
 b5-20020a170902a9c500b0015632bfb526mr4687173plr.46.1649180298344; 
 Tue, 05 Apr 2022 10:38:18 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a63b70f000000b00381510608e9sm13966302pgf.14.2022.04.05.10.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Apr 2022 10:38:17 -0700 (PDT)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/virtio: Add execbuf flag to request no fence-event
Date: Tue,  5 Apr 2022 10:39:18 -0700
Message-Id: <20220405173918.1000846-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, David Airlie <airlied@linux.ie>,
 open list <linux-kernel@vger.kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
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

It would have been cleaner to have a flag to *request* the fence event.
But that ship has sailed.  So add a flag so that userspace which doesn't
care about the events can opt-out.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 8 +++++---
 include/uapi/drm/virtgpu_drm.h         | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3a8078f2ee27..09f1aa263f91 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -225,9 +225,11 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		goto out_unresv;
 	}
 
-	ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
-	if (ret)
-		goto out_unresv;
+	if (!(exbuf->flags & VIRTGPU_EXECBUF_NO_EVENT)) {
+		ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
+		if (ret)
+			goto out_unresv;
+	}
 
 	if (out_fence_fd >= 0) {
 		sync_file = sync_file_create(&out_fence->f);
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 0512fde5e697..d06cac3407cc 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -52,10 +52,12 @@ extern "C" {
 #define VIRTGPU_EXECBUF_FENCE_FD_IN	0x01
 #define VIRTGPU_EXECBUF_FENCE_FD_OUT	0x02
 #define VIRTGPU_EXECBUF_RING_IDX	0x04
+#define VIRTGPU_EXECBUF_NO_EVENT	0x08
 #define VIRTGPU_EXECBUF_FLAGS  (\
 		VIRTGPU_EXECBUF_FENCE_FD_IN |\
 		VIRTGPU_EXECBUF_FENCE_FD_OUT |\
 		VIRTGPU_EXECBUF_RING_IDX |\
+		VIRTGPU_EXECBUF_NO_EVENT |\
 		0)
 
 struct drm_virtgpu_map {
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
