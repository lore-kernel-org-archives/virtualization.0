Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6D30FC26
	for <virtualization@lists.linux.dev>; Mon,  8 Dec 2025 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765192673; cv=none; b=K5fgkOdtkvF8PAnaeXT8R2ObYm5GN8yhx2+zbldqaSetiplQslu0ZCEpc4oCbE+txDINVWqLJJ4oCx1weo8D0fFYC60cKoaeLWalHq0u0TFYGZsyYXPsLZzlt+v4AKEmgOF1wwInwszwxN9tt2ZPnzeLcutjBZ9hnvbmBgaS8Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765192673; c=relaxed/simple;
	bh=X2DLDNd1kYdj8vkfX5yl6SioDgHZyj4Tv8fX06kV5zM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EDl5jNwU4wKA78Ely0xZSiOp1ZOl7AJl4jbm6O8LMd73W6mDtwvLawIel7zwybff8UVh6YxTq5AhJZVEqhjjyD0I72fefanZOybO6Z5zKU2nTx6iRJIbxIlPs53XGR7LpxTan95yTtk4HOLMxWp+LTsju5Lsc5JBlT5p6qOxOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB4Nuyjk; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB4Nuyjk"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37a5bc6b491so36836181fa.0
        for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 03:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765192670; x=1765797470; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOCG7eO+IOYvs+xd7ddninCpQb0paex7uyJ3Uh9q6PY=;
        b=JB4NuyjkGnFakp5KBLxXw1V/lM9WQ3ZiG8PgmKKocLxzBMJYgm+cOTC5wWdTYef7KW
         s15rzg7TBIjLmODUh4qCu9cET8sLedE9WYoiMTq2LRJnzVduNAb3VloOoUb6PLm9kv4y
         H99JcGd8PJn//rKP5c36iz8p+EZ9zWeN0ztF4b/cIsF6uj5ITMuyslfNfVRsK9hwSPBI
         uYbjDowuTuW8G7lO6slcqeYMkMf5F7GRMX9VsXfFwwp+Z5KVLRvrX0GE++VV1OrevKzb
         ktf/kAYx0WpIWaevuj1KoUo4mCavd06KZdCLyPGWow+6YFQjBBA6lRa5+fUIoUlj07pP
         iSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765192670; x=1765797470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOCG7eO+IOYvs+xd7ddninCpQb0paex7uyJ3Uh9q6PY=;
        b=CY8NMlz0/oPconVBbhYOVtFn/rnHx0p5T0ei6CBtmYl8m6xUpKA9+vP3GJsKZpXqfX
         USW4dGMBPt7g1zT6KH7Hgl1Vn2i7ViRvTC6E9Z/0SbDUERebU3xWHj+OhiHHqyTjUIRe
         knDcLIHdFNsPvPduJX8NWnRqkIjfB9j4TwbRbGyMEcL1VrD+KUvxYHODbroB3mtjh+NU
         PcBgggQO4O7m/Z9KItzxGWfLgajnfLEtP/c9bD59rZyiBJETteLYjn6bsffXEEwpJqhj
         ZlFmseJj9CxzaSL0cItqHklRUJM5EGnXqhQdanpBt1mBaegVvn2cPOVZ/C67Hz20NWcT
         CqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9OJyMXnd/FMR1RV2rf1ZcH+LBztzk974Uxo+8zMB1oDFbyTB6FGmbPl6MTeHhF/Iy5dCpuwoSekNselsLcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YykxN+rf+bxB14H8F2/r+hQ4ATMgA7uNyGylqpC3BGLs2zr5mtt
	tOuyCh6iw41WAxmfpSdzlCE2AKCJiIC87GP3PmVtN5kpWqUWFcQ2pdD+
X-Gm-Gg: ASbGnctF3nj5oihEdf/4Y7QdWX5E5ZXUDvb94V8Oj8cD99IORuB3TJjmUAawCO5vbZ3
	1/XWpMOC/sxTN0Ed2i1DakFyzPOu20A3FNwplDady5KtC351CKKjxExnzLITR8PoekPOKfwSycN
	LnL0ddbnKUmVB7sraDPrAI75jB4QiYNdO/2XA+F8G1C8Uh/2qJG5JQV5rV3Qfe1BbmcG8a/QKQs
	lIsFIIC6MtRlmB1w6/koWf24v2kkyJPMGjPd1SCKjWkbIv9Vq39UigmnBhUbxmKxrU5zLMFmBU3
	FDra7CutGK3yZ+tGlrDoBmoDbA9zwz5ZocDxc4s0FGk1eUithytuRh/vAsBfj7bifope77Nv25s
	0Vox1LOUgzRNn8WA6+DYokUpNtK7YlH24EWosTebnxY8MiYG2tGMIgknqQZUEguKBJam8mckxGx
	6jFFadTBowx1EXqqnAZ5Rrc3rRYyJD11C62HldNQt34K4+6uBN
X-Google-Smtp-Source: AGHT+IFWmyERvTDs7Paip7pT+B/ATRQZHULExlPL+PNu3lhsbGI7kGlW5/9g5j/0woCl75JPzc8beA==
X-Received: by 2002:a2e:a989:0:b0:37b:a395:fd68 with SMTP id 38308e7fff4ca-37ed1fba490mr19694081fa.10.1765192669416;
        Mon, 08 Dec 2025 03:17:49 -0800 (PST)
Received: from home-server.lan (89-109-48-215.dynamic.mts-nn.ru. [89.109.48.215])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37e7065591dsm36754761fa.43.2025.12.08.03.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 03:17:49 -0800 (PST)
From: Alexey Simakov <bigalex934@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] drm/bochs: avoid sign extension in video memory size
Date: Mon,  8 Dec 2025 14:16:41 +0300
Message-Id: <20251208111641.4160-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When bochs_dispi_read() returns a value in the 0x8000–0xFFFF range,
the expression bochs_dispi_read() * 64 * 1024 is computed in signed
int and then promoted to unsigned long, which can lead to
int -> unsigned long sign extension.

Cast the multipliers to unsigned long so that the multiplication is
done in unsigned long and covers the full range of the DISPI video
memory register without sign extension.

The QEMU stdvga device using the bochs dispi interface exposes video
memory up to 256 MB, so this change is made against malicious or
out-of-spec return values from the device.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 0a6659bdc5e8 ("drm/bochs: new driver")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index d2d5e9f1269f..943bceadd2f4 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -258,7 +258,7 @@ static int bochs_hw_init(struct bochs_device *bochs)
 
 	id = bochs_dispi_read(bochs, VBE_DISPI_INDEX_ID);
 	mem = bochs_dispi_read(bochs, VBE_DISPI_INDEX_VIDEO_MEMORY_64K)
-		* 64 * 1024;
+		* 64UL * 1024UL;
 	if ((id & 0xfff0) != VBE_DISPI_ID0) {
 		DRM_ERROR("ID mismatch\n");
 		return -ENODEV;
-- 
2.34.1

