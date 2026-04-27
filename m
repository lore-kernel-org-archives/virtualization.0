Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6823ABBF
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 04:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777263425; cv=none; b=IOjsFsrFrDHThFJn8JR6UZdKnowYWJNkn1yHriOTC74n+5bEnrIgXqE6/7T8lGx953ejzR+cjJAONFcdMbpgT8FzBg1WD9s0btK0Txm3+8K75DaK13p7hYNm1jhUHLJw2sVUQoYgPl4MnWShGT3Q+8NSPm2vZhSIRpVVTa2Mv0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777263425; c=relaxed/simple;
	bh=KRQmkVM65Q1840oxn8DuHujVjwJvPzfBblnZbPxTSFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUz1TnWtNwklAPjTR6yJIYACkJC0Qm4dE9TsS7iLjzE35tH1uRPh4RwA4B1E2qicoQ5b/8Eo1qkKffCFWW/TsRWlToCGpjxLsvGrAPSi+mRg+DAOUizMyymeJAxwW+go8IVOavUCqqpWR9bTMxNhVekaUOO8H3M2Ma1z/W/ixh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cr2R/mF1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cr2R/mF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777263423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BlAcW1ltQC2knkDii6CnmOJ/sQDwRimX9IVYeMU2YuU=;
	b=cr2R/mF1/h866dvZY5ooW76LIy+9JKw/EoTtxiX7dPv2dDb5ei+6g8zBt5LWlFnzIjrqW1
	Z1YTjuGRsxzs0BrB4gTgwhpPtl2zekWSVbBqrkHHedNH8FcKJ13MiaPxfzrr/uzVWG+xwC
	gVLLf3cEfLnLAo9wjqGncIA+0jt7Y3o=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-NqLixVJNPYSb4E7se4YFHA-1; Mon, 27 Apr 2026 00:17:01 -0400
X-MC-Unique: NqLixVJNPYSb4E7se4YFHA-1
X-Mimecast-MFC-AGG-ID: NqLixVJNPYSb4E7se4YFHA_1777263420
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b24cd2e2b3so88607785ad.0
        for <virtualization@lists.linux.dev>; Sun, 26 Apr 2026 21:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777263420; x=1777868220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BlAcW1ltQC2knkDii6CnmOJ/sQDwRimX9IVYeMU2YuU=;
        b=WYmdsqevbym/1QZ21V646GBOtmZOlliP+xo9pyrxVaD7pBLV4XFvnjPZeGVzjpq7RU
         XPl2N3tRp0df3X/aRJZGvqC2kE+UegYDbB33rKiP7rkM97VyER/OSmSij6xrQBXhOUea
         RkwfhvlybFVP6coKSOJ1PDkOQ9Ny4O3/MAAgK6EM7IYqG3An64yq5xZkBAIlBgCEIQCg
         ZT0Zzx3yKCQaDd7ss3xl6OoR6sQn5QP0NTnC1Dt/qMduB4U5D13IdO5DXgmSW/BP1ys0
         egK/VdtQo1F/4sqGqov3ewaAxamegkAH7s+ERFq2BC2kxHf3M9MPxPGp/SoH9XZlkVCC
         FRsw==
X-Forwarded-Encrypted: i=1; AFNElJ+VmXoOaQ50kazJkaGFNwdcqr9NdMKN6oqbRmafVFZLdLck6fLWdE6chlXUdRd/hNf1OiEuWgJPIZpqVWDUAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzOwd1HhmnyMe2VcsyRAP34Zx5YwWml9xlmbTrBkdLAuGA0nz0D
	RFljlJW2MQhFAg79dRQnP/VYs+7RwNQ6PgOrCKU9XBK3NrPBXRSL6d4APVn3A38fnmYydCSKq1L
	3Q8raY/WzRy9gBBtX+oNHNPGg98AkPOULJrR5xzO2x6l/HofD5kAkNA/FhWjzawwoiBi/cm8RsZ
	LV+M7MTJXgyvi4/Rj4iPL+uQJuCXj/qyY/yqKbKW8xf7o=
X-Gm-Gg: AeBDiesMxXQ/JT+VgWToLWtEzTRVBWUlrzsJTgzGSDN1QCKJdFCOovvhpmwys14GyRc
	fVQKpQT1cAhyvKVD/iBkyyCcQYJ3anp6X46Jo0J8zJB6xTLxO75Haytlq0BCNnKS1SY706nhB3i
	rAT34JKpGtHGJfFyCrIj7jvl2bO24f9+BJqb5i11zgq6GVYag+AOtRR+o0CusiCeGKKinCqxc3j
	GKSWG0hON6xDINvaw==
X-Received: by 2002:a17:903:3c47:b0:2b0:afb4:7d41 with SMTP id d9443c01a7336-2b5f9ea4989mr414325785ad.10.1777263420245;
        Sun, 26 Apr 2026 21:17:00 -0700 (PDT)
X-Received: by 2002:a17:903:3c47:b0:2b0:afb4:7d41 with SMTP id
 d9443c01a7336-2b5f9ea4989mr414325525ad.10.1777263419737; Sun, 26 Apr 2026
 21:16:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260424104820.2619227-1-johan@kernel.org>
In-Reply-To: <20260424104820.2619227-1-johan@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Apr 2026 12:16:47 +0800
X-Gm-Features: AQROBzDo3K7FC_rCt0vVXYTIfOgarpjIs4uJ_FH9j5Yq_1TWlvoxBmscBnVoKng
Message-ID: <CACGkMEvJ4CZt9mVhn5TRCz5yCYzY_yHNFh8pbT4hOmJoWDiKOA@mail.gmail.com>
Subject: Re: [PATCH] virtio-mmio: fix device release warning on module unload
To: Johan Hovold <johan@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Pawel Moll <pawel.moll@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CYDayMx299UwSWV0LWVAmIfHFnKXQcUzzyMxcI0AWXA_1777263420
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 6:48=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> Driver core expects devices to be allocated dynamically and complains
> loudly when a device that lacks a release function is freed.
>
> Use __root_device_register() to allocate and register the root device
> instead of open coding using a static device.
>
> Note that root_device_register(), which also creates a link to the
> module, cannot be used as the device is registered when parsing the
> module parameters which happens before the module kobject has been set
> up.
>
> Fixes: 81a054ce0b46 ("virtio-mmio: Devices parameter parsing")
> Cc: stable@vger.kernel.org      # 3.5
> Cc: Pawel Moll <pawel.moll@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/virtio/virtio_mmio.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 595c2274fbb5..1b580de81e82 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -662,9 +662,7 @@ static void virtio_mmio_remove(struct platform_device=
 *pdev)
>
>  #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
>
> -static struct device vm_cmdline_parent =3D {
> -       .init_name =3D "virtio-mmio-cmdline",
> -};
> +static struct device *vm_cmdline_parent;

vm_cmdline_get() is the .get callback for the device module parameter.
It is invoked when userspace reads
/sys/module/virtio_mmio/parameters/device. This function uses
vm_cmdline_parent unconditionally, without checking whether the device
has been registered. This would cause NULL pointer dereference.

Thanks

