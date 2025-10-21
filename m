Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC4246BAA
	for <virtualization@lists.linux.dev>; Tue, 21 Oct 2025 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018970; cv=none; b=cG9Tq8WIcaVBURqyeDNMwg8o7QPmxMrYlnhS5fP5aGum/m6I+r4g5rMg+ORkQXF5pDNWUsaBly6g75fGfsedRLnsDUkEC/3xqAHIBXZ0ittnkjsbmqQiRjZ/q/HHXiqZ/YuXrzY7wpEZSrn1ldeicH99EnlX8GDLSC/IpRIm8r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018970; c=relaxed/simple;
	bh=4HUYXzgmQuRrjki7cRVCC1qE1Gbl+EdMdBdgCdr4tB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qxN7fdTpxOE+QtO3G1yGZQ7HJM+yyE2ZF93Q4O++2Kr2m+N53j+cnpmAUyrBveD6sG26yDaJUilSbS1RNVamB+fR2Vsj+GotQHzeo7Rm3LBfkM9FtOFmJqgF+PlTWl/SpVPE3vNDWmXZiIafibGfvWTqFm1TAKKgvnAumXgO5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HhdvZjj2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HhdvZjj2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761018963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5KXU9vMnHGXiyYsj72T8GiUMkynl1civeffeASc2+N0=;
	b=HhdvZjj24vyWTa9NcMkDNocH/WLKYLR258PvFDkobp4ZONtIwy983yBs1dveM3NkEJuWKR
	DCBPqOgZzy257F+43NLuZ2VcgBo23G3vC7MYIzy+fqSZJsKwN4A83tSXYo+Rb2B2h1oav5
	kbIiWoSMDU2pNU5L3cI6tBGeNz1WuAg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-iHkW2qm1OMCLpX0x9OV4TA-1; Mon, 20 Oct 2025 23:56:00 -0400
X-MC-Unique: iHkW2qm1OMCLpX0x9OV4TA-1
X-Mimecast-MFC-AGG-ID: iHkW2qm1OMCLpX0x9OV4TA_1761018959
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so4253894a91.1
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 20:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761018959; x=1761623759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KXU9vMnHGXiyYsj72T8GiUMkynl1civeffeASc2+N0=;
        b=mPeBBYuZCOlij51XxKzR45KJwhLKqcvou5ABkAwO4CmMfzrfUpbn8QoWp7wjfJfr0u
         skcSaqybEi2uqCA2vjp/KP/S4DoObEa82/QTlf9vzW5L+mHlSjZcswXQCMUufsmFs97x
         23ET+zEAbjwLM60u3dC2sZIfvjzWOCH+c4jJBmCbnUFWWFkcsB/sHlM+lKb8e2jPHsgR
         MUftn9giv6I+6irEj4lo8B45PrB3sMUKnhdO2oDN1VA/BM2eHINoharR4mKKkU/7iE1c
         v3V3qBjV2GYMph6juUEKW4sIusQCctNkP0C7x0l+UUEaC5P1fmP1X54UQ0tV1oPxjLdb
         16qg==
X-Forwarded-Encrypted: i=1; AJvYcCVcX2uo6UrftnvMXVojVaNykIHdnmGqOP1tnrgIY0NA5+OLJOV+uIfjE6WmV/0MS1SrDGHEGWhcbLBr1xFYvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyhTEFkdQf6aTqDtmL+EQCxZVxXT76QURheAgXdxLFAsweMTzMr
	6YS6gR6c9f0XiJ1SDdGIJppO8ytNY5SLLTatrWZxd78JdZF/b4XrVdFqzuyWGh7+x7/q2b09NG7
	7PjiVnvfWOMM7A6EGsR3YyhCLLBnSICNr3SkUpzB8vATDpXD8hr5I7TvAYAOwkHY8oqj6WpexFK
	thcbd2NNx9c6ybGrT0f0+qyGSqHj939jO/pXCNvbY0pNs=
X-Gm-Gg: ASbGncuAZKrymsibHuyzurK+0iiGXD8SILM1dGCWkm5GoyP+u1ili7cxp7ecbt12k7m
	Rstw92V+4vT/lEvPJmHdEFE/gZWq0ucYB4xgDEFiimTxTcNjPcvr8N6/4/Dli1pSwmLHoS5npHu
	ItHfY6awYrNqSWKbgACMdy35qft4QDFKnWd43XQQSz/TVtR+v2nYmHGf2o
X-Received: by 2002:a17:90b:2d83:b0:32e:5b07:15dd with SMTP id 98e67ed59e1d1-33bcf8628demr17715366a91.1.1761018959137;
        Mon, 20 Oct 2025 20:55:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ko8D1z3OJ5qSJ0J55ui+yDu4uUJ5mp94CSlL54NGBmQbOCI24DmW0qVUAn07/GKA7z8/0JZN7it7xIEXFkY=
X-Received: by 2002:a17:90b:2d83:b0:32e:5b07:15dd with SMTP id
 98e67ed59e1d1-33bcf8628demr17715342a91.1.1761018958629; Mon, 20 Oct 2025
 20:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251020071003.28834-1-jasowang@redhat.com> <20251020071003.28834-18-jasowang@redhat.com>
 <20251020121643-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020121643-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:55:47 +0800
X-Gm-Features: AS18NWA6SRYqO_k2DCn6HEp5F2mH9mkSTsc-hdveTB2yX3aA9q3if-M-fNGhk9k
Message-ID: <CACGkMEtV89bDjVhNV6=eZz7T0SLi6+17sn2ORNEnBbtifQxN1A@mail.gmail.com>
Subject: Re: [PATCH V8 17/19] virtio_ring: factor out split indirect detaching logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gVkjgWiSq6LSARlKLDkG8zmr_zMh5cn9eBEhdbLsVKE_1761018959
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 12:17=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Mon, Oct 20, 2025 at 03:10:01PM +0800, Jason Wang wrote:
> > Factor out the split indirect descriptor detaching logic in order to
> > allow it to be reused by the in order support.
> >
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
> >  1 file changed, 35 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.=
c
> > index c59e27e2ad68..0f07a6637acb 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -771,11 +771,42 @@ static bool virtqueue_kick_prepare_split(struct v=
ring_virtqueue *vq)
> >       return needs_kick;
> >  }
> >
> > +static void detach_indirect_split(struct vring_virtqueue *vq,
> > +                               unsigned int head)
> > +{
> > +     struct vring_desc_extra *extra =3D vq->split.desc_extra;
> > +     struct vring_desc *indir_desc =3D
> > +            vq->split.desc_state[head].indir_desc;
>
> why split this line?  it's not too long.
>

Fixed.

Thanks

