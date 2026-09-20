Received: from mxout021.mail.hostpoint.ch (mxout021.mail.hostpoint.ch [217.26.49.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C311A2DF13B;
	Sun, 20 Sep 2026 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.26.49.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933727; cv=none; b=fhT4w33l8c2vmj5ZH/Xs15bWoYZ6WAFmUUthaV25mgTsRKnw/xkD23YoJ399YcLYUTpGSg7F9h7rVPsacI2WFfrNE6SfRQI6nK0tGmkwM7ffRfBDbu+BU69X653YV1BPpXLL29NieiEZzJ4w2HOO50PUlgZhiZ1BoWRGZ/p4FXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933727; c=relaxed/simple;
	bh=A1w5h4DRCpZnQPZ8bKzTwmM9hpoIACrQPo7j4MpydvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoPTK41YbuEN8SRVJgmYLdDqw+ZLze+1a3/SxGaJdNQfr6tbwCNgjKC7POzGEoGvuBLrZ3Ye6lparHh9yAqv4JI8KH07tkytUJdbIOS5Oy7jY/DxoJDzlfBSwUw36tQt6up8idxJFYmx2ngtXoPOof/XkhaeL79a1NnnShzW07M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sebastianvonarx.ch; spf=pass smtp.mailfrom=sebastianvonarx.ch; arc=none smtp.client-ip=217.26.49.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sebastianvonarx.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sebastianvonarx.ch
Received: from asmtp012.mail.hostpoint.internal ([10.4.1.185] helo=asmtp012.mail.hostpoint.ch)
	by mxout012.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5 (FreeBSD))
	(envelope-from <linux@sebastianvonarx.ch>)
	id 1x8MX9-00000000PZL-0xdw;
	Sun, 20 Sep 2026 20:45:03 +0200
Received: from [2a02:aa13:e47f:2280:d4b0:56c5:656d:f4f1] (helo=omarchy)
	by asmtp012.mail.hostpoint.ch with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5 (FreeBSD))
	(envelope-from <linux@sebastianvonarx.ch>)
	id 1x8MX8-00000000NQ9-49VF;
	Sun, 20 Sep 2026 20:45:03 +0200
X-Authenticated-Sender-Id: linux@sebastianvonarx.ch
From: Sebastian von Arx <linux@sebastianvonarx.ch>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sebastian von Arx <linux@sebastianvonarx.ch>
Subject: [PATCH 0/2] drm/virtio: Open-code drm_simple_encoder_init()
Date: Sun, 20 Sep 2026 20:42:42 +0200
Message-ID: <20260920184244.464343-1-linux@sebastianvonarx.ch>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace drm_simple_encoder_init() in the virtio GPU driver with
drm_encoder_init() and propagate initialization errors to the caller.

Sebastian von Arx (2):
  drm/virtio: Open-code drm_simple_encoder_init()
  drm/virtio: Propagate drm_encoder_init() errors

 drivers/gpu/drm/virtio/virtgpu_display.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
-- 
2.55.0

