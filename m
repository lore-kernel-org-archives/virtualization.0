Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4537547A888
	for <virtualization@lists.linux.dev>; Fri,  2 Oct 2026 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936814; cv=pass; b=FBCz6Aq0xtQzhnkTfXksfOE6mjvxh2U9kDqSqJWLAJCrw7sTHFm642MdTVLRb+JHc0f39tXvdeoQ/JOcqsi3E0RNJ3yf+xPlI616aUlp5BVxbrIDckXXAKTaBY5YxoNAyNOMoDxXLIeQcDyjgxjNFRDj+3jkVMKKxZ3iXM3sslc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936814; c=relaxed/simple;
	bh=Jx2YFVYAK3NHsrbqjziZ7rmPEJEJs7eMxRSPDYoiDUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhYFQsoGzHCXMACoZoj/PpMl0ut4ytSATFewVZlBStRF0vZE+ZhcGnazNpKqExriETG1Zgr5mTRCeuOuHBUGLIZ9mFWtPTwku04L07FRGrnqsqvmGQaDlzkRPqHZLDEYgyWmNv9hbxhZCnDza2xLykJ2/eIPr64W2QsuGHYBr5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=GQnxE8bO; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="GQnxE8bO"
ARC-Seal: i=1; a=rsa-sha256; t=1790936797; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D3im91SJq5ZGscs2Smeb+uOrOJX+UttklDSNpfQ48AnDQZyGSIr3pvX8EZsNkbEx2JT+FDjZltUsBNyZZ1KrzP/FsBkiPaXRLBlsxydnqOPFDTYbA5UEGJWI/wmz/mjf/unS0/iiGHd8tJPekqRi+Dmj+rFBGEZOTY4jNxoho3g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790936797; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WTa1Ybsrqm/t55pYEzCBO6zMyb2xeOEIRuOtsv1husQ=; 
	b=JCQca65d3u996+sxNW2u7pazr+vBW9qRtVxJ6NMSEtcr0YP17x71KUUGRRPoY8unyie8P/8LM60cCovcL3iPkyf8jdBuMGv+JYfexe/iLV4GvshseSYXLbRAz/jPCmt2YJ7x054JBr8FtjDws85lgydn7brr2RJwUckGudEiHy0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790936797;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=WTa1Ybsrqm/t55pYEzCBO6zMyb2xeOEIRuOtsv1husQ=;
	b=GQnxE8bOT1RGx0TsVEGFsFtVPBms08WtJ8XXh8+PDlasZESRE7P0UikMzymc3utO
	VASqezhg1btvbmpALs1cu+rhKNg0J90YHkJbYr92Mrj/zuvFEE02l3Z6VqrCiPA1rge
	iwanfTNsPnArqJzFDwm9pvQbK0IAjR3fc48Pcd5A=
Received: by smtp.zohomail.com with SMTPS id 1790936796927284.6379734282733;
	Fri, 2 Oct 2026 03:26:36 -0700 (PDT)
Message-ID: <c6f77d41-fea9-4eae-b680-b03164efe866@collabora.com>
Date: Fri, 2 Oct 2026 13:26:31 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Add pixel blend mode property to cursor plane
To: Marek Szyprowski <m.szyprowski@samsung.com>, oushixiong1025@163.com,
 David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>, Ye Liu <liuye@kylinos.cn>
References: <20260828090123.784944-1-oushixiong1025@163.com>
 <c627ced6-1bdb-4508-b010-46df53eab2b3@collabora.com>
 <CGME20261001180058eucas1p1506f92fdf0e1417404bb8025f181ae30@eucas1p1.samsung.com>
 <ce84d3d2-e78b-4939-aecf-9ef7267bd42a@samsung.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ce84d3d2-e78b-4939-aecf-9ef7267bd42a@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/1/26 21:00, Marek Szyprowski wrote:
> On 20.09.2026 20:21, Dmitry Osipenko wrote:
>> On 8/28/26 12:01, oushixiong1025@163.com wrote:
>>> From: Shixiong Ou <oushixiong@kylinos.cn>
>>>
>>> The cursor plane exposes a format with an alpha channel
>>> (DRM_FORMAT_ARGB8888) without a pixel blend mode property. Since
>>> commit 860e748bddcc ("drm: ensure blend mode supported if pixel
>>> format with alpha exposed") this triggers a warning during
>>> drm_mode_config_validate():
>>>
>>> [    0.649020] ------------[ cut here ]------------
>>> [    0.649040] [PLANE:36:plane-1] pixel format with alpha exposed but blend mode not setup
>>> [    0.649081] WARNING: drivers/gpu/drm/drm_mode_config.c:872 at drm_mode_config_validate
>>> ......
>>> [    0.649761] Call trace:
>>> [    0.649764]  drm_mode_config_validate+0x398/0x558 [drm] (P)
>>> [    0.649912]  drm_dev_register+0x1cc/0x2a0 [drm]
>>> [    0.650058]  virtio_gpu_probe+0xd4/0x1c0 [virtio_gpu]
>>> [    0.650088]  virtio_dev_probe+0x1c8/0x310
>>> ......
>>> [    0.650261] ---[ end trace 0000000000000000 ]---
>>>
>>>
>>> Create the property with the only supported blend mode,
>>> DRM_MODE_BLEND_PREMULTI, which is also the property's default and
>>> matches what userspace had to assume before the property existed.
>>>
>>> Reported-by: Ye Liu <liuye@kylinos.cn>
>>> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_plane.c | 14 ++++++++++++++
>>>  1 file changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
>>> index 1d1b27ece62a..11771c943ea6 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>>> @@ -24,6 +24,7 @@
>>>   */
>>>  
>>>  #include <drm/drm_atomic_helper.h>
>>> +#include <drm/drm_blend.h>
>>>  #include <drm/drm_damage_helper.h>
>>>  #include <drm/drm_fourcc.h>
>>>  #include <drm/drm_gem_atomic_helper.h>
>>> @@ -588,6 +589,7 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>>>  	struct drm_plane *plane;
>>>  	const uint32_t *formats;
>>>  	int nformats;
>>> +	int ret;
>>>  
>>>  	if (type == DRM_PLANE_TYPE_CURSOR) {
>>>  		formats = virtio_gpu_cursor_formats;
>>> @@ -610,5 +612,17 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>>>  	if (type == DRM_PLANE_TYPE_PRIMARY)
>>>  		drm_plane_enable_fb_damage_clips(plane);
>>>  
>>> +	if (type == DRM_PLANE_TYPE_CURSOR) {
>>> +		/*
>>> +		 * The cursor plane exposes a format with an alpha channel,
>>> +		 * which requires a blend mode property. The host blends
>>> +		 * premultiplied alpha, matching the property's default.
>>> +		 */
>>> +		ret = drm_plane_create_blend_mode_property(plane,
>>> +							   BIT(DRM_MODE_BLEND_PREMULTI));
>>> +		if (ret)
>>> +			return ERR_PTR(ret);
>>> +	}
>>> +
>>>  	return plane;
>>>  }
>> Applied to misc-fixes, thanks!
> 
> 
> This duplicates commit f2e64f450c16 ("drm/virtio: create blend mode property on cursor
> plane") merged a bit earlier, what in turn results in double call to
> drm_plane_create_blend_mode_property() what confuses userspace (modetest tool crashes).
Good catch, will revert this patch. Thanks!

-- 
Best regards,
Dmitry
