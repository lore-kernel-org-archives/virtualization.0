Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349D3CC9EC
	for <virtualization@lists.linux.dev>; Mon,  2 Mar 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459872; cv=pass; b=BZkjJrJv2KPmxrXcGHUrVfg9G0h8NBpA5HCJq7ElNAz+IymaJpr7I+2/xOWJN1QAYg4805My1lBQyWTDpgVpBWsCytCBBiPz4Of0yWAtdhcB9XVAHYyDoi2IpKLuVhQLEpMEx6mc5yxA4KAUB8i4gr1FFQcjQGsDxkgMM1LoDfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459872; c=relaxed/simple;
	bh=RNzBknGJC5Td2A3BAufOzh95nA+NKY45sl0tK/eDGrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgiIA4tEV/opkfzbnWmp4wGlBHD0wd6Chag9Kccesau513qWBwoiTqxNSVVC8LytzaDuAjNP7siPpcLXQ5lJ+d5Mkb1fXrV8JS/1ULIGcJQXAT3efiPr7SmX2WqdhGWKLvlPEq6G3zf8q6M34wdGW9zUUYyf87gnXd6IDwny37g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=DM1YpM4j; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="DM1YpM4j"
ARC-Seal: i=1; a=rsa-sha256; t=1772459859; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nl0zWHiWJPTznVpkoBeXtZlbKihjDHFVS+z7bMaN8eBvIu+guuvRrh3PhG443iR0g3zkMPLzeDy0blWj/c4p+d+gIO1C/d9SzB5nqPL4l2EZnlg8MykKp1DootoE+dez5WmmgMaNMVGBuSJ+pCqMMQah5/ATjx7tW8InuEVOCn4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772459859; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9S0tOwOFXfOQ/5Lgl0jiNTHxwVDxSUMtW8D+le7xJiY=; 
	b=C68wjgV6jF+wdWgchAPUlgVMR+ImcgZoCVuYTTvvWhzZWXp3scUCCEGb2y69AImlNB9A7myYdeWoaxIEzVYlVPUwUx5rcJ3+zWvKSpbihuDsyFI0AyQjLMjUejYvCo09NxX9xV9IGNUHBxBBTydkNtfCa5lpHX+ZoK2F1bRk7yA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772459859;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9S0tOwOFXfOQ/5Lgl0jiNTHxwVDxSUMtW8D+le7xJiY=;
	b=DM1YpM4jBTdt+AZ2gkz7tp7GoPniPVDugasyMp1TrHeRvuUlBtDBC53iQ14xobS8
	I7p6kmLTO9Cu5KRFLlwyY6G0m712biGKQmVBNutXaxVvR9xUnygil62dx7moz35h0ge
	eHLL4JgZmzJZR2/l6hzFwVLkM6139zJk8PP3tIAA=
Received: by mx.zohomail.com with SMTPS id 177245985757312.512892143685917;
	Mon, 2 Mar 2026 05:57:37 -0800 (PST)
Message-ID: <4fa6bc36-3507-4171-8955-29c90db9254b@collabora.com>
Date: Mon, 2 Mar 2026 16:57:32 +0300
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
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <5cdb4e34-7964-4456-9311-eac8b3d37371@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 3/2/26 16:48, Thomas Zimmermann wrote:
> Hi
> 
> Am 27.02.26 um 11:35 schrieb Hardik Phalet:
>> drm_simple_encoder_init() is a thin wrapper around drm_encoder_init()
>> that only provides a minimal drm_encoder_funcs instance with
>> .destroy = drm_encoder_cleanup.
>>
>> Inline the helper in virtgpu_display.c and provide a local
>> drm_encoder_funcs instance instead. This removes the unnecessary
>> indirection and prepares for the eventual removal of
>> drm_simple_encoder_init().
>>
>> No functional changes intended.
>>
>> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_display.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/
>> drm/virtio/virtgpu_display.c
>> index f1dae9569805..8bd6cdc6c16e 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_display.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_display.c
>> @@ -232,6 +232,10 @@ static enum drm_mode_status
>> virtio_gpu_conn_mode_valid(struct drm_connector *con
>>       return MODE_BAD;
>>   }
>>   +static const struct drm_encoder_funcs virtio_gpu_enc_cleanup_funcs = {
>> +    .destroy = drm_encoder_cleanup
>> +};
>> +
>>   static const struct drm_encoder_helper_funcs
>> virtio_gpu_enc_helper_funcs = {
>>       .mode_set   = virtio_gpu_enc_mode_set,
>>       .enable     = virtio_gpu_enc_enable,
>> @@ -306,7 +310,8 @@ static int vgdev_output_init(struct
>> virtio_gpu_device *vgdev, int index)
>>       if (vgdev->has_edid)
>>           drm_connector_attach_edid_property(connector);
>>   -    drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
>> +    drm_encoder_init(dev, encoder, &virtio_gpu_enc_cleanup_funcs,
>> +             DRM_MODE_ENCODER_VIRTUAL, NULL);
> 
> This looks correct, but you should also remove the include statement at [1]
> 
> [1] https://elixir.bootlin.com/linux/v6.19/source/drivers/gpu/drm/
> virtio/virtgpu_display.c#L35

The patch adds more lines than removes. What's wrong with
drm_simple_encoder_init() and why it needs to be removed eventually?

-- 
Best regards,
Dmitry
