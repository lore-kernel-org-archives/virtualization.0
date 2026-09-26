Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878F43806C2
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440296; cv=none; b=jvcQB2JF++XgCxZdExHwWlAlulFSHkPA+jkrttD+KMBc/7SkKQizskGt7jXbqpkOibNnNdOzxoLSiuFFeXMU4rEm4IPthDVvzyvZF9LWN0ggpYyOS2Fep9RwSUfuZDyg5dgH3w5+KKRfNJXPtIpjXGhDElGzMNzVFwr+1eBxL9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440296; c=relaxed/simple;
	bh=js86bFRXeGRz01VfgdSLlpFJ18e21n6Navx1JM9ocZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUMpTydxMnjCeAvjNEI+O6Xnm57O9W5xtD2Hz4eawIQFCwmSwBMlpjOFaDQbRtXsbvxjaazSLgcWg/n4Ev/iGNSKL1WZ+RZsXQa6GFkGVuFPi7B5t+lSs/yh5kwwgfgEyuQqLqFfzu8IR90myUYl+zEWhEOAtF/k7P8Vg4LoDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNsCES6a; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNsCES6a"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910a0cefaso168661785a.2
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440291; x=1791045091; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ilWbdrK2o5HYjWejTvlhwKOghbkTj1jD2D3PzsAcjlU=;
        b=pNsCES6aUkTd3pgKUbilRq9R9BSAwcFp3XObzxx7bHb9cHA3NHi3VerUX91GrxBJCJ
         VH0rd7yqay1gSmAS/fqcArN1suVow7q6bV8finVEhiNWKEOVUL3qEtfMtiV12s6fFdkE
         Bq9G9ADG9kD2EJIUyxrBEi+E3rQGQ9N246IujOycr52bv9Rqtw9xKSaG1KbQsWJLSsh2
         ts0Z2ez1ixDFS1IRheWb2LCPfsAEyjFQLmW62+CEDzAyQYYojjIhTmuEr7VMGE7BmJcj
         FzcRb3Q4KebyDouKoW4TEy1BIh2Dns844vJNFdpWife/aFxm4DlfXr297LfRG7dNbF9T
         BjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440291; x=1791045091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ilWbdrK2o5HYjWejTvlhwKOghbkTj1jD2D3PzsAcjlU=;
        b=XElvYKFmu5S7szgXwiNuFkUeQijmHi0yK+MU1aXadJD6HkLsbU2+Ywx2o51rIXFQGD
         A35cDhy2PHJyRvLtH1pqogaD1eNBh48nCz8B2dYEwHSOXj/cqRFINdXbOQ1p/yX6w1/a
         BIcE1HqSiQg1MnOHqITqiEMoNY0tEizNB+y6hVEBkT/u8lO6twdLQb3rEBoGfdKet5Cz
         NpgQ2lY1FOOAPwzwOoszedQA4s7RRuoaAzYrv4XkibLpHyowc+l4cJHxixbcNCNtjMti
         YNN/FFN9VpxX1eQmhQyk+AR0TGRAiSI1ewbzKw03DPA7VJsSmN9c98T2BXSztXE/3GKW
         b17Q==
X-Forwarded-Encrypted: i=1; AKwUvBxKGWnqm8JYqdNPVJtMmo0yFTbxQV1geVsmAaeVg6+eB/39F4RJRYLv/l/dHVK1aCf4Vzv0NTWpBpFcPn7btA==@lists.linux.dev
X-Gm-Message-State: AFuF++mVJ7+uPkSsuR+7ry39ijCbIG2A3cZ3VaaM+BTt5TnuwxjYRWYi
	tSQO1e+s5hTF53iELHQR81e41vRPDhhV36v02hRnekVEIfOfbkFPKqtX
X-Gm-Gg: AYBFou2g7VjPS1ecG4MoZOwb0mt2XNbHX8+p8NQFRwLhnpJJdC9kT45FimJLmuXwo+E
	aLlgWreGnk0LSe5QxtDnEUDna02Cu5+lgEwvNEfPl8IsvfPKUcd4cW+C1vDb1tw3VkAo6jqo9gy
	5cXk+BiQKfXNslm9XQrs+5fGySsZ2ILVMBtyWTqUvnQwSoFF0N8AhyyT2YKmlrKLQBQqQVX09Zm
	JrOPYAbEiLT+zuLvMyeXiS+Mo3LxEyutWIF06XnCu0mCuV5DQkgeqeNFoldlTCy6dTCvjz2E26R
	UtS6dz0knpImIriSHb1kAhn4I3HfKBCJAVhr3JEvcLt2+CkUgrlEC5veiqiTEgUt3GP40HOqID+
	8tZhQglJq2UVZMM+GbblyL2PFtHc24vn4I7OFR1dstgiX6c5eGWYE8MHtTfA59kpwwMo6CgxyQv
	2GzEN3+e/zLjgR1gwsxfq84SHAb9hlBFOPCauJHmyVH1OXbc9vcoy83faPUuHRWUCtEXytOouHP
	keDXgM0MdmBgN/OGnYs4CtmvorP5UYfqwWoESYw3TxpoC8au9mTOjTUisTxaT/Yx80k
X-Received: by 2002:a05:620a:4111:b0:939:13a7:70f0 with SMTP id af79cd13be357-93c43b7f202mr1155214985a.5.1790440290642;
        Sat, 26 Sep 2026 09:31:30 -0700 (PDT)
Received: from localhost.localdomain ([2600:4040:29f7:9600:f571:6178:b590:34a4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c4fe09037sm341332385a.27.2026.09.26.09.31.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:31:29 -0700 (PDT)
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
Subject: [PATCH v3 1/5] drm/qxl: unpin the framebuffer when plane preparation fails
Date: Sat, 26 Sep 2026 12:31:19 -0400
Message-ID: <20260926163123.39217-2-dillona@gmail.com>
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

qxl_plane_prepare_fb() pins the framebuffer before preparing its GEM
fences. If GEM preparation fails, the atomic helper cleans up only the
previously prepared planes, leaving this framebuffer pinned.

Unpin this plane's framebuffer before returning the preparation error.

Fixes: 6071c4c2a319 ("drm/qxl: add drm_gem_plane_helper_prepare_fb")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..1f869734e14d 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -887,7 +887,10 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 	if (ret)
 		return ret;
 
-	return drm_gem_plane_helper_prepare_fb(plane, new_state);
+	ret = drm_gem_plane_helper_prepare_fb(plane, new_state);
+	if (ret)
+		qxl_bo_unpin(user_bo);
+	return ret;
 }
 
 static void qxl_plane_cleanup_fb(struct drm_plane *plane,
