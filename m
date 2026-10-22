Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672514;
	b=bsGjgW/y6OjhNaQo9MEZX3r6A+3yGREUqZFKX+1diQPEZMZwe0FESG9KAEBKfTIxLSeq
	 qzB6yniAd+UH749N83pujtkbMGQWmYmg3P5G/GgejNkCE3/mi/1CqAymW75BCbG15aU4X
	 AhYBXkNeevAGNZelnUcQp+9I9Rz5/Eg6yoxpXmTgkp0sJuRFnKACFt30MoRCdS+VZoGrd
	 /PWFydrriTo/EhdX3pWxS/4KxlZRIvlNAe2DCvSVtMjBKOraOXHH/qJKeGvSARw+MgDrz
	 ycfxVQAAWdIQB5ifQYiaYq3XTUbn77rbyKi9LUhD5+rhdok2Cz/2PdyCV4AB+RMGqeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672514;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+0LuoyrNY2M2xNAxNIEv1eNUof956wGD4Lw0YLoA+0E=;
	b=nIoELrHxxf+shFeQpm28wPvcyyGw4GQC2QnghpY4Kf73BVU+cgbxiFzta37GD5x0aMz1
	 Cvf2JaTSS9Ph1aYV5Co0iBO/Ir/jgoQqynKPf0K06Lpk4PEZC64Jk3EYNH+Xwax3YvK9G
	 E5Zl9mS7lo7GAbOyRL8gAX/bjihYT8IFgiYJ54bewICz7qL9zQSzPs7zcCkfNty4Q4n4s
	 kJIW5s6p22M4X31rdEUClQJxvwtrcQ16+DS7YSTnJADjATjSF5QMl3um9Kd1xJfSzbspf
	 NK5X8SekSS9rjW6DRKzJYMELIjRaVou/JQGs34PenTHJbtO+7/YtYprJuEHNDiOD+pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Scs+bHbH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581E606A325
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Scs+bHbH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D132D1F000C3;
	Thu, 22 Oct 2026 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792672513;
	bh=+0LuoyrNY2M2xNAxNIEv1eNUof956wGD4Lw0YLoA+0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Scs+bHbHWxV53tobel3lG4QDjCvIPX1Gg+YBcTq+nmvsV/Iq3ra6yXkTdmNywsLYT
	 Oo9UekTRyvhPLa1xf0qgiwThJhyVAb0UOr5AaLqVbKkrpZh37RhWwiFQ9mCaAlCkj3
	 GgqD3k9kgVZYFhwAwytdSdRSv28RtAu4rYcT+44VEXUwSLXqEXmU7IQiGeyiHZqyrS
	 /EXsKdesg95Uzgtj0RXcd2eHbxdyZqg+uGGl8w0by+F6UlYLoNMl9ZV3E0w70b9Clg
	 z2zYhG9TxhSBXdw+syn+iL0J5VE1wBKxrpKB4pL7OQDkF3btt0kCpIfeyj9SLw7zXE
	 iP22kURrGeKmA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:23 +0200
Subject: [PATCH v2 24/59] drm/qxl: Switch to
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
Message-Id: <20261022-drm-no-more-connector-reset-v2-24-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=mripard@kernel.org;
 h=from:subject:message-id; bh=sA7bucIT/41HYFCGwypCIgGH4JQh0Qt8z/YGI32/ZB8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mGb0nZx6ff7pA/ECXkouey7qit9e1rxoTt1K0RU12
 VOCTnKu7ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT6bnI2PCH4WlBQ9Pcu8lm
 F9RNcjyKj9XKKgU2s4baHC5/9VUs4XCk6r/N4Rs8T/l5hV8QWLejkbE+psal/aR255JjvN57uK/
 O9y019nS/yOvnrGya/cm2e2vO3F9T93jkmfAVS/ldbzt04xUA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The qxl connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 63fc7c6a7f1a..204c47d61373 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1142,5 +1142,5 @@ static const struct drm_connector_funcs qxl_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = qxl_conn_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

