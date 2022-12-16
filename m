Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20EB0C3DA6E
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 23:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67B7B419F3;
	Fri, 16 Dec 2022 23:33:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67B7B419F3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=MEAPdrhZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G1_Q4EvyREEG; Fri, 16 Dec 2022 23:33:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6EE0C41989;
	Fri, 16 Dec 2022 23:33:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6EE0C41989
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30734C0032;
	Fri, 16 Dec 2022 23:33:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1122C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 23:33:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 659BA419EC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 23:33:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 659BA419EC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9bul__jG5iUb
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 23:33:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F0FF41989
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F0FF41989
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 23:33:55 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id gt4so3930245pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 15:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfjZR0CL1te6hYjGQ5Dgru9uZsEh0pXQEs7OK+nQBYw=;
 b=MEAPdrhZCgMx9z1Z6Jn2EYHyIXxjfM1YSxkXyqhSTc2jPmkC1c0uWfXBTsUYHE4PtP
 h8rVGbHesBKlT+CU8fc6gdoh+eOabsO2dVBJGr+mVHhCuUmi6DwypQm/9vV1MI1fcg1D
 5/Yf8XKQKp8JDF1kx0kdS89aVofVbDMcDrnd3M+E0O8FW5mqg3NBwMpmq92xGyZeL7yA
 dYhh8ayAcrmYr90vQ5arscaU13bsjieP09SmQliZrPvFAVWLqFwfXbCVU6Fl1I09FxNL
 01/YSveCtv21TrKwk4tV+8bE8YqKj4uQoT9ueZf8XPZpLeFHtkswnov/hR++CjriaVDq
 WNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfjZR0CL1te6hYjGQ5Dgru9uZsEh0pXQEs7OK+nQBYw=;
 b=DMB2DwlGqPF0oYp0dBgTqPD8tnztXTHruByOWsYo+VK3yYNVqGbbYintEw1fV8YSZ0
 0+fCUFtc0J9ZHKHmtYhV2xxJTXWptu/jgjbx5+3uOkJwWMgZgFVuQLIk65Q2vHWJSmCV
 Im38BnrSDDDXKaSz3ombm2YYahe+eEoZnLej3TtTf+7oP2r7X6GLYJVd0g+MiE36dGPD
 CAxvbwFvM0horFQ6EqYG33U4bAFcL6y3D9TQisFhzTUvmsd0sCqnnW5gLkJ4HApxQ3GK
 Tqt9qDpetbRqhQSBSSjWKruyDSw8/IrdYIfEfSai3LF5j+h+5XcXvs6RPx9yCh9TqPgs
 cFbQ==
X-Gm-Message-State: AFqh2kpjNy6UnGlf4VlfpqEkuEjASKcbwvOPxZDKTAlLK6OwHilR/A2A
 RDlzF7EndGcwlbrpOZ9KZz8=
X-Google-Smtp-Source: AMrXdXsGC5cwDrscK9zfqya1W9a0AUROGuAxhCkIiB+QuUseJeEHf7YPmb7ebCFt6ikROnxni4p6EA==
X-Received: by 2002:a17:90a:6744:b0:219:1d62:9e05 with SMTP id
 c4-20020a17090a674400b002191d629e05mr164074pjm.34.1671233634873; 
 Fri, 16 Dec 2022 15:33:54 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
 by smtp.gmail.com with ESMTPSA id
 64-20020a630743000000b0047781f8ac17sm1976000pgh.77.2022.12.16.15.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Dec 2022 15:33:54 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/virtio: Fix GEM handle creation UAF
Date: Fri, 16 Dec 2022 15:33:55 -0800
Message-Id: <20221216233355.542197-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221216233355.542197-1-robdclark@gmail.com>
References: <20221216233355.542197-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@redhat.com>,
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

Userspace can guess the handle value and try to race GEM object creation
with handle close, resulting in a use-after-free if we dereference the
object after dropping the handle's reference.  For that reason, dropping
the handle's reference must be done *after* we are done dereferencing
the object.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index a5cccccb4998..f1c55c1630ca 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -366,10 +366,18 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 		drm_gem_object_release(obj);
 		return ret;
 	}
-	drm_gem_object_put(obj);
 
 	rc->res_handle = qobj->hw_res_handle; /* similiar to a VM address */
 	rc->bo_handle = handle;
+
+	/*
+	 * The handle owns the reference now.  But we must drop our
+	 * remaining reference *after* we no longer need to dereference
+	 * the obj.  Otherwise userspace could guess the handle and
+	 * race closing it from another thread.
+	 */
+	drm_gem_object_put(obj);
+
 	return 0;
 }
 
@@ -731,11 +739,18 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 		drm_gem_object_release(obj);
 		return ret;
 	}
-	drm_gem_object_put(obj);
 
 	rc_blob->res_handle = bo->hw_res_handle;
 	rc_blob->bo_handle = handle;
 
+	/*
+	 * The handle owns the reference now.  But we must drop our
+	 * remaining reference *after* we no longer need to dereference
+	 * the obj.  Otherwise userspace could guess the handle and
+	 * race closing it from another thread.
+	 */
+	drm_gem_object_put(obj);
+
 	return 0;
 }
 
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
