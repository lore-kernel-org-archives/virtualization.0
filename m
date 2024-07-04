Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944702F37
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101649; cv=none; b=idvF7xqZIOkw7wQoXSHDYb51+UUmuD94cprmoCeQKnkWpPn8ir8xAov9qoJrSlD7Wx3BGt6rm0VA2PZrm/8U29nQ/jeHoTTIWWck51FqpC7cZOFnjlSjgcYHJndzxX7CmOHxBt5pRcNm3iLR5ymfRc7DtuSp0aaaWHykqPiQ0rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101649; c=relaxed/simple;
	bh=/X0yE8f7XR4volbJhs7urx60xnjrl6METk7uV8iq6k4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJwQrBl4CBgD4DpqeQFjb0myVmNVTCuSzvYs0CzxrA9t325oGTMeqDsmV9A1XHG6CigcPXBpik88it9ohhBvU3zxe/q+3SScROuxp2s1zKnD8R6olSEGftfp6aTGttf/R5LU6rUOLz8LhbiW61gV1Kqf+qMUmw3V7hQPur9o7u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowACnr8v8qoZm5G+PAQ--.2764S2;
	Thu, 04 Jul 2024 22:00:35 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	noralf@tronnes.org
Cc: virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH RESEND] drm/qxl: fix null pointer dereference in qxl_add_mode
Date: Thu,  4 Jul 2024 22:00:27 +0800
Message-Id: <20240704140027.304685-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnr8v8qoZm5G+PAQ--.2764S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF13Kr4UuryDtr47GF47XFb_yoWfAwb_ur
	18ZwnrXryUu3Wv9r47ZFyfur4IvFykZF4xXr1xta4Sq3y8G3ZxXr47ZwnYv3y7Za4UAFnr
	Aw48GwnxAan7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUFYFADUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In qxl_add_mode(), the return value of drm_cvt_mode() is assigned to mode,
which will lead to a possible NULL pointer dereference on failure of
drm_cvt_mode(). Add a check to avoid npd.

Fixes: 1b043677d4be ("drm/qxl: add qxl_add_mode helper function")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index c6d35c33d5d6..7c11383cd3c4 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -236,6 +236,8 @@ static int qxl_add_mode(struct drm_connector *connector,
 		return 0;
 
 	mode = drm_cvt_mode(dev, width, height, 60, false, false, false);
+	if (!mode)
+		return -ENOMEM;
 	if (preferred)
 		mode->type |= DRM_MODE_TYPE_PREFERRED;
 	mode->hdisplay = width;
-- 
2.25.1

