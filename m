Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51133092
	for <virtualization@lists.linux.dev>; Thu, 23 Nov 2023 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWrwZAQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700777604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3hQPeRRqjnZSS8OWuMWpjh1Oj2NJuDlBMcX3dbEThk=;
	b=IWrwZAQ3HVB2RnXsLIKnAaoMz1YFK0ckhtsEGGRZYfQRr1gWc58B9g9SIfO/QqfxbN4G6z
	a9x+5wCCYQd01nvIj9R2QkKxL1ahWyR5N1sS4MThrRRiBo50jxdWMywsLTZF1ru+YWmQTT
	zrz9yOQNFxVEtC42nLvpIsfk9LKPRLM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-oKTEFKtFN4q5rslgovS15g-1; Thu, 23 Nov 2023 17:13:22 -0500
X-MC-Unique: oKTEFKtFN4q5rslgovS15g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b3519a03aso7573475e9.3
        for <virtualization@lists.linux.dev>; Thu, 23 Nov 2023 14:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777601; x=1701382401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3hQPeRRqjnZSS8OWuMWpjh1Oj2NJuDlBMcX3dbEThk=;
        b=dEgQn4PnjvCWSLa+rACZpRcFa4VwCnlu5zR+J+GFKwWF1YR50CkevkBQXclVEVxc+A
         c8LZpVZLcg2ASObNr8S/1AFqRVZnxy/8AA0AbLbJQBIifAqm4K7dIEATifxBy8+0PrDp
         JeJgyfgZ2uWNKFiabJyUZZ7WGKPnQZiBtwtG8PZGvlOmgZwhxi/qiR/G7RKcmXHozPm/
         aCQVx24KSzsqpPQ8Ilzq/Q6XULi93GNT150xsD6VkxdsDAYSp1wyDv6iyRjkuQhC1/oP
         CULxdfXsNvpS4cbeb+ra6cFyreqduqH2XQ9b9py8Sq+U9gxy+EHk3pAY2ZJiLyvNiZRq
         tnYQ==
X-Gm-Message-State: AOJu0YyvtLK1SPhuWb6Zpg3mMNnTSVoZb/SBT26VUfb0lEiFvGBIyafZ
	vOK9nW0w3QASEy/AsRw2f2ji+AfgxkXA7/k/tNUh38aqZVDQoUXTG0cE+3Tmq/7eW11K5Ui91bm
	4CID6o6QCXdbcmUpW73rO14S66Go=
X-Received: by 2002:a05:600c:3507:b0:406:44e6:c00d with SMTP id h7-20020a05600c350700b0040644e6c00dmr662874wmq.2.1700777601608;
        Thu, 23 Nov 2023 14:13:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt+DfJY/Kdak/dZD3b9Ayp5iu9B3rETe6oqsTju4XsMZUCKTzrR+3d7cg40KCVTwvZqoHReg==
X-Received: by 2002:a05:600c:3507:b0:406:44e6:c00d with SMTP id h7-20020a05600c350700b0040644e6c00dmr662869wmq.2.1700777601339;
        Thu, 23 Nov 2023 14:13:21 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id je19-20020a05600c1f9300b004083729fc14sm3839537wmb.20.2023.11.23.14.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:13:20 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Zack Rusin <zackr@vmware.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Bilal Elmoussaoui <belmouss@redhat.com>,
	Simon Ser <contact@emersion.fr>,
	Erico Nunes <nunes.erico@gmail.com>,
	Sima Vetter <daniel.vetter@ffwll.ch>,
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
Subject: [PATCH v4 2/5] drm/virtio: Disable damage clipping if FB changed since last page-flip
Date: Thu, 23 Nov 2023 23:13:01 +0100
Message-ID: <20231123221315.3579454-3-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123221315.3579454-1-javierm@redhat.com>
References: <20231123221315.3579454-1-javierm@redhat.com>
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
Reviewed-by: Zack Rusin <zackr@vmware.com>
Acked-by: Sima Vetter <daniel.vetter@ffwll.ch>
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

