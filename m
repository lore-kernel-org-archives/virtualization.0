Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825205;
	b=FuMIRVqSTPfWp6L8JihCl7QUr4ZhrRuLYs2MN5HdBipOa8WdZq7qBQHI7efTDlcxfVJl
	 5qekUGYLlVRMYoDYgoy8GsY1lHiiYECbDEhFRMG8LD+BaXP5WBdTDIkhuk0Cabb9Z5KoX
	 n4Y6Kj7DmpfRF9Cl04KVNeADC4KuX4Fre5fIieeeid2HC7kpcbybRhhdn8iHuiE/4+dlf
	 67qwcYskOksQ3yuqPxzEG9eicQbVGNj2RpFZFrwuzsn9xF2Hd5EhtnJkDjFicgXTR1qTg
	 l6OReWC6ToKiEn+C4Y8PWRkx1GCgTzZp/IkEH8VCoUpkfCMpUsV9g+/zTmPYpJJcbJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825205;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WGtNUpx7CBH9AVW0rbFPnwpFHv8Ka71t7S5EnLEFcOI=;
	b=sGid+SuDuMDWQvDroicBZk8mNuwJP1RUOBkOOyclLeEtfXmtrbmWCnEuemtmvuhbhb+9
	 U3U0jAZxeY0gaAb5zZzbXNFhSXsm4kUQ2NxMBBuKpO0cC2ngFsO+d2bix+OznRoB3jbsb
	 1oETIm7i55+bdDgw0Vzvo2Dx/+46KVtN3yPN54nScLlnYbDMGwbQ3pQPjahFbk7WaZJjs
	 c60Vs8osAWfLvRMPA0tCkrasQw+ZKPuHVgurnYSo7M24ULWZOl8LMVhfhTOKaJi4aKSGN
	 Vm3jVDxEw2w4c0yF4wb1bVn8huley60o1X+mBULI+6pDrVVTvrt1LEAyb8DpdAaBHkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTy1g1Gr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CA5606A329
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UTy1g1Gr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D841F000C4;
	Mon, 16 Nov 2026 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794825205;
	bh=WGtNUpx7CBH9AVW0rbFPnwpFHv8Ka71t7S5EnLEFcOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UTy1g1GrGRitYr3yLk/qHaOXhVfVL1IxLWwx1o+VM8w830mO24HQoXCcxDhBYbcEh
	 7ciFDeBJIcJ+ucOYMHhrYjCgsTYilFUHKJh6KUsKtlmPzooMGOKOJotA4Kg/MBeFw7
	 +xg0LfplTtCSTaWRkKJyrZCGAdihxUcVIFKJO3OAdscg9vjqDBdOuscVKMMYTG66Iz
	 iWQsKQy4ckKJN+olqtYthqPjs46QsxNu9aEskMZ9MxcmYJ5MRdk+UMlcVFb+cGeR6L
	 gWpiaAxw6/uY4R7N4s1Oa8e5t/f6oESsUXKKOiOoJHHI7p+YpkGEJwc/V7cgXY+Ghl
	 2z+79rUZoELFg==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:31:02 +0100
Subject: [PATCH v2 46/64] drm/cirrus-qemu: Switch to
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
Message-Id: <20261116-drm-no-more-config-reset-v2-46-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tgxKCg4Td3S4DS+64eM4+SYN9OtbbAEdjJzeA7C40qU=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bocUFBYkF+6z2rdgJktyRWrHipumvFWBnKfVPghfy
 7kw58OpjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRpjOMtWJazwI7fSTaqqbb
 cv4KcOLIlvhUcMa1ZM+biLt9H7VdvJ5tW5Gz2bVsw+GVR/nWbD3QxFgrFvl3iqLrDcEb+/VsPh2
 9cHp1S37nIQ12C1t28z/T83/9FnS2meB44kT9/Au9XyOaynYAAA==
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
@@ -621,11 +621,13 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
 
 	ret = cirrus_pipe_init(cirrus);
 	if (ret < 0)
 		return ret;
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	pci_set_drvdata(pdev, dev);
 	ret = drm_dev_register(dev, 0);
 	if (ret)
 		return ret;

-- 
2.56.1

