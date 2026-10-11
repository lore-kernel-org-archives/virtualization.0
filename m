Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00AB4499B0
	for <virtualization@lists.linux.dev>; Sun, 11 Oct 2026 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791756262; cv=pass; b=aoN5LsSMtzHc8XnBYoVa4N4L84puBLA4nVV7mUgGNMjjTB4zvRCT383m7XwWJ5yLKoEBrZLK0T2HwgUppBPKcKBizOXkF/jP0DlCh/QuvBCmh/VPjP3gNMfIxToiBbcXVtZQ/aVdn7dhbjr3M6OuzLNcg2ewLseoziSj0A2dXeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791756262; c=relaxed/simple;
	bh=7UPp9ElkGnZalsMH/5actDI6CxXZr0lhP963YES1Dqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFCRWXu8jFzLQfnBVmOI0gPCBf7G1Air012mLpZoLCSmJMh5bnhnWixq6+RorT37qrRmXXZ0ydjvfmi9OmomTdBob2f/C4XkQtjn1XmV0TrHXbelPLXDk0KiZWjkFoI35htX5cFasgnRg1LAqYpHvg3tXa/rjqcPbXlgaUbC+DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ivhPQ/0N; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ivhPQ/0N"
ARC-Seal: i=1; a=rsa-sha256; t=1791756245; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XBGn0EDiYLl2ayemR909LBeoVeG4BdqbgPbug6BE2YDLi4qdojAkJjOVsECwylTRN8bgJKbIj1IZix1be3boaFrCyffPZvxyZrcHif4cofQVryIe/SVV2pMk5MYf3Xau6FxiLGh+yb211yqLCwyx1isZrFO+yaF020a84blHPJc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791756245; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nCzvftucFk6WSAIfrGo74dUEjckzzf0Uo1ODZeMVfTo=; 
	b=YgTA7zWhjYvHNFjzFGXCFMih5yaH5SMU9/n/N4ZDvM1aacmOLwyUg77tdZWIjrvPOkDvSXJHXh4+VezUld0gS3mz90WBSnE4F3ya3Nsg7it0Z9L1PiXbESSMyM1Wmt/NaoW3Y4Nc60oKHufw5Y6R7gk+frzZ4T+OhnHA61ZofZk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791756245;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nCzvftucFk6WSAIfrGo74dUEjckzzf0Uo1ODZeMVfTo=;
	b=ivhPQ/0N5acPf1VXsyY1WmGHwLXFfthSlusOrjJzvFQIyJqkf9z/cLlkACyPsapR
	tz1f6OmP6GQ0VYTMR1X28PXbR8gdIwgFagIq3j4fbXfDcki846JFZuS5pQDG1Pv86LB
	iSk+0r5u4dTG72UuNQLaaQXE33VwJmKir8n7Tg4c=
Received: by smtp.zohomail.com with SMTPS id 1791756244116211.11807230278964;
	Sun, 11 Oct 2026 15:04:04 -0700 (PDT)
Message-ID: <cd9e6f0f-808d-4aa3-992b-e1d0af833175@collabora.com>
Date: Mon, 12 Oct 2026 01:04:00 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Revert "drm/virtio: Add pixel blend mode property to
 cursor plane"
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261007222244.295186-1-dmitry.osipenko@collabora.com>
 <CGME20261008093604eucas1p1857ec36ab7da379e75cb5f8bb993b1b6@eucas1p1.samsung.com>
 <dae2c4c1-0b60-4975-83d6-924d5255db94@collabora.com>
 <64f7ea95-516f-4b95-a42e-14fd606879f9@samsung.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <64f7ea95-516f-4b95-a42e-14fd606879f9@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/8/26 12:40, Marek Szyprowski wrote:
> On 08.10.2026 11:35, Dmitry Osipenko wrote:
>> On 10/8/26 01:22, Dmitry Osipenko wrote:
>>> The cursor blending mode was added twice because the same change was
>>> applied by accident from different patches. Revert the second patch.
>>>
>>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Link: https://lore.kernel.org/dri-devel/ce84d3d2-e78b-4939-aecf-9ef7267bd42a@samsung.com/
>>> Fixes: 6947b78df4d2 ("drm/virtio: Add pixel blend mode property to cursor plane")
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>  drivers/gpu/drm/virtio/virtgpu_plane.c | 13 -------------
>>>  1 file changed, 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
>>> index b422eba42a5f..640815af4098 100644
>>> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
>>> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
>>> @@ -589,7 +589,6 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>>>  	struct drm_plane *plane;
>>>  	const uint32_t *formats;
>>>  	int nformats;
>>> -	int ret;
>>>  
>>>  	if (type == DRM_PLANE_TYPE_CURSOR) {
>>>  		formats = virtio_gpu_cursor_formats;
>>> @@ -615,17 +614,5 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
>>>  		drm_plane_create_blend_mode_property(plane,
>>>  						     BIT(DRM_MODE_BLEND_PREMULTI));
>>>  
>>> -	if (type == DRM_PLANE_TYPE_CURSOR) {
>>> -		/*
>>> -		 * The cursor plane exposes a format with an alpha channel,
>>> -		 * which requires a blend mode property. The host blends
>>> -		 * premultiplied alpha, matching the property's default.
>>> -		 */
>>> -		ret = drm_plane_create_blend_mode_property(plane,
>>> -							   BIT(DRM_MODE_BLEND_PREMULTI));
>>> -		if (ret)
>>> -			return ERR_PTR(ret);
>>> -	}
>>> -
>>>  	return plane;
>>>  }
>> Marek, could you please give your r-b?
> 
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks, applied to misc-fixes

-- 
Best regards,
Dmitry
