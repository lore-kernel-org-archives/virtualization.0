Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8D137747
	for <virtualization@lists.linux.dev>; Thu,  5 Sep 2024 02:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725503040; cv=none; b=j2mKBgNniRJq/WdliOSyAAR5Ol8td/4nr0uQVM8Y2KEhvFC7vvsi+t9yQbFiR3ouBVchYxsUcGtlxC1Y0kCAhhADWp5HkRqN+LfZIdL1ZOMZlF6PsYx6qUeAjGVewUucyLkTOhpq89j4wfUtxyXHk0YdVOgkXZOAdr0e6oD1bI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725503040; c=relaxed/simple;
	bh=a6s7qQ3k+HcZs8eL+uK/csotPie51XK3iW4gPhvjzLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oA7jyWQ6j7dCKRzaSSZpHXMvVfuVbyAs2F19M2IvBrvHo0bsLWZTI0Wu2HgRlXRk4C96JVTvkNPsxpyplFqi8NCK7ym0wPsK8Pa/QEgJVHTFYsGQwQ2hYglp7FkK/9L09okgMXhxetk3VDUn4dfJs+kVg/s3b4t9fDnhfzTE/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+EpqoZN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+EpqoZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725503037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6s7qQ3k+HcZs8eL+uK/csotPie51XK3iW4gPhvjzLs=;
	b=D+EpqoZNhv+CMaoTAdfo5Cu3qaEN4+XBBdBymOkz7jwLN0ELNpw+vpymeEOjtfdMvvut4z
	Z7ozYRMVQMIKNb8+XFvVy2l+NdeX13PtgrRl9n7sY021sko4grJ2WJK7Fz4BFLn2UwZzpD
	3SB+VvzYZzrIjYYoYHZZkr8NSoUNnHM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-7FFk89dRNL2Xb8A9pfBrWQ-1; Wed, 04 Sep 2024 22:23:56 -0400
X-MC-Unique: 7FFk89dRNL2Xb8A9pfBrWQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d8859d6e9dso264128a91.1
        for <virtualization@lists.linux.dev>; Wed, 04 Sep 2024 19:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725503035; x=1726107835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6s7qQ3k+HcZs8eL+uK/csotPie51XK3iW4gPhvjzLs=;
        b=djwY7njLSbQC7Swcvr/Eg9mdFgGOen/W1CRFgPgVujnMCvS+AEu4qET+5EEDoWsP/d
         uekhCbM6/apIwdID648iZCdtV9JvKP0TrGaJsMSnWUndmCse/HewmNijZFw89zIToj7J
         XuvI61QuE5F8St1GR9lJoXI+RZ49jCk4BG/qohocjSWjK0CJd2BAa/knY0kMwWViBQUv
         NtkIJJl+TSOIZRjNqu0FcKms4bBu0UUd2YFbUAQDOxg0Y/EoYxpDn0k4nS0pq4fnU0x4
         +NbL68+65AsJfG9dx48lsj6+K4r9075b0qbWxZyoMcTaeqPmSmUIu1SwCEUre+KAsUpY
         AssA==
X-Forwarded-Encrypted: i=1; AJvYcCUhYifffYVEeMol15casu8eGhHhgBZpAs+4B37G3cYYgZnSC5yTBbxmDrkKX+PklbMG/GRhgDHTQFizFYP40Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhW9tie4Cp6jNQKy2xsQ8ukN0xqCSBbO/pn7m23+CknaOT30LM
	EfsuVehjnVZqH+qyQuMUY8A4NdVJYz53VU8zv2ges4kX+593PR43PsZRILI+iHTnfu8ZueJBVBJ
	WyNAU6Dl8LjA/ZLQiUmPCxp1aHPF0rAaF6DhMZXooj7zDARnm38Q3+slCUFiUcNk/wUVRyEU5YO
	mtdaT2hU5L9VdVlVGJnxUZ1Ea+Dfl8DVnBpllJG6g=
X-Received: by 2002:a17:90a:fd8b:b0:2c5:10a6:e989 with SMTP id 98e67ed59e1d1-2da6344ce5bmr7804065a91.35.1725503035424;
        Wed, 04 Sep 2024 19:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG23zHXhEHTjyKBW3CywgbRBX6O92NrUsGkTQ5WvgrENGy5961jGcrmiJ4JtIcJZJk6DZcvqrJ35iW8k8+jExs=
X-Received: by 2002:a17:90a:fd8b:b0:2c5:10a6:e989 with SMTP id
 98e67ed59e1d1-2da6344ce5bmr7804048a91.35.1725503034966; Wed, 04 Sep 2024
 19:23:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240903171514.201569-1-carlos.bilbao.osdev@gmail.com>
 <20240903171514.201569-3-carlos.bilbao.osdev@gmail.com> <CACGkMEvHU0VnOEZbVnEr1SvmOF5PhMtKk=M2o7Wwq-DUO9p7Uw@mail.gmail.com>
 <faafc28a-23a9-4dff-8223-1c72acb42443@nvidia.com> <CACGkMEtZHnkBj2JKaEp=7xURtkUFy=vFQEO8LZ7z7hoFafDMVg@mail.gmail.com>
 <ea0010cc-1028-4fe6-9f95-26677142fe42@nvidia.com>
In-Reply-To: <ea0010cc-1028-4fe6-9f95-26677142fe42@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 5 Sep 2024 10:23:43 +0800
Message-ID: <CACGkMEvfdUYLjx-Z+oB11XW-54ErJsQMKcnu2p=dsj5N_BiEKw@mail.gmail.com>
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

On Thu, Sep 5, 2024 at 1:48=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
>
> On 04.09.24 08:34, Jason Wang wrote:
> > On Wed, Sep 4, 2024 at 1:59=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.=
com> wrote:
> >>
> >>
> >>
> >> On 04.09.24 05:38, Jason Wang wrote:
> >>> On Wed, Sep 4, 2024 at 1:15=E2=80=AFAM Carlos Bilbao
> >>> <carlos.bilbao.osdev@gmail.com> wrote:
> >>>>
> >>>> From: Carlos Bilbao <cbilbao@digitalocean.com>
> >>>>
> >>>> Remove invalid ioctl VHOST_VDPA_SET_CONFIG and all its implementatio=
ns
> >>>> with vdpa_config_ops->set_config(). This is needed per virtio spec
> >>>> requirements; virtio-spec v3.1 Sec 5.1.4 states that "All of the dev=
ice
> >>>> configuration fields are read-only for the driver."
> >>>>
> >>>> Signed-off-by: Carlos Bilbao <cbilbao@digitalocean.com>
> >>>
> >>> Note that only the config space of the modern device is read only. So
> >>> it should be fine to remove vp_vdpa which only works for modern
> >>> devices.
> >> Just out of curiosity: how will this work for devices that are not
> >> v1.3 compliant but are v1.2 compliant?
> >
> > Devices don't know the version of the spec, it works with features.
> > For example, most devices mandate ACCESS_PLATFORM which implies a
> > mandatory VERSION_1. So they are modern devices.
> >
> And modern devices should not write to the device config space.

It depends on the type of the device.

For example, for blocking device, write_back could be modified by
guest if VIRTIO_BLK_F_CONFIG_WCE is neogitated:

"""
If the VIRTIO_BLK_F_CONFIG_WCE feature is negotiated, the cache mode
can be read or set through the writeback field. 0 corresponds to a
writethrough cache, 1 to a writeback cache13. The cache mode after
reset can be either writeback or writethrough. The actual mode can be
determined by reading writeback after feature negotiation.
"""

> This
> was discouraged in v1.x until v1.3 which now prohibits it. Did I get
> this right?

It really depends on the semantics of the field. My understanding is
that, from 1.0 to 1.3 there's no writable fields defined in the spec.
But it doesn't mean we can't have one in the future.

Thanks

>
> Thanks,
> Dragos
>
> >> Or is this true of all devices
> >> except eni?
> >
> > ENI depends on the virtio-pci legacy library, so we know it's a legacy
> > device implementation which allows mac address setting via config
> > space.
> >
> > Thanks
> >
> >>
> >> Thanks,
> >> Dragos
> >>>
> >>> And for eni, it is a legacy only device, so we should not move the
> >>> set_config there.
> >>>
> >>> For the rest, we need the acks for those maintainers.
> >>>
> >>> Thanks
> >>>
> >>
> >
>

