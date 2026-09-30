Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3F73E450D
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 22:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806958; cv=none; b=XXxluwLm3ejXl27+B+spN3s06f52rsinD3EtE1YsWxeg0fTuO3nVIHQZN0v6Vtn9YYX03DR0lRNQVQVqFsqZn2fHzOl07IUKHnJBFWrYiYYr+3xSa4b+Pa+Fok9uorEDqobCkVU9xSt3icL1jR/BOSXGwqFal9lgu6pd3owIYe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806958; c=relaxed/simple;
	bh=gt3LthqFRkLxODcm7OXpQL/qyastGnf4iqmrHxkq0xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dTI0X15V5VYlr+mH52OnEGiDQ5K8wwfLXqoHomk9QfFNSPLJIm1FQ4D0iTgbrUloxBB69yrkCLkNItHcRk11QKQ5aNJmLB3C0OApSDjgShD/e8W+aEOfUyIFEEtWixUM4+r67IDOOAKQ1V0t5ii0UuLKyDqwd5XiDr0l0UR9n3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=jWaEDSZS; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="jWaEDSZS"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [191.54.63.196])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 4E3E21210C8;
	Wed, 30 Sep 2026 19:22:21 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1790806945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fN3vRZcAy1b1oMCBjzogxuAqwRES3eo98nkRCXEYVzg=;
	b=jWaEDSZSGcckRgKrcGvEInffVHzm/aUNwBEFOiPag/vuwph4P7fQX5hpwpVDGePJFfCHG2
	8C/DJXaX5LtFJe+CheZrVlYLSNI14xZmjJ9NHTLNusF6PuOdCZIqCXTioSV3sb5x+JD5vv
	QKem4ZmpCYSWHVBa5tXaDeSMooMUil52/YFZlxdSsQqcT/E3yle5ZiW36XkAFf7rSJ2jF4
	KAITo8PuMQq0H/vNQVcmBSkwEqUdg+DWJeOX2KsUojsiSJQBPJPNtGuLqhqHAI+J8odtUt
	s23+HAT72V6axl4hbqYGRfjZk75Wzbgp4o/55BeGZ+EWoU3gvlBED+BAjuXHuw==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alon Levy <alevy@redhat.com>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH] drm/qxl: return -ENODEV for unsupported revisions
Date: Wed, 30 Sep 2026 19:22:13 -0300
Message-ID: <20260930222214.69443-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qxl driver currently returns -EINVAL when the emulated qxl revision
is too old. This is not a driver initialization failure but rather a
match rejection, which should return -ENODEV.

Change the value returned when the qxl revision is below 4 to -ENODEV.
Switch the xf86-video-qxl suggestion log to be info level, as this is
not an error.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 97df9d3d6..35b83b1bb 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -82,9 +82,9 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int ret;
 
 	if (pdev->revision < 4) {
-		DRM_ERROR("qxl too old, doesn't support client_monitors_config,"
-			  " use xf86-video-qxl in user mode");
-		return -EINVAL; /* TODO: ENODEV ? */
+		dev_info(&pdev->dev,
+			 "qxl too old, doesn't support client_monitors_config, use xf86-video-qxl in user mode\n");
+		return -ENODEV;
 	}
 
 	qdev = devm_drm_dev_alloc(&pdev->dev, &qxl_driver,
-- 
2.43.0

