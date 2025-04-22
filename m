Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0829009F
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745340555; cv=none; b=e9TT6j6PYqoR6LeyuANsI9JeQF6sQRnwjbObC4f6RXketZ7wVEnG+3jbEw1G121CGff9vDDqIvGiOfzRs1GyYX2Xw86U+YP732KvSWfnGjC+n0Df6CSjcoHno0dV5ui9cl2htJTPAqfgnlto7E1x0u32qzhASN+BxVzFvPanqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745340555; c=relaxed/simple;
	bh=OnwSNDn64S8aCsL+BPdxyk1KPcCrvENt7q1PLD17rCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDExmEq5yo+rGOmI4pwvf8/QeN4JPiygNwabHAU7LzVGFJqZabe4x8vcH9ctTcJoSPIOz1DBKU+SeSRrXRJnxvbj+M35x/GrWdy5APZM/J18GKxAstgvfSSaxNlohvO8QQ/eAHW/jB/DXaGWcXo488pCIybpOLYO/PqvxlUetrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZD6OZhB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZD6OZhB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745340551;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrsd/3p7dvdW/2Y1idz3MOxsrZjO4oXnRPdIb4aDyus=;
	b=FZD6OZhB6PUKbnyJ8Sx/oQhiW4OJcg0RhWK3eQOao1iVUbGsj2hVgcoshj0ExRBOUNM5iQ
	ocBZ58GRZNSXSnXhTamL2hhEF+769icgcV+0CPAPSxIkwKBvUpLiRfTaleagwe3H2UdDD9
	NjnakHJ+x/5cjMoZJh+i49IaaqJo2co=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-6AW5mJazPMaPSkYg_apgeA-1; Tue, 22 Apr 2025 12:49:09 -0400
X-MC-Unique: 6AW5mJazPMaPSkYg_apgeA-1
X-Mimecast-MFC-AGG-ID: 6AW5mJazPMaPSkYg_apgeA_1745340548
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d0a037f97so29008445e9.2
        for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 09:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745340548; x=1745945348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zrsd/3p7dvdW/2Y1idz3MOxsrZjO4oXnRPdIb4aDyus=;
        b=l5nVk72xjWps3Xoz8GoSktIqEEv3S2Jo+W3re2AfE7KeepkMajJFXRphum2o7JgIIX
         BlZ6r7Hwt9bP5Ujvj4xAAYzcyD/X1jVOh3ZUNsyu/olTmQKegWcFa2y+BgWxQdkTLSSn
         TykTg98lOGvcFc1QRwmPIwp3ZnnQhqUiwBuMsqCsMzFinChgDH5MEuyA/kQC8RUSq922
         9uu46+NImXpotiNZTSN9mjgz44PrC/gKfiYaUD5A76SIw6XGS+dZYl+0SG7j1xCwhy4p
         VyPNW79PuenbwRwuhbk+5EOwWbI3qEtI6nXm+olv/m0MkeeVXj1zpsu0qpIiXnzOVPGF
         m8CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqweVwjpQPPR54BZVrDArmRB/p41+IGQwL6GR3FN+UAlbB49OY3WOFP8QjKRxIP43w9FwzZQE/a33J5YXIfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEZhEBi2CwTIT+xkYsHOwvdphb4WYn+nNCfMR1y6cA/ItyyAF2
	JLN0u90U2TWPgiQ54cEdHE8NlrSPrukB4F2DijXxQ2mH1DoOYoPes/Xfa8v4oI1x1XPiZTwLc71
	7PTDmTRu5wYX6hrYvzjB3XYbs3tbsNiIqlte8UOcJMMCYsvkMfx2nyISQwmrPlRan
X-Gm-Gg: ASbGncv+5+udCrS3N8O4W+ds6zGRxW/ODHg1YpL+T2gi2Y4uaNFofFtHoW53ozgyGLr
	e+46leQFgiud+2kdfIQceYLCcMCvHOvFKhD5OaGPBCgix2VmFHgsdHH4udrUlIVqM2XNc/Psh4F
	aeQ+5T9jeVHiCO04Xo9e3RlGG60uK3PnlMNBK+PWIt3icByC8QPT3dcHNOECCPUW1F/LI77v8TC
	A6CuQOqIr0N2pTkKXKrGxj8PH003GCAu6XlUxvkGqfdvdTiuEkuZFYgR3NswrRAhSx5mbNvLwiJ
	jp7RmV4P7Hi6CObyRbgWRHNn08oPlKoh5BmSf+0T0ZcthXnv74KA6QlHkVg=
X-Received: by 2002:a05:600c:1906:b0:43d:fa58:8378 with SMTP id 5b1f17b1804b1-4406ac11581mr132427915e9.33.1745340548369;
        Tue, 22 Apr 2025 09:49:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL0BTg1501d7TjC/8u5Gc8ZzZQofR/EdbhGN5AMF4Ozt8Ub8BwgAm98X6mqgEsGUZkPjE5Lw==
X-Received: by 2002:a05:600c:1906:b0:43d:fa58:8378 with SMTP id 5b1f17b1804b1-4406ac11581mr132427685e9.33.1745340547956;
        Tue, 22 Apr 2025 09:49:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5ace47sm178502985e9.15.2025.04.22.09.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 09:49:07 -0700 (PDT)
Message-ID: <5aede4c4-5dfd-4ec1-9fd8-a5d6700678bd@redhat.com>
Date: Tue, 22 Apr 2025 18:49:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2] virtgpu: don't reset on shutdown
To: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Eric Auger <eauger@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
References: <8490dbeb6f79ed039e6c11d121002618972538a3.1744293540.git.mst@redhat.com>
 <ge6675q3ahypfncrwbiodtcjnoftuza6ele5fhre3jmdeifsez@yy53fbwoulgo>
 <20250415095922-mutt-send-email-mst@kernel.org>
 <lgizdflxcku5ew2en55ux3r72u37d6aycuoosn5i5a5wagz6sc@d2kha7ycmmpy>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <lgizdflxcku5ew2en55ux3r72u37d6aycuoosn5i5a5wagz6sc@d2kha7ycmmpy>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QFXgOannBrBR8tAJUr0o4JlOpEopSK19BDncGRnZFHI_1745340548
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Gerd, Michael,

On 4/16/25 3:57 PM, Gerd Hoffmann wrote:
> On Tue, Apr 15, 2025 at 10:00:48AM -0400, Michael S. Tsirkin wrote:
>> On Tue, Apr 15, 2025 at 01:16:32PM +0200, Gerd Hoffmann wrote:
>>>   Hi,
>>>
>>>> +static void virtio_gpu_shutdown(struct virtio_device *vdev)
>>>> +{
>>>> +	/*
>>>> +	 * drm does its own synchronization on shutdown.
>>>> +	 * Do nothing here, opt out of device reset.
>>>> +	 */
>>> I think a call to 'drm_dev_unplug()' is what you need here.
>>>
>>> take care,
>>>   Gerd
>> My patch reverts the behaviour back to what it was, so pls go
>> ahead and send a patch on top? I won't be able to explain
>> what it does and why it's needed.
> See below.  Untested.
>
> Eric, can you give this a spin?
>
> thanks,
>   Gerd
>
> ----------------------- cut here -------------------------------
> From f3051dd52cb2004232941e6d2cbc0c694e290534 Mon Sep 17 00:00:00 2001
> From: Gerd Hoffmann <kraxel@redhat.com>
> Date: Wed, 16 Apr 2025 15:53:04 +0200
> Subject: [PATCH] drm/virtio: implement virtio_gpu_shutdown
>
> Calling drm_dev_unplug() is the drm way to say the device
> is gone and can not be accessed any more.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
> index e32e680c7197..71c6ccad4b99 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
> @@ -130,10 +130,10 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
>  
>  static void virtio_gpu_shutdown(struct virtio_device *vdev)
>  {
> -	/*
> -	 * drm does its own synchronization on shutdown.
> -	 * Do nothing here, opt out of device reset.
> -	 */
> +	struct drm_device *dev = vdev->priv;
> +
> +	/* stop talking to the device */
> +	drm_dev_unplug(dev);
I have tested this patch on top of Michael's v2 and I don't see any
splat on guest.

Feel free to add my

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>  }
>  
>  static void virtio_gpu_config_changed(struct virtio_device *vdev)

