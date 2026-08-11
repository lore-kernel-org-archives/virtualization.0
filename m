Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C6E23A9BD
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413401; cv=none; b=uC2NC09eap1XNPrAMF2irLQTlZMnuyyQnPBhITaBFUr2TLZGknxsz00ia15QajutZLWrToS+lhBi4fffBDD7dg0N9xpxqfB75QlpWL4aNYZ0iYp/9/hibmz6G9kuG7O/ZRXxUTaPh720PX5EliiiRVyxYRnv/73/WGtkeZR5rTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413401; c=relaxed/simple;
	bh=JP53AKVYfy8w6mDHpYc1QU9BEOub73QF6+gV2TWJQzY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wvhi7CmBaLNBlgp1PmFhXj4dxFotq1TJLJZE81EuQ4BnwVq6zuEKFZ5bTV0Vcb6r2Nq8l5H87qgGY/jFgokYzJ0Ry26suOhSx5JX8rQkrnHSiC8irN6ad+ldRY5JXYu8L5bwc0+YjKYS36ayBRmFFopPGY54MzdqFd22yOc6Cqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4hJvmd1SQQzBL0v1;
	Tue, 11 Aug 2026 09:53:53 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Tue, 11 Aug 2026 09:56:32 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <airlied@redhat.com>, <kraxel@redhat.com>,
	<dmitry.osipenko@collabora.com>, <gurchetansingh@chromium.org>,
	<olvaffe@gmail.com>, <maarten.lankhorst@linux.intel.com>
CC: <mripard@kernel.org>, <tzimmermann@suse.de>, <simona@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>,
	<chenjialong@xfusion.com>, shechenglong <shechenglong@xfusion.com>
Subject: [RESEND PATCH] drm/virtio: check return value of vgdev_output_init()
Date: Tue, 11 Aug 2026 09:56:24 +0800
Message-ID: <20260811015624.830-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20260802101108.1595-1-shechenglong@xfusion.com>
References: <20260802101108.1595-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03045.xfusion.com (10.32.131.99) To
 wuxpheds03048.xfusion.com (10.32.143.30)

The return value of vgdev_output_init(), called by=0D
virtio_gpu_modeset_init(), is not checked. As a result, modeset=0D
initialization continues even if an output fails to initialize.=0D
=0D
check the return value and return the error to the caller.=0D
=0D
Signed-off-by: shechenglong <shechenglong@xfusion.com>=0D
---=0D
 drivers/gpu/drm/virtio/virtgpu_display.c | 7 +++++--=0D
 1 file changed, 5 insertions(+), 2 deletions(-)=0D
=0D
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/vir=
tio/virtgpu_display.c=0D
index 44ffffec550f..f2b98d018c1e 100644=0D
--- a/drivers/gpu/drm/virtio/virtgpu_display.c=0D
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c=0D
@@ -378,8 +378,11 @@ int virtio_gpu_modeset_init(struct virtio_gpu_device *=
vgdev)=0D
=0D
    vgdev->ddev->mode_config.fb_modifiers_not_supported =3D true;=0D
=0D
-   for (i =3D 0 ; i < vgdev->num_scanouts; ++i)=0D
-       vgdev_output_init(vgdev, i);=0D
+   for (i =3D 0; i < vgdev->num_scanouts; ++i) {=0D
+       ret =3D vgdev_output_init(vgdev, i);=0D
+       if (ret)=0D
+           return ret;=0D
+   }=0D
=0D
    ret =3D drm_vblank_init(vgdev->ddev, vgdev->num_scanouts);=0D
    if (ret)=0D
--=0D
2.33.0=0D
=0D
