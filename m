Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5FF35975
	for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786604897; cv=none; b=ly88QNzv2Han6jxGfr6K+BaYyrN0lIeJcOm7lOnm/GktFGgwO4N/hEb8ZWWxAGn33fl3+2nVG+PYd/5YaBPvhdOgxfGqU+VqlMC+Z3R3Glh5R9DbtUdlf2YEXogZAmtJIunaeOly6mxVrR1kbQmi61GIo8FqishAyIzjU5WAL/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786604897; c=relaxed/simple;
	bh=bh4B7O/nniVK1wq8M9cB8RIRsbzfRKwBou+ARWbIlmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XXq+GtSxpJxiFXINBmMpm8on99+S0cpZgRu46AyxomJJtuCO9qe4XkwF0dOP7oGnAtz52Ry6R/ExnmV50icPhy/6L9f6xcwWOK4Oo1y7Z6hwtUqrwllASG25PYXFoSTh/tWdfVvvYUB4HjmG/9dgsldQUtsBIQAQP3/N49OXRyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7DS1zMk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7DS1zMk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-930f72317a6so108355685a.3
        for <virtualization@lists.linux.dev>; Thu, 13 Aug 2026 00:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786604895; x=1787209695; darn=lists.linux.dev;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSbJwX3mVENBYQLVT50jOp9wDyIPziduBiZzfCOk5ZY=;
        b=e7DS1zMkeO+b/UGnka9/FWIpol5vG4AZ3bSRgrfSK9fvCU8RUqlwkF4CZqfWebun/F
         G89tU0kIJgMcwOHWPrfg96N8ih7QKZsaI0O8FU6KOBQe8yZm9velRkrgeAUzKsmNSk2Z
         yn83FJNYbm+FKVj6Dt8OurPJRnrvrklgv4/vBdyzR1NpZH7unlBwxblu1yXUNAvH1vED
         y5gXSZuHO7uMW3RDKzy7sjqnKRV09xPsjCTeqxN0vGFmZXDgi2YiKN8zwirixHQ8KeRE
         Zp37BcKgiqImFiY5kIZDvWnvSPGcvNozz0E/wlU6NsOD5Z8IedNEnDJO5saI01RICM/q
         wbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786604895; x=1787209695;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSbJwX3mVENBYQLVT50jOp9wDyIPziduBiZzfCOk5ZY=;
        b=OIK/dVVaBiHU9+pxlTfa0X8i6IxEn4i0Z6mORTWx7SKGK1vB0YL149+A/E7NpA16Vc
         Ll1A2iJbNWkRN3sHD+so3MAC1nfdS5kUltl07JJkPx9if7s95XyoICSaTPyGYPR/CJ9v
         2ZFDCxcjwDT1nFG7WkS3lF+okE/LP+7hXqYE+VbFEzQrOlCGk351XEWN/nHHh5zB0FSG
         /QGeEqx/9WxG3Y24Km1L3eDcrD15xBaNVG4Q2L4CZN0i9lw6pfLOvrYTazeavl4vSWBT
         030/BIwAN6YD/5MXK7hkhDwaCE7PSSwxGkR5tGdoGPhthcxvysSAQPFbvdIaq0tjm3dt
         Rsaw==
X-Forwarded-Encrypted: i=1; AHgh+RpMMhzcWnlh/ftbzx1Iw2OTigrbebVXHIo8XvlVnwfG1k/kY/8kJ5+nc5DqXWoIIEnYsuZuZo3wAKS+XZCXBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxsJQkSf8nIqcZXZ51vX0mso5lvcAXYqFPIfe/0M5EPzVZk8vMl
	jTfRW1diUctRaqqvNUYB8J4QE2UfUb1Sk8lpD0C0lZrUfBnkjk3LprIr
X-Gm-Gg: AR+sD13HVdMYIqaj+oUHqfR7wGHWSpRGQAWRb0ajrWfjqLnVup4kxZLXefhabpZQ8HP
	2jubbdO3nU4gVObtp5rda7zRLJwvxiJdW/+b3TVf84ixiUSmVhf0QGpdVmJg5rv3e1EawOG7aud
	QH+GiFKwUs+ABuqICPCzGESfgI235Am4d00++PLQGNYYS57IE3YZhSoQ8h75OeN+YwcrWbpTFkS
	aKF3/74r0Ep/lg7bqdOAtqVD2lQRgABTe01gpW9UAFPIVuHr7UD1MagYYlBOGMdP8OA6g8by1CI
	pgGdsyF8Apzr44s+IJsSTsenPRblfAr+Kqx2ASVvgKcdZYNE2bWCh4W5awp69gK5gkZk0hQA2QW
	uoAUsWrLSVC+xapvH7k9cZrZLjfFCpDgO41oQHbNzmrCOetomjw415yrK7ZY/YU8JLEx11H/gG+
	Bn0wpzw4ZHNAOonkaNtSVgWfd0yXSn3/oL/q1c0duxIikhpew3gJHcJEe89YoxfTA=
X-Received: by 2002:ac8:7d0f:0:b0:519:8b76:2ce0 with SMTP id d75a77b69052e-52d73e0144cmr31264241cf.37.1786604894953;
        Thu, 13 Aug 2026 00:08:14 -0700 (PDT)
Received: from localhost ([37.19.206.57])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d73dfaf51sm11432531cf.6.2026.08.13.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:08:14 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:08:09 +0300
From: Dan Carpenter <error27@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/virtio: Fix a NULL vs ERR_PTR() bug in
 virtio_gpu_user_framebuffer_create()
Message-ID: <an1tWfHIHwtXd9SO@stanley.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains that returning a NULL here will lead to a NULL pointer
dereference in drm_mode_addfb2().  Return an error pointer instead.

Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
This code is obviously over a decade old.  I think this patch is correct.
None of the other implementations return NULL, but I haven't tested it.
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 44ffffec550f..85ea252c658e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -344,7 +344,7 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	if (ret) {
 		kfree(virtio_gpu_fb);
 		drm_gem_object_put(obj);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return &virtio_gpu_fb->base;
-- 
2.53.0

