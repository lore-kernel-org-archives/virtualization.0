Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B257613D8A3
	for <virtualization@lists.linux.dev>; Wed,  4 Sep 2024 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431698; cv=none; b=QkrWh0OkjpUJ7bBkz8uWkb8h1KqBa+pOXDSeR5vWJebjFFZqdJ6uws0wdeJS9fSTP1HPbDtaDKdiVkVE6B+VUM7jYZ/cIdLyivgGoH7Hyk6v9OaqMLiVBxb3cfoh04h408dWC6lX0XcIHGv9e2SFU0jMfB2doRDTcBRQPqgbOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431698; c=relaxed/simple;
	bh=Nib65CS/jKWraWvQ+DYxRru/c/gctxD1oYSNGhN1rv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8iA5P+AivK3tGZdbVPhwJi7/gY68UlQ/qLzeAJ5hrbbVii3gaKCmcUScTe3uo/U9gmYo4DMNtIoaQdjjJCcEcVg2eS2NvQ5qG8lg53uvB6bhBNRf8vZTh8fdKIgSLMPl2nkWLwikIzOvj5HGqMc6icW8vsU14icGcIMnjg2cMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LZwWEkBX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZwWEkBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725431694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nib65CS/jKWraWvQ+DYxRru/c/gctxD1oYSNGhN1rv4=;
	b=LZwWEkBX9pBvYDVGPaF+sfsqAfCg/raLThpNBmXfPqiLKcDtZ8zS1bz3/57+wmoSBUfidh
	wZzXXkle7bL5lwLasbD+JycnX8pJp13n2g7YsY5G7oC6Lfx85zYw95qyy8cQZCM4kwtSYq
	NTiVb1H5hR11EI++H7JXh5s/+3PSWoA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-XAIVe-T6OSyqv_UPjMKpBg-1; Wed, 04 Sep 2024 02:34:53 -0400
X-MC-Unique: XAIVe-T6OSyqv_UPjMKpBg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7cd7cd2f915so5070719a12.3
        for <virtualization@lists.linux.dev>; Tue, 03 Sep 2024 23:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725431693; x=1726036493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nib65CS/jKWraWvQ+DYxRru/c/gctxD1oYSNGhN1rv4=;
        b=VxYjMjrd5DuXt81YppfH8nMBjnu/sjJoONAY/yxrxh+/MSImn/sRt1uDE3artt0RQe
         gN6xgi/42xpdx4S/TTtTuyPmeUJAupb2FltbdoglyCCrWVJ9A/9Y1vmSiOUT/SX0nxy4
         Jq+8XiAvM+QwEicENZfyZfGGRpPLnBaP9K6U77rYdH8EvwIVM3Z7GQsH1jtFHCxB+/Ny
         vVqTOjP90WSHnql3K3L1TPczwy6PQtDc7NsncNE8Ng2H7vUIveHqk5CR09p+9YcnywNT
         55BDs9CZpw0FxhRHlwUNi4JepW4ghl5ZqXuXexUo9Q5zvnx0JuljYgrqd38XygDVJ5sd
         wMYw==
X-Forwarded-Encrypted: i=1; AJvYcCUC+EJ+OSyz95xAPLHGJmR1TA3XRkdcP01o8NUyIlmD3jiYjF9F+udwrp/QNgRBR+zK25QlJebP0vWWoHV2HA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxxLTE72fdknLtALejZYoAd/H978gr9Rej3tHWCUJqg9xJYrqfl
	GUMNbhuvMwiTvUS5wEOHim8KfLOfqiJt3DU4X6MiFDUQumFvTAS/FWH8HGsgn8FgTmaJ2WmhXPB
	N8bPy722TOaFxj41kxY5sjU4nUO3s7h6AfeRSIefvu3D+IzeS1J1lfnAxgcwL70E4wnl3IA0JOo
	PZyZ+Vrnn/z0R+XPWXQmIAEz/JdgLKpHUvhU7gAeI=
X-Received: by 2002:a05:6a21:1706:b0:1c2:8f50:b450 with SMTP id adf61e73a8af0-1cece502d52mr12321301637.18.1725431692602;
        Tue, 03 Sep 2024 23:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELt1GC768sylfd9cTaGwknyMDJpOCJXkmNL6NeitKqFXTFJKiRjDvxPjGsHsp/dkBeUZBjUFKz563x6JqMgvo=
X-Received: by 2002:a05:6a21:1706:b0:1c2:8f50:b450 with SMTP id
 adf61e73a8af0-1cece502d52mr12321276637.18.1725431691959; Tue, 03 Sep 2024
 23:34:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com> <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
 <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com>
In-Reply-To: <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Sep 2024 14:34:41 +0800
Message-ID: <CACGkMEtZHnkBj2JKaEp=7xURtkUFy=vFQEO8LZ7z7hoFafDMVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vdpa: Remove ioctl VHOST_VDPA_SET_CONFIG per spec compliance
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, mst@redhat.com, shannon.nelson@amd.com, 
	sashal@kernel.org, alvaro.karsz@solid-run.com, christophe.jaillet@wanadoo.fr, 
	steven.sistare@oracle.com, bilbao@vt.edu, xuanzhuo@linux.alibaba.com, 
	johnah.palmer@oracle.com, eperezma@redhat.com, cratiu@nvidia.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Carlos Bilbao <cbilbao@digitalocean.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 1:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 04.09.24 05:38, Jason Wang wrote:
> > On Wed, Sep 4, 2024 at 1:15=E2=80=AFAM Carlos Bilbao
> > <carlos.bilbao.osdev@gmail.com> wrote:
> >>
> >> From: Carlos Bilbao <cbilbao@digitalocean.com>
> >>
> >> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementations
> >> with vdpa_config_ops->set_config(). This is needed per virtio spec
> >> requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the devic=
e
> >> configuration fields are read-only for the driver."
> >>
> >> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> >
> > Note that only the config space of the modern device is read only. So
> > it should be fine to remove vp_vdpa which only works for modern
> > devices.
> Just out of curiosity: how will this work for devices that are not
> v1.3 compliant but are v1.2 compliant?

Devices don't know the version of the spec, it works with features.
For example, most devices mandate ACCESS_PLATFORM which implies a
mandatory VERSION_1. So they are modern devices.

> Or is this true of all devices
> except eni?

ENI depends on the virtio-pci legacy library, so we know it's a legacy
device implementation which allows mac address setting via config
space.

Thanks

>
> Thanks,
> Dragos
> >
> > And for eni, it is a legacy only device, so we should not move the
> > set_config there.
> >
> > For the rest, we need the acks for those maintainers.
> >
> > Thanks
> >
>

