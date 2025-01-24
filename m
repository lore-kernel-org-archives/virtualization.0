Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5337F4C91
	for <virtualization@lists.linux.dev>; Fri, 24 Jan 2025 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737680637; cv=none; b=FdRFlp7F2EHdCYChUeMZ2UblTr2MAe6Zk6onrv0+p+6hqqm2MAn+im3fvoZR8NVYMEoJ3wkokx4UZFztydH3EFmmZql0wc1edqK7vYN4+FMLceEmKSleHz0OvwQFULVYUlE7HaE93cqS3F73cRr0jT5/JCWRoQCIKISomPKHWYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737680637; c=relaxed/simple;
	bh=Pjp8xnuGHLZQj/CyNWgYgUDelRHewgCaBaBVq424EZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUOtgQpKcm5qBxaRHdszIpx9Gy75HXUHA1U3/wmlPoB4rAMp/5il1Jl2bPlzWCAx0MmzLeweA7Mfj/hRPdq6OFFHeB3hWZmh6a5wKxQV4ewei/gJ9NwKYeDU/efX+OYCSuxabJTIbpkqPlnaNSLUT/ZaTxSQcJCnxmHYKChTBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8oJRwMC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8oJRwMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737680634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pjp8xnuGHLZQj/CyNWgYgUDelRHewgCaBaBVq424EZ8=;
	b=H8oJRwMCfX0TjlvXECKkeGj5UqOzwccfouZ8Qjg0dY9aNFdhfBo+SHPuqxuAewS3L5mKzu
	3OW7mVD6fPfipZU4JcwhzNNOlt3nZWL9HDCgXynGehtd2BVAiyqfLKxU8goEMMYgBchMWt
	TtLgrjrkM6AeTPFf9134kfj5hbH5Z5U=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-1KOxnNzMMvW8MPflZBCZmg-1; Thu, 23 Jan 2025 20:03:52 -0500
X-MC-Unique: 1KOxnNzMMvW8MPflZBCZmg-1
X-Mimecast-MFC-AGG-ID: 1KOxnNzMMvW8MPflZBCZmg
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4afebfa888aso162248137.0
        for <virtualization@lists.linux.dev>; Thu, 23 Jan 2025 17:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737680632; x=1738285432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pjp8xnuGHLZQj/CyNWgYgUDelRHewgCaBaBVq424EZ8=;
        b=ZQKOsgbJJf+titeZIUUMXJRUjMLVheGB0U81qMuYoRUDcOJGh6R5fWR9lA4t3RErBn
         x1dW2vUgVg4ukl+0KUHi/0YM18Ew32lfhsTpgCXgd4JCQWgW1VRZFopKCol7msCryt33
         rGBqWTaU/vHPLrZfDz+4+w1/SHUtMhWnvVXFmGTXWgtdnpwgF2HTDhcHsbULZn3Hjfoi
         z38vRxAIlkktNPtzBYLnxuKRXlyeLGGYqcyQnzuqP9Tac1YUFEdHgCrOKlBYi+of3D2L
         IudsyIlRlWs1Up54/Tq+dgV5ml51srM+mWvsSFIp11/egSYpdHFXe/c84YyHOHT1RBZg
         Uqgw==
X-Forwarded-Encrypted: i=1; AJvYcCWuLkwLOshByb7ppYuhVloXRGu/3syYvtmMnbdEmUsbxUBnh49IM0MMJk5cFtUM22YqWfpmPtlJgeGcc3vhVA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUOEKZ6T24NxJ9G3Ogvu0b2IRnO3Jo+BOCJ7bz86dtPGS0KE8N
	RaSfk88ZthsaMryDDpfoNEGJgWUoEcSJ1y7uHDxeMmeDS2jLa5rk3Eyin8PrgT8RvZ2JGdMbT1+
	WaCleJYy5L5N8d5nqJ2LVIQ4DnddQVrTLHSYHhgTpJZY8a+t4hoJXroWdta2xTuvpJG/X62ZteV
	Qi7ACKYqMuKlCDICFoC1qpMX5NLQhYo0EQaOPU6XE=
X-Gm-Gg: ASbGncuN2qZVkckME2qmJRHnTBQgo62WKBMxTAzTyqSHKOWzdwNUZHTUUTJn/fmme+7
	8sSxvNOWRAC3O30tmZiCfeaQ5V90NYDgl/+9IkWbUxGH1xkZtOw==
X-Received: by 2002:a05:6102:952:b0:4b4:6988:b140 with SMTP id ada2fe7eead31-4b690cb91e8mr25321271137.23.1737680632196;
        Thu, 23 Jan 2025 17:03:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/i0kh4kBasetfJ/kVeIlz+bL3d4eaiEkFieYRJx1/nXMYcwqqBCNlIJMK+lFJavjM/a2FmrnZnUzFiGsXEE8=
X-Received: by 2002:a05:6102:952:b0:4b4:6988:b140 with SMTP id
 ada2fe7eead31-4b690cb91e8mr25321193137.23.1737680631803; Thu, 23 Jan 2025
 17:03:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250122163154.1225353-1-eperezma@redhat.com> <20250122163154.1225353-3-eperezma@redhat.com>
 <CACGkMEt8djYRdSvwBK7QGoNV1iG-8nafOox0=pt6ix1m0NOZtA@mail.gmail.com> <CAJaqyWfpVfm6JgSanRBKrsprpKR6Nc+YsyFmsYzoNwBb+uZW-Q@mail.gmail.com>
In-Reply-To: <CAJaqyWfpVfm6JgSanRBKrsprpKR6Nc+YsyFmsYzoNwBb+uZW-Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Jan 2025 09:03:39 +0800
X-Gm-Features: AWEUYZlpxS0cKq6BCEXdobd0cLPSt7ECKxku3rDCRRZKX-WgOegnY96fLvybfdA
Message-ID: <CACGkMEuZKSd5CATEiPUoFiWCU5JY+myn6zsJV+UYUt71-4Xdrg@mail.gmail.com>
Subject: Re: [RFC 2/5] virtio_ring: introduce virtqueue_map/unmap_sgs()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: linux-kernel@vger.kernel.org, mst@redhat.com, 
	Hanna Reitz <hreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, German Maglione <gmaglione@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wZoIzPRSiu6PEVT7LToQc7UeWsNVekFZEL9QfSieGwo_1737680632
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 3:32=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Jan 23, 2025 at 2:51=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Jan 23, 2025 at 12:32=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@r=
edhat.com> wrote:
> > >
> > > From: Jason Wang <jasowang@redhat.com>
> > >
> > > Introduce new virtqueue DMA operations which allows the drivers that
> > > want to make use of the premapping API but operate at the sg level.
> > >
> > > Note that we still follow the assumtions if virtqueue_add() so
> > > dma_map_sg() is not used. This could be optimized in the future.
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > --
> > > Eugenio's changes: Remove blank
> > > TODO: Should we call directly dma_map instead of this? XDP do the dir=
ect
> > > call.
> >
> > Note that we should have an indirection layer as the device is not
> > necessarily DMA capable.
> >
>
> Can you expand on this? virtqueue_map_sgs calls directly to
> dma_map_page for each entry in the sg. This indirection layer should
> be in the device's callback for DMA, isn't it?

Nope, there are devices that can't do DMA.

Basically, the virtio core should

1) provide mapping helpers then we should use
2) transport specific method to do the mapping, e.g PCI knows it can
do DMA so it can use DMA API

only 1) is implemented now, in the future we need to implement 2) (we
still have dirty hacks for vdpa_sim etc now).

So it's better not to go back to calling dma_map_sg() directly.

>
> > And we probably need to rename the virtqueue_dma_map_XXX() to
> > virtqueue_map_XXX()
> >
>
> Ok so maybe these functions are already enough without using
> dma_map_sgs. I"m ok with renaming these, but that should be done in a
> separate series, isn't it?

Yes, this explains 1) above.

Thanks

>
> Thanks!
>

