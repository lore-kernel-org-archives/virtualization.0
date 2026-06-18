Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A25130DD2A
	for <virtualization@lists.linux.dev>; Thu, 18 Jun 2026 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781767155; cv=none; b=h/0YZZaglJ2x1bZtmMfsjFrKcL9a4vyzH67HK0kNCLbAD+09QzRqk2p24aQOGQlDgpsruCfthc9LWRZlsNYr7T0gL6UYu+lTkqsKBucYTtd6sBMQAY7n4jjxBDicoDfvAgI/+xeFIZJziY2NfYNZSAWTyfGrXCyebHjQpDh1xs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781767155; c=relaxed/simple;
	bh=Yc/wS/d1/qSBZT5AZyT50G2+PU1qrb10h56XjHH9zvk=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=aHjxFhmyqrYQhabFh4105EbEnNgL6u3PXhcwZlua2HPbtH29J9XdAQfYGTkdN2eaT0KL+xBIp9qL5e8vapHmSJotauAF+qKTqQm3Atag+K8YJhY+0fSTgtYPCK0PM+xuBEi4YlLZ6pLss5LVvcL8JEcG4TgNFbqhRAz5MOIdl5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlGZUA4w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlGZUA4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781767152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rCqSdccfBETy30vxIetTOcEo73ed1Rs+CAf/MV+45CE=;
	b=UlGZUA4wQKnYWs0Q1lS80RUoe96xOtSGArUZ5iYYThmwT33RPi3ZfRqOwW4ENHJIu7Q12C
	ixKQw9BG9EddJQUtWQfiki0Lcu4Fp0+p5y79FMSfio/mM7JFh+ivmbn8po3VlFugu4CiTM
	m7nuzoxWisR2VUS2MLb1l3OMZun4S6Q=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-sCzNWKqzMDC57bPGlSwgpg-1; Thu, 18 Jun 2026 03:19:10 -0400
X-MC-Unique: sCzNWKqzMDC57bPGlSwgpg-1
X-Mimecast-MFC-AGG-ID: sCzNWKqzMDC57bPGlSwgpg_1781767150
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-842208d5b0eso428655b3a.3
        for <virtualization@lists.linux.dev>; Thu, 18 Jun 2026 00:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781767149; x=1782371949;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCqSdccfBETy30vxIetTOcEo73ed1Rs+CAf/MV+45CE=;
        b=ICRHJpbXWZ4U/G5BTpaZNd3THb+V4Nfwgylsuvzs5RXL7kHRi0r3K4W+A0ttSWd9QG
         SzVA0KNHjU0dAHq6c0WbPlWf0vK9mfs4OH6Hkq3R7pNIQKovFgZQEzw3bzCHE1BzufF5
         6BGx9abN5bDkAXVPwxIU6w990dtqJv0XHvfEw4LwL0ZZOivlvKiVP2zFxyz69VOL7LQo
         2Vima5tCIRZiv3N2FpNycJ9Bwz1OVVz3xXyNMwTlWuzf+UQXOtkpwNTZQWLkBmyv8xz/
         sSdmhUN2rx9AOjHyKapwL7ox0nX/vHDRMWYTcWxtgnp3u9gFwghmbqDvYYTZ8TndKz7u
         bf3g==
X-Forwarded-Encrypted: i=1; AFNElJ/O/n4cU1PKtfX/dETNCcBUbqw8YQF7joqyx8QRrQiJ8VUZqnLP0V070aI28o5pbI8VB/1kFNguE71/AUkWiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMiYFxZThPZG3jpu1gODqMvc8ejQZ6QKNRQAUY9O0UfGDFwoM2
	0pe8MVO11TK2T/xBwPDvFcsIl+VoMt6pGyb5XAjya5q4mPnJRMVa7EdRHDmaM09CBvN5hsDcaSr
	Rpr8dAA5tfmHmMHYiJdCBFDAmMYJsMdMMCxnD9SBNwsluGV3tcj59T58HC+IQ4yNLOoDs
X-Gm-Gg: AfdE7clbfB0UjbVw/rHOnrapUOn5VIpI76+6CiyHvAqXL/OXP63Gp2owqxS/WlTprtr
	M5StwarEY1cdmlrj0z/7bfzx8kbDwE0JMNTFeCEQL5y3ArqisFKgAN2Gvn7Wm0P4pbNS39X9/0I
	Qw7oW4UvNmU4QsCGwXLdWW9MqwbrcwGydVijqSJkdVlQxbr7z2DosWp1dd58iMSela4z4MTeunt
	8S/7xM4HoS+Lpx0yaxZbzqRUjll4Lc8NeaEf+NDWzV26ZtY3UzfTm8P3tF7Q94CKMYwGzIddZqI
	Aex75//sz2c2NL2r/7tj53KoX69lcrNd7xqF2wdcruqxSOexXq/ocjbBWZ3XiiOCitgPCCzl871
	+uEYqqmdQRPGVOckBdp8qXbJUWyXhGTRvTGZ8Aht4EFpIIhbT
X-Received: by 2002:a05:6a00:1706:b0:843:4726:e3df with SMTP id d2e1a72fcca58-8452459a7efmr8045424b3a.35.1781767149423;
        Thu, 18 Jun 2026 00:19:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:1706:b0:843:4726:e3df with SMTP id d2e1a72fcca58-8452459a7efmr8045395b3a.35.1781767148924;
        Thu, 18 Jun 2026 00:19:08 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84531dbbe7fsm3178594b3a.14.2026.06.18.00.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:19:08 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Thu, 18 Jun 2026 16:18:30 +0900
Subject: [PATCH] drm/virtio: warn when virtqueue has no free space for too
 long
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260618-virtiogpu_add_timeout-v1-1-dc36cef609d9@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBPSyKyrRETkVLNIRS0C8e5Jy
 7f4P0FATxhgrBJ4fCiQNQW8rmA7V3MgI10MohGykVyyh3wke7h7WbVeIl1o78jaFgfV9VxtQkB
 pnced3v87zTl/9qg/SmcAAAA=
X-Change-ID: 20260616-virtiogpu_add_timeout-33e985718c22
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ryosuke Yasuoka <ryasuoka@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wut26X6Of6c1_kA0pZ2z2GDNslNNtmWHzCsh-ggvPgs_1781767150
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() wait for
virtqueue space using wait_event() with vqs_released as the only abort
condition. This covers the device removal path, where
virtio_gpu_release_vqs() sets the flag, but does not help when the host
simply stops processing the virtqueue while the device remains present.

In that case, the virtqueue fills up and subsequent command submissions
block indefinitely in D state with no diagnostic output, making the root
cause difficult to identify.

Replace the bare wait_event() with a wait_event_timeout() loop that
prints a warning every 5 seconds while the virtqueue remains full. The
wait still blocks indefinitely so driver behavior is unchanged. The
warnings help identify an unresponsive host device during
troubleshooting.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
When the host stops processing the virtio-gpu virtqueue without
triggering device removal, the bare wait_event() in
virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() blocks
indefinitely with no diagnostic output. A DRM atomic commit worker
blocks in virtio_gpu_queue_fenced_ctrl_buffer() while holding the
modeset lock. During graceful shutdown, systemd (PID 1) needs the same
lock — either by writing to the console via fbcon, or by closing a DRM
file descriptor that triggers framebuffer cleanup — and blocks as well,
making the VM unrecoverable without a forced power-off.

  PID: 553    COMMAND: "kworker/u4:3"
   #0 __schedule
   #1 schedule
   #2 virtio_gpu_queue_fenced_ctrl_buffer [virtio_gpu]
   #3 virtio_gpu_primary_plane_update [virtio_gpu]
   ...

  PID: 1      COMMAND: "systemd"  (console write path)
   #0 __schedule
   #1 schedule
   #2 schedule_preempt_disabled
   #3 __ww_mutex_lock
   #4 drm_modeset_lock [drm]
   #5 drm_atomic_get_plane_state [drm]
   #6 drm_client_modeset_commit_atomic [drm]
   #7 drm_client_modeset_commit_locked [drm]
   #8 drm_fb_helper_pan_display [drm_kms_helper]
   #9 fb_pan_display
  #10 bit_update_start
  #11 fbcon_switch
  #12 redraw_screen
   ...

Reproduction steps:
1. Build QEMU with the fault injection patch [1] that adds an
   x-ctrl-queue-broken property to virtio-gpu.
2. Boot the VM and trigger the fault injection from the host.
3. Fill the ctrlq (e.g., move the mouse on the guest's display).
   The process gets stuck in virtio_gpu_queue_fenced_ctrl_buffer()
   in D state.
4. Run a graceful shutdown command (shutdown now or reboot).
5. The shutdown process hangs.

My earlier patch a46991b334f6 ("drm/virtio: abort virtqueue wait on
device removal to avoid hung task") covers the case where the shutdown
process reaches the device_shutdown() call path, which sets vqs_released
to unblock the wait. However, during graceful shutdown, systemd (PID 1)
gets stuck on the modeset lock before ever reaching device_shutdown(),
so vqs_released is never set and the wait is never unblocked.

I initially considered adding a module parameter to abort the wait with
-ENODEV on timeout:

  +static unsigned int virtio_gpu_vq_timeout;
  +MODULE_PARM_DESC(vq_timeout,
  +     "Timeout in seconds for virtqueue wait (0 = no timeout, default)");
  +module_param_named(vq_timeout, virtio_gpu_vq_timeout, uint, 0444);
  ...
  +             if (virtio_gpu_vq_timeout) {
  +                     if (!wait_event_timeout(vgdev->ctrlq.ack_queue,
  +                                             vq->num_free >= elemcnt ||
  +                                             vgdev->vqs_released,
  +                                             secs_to_jiffies(virtio_gpu_vq_timeout))) {
  +                             if (fence && vbuf->objs)
  +                                     virtio_gpu_array_unlock_resv(vbuf->objs);
  +                             free_vbuf(vgdev, vbuf);
  +                             drm_dev_exit(idx);
  +                             return -ENODEV;
  +                     }
  +             } else {
  +                     wait_event(vgdev->ctrlq.ack_queue,
  +                                vq->num_free >= elemcnt ||
  +                                vgdev->vqs_released);
  +             }

This approach aborts the wait and allows the graceful shutdown process
to eventually proceed, albeit with a delay.

But that approach has drawbacks: it allows users to set arbitrarily
short timeouts that could destabilize the driver, and aborting commands
mid-flight is a rough recovery path. An unconditional timeout was also
discussed previously [2] but is not appropriate without virtio
specification support.

This patch takes a safer approach: replace the bare wait_event() with
wait_event_timeout() and print a warning every 5 seconds while the
virtqueue remains full. The wait still blocks indefinitely and no
commands are aborted, so driver behavior is unchanged. The warnings
help identify an unresponsive host device during troubleshooting.
Once the user notices the warning, they can work around the hang by
unbinding the VT from fbcon, removing the device, or forcing a shutdown
via SysRq.

[1] https://gist.github.com/YsuOS/fbcd181752594af35f954953a1d260b8
[2] https://lore.kernel.org/all/8a986c52-964f-42a5-b063-fbe2b242ca36@collabora.com/
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 68d097ad9d1d..a546130d3b6a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -410,8 +410,13 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	if (vq->num_free < elemcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
 		virtio_gpu_notify(vgdev);
-		wait_event(vgdev->ctrlq.ack_queue,
-			   vq->num_free >= elemcnt || vgdev->vqs_released);
+		while (!wait_event_timeout(vgdev->ctrlq.ack_queue,
+					   vq->num_free >= elemcnt ||
+					   vgdev->vqs_released,
+					   5 * HZ) && !vgdev->vqs_released)
+			DRM_WARN("ctrlq waiting for host: no free space for %d secs\n",
+				 5);
+
 		/*
 		 * Set by virtio_gpu_release_vqs() to unblock
 		 * synchronize_srcu() wait in drm_dev_unplug().
@@ -592,8 +597,13 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->cursorq.qlock);
-		wait_event(vgdev->cursorq.ack_queue,
-			   vq->num_free >= outcnt || vgdev->vqs_released);
+		while (!wait_event_timeout(vgdev->cursorq.ack_queue,
+					   vq->num_free >= outcnt ||
+					   vgdev->vqs_released,
+					   5 * HZ) && !vgdev->vqs_released)
+			DRM_WARN("cursorq waiting for host: no free space for %d secs\n",
+				 5);
+
 		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
 		if (vgdev->vqs_released) {
 			free_vbuf(vgdev, vbuf);

---
base-commit: b9e2d5cdaab05c997be3a69d9b372d7676683e1b
change-id: 20260616-virtiogpu_add_timeout-33e985718c22

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>

