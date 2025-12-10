Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999527B358
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765382071; cv=none; b=G1keNi00wmeZ+S8u9Y+nt+R55pYjrnF+sHdMqXsQ/+Zrf2wfjL8cEDzXmfZRduS3HYFXcLGmCIMboXKdZZ5KmoGzcz0kSrCumG91Sj8rJXQEVgy/HpwY1YPP8GkSpOrpGEuh2mWN10OjQMfoewjj0qb/+w7OsdpAjRYRHXbqJ9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765382071; c=relaxed/simple;
	bh=XM5+ibgCRNx6laH3fHmABA6JPmVTRYJEvOZNcSA90SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXWTiFeRIcfBf4mDzwXz73BnYxcrhSCegYqwxAugVQfFmPBvPdenUiKZbppGOMpnsvXsb3uadI+1n6B0b/49Yq4ubv7s4MQa+BU0WLzrAj3FO6dSDJ3obYr9PHS2S+z8rcRMjEoycZ9RN0SyOBjablRp3RuO5slLsuEGX2bdjQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=Mns+9tOz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lh74OJWa; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="Mns+9tOz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lh74OJWa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 373ECEC071B;
	Wed, 10 Dec 2025 10:54:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 10 Dec 2025 10:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm1; t=
	1765382068; x=1765468468; bh=BllEaiPhiGYZgGS2XLNjzeUPP3RSfQtfvXc
	wa9hVnPk=; b=Mns+9tOzIa+HRFFhUpIqS/fgx4r9fxXxtjAZkKskf/x7hYp6bHj
	4Edd+3rWq8Cm0hJ+xjOv3/E7fA3qREUYUxCglY4O9eDpxzJRl6//om2Cj1P23EoC
	J8CdYM3II3Gg9FQ6cP6R0eGFH5FLBfibiUe5fx+/XBeFC7p8+4BStPSzUHTBEXc7
	ny81nG/mUwwEb865e45X4zCwItwS5lhRMNcYeVzM1Ko5tizzPDh/P5ACteQLp6Q1
	VMMdFDUFmQy8xYC2063Q2ySvtrBShVY/vLBd9h/w05QUWJiVFbwP4Dv/j4r7sxAO
	MRUZgGgLqiNzUe6cHJFYbwg3soxU0Rwp63g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765382068; x=1765468468; bh=BllEaiPhiGYZgGS2XLNjzeUPP3RSfQtfvXc
	wa9hVnPk=; b=Lh74OJWaLQ/D9N/j7SHJz6JXV15Vlh1XodWscwhqTDzq/So2J3n
	ciaEYJdXEtneogTwjsc2WdyacJmmn0tOYYERg5F7lOucuiiMj9g/E4LtCbna9Soq
	SAEQQf8Toh+r5izHNJ5/KdjBc7+AB85d5cDOmkoXndIMyD5FncdHdlt85MoIEfgu
	da1qUY7IRImWAt8VEWeqCqtv3//gA9vcrproq/7WJc/X6UCemHXDFOmEoHhWZU+m
	2kdH6+LPAVPa7xNHTvA5i/WDqQ0y4I0b4rI50VVcn1asnaFWZTsGJoKhP/AP7zN0
	7+J1wMLOnX+6upIAmIfNOCUM5HJeiJ5RCSA==
X-ME-Sender: <xms:s5c5aVKpspnptEjy69VqQvm43xA_stccHAWuUCXogfXlrxyokPwFBw>
    <xme:s5c5afoBUAi9YENBtM2jG3uqAoAAAg8hBUJI7yObgbAwaUUSeWMIEtLcvucfImYIa
    FXJbwUhL35vB8XF_Oc5mxGaahvh50dDGcZAWHprvs37ZqlS4-Y>
X-ME-Received: <xmr:s5c5aUiPS4D6FFKL1VDM3R5rKTuC8jmLpczjrNgNtOETpx_Tzld1gh8MLyu960XLe-ZVk2hgoSE7AvmnZ4RtZWlSSef-Rjg_HwnKdhkfE9ovLDIAijd811ToMgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeggrghlucfrrggtkhgv
    thhtuceovhgrlhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtf
    frrghtthgvrhhnpeevudeiiedtjeegfeduveffkedtkeegudelfedvhfdvffdvjedvfeej
    uedvgeduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehvrghlsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhdpnhgspghrtghp
    thhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrihhrlhhivgguse
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehkrhgrgigvlhesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepughmihhtrhihrdhoshhiphgvnhhkohestgholhhlrggsohhrrgdrtg
    homhdprhgtphhtthhopehguhhrtghhvghtrghnshhinhhghhestghhrhhomhhiuhhmrdho
    rhhgpdhrtghpthhtohepohhlvhgrfhhfvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpdhr
    tghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthiiih
    hmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopehsihhmohhnrgesfhhffihl
    lhdrtghh
X-ME-Proxy: <xmx:s5c5aWb9rNrhVGA5AOpjVHbkhRXPT0AjethTgb9ekF3eHBxuM_30XA>
    <xmx:s5c5aUnGWGVRvi41NTsJolOCIuF4aF4l9BI5aPA4hDpdnbBUIA-7iw>
    <xmx:s5c5aUyBdj71vM9_Tfb4Oh6MgaaDtEEi258S2DaAYgaDFBLrIfTMdA>
    <xmx:s5c5aS9bXAkHEHZ12JHQrBYAXDmL_H1EmeaaT5Hz4BbvIjU0UuuGhQ>
    <xmx:tJc5afkCWTEWD1IcTk8X12Ddbe3lSYOmB_DfyKzol1DAjiEdTpzLRcw8>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Dec 2025 10:54:24 -0500 (EST)
From: Val Packett <val@invisiblethingslab.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Val Packett <val@invisiblethingslab.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	Christian Koenig <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: Allow importing prime buffers when 3D is enabled
Date: Wed, 10 Dec 2025 12:39:23 -0300
Message-ID: <20251210154755.1119861-2-val@invisiblethingslab.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This functionality was added for using a KMS-only virtgpu with a physical
(or SR-IOV) headless GPU in passthrough, but it should not be restricted
to KMS-only mode. It can be used with cross-domain to pass guest memfds
to the host compositor with zero copies (using udmabuf on both sides).

Drop the check for the absence of virgl_3d to allow for more use cases.

Fixes: ca77f27a2665 ("drm/virtio: Import prime buffers from other devices as guest blobs")
Signed-off-by: Val Packett <val@invisiblethingslab.com>
---

Hi. I couldn't find any comments on that line in the reviews (on patchwork), so I assume
there was never a specific technical reason for that check, just an abundance of caution?

BTW, while here.. The drm_gem_prime_import "fallback" seems pretty much equivalent to
`return (-ENODEV)`, as drm_gem_prime_import(_dev) just translates the call to
gem_prime_import_sg_table which we don't use. Should it be replaced with `return (-ENODEV)`?

---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index ce49282198cb..2fedd5d3bd62 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -312,7 +312,7 @@ struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
 		}
 	}
 
-	if (!vgdev->has_resource_blob || vgdev->has_virgl_3d)
+	if (!vgdev->has_resource_blob)
 		return drm_gem_prime_import(dev, buf);
 
 	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
-- 
2.51.2

