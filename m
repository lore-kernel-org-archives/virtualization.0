Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC542AE68
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711682212; cv=none; b=sgirX/GgDDzxfM5Py3bDE124ArSkqca4yoKErnsooKiw6P4xj+GcVEUZK6kRR2r6OXZe6MiPC8XFFiSmXVVTGsw35YMX2Yv2fp2VQRe+GEANC4lyjRzj6beZaPt80V9A0RP0sDM/AYg80y+PmoEyR/maRRTo0ori/7LWDkYILyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711682212; c=relaxed/simple;
	bh=a/VN+mdeggc6CK86VLaGu6ajVMPHLw3pM99GGwm9EuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnjHxEcuEoOhdqXgRNgxndVuPoq68/VRS/7SsM9J+Hy/QAVEyX65eyzQN+z0MR8DUKQU7izPrK/7ZxMfnZDuomWPYPnx3Msf9eq3xDRPU982LAfimlk2AO+C0qVGaQTPYligDvk7MZ1J7uNrlktOeYY6kcHkQqnz6/6Lr9lN3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kip83uE5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kip83uE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711682209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35D3mH4G6Kyxe+It17TRBfV5gddJyYbeSD6Ix202fhU=;
	b=Kip83uE5X6QuX5u71aNNQk+hyx1BUlJxRCJO6jmZI9nUjnMT41JLjNTIne5ITZ/f0KJdsR
	zzVD9HjvMuYM+qamKdY7ILvYenHCPqydWAO3Hhv8s5pdcyY7VzPYxbyFk1m/14L0jCkaxZ
	s1cB6IXsNiSy9y+AJQroDv5cGpSfb+o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-a9ULGfhjMECo2J9Tr2RQ3A-1; Thu, 28 Mar 2024 23:16:47 -0400
X-MC-Unique: a9ULGfhjMECo2J9Tr2RQ3A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-29df71a709eso1453676a91.1
        for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 20:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711682207; x=1712287007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35D3mH4G6Kyxe+It17TRBfV5gddJyYbeSD6Ix202fhU=;
        b=kTUxxHEMsRiTkZGT6syaQMio0sAMJ4pv/1V/Qr8G14XpLhSvRllPBILaTU9hSknQEF
         /v7fxcXwiLmjK1C7qrPO19HYRDPpeyb0t1T3enk8wttMVcLDDV4Vp+0/c7AiMmaW0Jsc
         o32ockTUFw4xKsRBtVa/8OsLqQdwnQcitiI89IEGd6TSg3nOElYtD8ToPAIwuaZ5phJJ
         QwxaloBWGIqwTt+ZzbA7rQVexC4LWmzvY/emH7/zuPaw7o3FV+o26IGDw9VGxD3cN/px
         GraIJUY+HDBDc08rem7ZAn++jqb1u0RXGno2fUA7pswIwVMRa04Klp0d641Jm93Gkwy/
         jTqQ==
X-Gm-Message-State: AOJu0YyaoR0W0dJFKCSD2ZxIPfCuWaY7SEcI685x74wpzfdgpPNGa3Cx
	HPx2goQLol48as+qdl2/MJ0jzGIlM76yoEqvEhnAQgXzR5+Bu35jEkvxyLCZX7DEvGXI8k1Ug0J
	Zwhg5rS5dSSlJua1Pkcpy1+7NadNxDyavJQach5zFaoHo5sm9gCjb5pntVnQ6GYCCIrPxWoXfdu
	Fp49rmf9Ujia8wPYwiMhbyNrgwM/+18DiA+OpPuMw=
X-Received: by 2002:a17:90b:438d:b0:29b:95a:baaa with SMTP id in13-20020a17090b438d00b0029b095abaaamr1122304pjb.47.1711682206880;
        Thu, 28 Mar 2024 20:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY7MfzA7vL4DFnj2zKalqTY7rUS4dD1nFqOdbO9QfQtKabq9D8jBbHUcOBDHuK3bXvlS9FRDrwFXK37GuogFw=
X-Received: by 2002:a17:90b:438d:b0:29b:95a:baaa with SMTP id
 in13-20020a17090b438d00b0029b095abaaamr1122287pjb.47.1711682206548; Thu, 28
 Mar 2024 20:16:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-7-xuanzhuo@linux.alibaba.com> <CACGkMEsmnzEUmaffn3ueY1JtbJ4UzLpr9o0s4j1jwoVuO-yy8Q@mail.gmail.com>
 <1711611643.583144-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711611643.583144-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 29 Mar 2024 11:16:35 +0800
Message-ID: <CACGkMEv08s6vt7r218rQ1_oAppGWRnsMZBzULFX8zMiMi8e6kA@mail.gmail.com>
Subject: Re: [PATCH vhost v6 06/10] virtio_ring: no store dma info when unmap
 is not needed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 3:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 28 Mar 2024 15:06:33 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > As discussed:
> > > http://lore.kernel.org/all/CACGkMEug-=3DC+VQhkMYSgUKMC=3D=3D04m7-uem_=
yC21bgGkKZh845w@mail.gmail.com
> > >
> > > When the vq is premapped mode, the driver manages the dma
> > > info is a good way.
> > >
> > > So this commit make the virtio core not to store the dma
> > > info and release the memory which is used to store the dma
> > > info.
> > >
> > > If the use_dma_api is false, the memory is also not allocated.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 120 ++++++++++++++++++++++++++++-----=
--
> > >  1 file changed, 97 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 1f7c96543d58..08e4f6e1d722 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -69,23 +69,26 @@
> > >
> > >  struct vring_desc_state_split {
> > >         void *data;                     /* Data for callback. */
> > > -       struct vring_desc_extra *indir_desc;    /* Indirect descripto=
r, if any. */
> > > +       struct vring_desc_dma *indir_desc;      /* Indirect descripto=
r, if any. */
> > >  };
> > >
> > >  struct vring_desc_state_packed {
> > >         void *data;                     /* Data for callback. */
> > > -       struct vring_desc_extra *indir_desc; /* Indirect descriptor, =
if any. */
> > > +       struct vring_desc_dma *indir_desc; /* Indirect descriptor, if=
 any. */
> > >         u16 num;                        /* Descriptor list length. */
> > >         u16 last;                       /* The last desc state in a l=
ist. */
> > >  };
> > >
> > >  struct vring_desc_extra {
> > > -       dma_addr_t addr;                /* Descriptor DMA addr. */
> > > -       u32 len;                        /* Descriptor length. */
> > >         u16 flags;                      /* Descriptor flags. */
> > >         u16 next;                       /* The next desc state in a l=
ist. */
> > >  };
> > >
> > > +struct vring_desc_dma {
> > > +       dma_addr_t addr;                /* Descriptor DMA addr. */
> > > +       u32 len;                        /* Descriptor length. */
> >
> > This seems to be odd, flag should be part of dma info.
>
> flags contains F_NEXT, that is used by detach when no dma info.

Right, so it is needed for hardening.

>
> >
> > To reduce the changeset, I would split out next.
>
> Do you mean split this patch set?

No, then this patch looks ok.

Thanks

>
> Thanks
>
>
>
> >
> > Thank
> >
>

