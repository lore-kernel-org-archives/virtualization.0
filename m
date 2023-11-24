Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0F25749
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEVYySQZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 734AD402E4
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 14:41:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 734AD402E4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MEVYySQZ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zBsyHUFtTS4G
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 14:41:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DD56640168
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 14:41:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD56640168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700836910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3K50cOwL2e/Sm1/EHsvbvDxOsSWvo2nEBpLvx7bOk4=;
	b=MEVYySQZCUZ4y6+bcAiRUnotn/DK0kkAYMWEIfbxHkcpa/k/2TZbnjtFfymMtdSfsxruW1
	nWUg06zNCLXdf/aHtHvvT+mZ1VvZ5v7cbR/+xMFRk+wlZLjU3uy/x0QKETDWVXb+KCb+E6
	XP7MggkbeQ+Jyy8gZN/GmE4j19z/IYU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-IRBDW0COOl6CmF_WGAmepg-1; Fri, 24 Nov 2023 09:41:47 -0500
X-MC-Unique: IRBDW0COOl6CmF_WGAmepg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3316945c6e5so1644000f8f.0
        for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 06:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700836906; x=1701441706;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3K50cOwL2e/Sm1/EHsvbvDxOsSWvo2nEBpLvx7bOk4=;
        b=aUy9vWGSsBrn8oOYDOqoP5FAE6HR/8TfZ3yU2Mxl93YNAAZGrBOwKbLSYAk7Ml0uyE
         2V/Ig9C9haHZ4a4t350/J75VfSQ0U2vdjQSbZ8JJafveNTBSlvLtTdLVmBvujX6CjkrV
         PSE0PgUIfaX5Z9aQisAVuVZ6cAQspoLRPLNMILuN9fxMNhFe4Djn2fLJ/18FuT5N0mVe
         +C0Fg8udSh89JUkXl/9R2Zt7gr+5Oxyf0UZO8bNCEi6kOQ/tABqKMg8xcR5BIEDnhbRe
         msYIs6aOIhkAysAqGtlResNfqMvZp9/iliihZOK4HeQEfiIHWAjeorr483HAMuVEVG1J
         tG6g==
X-Gm-Message-State: AOJu0YxmNpUQA66Iz4rSIn+pU0v41XPaWVqXTE+B7PQjItbfa6TsJltT
	MyI4JalHb7supEQLj+HLpNNw/pkk1X966BuXDDooDkP1WAfc35MUCp7rAaNr4TSD5oJaYJ+kI9X
	Ognpq2xC7BWbOQif27SGeB2Yhpl2ApY5NXlwMQ3SsNg==
X-Received: by 2002:adf:ff92:0:b0:332:eacf:c9d7 with SMTP id j18-20020adfff92000000b00332eacfc9d7mr2292937wrr.8.1700836906394;
        Fri, 24 Nov 2023 06:41:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE53BbITSRE5erDBMKhplTxbIjo+7N2xRO0vWBt96X5OYz91Q7KP0WC4vmV1rL31vNgSjrYww==
X-Received: by 2002:adf:ff92:0:b0:332:eacf:c9d7 with SMTP id j18-20020adfff92000000b00332eacfc9d7mr2292920wrr.8.1700836906054;
        Fri, 24 Nov 2023 06:41:46 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s15-20020adf978f000000b00332d41f0798sm4514822wrb.29.2023.11.24.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 06:41:45 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: zackr@vmware.com, contact@emersion.fr, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>,
 iforbes@vmware.com, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Chia-I Wu <olvaffe@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Hans de Goede <hdegoede@redhat.com>, Matt Roper
 <matthew.d.roper@intel.com>, David Airlie <airlied@gmail.com>,
 banackm@vmware.com, Rob Clark <robdclark@gmail.com>, krastevm@vmware.com,
 spice-devel@lists.freedesktop.org, Gurchetan Singh
 <gurchetansingh@chromium.org>, Jonathan Corbet <corbet@lwn.net>, David
 Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mombasawalam@vmware.com, Daniel Vetter
 <daniel@ffwll.ch>, ppaalanen@gmail.com, VMware Graphics Reviewers
 <linux-graphics-maintainer@vmware.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix cursor planes with virtualized drivers
In-Reply-To: <20231023074613.41327-1-aesteve@redhat.com>
References: <20231023074613.41327-1-aesteve@redhat.com>
Date: Fri, 24 Nov 2023 15:41:44 +0100
Message-ID: <87h6lbcixj.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Albert Esteve <aesteve@redhat.com> writes:

> v6: Shift DRIVER_CURSOR_HOTSPOT flag bit to BIT(9), since BIT(8)
> was already taken by DRIVER_GEM_GPUVA.
>
> v5: Add a change with documentation from Michael, based on his discussion
> with Pekka and bump the kernel version DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
> might be introduced with to 6.6.
>
> v4: Make drm_plane_create_hotspot_properties static, rename
> DRM_CLIENT_CAP_VIRTUALIZED_CURSOR_PLANE to DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
> and some minor stylistic fixes for things found by Javier and Pekka
> in v3.
>
> v3: Renames, fixes and cleanups suggested by Daniel, Simon and Pekka
> after v2. There's no major changes in functionality. Please let me know
> if I missed anything, it's been a while since v2.
>
> Virtualized drivers have had a lot of issues with cursor support on top
> of atomic modesetting. This set both fixes the long standing problems
> with atomic kms and virtualized drivers and adds code to let userspace
> use atomic kms on virtualized drivers while preserving functioning
> seamless cursors between the host and guest.
>
> The first change in the set is one that should be backported as far as
> possible, likely 5.4 stable, because earlier stable kernels do not have
> virtualbox driver. The change makes virtualized drivers stop exposing
> a cursor plane for atomic clients, this fixes mouse cursor on all well
> formed compositors which will automatically fallback to software cursor.
>
> The rest of the changes until the last one ports the legacy hotspot code
> to atomic plane properties.
>
> Finally the last change introduces userspace API to let userspace
> clients advertise the fact that they are aware of additional restrictions
> placed upon the cursor plane by virtualized drivers and lets them use
> atomic kms with virtualized drivers (the clients are expected to set
> hotspots correctly when advertising support for virtual cursor plane).
>
> Link to the IGT test covering this patch (already merged):
> https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
>
> Mutter patch:
> https://lists.freedesktop.org/archives/igt-dev/2023-July/058427.html
>
> Michael Banack (1):
>   drm: Introduce documentation for hotspot properties
>
> Zack Rusin (8):
>   drm: Disable the cursor plane on atomic contexts with virtualized
>     drivers
>   drm/atomic: Add support for mouse hotspots
>   drm/vmwgfx: Use the hotspot properties from cursor planes
>   drm/qxl: Use the hotspot properties from cursor planes
>   drm/vboxvideo: Use the hotspot properties from cursor planes
>   drm/virtio: Use the hotspot properties from cursor planes
>   drm: Remove legacy cursor hotspot code
>   drm: Introduce DRM_CLIENT_CAP_CURSOR_PLANE_HOTSPOT
>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

