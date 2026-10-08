Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A336B938
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474647; cv=none; b=PbrTKyG8yNzZ6ZvBEnOwTCqwhpwQHQR/BBtTsdh5XO2tKVM1CVjUbTlGo0vxEPAA8TKpfQES/V8ZbcT/AQMBicjYC/W2g6PYEuhM3zSPC2RS+fOpq3uTbljz/YIibjM4nB+AQgCUBWXJ0bil927dvd9ecxPeK7F1R7moMp5Qw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474647; c=relaxed/simple;
	bh=+cqdQ9gmgKOhr55i/OTv9gp5iM1UodxiR77kiuHe4g4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hJTSk/dRTT6DK1yYd4du9x6HOlAKRmRUG7Vxitdw4M2X1NuY5lHP48Zi5XzMSN8as+ZkcUnxY5praxlMEykyzT6zbwAm8bebYOVUchwRE/sqPmVRN5vb3LBERcfhLgo1NbXNnuxzSKuIfd896wVVlq7h40vjejgixliATdJ6TAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTvB+WSl; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTvB+WSl"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-782e0fc1e55so1467984137.3
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791474645; x=1792079445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z605x3oSurFK9+1Jj7NngNX+hXuD5vIj60PGN3GhQpM=;
        b=CTvB+WSliXGM92D2szL1S1E7S+XRVXybj1V3hTqHb/951K+6G/wZzoUZEP1eCi6/EK
         AoicT4/kOgT3XvTZZILQsoq892rdijKjvEP/XCyVYGDrGteLTMLi9C+3mkuNsVMo1lrj
         ICTA8a/DCN5wEjrdDz6dWVJXL8U/J6NBlFNVWu/E42o8p4RpwG10tBNFEsV83MwLUmQ2
         x6V7IgPbrE8NwiUdQ9XAHttV7C9n/VJkfB2Wxf5Eiytk17tjeC1fQ/FizFN+2Iz9JzYe
         4fp5fjS+DYnBxT5MXnOpFSV/T+eONmk2p3ui+DHoA7vp4aIcNpPjj2ozcvvK2en9wfLt
         KSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791474645; x=1792079445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z605x3oSurFK9+1Jj7NngNX+hXuD5vIj60PGN3GhQpM=;
        b=lXeLZ6waaID2GV7ADyGwKYUWxDWCZN95iHS0h/Jz3ImlCyMXzvL4BC69uaKxDtcOBG
         D3GNTg4gBu2CIqWWbU/G44U9fmXDDubUVUosoLvj1ZjcVN4TG3ZlZlLKGWLXibPGerv6
         pIwacLPkS74NRaDtRR3mC5I4l4FMb2ZfQ4Iu7RLNVDWW/U7Zl6VXDm9xZO09f52nApx+
         s22c0kgBPcqYJqNnL6/A40HkLIEWrtdRsIzGGprMIiVrXqJFbz3FtTSj0a5xQHudw4Rg
         gWWV8SbXtR/+HGA/dAn3USKcwLO19uVPSpK06/vyGhxXg3mjLean6te4SmCCIVrIvx8s
         lz1g==
X-Forwarded-Encrypted: i=1; AKwUvByZfMm+BW3O/xOBIIFnjZ4PBySzUIVPxOUjEJuuZAAjOP6juCegiRA3DlOFY3U6gNt7C+r4jqq0nYj/caSO1w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIUV6vPw66YgpmlT8+Qop5iJGmnS20d5Hk3SRwm4iCzmcMtJ+8e
	lt48Y30g2gqTgEwCasA9cllnNiHH0EmCAl/IyxqRfEHeDJuZGEN1ODgo
X-Gm-Gg: AYBFou0oJcMMUc1HVlAmPusZ/6JGTE88lFw6c96ESn0A7USFEx06QfSuDuGuUS76mkE
	Qy+vQwcHUSJvrfidV5OZTkTu7BxiXxYsrm8ph1/pS3hHR+FDfNnYhTH4lO4RT91S8Vx9G7Tjs/q
	fVW1wl3dG1DXvaAbAqL09I25rshI9dcMfHpvpIjm9BZev8BpiMVRhnn0XuLKd0Fcppc7gF0oy5X
	dMwA41FuSk6pScZ+k0UniDTmCJj/OyFboYlitvQJVfHl8Rr/z3ok8S25NkB3zUip5JJItapvBTq
	yvAmVP2ytKZVIrE2JdUsNp1i2+gekQt9uSVl7oc99UTLZHIw8kp6BEh6QcSZMElAn7mCFby5u8e
	GNTnzt+8qoSifbGPXxYpKoBIXGLe2Ai1o5HUUO7CRSyMtTN8QYGWXITNpzFycBB7k13COVbXq7Y
	45nOURUcky39kTWq1OK9/H/QejsFCU0ZJwYiHrv2r0YNrO4Zw=
X-Received: by 2002:a05:6102:4426:b0:7b2:508e:3d57 with SMTP id ada2fe7eead31-7ca36e40c71mr1688635137.4.1791474645346;
        Thu, 08 Oct 2026 08:50:45 -0700 (PDT)
Received: from fedora ([2804:14c:3b83:954b::e289])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98e39adb533sm4293125241.2.2026.10.08.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:50:43 -0700 (PDT)
From: Julio Faracco <jcfaracco@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] drm/qxl: Fix out-of-bounds read in client monitors head access
Date: Thu,  8 Oct 2026 12:50:34 -0300
Message-ID: <20261008155034.55688-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qxl_update_offset_props() dereferences
qdev->client_monitors_config->heads[output->index] for every connector.
The connector list holds qxl_num_crtc entries (default 4), but heads[] is
only allocated for client_monitors_config->count entries. When the client
reports fewer monitors than qxl_num_crtc (e.g. a guest started with
heads=1), output->index exceeds count and the read runs off the end:

    BUG: KASAN: slab-out-of-bounds in
         qxl_display_read_client_monitors_config+0x61e/0x6f0 [qxl]
    Read of size 4 ... located 16 bytes to the right of
    allocated 32-byte region

Factor the index-vs-count check already open-coded in
qxl_add_monitors_config_modes() and qxl_conn_detect() into a
qxl_output_get_client_head() helper that returns the head or NULL when the
config is absent or does not cover the output's index, and use it in all
four places, including qxl_conn_get_modes() which had the same unchecked
heads[output->index] access reachable from the mode probe path.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
v2:
- Also convert qxl_conn_get_modes(), same unchecked access
  (from Sashiko AI review).

 drivers/gpu/drm/qxl/qxl_display.c | 40 ++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..35440ee71b83 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -148,6 +148,21 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 	return status;
 }
 
+/*
+ * Return the client monitors config head for @output, or NULL when the
+ * client monitors config is absent or does not cover this output's index.
+ */
+static struct qxl_head *qxl_output_get_client_head(struct qxl_output *output)
+{
+	struct qxl_device *qdev = to_qxl(output->base.dev);
+	struct qxl_monitors_config *cfg = qdev->client_monitors_config;
+
+	if (!cfg || output->index >= cfg->count)
+		return NULL;
+
+	return &cfg->heads[output->index];
+}
+
 static void qxl_update_offset_props(struct qxl_device *qdev)
 {
 	struct drm_device *dev = &qdev->ddev;
@@ -158,7 +173,9 @@ static void qxl_update_offset_props(struct qxl_device *qdev)
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		output = drm_connector_to_qxl_output(connector);
 
-		head = &qdev->client_monitors_config->heads[output->index];
+		head = qxl_output_get_client_head(output);
+		if (!head)
+			continue;
 
 		drm_object_property_set_value(&connector->base,
 			dev->mode_config.suggested_x_property, head->x);
@@ -263,12 +280,11 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector)
 		return 0;
 	if (h >= qxl_num_crtc)
 		return 0;
-	if (!qdev->client_monitors_config)
-		return 0;
-	if (h >= qdev->client_monitors_config->count)
+
+	head = qxl_output_get_client_head(output);
+	if (!head)
 		return 0;
 
-	head = &qdev->client_monitors_config->heads[h];
 	DRM_DEBUG_KMS("head %d is %dx%d\n", h, head->width, head->height);
 
 	return qxl_add_mode(connector, head->width, head->height, true);
@@ -1054,11 +1070,11 @@ static int qxl_conn_get_modes(struct drm_connector *connector)
 	struct qxl_output *output = drm_connector_to_qxl_output(connector);
 	unsigned int pwidth = 1024;
 	unsigned int pheight = 768;
+	struct qxl_head *head;
 	int ret = 0;
 
-	if (qdev->client_monitors_config) {
-		struct qxl_head *head;
-		head = &qdev->client_monitors_config->heads[output->index];
+	head = qxl_output_get_client_head(output);
+	if (head) {
 		if (head->width)
 			pwidth = head->width;
 		if (head->height)
@@ -1111,15 +1127,17 @@ static enum drm_connector_status qxl_conn_detect(
 		drm_connector_to_qxl_output(connector);
 	struct drm_device *ddev = connector->dev;
 	struct qxl_device *qdev = to_qxl(ddev);
+	struct qxl_head *head;
 	bool connected = false;
 
 	/* The first monitor is always connected */
 	if (!qdev->client_monitors_config) {
 		if (output->index == 0)
 			connected = true;
-	} else
-		connected = qdev->client_monitors_config->count > output->index &&
-		     qxl_head_enabled(&qdev->client_monitors_config->heads[output->index]);
+	} else {
+		head = qxl_output_get_client_head(output);
+		connected = head && qxl_head_enabled(head);
+	}
 
 	DRM_DEBUG("#%d connected: %d\n", output->index, connected);
 
-- 
2.55.0

