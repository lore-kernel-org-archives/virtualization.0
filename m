Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887910;
	b=EwB71yA9d3Xrxarin0eMVG9p1MQE1IZHwgLtvTD5bp1P5uE4l9X/qZs/mqk5FWTIaemp
	 fQ6okGIpkMEIRqP/0Ds+xDes5pGXF/IXWt8Oi4C8INacHn7o3jM7eJv5uvtkS4GFLrDpq
	 GfyugTpd+CcRfi6kbWK9bzJjnEgwhGbOY0xqrzWyUJ/A0/ZmeBDbJ4dMGRG+NVisGVBis
	 UQqPy1oMYa0ViskL7r9OQJaZznJOEjNrbjmoWe++knqYxdmyhOUDFEHM0CZpyeKwVkh9q
	 62eZRZeW3HV5o2lw+lh843VhopedcsBly0pu96zCM4aonpCuMQxJ8oabSleF3x2UsxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887910;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1fyb+oHDiIfRS8lx0Wk6UDHCYZF/ybxBZCuc56FJjjI=;
	b=AXeEyQzo9f05j/Tn7G8y0quU8vFsoDHx+pYiwKYceW2c6zzdauHPs1rJ0AIeK/SQ5A0c
	 J1I6R4fJWHcbmRnP96S34uOxv/boYfpJbtJBBFLHohbbk9oXY3RnaZrsILQ/y9ceAfwO2
	 Eql9h/wcOThJ4NRWc6qEJDZ6a4guZJak7B/Rzm8y7gybGF//Ch2Tng0ftew/xmeynUEUe
	 pna2sCdbJIEkEhgKaF63IQH5x01Rsne3KzqDPAn9z07538M4VGhfTIPPgSySC96PiFh/O
	 KF2KkjQ//nbKy40YJGM8I6elTMvFLJz0Sy3a7FS64tOmEH2Qn8urY7oL6b9yF7TG9tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yqv87AUg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AB7606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yqv87AUg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B11A1F000C1;
	Thu,  5 Nov 2026 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887909;
	bh=1fyb+oHDiIfRS8lx0Wk6UDHCYZF/ybxBZCuc56FJjjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Yqv87AUg+uL2Gm2FEUplHtqPuuGY3C95UF+jSgjzXzTuZwLgwkbIEPoeB3R+J5WZi
	 GNX0shsSXAQqKOz/QzyqYLx+Z+o/uYdk6cEjWs9UE7NRCSJe0v2OcFgfyDGmiNTiO1
	 6zkQt0NRrTyQxqCYF8LuKzw6BHO+tAX/ZEWKQZ18t1Vg8smU9RVuT1zBd/+5SK3ZzE
	 bpFHfGJcJxRavsWE2D6lnU6PaAcB+DCmh1n2zyQer/tn9JCRnpKnbgy/nlroSWD5VE
	 1/H/CPnL31kIF0HfO/z04fH1anzGVvy9fjHMtCSTQGaTev4zIAJvXEGzedUDcRNz8C
	 dUS97bekGhVRg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 15:08:19 +0100
Subject: [PATCH 62/83] drm/cirrus-qemu: Switch to
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
Message-Id: <20261105-drm-no-more-config-reset-v1-62-763560c2cc3f@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-763560c2cc3f@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=mripard@kernel.org;
 h=from:subject:message-id; bh=6eiGMjLD0b3XWasbaPwJibr7gKWavL90TEmFJsSYJBM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlverd3JdimWbw9pMU2s7/1a8AT5onan4J9ZGb/i9A7/
 T5fc41lx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIgTljQ6vjraJLLFXXdhf2
 LOzOcatqmD/18NK7l6awt5XsfW516s62EPuH6d92poidVty+0r7KkrHh4CPpWJOQ+OfRujuesde
 Z/FzFsq25mvsBM9PPIyFiyutP6bSvPWnRH/jlmpBa2fVUjRIA
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
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 9e3051b9c3f7..98664f573ff8 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -624,5 +624,7 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	pci_set_drvdata(pdev, dev);

-- 
2.55.0

