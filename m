Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16106179A6
	for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiyXnj5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700054157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4lF7aMHaWE0StDFmSjkvXf9QppPYg6hsJ7Fo37wmlDE=;
	b=hiyXnj5Cz2ylK27TvjwJNPuiMVaG+kR1Lyk7EkSMZoRnyjmYkwYZg5TRzbvozbxlqVb6zg
	SyAyBLULf0tP9fZo8OJglALWDqvc6EHIYDNbpfnxmTqMKRALlvt3brh0jRaiW3lzG4PsAb
	hB3oenzmH+Zxj0rfcZXwVf4zBvMx5HQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-O5XXaHmfP0GmTPEodZYmYw-1; Wed, 15 Nov 2023 08:15:54 -0500
X-MC-Unique: O5XXaHmfP0GmTPEodZYmYw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32fd8da34fbso3090601f8f.1
        for <virtualization@lists.linux.dev>; Wed, 15 Nov 2023 05:15:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700054153; x=1700658953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lF7aMHaWE0StDFmSjkvXf9QppPYg6hsJ7Fo37wmlDE=;
        b=RRJ/1k7GPBhVpHmQgGsdTBiBU0sgfBb26r0m/0TVKYGmP9pZH8nfscVX3cejNAv8GL
         ZzK1zrprOTNkjyRfUjWYpxlyz5MP/ZtyzlYP7BponlCGXdu0LOKv05yHNuUnDw3Af/9i
         cjBNd8jcHbNfpmITs45jmMvXEgnyFNaFMldsl43B27y78uR31avF3oDSW8W2wT+sVyPm
         dKVeVeVmd4DrepDTcYMwbfuJrpjlfk91XT132v+MYNOzwkPwYwvy5JiyiuRiGZo7VDWZ
         DTQDfWuTwstRdzs0Bdjy84/wnxoChd0xgVlAr/1TLclqbcFGqpdTpmfWpx7ekaoAGl8F
         8kJQ==
X-Gm-Message-State: AOJu0YyySLY6MmTeAIzPmefskvkPAw0lM8cZ1jHXIA+6LIo+x7D0OjJb
	S1nSlXPVTaLkx1rPI02pW17+lekWdqry6Ub7huS+uDdeNbtZbo9hkRcEn7sBq9UFBO/UTkUVOlR
	3/8St+63ZCmLs5OybZzhhox0eGlg=
X-Received: by 2002:a5d:64ef:0:b0:31c:8880:5d0f with SMTP id g15-20020a5d64ef000000b0031c88805d0fmr8815345wri.11.1700054153442;
        Wed, 15 Nov 2023 05:15:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8Akj/DP0M6gaPcJ9iKzQAqtuUVukMuYMObXNcXMXbVoCf04jCr7iPlpSq+gDQSE1T7tfrhg==
X-Received: by 2002:a5d:64ef:0:b0:31c:8880:5d0f with SMTP id g15-20020a5d64ef000000b0031c88805d0fmr8815312wri.11.1700054153053;
        Wed, 15 Nov 2023 05:15:53 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600000cc00b0032db4e660d9sm10551595wrx.56.2023.11.15.05.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 05:15:52 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@kernel.org>,
	Bilal Elmoussaoui <belmouss@redhat.com>,
	Simon Ser <contact@emersion.fr>,
	Erico Nunes <nunes.erico@gmail.com>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
	Zack Rusin <zackr@vmware.com>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2 0/5] drm: Allow the damage helpers to handle buffer damage
Date: Wed, 15 Nov 2023 14:15:39 +0100
Message-ID: <20231115131549.2191589-1-javierm@redhat.com>
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

It is a v2 that addresses issues pointed out by Thomas Zimmermann in v1:
https://lists.freedesktop.org/archives/dri-devel/2023-November/430138.html

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

 Documentation/gpu/todo.rst             | 20 ++++++++++++++++++++
 drivers/gpu/drm/drm_damage_helper.c    |  3 ++-
 drivers/gpu/drm/drm_plane.c            | 20 ++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c    | 11 +++++++++++
 include/drm/drm_plane.h                |  8 ++++++++
 6 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.41.0

