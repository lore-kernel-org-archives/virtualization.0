Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE17449EA9
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463414; cv=none; b=PYnIVHF/pwfOKTHL2V9v+9UeNBvDDyKnEvQdd0BpEc4M0L7nLKB3XbauUMDjel+KEzJbajMT3GimCNnLD4CqkEMZNV0Oy7gjc5rHnjX2xjIWK/newNj7ELqBe0Ja4JbUzV0NAhXaaYzz3jsyWbanXBn9HWqkg9VDgNFUk/LiFx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463414; c=relaxed/simple;
	bh=g2NMp1OTkz+xp2hURg4AbW7nPX6JSMyZwFFA6vA+7Sw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Kx6Kj1EckyUURinTkEa7fh0/UGpf8f8ERH/AfTVMH85qXxR4CGQK77w1aJ5KC26yIqBd+Z+FW/WoCZxt/McCJ79SO40hbBnLNYptDAfzjLqKBGgkLjyRKx004jL1sC0Ck0yLnkH5J6l5DhtlcDc7W+UelNiV51VElpyWmPkzf6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOctwRTR; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOctwRTR"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-98929bb8eb0so910971241.0
        for <virtualization@lists.linux.dev>; Thu, 08 Oct 2026 05:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791463412; x=1792068212; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YZ/V9Z4SvvYEKRHXDwdb1N1cFPl5NmC2hXDXe08e+q0=;
        b=DOctwRTR8PQ+N5EJINb0VZbBMzy4/8MxVYbiKwnCPdDk5zpm3GkqPrHxg2/M7otVcD
         aOXcLqNBYG9oNECFlacoAp5m9agZUexM/8v6aOLB45zWxy+2mAq9waLcLpE2f3LCMVPQ
         uaUTDEvdF0JvlXzQbqA3toGdfQdtrBEPJcSFl4FZxt3Y1dpJFWAYMBBnmi/R6CKRSylo
         OWkCq28kFMfnvBARHC1Bzu18lp2vYVdHgQTrBFUks+oZTJeiTRLzU2TWtyJaf2v48owU
         fBre02mHRqSVoc1bM32Csz8GvQUO6ejh3zuBSy/ubN3gm93XvcBan5FaPPVJs9bMZyVx
         C5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791463412; x=1792068212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YZ/V9Z4SvvYEKRHXDwdb1N1cFPl5NmC2hXDXe08e+q0=;
        b=hZBASt3CrghRrll4xpfUyjdGl834XFBY8XHJbTWXpvSeBAU6XgFDYZFICjQe77ZA59
         t7Q/9weMxsh+NS7EY1c3Z45DWk5g9jE/zG9IY2cGUSTcnziKO4/zGCuTfcCXPvGR+Vtq
         owoYuQ6HL3iyUIHSE5HkBmuCYx/0QYElVfuC7F38vQxnCYlXnceXtBC82wVYWcyvRgkQ
         Sd2LyMkQ5lQfUN90ISGJ1NXBw4vXQP3lVN4GbnXtK63Lijsse35mOCis3poJ6+EvV5EC
         SBqo2Q+6reUV1VRQUMdBe1v3NHFjwTD/s6Amk66xkGWQkQpY5w9bODFggnXBJq6kXHVH
         CdYA==
X-Forwarded-Encrypted: i=1; AKwUvBzcsb8dTZA0l9bJZmBY8JY90OLJI1k5kJxa7bt9M8vL9xWiqN0DvqvuNjhO6mOcplG8XNpMNNIrmxL3U9Io6Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYK/NbyawodtVZj+Vc0EIKjXeEkKIbgwB6DBBdDV+sZBKSh/E4CZ
	nN+BiCU3nj35HVl+kFuMuNmXerk0pDurPM+oJEPaGQ2MrFtzSv9UFZat
X-Gm-Gg: AYBFou0pOK+kxanfaPOZQ4mBlaGsY/5VV5YGOzH6CSvPsZjETYFQ789O7SXIBr+/dkd
	P/zFI9Ap6uE8U40h/zkSCClO6BUmW7C1QVz5frrX8qRoFw4YKq3SWyvyBJc5Fq0mFNg0oFTq6jO
	ygeq2RtkEiNSrmqwHVV5bk9WsfZbfpGRO7RhEw7+YifVBkSmGEsOTvdK1Ag31e26b+0MJGvvihc
	rUbv/jmrxx1P9miz0BaQ68thqqXd2W7Feg4zaIwpqV9K5aqw964x7ksMB9bS68s8BNFmGjKgs+q
	fXMa5H0IJeRTcKotNPfDyXbHcUt4UOp0aExwxppC1xf9aWHYwpt3Jdd2TSBMCW0gPKXb13va/0D
	eexvvk1sD7e7q9bYSt0RiA2wdWq8RHRxSxq4IgZQ2rVqBQMcIdiX1gXK3gp/bu4ifGlu03PFXnl
	11d829M14YmH9OayoWFFwd4DaEN8Sd/md5pUgTktAlXHUG72aw
X-Received: by 2002:a05:6102:370c:b0:7c3:66db:a66c with SMTP id ada2fe7eead31-7ca38b522ebmr1122494137.20.1791463411637;
        Thu, 08 Oct 2026 05:43:31 -0700 (PDT)
Received: from fedora ([2804:14c:3b83:954b::e289])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98e39c39cd4sm3821051241.7.2026.10.08.05.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 05:43:27 -0700 (PDT)
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
Subject: [PATCH] drm/qxl: Fix out-of-bounds read in qxl_update_offset_props()
Date: Thu,  8 Oct 2026 09:43:17 -0300
Message-ID: <20261008124317.32199-1-jcfaracco@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function qxl_update_offset_props() dereferences
qdev->client_monitors_config->heads[output->index] for every connector.
The connector list holds qxl_num_crtc entries (default 4), but heads[] is
only allocated for client_monitors_config->count entries. When the client
reports fewer monitors than qxl_num_crtc (e.g. a guest started with
heads=1), output->index exceeds count and the read runs off the end:

    BUG: KASAN: slab-out-of-bounds in
         qxl_display_read_client_monitors_config+0x61e/0x6f0 [qxl]
    Read of size 4 ... located 16 bytes to the right of allocated
    32-byte region

Factor the index-vs-count check already open-coded in
qxl_add_monitors_config_modes() and qxl_conn_detect() into a
qxl_output_get_client_head() helper that returns the head or NULL when
the config is absent or does not cover the output's index, and use it
in all three places.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 34 +++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 75d47e6b9142..92cc240dc9c2 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -147,6 +147,21 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
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
@@ -157,7 +172,9 @@ static void qxl_update_offset_props(struct qxl_device *qdev)
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
 		output = drm_connector_to_qxl_output(connector);
 
-		head = &qdev->client_monitors_config->heads[output->index];
+		head = qxl_output_get_client_head(output);
+		if (!head)
+			continue;
 
 		drm_object_property_set_value(&connector->base,
 			dev->mode_config.suggested_x_property, head->x);
@@ -262,12 +279,11 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector)
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
@@ -1103,15 +1119,17 @@ static enum drm_connector_status qxl_conn_detect(
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

