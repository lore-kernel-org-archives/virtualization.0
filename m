Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793857824;
	b=i09RHuwPMm9wphUeRLdXtX9s9dwNjsqcC/5Lfy8hMVgPlFRag9wqinjdJPkkmYUH8I+/
	 /VR3wcIbfe0rudjdejLc3prHosfMPrPE/iP8fZYIk9NH3u1ET7fCaZyUViMdSvtTP0GmG
	 TyomcO0ukGqlBFBlyvq/hmMcOvrfejvxE9LZFndx//SNHjU5S2RPdXtYhyuABPu5Irbq5
	 Fzov65gs99uw5rmjvPS7RLRWTn2PqS6ABIypnajWODLbovZDyaBqpaRZIpZrATiSv6xiP
	 fLLckuzEBZCnUbjTuHh8d+67hMBfzQsZlB9b/EtlBJOp/e1gEA7iu1oPGTXfeL3YXjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793857824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+g9gPB3NPHJMq13L+EnItb3VxEDWriLeBj7+7fau5JU=;
	b=No3ki+wlP2B8GQNiW48V7k1KZg1mKO8mPcMLDbEkT8iMhOFobGcLn0Wxb5U8B7Vv89Ru
	 o6NVcl8Gn1uT4b1rcZdGts8LIMRj8e/EOQjAh4h6N7kQL6GVKjtIQIPIuCkHoAom3Taxt
	 XBioyZWRVnuu4o7tlndllfwqd6Z6z4JVSos6F0B4xzcCUciwiyotcmrGN4vdnpxGy7MQN
	 OMqkiOmrZP6PwVbWMc/fDQ/pySBcc+Uz+UYS1TCnQ8s7qj4O9ztu+aHU0rzF+Y1tdx2Tg
	 FHlUE/ryT4wlBsibALOgcPbQvkurabvSytr9pHvMrtYQ1lH/1IjQ39Vz0IKX/gsr2Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sp7ZJwpc;
	arc=none smtp.remote-ip=74.125.231.133
Received: from mail-oo2-f5.google.com (mail-oo2-f5.google.com [74.125.231.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05710606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 05:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05710606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sp7ZJwpc
Received: by mail-oo2-f5.google.com with SMTP id 006d021491bc7-7033e26cb19so645799eaf.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 21:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793857823; x=1794462623; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+g9gPB3NPHJMq13L+EnItb3VxEDWriLeBj7+7fau5JU=;
        b=sp7ZJwpcPvRWaBYItbMAzZXMuAX+UtmUYgEa2QYT4dogRTUd95n+iih2qmJOWFBZaz
         Ad4UMv0bNtpmJzqfznp+mMilNCamORllosejd9yyWWIEIIonkm1Kv1c8O6Vt4aqoV+6q
         fY8uTmKoGSwYgodH6pnKXXb8Paoqk5oPEdbQ8mDZ/1GwBuoxqUSCiDnbkiWK4/d5Y5CB
         L9346jh6AF8uo1rNYaikLt3d7TzPrrn3+Sw+VM8xoLeGpt/etaN+AxswrJKeIGBqC45v
         lPlgFFdFtqBzqFvtEAo6gMx9UJDX0jqXDQhISATLfY0r+x4JarQDDCQCzorcgE/Iz1xC
         8iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793857823; x=1794462623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+g9gPB3NPHJMq13L+EnItb3VxEDWriLeBj7+7fau5JU=;
        b=1rxeOdi2wvP4L0ypWJM7EXBuFH6oRgs50vgMTlNTMUhPj+nUKly88Q4aK/vf8ragYR
         9llxEa5OcSjOXqXct9NtdABOIMkWxJPHaI0bPlTIyWdCFVd73EmW7yMIgjCWKLjrXs4j
         3iSSJ714V35fG0EGwFSiz+ns18kGBk9XpfsENg5st2qSQDJhpHPsHyDwFu/LAJl7C05x
         gOsZPpsCcTWzGKFdCXdSzh8tuIm0yuhYv+N/zVFlrNzc3qNdywhJBWM/nKcGrvomYmCH
         PGYATtvy6bAtnDj/ysXD01217N/BGle+NMuDXMQGIZWAtBUF6+dlIwkJIqtGKHqOzYJU
         aSMw==
X-Forwarded-Encrypted: i=1; AKwUvByGno0dn17JpfaKnA8EyYPl6Y43mEFq/V84lOGhLXgAp+q+a7gHs0Z/DqaJOCfgGECG3rUFeM81Z/cw7aKxnQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8ULEN7jTK9VvUUD76qtp++r26fOB0cqvU/LbN8JKYK+Jyl3JSV
	XB9mt1TEnKzGoTzOJ/nW5QkrUo07xdDoMJWskFXgwoxGu5KXcdLVuwZg
X-Gm-Gg: AYBFou0ED7mjgPa90hVojO8JNzWVcWIwECt9LxYUIr9j3Hxg6DBs1lFOx4D/TMbz/oY
	Nmf8yNSsJ4aYzjUpJ3qGh4StG+EhaF1nBdOlepeqSxaFelC4hQzV6UFTFbQhJjvq3NTlu8GAGgH
	H7wADUBNt0cCaf/JrpbbbZiap1svd3THOTzL8giJZBt8ovnBIUlvRQkQ7XTb7fmad2MQHw9PK5h
	wvIRQYRwhiYgAcjd0hTWYVvj2JaV3el1nsTY8AAj2IherF/TM+/SheecskwoeQX7OsF0OwMYtSS
	thAe2Z2BJv4ysGejW2v5WnxhlqdY812S7zOTihfI9T68UheAHuhogfM4gwuKZ3lJJg9HD4vQA02
	Hsaiphc/BzJ+k43/q4tnAVjlt0INFZ00D2LTfUEpaXOvf7kAh/zQ1jzZoQiIbQ2D0xWrTtUgvGZ
	iAMJN8YKHNkJKXNgZs4ZqU9fVdY7cwMhteUoU0754HUBg6IW5qDKkB6ecIyAXZxbTn35hoCDR3u
	DacX9zT4kfUC1epIcCLouDoCiqIel/9miIIhLR304dpuU/l0vmyp+JxBs8ETroWtQKCwSnfzZqB
	dd38BbeQq32bima/7iFZ/ljsBaG0SOHA+vJFeM9alcur4tnBSZspCjnmlPwESK2unjetbJu/iW0
	Q6Diw0v+rfVyG
X-Received: by 2002:a05:6820:f001:b0:716:caab:5347 with SMTP id 006d021491bc7-716caab604dmr2386765eaf.75.1793857822678;
        Wed, 04 Nov 2026 21:50:22 -0800 (PST)
Received: from localhost.localdomain ([14.22.11.180])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea48fd55sm3919776fac.4.2026.11.04.21.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:50:20 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: kraxel@redhat.com
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Henry Martin <bsdhenrymartin@gmail.com>,
	zeroday zhao <zerodayzhao@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bochs: fix VRAM out-of-bounds blit with oversized fb pitch
Date: Thu,  5 Nov 2026 13:50:00 +0800
Message-ID: <20261105055000.1873029-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary plane's atomic_update() copies the shadow framebuffer
into the ioremapped VRAM with the fb pitch as the row stride.  The
blit offset and length grow with the pitch, but nothing checks them
against the size of the VRAM mapping.

Addfb2 only enforces a minimum pitch, so userspace can pick an
arbitrarily large one.  A single atomic commit then writes
framebuffer content beyond the VRAM mapping, e.g. on mainline
v7.4-rc1 (KASAN build):

    BUG: unable to handle page fault for address: ffffc90002800000
    Oops: Oops: 0002 [#1] SMP KASAN NOPTI
    CPU: 2 UID: 1000 PID: 1258 Comm: poc Not tainted 7.4.0-rc1 #1
    RIP: 0010:memcpy_toio+0x22/0x50
    CR2: ffffc90002800000 CR3: 0000000110f75000 CR4: 00000000003006f0
    Call Trace:
     drm_fb_memcpy+0x37c/0x6b0
     bochs_primary_plane_helper_atomic_update+0x36c/0xa20

Reject framebuffers whose pitch * height exceeds the VRAM size in
the primary plane's atomic_check(), same as the hyperv DRM driver
does.

This issue was discovered by Tencent CodeBuddy Security.

Reported-by: zeroday zhao <zerodayzhao@tencent.com>
Fixes: c3ac343c14485 ("drm/bochs: Use GEM SHMEM helpers for memory management")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 8192decddbc1e..527ddd8bcf369 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -422,7 +422,9 @@ static const uint32_t bochs_primary_plane_formats[] = {
 static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
 						   struct drm_atomic_commit *state)
 {
+	struct bochs_device *bochs = to_bochs_device(plane->dev);
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_framebuffer *fb = new_plane_state->fb;
 	struct drm_crtc *new_crtc = new_plane_state->crtc;
 	struct drm_crtc_state *new_crtc_state = NULL;
 	int ret;
@@ -439,6 +441,15 @@ static int bochs_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	else if (!new_plane_state->visible)
 		return 0;
 
+	/*
+	 * atomic_update() blits the shadow framebuffer into the
+	 * ioremapped VRAM with the fb pitch as the row stride. The
+	 * blit offset and length grow with the pitch, so make sure
+	 * the framebuffer fits into the VRAM mapping.
+	 */
+	if ((u64)fb->pitches[0] * fb->height > bochs->fb_size)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.43.7

