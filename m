Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947C239526C
	for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188551; cv=none; b=sbDCwhNwT2/QxXPLqx+jxOW49pa65TjijwmLWP0Wu8+l1jDXT26J//d3O5ez2mAwT/pKIrJM6yFWI84kXObvE6V7WXiD3pmoMf/WQs2gTY8qodV1D7pJidiHw9HegsEL6peJ0lb4M1SgE14h2DULWWYWwubCCAG53CE/q6XjWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188551; c=relaxed/simple;
	bh=zG3OrvZdKNn6zh6V73uN0Cvr/55X+qZzOfFvV/Y+h+I=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZjTgBbGz/6iBl0f+G6gtniCCxXOeNSlB/wNe88fpL7Py740F6n1B9Mf4Pev9W1E8Rwl9vsbl47aehAMtIo47q3yTmspNZWZsUidcSORzdtWhDj1pqpP1WyeCIskwW3/95PGvVpU+bJLR1htpBfa2L0ALwOBNJy+ma6M9YC3kPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=OVqSr9gi; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="OVqSr9gi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1772188539; x=1772447739;
	bh=P7jRVG2awdtnvkNGRL41RAX3AeTjovXVV6WiqUibkXM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OVqSr9giXOZRihXEvaHWLKLVUo7MrFxZvQwupf+D8/vgEjx32PDF3HaIH4tulTVwd
	 jhbPsShyp2xT3Pc/ULjAg2L9D6/wr76klRF1QuKr44BT2ZC6Qwfz6mVPGabysF7w3a
	 xlau8Tt58NLYKvlA2VTZVcynDMNdOG+ueFQBNZEBBYignvDAmp7S6/aof4kauoh2uE
	 ymnNJ7sTO56eSbdchAH7Afi69BLSVaq1eu9/plifZMiP0r1Mx8bmUSTjCZE1DOgeMS
	 JaFo3LM5KeAIepLozX2EoQEPouFwuiuKsd9fpXb3bmiotsiBsfuzl5rDFU3wbNgvpk
	 fpCB7hYTRIukQ==
Date: Fri, 27 Feb 2026 10:35:32 +0000
To: Thomas Zimmermann <tzimmermann@suse.de>
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: Hardik Phalet <hardik.phalet@gmail.com>, David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH] drm/virtio: Open-code drm_simple_encoder_init()
Message-ID: <20260227103515.413685-1-hardik.phalet@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 5e66828b35d0172477757075c415afd9d65f4af3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

drm_simple_encoder_init() is a thin wrapper around drm_encoder_init()
that only provides a minimal drm_encoder_funcs instance with
.destroy =3D drm_encoder_cleanup.

Inline the helper in virtgpu_display.c and provide a local
drm_encoder_funcs instance instead. This removes the unnecessary
indirection and prepares for the eventual removal of
drm_simple_encoder_init().

No functional changes intended.

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/vir=
tio/virtgpu_display.c
index f1dae9569805..8bd6cdc6c16e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -232,6 +232,10 @@ static enum drm_mode_status virtio_gpu_conn_mode_valid=
(struct drm_connector *con
 =09return MODE_BAD;
 }
=20
+static const struct drm_encoder_funcs virtio_gpu_enc_cleanup_funcs =3D {
+=09.destroy =3D drm_encoder_cleanup
+};
+
 static const struct drm_encoder_helper_funcs virtio_gpu_enc_helper_funcs =
=3D {
 =09.mode_set   =3D virtio_gpu_enc_mode_set,
 =09.enable     =3D virtio_gpu_enc_enable,
@@ -306,7 +310,8 @@ static int vgdev_output_init(struct virtio_gpu_device *=
vgdev, int index)
 =09if (vgdev->has_edid)
 =09=09drm_connector_attach_edid_property(connector);
=20
-=09drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+=09drm_encoder_init(dev, encoder, &virtio_gpu_enc_cleanup_funcs,
+=09=09=09 DRM_MODE_ENCODER_VIRTUAL, NULL);
 =09drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 =09encoder->possible_crtcs =3D 1 << index;
=20
--=20
2.53.0


