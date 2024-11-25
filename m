Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B5D1B415F
	for <virtualization@lists.linux.dev>; Mon, 25 Nov 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555544; cv=none; b=T5l5A5yLOUUQboeQ0isBqwTxlTF/9NeR0mNT8GcStEwV/iS24n7RER4DAY5OmHLE3DGEOH30ZrbGtV5hNTnSd9HG2lSCs5mW7IZqeawa4Xtpaf/QUhnOETSHy8DmpkJ0X5YW5XDe7+H0cZlgkTVf+XLM7CwbPkhbDLoccTv0XPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555544; c=relaxed/simple;
	bh=3NsJgxiTqriz6qQDXCK8JEP22fKawrWmvmPgO4GF5zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sd2Z3fMkLag7jRP22C1KYASVCwotlRDlgaS7YteDxDQYfuBPkLLDMhSTqU7MwcX/4rkkL5D/YtVNgZ9yZmDa1Rvt8f8YS10VmJE8L/UoJcEhfJIdnt4zZSINfGOBnJULo+BRGL2+FaRRSfck7rLCZjsGdPh5j3j1p05zgcaoGVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQWXshNs; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQWXshNs"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-7b65d1c707aso153515585a.0
        for <virtualization@lists.linux.dev>; Mon, 25 Nov 2024 09:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732555542; x=1733160342; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVDQspBi0nK52468djjhcLsHS6suKDvQYTgpSTpGaWI=;
        b=MQWXshNsBma+puNnuolglRb4MUCPqz5GE8+XqqceL1savDwNj8IkzkqOoow3Pq5gPy
         FoDrjkRmwjHDXlG5IEY5MzgKY/Zy77Wr9knx3DhWF2DmkAEBhxe5C/JkMO2F6yDch7gZ
         CWOssOlKAXBt4AzoC9A8yrEua26YNhAy/911v0p/GAIpFSlJnmAzaUDVnV2UdPcrXBKW
         DFyyZrPgBvUuxRLUJhv6L1zpX/15X9F+5xF6MfkYTB8Tg5qkfr7omZ7MFnwywaGSmkVj
         TgyBaEsO67q25EL3SxpBXJZR3iQb4YEarAY9xI+dk80/5JcYhjsKfBMKsAZOCaknQ1Ez
         1Rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732555542; x=1733160342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVDQspBi0nK52468djjhcLsHS6suKDvQYTgpSTpGaWI=;
        b=jZsHzKHEwnhhYAK6J07UdLdZv5fdWy7aHf3KTugf3GhzPCPAH5fXsQimo+PNZuaPsa
         yX18tN97NB5dZJKGpqgWnoQr0b6711AMrV0StL9fsLF7qLO0RKEPpm6Iw99vDKDHdz5p
         dJpaAraEYSbdwcEWaWqUvWzqOJdCm1bzN6xbRAhVxX0mguRDsB/NO+jNZ4fhx6RrxrvF
         vPqosR18rNH5v5ovcQkL1Aoo5JNkeA6qhpJXOl2WlA5wCLPdk6yBkfQBGe74PoHEEGC0
         wLJi7Auc+GNV9ltGbAgikjIQvwnmnOZisXHjlUsI3HI4bEIuJ7/27vjNKTkzhh8Hqoyv
         FiXg==
X-Gm-Message-State: AOJu0YzwWtJERt0hGZ3MbPj9GNv+t/BW3fopY6+Lsak+jzwkMrY+mjkU
	FZNd87ENgyoMQJNtP6g4lj2n/CEphT96pqrTlGM3IILCpFNcB3xt
X-Gm-Gg: ASbGncv/6RpxDsRNnpQkfwmAdQLsMGHzeTCB70YCU7Qpfc38TBLh3tYBKc4eSp4t+US
	SBSbuzPpQsPUj6H7jLrBAN/jqIOEaJmjK3ISk438rHODjQzUZNCWglu6cN13+U0UvypiibBscrn
	D/LIIxANI4JcnvyYhNDS3fsHuI0F9xjMY46C3h9xqoJ6lB0Byycfxpw4xiOXpYgpKYZENke08Ha
	rNVcayxNZYxpGNLxxV0voJsfY6B+7geOH/IfncYJ2x6I2IuvRpRVvh1G+hriqBjZ85ijNAFYGBo
	In49T98SZQsDsnRg+coFwrZOVX7m/BWnEZnh
X-Google-Smtp-Source: AGHT+IFGvdFBb55MfpIRzxnpds3EDnlB90XnfhZ3sDfgc1tgDF7Qn6XtKH/y7aitBCCp0Ukgox6SIQ==
X-Received: by 2002:a05:6214:1d0a:b0:6cb:d4e6:2507 with SMTP id 6a1803df08f44-6d450e871f7mr221611656d6.22.1732555542124;
        Mon, 25 Nov 2024 09:25:42 -0800 (PST)
Received: from localhost.localdomain (mobile-130-126-255-54.near.illinois.edu. [130.126.255.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451ab4d8esm44702576d6.54.2024.11.25.09.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 09:25:41 -0800 (PST)
From: Gax-c <zichenxie0106@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Zichen Xie <zichenxie0106@gmail.com>
Subject: [PATCH] drm: cast calculation to __u64 in qxl_mode_dumb_create()
Date: Mon, 25 Nov 2024 11:25:17 -0600
Message-Id: <20241125172516.9622-1-zichenxie0106@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zichen Xie <zichenxie0106@gmail.com>

Like commit b0b0d811eac6 ("drm/mediatek: Fix coverity issue with
unintentional integer overflow"), directly multiply pitch and
args->height may lead to integer overflow. Add a cast to avoid it.

Signed-off-by: Zichen Xie <zichenxie0106@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_dumb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
index 17df5c7ccf69..74076c87a002 100644
--- a/drivers/gpu/drm/qxl/qxl_dumb.c
+++ b/drivers/gpu/drm/qxl/qxl_dumb.c
@@ -41,7 +41,7 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 	uint32_t pitch, format;
 
 	pitch = args->width * ((args->bpp + 1) / 8);
-	args->size = pitch * args->height;
+	args->size = (__u64)pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
 	switch (args->bpp) {
-- 
2.34.1

