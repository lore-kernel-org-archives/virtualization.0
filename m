Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672574;
	b=ckJC/GTeTpH9Sac/O6CE+SLQtGd1WCoqFwlqtp72/pWp1Yqb7DWtHKapdwwuAN9htTvr
	 R9at9ABbTKcr6Oli4fyX0paKkWqUiyfSSQ5s60bouTlhEiU33PecvD2AJg2ShFC3iClVP
	 5gDKUVGf87rRKkVN5r8a6/x/7GRdAyuiS3OkxIE+kYpuoWN3dJ3sAdwKthERUEJTqcssu
	 eQdZP84dcLEKpxa7xD+5MOhTbNKI5EsFiFOcX4SzSSTDgLUmYWMM0Jii2zkpiQS1fTDwn
	 r1h9k9ax9o2Zsi1M5xxY4dDamKC1qC5CWtnePRy+X1tFiTuLcjLHLsrY1h9Mv+MQdpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672574;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=JV0+hDXKStKI5k15ediYrUt3eXeXdrAVMPA+rGZ5BsM=;
	b=luMarfCjrXG0h3crnP+D9195izVWc6hOB5X090zfWVLN5xyvKgW/vpYKReQIRr9pA2Mm
	 htWHoM1l1fp0Ub5OHpKRajMGUgqD9E/657kkbgcNR/PY2A2Z2YBZX3uAbbZ7sC59Rlq6o
	 kN18lSQIQiBZzaOUWxMfaAUYN6BPHePpvg7VnV/bUuw48fILut6SYW6ujpY17iv3x3ICG
	 GoHZo7VuDf9dAJMcTMn97Tg3n+yGGq0YsG/GVYHV69WyB2rAUD9rKl89ypRPz9TuQRQyl
	 u+b+k56IJHjWdv6/vIiOMLHvNf1HuzpOBZKjR2KWzoFa5Cq7MLMjI5Kd7XiRoVHbFlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nO4KgITd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E7606A319
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nO4KgITd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDBD1F000C1;
	Thu, 22 Oct 2026 12:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792672574;
	bh=JV0+hDXKStKI5k15ediYrUt3eXeXdrAVMPA+rGZ5BsM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nO4KgITdLOXp+DT3ZZlyonzv8rREQkKD1yPffwCAj1tHpSHdcCk4dLUOcyWSAINRl
	 86Sm9tWQHX90UTDhfMIA+bgEFXidaAMpSt4q2ukOO/0X06vsfYzdGH9QxvUTsc7Eh0
	 hjfhQPx2C9q3ssJ5PDMHgFMHLqyaqNYUVe875mKs9yzkYO2L1oMpIeBtLW2bcwtrBV
	 UAbfM5Rpt7LqW2f5rZzDnueD48pzk+X7bitwSs2x9mw9tLPva+Hz8dmunzln9Rq+v4
	 +zY4ykSQ1S5faG2lxMumqRzvouK03lUaSDwWPW8VU5+DgpSbPVYp3DgdfMweVH4PhG
	 AUullOaCcOPpA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:40 +0200
Subject: [PATCH v2 41/59] drm/virtio: Switch to
 drm_atomic_helper_connector_create_state
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
Message-Id: <20261022-drm-no-more-connector-reset-v2-41-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+tchhSPJrPxzTPXw7MeGEfbYaaYl1eTMahtrArMuNTc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mOZHvFMKTAxNZ1n84M8aNw7rOQfV229UcP+u5Q44q
 93LsUCxYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyk4xVjQ4fZs/x/pXEH99wX
 zd/d3pH1Mr7hnr6wW1bfIbGCjds8uK9v4uY4pC5+K0Sn+hQLe2wfY51N16JCeTdu8QhppUfqbOd
 /Bx9V14t66rj8hfqzGY7TF90risv+x1+5/pp2yVSOFAuzGwA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The virtio connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chia-I Wu <olvaffe@gmail.com>
Cc: David Airlie <airlied@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index b60aab07e78d..f0ed9bd27a91 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -271,5 +271,5 @@ static const struct drm_connector_funcs virtio_gpu_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = virtio_gpu_conn_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

