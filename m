Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E764C6EE8
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028515; cv=none; b=ujuG9A0O4jjN/C/EzXyDj1wrHbzWcG3GVLXcmC6pUFk4ZEyWUbMOtQ3K6OjxKoDAyJhybRMd+QZZzMBQ0XoB1X73CG/rGRQcHYjdzvtwAcWSy+aOe88hyv8lnyoWJ7h4qgLY8lGkw1W4U5Tfy+Iamn6stF2HLov1sh2FFy5+GWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028515; c=relaxed/simple;
	bh=8PxgdVd5egqagi4OQSfCP/LgucTSPc5L4FPbpNs2LFk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TTUkap820CDqkv1hQqhDnI6tONvx8206gzYQJYKcN4qMkbzH5QOsgl7fZ2AbYyV4Lfh6vP25tM3NLp+sLLHcgpRP2HTQYpam4y8jaRWHkMKQQHaA9QUMvXhb9IjrohTCyPVN17XWeUYhdtLMRjZz2pyJPuXFwMumrwfnMLAm/og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=X17deeEc; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="X17deeEc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781028488; x=1781633288; i=markus.elfring@web.de;
	bh=aPFT5tpKtV1vnCpf8A2Cb4cBeYk/zZTv9ePoWv32Mzk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X17deeEcVJTKYScR2ueS/ey0s6TkoeXxn1f3Ir2DWeodAUZp/odwo+4rtx1hC+vj
	 qwle6/whbqBr+sAno0V0FAPzOVKZuEOp+zQfZ0nVEnpgiSV552XXUuGPImXJUZPP1
	 ua4+mHwb0cq1yXFsVVrvwweGdUvh6Eb5KYSe4Eq5Gj7CEaO+FDqL+x8I0oN0YzI09
	 Z2rWz6X/qHE6/7k0kc2y8L1d7yKaqa5TnmciXRgFTHNYWV3fEoCh4JVeUcPOdh8iT
	 WoSrpfKAE3Hz665VWvziJyHRiKvGiSRt9NhQwxHEVcyH06WeyADcLDzwwM0vOUN2D
	 90t+q5OcFnlLfX4ecQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoeY7-1x03Af36uf-00gnb3; Tue, 09
 Jun 2026 20:08:08 +0200
Message-ID: <b7440806-e9e8-4027-afe1-f6fe9297d8b2@web.de>
Date: Tue, 9 Jun 2026 20:08:05 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 Chia-I Wu <olvaffe@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/virtio: Use common error handling code in two functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ysu4JNB1LX9QaFKkc0f1ea/R8dyRnFlz7MtJfV693+8tpfwYgqF
 8sj1byjbCsDKd67NbGg5QSljmk3w2iZGQZ5vsn+bDkBCcjywn5oB07ZKHevVr3vOcfOs7KT
 2AkC0RDgynfhL2WBgzatyDkgQQu2dc9AFH5G7DizH2bD/vaOrLLuwITYIuYvB8Qxub6P22L
 hzcnxwa1LYZuNZmX4x/2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W1x/7L/ptoQ=;4pkbZeeO8nPlEYjq+KM0kvj1NQJ
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 9 Jun 2026 20:00:07 +0200

Use additional labels so that a bit of exception handling can be better
reused at the end of two function implementations.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/virtio/virtgpu_vq.c   |  7 +++----
 drivers/gpu/drm/virtio/virtgpu_vram.c | 16 ++++++++--------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/=
virtgpu_vq.c
index 67865810a2e7..05b19c73103a 100644
=2D-- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -318,15 +318,14 @@ static struct sg_table *vmalloc_to_sgt(char *data, u=
int32_t size, int *sg_ents)
=20
 	*sg_ents =3D DIV_ROUND_UP(size, PAGE_SIZE);
 	ret =3D sg_alloc_table(sgt, *sg_ents, GFP_KERNEL);
-	if (ret) {
-		kfree(sgt);
-		return NULL;
-	}
+	if (ret)
+		goto free_sgt;
=20
 	for_each_sgtable_sg(sgt, sg, i) {
 		pg =3D vmalloc_to_page(data);
 		if (!pg) {
 			sg_free_table(sgt);
+free_sgt:
 			kfree(sgt);
 			return NULL;
 		}
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virti=
o/virtgpu_vram.c
index 4ae3cbc35dd3..ec5b669fccfa 100644
=2D-- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -212,16 +212,12 @@ int virtio_gpu_vram_create(struct virtio_gpu_device =
*vgdev,
=20
 	/* Create fake offset */
 	ret =3D drm_gem_create_mmap_offset(obj);
-	if (ret) {
-		kfree(vram);
-		return ret;
-	}
+	if (ret)
+		goto free_vram;
=20
 	ret =3D virtio_gpu_resource_id_get(vgdev, &vram->base.hw_res_handle);
-	if (ret) {
-		kfree(vram);
-		return ret;
-	}
+	if (ret)
+		goto free_vram;
=20
 	virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params, NULL,
 					    0);
@@ -237,6 +233,10 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *=
vgdev,
=20
 	*bo_ptr =3D &vram->base;
 	return 0;
+
+free_vram:
+	kfree(vram);
+	return ret;
 }
=20
 void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
=2D-=20
2.54.0

