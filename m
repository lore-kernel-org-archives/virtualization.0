Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9544E36E6
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846936; cv=none; b=Lwc4tpMIAVtW4u04mF7OrvwOQDqu+qMZthNCvautNk5iQo7KvCH+pLeMW/4/FOPjD5HQdrpIO32ZsJFzAS9FzGmv1TAmZqzscWvAf4XJ+5YYzpStBoK9vxDpMXz2anQU3v/IyV9Psu5DD3xmrwOLILg3ugz1Fsqm+uZdoiXSujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846936; c=relaxed/simple;
	bh=cbiryS0f65xjA12Z2hGB3kIPpkklyBe3TYdzcK7KMyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+EU8dC/JMPyUmJ/3nOF0z36PaxDuuMdRcmxKKDRfFr6JrmbpZFtj7vWc86Vh+4oQqLQbhOswjdXe24/X3FrKAzLT51Tbj/Dcgk3+s1er/RFpvdy0CVqyWe51VuT1wbLd0oTewxV7g5bIMyrF93UJHSiNt/F3YuSCG3cskEwQIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=HU3jFeIi; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="HU3jFeIi"
Received: from LAPTOP-R01LEAQM.localdomain (unknown [186.210.30.235])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 2DA56121044;
	Thu,  1 Oct 2026 06:28:37 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1790846919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3OgB654oRo0gCP4kTojqjma900bs/fn+J1noC4FWW5Y=;
	b=HU3jFeIielxd+Fd8wwyuv6IEYiFrzIonkg25EA0TyUcq3tYAlQRA2YTw2p7KFs5WY5G4tg
	IwCj+SK7fJBlHFLpPgW4vTwPPA/+QzSc/FbJyO3oEYMgJvAMy2E3TgXZz0ps/IhtcJcun8
	vUgCy9i3Xbs1tkK7B5UyI5lMxjGwiV7ywICO0f6+OT6lTO1ogIQUWeZMUrKBtMmK/qWju6
	uxc1A/eU047QAM3VOH+a4IPjO1vVCFqDpenfp/LoePp04VX7e8vQU9xYX3K8AKeZXXLAaX
	jTEKvkl2FHNP1HKeBZm/puHINlBItpV1hZS/pcV44a8EK+pR62rSnP5q/O/Xwg==
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
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
	Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Subject: [PATCH v2] drm/qxl: return -ENODEV for unsupported revisions
Date: Thu,  1 Oct 2026 06:25:06 -0300
Message-ID: <20261001092506.76201-1-matheus.aalmeida@inf.ufrgs.br>
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
Switch the DRM_ERROR() call to a dev_err() call.

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Signed-off-by: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
---
v2: Use dev_err() instead of dev_info()

 drivers/gpu/drm/qxl/qxl_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 97df9d3d6..85743f235 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -82,9 +82,9 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	int ret;
 
 	if (pdev->revision < 4) {
-		DRM_ERROR("qxl too old, doesn't support client_monitors_config,"
-			  " use xf86-video-qxl in user mode");
-		return -EINVAL; /* TODO: ENODEV ? */
+		dev_err(&pdev->dev,
+			"qxl too old, doesn't support client_monitors_config, use xf86-video-qxl in user mode\n");
+		return -ENODEV;
 	}
 
 	qdev = devm_drm_dev_alloc(&pdev->dev, &qxl_driver,
-- 
2.43.0

