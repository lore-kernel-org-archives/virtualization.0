Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887971;
	b=Tipp7B9diqUoUljPffYOAKYKKq0eRdBBiSylykJ8Pven16+pFlF+MWXzSMPtjqX88muz
	 MpRIrf5Nyiiaxf6Bn4rWnNjhj881r04jAu+bzRHFT5nMOAoatTyLAXoec7vXDeQKoBCZK
	 qowHhdMuV909DGjsu/qRtFdNOQ9ML7d/8qzYKV13KfV5afSuQz4mRVkSpzmjtAVcJEHS1
	 RodPXTtseIIAq7V54hVMVlDwmsYyahq4n0xBNu2U1X6iog44pa3kFm/vXf9WuCZ4kcF82
	 QyQjttk52JmaszSutQzjBsOWNviRfsQDKKus+6omNWYo0OgoJ89z3miQ/W+ZcqD9/mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887971;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4MSsUxDulFewsTAdZFuJCjltliXHaoHQchWPzOduXZc=;
	b=4HdbxPKlRDb2S4yFQt0tUS1L0FsL1jMwgfJ93N1uA5KQd4EemhEonI739vf2zFyGraJS
	 fpLRG9m35Jfm5yGN+bDHmuos/8mnusncr5OUgyX544zc2HBnj1kl4SgOc2UwBwSObtDnQ
	 yN5XuoqYtSBvBLR/UMVkDCWjmORSxFgMs6oVTHsTM+NqFb+R1+cJNTuRgLUXoz2JhyS8B
	 lXDBgf+AKmXyuuEcFfi+eyp+PK5hlvDS3LaVCX2/15pVYr74UOQv/2IWR6rwYmv6tzmQo
	 IF0ynUGO98LvXPgym7bUC3xawm9KY8pURrbCgqAbStZ08wU9juiuKQpkAgvwzYl+xTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mk1PNucE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E4606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mk1PNucE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AED1F00A17;
	Thu,  5 Nov 2026 14:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887971;
	bh=4MSsUxDulFewsTAdZFuJCjltliXHaoHQchWPzOduXZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Mk1PNucE96xKBb4UT8sHTCEiXhi0LMQfZjJf0McmiJ5PaOnQLa2yK0VZJeUY5kcHp
	 p70wSbzgi6kPVx9pXk417VFMKzDJ19tXIgVSCq5LN5yQU8MJa6z01kbmfcbo3+k2J9
	 71LOFUSc3bq2ov9UUmfVG2Tsc0hr3ACAnQv4AFE+NMRx1VWU+SEUPTk7MWSoBwcCpj
	 j1hV7PpJaUaR6UgtkbRRLPvbyPoOqNgC3lYnTJINKYmhfAFofv+Ha4j78wiYnLSq29
	 JtKWYABJn55rOHvnXP3FELu84kdd44vl1lcO+vL7idBzD6FrhwEtVQeSY2oNtI/9cc
	 cukMScKsTTpRg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:08:36 +0100
Subject: [PATCH 79/83] drm/virtio: Switch to
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
Message-Id: <20261105-drm-no-more-config-reset-v1-79-763560c2cc3f@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=mripard@kernel.org;
 h=from:subject:message-id; bh=T+TESsozrvSq97ycIKGAiBu3kqjoAgmAIJUqctHtT0I=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrsjb6hxzIBraviFIww8y7oE3PF0tXqnOKJ6SXo6FBLfEdCK
 YiVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrsjb4ACgkQJ1/OGaI9vnb95wGAiHmR
 6OcwMjB8tOmXF3JIhx8jj+EVwUdC7XZWSb6eQp64kU2JST8w71MlYnQsYev/AX9BxDaVGG9dnac
 6N5z71IuVpXRJOyU9+UQTzEeFxDuqdl9yUUy8gHf0DAbLEp/k/sk=
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

