Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E3DF4C
	for <virtualization@lists.linux.dev>; Sun, 19 Nov 2023 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea7u83yS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700391442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wduLhA1JfH2JIibNOg1UP/hJXljazR5AfhyG/qLMjyE=;
	b=ea7u83yS69wT4RP2dvQ1MsxYQqFXQUL/FpUU0Ri7CsLpow7Fn3v5x0k3PPbD23WjjiKJvM
	Gy1sOA4zl9Gp3SDDyTsWV75fR27vMUcGp41WrcaUQxj3C0B8wj6uVtPwTBm8YfrRQxZG5/
	I0vkBF0HBJfCPuSMwxThncYmx+PJTOI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-Js0Op4K6MZi-3XJROYD2GA-1; Sun, 19 Nov 2023 05:57:19 -0500
X-MC-Unique: Js0Op4K6MZi-3XJROYD2GA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40a700481f4so6490915e9.1
        for <virtualization@lists.linux.dev>; Sun, 19 Nov 2023 02:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700391438; x=1700996238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wduLhA1JfH2JIibNOg1UP/hJXljazR5AfhyG/qLMjyE=;
        b=iQas03ZmzF0z0TPVubevjsYoHwjOpRQmvIv/8K/Hsw9qsm4bfrO+bSSuuugLWL0XbO
         9yhQOaJpFVDI/AoGfwQEa73M/iH9wPJoofwqSJeGXV2vlnfoiUu5BQ+4FAn+jmkdOD7F
         Me2FzJSo9D4KqZfXwip+pwXtAaborbM8mJ/hPrVtaGJmSaqKu4J9x4wbCEMqEsjS7Z9T
         PFQJBCn7wnAMfBWFf0bOON0441hsZVJee7ANaOhbtGKV21RdBg5VxDnGFUQj8wjcOOnN
         FejQLhrD3PQfyk2UCEEgCPxfLPa/C/4EQPebVrUsvCC7TjOzGpf/T0G3ZDewjBNTKDD0
         QnPg==
X-Gm-Message-State: AOJu0YzHKI5MmHh3XxyyRZtg4cKGmSADpmC2IOvg/hZ1y1f3u3h5DRGK
	A3B57ppmpo9MjUF/eEttvq8mOLWulTgSE8r/aTpwGJpdSLWUEL2ZmQzHCHpGgF3l8i+7ZXXS2Zj
	2KzKq/wtNQwtJp2PQ92SKTX3fRcc=
X-Received: by 2002:a05:600c:5254:b0:408:40e2:773b with SMTP id fc20-20020a05600c525400b0040840e2773bmr3874941wmb.34.1700391438612;
        Sun, 19 Nov 2023 02:57:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlYVHBUM49anhifPkjs7hxrNsnEGArla3y2Mra38iXhi+oYySY1k50/IKpNWu+heDGdF252Q==
X-Received: by 2002:a05:600c:5254:b0:408:40e2:773b with SMTP id fc20-20020a05600c525400b0040840e2773bmr3874914wmb.34.1700391438309;
        Sun, 19 Nov 2023 02:57:18 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b004094e565e71sm9510932wmo.23.2023.11.19.02.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 02:57:17 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Sima Vetter <daniel.vetter@ffwll.ch>,
	Erico Nunes <nunes.erico@gmail.com>,
	Simon Ser <contact@emersion.fr>,
	Bilal Elmoussaoui <belmouss@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	stable@vger.kernel.org,
	nerdopolis <bluescreen_avenger@verizon.net>,
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 2/5] drm/virtio: Disable damage clipping if FB changed since last page-flip
Date: Sun, 19 Nov 2023 11:56:58 +0100
Message-ID: <20231119105709.3143489-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119105709.3143489-1-javierm@redhat.com>
References: <20231119105709.3143489-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The driver does per-buffer uploads and needs to force a full plane update
if the plane's attached framebuffer has change since the last page-flip.

Fixes: 01f05940a9a7 ("drm/virtio: Enable fb damage clips property for the primary plane")
Cc: <stable@vger.kernel.org> # v6.4+
Reported-by: nerdopolis <bluescreen_avenger@verizon.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218115
Suggested-by: Sima Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v2)

Changes in v2:
- Set struct drm_plane_state .ignore_damage_clips in virtio-gpu plane's
  .atomic_check instead of using a different helpers (Thomas Zimmermann).

 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a000..a1ef657eba07 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -79,6 +79,8 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
 										 plane);
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state,
+										 plane);
 	bool is_cursor = plane->type == DRM_PLANE_TYPE_CURSOR;
 	struct drm_crtc_state *crtc_state;
 	int ret;
@@ -86,6 +88,14 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 	if (!new_plane_state->fb || WARN_ON(!new_plane_state->crtc))
 		return 0;
 
+	/*
+	 * Ignore damage clips if the framebuffer attached to the plane's state
+	 * has changed since the last plane update (page-flip). In this case, a
+	 * full plane update should happen because uploads are done per-buffer.
+	 */
+	if (old_plane_state->fb != new_plane_state->fb)
+		new_plane_state->ignore_damage_clips = true;
+
 	crtc_state = drm_atomic_get_crtc_state(state,
 					       new_plane_state->crtc);
 	if (IS_ERR(crtc_state))
-- 
2.41.0

