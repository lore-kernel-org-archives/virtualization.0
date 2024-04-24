Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD4143891
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963816; cv=none; b=RSbhOKLi3qDIa+1b00dfoMV53ryQXSoE3JMtUeBDvnF4DmNiBvh0S5k3SKCPDaeEIHtO4XYDwGBhfv6iQjM2XMUTHesUHKc8LNHN6gViePnlfIastS/X7V1zHGEA1KVuR/Lhk6hfpSHejerz0nW3bUOv2i+frTLx9SH9mM9koLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963816; c=relaxed/simple;
	bh=9Vw3QsSN9MtG+Q8HObd3p3koDa2c+pw2/PkCfEYrGi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YK9U/IRdWQjYj3OJ10Ds3IQlvZsq4CyxXLzuDuD247IoKL+1ikVzS8y06dhLMMKStlRRP549J+7KFfWdmZWZ2vK5o93uY4Qt7b8bDmif5wJDAdJn270BasRyFkHyF9Pzv+LEU0taBWvC7grpiNltvemTehWBNSan5u6VK4f0o+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAeAnyR0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAeAnyR0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713963813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaV3IArlUv54xMzfpCp75Zf5kU8oPtgFZOhgzTbc6L4=;
	b=WAeAnyR06FPMmi60QpdbX6Pzzm5xe8JkCqVL3pRh5TXt3CZxF7KGLKa541hBRjz10OMCvi
	dIQFfHXmbo+eZlgNdRlnLMOawqLFso1stdlY54JEcLmyC8fo0DEV/VWFsVx2OF2AvmIh3Y
	Fx+oEPyJQRx9kf9Q4vBsq58bS1+3UTU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-j_UR2jKQMY6xarLptPS7hQ-1; Wed, 24 Apr 2024 09:03:30 -0400
X-MC-Unique: j_UR2jKQMY6xarLptPS7hQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-439e8824c7dso26273811cf.0
        for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 06:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963810; x=1714568610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaV3IArlUv54xMzfpCp75Zf5kU8oPtgFZOhgzTbc6L4=;
        b=pFDzSaJTv+wwiwI7XHh7aNy9/vVwDirW+XSOSPJ7+MOBxWkmT1BrrS/nIeLcMg8JJp
         zOkPPijbbaEts/RjTnrm+8A3Xwg2NxKp7UKpgm2Uc8HnhYEy/qnnySOLjqZ3fP86W2V4
         s+hP/PnY8Ii+6jsuBL2kC6WwToRhC+9UD2hTWQ9j6oF/rQWasLfKVV56ALl9lQPCCEpP
         IgEYsGP9kHa8kQyv0upi/GSipSFX8Tz2/YUzsvmWsBuH2puGmeLF5vsLllqkdSS8aiua
         3Jww5Cs6uMf2HBEGnjfpl5C4+h92mPDhJpFU+cBtttAz84mfo+SVvmUyszVetzx31kXF
         6cHw==
X-Forwarded-Encrypted: i=1; AJvYcCVjWP+CPbnYLNzauIktYOf62UBc+9OpmxTvll9xK48ffe8QXfcWe12Ysq+Y1lBK0KA64mswMfAmBulHYITVH92mDINgUkYyy7EeMasVZa4=
X-Gm-Message-State: AOJu0YxTOeHBLyRavA59g1UxlJ5TgTv3fXJb+bm5JOOeXdNt2zV2K7CL
	vVjsRLVpfNqAAIxPsG++ofQVyFQ16/OL7P5mwtJyKRt5tFReEJ75jZeNUOP+Q8g3CPTUo3YDOKz
	3Sh4FUUz5hDm8l/PiqYKpxyVXE+/ETsV56s6jOMBk6pmw7f2tIKmXbOXP69wf/27AMZZF71znhB
	QMr35Y5hZQPyn74/K5rF8O0qn6BMmdjImOOi1XWT4=
X-Received: by 2002:a05:622a:2998:b0:439:e722:1923 with SMTP id hd24-20020a05622a299800b00439e7221923mr2473835qtb.35.1713963809841;
        Wed, 24 Apr 2024 06:03:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6udTZN9HoEjIdODs1JhGOU4VWnBeQOkmX6+2ZVLMzs0E9kEXmTBXlyxDebJcR95prOQoRgnbVHMjUCuFNumw=
X-Received: by 2002:a05:622a:2998:b0:439:e722:1923 with SMTP id
 hd24-20020a05622a299800b00439e7221923mr2473812qtb.35.1713963809572; Wed, 24
 Apr 2024 06:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240424090613.2630952-1-korantli@tencent.com>
In-Reply-To: <20240424090613.2630952-1-korantli@tencent.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 24 Apr 2024 10:03:18 -0300
Message-ID: <CAAq0SUmJsuns4_wJ155+Gnj-a8WmXhzptsrCiz7+=HjKiFKQ0w@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: fix comment typo
To: Xinghui Li <korantwork@gmail.com>
Cc: airlied@redhat.com, kraxel@redhat.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xinghui Li <korantli@tencent.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 6:06=E2=80=AFAM Xinghui Li <korantwork@gmail.com> w=
rote:
>
> There is one typo in drivers/gpu/drm/qxl/qxl_gem.c's comment, which
> 'acess' should be 'access'. So fix it.
>
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>  drivers/gpu/drm/qxl/qxl_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.=
c
> index fc5e3763c359..2cfe29d72d81 100644
> --- a/drivers/gpu/drm/qxl/qxl_gem.c
> +++ b/drivers/gpu/drm/qxl/qxl_gem.c
> @@ -74,7 +74,7 @@ int qxl_gem_object_create(struct qxl_device *qdev, int =
size,
>
>  /*
>   * If the caller passed a valid gobj pointer, it is responsible to call
> - * drm_gem_object_put() when it no longer needs to acess the object.
> + * drm_gem_object_put() when it no longer needs to access the object.
>   *
>   * If gobj is NULL, it is handled internally.
>   */
> --
> 2.39.3
>

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

