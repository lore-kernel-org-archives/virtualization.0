Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F061DA31
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R+WiHN3g"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BED6F40432
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 12:19:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BED6F40432
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=R+WiHN3g
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eb_7WO_O845P
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 12:19:24 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E498E41A00
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 12:19:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E498E41A00
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 344CA6607325;
	Wed, 29 Nov 2023 12:19:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701260362;
	bh=O5ckehyI20/PoLmFk+FV3fLp1KbSS4iwwIAE9XfLTh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R+WiHN3gCDt6vq+jDhSG7b8yQDkYWemthE6ABt1fa9Hazyp8zqJeM9wW/w/uz0cQz
	 Eg0iMzsj7MsUCs1wGKkd96wLK/MK8PGYXoH6h6DDbJlUFg5fGLhwbiEjKGT+KCblyo
	 jSTXJKUt4qpVLqzzHFCQvxQnKuYOQv+4Jux+uFCjOGlJx+aP1fQD3bJaq15aG6bpAU
	 tVJtDMOzdUyMqCRp0Z9K1e2KzqOEbWlgzwSJlI/kXrgDLibdWeZS6KYc6JhyGxqXkm
	 daUeCsjPUoRUMXm8KmxDRzzxTORlSZrjoAKfBiSHZKE/OCrninnhKiVE/9FEwCrwrZ
	 D+UWU24o7lXgg==
From: Vignesh Raman <vignesh.raman@collabora.com>
To: helen.koike@collabora.com,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: david.heidelberg@collabora.com,
	sergi.blanch.torne@collabora.com,
	guilherme.gallo@collabora.com,
	daniels@collabora.com,
	gustavo.padovan@collabora.com,
	emma@anholt.net,
	robdclark@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	virtualization@lists.linux-foundation.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 07/10] drm: ci: virtio: Make artifacts available
Date: Wed, 29 Nov 2023 17:48:38 +0530
Message-Id: <20231129121841.253223-8-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129121841.253223-1-vignesh.raman@collabora.com>
References: <20231129121841.253223-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were no artifacts available for virtio job.
So make the artifacts available in the pipeline job.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
---

v5:
  - Added a new patch in the series to make artifacts available for virtio jobs

v6:
  - No changes

---
 drivers/gpu/drm/ci/test.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
index e0fdc55c9b69..2c9a1838e728 100644
--- a/drivers/gpu/drm/ci/test.yml
+++ b/drivers/gpu/drm/ci/test.yml
@@ -329,6 +329,8 @@ virtio_gpu:none:
   script:
     - ln -sf $CI_PROJECT_DIR/install /install
     - mv install/bzImage /lava-files/bzImage
+    - mkdir -p $CI_PROJECT_DIR/results
+    - ln -sf $CI_PROJECT_DIR/results /results
     - install/crosvm-runner.sh install/igt_runner.sh
   needs:
     - debian/x86_64_test-gl
-- 
2.40.1

