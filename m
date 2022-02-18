Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858DFC433F5
	for <virtualization@archiver.kernel.org>; Fri, 18 Feb 2022 15:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 052A840C06;
	Fri, 18 Feb 2022 15:57:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CvpC_FXzYdOm; Fri, 18 Feb 2022 15:57:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0FED040110;
	Fri, 18 Feb 2022 15:57:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3AB9C0011;
	Fri, 18 Feb 2022 15:57:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAB7FC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 15:57:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A53ED84C5C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 15:57:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PorSKTvxOQcF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 15:57:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 174EE84C36
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 15:57:05 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id w1so7491070plb.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 07:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=76Ch6++ik3Xa10+F3GaCo4BUItW2eOp7s3nI1jmAaLM=;
 b=A40JfGTULXeEUbGb9OgxcyRI82LxcgRaLTkMait0arWn+xroPYbZgjIcpuB5u2l1L+
 sTwFaGQpf0koggIBdKnYnVx02wX+TVu+8ngmXD4e7mMp6hfp/9APvsdldJHD2S112YZX
 v0zRiA6pIR7tBEyD0HnWuzTAZbL4cUJkdVFUXqZchlUVOW67Um90cP1XMFHJOwBDyZ9f
 /ttNhcRWdNNqaCHpuwvI4UYXlp7znCgoVpx2tUjH2FYfuR5RJd51GVi6XJfzidG6PMUn
 f8Rh0O6P6+uxpaOehdQTpSOIWRP6HJ8ORQ1r5wu6YA15UfW+KBar4KEnTWeMoX67eHY0
 5UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=76Ch6++ik3Xa10+F3GaCo4BUItW2eOp7s3nI1jmAaLM=;
 b=nNEDmzGFif1oCCLXfOzmoGPhyg1r47Su9TtvSvtCmA2DR1LSkILYtp8yOYF4a5GCgr
 P7gU7uhLbbD1TsNBJxaH9i10XsWbEJKIEbFIjh6JL850ym0rhHlbqmddeU8UIdtHexUW
 0USQhXAFZC3iFjLIZkk42TAlyHgkq2NM0LXxvZcl/b89uFySVxI+d2Quu+BWcB3YcNlH
 K2YaVf7+HECPl1JpUNzJRntddUHs5tW5E3IVeK6ay2GkyU7mLCeXyPBEBHsCFu6fpcJJ
 5Ok6GfpDtWKcEv7jsfZiI0wiQSzutaxN/nSdSPYfCpGWH1OvqQeMpK9OaQdsLb9OiPNQ
 eUiA==
X-Gm-Message-State: AOAM532jIKl35Wj1BywzSoQTPqh6x76RVxSSiI/Py33b8xSmhC8Kaij5
 C5bdnvFYtB6ia/OHN64KYYU=
X-Google-Smtp-Source: ABdhPJzowmB7x8JMRpgtI/TJsdA2/uiiijdaIc3IM5FfQuUSf/aRW56OUqxSDoCAKPwWMBnLsaESQg==
X-Received: by 2002:a17:902:c10d:b0:14e:d3ca:8a20 with SMTP id
 13-20020a170902c10d00b0014ed3ca8a20mr8021755pli.92.1645199824398; 
 Fri, 18 Feb 2022 07:57:04 -0800 (PST)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
 by smtp.gmail.com with ESMTPSA id
 x1sm3485752pfh.54.2022.02.18.07.57.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Feb 2022 07:57:02 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/virtio: Add USE_INTERNAL blob flag
Date: Fri, 18 Feb 2022 07:57:25 -0800
Message-Id: <20220218155725.487785-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.34.1
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

With native userspace drivers in guest, a lot of GEM objects need to be
neither shared nor mappable.  And in fact making everything mappable
and/or sharable results in unreasonably high fd usage in host VMM.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
This is for a thing I'm working on, a new virtgpu context type that
allows for running native userspace driver in the guest, with a
thin shim in the host VMM.  In this case, the guest has a lot of
GEM buffer objects which need to be neither shared nor mappable.

Alternative idea is to just drop the restriction that blob_flags
be non-zero.  I'm ok with either approach.

 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 7 ++++++-
 include/uapi/drm/virtgpu_drm.h         | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 69f1952f3144..92e1ba6b8078 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -36,7 +36,8 @@
 
 #define VIRTGPU_BLOB_FLAG_USE_MASK (VIRTGPU_BLOB_FLAG_USE_MAPPABLE | \
 				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
-				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
+				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE | \
+				    VIRTGPU_BLOB_FLAG_USE_INTERNAL)
 
 static int virtio_gpu_fence_event_create(struct drm_device *dev,
 					 struct drm_file *file,
@@ -662,6 +663,10 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->size = rc_blob->size;
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
+
+	/* USE_INTERNAL is local to guest kernel, don't past to host: */
+	params->blob_flags &= ~VIRTGPU_BLOB_FLAG_USE_INTERNAL;
+
 	return 0;
 }
 
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 0512fde5e697..62b7483e5c60 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -163,6 +163,7 @@ struct drm_virtgpu_resource_create_blob {
 #define VIRTGPU_BLOB_FLAG_USE_MAPPABLE     0x0001
 #define VIRTGPU_BLOB_FLAG_USE_SHAREABLE    0x0002
 #define VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
+#define VIRTGPU_BLOB_FLAG_USE_INTERNAL     0x0008   /* not-mappable, not-shareable */
 	/* zero is invalid blob_mem */
 	__u32 blob_mem;
 	__u32 blob_flags;
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
