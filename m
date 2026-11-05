Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892900;
	b=FG3ro/XTtjINb5tKsOocw8bba7E8y2CjC/msFqm/PqTxRbPM6ZAG0ZScEb6Z5DnqthIq
	 JKq5u8X/zJhINhsH8lLPOxLyIdkKM71J9OzX3b6C1aETWYig2vJBGT1SbENg3Wgs+ptU/
	 +9cgz6kqtTZGDbxviKW1msVfYfmYjG1tFyZVb6mgjWmn6pC9iZfDV6S+UU0A2XkPicbiU
	 cMohPGLW4cgF2o7SJj+IroMJPGLC42n+DCcU/+Cu3VibmFiWV+BIwWpXA6QkcGQvCw3qk
	 KnMzPlMyIZfoorcGrUogiD/GgPmerqu4AqaCPUt62A+a9Kfbza0X4MFUXmWR/wPErlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892900;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4MSsUxDulFewsTAdZFuJCjltliXHaoHQchWPzOduXZc=;
	b=4Ib5OshrVryvBeMV/iEZ/CyMEtHuKJ3MsppZE/w4dNGjnQ32I0I/yB6QpkgYehtt9WaA
	 hL3WRXIn8d4xq9RXJVMXkeler1QrazNO+5Bq5mN2fV+Nw160zhTyolq39jSNWKWFErge3
	 Q5cBPMcj+W5bw3aXSEJqzjQBfZ0qlXJ4qldWbYFLndQYSnM+5hznh2Pwwn04yeSN7rBLS
	 EVvHS/m400GNdrNq5Olx0J9KUE7Ss65cVJgxMm1JQXTwrybzcj3Wl5xc2Qdb1qTk8ygv1
	 ztucw2Yhj2EblPFVmeYSLZau/Z9yiPY1BtOVbVqhG45wp5I2jTSqqkCwi8BIhi6002g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPqXtwi2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2F606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nPqXtwi2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EF51F000C1;
	Thu,  5 Nov 2026 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892899;
	bh=4MSsUxDulFewsTAdZFuJCjltliXHaoHQchWPzOduXZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nPqXtwi2fgt1ncQvsKRUB0BoqCTtyWIccvGuCS+NfcJP3ziGm/AfzRWN6b/qfEPQ7
	 14os21GLUZamee4uKHC4fubMf46C7TDnNLHinvoUI5rm3kskcULRZsWSIxlfkZpto0
	 3u/Y3/vQSGiPUtG115QMD07nyUG4B0Enyj/S6UIA+7X66zsGR4LlrTPgVhdLyc+EOb
	 +ZVvX69SMPDsIkMXfbkotv4UHwZLP7YtHq06UAr/jo0rsh6BN0+sYmlW7ojPSa7uf2
	 y4Plk2Dmho1Z/EL6KmlQ5xwayVZ+bwKrGGgnw63MuC2bt0JrqKvif3+ybIlx93LWXB
	 KY/RDGvSCAYzQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:28 +0100
Subject: [PATCH RESEND 79/83] drm/virtio: Switch to
 drm_mode_config_create_initial_state
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-79-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=mripard@kernel.org;
 h=from:subject:message-id; bh=T+TESsozrvSq97ycIKGAiBu3kqjoAgmAIJUqctHtT0I=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjLoz+hr6LoXbWV/YOLemzdqeHPC2bSEWLTOaah7/
 VavcznbMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYyfwVjfajMZEn+3s1rz3Vc
 +Hw/bf5s3esbn3inPbM9pPzx/NIEoVxJxr4LEp0cuz52OFa5fjg7kbFh8dnaG4VvokolzWtdvuo
 u/XrQR3XxB5kVi48lOUlHTdyed0hhz+ebHsKMzPu6W/dZ3EgHAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index f0ed9bd27a91..dfc3aed03b8e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -397,6 +397,5 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *vgdev)
 		return ret;
 
-	drm_mode_config_reset(vgdev->ddev);
-	return 0;
+	return drm_mode_config_create_initial_state(vgdev->ddev);
 }
 

-- 
2.55.0

