Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6631FF1AE
	for <virtualization@lists.linux.dev>; Wed, 11 Feb 2026 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770852982; cv=pass; b=T56sUTbso/vmhzfUvPUnwVPv+DmebF46mxBqsFEybW+4++O7JiT/5ZJWJXP9Jj+6SKAjU5QjSUrfCCue0i9F1h66ug5UxerJS0/d4CndbwS5n2yFi2GCDPJZL3sukAgtcKuouNGl2RfsFXK0RegISx/IG+LIf9+FMSLJ0nSFblw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770852982; c=relaxed/simple;
	bh=swXIi7Mz1r4WpX+n2ID5G7/wAbjrRptgElekjbPUyEk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O82Uhb2s4Jrgg58YA7O1tSdYjvhhLe77xHr1ZEHYEgvyy2cRGJP9jyCyqrtuwdThg5+FZhoIaIwxrO3bIBh/Ti0fsbVDUJ1TjclvVxI1FXUxdnz+2/gMBJSeVSuu3ukUEwo2kO2ekWqfMtoCsJcwiRbgguxjVpPkHinJfH8MJV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=UnzV3fwd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="UnzV3fwd"
ARC-Seal: i=1; a=rsa-sha256; t=1770852967; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b7TeAgBvOkPhQZuu0FxXmM4SYQf8W+TvazFZQkMLrvNCwd9b7HiUjh4ufjCaq7xGy6oIditvg5CXhNlgl1S3OXDUvhD6Gsbybdj8T1vdidctYApI2fyg5ln9DERACErw7Gzc4jj0c4kfApTmlZFGH7RGeUdQpepFb1FzjIHoJ4w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770852967; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NuDprhfp0CipY6Sg+IILW80aGPA17nB5ISnMg3x56Ak=; 
	b=GA1RrGrcmA75x/E2ezH7eRMuXiQkMhtLcQ1l9tVcHgzETTh1cvJtWIkXpRhfMRBG6MeIB+Bb+lyVcjkXzuMkg5OI2t/9D4EofXQapB7DV3SP5OhmpxA6ROcBCRuY0fi+SbZnQvJUM0Xdfxn+mvWeGh5Ft63IkqpGFP3sqdzIlMo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770852967;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NuDprhfp0CipY6Sg+IILW80aGPA17nB5ISnMg3x56Ak=;
	b=UnzV3fwdzMrI7UludT0TFpSJGgHjk5zhvvafsVGFlq5xfPzx4C/uQBvtcTjMqrpb
	MrbTLtYzOCMhUL9AaboKWqPlYMnNB8yFQeHsD388l5PsCMUknDtpbZFUErgTcYHa5SD
	A4rbyTZDU5+r/spYh2TJXwuY2WawHT106CtvLADQ=
Received: by mx.zohomail.com with SMTPS id 1770852966508980.015296459701;
	Wed, 11 Feb 2026 15:36:06 -0800 (PST)
Message-ID: <c00ef6a9-cb27-456a-b3c2-81856f4cb56d@collabora.com>
Date: Thu, 12 Feb 2026 02:35:59 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: Allow importing prime buffers when 3D is
 enabled
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Val Packett <val@invisiblethingslab.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 Christian Koenig <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251210154755.1119861-2-val@invisiblethingslab.com>
 <b871f1d3-7a38-4f02-ac7a-7b8db188f464@collabora.com>
Content-Language: en-US
In-Reply-To: <b871f1d3-7a38-4f02-ac7a-7b8db188f464@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 2/12/26 01:58, Dmitry Osipenko wrote:
> On 12/10/25 18:39, Val Packett wrote:
>> This functionality was added for using a KMS-only virtgpu with a physical
>> (or SR-IOV) headless GPU in passthrough, but it should not be restricted
>> to KMS-only mode. It can be used with cross-domain to pass guest memfds
>> to the host compositor with zero copies (using udmabuf on both sides).
>>
>> Drop the check for the absence of virgl_3d to allow for more use cases.
>>
>> Fixes: ca77f27a2665 ("drm/virtio: Import prime buffers from other devices as guest blobs")
>> Signed-off-by: Val Packett <val@invisiblethingslab.com>
>> ---
>>
>> Hi. I couldn't find any comments on that line in the reviews (on patchwork), so I assume
>> there was never a specific technical reason for that check, just an abundance of caution?
>>
>> BTW, while here.. The drm_gem_prime_import "fallback" seems pretty much equivalent to
>> `return (-ENODEV)`, as drm_gem_prime_import(_dev) just translates the call to
>> gem_prime_import_sg_table which we don't use. Should it be replaced with `return (-ENODEV)`?
>>
>> ---
>>  drivers/gpu/drm/virtio/virtgpu_prime.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
>> index ce49282198cb..2fedd5d3bd62 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
>> @@ -312,7 +312,7 @@ struct drm_gem_object *virtgpu_gem_prime_import(struct drm_device *dev,
>>  		}
>>  	}
>>  
>> -	if (!vgdev->has_resource_blob || vgdev->has_virgl_3d)
>> +	if (!vgdev->has_resource_blob)
>>  		return drm_gem_prime_import(dev, buf);
>>  
>>  	bo = kzalloc(sizeof(*bo), GFP_KERNEL);
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Applied to misc-next, thanks

-- 
Best regards,
Dmitry
