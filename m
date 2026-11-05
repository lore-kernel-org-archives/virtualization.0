Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892839;
	b=oSzaMu7ICMPIpB33NhNeuoZBoNbUDRwyh9Sp4jsUKNZgOSImqq2M3IfCS5O9+JzCfWqA
	 2Xom/oEh4NP3UcwR/g0xGQSxsGcNMH0t8yf+g529q0r3SqYFcERI7+Vg2R8jb3Q3J89CX
	 fkvdi46Wb8IuGeBfDmuXLYVnBXuGjrL8KgfYrVkrPUDcMhu+kRhfT880VMf9c9WZoWSeE
	 tm3IZAhTwV4J/9hwQRZGGtWuour033jOq1CWdlKTgykJisJm5ztlryNZJPGYcPSEfgVML
	 8gCT3W3TwUoef47PnXrXPPwhJ0a/CgqQ12N6D61SnthLxei88G+NomkSavuOsjCan/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892839;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=1fyb+oHDiIfRS8lx0Wk6UDHCYZF/ybxBZCuc56FJjjI=;
	b=BHD5WTsqnplfrmN30PK/D728+5YbPNSK0MDcaE0fM4fbgNOMnyOqkP+jN7+KVK57o5lb
	 KNh2L55rhwXLMEtUAixSji+JUcHfrmz4ayvJWAE8R2sNOe124cqSO+WD5VsagT4GA6rbs
	 O1Ul39H4aowI9HqB2Oz4XaIXk1FFJ8/0DWAqpb3XI1IL900sgev+MyUHmwVMLE5UXmeNo
	 f4W/iPKoGxLFIoBV87+jfcFE/7lbPGF269LcJ1fmZvlFCle62owaqxcxVWPU+gnKS8cWR
	 rzgznRT9HVQSss9hKTLgw1Pwu4s99UgOeR3dqPu2uLUyMAkIaZPiZQmA9hcDKKKRyEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpQF4JqX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B759A606A328
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GpQF4JqX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69931F000C1;
	Thu,  5 Nov 2026 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892838;
	bh=1fyb+oHDiIfRS8lx0Wk6UDHCYZF/ybxBZCuc56FJjjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GpQF4JqXORHxZ8UTge6F6VnzAGyCslT5ubywTgW7XzjE376qdziNiq2BySYA181xp
	 S2iIpuFO84IaxT+wXT6y1pfWTX2c8+4/mjd6jBHpcP/hFtbTVpqcBImB2/4ZSVRRqX
	 3vUwbWdYJMFqJjR6jaH9uDPDTSOGP39LLrZeo8AsrnfVr7mA75k7ocTqTTm42vWc+X
	 sXaSMRO7K/gUBK5O6g2rA2CICHhNNqZq3GBXFxHG1tTyj2z9dEvU9hyYlyen7CQE3c
	 NlhbtdTdyeRJ/qN/xIuTbGBne1WBUlm0L8wvYfhuusVn9Xev+v+gK6gd861uvTn0D8
	 aTz4AUGuzxYyQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:11 +0100
Subject: [PATCH RESEND 62/83] drm/cirrus-qemu: Switch to
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
Message-Id: <20261105-drm-no-more-config-reset-v1-62-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=mripard@kernel.org;
 h=from:subject:message-id; bh=6eiGMjLD0b3XWasbaPwJibr7gKWavL90TEmFJsSYJBM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvwwbTzYpHXCxf6I7m415pYzHG3H4lXPRueHX9+zz
 Sv57hL9jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR/bMZG2b+bjRKn7NlcpQg
 Y+meU9aKe+dWCWxS3+uR/91veTFvbayg5YUAja1eM9vSj9aunxUxjbE+z86eqfeRjuMDNv91p16
 0OdTozbx4NndNpdUf7adT3ZYdqrkqf2+e8qyFv3RKOn/++tgMAA==
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

