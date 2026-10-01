Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7128CF4A
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877677; cv=none; b=hSdN8ry1+xxIOlpdmg/DlVg8ubmY5rXwn76jNSRWYE9e/flZWFxMaOdEcFNf4Wa+c0SXby5JDvHcjy4/IcZGSLegbufMVV++EGlMkBGtXZDsghZhRXdwHy1iZFXc9thBMutsjYS5r30Wa42be+Amg2IC3DCGlP6wIVngKmxHFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877677; c=relaxed/simple;
	bh=d1j8gb2qOLMFZ82Cae3ZIiQgAGcCfTySYiTh6vo2Hv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=m8U4SP+kwbLkILhxdGlxVwwSnjKhub424Q07HiaLew5rf9yCUOKEcmj9lWQ+eoRzQtLqHDPbjDOA3OLe+IUU53ysjYWxKcmwbgxjTmBSo9AmEYAWI+wKnpJz8XB3uwf1wHIkfFF+deOsuzoDXkGE1SM1q5+jQTfGJi4Hd6iDTNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bbapBWYJ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bbapBWYJ"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261001180058euoutp0108c52bbec1e3f3bc4157fd01a2179693~aeb3x28HC1288412884euoutp01_
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 18:00:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261001180058euoutp0108c52bbec1e3f3bc4157fd01a2179693~aeb3x28HC1288412884euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790877658;
	bh=gQkTa+2Uo3OACPSQX7bm2CZcFqbnX/8IeP5vIuor0Ng=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bbapBWYJUKQjTryRXf/MRuhP70FKTNET3C7JuydO0RhWDbtk9NFm5LS9zt6LX+Bks
	 Ep0kL6J9rB3wKrZlaKM9iDYxmy0sxakZDPuJ7h3dAaFdEMUYSgLEHr8sTycz7o8kOq
	 bZHMHeZafFM7JBq1Hz2zbX6QU9PdIZ7+pSpSgJQI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261001180058eucas1p1506f92fdf0e1417404bb8025f181ae30~aeb3hNyDO1569615696eucas1p1G;
	Thu,  1 Oct 2026 18:00:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261001180056eusmtip29a2ceb3cd88b6599c4377c9182bfa693~aeb2LaVai0953409534eusmtip2H;
	Thu,  1 Oct 2026 18:00:56 +0000 (GMT)
Message-ID: <ce84d3d2-e78b-4939-aecf-9ef7267bd42a@samsung.com>
Date: Thu, 1 Oct 2026 20:00:56 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] drm/virtio: Add pixel blend mode property to cursor
 plane
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, oushixiong1025@163.com,
	David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter
	<simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, Shixiong Ou
	<oushixiong@kylinos.cn>, Ye Liu <liuye@kylinos.cn>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <c627ced6-1bdb-4508-b010-46df53eab2b3@collabora.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261001180058eucas1p1506f92fdf0e1417404bb8025f181ae30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261001180058eucas1p1506f92fdf0e1417404bb8025f181ae30
X-EPHeader: CA
X-CMS-RootMailID: 20261001180058eucas1p1506f92fdf0e1417404bb8025f181ae30
References: <20260828090123.784944-1-oushixiong1025@163.com>
	<c627ced6-1bdb-4508-b010-46df53eab2b3@collabora.com>
	<CGME20261001180058eucas1p1506f92fdf0e1417404bb8025f181ae30@eucas1p1.samsung.com>

On 20.09.2026 20:21, Dmitry Osipenko wrote:
> On 8/28/26 12:01, oushixiong1025@163.com wrote:
>> From: Shixiong Ou <oushixiong@kylinos.cn>
>>
>> The cursor plane exposes a format with an alpha channel
>> (DRM_FORMAT_ARGB8888) without a pixel blend mode property. Since
>> commit 860e748bddcc ("drm: ensure blend mode supported if pixel
>> format with alpha exposed") this triggers a warning during
>> drm_mode_config_validate():
>>
>> [    0.649020] ------------[ cut here ]------------
>> [    0.649040] [PLANE:36:plane-1] pixel format with alpha exposed but blend mode not setup
>> [    0.649081] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate
>> ......
>> [    0.649761] Call trace:
>> [    0.649764]  drm_mode_config_validate+0x398/0x558 [drm] (P)
>> [    0.649912]  drm_dev_register+0x1cc/0x2a0 [drm]
>> [    0.650058]  virtio_gpu_probe+0xd4/0x1c0 [virtio_gpu]
>> [    0.650088]  virtio_dev_probe+0x1c8/0x310
>> ......
>> [    0.650261] ---[ end trace 0000000000000000 ]---
>>
>>
>> Create the property with the only supported blend mode,
>> DRM_MODE_BLEND_PREMULTI, which is also the property's default and
>> matches what userspace had to assume before the property existed.
>>
>> Reported-by: Ye Liu <liuye@kylinos.cn>
>> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_plane.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> index 1d1b27ece62a..11771c943ea6 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>> @@ -24,6 +24,7 @@
>>   */
>>  
>>  #include <drm/drm_atomic_helper.h>
>> +#include <drm/drm_blend.h>
>>  #include <drm/drm_damage_helper.h>
>>  #include <drm/drm_fourcc.h>
>>  #include <drm/drm_gem_atomic_helper.h>
>> @@ -588,6 +589,7 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>>  	struct drm_plane *plane;
>>  	const uint32_t *formats;
>>  	int nformats;
>> +	int ret;
>>  
>>  	if (type == DRM_PLANE_TYPE_CURSOR) {
>>  		formats = virtio_gpu_cursor_formats;
>> @@ -610,5 +612,17 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>>  	if (type == DRM_PLANE_TYPE_PRIMARY)
>>  		drm_plane_enable_fb_damage_clips(plane);
>>  
>> +	if (type == DRM_PLANE_TYPE_CURSOR) {
>> +		/*
>> +		 * The cursor plane exposes a format with an alpha channel,
>> +		 * which requires a blend mode property. The host blends
>> +		 * premultiplied alpha, matching the property's default.
>> +		 */
>> +		ret = drm_plane_create_blend_mode_property(plane,
>> +							   BIT(DRM_MODE_BLEND_PREMULTI));
>> +		if (ret)
>> +			return ERR_PTR(ret);
>> +	}
>> +
>>  	return plane;
>>  }
> Applied to misc-fixes, thanks!


This duplicates commit f2e64f450c16 ("drm/virtio: create blend mode property on cursor
plane") merged a bit earlier, what in turn results in double call to
drm_plane_create_blend_mode_property() what confuses userspace (modetest tool crashes).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

