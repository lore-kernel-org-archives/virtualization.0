Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39114D9550
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775005; cv=none; b=sgYI+vzd29E4fTQ0HNi2JnEDijkznVThq1lN2iiwuI1u6VCs2zKNPrEUsv+orZEqMnN3FlZH7hlUtYXQEQe/UFgrUWFUleDm366qJ+GIcRYUiiQ+gUV4nV4vKqi9DWVIwsXK7oU2U+9DV7XrMJRYZpCj8CBzakg7jOxl6NKkni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775005; c=relaxed/simple;
	bh=6Vs6O8PONoMOrR7ZONa21JMLdmlfVfP+AU3ZmYHeqoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=L2YVqAPVmKMdbtvkCskc+WDzTmAQYj7It6H+IQMW86jIrQYb+aRWCHEgiuhKWMkC2muhZQH3rImk+6Rl59wuh6dycv5E3xVfBRg2odDrxa8p7PMFydKgZGnDMPAb+ei7xX+LLS/igRT0bavYT6eW2pXWcwTUPUSvIvUr19BUt+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ccUBWyDL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ccUBWyDL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790774992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WYoWKwmmFmUn/iLrFWt5ayLZVBeiXg5SrFLIxovOK5Y=;
	b=ccUBWyDL6R5aQnPik+kHg3SVQcTnciFKhTKT/OSjUIb1GbJv6dT49YwYNdCxIj/1ZrE77o
	DWDNpk+EXA3NSgUw4kC2MOn1mfP8H35iPoyMRHoBnrkB2JI2sBxvClsKlDeM9f63NNw81I
	ODxOJ+VaHA+LCtHUp1mfnxXooCcLh74=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-soK_OVOjN3CZZ1LpJzQMlQ-1; Wed, 30 Sep 2026 09:29:51 -0400
X-MC-Unique: soK_OVOjN3CZZ1LpJzQMlQ-1
X-Mimecast-MFC-AGG-ID: soK_OVOjN3CZZ1LpJzQMlQ_1790774990
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso53917215e9.1
        for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 06:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790774990; x=1791379790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYoWKwmmFmUn/iLrFWt5ayLZVBeiXg5SrFLIxovOK5Y=;
        b=CNcXcjj1Amv7NrCm4/Wu7z/fMnT9gj3TdULk1cf2xTmRrPV2raNwWSPMwK/4bAfoDe
         cwTkvwfmv4vhv3PC0zsaV8DdTZrYbTkglbRjluG5/nYOK6iy+FZrP047Wo9V3vDUM1+N
         xoM+eYRxwAv7HvUIH8GLYSZ5wfDw2MuckKZ8TSKD3TfgtNbyYQpLv5xGjWfKcwVKr3Vc
         DqcAr9NhJsaM9SjQKJf0KurVw2NJUZNnpRtPHdYwZBUrt2FFCT1NevfxZgYLEc6p8zKF
         evp5eCrQcOQ9fohMEPk1lSH8if/pvTaXVz2FL7XoX0hjWn05LAGhFwqdQ0ruVgRIVVBY
         4AGA==
X-Forwarded-Encrypted: i=1; AKwUvBzSi0VMLbV6EQPt8NxAYzlnrq9kd+U7FcSKErJvRp6J0rFCO6luYZsYXXM67BapfMz7LSvrWtHaXbXLqaTxOg==@lists.linux.dev
X-Gm-Message-State: AFuF++kLIlRLql+cio+EWGDGXxqqbYiP6O0SbBb/UcV8RqNQahsGhKJr
	9vCcj1kPWr6EMk3gV7JtTAko/HGkArou+ibdqdwKIQJwXUv0gM5MBgnWFFdbHD3icH0xBUUE38T
	gKZhN4guW3hW6uMHqQK4gN3SuFlqU6UuHwVN3ST2iGv2I8JjB2RhC4kBnfR/4GsYk/ANI
X-Gm-Gg: AYBFou1ovFGirK3ET8ISCbhFZEbESDQ2/0ntZc4PIi+85LevHyqWrMDSwhrTIbl8aaX
	siLZKg+owX+udWku9b2kry3/AbxsFodkNarxtoHSNECFifzDiGmuAB1TrZ4LbUL7RNzK6fflzxF
	8a5foMnDQsSe8t6UOMiH7o0CNrrz8KMGSbhUlaux/PezFOHZgvCPMIkJGHscdgGQdFikJioc9CO
	vJhuGSZ40sIWpBRHMoVz+t6cjzrGCglj+NQJW4jipjS2WmXom2Ry0mzo++4l/hFV7RgITWsBzx3
	vfhKGz/H6PL6Zm/qeAMJHUH9kc2LS7RC+qHTuVQstHmDnbO+Ff6D0C33mkwImaIvNHlJqtJ+ieL
	yYlUl8NRBw4obrVVPvUa2aziMt8YOKMvTKQjTxGSMcgJgmuY0wcn35PdxkiQt77pJ6eb1fBFkfs
	chU3A5LfXNpDs=
X-Received: by 2002:a05:600c:a10d:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a01c102ebamr14248985e9.27.1790774989713;
        Wed, 30 Sep 2026 06:29:49 -0700 (PDT)
X-Received: by 2002:a05:600c:a10d:b0:4a0:1c10:1372 with SMTP id 5b1f17b1804b1-4a01c102ebamr14248695e9.27.1790774989381;
        Wed, 30 Sep 2026 06:29:49 -0700 (PDT)
Received: from dbassey-thinkpadp16vgen1.tpbc.csb ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0174e165fsm63564975e9.6.2026.09.30.06.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 06:29:41 -0700 (PDT)
From: Dorinda Bassey <dbassey@redhat.com>
To: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Cc: kraxel@redhat.com,
	airlied@redhat.com,
	dmitry.osipenko@collabora.com,
	slp@redhat.com,
	mhrica@redhat.com,
	gurchetansingh@chromium.org,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	linux-kernel@vger.kernel.org,
	Dorinda Bassey <dbassey@redhat.com>
Subject: [PATCH] drm/virtio: add ARGB8888 support for primary planes
Date: Wed, 30 Sep 2026 15:27:07 +0200
Message-ID: <20260930132707.500748-1-dbassey@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BVLHziN1lAorXFbDxLwNK3j8MOwcIfQaodBqaf3RqL8_1790774990
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add DRM_FORMAT_HOST_ARGB8888 to the list of supported formats for
virtio-gpu primary planes. Without this, glmark2-drm fails at
startup because it selects ARGB visual configs by default, which
don't match the XRGB-only plane capabilities. This causes
drmModeSetCrtc to fail with EINVAL.

The virtio_gpu_translate_format() function already handles
ARGB8888 translation to VIRTIO_GPU_FORMAT_B8G8R8A8_UNORM,
so this just exposes the existing capability to userspace.

Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index b422eba42a5f..5f0bc1b1931b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -37,6 +37,7 @@
 
 static const uint32_t virtio_gpu_formats[] = {
 	DRM_FORMAT_HOST_XRGB8888,
+	DRM_FORMAT_HOST_ARGB8888,
 };
 
 static const uint32_t virtio_gpu_cursor_formats[] = {
-- 
2.55.0

