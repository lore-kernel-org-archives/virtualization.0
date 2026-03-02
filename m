Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DF277017
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465494; cv=pass; b=i1znsfWs2/saJWk1jIsJTa7cwZ/if3TBO8C2teRYM1Gg6QdrolkFxThO/hDGKVy1euM+z9dVEl0wL4TTD+wedx+kuPCDgHCth05H/NYR0qXP0QROkk7EeUh1bmmY2XPfBfszRJc+YV32a4T1a+x2OpeFeL1620lzJSDjlJLOEN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465494; c=relaxed/simple;
	bh=bsngZWlL9G2kEqOQSjJ/Eu/yY+Ehaq+Jh51IS1Fy0qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eM0zPHkJWbA1JVlWa3NupsJXFcB4TCjaWbhG8EZ/mPnyB9sEYwNrRt34mQ4arSHWX05IcsXzGjOys0ikjELX8mdpES0Hb47z02dPbu0vmtVjvdF9EjSqP/WtbxHVUDwcShRXbGg9KF7m6/BIKRTSvu71Pz4OfsXhTypZiZ5llZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Pxe2V95B; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Pxe2V95B"
ARC-Seal: i=1; a=rsa-sha256; t=1772465474; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WR6scvr9p/S5ObbSRZawvUKaqAQWdOPo0sfAJB1I0pQ2eMCQQ6ybGsFTHeCQZw8ci8PeZ+lMjtauukuSamLzk/pXsGwwZcYLUzrV4hpD2rMf1MTn8lBft3PbINp5yD1t070mPuRKlW//sXJYg2XDSu6OAkWuU6SDHMVI+F+wfBI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772465474; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QPQ7UF8YWdWeJxx5Wa+6PvK2WVcZGfs+L5dNcsKqJ4s=; 
	b=NVzz3+2t5esyrrCTuZKveU9/hXZ9+U2+4JNOB/vedtmd/Par1cYLLPdGH+z+xl0MxpYPhBi9oDGwLx31qgQ1NgJzHbzyx7tWvHSPHPeBQPR2/RSI18+MD+zzWtkl05QMNyaIj/XnlFuZfNX7ideFFwP/EYnIKmwYNxR2SOe/bug=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772465474;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QPQ7UF8YWdWeJxx5Wa+6PvK2WVcZGfs+L5dNcsKqJ4s=;
	b=Pxe2V95BeHlqSpVCTrhebOQTra522Kvo+Mo0WB9/qorbJ8AVpM6YYvzANccGWy0w
	EaC1vnSIelrUiJ5YK0Rb+jgvbGPJwR/tieTBGdE5pruQ1RDTMv/kAbMwsy5OGf3KnSf
	th8mLhJuGrOzdJEv5BbdaoJ/XQyapIdYHmUtH9cc=
Received: by mx.zohomail.com with SMTPS id 1772465472560905.9229040614745;
	Mon, 2 Mar 2026 07:31:12 -0800 (PST)
Message-ID: <e008ca24-83ee-427e-b2a2-8f93e390b199@collabora.com>
Date: Mon, 2 Mar 2026 18:31:08 +0300
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
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <cf8cb929-2339-46a9-8b76-e76778787b9d@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 3/2/26 17:15, Thomas Zimmermann wrote:
> Hi
> 
> Am 02.03.26 um 14:57 schrieb Dmitry Osipenko:
>> On 3/2/26 16:48, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 27.02.26 um 11:35 schrieb Hardik Phalet:
>>>> drm_simple_encoder_init() is a thin wrapper around drm_encoder_init()
>>>> that only provides a minimal drm_encoder_funcs instance with
>>>> .destroy = drm_encoder_cleanup.
>>>>
>>>> Inline the helper in virtgpu_display.c and provide a local
>>>> drm_encoder_funcs instance instead. This removes the unnecessary
>>>> indirection and prepares for the eventual removal of
>>>> drm_simple_encoder_init().
>>>>
>>>> No functional changes intended.
>>>>
>>>> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
>>>> ---
>>>>    drivers/gpu/drm/virtio/virtgpu_display.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/
>>>> drm/virtio/virtgpu_display.c
>>>> index f1dae9569805..8bd6cdc6c16e 100644
>>>> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
>>>> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
>>>> @@ -232,6 +232,10 @@ static enum drm_mode_status
>>>> virtio_gpu_conn_mode_valid(struct drm_connector *con
>>>>        return MODE_BAD;
>>>>    }
>>>>    +static const struct drm_encoder_funcs
>>>> virtio_gpu_enc_cleanup_funcs = {
>>>> +    .destroy = drm_encoder_cleanup
>>>> +};
>>>> +
>>>>    static const struct drm_encoder_helper_funcs
>>>> virtio_gpu_enc_helper_funcs = {
>>>>        .mode_set   = virtio_gpu_enc_mode_set,
>>>>        .enable     = virtio_gpu_enc_enable,
>>>> @@ -306,7 +310,8 @@ static int vgdev_output_init(struct
>>>> virtio_gpu_device *vgdev, int index)
>>>>        if (vgdev->has_edid)
>>>>            drm_connector_attach_edid_property(connector);
>>>>    -    drm_simple_encoder_init(dev, encoder,
>>>> DRM_MODE_ENCODER_VIRTUAL);
>>>> +    drm_encoder_init(dev, encoder, &virtio_gpu_enc_cleanup_funcs,
>>>> +             DRM_MODE_ENCODER_VIRTUAL, NULL);
>>> This looks correct, but you should also remove the include statement
>>> at [1]
>>>
>>> [1] https://elixir.bootlin.com/linux/v6.19/source/drivers/gpu/drm/
>>> virtio/virtgpu_display.c#L35
>> The patch adds more lines than removes. What's wrong with
>> drm_simple_encoder_init() and why it needs to be removed eventually?
> 
> I added it myself a few years ago in an attempt to save some lines of
> code. That was a mistake. It's a helper without any purpose. Helpers
> should do something.

It saves few lines and makes code easier to read. Don't see value in
removal of the helper.

-- 
Best regards,
Dmitry
