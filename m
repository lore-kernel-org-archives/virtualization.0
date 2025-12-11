Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F7B18FDDB
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 04:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765429162; cv=pass; b=htkrQcoQwQY9VaAWWCUJlHQ9eQUxgwQJB2g/GT7tjXjtJ+5XlTjXk6M06N+d2E3d7jtdzQAIILCwGFfJatGAgf8wNezY7ap9qeDLmS73jEkyNc5rIT7ZphnO8/0exW0GylB/MSR/x+MjTi/l5dbx9A1TLFYAtpE05QxctkKeQEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765429162; c=relaxed/simple;
	bh=9Wr8elOShctkOD9AqVLPgycqaZObJzFqDnlh4FRkYvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABPSs+GrQ5hZ/2atFy7Pi2dksDh7H7zLuPpFsAf3wbRQ9n0GfFqB4lfIfsws60SWBfjRA6Pc2o9kNXhIdeVAydNbxkVh4Ekr5AiZJun3R1s3J3kCg55Vhqb8j3NmUR5HSwdbSFClG97xy+gfQNIKE9raVt4JjG0bHVsYb83Zqm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=HY3aHcLR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="HY3aHcLR"
ARC-Seal: i=1; a=rsa-sha256; t=1765429147; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mpRRoGYWy0CaWZFxvKQ2CXqkwG07kRC8GtCV/AV39794kpUk/tR/uWAr7a/I+YSCBVnWiWn2/LfUKVONQJuZbV/sGFvkKj8wohVH5zksSP+J5IZjO1ncRBOGQfGYGHbz+08PUOiQmB86Iy0DJzAeNGg3If9Ef9Cn0/LwIIUmB84=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765429147; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qwwDK7ES44/mxuRZWvi5JZL/SkS9OB3I5PC49lDpPF4=; 
	b=ldPbMMhVfRjkxcYRy7uIyhLia/OUNKBJjgDGFkw143Hs2tx/zo/hTWTr7Vp45RW7hZsdPia/vaiaglExsdFsMrRS1vJAqMHuDU8n/8pbtBCTED6r2P6hHiWxH0T7Kn/gxvnD0p1gm3xL2eWf27tC+o+JEtjhDiRG+M7X7okuGbg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765429146;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qwwDK7ES44/mxuRZWvi5JZL/SkS9OB3I5PC49lDpPF4=;
	b=HY3aHcLRkXFX9kMvwxviOrWM3TP/YIhH5U0oxpPcMzIS93U7mYJzJKXTmltT7Bxe
	4tgInjqY+T8a8s8lAhEedR6Cg0SKFpmJjK/+VrK4Vww5Q4RQvmqRQ5QPh52lcSwZl8Y
	Lq5TCDJCUXe8mdsaFqnMFfPovjO6QJsEixiI1fZk=
Received: by mx.zohomail.com with SMTPS id 1765429145328519.7374459440082;
	Wed, 10 Dec 2025 20:59:05 -0800 (PST)
Message-ID: <61a12a08-86bf-498f-8e3e-a49a91c1bbd1@collabora.com>
Date: Thu, 11 Dec 2025 07:58:57 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: fix undefined behavior in capset shift
 calculation
To: Alexey Simakov <bigalex934@gmail.com>, David Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Lingfeng Yang <lfy@google.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20251208160228.13145-1-bigalex934@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251208160228.13145-1-bigalex934@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 12/8/25 19:02, Alexey Simakov wrote:
> According to MAX_CAPSET_ID, possible values of vgdev->capsets[i].id
> range from 0 to 63. Since the intermediate calculation uses type int,
> shifting by values larger than the bit width of int is undefined
> behavior as per the C language standard.
> 
> Explicitly cast the left-shift operand to ULL to prevent undefined
> behavior during the calculation.
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Fixes: 1925d6a7e0f4 ("drm/virtio: implement context init: track valid capabilities in a mask")
> Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 1c15cbf326b7..2e0ec7590ac2 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -104,7 +104,7 @@ static void virtio_gpu_get_capsets(struct virtio_gpu_device *vgdev,
>  			return;
>  		}
>  
> -		vgdev->capset_id_mask |= 1 << vgdev->capsets[i].id;
> +		vgdev->capset_id_mask |= 1ULL << vgdev->capsets[i].id;
>  		DRM_INFO("cap set %d: id %d, max-version %d, max-size %d\n",
>  			 i, vgdev->capsets[i].id,
>  			 vgdev->capsets[i].max_version,

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
