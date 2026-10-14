Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C831B101
	for <virtualization@lists.linux.dev>; Wed, 14 Oct 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998949; cv=none; b=oYWK7btdnnJlxyUYgz16G1DCMw6Gz33AhMYJE7xGKIH6GqXOe7F5V6dgNoHVDzQxbI89GCjWnNJmTReWY1v/Xw7WdMYRHFWSUn62DgEnVuSmbhk7Z/+Rlf6yQr1u1d7SxW7Te0DVGYFdb8yCaUCK0MXv+2LcSqXOgoykyqDkOWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998949; c=relaxed/simple;
	bh=pQyNtLFsY90O8SQ7JhPYrL5wwHyW8gswquII9q9OtYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RY8txZB59MnToKbIbdoWTE3vBHmQwLl0gXaDRVAhpC8Z4RpejE7z9IIF0bYK53bfHfy76ra+LH4jfO5s6fv+YLDv+RPNiykCDpuHNpJWVn4vVU43tRQiYcbuEKMJW3Chq1YR4Wl4sBIma6SBav9coo3eDg2Ksgy8AIIkYey+0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crigrfwT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crigrfwT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8801F000C7;
	Wed, 14 Oct 2026 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998944;
	bh=Q3zMshmFGLjHYUyh0j+F4xwA1uMU6pU+18/2kyrzuXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=crigrfwThb7rPlMlYA0dm6grWRXl4paK3a+/DuywknHCp+uEl0RsA5A002BQmCoyr
	 OXbLJzOz7Osz7M89oXr6VZIzPbTv4MdXWGrO4zU8BJDWDubr5Hw0OVbRTMwEr67seZ
	 YqM9U4/oD89roQnyCSLLBuAhPy/F29wrj5Az70y4TPiVj65vWKhOSKHpz4xVM4H12I
	 jmW6hSz2Ef97+Ghm4XWmHj6pDIE8w+3xNqDF2AMzpZU3RGsTynkyvndALmb7/9bjz3
	 tBAKpZam22t5hj03fYzUFLl0OX+oypZOV2f1qnjtDPGyiZvyV+NtqSUbyu3uAZZvIb
	 OLjQQtXZo55Iw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:54 +0200
Subject: [PATCH 31/75] drm/qxl: Switch to
 drm_atomic_helper_connector_create_state
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-31-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=mripard@kernel.org;
 h=from:subject:message-id; bh=pQyNtLFsY90O8SQ7JhPYrL5wwHyW8gswquII9q9OtYk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd0cc4PtpcM8z1nN3a5bowZkBEtXt1mfqP53c/mKGv
 WVx/mrmjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRLeqMDX9/Fh3cmuJ/2d3G
 b/NmzkPntD+les/3OXxwe/Ldz6se8iQmyJ05WMH7rW/V/U81kucX1zA2LG+Y5secOnGdHusS2zl
 cpyL1ldxXHTFY4R361oOrpeltw5U9ky7Zyi51Pyt2qbvs6Y4dAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The qxl connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 63fc7c6a7f1a..204c47d61373 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1139,11 +1139,11 @@ static void qxl_conn_destroy(struct drm_connector *connector)
 
 static const struct drm_connector_funcs qxl_connector_funcs = {
 	.detect = qxl_conn_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = qxl_conn_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int qxl_mode_create_hotplug_mode_update_property(struct qxl_device *qdev)

-- 
2.55.0

