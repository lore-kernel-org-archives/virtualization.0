Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7515EC433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 01:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B51782CB7;
	Wed, 16 Feb 2022 01:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TE6-8idgvg53; Wed, 16 Feb 2022 01:15:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B30C681397;
	Wed, 16 Feb 2022 01:15:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8486AC0011;
	Wed, 16 Feb 2022 01:15:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FA97C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E6AE4055D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:15:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WtKsPIzk70IU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:15:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C55D4052D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 01:15:50 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id om7so1036864pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 17:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0hwZ2F3aREhpJrlJ2d2Ygxmwwu5LB/WMxQx3SAucGcc=;
 b=Kn1kq8Z6LR/PsKUAKmu2TgN0q8KMHpYWQ0TA59BvJ8YXgNv9+VQ6HyX8RCNhpl0HKF
 tzKXer0c/VfAgtIdWOuaqJ9PDLt7uNxv183fEXL7piAF+9HILKHrpQGzcrUpaXnhG/0B
 b9WG14crvUmfqNnOWjcOkmRxjzAo55kSsS9JdXzianc87UOkXPI8gUoLh+11HpAuGrYz
 7IX5mR6/cHus1ppqJYk+nXObKvxE2Q1SAmcsvAcHl8XzTLlOcPAykr0lvclKdumwAFgJ
 leMOJyYUdIRBTySDndNDULI/vhF64kb+pDSvx9NbwomaMxjHu5FmJt3FP2Vg2fbh7XMy
 Jkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0hwZ2F3aREhpJrlJ2d2Ygxmwwu5LB/WMxQx3SAucGcc=;
 b=yHXbVQF0gCLQa/QYUkKf5xzqb6h5+6YHYJheIMw/eP8A4MKwwOlLTP03V1nuSIl9+7
 UR7PMy1c7tnvKlW1kvcHlA+oTrNb61nPualFb30gHxqnjzUZvzpmKWTbPzGD0gvi1LjI
 OfhfY+F5HSD7jnWPWMg1zxszlBzkeZW4ykbDkphOAyO97rLDye6D7TufVFviaUQMtuaG
 vmtODsdxeLrJl1Gacw5NDdXPoh8f703pAywcG3DnIFA5TkrK3QL8PJJFPJcLu9arlwvn
 WOdiGCQMAZ3aeY8mcJEvvJfdzwQ94MSyUD6nPJ8+kGT4LT6PfpszUlGBYLie91V+HLF7
 863A==
X-Gm-Message-State: AOAM533PbLZEzwQCmg79GOGYrkuHjWydoyxMNK6WsKAT5+fnumjd1N1T
 y1dRwnSya5uBzcp+tegT1UI=
X-Google-Smtp-Source: ABdhPJzObOPULx4E0kcZ0vLa3iyJhoz+Xq3kxebJsb1C6cXwwaNrpNsO/2CfAyEGSfvbGjclvdffIQ==
X-Received: by 2002:a17:90a:734c:b0:1b9:b1fa:db6a with SMTP id
 j12-20020a17090a734c00b001b9b1fadb6amr191487pjs.158.1644974149433; 
 Tue, 15 Feb 2022 17:15:49 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 ls14sm15760824pjb.0.2022.02.15.17.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Feb 2022 17:15:48 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/virtio: Fix capset-id query size
Date: Tue, 15 Feb 2022 17:16:14 -0800
Message-Id: <20220216011614.360451-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The UABI was already defined for pointer to 64b value, and all the
userspace users of this ioctl that I could find are already using a
uint64_t (but zeroing it out to work around kernel only copying 32b).
Unfortunately this ioctl doesn't have a length field, so out of paranoia
I restricted the change to copy 64b to the single 64b param that can be
queried.

Fixes: 78aa20fa4381 ("drm/virtio: implement context init: advertise feature to userspace")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 0f2f3f54dbf9..0158d27d5645 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -269,7 +269,8 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 {
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_virtgpu_getparam *param = data;
-	int value;
+	int value, ret, sz = sizeof(int);
+	uint64_t value64;
 
 	switch (param->param) {
 	case VIRTGPU_PARAM_3D_FEATURES:
@@ -291,13 +292,20 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 		value = vgdev->has_context_init ? 1 : 0;
 		break;
 	case VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs:
-		value = vgdev->capset_id_mask;
+		value64 = vgdev->capset_id_mask;
+		sz = sizeof(value64);
 		break;
 	default:
 		return -EINVAL;
 	}
-	if (copy_to_user(u64_to_user_ptr(param->value), &value, sizeof(int)))
-		return -EFAULT;
+
+	if (sz == sizeof(int)) {
+		if (copy_to_user(u64_to_user_ptr(param->value), &value, sz))
+			return -EFAULT;
+	} else {
+		if (copy_to_user(u64_to_user_ptr(param->value), &value64, sz))
+			return -EFAULT;
+	}
 
 	return 0;
 }
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
