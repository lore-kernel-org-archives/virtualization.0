Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C21D31A8
	for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 12:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169525; cv=none; b=dFIq/npHMMA/XtPab3R5N5mTWz+5Z+OJy+9xvNCAzJNY7x+mi82aIAjXvkdIHhD/OnUAa+Fp1oP1GKGrhpriiy1tU6HlMWetLhUaIX/3HfeDjgsMQSarRKDQXRFm331KV3XkDUHxzpvSy8Rh3vtlP5DX3HwxBGLQb1iu2aGQ2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169525; c=relaxed/simple;
	bh=e8SdBWX5LcZecSoqEGGdswWYrfPe2dBO7nVZ2+eJaL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MS4qT3Lcb2j0kWTwNIQ8K2D3ahlYlEL+tbINVA5e2yG/nvxYsuyuITXYJcQ6WXJs+RukDN1o6jVydjtvneg8+Vp2ayxLUlBDG7xRXS0vh2Vc1Lg1tARt2ZpEzCEMwbfC0jJJWnioOmMXFmsoS76cTWBHnnHgGFDZAwsrjPllyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7Sddvu/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7Sddvu/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729169522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=um5kPuJ64llVoLwmFFHr1GyuNJY8DQ3vVEayxTgqCeU=;
	b=g7Sddvu/c1rWe2CWWxcCi9qgi8EkHBLAbOOaW0AiVnM4hHw1/DQiWdkC4VBDhoC0cwrk6d
	MpiPrPbxouYVUbdORzL+57SeBF/+5/vHyQcydNax/MJKTDrMC7LZnHutf8Kw1B1/8bp8bW
	cRGL+7TgqN16AKM7DV5NOFZvZfA1Tew=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-C7HycUqEMH6PZuJN3s6C0A-1; Thu, 17 Oct 2024 08:52:01 -0400
X-MC-Unique: C7HycUqEMH6PZuJN3s6C0A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43127097727so6788625e9.0
        for <virtualization@lists.linux.dev>; Thu, 17 Oct 2024 05:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729169520; x=1729774320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=um5kPuJ64llVoLwmFFHr1GyuNJY8DQ3vVEayxTgqCeU=;
        b=cjJV+554LShrCjoQGph7aoifc8FQ07l6GbZwxaFJYcp4RUhlIJSy36K2N2GLA26HMr
         xLr1O2Jn3bnJ+v+Z/csO+xAMA1NaJSz6CGwdLvQWk44JBR+fFzuboZ+sHj0qlqIpudcF
         D4DRCJ/c3QFu3jXuU/Hx56/S5j0vxP4uKQYsFLz7sqbqZj5dG77u4c8EV8jzKKsUSaEI
         rURtQsh4prcCQBbmnQarM3DjgQkDf9AiX0DGAVJkyUmjWmiE+i5J4G2csAyUFvqRv2uY
         bItGEE44l4QxjUMdgikC7wbyMQ3Edq7zEINpydfThHz856AOlWquA5Muj3sz00ChLwJs
         Iw2w==
X-Gm-Message-State: AOJu0Yx2EIK/xQQppgh5eXiw6wUBUl7ZONKsaix399LMRtMx3JQdjREF
	bAu5+bg6OzhYGLSBtTb8oUINX5b3OCkRfBgbWpdOenwAhm7aDS6vRjF0IjWkpHZqdTzuKa32a2i
	QdOk1IfvhRjPySIIgaRjXgwzZTz/L3zRfHKIOvTDFKfnClpFuRhfJR5HhtJR8e7Nw
X-Received: by 2002:a05:600c:510f:b0:431:5bf2:2d4 with SMTP id 5b1f17b1804b1-4315bf20381mr16130605e9.29.1729169520174;
        Thu, 17 Oct 2024 05:52:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGYFzQ02xHqa9DwuB2IQl1STrx/TjGYcJn3bnqxHl7RZjfzQiYdIGcS5/o7InyDdXexXUkSg==
X-Received: by 2002:a05:600c:510f:b0:431:5bf2:2d4 with SMTP id 5b1f17b1804b1-4315bf20381mr16130475e9.29.1729169519778;
        Thu, 17 Oct 2024 05:51:59 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf8228sm7178054f8f.81.2024.10.17.05.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 05:51:59 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] drm/bochs: Replace deprecated PCI implicit devres
Date: Thu, 17 Oct 2024 14:51:46 +0200
Message-ID: <20241017125145.34729-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

bochs uses pcim_enable_device(), which causes pci_request_region() to
implicitly set up devres callbacks which will release the region on
driver detach. Despite this, the driver calls pci_release_regions()
manually on driver teardown.

Implicit devres has been deprecated in PCI in commit 81fcf28e74a3 ("PCI:
Document hybrid devres hazards").

Replace the calls to pci_request_region() with ones to always-managed
pcim_request_region(). Remove the unnecessary call to
pci_release_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/tiny/bochs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 31fc5d839e10..888f12a67470 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -217,7 +217,7 @@ static int bochs_hw_init(struct drm_device *dev)
 
 	if (pdev->resource[2].flags & IORESOURCE_MEM) {
 		/* mmio bar with vga and bochs registers present */
-		if (pci_request_region(pdev, 2, "bochs-drm") != 0) {
+		if (pcim_request_region(pdev, 2, "bochs-drm") != 0) {
 			DRM_ERROR("Cannot request mmio region\n");
 			return -EBUSY;
 		}
@@ -258,7 +258,7 @@ static int bochs_hw_init(struct drm_device *dev)
 		size = min(size, mem);
 	}
 
-	if (pci_request_region(pdev, 0, "bochs-drm") != 0)
+	if (pcim_request_region(pdev, 0, "bochs-drm") != 0)
 		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
 
 	bochs->fb_map = ioremap(addr, size);
@@ -302,7 +302,7 @@ static void bochs_hw_fini(struct drm_device *dev)
 		release_region(VBE_DISPI_IOPORT_INDEX, 2);
 	if (bochs->fb_map)
 		iounmap(bochs->fb_map);
-	pci_release_regions(to_pci_dev(dev->dev));
+
 	drm_edid_free(bochs->drm_edid);
 }
 
-- 
2.47.0

