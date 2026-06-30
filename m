Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B89316192
	for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811024; cv=none; b=pFaxMl5oNTzu7IApoH/swLFRzkTpCbdCv86wevohvfUGA6GzKRpYmddqyk3aNlSQQtL4NBY2gFWKiLa7q/AD0D0Lru6at4kB2u8iA4LJHSE86640ErF6odvCyaXW1fBOtyYPZDjZ01hVNBdNdkfZwrUsgc8AG4EuvVSRYR0QLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811024; c=relaxed/simple;
	bh=qVZVunnAIEFClL5xxjyBkQV2G0Ey392PyLu0V5W6xQo=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=qKIAdrFhGj4U14Ft8qk7+pWHQ799TkNnyqfXhfIbgj0tqqlscdCpAcJSQeOUEUs1lDV8H3qOXw7pwaLwdD6Z6F1R0XHfauyVp7BulcPZ9h+nxJ3VHm2vKHb+H8VEcXQwLJXuNkueHCwez5UgaO9YShDaRSIEuxIPh381aEm8ZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdjYdih3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdjYdih3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782811021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SQjV7ILhB1oO4EWB5BntYJkQ/7T/8cRlQn3mNNHBaBw=;
	b=ZdjYdih3JLxVd8WWorRre9ENZ4ez2fYMg1nIHD3YKwNs3iPeCLy9q+k/mlX56iafxhuXVE
	2MZaKnsBu8LfpcagTptHi3rUh681GXIJc1ox9QSGIbM5teaTBD5hIN2nxsBo/UlGgJSzJR
	R/yLxSLnePV5+kvXMyMZ32UCcHmGzO0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-sUnH7FYYPN6QqPtCsc54gw-1; Tue, 30 Jun 2026 05:16:59 -0400
X-MC-Unique: sUnH7FYYPN6QqPtCsc54gw-1
X-Mimecast-MFC-AGG-ID: sUnH7FYYPN6QqPtCsc54gw_1782811019
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84622d6102dso2397530b3a.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jun 2026 02:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782811019; x=1783415819;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQjV7ILhB1oO4EWB5BntYJkQ/7T/8cRlQn3mNNHBaBw=;
        b=GAcHjt+lejEjesj6SrRQXZoA9PUieKGZJ795wXhkE9i93WXGMG36pcCRRJmnX39q2X
         IqWC2+ZIvXUiDd4YltTbx5W9CDcWSnOeqWqU+JayajTAXp/+ydIGkpjSnz5YHbSsvuqZ
         qJwn3o3/0IySdGysacIMJSqROEFlELc1gCf4QJ2L2BoyBpJxYiVp3SV8OY8XstFztBsO
         eTGj4uRkm0Z4TCrNcn0zA/Nnudjp3+TZZBDCgYuTy+2GZ2wxeYH6sF7kMpVeW2JkdW/A
         Jf0HSlJW33oxEw8hbduSqwQM6FmMkdtRi3Tf/x1D6cmBrr8Xt8COoyNHwvwWyjlbDg5O
         TVtg==
X-Forwarded-Encrypted: i=1; AHgh+Rose+NL6y+yNB4+qegCd+X1RVYvPahFuj3+0gQk5aN7g4SowuexMOR3YcbpIvD5nD+xaoQT6o2EsvFYG5vIUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyE+7c0rDtd+FVL9tb+bi1+5M6PX8uYekbw+OlmwfudpXADQS/k
	ySzlfGJ2b0X0XKY0SJXSRlrYCPfwgeckKZdC8kjW1IREYyEDTWMEt3YaIxtqdkSusbMwz+cXwCq
	qQsWzu4hqhsyfZx89XLJ12vW8dmDrhemgPCHRs9uft6h8hiEdDG9WrGyKccm1iN2fI9b8
X-Gm-Gg: AfdE7cmG7InVYVayrY/W4Av7stOkV4L4f2Pin4EYzxuhKYK4cpKEN99fDZpZgJ0GYwj
	zkmgyMOP4XGVkaXYjhGA1shp1XaVZnUwskGDOhNj+80Rd+NtUFSJ/UpaYMIQiYYaE0pzKnRecTA
	2lgl3FYMrghTAQBBmIbLV4ymIgJdYfDS7z66JeVaOB9qlvyeoIScvFThTSh/zKMMewC6FdJSSor
	GSwQvkSbM2PcNS94nAt0+5lFCmIb6cRywB93au1+jGPde+ev7r204NI1Yr3zee5vF5xDAijILQY
	5Vj2kMwFj2pIgiM+3t33TiMD+GjWFO1sYWsNVGe+Op0McGa+vWAoxpkIAqoR2s8sq5LNS8u+6hh
	SGXm7j16BgxMqyLfOxYuOdKKH/wd9rnnYeWTcyCQpOMyGdetQ
X-Received: by 2002:a05:6a00:9505:b0:847:8f68:e8d7 with SMTP id d2e1a72fcca58-8479ee9a5bdmr2034494b3a.8.1782811018754;
        Tue, 30 Jun 2026 02:16:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:9505:b0:847:8f68:e8d7 with SMTP id d2e1a72fcca58-8479ee9a5bdmr2034475b3a.8.1782811018268;
        Tue, 30 Jun 2026 02:16:58 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a005af85sm1494569b3a.25.2026.06.30.02.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:16:57 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Tue, 30 Jun 2026 18:16:42 +0900
Subject: [PATCH] drm/virtio: defer hotplug event from dequeue worker to
 avoid deadlock
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260630-virtiogpu_syzbot-v1-1-0aa06630750e@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBMsSKqrRETqaLPR0IpKvHvS8
 i3+TxAxEEYYqwQBL4rkXUFTV6C21VlkpIuh5a3gohnYReEgb/dzic8r/cGkXmXHe2OU7qBke0B
 D97+c5pw/IIUSo2IAAAA=
X-Change-ID: 20260619-virtiogpu_syzbot-bdab508ffcd5
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ryosuke Yasuoka <ryasuoka@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DdDxRjbAYVxrIvd_od6wMAzhH6iBVn0xl718EYffgv4_1782811019
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

A probe-time deadlock can occur between the dequeue worker and
drm_client_register(). During probe, drm_client_register() holds
clientlist_mutex and calls the fbdev hotplug callback, which triggers an
atomic commit that ends up sleeping in virtio_gpu_queue_ctrl_sgs()
waiting for virtqueue space. The dequeue worker that would free that
space calls virtio_gpu_cmd_get_display_info_cb(), which invokes
drm_kms_helper_hotplug_event() -> drm_client_dev_hotplug(), attempting
to acquire the same clientlist_mutex. Since wake_up() is only called
after the resp_cb loop, the probe thread is never woken and both threads
deadlock.

Fix this by deferring the hotplug notification from
virtio_gpu_cmd_get_display_info_cb() to a separate work item. The
display data (outputs[i].info) is still updated synchronously in the
callback, and the deferred work only triggers a re-probe notification to
DRM clients.

Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registering a client")
Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  3 +++
 drivers/gpu/drm/virtio/virtgpu_kms.c |  3 +++
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 12 ++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 7449907754a4..27ffa4697ae9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -264,6 +264,8 @@ struct virtio_gpu_device {
 
 	struct work_struct config_changed_work;
 
+	struct work_struct hotplug_work;
+
 	struct work_struct obj_free_work;
 	spinlock_t obj_free_lock;
 	struct list_head obj_free_list;
@@ -350,6 +352,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint32_t x, uint32_t y,
 					struct virtio_gpu_object_array *objs,
 					struct virtio_gpu_fence *fence);
+void virtio_gpu_hotplug_work_func(struct work_struct *work);
 void virtio_gpu_panic_cmd_resource_flush(struct virtio_gpu_device *vgdev,
 					 uint32_t resource_id,
 					 uint32_t x, uint32_t y,
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index cfde9f573df6..cfb532ba43a4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -154,6 +154,8 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	INIT_WORK(&vgdev->config_changed_work,
 		  virtio_gpu_config_changed_work_func);
 
+	INIT_WORK(&vgdev->hotplug_work, virtio_gpu_hotplug_work_func);
+
 	INIT_WORK(&vgdev->obj_free_work,
 		  virtio_gpu_array_put_free_work);
 	INIT_LIST_HEAD(&vgdev->obj_free_list);
@@ -293,6 +295,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
 	flush_work(&vgdev->obj_free_work);
 	flush_work(&vgdev->ctrlq.dequeue_work);
 	flush_work(&vgdev->cursorq.dequeue_work);
+	flush_work(&vgdev->hotplug_work);
 	flush_work(&vgdev->config_changed_work);
 	virtio_reset_device(vgdev->vdev);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 67865810a2e7..084d98f5dc7b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -816,6 +816,15 @@ virtio_gpu_cmd_resource_detach_backing(struct virtio_gpu_device *vgdev,
 	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
 }
 
+void virtio_gpu_hotplug_work_func(struct work_struct *work)
+{
+	struct virtio_gpu_device *vgdev =
+		container_of(work, struct virtio_gpu_device, hotplug_work);
+
+	if (!drm_helper_hpd_irq_event(vgdev->ddev))
+		drm_kms_helper_hotplug_event(vgdev->ddev);
+}
+
 static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
 					       struct virtio_gpu_vbuffer *vbuf)
 {
@@ -841,8 +850,7 @@ static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
 	spin_unlock(&vgdev->display_info_lock);
 	wake_up(&vgdev->resp_wq);
 
-	if (!drm_helper_hpd_irq_event(vgdev->ddev))
-		drm_kms_helper_hotplug_event(vgdev->ddev);
+	schedule_work(&vgdev->hotplug_work);
 }
 
 static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device *vgdev,

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260619-virtiogpu_syzbot-bdab508ffcd5

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>

