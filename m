Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFC3CEB81
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034116; cv=none; b=GqdueDoy3/O/8ePx7WE9kl3hJHEPfbGSuIhwyJ7tvJqWs0pflt+9uBIk7R1MX0crgzzwrOGNT3igic6Zu/rE7pfs8SxosBzm68rU/S1YgLbtbiF9uI3XLeyQWQO+XC+ykddUxFTz9i0cBM94FQbnu5pVwRrdrTkdEmV7THZ3AS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034116; c=relaxed/simple;
	bh=oUQ4zOnhcCXCb2NZHPW7X+oOw+LqffcoU1PnIqoAs7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxT12WzKdGYuWaC+cSqL+Dz8TFykmpJp4z9CVt7uLTTCQO7WIwVJnvIU9z+hYiz9LjyJ2LdFylbjuEEhWJAVRM4Kt6gZ2dc8ipUGuM91vXvAWBp2TrNbJKZwK4aBEK7MoASJS0VkCLqz9htz56cAi9woEFSNBPzUkfzQg98RZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0TemCJ7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0TemCJ7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso49598735ad.1
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777034112; x=1777638912; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ru7oTacAH1AHj/CyXoHHypjd6b0Mk6YIUe6NpkAx0hI=;
        b=m0TemCJ7xep0ZM2J11t5bR2783YqfIp8aqasI+wz+HxiGRV2KStWbaU8YINJOARDV5
         GT1gLvsdhrVPx5+9Ji2jKJbV7SNiD0R3O3c81Ycp+uPcmNqr/ZugpTO/lUV1iSrZTuc7
         1hWpKU3STHoPblsZx4Wh+AZNdakoK6J49dybcwK6q81RtN64Mk/8c6paWHGNgfCGd48f
         E0D90SjkwlcpKePYvnSnbUkw3SkxCUZovcR7eIsxWQfG9AAiN39eJiNyi7PDAVRvxx52
         +NA9wigaDy498tGgM3KjikE/vgMMOJFAqRdFDl7HnNS8uUG0jdScCI2mkvpKfG3IqjTQ
         qlow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777034112; x=1777638912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ru7oTacAH1AHj/CyXoHHypjd6b0Mk6YIUe6NpkAx0hI=;
        b=ZyLfFX/uM40xj/DZw5e5EZrHf3XImFGnoBExa8zj2kXgoGQ999/fxbL1K5s98LHg6G
         pnYGdWsJBkGfAQ4xMB2Jw8d944ZXJcwoFhww7TiXEP0GRxUz3LP/Jn2urk3kKyeHT31N
         2g7IXuyVwT56urXfKmuqAgnc+uHTTg8EDXPisG27Hg7OSSJGbWMhonAG7XhhbJ0vYM8h
         lNymEndMXfJWJcv2PnJGlb3HQYhH+yw86wKkcyznMuXJHDXfw+he2NWsU0qbAENQxs3q
         1oqqBj5BZpQcQMNLBLqvhVdR1akozRzQY40Mza5Gy++VHxuZaSexX1Zo6Fljsye37SBh
         LbMA==
X-Forwarded-Encrypted: i=1; AFNElJ+5Ss2yaoyAcdCjQTqdvsSaIuqPtyfy//mhxYMiQLdhp466e4rkxsLEJ1att7BWl53Sup4ui3z77I/PoBFeMQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyr92EP1VAZIhViWEoNXjtw8F9u6hB7mgqugo4QO7GdHrytJgxS
	HsCtr6D/yp9eoAFQ9YrSCzMqh0N78bFnRGRKG2Eiitac6sPKcMqCSf8=
X-Gm-Gg: AeBDiet+B9AaaxYNbCtJpDCWpkKJlzB8Q3rvbVeXr7Hw7vNykw3N9GS8gXL8o5vR6vB
	32aVXKJgqMp8bBNlIKbdQtmnHhAL8OVaBAGWD8ztt7EBkoUcbkObb1lpX/3lu6gq0Sz/Ivm7gIt
	LpfXnu417qL4lZYF/Y4borSVAbts8/gOt/NLGrI8LOAZTAxWEUi0wmYDNz3/Aj89OIrZ+bBFvaJ
	RXYp02KTqWgQEOX082pNZ6CRSaJxP9yxjcfvPZvdYoIg/zfWaeA35amcGroVjf/LsAXBlRsfAzl
	HJGeCUIVG9JJQzNKpJ8m/Q1NScv28yIedjFnabcIXL+tGrubAv3mzkm79FezKrE/dme8+FkZAKy
	zApqgKnM4Sbo1Sfg+hFVGUMKbDDL5LuOHsxZI4AR14LHs9tTRuLL+KCGCz0cvzWvbB9Wd0mmmVw
	7dbd7rctelGZ+S9TwQmNCo16VoDTjecT8bIxGB6401vQ22wBGWBXXtZUTZDvsVSzcKBasyF9mqy
	TQqcibjRg==
X-Received: by 2002:a17:902:bf4a:b0:2b2:4e5c:69a9 with SMTP id d9443c01a7336-2b5f9e79fa8mr242778605ad.5.1777034112041;
        Fri, 24 Apr 2026 05:35:12 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cdbbsm224428665ad.48.2026.04.24.05.35.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 05:35:11 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bochs: Drop manual put on probe error path
Date: Fri, 24 Apr 2026 21:34:28 +0900
Message-ID: <20260424123506.32275-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bochs_pci_probe() allocates the DRM device with devm_drm_dev_alloc(),
which registers a devres action to drop the initial DRM device reference
on driver detach or probe failure.

The error path currently calls drm_dev_put() manually. If probe then
returns an error, devres will run the registered release action and put
the same device again, after the first put may already have released it.

Return the probe error directly and let devres own the final put.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 222e4ae1ab..5d8dc5efec 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -761,25 +761,21 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	pci_set_drvdata(pdev, dev);
 
 	ret = bochs_load(bochs);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	ret = drm_dev_register(dev, 0);
 	if (ret)
-		goto err_free_dev;
+		return ret;
 
 	drm_client_setup(dev, NULL);
 
 	return ret;
-
-err_free_dev:
-	drm_dev_put(dev);
-	return ret;
 }
 
 static void bochs_pci_remove(struct pci_dev *pdev)
-- 
2.39.5

