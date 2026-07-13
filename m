Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08757411668
	for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 13:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783947680; cv=none; b=Ozw/FaPXv1rnhfZS9tQZTtQ+8WhwwPtsBshnI1i0vaxYEYf0glv3SHrNPwmWma6csTgGXiH/7ZjcPvjmrQzN1hT0lfRDtqbmeVbXgjQCcWJGFPrX3AGnPl1v10DKP9JWinUDo27cr+kJVItfBZtNfKpL0dkrWbbm77i4XNKnNKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783947680; c=relaxed/simple;
	bh=WUcQk+W2gRvj9AKZJ+HKO8HCCnSIPe4j7rEN4B8rVs4=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=WOn6dhhdCsDcAYrfdMvSFyXZlBHP8ek7J7SLkuA7ogOHMNC0uBbd8+5Yu0hHR95U1ijiEhzt9cvBsANGq5WEje9EvwNwiwJONnwwc3D2wvc4WJLfTlH8w+dwYNaqI8dFfcgCKVQtnsuBtu6bamcmgR1VfeF8eNR1hUShP31eQek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHOHMGTV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHOHMGTV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783947677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bIN4Uwhb8SwPUKKjdKqPp/oSbTdbYDS5rLSl3N5RmDg=;
	b=NHOHMGTVOKjB9q5edmm52tKjI/dXcfbpPjiAaQVcVC5/DzHExtJvUSlbesaODa7ho24Pmw
	cH5lS0vXx305pTFhAK5XBJ2VpuGleBGV+g01Ic+0H0d9CGh4Gpi+kg0VSmmXKICX6/Er64
	qJXdSXnRIa8ZXd6dhyBLe5tuJk5IA7E=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-eLVcsgDGOjqOdRmGCZGFpA-1; Mon, 13 Jul 2026 09:01:16 -0400
X-MC-Unique: eLVcsgDGOjqOdRmGCZGFpA-1
X-Mimecast-MFC-AGG-ID: eLVcsgDGOjqOdRmGCZGFpA_1783947675
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso2655637b3a.0
        for <virtualization@lists.linux.dev>; Mon, 13 Jul 2026 06:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783947675; x=1784552475;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bIN4Uwhb8SwPUKKjdKqPp/oSbTdbYDS5rLSl3N5RmDg=;
        b=YWCr/1y0Y4HWS3L3N8QB97HFKOiur3IIWoFgF61dQ4w6ynrCRmCVPg+Id4y3KETL7u
         /qId+vr3YKOSJVhCl328vu3lM5JAb0T2RMrd9LE27jlX9BYlFtOuJ/WZ6ZgghVmiOk+8
         xl2u3Km3uW4hbCeUzmP9SPq3ttHfa1gNdgrOtouDdsX4DVKW6DWQBlv4pbaEUPtZ01ce
         89uhNkpDA8jle0lkxeV3TachVyfKNM7qoOR7zik2FIxLaDOLY+AcqHjcYJ6Re6GhwpTc
         mC7Bdv0zPCXr851BGvwPmitkwqAsOu/6pwL8E/tDVASy0OVVwZEpArKouIQzQh49Ou5F
         zNOA==
X-Forwarded-Encrypted: i=1; AHgh+RoTX4bg9UyM0ialZdGVwSgQoIzej/F1Ej7i2R80lIvLUOi6cbQ+sLq/nQqVnwZbkeGg0NN79e4jQsPsNFdi2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpOIsiLW5gRUHXQP+W4D2R6sFTHixV3ziNpgearBStMGimCS+X
	dpSeqOj5L7LgxQ4B4jwQUCsavedfIm486vlySGavF0yduTHc0OiIj422S1tTDfIb4Hwv0ZfkHLB
	c8uFF5N0bQFsF3HHs1N469BFq2aUwfJnn6jPTGsivmzh0JPOFgCnWUV3s2wLHRzyxz2Nh
X-Gm-Gg: AfdE7cmSwwHRzRu5BTk1vrLuLLLF9odTCrTVf1Tnc38qZdojPYdAVOJatDVw5Tk2hTQ
	/6sm9ANGZ5qZUiYopdkWY9/aC9mmDkVLhiyL4r3u4q3Ys+pteqtwHPZXhEUZNtl58eJ0+FKsO/7
	zjthYTquk+TlAlcMdt7SHHQtcbaOROJtdIk0OD6vUh28iBKlfduh4DkucvBir16OcQ5ahiSgEo+
	Bkt84LOg5Pu/Bqtx6bx08u51BPCRsvV36kYF/JCgXaQpSOiHeSw1bkt192bUPid9eaONSePogR8
	erYMSg6HXGbEdCHe5u4IFafjoCP865lhc24oQ5Nwz+1G2qN3ASvWvHV+GbEL70dzfSKPXREM02n
	nUWM0O8kM/Yc9KFqkbJl76aWldqBrsKfn0pZP/5ZenMK+6X2z
X-Received: by 2002:a05:6a00:1d90:b0:845:e9e8:6458 with SMTP id d2e1a72fcca58-84889703f26mr7907406b3a.20.1783947674911;
        Mon, 13 Jul 2026 06:01:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d90:b0:845:e9e8:6458 with SMTP id d2e1a72fcca58-84889703f26mr7907345b3a.20.1783947674363;
        Mon, 13 Jul 2026 06:01:14 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84909673e32sm3183069b3a.56.2026.07.13.06.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:01:13 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Mon, 13 Jul 2026 22:01:00 +0900
Subject: [PATCH v2] drm/virtio: fix deadlock in display_info_cb by removing
 hotplug from dequeue worker
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260713-virtiogpu_syzbot-v2-1-2958fa37d46d@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNzQ7CIBCEX6XZs5gF0/pz8j1MYygs7R4sDSCxN
 n13sfHm8ZvJfLNApMAU4VItEChzZD8WULsKzKDHngTbwqBQNdjIs8gcEvt+et7j/O58Ep3VXY0
 n54ytocymQI5fm/LWFh44Jh/m7SHLb/qTHfBflqWQArXGptTHGukayA467Y1/QLuu6wd/koZ6s
 QAAAA==
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
X-Mimecast-MFC-PROC-ID: vsF3wr1yKaYbCWLcVo-GXrAlm1F7gKVdNG5PnOpagE4_1783947675
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

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

Fix this by removing the hotplug notification from
virtio_gpu_cmd_get_display_info_cb(). The display data (outputs[i].info)
is still updated synchronously in the callback.

For the init path, drm_client_register() already fires an initial
hotplug when the client is registered, which picks up the connector
state updated by display_info_cb.

For the runtime config_changed path, add a wait_event_timeout() in
config_changed_work_func() so that display_info_cb updates the connector
data before the hotplug notification is sent. Also replace
drm_helper_hpd_irq_event() with drm_kms_helper_hotplug_event() since
virtio-gpu never calls drm_kms_helper_poll_init() and thus
drm_helper_hpd_irq_event() always returns false without doing anything.

Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registering a client")
Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
I checked whether drm_helper_hpd_irq_event() is needed in
virtio_gpu_init(), as Dmitry suggested. AFAIS, it is not needed because:

1. drm_helper_hpd_irq_event() is always a no-op in virtio-gpu.
   It returns false immediately probe_helper.c:1088 because
   dev->mode_config.poll_enabled is false — virtio-gpu never calls
   drm_kms_helper_poll_init(). Even if it passed that gate, no
   virtio-gpu connectors set DRM_CONNECTOR_POLL_HPD.

1082 bool drm_helper_hpd_irq_event(struct drm_device *dev)
1083 {
...
1088         if (!dev->mode_config.poll_enabled)
1089                 return false;

2. virtio_gpu_init() runs before drm_dev_register() and
   drm_client_setup(), so no DRM clients are registered yet.
   drm_kms_helper_hotplug_event() would iterate an empty client list.
   The initial hotplug is handled by drm_client_register(), which fires
   a hotplug callback to the newly registered client. By that time,
   display_info_cb has already updated the connector data.

For the same reason, drm_helper_hpd_irq_event() in
config_changed_work_func() was also a no-op. The actual runtime hotplug
notification was always delivered by display_info_cb's call to
drm_kms_helper_hotplug_event(). This patch replaces it with a direct
drm_kms_helper_hotplug_event() call after waiting for the display info
response.
---
Changes in v2:
- Dropped the work_struct approach from v1.
- Instead, removed the hotplug calls from display_info_cb entirely, as
suggested by Dmitry.
- Added wait_event_timeout() in config_changed_work_func() so that the
display info response is received before sending the hotplug
notification.
- Replaced drm_helper_hpd_irq_event() with drm_kms_helper_hotplug_event()
in config_changed_work_func() since drm_helper_hpd_irq_event() is
always a no-op in virtio-gpu (poll_enabled is never set).
- No changes to virtio_gpu_init() — drm_client_register() already
handles the initial hotplug and hotplug event does nothing before DRM
device/client has been registered.
- Link to v1: https://lore.kernel.org/r/20260630-virtiogpu_syzbot-v1-1-0aa06630750e@redhat.com
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 5 ++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 3 ---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index cfde9f573df6..b4329f28e976 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -49,7 +49,10 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 				virtio_gpu_cmd_get_edids(vgdev);
 			virtio_gpu_cmd_get_display_info(vgdev);
 			virtio_gpu_notify(vgdev);
-			drm_helper_hpd_irq_event(vgdev->ddev);
+			wait_event_timeout(vgdev->resp_wq,
+					   !vgdev->display_info_pending,
+					   5 * HZ);
+			drm_kms_helper_hotplug_event(vgdev->ddev);
 		}
 		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
 	}
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c8b9475a7472..e5e1af8b8e8a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -840,9 +840,6 @@ static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
 	vgdev->display_info_pending = false;
 	spin_unlock(&vgdev->display_info_lock);
 	wake_up(&vgdev->resp_wq);
-
-	if (!drm_helper_hpd_irq_event(vgdev->ddev))
-		drm_kms_helper_hotplug_event(vgdev->ddev);
 }
 
 static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device *vgdev,

---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260619-virtiogpu_syzbot-bdab508ffcd5

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>

