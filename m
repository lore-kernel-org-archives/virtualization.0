Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19451372EEF
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772581919; cv=pass; b=oA0jDSM7SH+reAitAS2d76iyIGSiOk+jZyBumQ7ZdBG+oI9oBLf8lhPrDlijDOFoKVBGoXy4na1wVZljj4L182hMtUnSqITRV8kDOdoGHLLD0adLbVB09Zde6sq5XaVm4vKHk/o34HDyzSFpLH9cwJJkovGTtoBdEtDlcGf5IBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772581919; c=relaxed/simple;
	bh=aLUgPCew+HGAcZyC6poHY+NyEUkIlPepyMaaElTqvHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CD6nB7W2DT2pwLBd1x79sJrSa+0M2ya8oxCoKKaQGMnsiKjPjEZxQXhCSbaTGhoBVVy1UW1kRm+S7v1MsrPMC44LXyGZ2zhJkgejk/kYdEecSDJzT6XEoD+pCx5FKMV6osxSYfwjKrbqBK6qqirFUdNVGjtz5/W/xM8FsoXomU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ZhZDh+nh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ZhZDh+nh"
ARC-Seal: i=1; a=rsa-sha256; t=1772581904; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q80XbsvtuVAQsmFPuoq/6zr+/oK7Kf9YFQSawVzzJqOIK0/QQlx3lAoqQS2VsfjazsCpgQUxFpBtxyRY46IIqQICgk/kfW799LU9+fk+aNjoaO+CVMaxLzQFNgoChFeZRaRPihen87XxzPKLcn2o3UVcZJajPCrG5aD9FBorjG0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772581904; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XVXWwjOao24+lehwACLHpjLtJk6m5zyKvGu/1VnP2Ro=; 
	b=jR5xnu+5iOu/s/rye5FtNmyVb/NCoYoC7vJsXzdMn0uhwcsc3X4WCJwvOh+EvJp0tNy85+Z4XHPCxVyAeTdmdUirnRJuuTzvQgQvxljmfUv2D4N4/0+33wCAoDR/xqT1kGaENe8bALQCqagHhazZ9BQ+GkzDbEwwauY7iu4wkkI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772581904;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XVXWwjOao24+lehwACLHpjLtJk6m5zyKvGu/1VnP2Ro=;
	b=ZhZDh+nhogEqNukm2fVZGCwX3nh7S1ezt/6mSsyl5dCyaZutN0+wyC2x5wmjC7ms
	4ysVKXgL5JaSsEPeJGGHvq8MoBgrou8/AhRzZcgLcvWfl42QxP3EMkO8cM8HhMPnH+6
	326gw+Pla8ttc6dB7Q2GhUKJiPePcj48/gZRyFcU=
Received: by mx.zohomail.com with SMTPS id 1772581903106480.1003236269638;
	Tue, 3 Mar 2026 15:51:43 -0800 (PST)
Message-ID: <7f9c5d89-68a7-4c52-b214-56197cd5ad9c@collabora.com>
Date: Wed, 4 Mar 2026 02:51:32 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Open-code drm_simple_encoder_init()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Hardik Phalet <hardik.phalet@pm.me>
Cc: Hardik Phalet <hardik.phalet@gmail.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260227103515.413685-1-hardik.phalet@pm.me>
 <5cdb4e34-7964-4456-9311-eac8b3d37371@suse.de>
 <4fa6bc36-3507-4171-8955-29c90db9254b@collabora.com>
 <cf8cb929-2339-46a9-8b76-e76778787b9d@suse.de>
 <e008ca24-83ee-427e-b2a2-8f93e390b199@collabora.com>
 <83824dfb-dbde-4466-bb5d-3fb4348dca6e@suse.de>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <83824dfb-dbde-4466-bb5d-3fb4348dca6e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 3/2/26 18:40, Thomas Zimmermann wrote:
> 
> 
> Am 02.03.26 um 16:31 schrieb Dmitry Osipenko:
>> On 3/2/26 17:15, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 02.03.26 um 14:57 schrieb Dmitry Osipenko:
>>>> On 3/2/26 16:48, Thomas Zimmermann wrote:
>>>>> Hi
>>>>>
>>>>> Am 27.02.26 um 11:35 schrieb Hardik Phalet:
>>>>>> drm_simple_encoder_init() is a thin wrapper around drm_encoder_init()
>>>>>> that only provides a minimal drm_encoder_funcs instance with
>>>>>> .destroy = drm_encoder_cleanup.
>>>>>>
>>>>>> Inline the helper in virtgpu_display.c and provide a local
>>>>>> drm_encoder_funcs instance instead. This removes the unnecessary
>>>>>> indirection and prepares for the eventual removal of
>>>>>> drm_simple_encoder_init().
>>>>>>
>>>>>> No functional changes intended.
>>>>>>
>>>>>> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
>>>>>> ---
>>>>>>     drivers/gpu/drm/virtio/virtgpu_display.c | 7 ++++++-
>>>>>>     1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/
>>>>>> drm/virtio/virtgpu_display.c
>>>>>> index f1dae9569805..8bd6cdc6c16e 100644
>>>>>> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
>>>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
>>>>>> @@ -232,6 +232,10 @@ static enum drm_mode_status
>>>>>> virtio_gpu_conn_mode_valid(struct drm_connector *con
>>>>>>         return MODE_BAD;
>>>>>>     }
>>>>>>     +static const struct drm_encoder_funcs
>>>>>> virtio_gpu_enc_cleanup_funcs = {
>>>>>> +    .destroy = drm_encoder_cleanup
>>>>>> +};
>>>>>> +
>>>>>>     static const struct drm_encoder_helper_funcs
>>>>>> virtio_gpu_enc_helper_funcs = {
>>>>>>         .mode_set   = virtio_gpu_enc_mode_set,
>>>>>>         .enable     = virtio_gpu_enc_enable,
>>>>>> @@ -306,7 +310,8 @@ static int vgdev_output_init(struct
>>>>>> virtio_gpu_device *vgdev, int index)
>>>>>>         if (vgdev->has_edid)
>>>>>>             drm_connector_attach_edid_property(connector);
>>>>>>     -    drm_simple_encoder_init(dev, encoder,
>>>>>> DRM_MODE_ENCODER_VIRTUAL);
>>>>>> +    drm_encoder_init(dev, encoder, &virtio_gpu_enc_cleanup_funcs,
>>>>>> +             DRM_MODE_ENCODER_VIRTUAL, NULL);
>>>>> This looks correct, but you should also remove the include statement
>>>>> at [1]
>>>>>
>>>>> [1] https://elixir.bootlin.com/linux/v6.19/source/drivers/gpu/drm/
>>>>> virtio/virtgpu_display.c#L35
>>>> The patch adds more lines than removes. What's wrong with
>>>> drm_simple_encoder_init() and why it needs to be removed eventually?
>>> I added it myself a few years ago in an attempt to save some lines of
>>> code. That was a mistake. It's a helper without any purpose. Helpers
>>> should do something.
>> It saves few lines and makes code easier to read. Don't see value in
>> removal of the helper.
> 
> All it does is to set a default cleanup function. But that's not even
> clear from the helper's name.
> 
> If we really want a default cleanup, we should call
> drm_encoder_cleanup() as a default at [1]. Drivers could then just leave
> out the encoder funcs entirely.
> 
> [1] https://elixir.bootlin.com/linux/v6.19/source/drivers/gpu/drm/
> drm_mode_config.c#L530

There are a lot of drivers using drm_simple_encoder_init() in kernel.
What problem the default cleanup function creates? If none, to me the
drm_simple_encoder_init() serves its purpose, improving the drivers'
code. I won't object much if you'll insist on merging the patch, but so
far it looks like a very bikeshed change without a clear explanation of
the solved problem.

-- 
Best regards,
Dmitry
