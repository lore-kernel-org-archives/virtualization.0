Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304130EF9F
	for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045557; cv=none; b=rbVRnmv42fsbT51+9pTDKQqokf5VH7LSs+QQqWjIksjxj5gECjlJ8mvafKJgmrPrdtnhACcw6lJx4A+FzkDBc/fl4KmuRAy3YMVK5+ZYLNr7K7kWlom9V2a79VuWMJYfi1zkgODLXgEK+Wr4R8W1ReXJ0sBagsosnPzvY1Mx3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045557; c=relaxed/simple;
	bh=y5YIqKVzOgea1hEskvVJXNFijZ0oP6nkRby64GmSm8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GvJ13K1nCOf8NNkjfEWD3XX1EMr/OdddRoxX0oqN/nsk71Zwqu1EwznUb12WGMBJE5EajhfSFTtNjTRgAcdXxqLnTw3kytfAfxClH8xcp7H8CCEDRKgKL4bVrvgMCo4PZLVqwjwSIhrXrLmR+GHjZaZfcGO0lopYer4wsV94wd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FYJKFv7H; arc=none smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FYJKFv7H"
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-9371f6f2813so2108035241.0
        for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 13:59:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767045554; x=1767650354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwzcNp2HYOV4Z1mSXVXCsNd5TObEfxUddJJZvW7JJZk=;
        b=nrKNkfUNa15aj0mkMM6vZDpSVrJpaByu43ehUxuh2z8IWWIUX3erMBSOQ4O4c2zWNC
         hBWPscU4A9aUdkZlA8QkMJ5hD96RiiF3BdlLPNQzCEul+Ej44dcJhg9NUqHorlaZ3pXv
         HLf6E+dUXmz7zFVGNtXStHiRPocSfN/F4lC885KQINXTk24JY3ubq7yN9VezLgDl9eQ2
         nyqbqqoPsicJ+WTbCTkt9JDE6OhpkvIGLqkfBdZXcKavVKgeZZ+yOa+Vi73zlVxOBqWV
         fOBnZmJYaN/ZFw5pKHPpH8X3uWj/FNxz7+ZpLmN/Yy4NI7yXdiu2xb1MvXr6boUw8yZz
         4NWg==
X-Forwarded-Encrypted: i=1; AJvYcCV9K/TCpQwoduAeNN3mzJBVB5uqydDI5THV5k0LZrX/hHpHI7lZDtFLrPAm1nVI2brWPz3GN9PA3zDjFjF+Gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyP6VVIMsfBJF0b4e78zpjchA7u1L3Vsc5SmYQdaYPLupfOgk9f
	hJPC+JRIsajkaLK97NhVKt46tgz87k1Uq5+GG7f4PHZzh6hFMXxyX6STUWSyTQaqsLNOv2NS7fP
	b1/OJV9UL7O01LWR/c8pe62z5VUCxeumI+QdEWJbbFRTCX6t2Szu6kcIhRP7VVsoDVZKJq5Z872
	tDhQToGW66FA2gxjAQD0b//4vwTeSx93etQuMQBijmJxax5hzs/pMw5R4ajuCuhQ77XMDA2JeW9
	kTZEo1C2B1DWOfao1g=
X-Gm-Gg: AY/fxX5kvbT48Oiqe+MlOMFe1aKars5P1bqvaFeC47EQmHZZBvaMLs/riJ3nBKfo0/C
	UNUQEgOWYUEMueANcgFkejKRNJmnA51A6Dv3bkQU3jWMS23nU4jtExApgfuswEV2pAewVGwnidL
	F1gSyJSlV7pvH3pNja5VMnhgQxIGJRtbWz3vjNDrztWjgI0+/Zwk9MKDkR59XSriDFIIbV/VY8A
	+6Kfn5vt2RCVLFzR2BDxCF/Z/7wAAVn3+YVkP/r4tNY/kXnUO/ycWAbcmERVL4lWZm8Cz6SVrrF
	wZQrqzgfzKzoS4o/o5lrHbmFiUn1ZvUgycsQi6en2iIpz4OPjPPuH3ZzciKV/0G+hTF387rBlzk
	IcYN8s3AnMIq9j0RrYLt90NuX/qL8krxjwvydippe6MSR3TfXNNbXZ7s3UtkxcQ/WRn4jV8MGP/
	08kOQE5ydtHSnuNDQsYK/gNK4ZmaMBxoWMNDdfqkUAVSrz
X-Google-Smtp-Source: AGHT+IEd+tD5QNupIBWNgRnIiZt9s0G+y62kD5AMCGP1kqOIWrZzHA2KaBdTD1DUQOwz+SByxc5jMPQT3nZF
X-Received: by 2002:a05:6102:6a8b:b0:5df:b31d:d5d9 with SMTP id ada2fe7eead31-5eb1a7c4517mr9044193137.23.1767045554114;
        Mon, 29 Dec 2025 13:59:14 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5eb1aa5375fsm4693420137.1.2025.12.29.13.59.12
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Dec 2025 13:59:14 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88233d526baso291609566d6.1
        for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 13:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767045552; x=1767650352; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwzcNp2HYOV4Z1mSXVXCsNd5TObEfxUddJJZvW7JJZk=;
        b=FYJKFv7HWTcE3HqSB7FTmzMoDda2qexiRRsNpbJy8wZiK7DsPmnQyvdrOslIl+zkTR
         5Tw/1l3D8rsvfmBakD+tyTkAZBzPU+fQTyeNf/3llDYXyJfvj4JWnEYRRBUM90qFfKGp
         SH98vmR2kn++Uqy782dDm6X//PUEYyqooNni4=
X-Forwarded-Encrypted: i=1; AJvYcCWLiu7Ii0DowMfBc54lZKgqC2CG8sxjnYakTtIsqwIExUIizuLieOJwTaS1xGRLR6kG6V1ldoA874IfYU+6xw==@lists.linux.dev
X-Received: by 2002:a05:6214:428e:b0:88a:3681:1d96 with SMTP id 6a1803df08f44-88d881b984fmr478636676d6.63.1767045552263;
        Mon, 29 Dec 2025 13:59:12 -0800 (PST)
X-Received: by 2002:a05:6214:428e:b0:88a:3681:1d96 with SMTP id 6a1803df08f44-88d881b984fmr478635666d6.63.1767045550918;
        Mon, 29 Dec 2025 13:59:10 -0800 (PST)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9759f164sm231530026d6.24.2025.12.29.13.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 13:59:10 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Ce Sun <cesun102@amd.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Dave Airlie <airlied@redhat.com>,
	Deepak Rawat <drawat.floss@gmail.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Hans de Goede <hansg@kernel.org>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Helge Deller <deller@gmx.de>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Lyude Paul <lyude@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Maxime Ripard <mripard@kernel.org>,
	nouveau@lists.freedesktop.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	spice-devel@lists.freedesktop.org,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	virtualization@lists.linux.dev,
	Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH 00/12] Recover sysfb after DRM probe failure
Date: Mon, 29 Dec 2025 16:58:06 -0500
Message-ID: <20251229215906.3688205-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Almost a rite of passage for every DRM developer and most Linux users
is upgrading your DRM driver/updating boot flags/changing some config
and having DRM driver fail at probe resulting in a blank screen.

Currently there's no way to recover from DRM driver probe failure. PCI
DRM driver explicitly throw out the existing sysfb to get exclusive
access to PCI resources so if the probe fails the system is left without
a functioning display driver.

Add code to sysfb to recever system framebuffer when DRM driver's probe
fails. This means that a DRM driver that fails to load reloads the system
framebuffer driver.

This works best with simpledrm. Without it Xorg won't recover because
it still tries to load the vendor specific driver which ends up usually
not working at all. With simpledrm the system recovers really nicely
ending up with a working console and not a blank screen.

There's a caveat in that some hardware might require some special magic
register write to recover EFI display. I'd appreciate it a lot if
maintainers could introduce a temporary failure in their drivers
probe to validate that the sysfb recovers and they get a working console.
The easiest way to double check it is by adding:
 /* XXX: Temporary failure to test sysfb restore - REMOVE BEFORE COMMIT */
 dev_info(&pdev->dev, "Testing sysfb restore: forcing probe failure\n");
 ret = -EINVAL;
 goto out_error;
or such right after the devm_aperture_remove_conflicting_pci_devices .

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ce Sun <cesun102@amd.com>
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Deepak Rawat <drawat.floss@gmail.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Helge Deller <deller@gmx.de>
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: linux-efi@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: nouveau@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: spice-devel@lists.freedesktop.org
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "Timur Kristóf" <timur.kristof@gmail.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: virtualization@lists.linux.dev
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>

Zack Rusin (12):
  video/aperture: Add sysfb restore on DRM probe failure
  drm/vmwgfx: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/xe: Use devm aperture helpers for sysfb restore on probe failure
  drm/amdgpu: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/virtio: Add sysfb restore on probe failure
  drm/nouveau: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/qxl: Use devm aperture helpers for sysfb restore on probe failure
  drm/vboxvideo: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/hyperv: Add sysfb restore on probe failure
  drm/ast: Use devm aperture helpers for sysfb restore on probe failure
  drm/radeon: Use devm aperture helpers for sysfb restore on probe
    failure
  drm/i915: Use devm aperture helpers for sysfb restore on probe failure

 drivers/firmware/efi/sysfb_efi.c           |   2 +-
 drivers/firmware/sysfb.c                   | 191 +++++++++++++--------
 drivers/firmware/sysfb_simplefb.c          |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   7 +
 drivers/gpu/drm/ast/ast_drv.c              |  13 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c    |  23 +++
 drivers/gpu/drm/i915/i915_driver.c         |  13 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c      |  16 +-
 drivers/gpu/drm/qxl/qxl_drv.c              |  14 +-
 drivers/gpu/drm/radeon/radeon_drv.c        |  15 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c       |  13 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c       |  29 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  13 +-
 drivers/gpu/drm/xe/xe_device.c             |   7 +-
 drivers/gpu/drm/xe/xe_pci.c                |   7 +
 drivers/video/aperture.c                   |  54 ++++++
 include/linux/aperture.h                   |  14 ++
 include/linux/sysfb.h                      |   6 +
 19 files changed, 368 insertions(+), 88 deletions(-)

-- 
2.48.1

