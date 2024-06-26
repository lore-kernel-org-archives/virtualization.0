Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926A10F4
	for <virtualization@lists.linux.dev>; Wed, 26 Jun 2024 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384054; cv=none; b=kmuoMntBMfzpE0I5HqQ2XCbLwfU6fbThA8ffyE9Ry78ul7xSpzgd1ori8YMG783jObRan2hvj/RwbPlZvV4+defbhuSqFbrUmwLOipWTcBYxZ1KWDQ93c+knxs/2DTDm7itO5Vj/x5tF4edoUjBGhLAICeu9HL1qi4B2hsjlvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384054; c=relaxed/simple;
	bh=V0+zSwiSSVsAC+DiD23TVpiqBcPumsUZT/Qbi/p7J/k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fAEC8bmYpHJxxYbH2fJ1fy2NYh7E5lORx6NkeSGyl6eXt4E3o3/9juPmTLhWubfXrpNXPN+Go6v51eBZezmeOtlxPIOkVgTe1OTj80VPx5+lQ9AGFj5RZEh+9zvtQxsfuxvDemFG5Z20Ze2XNKQVQyg5zznhCqy0ePfKMOwpZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowAA3Pr7Zt3tmHwqMEg--.8326S2;
	Wed, 26 Jun 2024 14:40:37 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>
Subject: [PATCH] drm/qxl: fix null pointer dereference in qxl_add_mode
Date: Wed, 26 Jun 2024 14:40:24 +0800
Message-Id: <20240626064024.2811255-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAA3Pr7Zt3tmHwqMEg--.8326S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF13Kr4UuryDtFWxXFykGrg_yoW3twc_ur
	18ZwnrX34Du3Wv9r47ZFyfZr4IvFykZF4xXr1Iq34Sq3y8G3Z8Xry7Zwn5Z3y7Za4jyF9r
	A3y8Wrn8Aan7GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

In qxl_add_mode(), the return value of drm_cvt_mode() is assigned to mode,
which will lead to a possible NULL pointer dereference on failure of
drm_cvt_mode(). Add a check to avoid npd.

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

