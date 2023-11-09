Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BFB22330
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KziWsXcr"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8995D61313
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 17:25:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8995D61313
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KziWsXcr
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r4bDzN8vhtgG
	for <virtualization@lists.linux-foundation.org>;
	Thu,  9 Nov 2023 17:25:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A98C6107E
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Nov 2023 17:25:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A98C6107E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699550710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KM+kZjFHA8E0A+l+o485oGQAZV87bwGJzM3u9NBaaMA=;
	b=KziWsXcr0NleOWadOD/8wosDwpxQAra3qhph31PXkukpBApBbgqrVouqs6cHMqts8ripBZ
	q6X+wo//wLOELrch59zzkeMFNT4CtGjHAis96+X0Nl8I5UBxACtpzvIqqXvcbNBlT/Jrqm
	7eDcORSiU40Cbtxq7Zi/gLx3BJTALHw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-8a-tRaMdM8GQZ-w2EmrUEg-1; Thu, 09 Nov 2023 12:25:08 -0500
X-MC-Unique: 8a-tRaMdM8GQZ-w2EmrUEg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4083a670d25so7353475e9.0
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Nov 2023 09:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550706; x=1700155506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KM+kZjFHA8E0A+l+o485oGQAZV87bwGJzM3u9NBaaMA=;
        b=kuOpuMK3xXoifsYQL2FnJ1bPBWYip2rm4mokPTC12PabJhYxZhd9A8k13F15u0m+fe
         9lQpLaYy6dy7RYjjYjd4bfBKyO52r98g0kyFiMxL9d840k1q3C23ZbFlp12z2zh4wWdK
         iORHEsW/NnbR/KRmDyx0OxCsl6euOvRx/NfnbQxpNl7Gx8WxJMHS9q8vtPabxt9Vj5Ep
         BgTQxtqiER0dNKBbj6tsT0sC1S2H9AEKHTTlGY/TsyWCCfpDsi34HMOP8IW2z5xQHCna
         fC0iojna0tcbSoQxDJKG7P8/7oyyQFIvCUqahQxNBw8M65YPR4mvbqvw939CPkovfE1y
         +PZw==
X-Gm-Message-State: AOJu0Ywzd7sg3yFtwAv9ksdBqL6r9pJv1nF0ORiMaeWDtqgwv/JjQR6F
	oYJNajzWez/3y/VKJrj87JeNfUe1WnuWY3WKPqAkSzyEmpHBUGxyJ4r1YYFNs6KWXcxmjF127Ln
	dQlwZSpGIDBxGAs+yUkx9tWjiG3MTd4I/oK2/gA2LyQ==
X-Received: by 2002:a05:600c:3d9a:b0:408:5bc6:a7d with SMTP id bi26-20020a05600c3d9a00b004085bc60a7dmr4807919wmb.19.1699550706435;
        Thu, 09 Nov 2023 09:25:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBYNpBFpSwc4pVpHVCRnVRLdnQyz2wbfqHlyA9KAIkGVscHGBHFPnaFmMk7VrRW7vmMUDnCw==
X-Received: by 2002:a05:600c:3d9a:b0:408:5bc6:a7d with SMTP id bi26-20020a05600c3d9a00b004085bc60a7dmr4807894wmb.19.1699550706031;
        Thu, 09 Nov 2023 09:25:06 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c3b9200b0040839fcb217sm646229wms.8.2023.11.09.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:04 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Simon Ser <contact@emersion.fr>,
	Sima Vetter <daniel.vetter@ffwll.ch>,
	Pekka Paalanen <pekka.paalanen@collabora.com>,
	Maxime Ripard <mripard@kernel.org>,
	Bilal Elmoussaoui <belmouss@redhat.com>,
	Erico Nunes <nunes.erico@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
	Zack Rusin <zackr@vmware.com>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH 0/6] drm: Allow the damage helpers to handle buffer damage
Date: Thu,  9 Nov 2023 18:24:34 +0100
Message-ID: <20231109172449.1599262-1-javierm@redhat.com>
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

Patch #1 is just a refactoring to allow the logic of the frame damage
helpers to be shared by the buffer damage helpers.

Patch #2 adds the helpers that are needed for buffer damage handling.

Patch #3 fixes the virtio-gpu damage handling logic by using the
helper that is required by drivers that need to handle buffer damage.

Patch #4 fixes the vmwgfx similarly, since that driver also needs to
handle buffer damage and should have the same issue (although I have
not tested it due not having a VMWare setup).

Patch #5 adds to the KMS damage tracking kernel-doc some paragraphs
about damage tracking types and references to links that explain
frame damage vs buffer damage.

Finally patch #6 adds an item to the DRM/KMS todo, about the need to
implement some buffer damage accumulation algorithm instead of just
doing a full plane update in this case.

Because commit 01f05940a9a7 landed in v6.4, the first three patches
are marked as Fixes and Cc stable.

I've tested this on a VM with weston, was able to reproduce the issue
reported and the patches did fix the problem.

Please let me know what you think. Specially on the wording since could
made mistakes due just learning about these concepts yesterday thanks to
Sima, Simon and Pekka.

Best regards,
Javier


Javier Martinez Canillas (6):
  drm: Move drm_atomic_helper_damage_{iter_init,merged}() to helpers
  drm: Add drm_atomic_helper_buffer_damage_{iter_init,merged}() helpers
  drm/virtio: Use drm_atomic_helper_buffer_damage_merged() for buffer
    damage
  drm/vmwgfx: Use drm_atomic_helper_buffer_damage_iter_init() for buffer
    damage
  drm/plane: Extend damage tracking kernel-doc
  drm/todo: Add entry about implementing buffer age for damage tracking

 Documentation/gpu/todo.rst             |  20 +++
 drivers/gpu/drm/drm_damage_helper.c    | 166 +++++++++++++++++++------
 drivers/gpu/drm/drm_plane.c            |  22 +++-
 drivers/gpu/drm/virtio/virtgpu_plane.c |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c    |   2 +-
 include/drm/drm_damage_helper.h        |   7 ++
 6 files changed, 173 insertions(+), 46 deletions(-)

-- 
2.41.0

