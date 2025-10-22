Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663602D661A
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 04:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105675; cv=none; b=jJ2OGLAiLy7CarHEnChDjGPD6BkLoaY3T3R1VSfbPPeSz9cwSp6IyLtAPZKnxb8hGtWsR8b4IPPip51RFxaa7Rdh3L/fXodlTUstGDRxCS+EWIe2T3ArdvPQ+wvE6ksFtL9yJX74cKdlicREUx/iqeB6q8Thy9C6k9FpxEAyLjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105675; c=relaxed/simple;
	bh=ExxG00WUT1IagntSo4MfFIFNw07rQDoJ9SPCq4MYTFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaePYkJNrEZ5rION8rtjQWPwxA3TUrJBmBtP9mm/CSsMhNp9v84fZ6DRGXGCx/eDU1GWq+ltjiSmxaw2KpmTr+dEPAqdH7GHOr9N233r0YYeAM3Y1kR4OWfuw3qbyjWK7HeavIU1WTefRgtpqM+V1bvOtLz4q6SKmud/WtFG7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLFwVa/H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLFwVa/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761105672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=px/1PnEGsVzDuAqu7+hFZS0aqZHYwLyi9+i6ljtogjc=;
	b=TLFwVa/HV5zo5rk3CWqoFl8kRuE2+2cDhYJWCmy8RnOzRk1248+eV7UwEm0ZXC7NIwdhs0
	/t1uG47yvERRwDeXl/GRXt2tkBS+hG5eD2kP45vAb89NyFz8WbcrtSWi/kXIg2gi8+N8X3
	q8XUMyClf5gpztxGNQxAAgyqlNGdVAg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-iGI1nX9xOKKppLhlismVHA-1; Wed, 22 Oct 2025 00:01:10 -0400
X-MC-Unique: iGI1nX9xOKKppLhlismVHA-1
X-Mimecast-MFC-AGG-ID: iGI1nX9xOKKppLhlismVHA_1761105669
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290da17197eso82514285ad.2
        for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 21:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105669; x=1761710469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=px/1PnEGsVzDuAqu7+hFZS0aqZHYwLyi9+i6ljtogjc=;
        b=IS0yUej7eQQmitYX1L1TNJfmeLJT3AB7DQOAY92SWRL5U2JzJT/+mVDnl2Sh+RObBz
         bibKTfjotvaQPFVfowfJXN9EQncT+NFk/eppQ/M8hjPR+kAzdfBR6Cqsow1bEh+kNl5F
         ovkOXVxziwj7Y1XwNKXv0BOW/9v0GI/ISGHaAoBGM5bNmzbauYd0NMW9BAGc0Y/2hz98
         tOkz3v6bAWl5caZFVGBFRsPGOas3p6P+nIKGmQzVnli3qQAMumpH+vnbcfjxu0abk/tm
         uzscTXC9zB3tcsKVSg3fVS4VEeaA972dsiwYp9q56i0H7olf12mVPfoKFvBs+CgwnZNz
         XHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxnfpiX5D9f+RjFkt3eGpWxUF0oVTmVzy6tdrFcGK8J5ISnp+rd3uVzOR4n8b5pAYQARsVrp3U+hbFfbBBvA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7Vrx8UabDmkFOaT6RvFN1TS0DtQPiRCBMz0ufT1wB9uOkaohZ
	Jeo4/bMkEp7wkhMXbEXDa4kxN6KdHEKLKpWjvHDqoFy9+uyf70s+DoeNzytQ+OSTRQXa4CJ0hTj
	FcvT169qFS+HqTz11+VP0WQFLIS3JxfZy6IAwPqWrzeew2b9UfpCta8DbJzPivy/VinVYH1eHKo
	JAW+AY6PgjUNT3VUc+GCr/5Z+UNozWjiwgbJDSN0bHpX4=
X-Gm-Gg: ASbGncuE0cIni2+ChpuVgcmjSqjaNW3WHiy4IwH6gAqhvqrqU7c2Z0tJ642kUdBl3gk
	nH2dAtDpa69uBOACNc8tEujnwqMpa2zk8+J/IWFKq48m91AIhpghk37OMICMoL4jvfCW2sLvLak
	0KvyN8JT2xqN7zuYUT2qpP8Z2goQWlAST5EAl8ilsCySEmg5GPOzj9ekYd
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id d9443c01a7336-290c99a9669mr229217985ad.0.1761105669138;
        Tue, 21 Oct 2025 21:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqPZl8Z6+wXXTq+AZoxPaazi7t261I9kr2FsxhfLSyR2ouuL4vUfGfOoznvt7TcYAfVlLV//O9cAZWtSZQkrg=
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id
 d9443c01a7336-290c99a9669mr229217155ad.0.1761105668421; Tue, 21 Oct 2025
 21:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-19-jasowang@redhat.com>
 <20251020111413-mutt-send-email-mst@kernel.org> <CACGkMEsRmkaBiU2WCQTepayhrhR18M1+bDQJXxTVxOUDG4sZyg@mail.gmail.com>
 <20251021042325-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251021042325-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 Oct 2025 12:00:53 +0800
X-Gm-Features: AS18NWAAzAExLbzR1SQ9Q8xgKInIDLRmK2l_SmYnjjQsmzapb0ZU1INU7NpbxDk
Message-ID: <CACGkMEskSf-mLZPaSYxkACu1z_hH_jXTKawzW1yZwZZOnSAFAg@mail.gmail.com>
Subject: Re: [PATCH V8 18/19] virtio_ring: factor out split detaching logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NabY2u0ZoR2d9NI3aEIGNarpI5n2Rz_capzuEy-joD0_1761105669
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:27=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Oct 21, 2025 at 11:36:12AM +0800, Jason Wang wrote:
> > On Mon, Oct 20, 2025 at 11:18=E2=80=AFPM Michael S. Tsirkin <mst@redhat=
.com> wrote:
> > >
> > > On Mon, Oct 20, 2025 at 03:10:02PM +0800, Jason Wang wrote:
> > > > This patch factors out the split core detaching logic that could be
> > > > reused by in order feature into a dedicated function.
> > > >
> > > > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
> > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_r=
ing.c
> > > > index 0f07a6637acb..96d7f165ec88 100644
> > > > --- a/drivers/virtio/virtio_ring.c
> > > > +++ b/drivers/virtio/virtio_ring.c
> > > > @@ -802,8 +802,9 @@ static void detach_indirect_split(struct vring_=
virtqueue *vq,
> > > >       vq->split.desc_state[head].indir_desc =3D NULL;
> > > >  }
> > > >
> > > > -static void detach_buf_split(struct vring_virtqueue *vq, unsigned =
int head,
> > > > -                          void **ctx)
> > > > +static unsigned detach_buf_split_in_order(struct vring_virtqueue *=
vq,
> > > > +                                       unsigned int head,
> > > > +                                       void **ctx)
> > >
> > >
> > > Well not really _inorder, right? This is a common function.
> >
> > Yes, but inorder is a subset for ooo so I use this name.
>
> Can't say it is consistent. I suggest for example:
>         _in_order -> specific to in order
>         _ooo -> specific to ooo
>         no suffix - common
>
> or some other scheme where it's clear which is which.

Will do that.

>
>
>
> > > You want to call it __detach_buf_split or something maybe.
> > >
> > > Additionally the very first line in there is:
> > >
> > >         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DE=
SC_F_NEXT);
> > >
> > > and the byte swap is not needed for inorder.
> >
> > I don't see why?
>
> To be more precise we do need a swap we do not need it
> conditional.
>
>
> No, I mean inorder is a modern only feature. So we do not
> need a branch in the inorder path,
> you can use __cpu_to_virtio16 with true flag,
> not cpu_to_virtio16.

The problem is that the core logic will be reused by the ooo as well.
I'm not sure it's worthwhile to introduce a new flag parameter for the
logic like:

detach_buf_split_in_order()
{
        __virtio16 nextflag =3D __cpu_to_virtio16(true, VRING_DESC_F_NEXT);
        detach_buf_split(..., nextflag);
}

?

>
> > > you could just do __cpu_to_virtio16(true, VRING_DESC_F_NEXT)
> >
> > Probably you mean a leftover for hardening? E.g should we check
> > desc_extra.flag instead of desc.flag here?
> >
> > while (vq->split.vring.desc[i].flags & nextflag) {
> >                 vring_unmap_one_split(vq, &extra[i]);
> >         i =3D vq->split.desc_extra[i].next;
> >                 vq->vq.num_free++;
> >         }
> >
> > Thanks
>
> If it is not exploitable we do not care.

It looks like it can be triggered by the device as the descriptor ring
is writable. Will post a fix.

Thanks

>
> --
> MST
>
>

