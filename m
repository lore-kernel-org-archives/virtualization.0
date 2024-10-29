Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF3206071
	for <virtualization@lists.linux.dev>; Tue, 29 Oct 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212779; cv=none; b=aTGd2Vc0WpbCQR67EKuxc0hApKYEFHC0DqpL3CT5kokPeZXCYyU7mt1hRqW6GM9qHfUeUbHRLMlSwrdV+OEoFoPd0TrMtjAs0tKMBTFjw7dnlr4e/6encSUnniOGHuzBU8QnB8clBAVrVyXyOcjR7aYs8KLcenJ6d/mL7YuScwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212779; c=relaxed/simple;
	bh=oeEfeiEsqBvzXQTIOV0lsQddjxBYifuB+NOcemziTIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mma0kH26oFJfgxGZZyFtqo7yAQ1s7bJ21uRwH991Ql8ZYzo25Ur8U4AN1w7hXaVy9XpU8PVu347XjHR/AyyAXnmvo6MYu3Oz+hfN/rSN9kScYDbK16avqOywdeb2BjyMXQY+/jR/w2DN5l+vxPSGpuS2ZQsh0MZaIkegf5cYj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JUOwJWX/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UPcMKKcG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JUOwJWX/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UPcMKKcG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JUOwJWX/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UPcMKKcG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JUOwJWX/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UPcMKKcG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBB211FED9;
	Tue, 29 Oct 2024 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730212775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+bJs0qrPmOjU1y32rTBncmvjo/Nl5zH0boK8UVhslA=;
	b=JUOwJWX/JOIV+zrOpkS2zz3F21VcmPFSil2iNZzoRSrxNsJ82i9qYLazNe7wWJaTBr2FLT
	jNo2wMQPMJ0RgSFoVqFiKCttnLR1FtphQCs917I1C3YmdGS1j95O9AbIBQUzQThdUhYcXT
	WgX6ZOx++1grVPYszlWOeSBNNjs5QGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730212775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+bJs0qrPmOjU1y32rTBncmvjo/Nl5zH0boK8UVhslA=;
	b=UPcMKKcG9Lu6HpaPsZymotvsTlRpq46v5kRGaYltzCGPkHHNSM0v4ES98D7a3iaJ+RNbTv
	QBZ3v9SX7bc5aIBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730212775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+bJs0qrPmOjU1y32rTBncmvjo/Nl5zH0boK8UVhslA=;
	b=JUOwJWX/JOIV+zrOpkS2zz3F21VcmPFSil2iNZzoRSrxNsJ82i9qYLazNe7wWJaTBr2FLT
	jNo2wMQPMJ0RgSFoVqFiKCttnLR1FtphQCs917I1C3YmdGS1j95O9AbIBQUzQThdUhYcXT
	WgX6ZOx++1grVPYszlWOeSBNNjs5QGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730212775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+bJs0qrPmOjU1y32rTBncmvjo/Nl5zH0boK8UVhslA=;
	b=UPcMKKcG9Lu6HpaPsZymotvsTlRpq46v5kRGaYltzCGPkHHNSM0v4ES98D7a3iaJ+RNbTv
	QBZ3v9SX7bc5aIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0D3913A17;
	Tue, 29 Oct 2024 14:39:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QLbQKafzIGd/AwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 29 Oct 2024 14:39:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] drm/cirrus: Use virtual encoder and connector types
Date: Tue, 29 Oct 2024 15:34:23 +0100
Message-ID: <20241029143928.208349-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241029143928.208349-1-tzimmermann@suse.de>
References: <20241029143928.208349-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The cirrus driver only works on emulated Cirrus hardware. Use the
correct types for encoder and connector.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/cirrus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index f06a2be71f60..0231bdf94b8a 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -587,14 +587,14 @@ static int cirrus_pipe_init(struct cirrus_device *cirrus)
 
 	encoder = &cirrus->encoder;
 	ret = drm_encoder_init(dev, encoder, &cirrus_encoder_funcs,
-			       DRM_MODE_ENCODER_DAC, NULL);
+			       DRM_MODE_ENCODER_VIRTUAL, NULL);
 	if (ret)
 		return ret;
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
 
 	connector = &cirrus->connector;
 	ret = drm_connector_init(dev, connector, &cirrus_connector_funcs,
-				 DRM_MODE_CONNECTOR_VGA);
+				 DRM_MODE_CONNECTOR_VIRTUAL);
 	if (ret)
 		return ret;
 	drm_connector_helper_add(connector, &cirrus_connector_helper_funcs);
-- 
2.46.0

