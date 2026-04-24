Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC9930DD00
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777029952; cv=none; b=pPWwqRmqclCHBQed5oeKV0qjqqVw8QPkA4Bb/ReKMSYyZBsrS4JVNeaeGPwI8zddI/SEVeOgpbH5o/9/utBN/7DFX9QsqM6xZwstPkQrg1+Eev+eKwA3/yespr3cTyVJB06Px/H+dCQOv1g26FpFYgV91GIpIc+QRjMuji17HKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777029952; c=relaxed/simple;
	bh=uRnq5eJz+CVtIj4P57vTT+K3+E8v0KlscITuP0PKqB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sn2WI2s4eU9nSYNG6AKDZhJ3xNwNJIlnEZqbmvUleeZg5qj3AGnSjyZxRg9ql6jIMuueXPiYIDYZFvTqxSheScOlNJbnC9RsA02/eF4NzwAtcy8mH5niCzmCAwpaLaGopYgX/5Kbn1eU9aAddMY6zOQVxEyt7WRZ1iMfn1xIgeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QByZL6yn; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QByZL6yn"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-356337f058aso5013172a91.2
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777029951; x=1777634751; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FSJ7I3/KIQ88Wa0Cq5z543CNK+Uoag1ofD2MM0j17pQ=;
        b=QByZL6ynYhMqKwHzuP+jkWbT0w9xuaZA1KPzEdy7R+FNia2dEpx1qEj4bsPrUQMh1K
         IpG1MvWW7US+FtnUrq4g+Gsq9as4sqzXYOQOEPEiDZlKySSPFZGUFc2uA8kgL9a7AJLq
         dSvMQPdsj4XB9jTS1e7p083IlejZEQNn13EKPbVU94f1U2bIpW2DatTUVjX+F/mVVxJa
         pLd80frKFDjqL2NHZ9xhHxcfLXFDX+sUuGUamCppvQaSNxpfPshw5LUBoPn3BmfKl3JN
         hnb7C47eZ3k1At9M0NRpRlNA9Wc0GAs2hQ5QW8N2OzFnkk6Irl2/qVZJwcgbkqfUVOPu
         24Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777029951; x=1777634751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSJ7I3/KIQ88Wa0Cq5z543CNK+Uoag1ofD2MM0j17pQ=;
        b=hbLCHzDZ5PHccerT602PJqodmeiTu3R2e/cqmOil6jTbB86446cGB+jH6MSaJQBmsr
         E2wnJ47NQ82gKKMba2rGVueX0Ztz9Gz33o5OPynQQYtH+KX6Yq747Ag2IryhenK0lFCt
         7gpCZZGS2VHKUn4vDuUVZNj2zrpkn2dXA8iWzn99+ccL6BjRsx/firO8M0C+yFqCoITO
         dTz8sg7O9vfdpPkM32dQ/WIcdP2k8xQ9sJA0PQJTXzJIwQNQeqEPxzLyIsZ826h2QSjF
         zsCSHfW0/sUiLnKhNoSRQ4GlCT6QjQpPXlfi+Dx4lcvhWZYoNsp+IEOXfVY0v1zIZ9IS
         beaA==
X-Forwarded-Encrypted: i=1; AFNElJ8V8O4qhN7vBIEybyiLCwT60W6nfwyMyiLucWKpvxVK/eTlAAkUkVndK8JYfgOvrKv5Uz6+fLIFAOAfOMW/2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuCwOQfnXmXwmazkAqegjMfxw92aHcIa3WmHwAlST9PucrAT6q
	rp9Jyizp4MdPNEyYBULOr/md/D1PR+80IgLK620ZXUF6+/KifOOdcFM=
X-Gm-Gg: AeBDievVCduSRLeoJfC13lew6sBURj0kQ2vEDSDQcs57WIn4KCy+mKU7i0Ge3xN62bw
	yC/iTJOsrurlDAlQNVxsq4W/Mpq2Oiz+3/Yj3/NtXMuNU9n+DpOlXQye8iGbiaSMw9p0IaoL4FA
	2B2IuG4OcCTPcVSCRM/ZZUCBYc1ObXazXuak/rh21cS7Lg2pcSR87Bbv7l440x24tPPVVZeLPwl
	UidoID4geXYr8cauv/qA+J0FsGEPKiUtVZyPuhr2FeOEdMen9x2S5o2NaHDUkla1qev6JQS02ZS
	rvRrz92BKHhA8OtkLMf3Kyj5+SiWttvePu26a6mieVx5N7hZURN7o/vnINw+smKD1IQWb7mEqDj
	Rcu7GEZv4LlFbaE/si9edb1IRnkeqPcotyJHHsfJsynht7jZTerMLjGtg8fueF/+3NNo/FrqBQW
	ETkfVid7tbPeeqq9/TcwRA+FgTkoh78dcQzoKc5pQiXMnwDmceZZykcGmAjvWJbyAHFygkpBaHi
	lRaUqtbcg==
X-Received: by 2002:a17:90b:380c:b0:35f:b5df:448 with SMTP id 98e67ed59e1d1-3614049ed12mr32784879a91.24.1777029951174;
        Fri, 24 Apr 2026 04:25:51 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141990bb6sm23974050a91.17.2026.04.24.04.25.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 04:25:50 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] drm/qxl: Fix missing KMS poll cleanup
Date: Fri, 24 Apr 2026 20:25:18 +0900
Message-ID: <20260424112543.57819-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_kms_helper_poll_init() initializes the output polling work and
enables polling for the DRM device. qxl enables polling before calling
drm_dev_register(), but the drm_dev_register() failure path tears down
the modeset and device state without disabling the polling helper.

The remove path also unregisters and shuts down the DRM device without
first disabling the polling helper. Add matching drm_kms_helper_poll_fini()
calls in both paths so the delayed polling work is cancelled before qxl
tears down the associated modeset/device state.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 2bbb1168a3..1e6a2392d7 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -118,12 +118,13 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Complete initialization. */
 	ret = drm_dev_register(&qdev->ddev, ent->driver_data);
 	if (ret)
-		goto modeset_cleanup;
+		goto poll_fini;
 
 	drm_client_setup(&qdev->ddev, NULL);
 	return 0;
 
-modeset_cleanup:
+poll_fini:
+	drm_kms_helper_poll_fini(&qdev->ddev);
 	qxl_modeset_fini(qdev);
 unload:
 	qxl_device_fini(qdev);
@@ -154,6 +155,7 @@ qxl_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
+	drm_kms_helper_poll_fini(dev);
 	drm_dev_unregister(dev);
 	drm_atomic_helper_shutdown(dev);
 	if (pci_is_vga(pdev) && pdev->revision < 5)
-- 
2.50.1
