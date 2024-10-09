Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8165183CA7
	for <virtualization@lists.linux.dev>; Wed,  9 Oct 2024 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462295; cv=none; b=JUORf+ngbk8aQ9psxwaTXh2p35cQtpBsbbvi3lvwdPgNvcFgCYUPjqul2MaOfI+nbv0H5jtPO9d4JHQvvItGd7nDVs5cDByUgQJ4cWIHDxGFT+MGKG1MUkvnl34yy2b3ZLGxNMB05s4UdFBw0aRKplwYp8nXLOABMmJuVu4xaeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462295; c=relaxed/simple;
	bh=geq+oaru+FJ7cHgJjBhnXacClS6n7uhJiBh7uKmXKCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/iuh48casIgLYc9sQ48Bmq92k7HIyGQH92NG6nsJX6TQHxhBgXNEwvofEQbmXWB0jFQht0TrN+gImkXP5mncXfr/qx6SUQ4uKkBp42sjGaSHUGaqYD4ZpXT0up0TnTBlSmAllungXgkoWfjWz67v/KIoVRx1Un8QiiMvZkIs88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRK5Twif; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRK5Twif"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728462292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vFvkVEd97F6gZHpNwA8fDaIVezT+euFnGNAB8ETWAg=;
	b=DRK5TwifxAb1RRzhek7dXg1ZlDEa+DKKXoXo4Fxk1h7Rbv5PL2NHDeVj7UzJCxTO7/JJh8
	7aw3UyJJEI6wv924+k/5bL/VgEtDhy/fExkGZ7YxFaNO+lllQRVYA/uqNiQtvyGtMiR6lG
	gBZd84oZKbqsHFcEW8cLR/KLyh1V8H0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-7W7EAKOcORi7Iwa1Ucwcxw-1; Wed, 09 Oct 2024 04:24:51 -0400
X-MC-Unique: 7W7EAKOcORi7Iwa1Ucwcxw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e18b6cd304so6562141a91.0
        for <virtualization@lists.linux.dev>; Wed, 09 Oct 2024 01:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462290; x=1729067090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vFvkVEd97F6gZHpNwA8fDaIVezT+euFnGNAB8ETWAg=;
        b=um0pG+3HDE48oj/3rW/ATtzLPKduc8ydBXNBjP72yekmMkLU3/pk9+13p/x1w1tz19
         5nmPG3yO4GztqIpPaZA3C17EBQosbQV72hiUAlpZyIBI73A6uEViJOXw2rVfLlWlZAK5
         5p9XXiuRPCHYGwXl18HR5lmJOIIc5xRMhbsRJk2/vT0DKtp5mfZsLTWVUo/4Bh76LT4E
         S5BjcmNgAptB1I2YHR9yu/VeAnsvAuhKNUcSpjIMf1dDhxGUVYOaGNgwewBEeAUFaP4b
         938FW5XlOcORXT8NqLFHhAIEdDmvST68Xth6829OJ3QMEtzrpvZw6PyfCuPJSZt9eP2b
         Wd+A==
X-Forwarded-Encrypted: i=1; AJvYcCXh1c0lGGLwZNM5De8IIP/ZPvUEW2GJVwwlYc8JAgZYNmygrf7Q9dJDyt3kDUEX71TfFwwN3/iONYLaFdtsjg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw89/fnu8zEOFknTm4lGzBfv1Hvzqqo0sUfna57BrWM9p5RtvqE
	fAcAG+70j8teu/MeOo+EajotBQ3B+6QqieHypz+vjYAiMM7CKMZ3J3r6Hd62pUzfCDz0uwfFLEe
	9teNAnyeNz0JfIg68RtyK4CSigyNJ8dZheiMeHdq3McU6aFXd/brtizK1AVyg8/pDbyF9jHcq2L
	VgIDYw3LH9YbwwDbu2LWvDOIpUTpUsScn2ESIa5UA=
X-Received: by 2002:a17:90a:e518:b0:2d8:9226:aa94 with SMTP id 98e67ed59e1d1-2e2a22e6ef7mr2139527a91.1.1728462290319;
        Wed, 09 Oct 2024 01:24:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwwUjxk7XX+SOdTlDiOu0nqaZzNpfhX5wfCXLAbqwGFm4XyrMtvc8yfci2MUwPr/hGDgJK9FaoN65hC3Ek3hE=
X-Received: by 2002:a17:90a:e518:b0:2d8:9226:aa94 with SMTP id
 98e67ed59e1d1-2e2a22e6ef7mr2139506a91.1.1728462289884; Wed, 09 Oct 2024
 01:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240926022557.8771-1-quic_jianguos@quicinc.com>
 <CACGkMEu-r2K1Xb-797YnK80-YeKEsErSe=BBP=xMbBvHcDv6qA@mail.gmail.com>
 <20240926020709-mutt-send-email-mst@kernel.org> <CACGkMEshXHRDtxeCJ2VOMh46NMJyYsEo_eFwa4_4TDTa0mA9XQ@mail.gmail.com>
 <20240929125700-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240929125700-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 16:24:38 +0800
Message-ID: <CACGkMEvSOLA58rPqJfRZek=nk0n6Q8vL4iKrO056rGzWRrf6Rg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add polling virtio-mmio device reset completion
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jianguo Sun <quic_jianguos@quicinc.com>, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	Sreenad Menon <quic_sreemeno@quicinc.com>, Anant Goel <quic_anantg@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 1:51=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Sep 27, 2024 at 12:08:34PM +0800, Jason Wang wrote:
> > On Thu, Sep 26, 2024 at 2:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Sep 26, 2024 at 11:21:25AM +0800, Jason Wang wrote:
> > > > On Thu, Sep 26, 2024 at 10:27=E2=80=AFAM Jianguo Sun <quic_jianguos=
@quicinc.com> wrote:
> > > > >
> > > > > We write 0 to device_status to initiate reset of a virtio-mmio de=
vice.
> > > > > The reset operation itself may or may not be completed by the tim=
e
> > > > > write instruction completes. Add polling device_status to return
> > > > > 0 to ensure reset completion before reinitializing the device.
> > > > >
> > > > > Change-Id: If15d11d090dfd0d4972ad35f49af03e076872413
> > > > > Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> > > > > Signed-off-by: Sreenad Menon <quic_sreemeno@quicinc.com>
> > > > > Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
> > > > > ---
> > > > >  drivers/virtio/virtio_mmio.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio=
_mmio.c
> > > > > index 90e784e7b721..cf1a4a3dd35d 100644
> > > > > --- a/drivers/virtio/virtio_mmio.c
> > > > > +++ b/drivers/virtio/virtio_mmio.c
> > > > > @@ -70,6 +70,7 @@
> > > > >  #include <linux/virtio_config.h>
> > > > >  #include <uapi/linux/virtio_mmio.h>
> > > > >  #include <linux/virtio_ring.h>
> > > > > +#include <linux/delay.h>
> > > > >
> > > > >
> > > > >
> > > > > @@ -269,6 +270,11 @@ static void vm_reset(struct virtio_device *v=
dev)
> > > > >
> > > > >         /* 0 status means a reset. */
> > > > >         writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> > > > > +       /* After writing 0 to device_status, the driver MUST wait=
 for a read of
> > > > > +        * device_status to return 0 before reinitializing the de=
vice.
> > > > > +        */
> > > >
> > > > Is this copied from the spec? I can only see a similar description =
in
> > > > the PCI but not MMIO part.
> > >
> > > Not in spec. We can add something like this in spec, but it
> > > can not be a MUST, has to be a SHOULD.
> > >
> > > > > +       while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
> > > > > +               msleep(1);
> > > >
> > > > Again, we probably need a feature bit to unbreak existing MMIO devi=
ces?
> > > >
> > > > THanks
> > >
> > > We can do this unconditionally since legacy devices return 0
> > > immediately,
> >
> > The problem is that we can't audit all legacy device implementations.
> > Current driver still works if a device doesn't reset status to 0.
>
> These would be out of spec though, would they not?

Yes, but it would work. Should we care about those?

> The reset value for the register is 0, and it is R/W.
>
>
> > > feature negotiation happens after reset, won't be useful
> > > here.
> >
> > Right, as said in another thread, it could be mmio specific flag or ver=
sion.
> >
> > Thanks
> >
> > >
> > >
> > > > >  }
> > > > >
> > > > >
> > > > > --
> > > > > 2.17.1
> > > > >
> > >
>

Thanks

