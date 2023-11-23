Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9768F2F868
	for <virtualization@lists.linux.dev>; Thu, 23 Nov 2023 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJbo33xg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700777600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BMSDWzklTKYX0k//1UvbJiLR3VQJPVSpH9qxFC3znV0=;
	b=GJbo33xgN7Wu/JYjVnropBxHt6M4RdBX8HYYtHAOGLb43E+rLvRgp3RzlXQpJk1Td2bo96
	OWti92Bqc1/CGt5zDId9QmKs0VWImPoW+gf+N+wglsG9qjv9df9937H/vKBfnOvRY1c4W0
	nYrEvuZx1ABN9Q8e2BJxvAQ7ZktjUds=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-kkQvtnLPOcqQNHc2tyEmZQ-1; Thu, 23 Nov 2023 17:13:18 -0500
X-MC-Unique: kkQvtnLPOcqQNHc2tyEmZQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f7cf9c33bso485052f8f.3
        for <virtualization@lists.linux.dev>; Thu, 23 Nov 2023 14:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700777598; x=1701382398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMSDWzklTKYX0k//1UvbJiLR3VQJPVSpH9qxFC3znV0=;
        b=oNWx+LPAwrzdO1oHj/ynPEid7xPMmaTj9AHv8XkysUtOxRWrBrayYpOXTmPB+DTEzG
         9AsfnPm7FaSYPUryzBB2J+hVPDAU1S0TfzJ2FP4MPFNZ7U1EwlTwL3pjamN1sMwPb6SL
         MbfBEHGbuoU/3e1WKQ4+nHcFSS27A2uWvevneu7ngMoOlaOIe+YcTUlNHCAZQa/J7Duz
         NF/SGrmTKLUYozVA8nQPcN1R+U4KIeYY9nUUwY9zKd9fWDSYwE7xoOKIrCdHkrrSqpDu
         LaZP5YgrATUwIjGi1P27WzU7SpNRHyZ1BmxsQETUAeLNq4a2aaorWlgyd0DwYrGF08ax
         vqxw==
X-Gm-Message-State: AOJu0Yxla3w6jNSIG6rx0B9OYxOzYdmfuPuf+9GKHnCVQ+4vCMOVWmmc
	0esJbOk6EcADOyQ1bf1ncrcBdwazdsgvlc10XAo/Ybf+4zwSN4BL1/CHcOpv68EVvLWtWoIPOJm
	7Mo0o2SnCyvQIJ3Fa/5EjYuqE1UY=
X-Received: by 2002:adf:f24e:0:b0:332:e5e4:35a0 with SMTP id b14-20020adff24e000000b00332e5e435a0mr514649wrp.51.1700777597833;
        Thu, 23 Nov 2023 14:13:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTc5cyyb2Lj+zZeLr8whfuiAjV15w5NBZGgF7fkaZUdpQEkaRfYZjLuIjGVT+m4u1zAGDz6w==
X-Received: by 2002:adf:f24e:0:b0:332:e5e4:35a0 with SMTP id b14-20020adff24e000000b00332e5e435a0mr514631wrp.51.1700777597458;
        Thu, 23 Nov 2023 14:13:17 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v19-20020adfd053000000b0032f79e55eb8sm2641676wrh.16.2023.11.23.14.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 14:13:17 -0800 (PST)
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
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 0/5] drm: Allow the damage helpers to handle buffer damage
Date: Thu, 23 Nov 2023 23:12:59 +0100
Message-ID: <20231123221315.3579454-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Hello,

This series is to fix an issue that surfaced after damage clipping was
enabled for the virtio-gpu by commit 01f05940a9a7 ("drm/virtio: Enable
fb damage clips property for the primary plane").

After that change, flickering artifacts was reported to be present with
both weston and wlroots wayland compositors when running in a virtual
machine. The cause was identified by Sima Vetter, who pointed out that
virtio-gpu does per-buffer uploads and for this reason it needs to do
a buffer damage handling, instead of frame damage handling.

Their suggestion was to extend the damage helpers to cover that case
and given that there's isn't a buffer damage accumulation algorithm
(e.g: buffer age), just do a full plane update if the framebuffer that
is attached to a plane changed since the last plane update (page-flip).

It is a v4 that addresses issues pointed out by Sima Vetter in v3:

https://lists.freedesktop.org/archives/dri-devel/2023-November/431409.html

Patch #1 adds a ignore_damage_clips field to struct drm_plane_state to be
set by drivers that want the damage helpers to ignore the damage clips.

Patch #2 fixes the virtio-gpu damage handling logic by asking the damage
helper to ignore the damage clips if the framebuffer attached to a plane
has changed since the last page-flip.

Patch #3 does the same but for the vmwgfx driver that also needs to handle
buffer damage and should have the same issue (although I haven't tested it
due not having a VMWare setup).

Patch #4 adds to the KMS damage tracking kernel-doc some paragraphs about
damage tracking types and references to links that explain frame damage vs
buffer damage.

Finally patch #5 adds an item to the DRM todo, about the need to implement
some buffer damage accumulation algorithm instead of just doing full plane
updates in this case.

Because commit 01f05940a9a7 landed in v6.4, the first 2 patches are marked
as Fixes and Cc stable.

I've tested this on a VM with weston, was able to reproduce the issue
reported and the patches did fix the problem.

Best regards,
Javier

Changes in v4:
- Refer in ignore_damage_clips kernel-doc to "Damage Tracking Properties"
  KMS documentation section (Sima Vetter).
- Add another paragraph to "Damage Tracking Properties" section to mention
  the fields that drivers with per-buffer upload target should check to set
  drm_plane_state.ignore_damage_clips (Sima Vetter).
- Reference the &drm_plane_state.ignore_damage_clips and the damage helpers
  in the buffer damage TODO entry (Sima Vetter).

Changes in v3:
- Fix typo in the kernel-doc (Simon Ser).
- Add a paragraph explaining what the problem in the kernel is and
  make it clear that the refeference documents are related to how
  user-space handles this case (Thomas Zimmermann).

Changes in v2:
- Add a struct drm_plane_state .ignore_damage_clips to set in the plane's
  .atomic_check, instead of having different helpers (Thomas Zimmermann).
- Set struct drm_plane_state .ignore_damage_clips in virtio-gpu plane's
  .atomic_check instead of using a different helpers (Thomas Zimmermann).
- Set struct drm_plane_state .ignore_damage_clips in vmwgfx plane's
  .atomic_check instead of using a different helpers (Thomas Zimmermann).

Javier Martinez Canillas (5):
  drm: Allow drivers to indicate the damage helpers to ignore damage
    clips
  drm/virtio: Disable damage clipping if FB changed since last page-flip
  drm/vmwgfx: Disable damage clipping if FB changed since last page-flip
  drm/plane: Extend damage tracking kernel-doc
  drm/todo: Add entry about implementing buffer age for damage tracking

 Documentation/gpu/drm-kms.rst          |  2 ++
 Documentation/gpu/todo.rst             | 23 ++++++++++++++++++++
 drivers/gpu/drm/drm_damage_helper.c    |  3 ++-
 drivers/gpu/drm/drm_plane.c            | 30 ++++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 +++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c    | 11 ++++++++++
 include/drm/drm_plane.h                | 10 +++++++++
 7 files changed, 88 insertions(+), 1 deletion(-)

-- 
2.41.0

