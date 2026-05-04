Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F8379980
	for <virtualization@lists.linux.dev>; Mon,  4 May 2026 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907149; cv=none; b=Le6gQJhcOUdX2dhttqaoWy8hj2ecCuxc0Ph2c9hvXSR4kE81nNOM8wXfTkjV5dOPrz+MF21qrQ5w/LH2GwV51sCHyZsBm1HJFMvbAcuIfYf9+jZl6Vz4V0hd6+qsk3tfa+M+jE65LlTMD4WUJI5c7JkT0kigvHRKcA/SotXuBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907149; c=relaxed/simple;
	bh=NE1L6eMzG6COj1SB7uAmt2t6ZR5qluBMscfu2fv82Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sAMi/0J8Mv9e+KDUfA1eQtrfpLruNt/3NiIByz3Gc3oQvqHjDUJ5L86fQ1j74E/6mkTBwevJrazc5mDz1gK5mz4Qst5ldKJxpAvavLwUYayAdjNWR+GUpk8pHJwS12uVIIIkJk8nptPfo6bcU63b1VxNQZ2PZUsNdNGDWzAMLWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=JOSzUTw4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="JOSzUTw4"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-44da2de25f3so795061f8f.1
        for <virtualization@lists.linux.dev>; Mon, 04 May 2026 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777907144; x=1778511944; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGzvK4HsHm02j9O1TwzKamsko2ii3BucSi9rVkl9Lnw=;
        b=JOSzUTw4v7BPuPnbTfO/fa52GZ0MT3Lcf6Mi5RXjxO7pRVPQk4o/wWKP/iPb7UN7kj
         3DfnXHvzkKUPG+5tn6ND9XbltkIX3l6aoVLA+bjs8y1fyzGvoB225JoqXUiMw2wb5s9s
         It9Gz0XhJi6L2x5dIvua9yYUG+KYfWONM4xfpFPiuB9j4K5g+eaHACLdU2w0z5N8e1kp
         vljNvByC5Ev8GJqgEuWXQ8ruVnsNT86u9fhYTzh+C0z5uxBm3QIRESufoOZlvqMa03nO
         S3o03LpN3q8zOU1s/TvJlPZeIQYPxAY7rHTXsQSObGr3fpuujSlEiZ9wi/fJuTJpiqYQ
         VTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777907144; x=1778511944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGzvK4HsHm02j9O1TwzKamsko2ii3BucSi9rVkl9Lnw=;
        b=jiFV+UfSOHjAtx0G5Ue34wF/azbhTkiFhPLQkVagUhqrSVemLRjkmL16X8mA3NcFmc
         rwW52fHPPVVVorfWsEd/T9iYK8Jk284fFFNArszM5XS47u9RV2cbvxDRV9dssJk4mjkh
         24iDDTn2BScxgOozTmlCtdYNJRwq/yqavCK2s0lfjVQDNn+I//uA+22NUDPVDYSEUIfH
         KZoHpfoGsQ95KFs9stdLkmUb3WQXmz2DOBDAl8c9UKYd2qCZb2IPSilSftVUvnZRy3NP
         m2QKABa6P6odFvIsbAchlOBjHDtKgB7/PBffxY/Of5Z5kT6Yo2REMs5uxBjXS3Zu/pYG
         6kpg==
X-Forwarded-Encrypted: i=1; AFNElJ9xRZsDy/wERO32kABLw/9iohQtoYofj8F+eZ7jAv+CHqvenTfrJP+EnskdSmHAdyxS0ZgZSAjEFhLgSZ0usg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyofZhCl3zHrJ20rKPvnC+T/HBMnUbZIXzVF0e5lznpxpTkGGOl
	kJlE8DSEBt3n0jO7/XYfKZ1CmG5anMAjBGmGwsVyWUvdOzuI7cVFb4q9EL+ApaCDEck=
X-Gm-Gg: AeBDieuoE00CPZnPyb4iU/60/FvEVMYHqCzhT7rEk7ma4JM9ayQ6M/GqtxKdg+nqFSF
	RerODObpmZYnKLmC53xhc8thtrZywpf7ukFOmqfHXYcErFEfk8hpITswq7wwCOf6E6sBjfPtb3l
	YdVesqOAgtKtdWxdn0obmF57EhvhAr69KwC7QD0SAgmQZLh4ZRecRhyXGPwdt/4f+PnDr9Hbnd7
	LLhzSAdv7cEpsq3+CKDuWiy6F5zDDPhR9L94eb/PK+5XPWi9vB7+TjCTtBL7ve+HZhucnZStOF/
	Q6fmE2bUc9tr+QUS3Qte0FMTqkpZY4ckv1BYotoFh7xFBvNRcTJTPSh4D57MKacexafakj6u9QP
	CBGS1aUUNy4g4Uk1SXErqV6xCiCohSzxRJPm32oq+B4RTXdcXbNW6fWRhPIg3h4ZLMRPQf6roUi
	8XNKPHC7FAZ+vDpUm2LhOgFTPDBA0N/bBhWx2uNpOGJsve9Bye8wVEks3vAbly35At4FJfU/IA5
	hfW2Kwn6qIF/fSpXLGIQ2oquA==
X-Received: by 2002:a05:600c:3487:b0:486:fb0b:ad79 with SMTP id 5b1f17b1804b1-48a988a6ec9mr178609795e9.20.1777907144531;
        Mon, 04 May 2026 08:05:44 -0700 (PDT)
Received: from localhost (p200300f65f114e08197264a4bf9e813f.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:1972:64a4:bf9e:813f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48d046faba7sm38072595e9.30.2026.05.04.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:05:43 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Qianhai Wu <wuqianhai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Dave Airlie <airlied@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org
Subject: [PATCH] drm: Consistently define pci_device_ids using named initializers
Date: Mon,  4 May 2026 17:05:37 +0200
Message-ID: <20260504150537.2136760-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9388; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=NE1L6eMzG6COj1SB7uAmt2t6ZR5qluBMscfu2fv82Pc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp+LXC7vbJIuE2keRFm6HVDh2ebJ24M6YY8wzqT r96mRsBPBmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafi1wgAKCRCPgPtYfRL+ Tl7GCACfNS/fqsNkHf6BM4BCBvB6p0B1vHt/ScUAqlpcSAqMYX8TzNHbiI+W88f+p/Vt3AVExJt LNxEJmfvDpAh3sTsue2/b4O/lc3hyU8y+Kw1VAYD7tkNcVUR/C6jcIB7QkOhwjNNsvj9RWpYghx 7fftJjmp6E7aLxhP9v5e+WDD6F8v+p7+RIApXuSQgNr4iCCY1jBVmbnQBFr2kNJQnoZtDNLy5dF 6yMkhqMJVJXebTe1j6thkum5+dfkHMjlcSrr6UeVNxJJdPJ8Kh10GudKxGbahDvUppWvhSBBa8R gWRoqIfS/iKEazlGfaUvk5/jVNOHfq3wJ/CEdLIpQLEr6H8j
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .driver_data member of the various struct pci_device_id arrays were
initialized by list expressions. This isn't easily readable if you're
not into PCI. Using the PCI_DEVICE macro and named initializers is more
explicit and thus easier to parse. Also skip explicit assignments of 0
(which the compiler then takes care of).

This change doesn't introduce changes to the compiled pci_device_id
arrays. Tested on x86 and arm64.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

The secret plan is to make struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
and that requires named initializers. But IMHO it's also a nice cleanup
on its own.

The anonymous union will allow changes like the following:

-	{ PCI_DEVICE(0x8086, 0x8108), .driver_data = (long) &psb_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x8108), .driver_data_ptr = &psb_chip_ops },

(together with the respective change in the code when the value is
used). This gets rid of a bunch of casts and thus slightly improves
type safety.

Best regards
Uwe

 drivers/gpu/drm/gma500/psb_drv.c      | 56 +++++++++++++--------------
 drivers/gpu/drm/loongson/lsdc_drv.c   |  4 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c | 24 ++++++------
 drivers/gpu/drm/qxl/qxl_drv.c         | 15 ++++---
 4 files changed, 52 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 005ab7f5355f..039da26ef24d 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -56,36 +56,36 @@ static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
  */
 static const struct pci_device_id pciidlist[] = {
 	/* Poulsbo */
-	{ 0x8086, 0x8108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &psb_chip_ops },
-	{ 0x8086, 0x8109, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &psb_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x8108), .driver_data = (long) &psb_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x8109), .driver_data = (long) &psb_chip_ops },
 	/* Oak Trail */
-	{ 0x8086, 0x4100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4101, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4102, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4103, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4104, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4105, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4106, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4107, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
-	{ 0x8086, 0x4108, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4100), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4101), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4102), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4103), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4104), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4105), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4106), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4107), .driver_data = (long) &oaktrail_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x4108), .driver_data = (long) &oaktrail_chip_ops },
 	/* Cedar Trail */
-	{ 0x8086, 0x0be0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be3, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be6, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be7, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be8, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0be9, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0bea, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0beb, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0bec, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0bed, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0bee, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0x8086, 0x0bef, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (long) &cdv_chip_ops },
-	{ 0, }
+	{ PCI_DEVICE(0x8086, 0x0be0), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be1), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be2), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be3), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be4), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be5), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be6), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be7), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be8), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0be9), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0bea), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0beb), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0bec), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0bed), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0bee), .driver_data = (long) &cdv_chip_ops },
+	{ PCI_DEVICE(0x8086, 0x0bef), .driver_data = (long) &cdv_chip_ops },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index 1ece1ea42f78..f9f7271ddbff 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -444,8 +444,8 @@ static const struct dev_pm_ops lsdc_pm_ops = {
 };
 
 static const struct pci_device_id lsdc_pciid_list[] = {
-	{PCI_VDEVICE(LOONGSON, 0x7a06), CHIP_LS7A1000},
-	{PCI_VDEVICE(LOONGSON, 0x7a36), CHIP_LS7A2000},
+	{ PCI_VDEVICE(LOONGSON, 0x7a06), .driver_data = CHIP_LS7A1000 },
+	{ PCI_VDEVICE(LOONGSON, 0x7a36), .driver_data = CHIP_LS7A2000 },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index a32be27c39e8..8ad4ddb60ee6 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -205,18 +205,18 @@ int mgag200_device_init(struct mga_device *mdev,
  */
 
 static const struct pci_device_id mgag200_pciidlist[] = {
-	{ PCI_VENDOR_ID_MATROX, 0x520, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_PCI },
-	{ PCI_VENDOR_ID_MATROX, 0x521, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_AGP },
-	{ PCI_VENDOR_ID_MATROX, 0x522, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_SE_A },
-	{ PCI_VENDOR_ID_MATROX, 0x524, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_SE_B },
-	{ PCI_VENDOR_ID_MATROX, 0x530, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EV },
-	{ PCI_VENDOR_ID_MATROX, 0x532, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_WB },
-	{ PCI_VENDOR_ID_MATROX, 0x533, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EH },
-	{ PCI_VENDOR_ID_MATROX, 0x534, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_ER },
-	{ PCI_VENDOR_ID_MATROX, 0x536, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EW3 },
-	{ PCI_VENDOR_ID_MATROX, 0x538, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EH3 },
-	{ PCI_VENDOR_ID_MATROX, 0x53a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, G200_EH5 },
-	{0,}
+	{ PCI_VDEVICE(MATROX, 0x0520), .driver_data = G200_PCI },
+	{ PCI_VDEVICE(MATROX, 0x0521), .driver_data = G200_AGP },
+	{ PCI_VDEVICE(MATROX, 0x0522), .driver_data = G200_SE_A },
+	{ PCI_VDEVICE(MATROX, 0x0524), .driver_data = G200_SE_B },
+	{ PCI_VDEVICE(MATROX, 0x0530), .driver_data = G200_EV },
+	{ PCI_VDEVICE(MATROX, 0x0532), .driver_data = G200_WB },
+	{ PCI_VDEVICE(MATROX, 0x0533), .driver_data = G200_EH },
+	{ PCI_VDEVICE(MATROX, 0x0534), .driver_data = G200_ER },
+	{ PCI_VDEVICE(MATROX, 0x0536), .driver_data = G200_EW3 },
+	{ PCI_VDEVICE(MATROX, 0x0538), .driver_data = G200_EH3 },
+	{ PCI_VDEVICE(MATROX, 0x053a), .driver_data = G200_EH5 },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci, mgag200_pciidlist);
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 2bbb1168a3ff..6c3c309b8e4d 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -50,11 +50,16 @@
 #include "qxl_object.h"
 
 static const struct pci_device_id pciidlist[] = {
-	{ 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8,
-	  0xffff00, 0 },
-	{ 0x1b36, 0x100, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_OTHER << 8,
-	  0xffff00, 0 },
-	{ 0, 0, 0 },
+	{
+		PCI_DEVICE(0x1b36, 0x0100),
+		.class = PCI_CLASS_DISPLAY_VGA << 8,
+		.class_mask = 0xffff00
+	}, {
+		PCI_DEVICE(0x1b36, 0x0100),
+		.class = PCI_CLASS_DISPLAY_OTHER << 8,
+		.class_mask = 0xffff00
+	},
+	{ },
 };
 MODULE_DEVICE_TABLE(pci, pciidlist);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

