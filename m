Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6BE30F95E
	for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767045578; cv=none; b=EqEKdU/d+0Q43Oc4bfmGvtNScCvS4IW5nOkdPjJ4N/TvZBOWwZJMXu1WcONa0Wwvwl/l18WunbLMfAMfDyFc+yveGS4cvaIyCDtI06kwlA/6Ym9kcg1OnAprjQGqYzdIxeyFnYQMQfYd3JMzqWSnViI0fXx2Zz5ghMNT3pVMe5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767045578; c=relaxed/simple;
	bh=abKkcSFLS+5JdHy2nWvYoeZMh7bXqKH5PJjyGl/Xk3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8jxiuIrotjaPuezJ9zdlvJQXfA9VizI7plV9+0c+wNFSnoo5w10oqByR+YIfCQ7wXk0ISRnqzL3HadxU73VvJ+lPrDoXmu4ULTq3Fh5+9Jp0biXfD2Ymbq3jSP/jI5GmH5FBJVd5eBQxI+tf8uwYxfrTUj+Iinje4ANNQBWFPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NOAREEpJ; arc=none smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NOAREEpJ"
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-55b09d690dcso3328474e0c.1
        for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 13:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767045576; x=1767650376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huMey1yvlTcl9trBYSLi6aENqnLSe9ecqic2n3VA9bs=;
        b=dj1sD+JddA+i8LQNgRDW4ju6M6ggDbYAJMTvG8lUFXysU0mKzjLzTZgJ8fZVgfrLpC
         OgMylF8Ah6nqfRFOujO8CvuZ3MTQ9ie9CKb6t+UNaChxybKXl/RqEeJVehNgTJ2J5BKw
         oFDeb1HmtvOR2ISoCHdhS+TeYWIl/pxXxNS2GDoO3TGefbItSPkcMT4Ey9MuJzRN9LY9
         6cpkst1fsQ8iekJR+3dyaznSi30AKHXdwyhSUC9u/L7BXoL069hIJxTG1iK8/WQye/KZ
         22IZSbK1SNcSjUNKUftj6bkfvMfXw6Kra8eGKGWCPFzsE7U3AH4mZb6HTaInPQ9u7PwK
         jLRg==
X-Forwarded-Encrypted: i=1; AJvYcCXyi2kgBu5+FlYhG2IITRVD7U7W4W8jBN14+D01nwfXcIIkfvsB+49RyP19Yq4v3uG9DrLcu/Z//H2WMCQESw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2jKsFUzrFjJ+5gGxjxmQTfzVynnzffuWSXj+OXmWwa9RJYqkn
	1UN7c/0IFIJ6oaqClhMX/DrGpqLqkgUssJGwPwhCEK6MIR29oV5ARC6M6ezPInbIb7EuoMAvagf
	CkaY7+ZM0fz8QNZ0PxCW1NkHi9YQU3eucXxZPS72d3UElsL3rIMpBBpVH0PeHXgsYpnFCixd47c
	yNPyCSxDGLXDu2f8eHjDtVxFMscsfjC4xD2z+78Fs63CI/M7uOf+6+1TARUejhZqYLT09soe/UU
	e4ndUDfq/vDm5lmE3s=
X-Gm-Gg: AY/fxX5jGi+BCS5Ub9sC/wh8Qaaq3u/pRI9x+he0JRkquXxikQCUNkiZ2mS0mXJ5j1/
	j3jwj/KcIYD6O7nOWOnjpILFJ1oeqEwgMBna9+6LWgsNpUCXmdEWpvnuPOco6+HjyQJbgh3QFvC
	Z7fR60lDEgL4QaLBdt57vuECiTNgma60DU+F/kXzzViDfvWKuM5AX69eGTz2PztDINYQUDR99Ky
	vYdv315AUrEJcKetbz3PZmTIKGTy2SJ9p2o1b5NTF5RY4qcwSw2zULYw3Th5lTlMZYk0ek2fmJP
	UsqFL+yN1EQjkZ479dr6qQgUqWwJw0aB2A8j8YRbatiu38T7uSDcyTadSRL2bIuqBdbLrub3dYq
	Zy0FT5X/m4BYhSd6s27T1/twl/xI6/z2QXAtYF0Fdy6bkYg4nEuXsRAoDH0jHI7CLLfRT8gle78
	pJy3G6YHYXjS5suK1f4wZKLmqGsqf904vBc1LjNG8=
X-Google-Smtp-Source: AGHT+IEWjoPCJCwHOksKPl0ZeG9ObVWhLSMpTMQmSaf5Id5aPuXqU2CJUpDCOfOvhU5oExrs6Y5ck1NpeTIA
X-Received: by 2002:a05:6122:468a:b0:55b:f45:1874 with SMTP id 71dfb90a1353d-5615be63410mr10837503e0c.11.1767045575711;
        Mon, 29 Dec 2025 13:59:35 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-2.dlp.protect.broadcom.com. [144.49.247.2])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5615d05ce9fsm4700457e0c.2.2025.12.29.13.59.32
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Dec 2025 13:59:35 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee09693109so188337931cf.3
        for <virtualization@lists.linux.dev>; Mon, 29 Dec 2025 13:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767045572; x=1767650372; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huMey1yvlTcl9trBYSLi6aENqnLSe9ecqic2n3VA9bs=;
        b=NOAREEpJfdyveZKFpdG2QKKwI80X8USHJz01TVvDSzO3K1H0yBBvCBeGZQey3fI3E9
         ahO3wkZZ0cag0KSJU5cyqay3kAOvY37ZFjj73+AZn2LNAdHGB84CYYiDbuBV04Vk5T7c
         wf32/wrwSHiG4q1WWKZadIFxTTLXOUuW29Wvc=
X-Forwarded-Encrypted: i=1; AJvYcCUUAIy6Ndkwngq0ohoAMfRDOEwJ5Yo0QtzaHD8Cm4/Wp3oDQ8/KKcvF/R6elEVX1owYQ0vN/Cl90Ymd8tIzjA==@lists.linux.dev
X-Received: by 2002:a05:622a:120e:b0:4ed:1bba:f935 with SMTP id d75a77b69052e-4f4abdb2f22mr498101331cf.57.1767045572375;
        Mon, 29 Dec 2025 13:59:32 -0800 (PST)
X-Received: by 2002:a05:622a:120e:b0:4ed:1bba:f935 with SMTP id d75a77b69052e-4f4abdb2f22mr498101101cf.57.1767045571961;
        Mon, 29 Dec 2025 13:59:31 -0800 (PST)
Received: from localhost.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9759f164sm231530026d6.24.2025.12.29.13.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 13:59:29 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] drm/qxl: Use devm aperture helpers for sysfb restore on probe failure
Date: Mon, 29 Dec 2025 16:58:13 -0500
Message-ID: <20251229215906.3688205-8-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251229215906.3688205-1-zack.rusin@broadcom.com>
References: <20251229215906.3688205-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Use devm_aperture_remove_conflicting_pci_devices() instead of the
non-devm variant to automatically restore the system framebuffer
(efifb/simpledrm) if the driver's probe fails after removing the
firmware framebuffer.

Call devm_aperture_remove_conflicting_pci_devices_done() after
successful probe to cancel the automatic restore, as the driver
is now responsible for display output.

This ensures users don't lose display output if the qxl driver
fails to probe after removing the firmware framebuffer.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: virtualization@lists.linux.dev
Cc: spice-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/qxl/qxl_drv.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 2bbb1168a3ff..ca4c817fd611 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -93,7 +93,12 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
-	ret = aperture_remove_conflicting_pci_devices(pdev, qxl_driver.name);
+	/*
+	 * Use devm variant to automatically restore sysfb if probe fails.
+	 * This ensures the user doesn't lose display if our probe fails
+	 * after removing the firmware framebuffer (efifb/simpledrm).
+	 */
+	ret = devm_aperture_remove_conflicting_pci_devices(pdev, qxl_driver.name);
 	if (ret)
 		goto disable_pci;
 
@@ -121,6 +126,13 @@ qxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto modeset_cleanup;
 
 	drm_client_setup(&qdev->ddev, NULL);
+
+	/*
+	 * Probe succeeded - cancel the automatic sysfb restore action.
+	 * We're now responsible for display output.
+	 */
+	devm_aperture_remove_conflicting_pci_devices_done(pdev);
+
 	return 0;
 
 modeset_cleanup:
-- 
2.48.1

