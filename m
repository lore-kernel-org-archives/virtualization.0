Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0674315D53
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440305; cv=none; b=rTGLFLVoAuRCP0B6t57w/nsNBqWlsKT/eMFHGBNmb19m/twKixka79BHgBm+A+EqOyVgCWovfULv1MsvGwb5JBP9ewefrzxzpSf/+WYaKLtlF853E+wcdzjYUOTWBnwq8KurMBQBdhimP5l1keA1g1BR0Uql+tc096L58zgPY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440305; c=relaxed/simple;
	bh=H3GXqyRWZmWKxgrex0TsuXWBaW3oWmtAgSFU2n4N7wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOdahYFqwkpMi4SKEFHsmIHqyXtki0ORzlH0u7t6x5lXmmGtW7wJNo+yps8KsjuxI5143dfqMgxZAby1EXmXgkYRjl2cbDqh/Y76Yhg5qDYN3Kar6cXtjJ3pQJRLLZdTDOku4OsJamUNz2fnXOucp/p6gI4Sa9TK+LMLcX0TzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVSMOjOh; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVSMOjOh"
Received: by mail-qk2-f41.google.com with SMTP id af79cd13be357-93c57d36d37so96485885a.3
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440297; x=1791045097; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MSWaUNt8N3BGw3JWkfdkKuhOhB5GPof0nwVAxfKx8+0=;
        b=iVSMOjOhHchcFIerp1636qjRpoKSgP/RqBUAda3ozjEBwOt+yqnG8tKygt8bRsNCqI
         EwjApbnEDZKakZJX8zJqfarBOUMygnnh4DLJMaYR5EhER8T+OWIFmHXgEu195zHW5usB
         H4OzTG+zHYNOpK3wvENXjFZYuwPjLKx//i7OW9QCDx4njCfsEeHC3OVyh7eq5suNjv7/
         5CfK+hNaRFgckBHSo37IZd341sAN02reu++pDZsIXDAC2ZsupKiww86x3qnH00hQEUH9
         t9Kgdt92/3IsRhdHhtdfUVCKDBZkSW/8SmcAsyEJEVXXrP56e7+GloK1paCDad5l5qa1
         sa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440297; x=1791045097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MSWaUNt8N3BGw3JWkfdkKuhOhB5GPof0nwVAxfKx8+0=;
        b=s3CRP/uEV5f4OQwfWAewyBeAv/2prTP6P3Hh2o+943yhmA4jR3GvwxRnWCovf/2x+v
         FXWdGEc1aRDJ7f2yA+Ve2Nk+6NlHz/LyBEYrwdecW0gBgVurBbgAENBz4MKRfrYiPef8
         j3v077llHFObl3vDGXJqWZeT9oUCz5fLiVRj6TNNxvg3F5GS9aoLdiUQr2Pmh2SvB4yw
         tm9MfFAeLDirlH5aUdwRsSLr5Frt+y7fSJIHnJZktFJkzzjKMEK020Nyb7EKn7X9bcbg
         YQR8aT0SZJO2MyOd3iuQ3GHLWScLTRfksd9+op3uSOebXFAl1S/fFF/i49/rkVm+EkUs
         jv5w==
X-Forwarded-Encrypted: i=1; AKwUvBy+vhwp7JxIUK3CTdok7/A3YXwoiV4yf/iimkSXP4KZKAc5kHuSkLDsSOcpf218XErLQ/WGgOycGDBVCVsbyw==@lists.linux.dev
X-Gm-Message-State: AFuF++k4Andn7dCsLB1RgKPHVsAmcKLYmVsELr+NhR5bX6tTm1EyTuZm
	y7828CeZhz7rNhIu+rTAJB8vbq6PkGurd/QP8Y+b/+uQUEalFyBNZ5WG
X-Gm-Gg: AYBFou2+d95vv7Le92ShbfS5tEl2z3grasm68pr5Sj1+xsPpEyRgDcwA50A2rDP9Jco
	/qOP+DDmVl+7I7SyRF5lbkJKq71baPWNfI4lnCWpECOF3AT0yijY82E1NCeMe+aj6QX0FmQZ6Lm
	ug662LsWw+rU3vhAgYAm3W7eTp4HqcPjN8OzOQ2fGT+HVi4VP7Y+XlxoPDa3Gh6wNTEx1Sm3T3W
	vOpAdwaluCMPtVwxKtoXDbUVoLPTiEc4oPBrT84mTIz1rqZsF0ofLfA6icyVzTiGO9VY+rA6gr6
	MKhbC35x7bcVY1YKgto1O8/spUINP0XfA3jzDtavUtsMgN22qgBeLocNupa3tjHCg/CcOZT+lkh
	X9Zjlwr6uQFu5YsvqSIHvEhloz239AB/Ut0tWWlNpLPlTKS47oU7rMGcqx1xoQ/7CL3oAYC+igg
	xu7uJKSkLNKi6mmvJD8Qoxh2NUp8C+3dW177OWbC2Oo35WQOdh6D2H2TS8ErtYD8rrJbIhWQgca
	5cB8S1nfb8uWNcImfntyVQmOOmr3FtFqPAsbZhTmknutsyIpsFocvt8Mw8LMfN5Tm0=
X-Received: by 2002:a05:620a:469e:b0:93c:62a9:d5cf with SMTP id af79cd13be357-93c62a9d67bmr260766085a.56.1790440296574;
        Sat, 26 Sep 2026 09:31:36 -0700 (PDT)
Received: from localhost.localdomain ([2600:4040:29f7:9600:f571:6178:b590:34a4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c4fe09037sm341332385a.27.2026.09.26.09.31.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:31:35 -0700 (PDT)
From: Dillon Amburgey <dillona@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Dillon Amburgey <dillona@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	christian.koenig@amd.com,
	krisman@collabora.co.uk,
	noralf@tronnes.org
Subject: [PATCH v3 3/5] drm/qxl: clear the monitor configuration for disabled head zero
Date: Sat, 26 Sep 2026 12:31:21 -0400
Message-ID: <20260926163123.39217-4-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260926163123.39217-1-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disabling head zero leaves its previous monitor entry intact because
the inactive-head path only clears heads with a nonzero index. With
another head still active, QXL continues publishing the disabled head
as a visible monitor.

Clear head zero using the same path as the other disabled heads.

Fixes: a6d3c4d79822 ("qxl: hook monitors_config updates into crtc, not encoder.")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 51087cacff74..05de8dd3144d 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -350,16 +350,13 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 			qdev->monitors_config->count = i + 1;
 		if (qdev->primary_bo == qdev->dumb_shadow_bo)
 			head.x += qdev->dumb_heads[i].x;
-	} else if (i > 0) {
+	} else {
 		head.width = 0;
 		head.height = 0;
 		head.x = 0;
 		head.y = 0;
 		if (qdev->monitors_config->count == i + 1)
 			qdev->monitors_config->count = i;
-	} else {
-		DRM_DEBUG_KMS("inactive head 0, skip (%s)\n", reason);
-		return;
 	}
 
 	if (head.width  == qdev->monitors_config->heads[i].width  &&
