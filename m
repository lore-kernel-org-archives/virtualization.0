Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC931684A8
	for <virtualization@lists.linux.dev>; Fri, 27 Sep 2024 04:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727410140; cv=none; b=lkBvmpp3b575paNyDLmrJdUQfXd66eDLJf16Z5XGwJHM6tRx1CHwZNfj4X4shqHXR+3Y7ufHXzMAgG1zLKSlZhl0pTMK8IZSkR8y2ODTn6w1YfsMqFELBv/s9k82VuhahbaODxR1jFiXRIOXZakGLBy+hY5SSmnQVep+fWhnfmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727410140; c=relaxed/simple;
	bh=Zg6LNszRJx5XwnL9b7gSKyZziRWcnHM9lvGCU85QC8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KebiszSW2C7jqv3rmz/SR1z5jWNoOA+elPp94GLuOXmSdqsSHTDdbHWItPZzkceraGZhoLOq3pvkbsTOqKY61uADt1mjGGx8FXysJEoGjFetVIPzvQ90hJOUW7wq5X5t1wp5qZ2T6Au0ERmyyZ/XMaP/6l+veG4Abe0MEfyRcHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f388gdhz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f388gdhz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727410137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uikubQm93pgeuA38Pb0WtPPWyXruZHs/Z/+sPbjQZxE=;
	b=f388gdhzl3alffY+K4D3ocQFPhnWnrx18MFV/WApU5IM2rSZC3iAaXt7pD8+rC30XM+z9v
	6voBfXOMyp2aLuN2NFNpXrwvqQmAghuDzebnW8t40Ys1QjFcQiVaDvSUflFWBgX1ZgEUEU
	3Pbjhytl2zm4AaqIzJZX+BVwgNl8zvw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-hI82R1ryPTGhgPSJULYp-g-1; Fri, 27 Sep 2024 00:08:52 -0400
X-MC-Unique: hI82R1ryPTGhgPSJULYp-g-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e07a5f4d44so1919124a91.2
        for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 21:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727410132; x=1728014932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uikubQm93pgeuA38Pb0WtPPWyXruZHs/Z/+sPbjQZxE=;
        b=dV+1QHS7uOBKXghicT5zxXW06OA8s9NtMJ9zhl8j/VMlRND5iEGmDn51BtvrE/38qk
         HBP105jRT4ihpSutQsqEdwqldlkCiP9Snazhuox/ax6qIxpZpiRDR/KDaaQqN564iKOU
         KRDOZBzrQcbKnvOS62w0Tk58vxxmN8EjKpgghxPaEPKLPNF3P/S3VtyghoQK/guRe1Vt
         vwwlrvS4nSTre4q42cx0dY9Y1ne5hG9nL7Rxg7icqiM0ZS/qD3aMqFMWvJB+SXxi81Bu
         85zRia4DSOh3GdkSeTVYq6nzOZG5oiY+ChaZd3L6TZ+c2TEnZhO04Y/lnV0kJzst0k80
         uFFw==
X-Forwarded-Encrypted: i=1; AJvYcCWRZAhf51+shllwpywdTBpXupPOJ+ezAfcOiB6kGRfxkk7NbByjNoKnf/4h/fPGUsDe9rwOFk7C/MYKE42/fw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8sHrJ2TfR9HtY7OQbvjMbwUNjKTR5vBabLvs+wxnqmap0GQzb
	NCZevldQMRt83MH9DWJN0Ejrtp+eDEpdkSwVqAyNODonDo0r4gspNqW9XdbzQUVYwjve9D1TYWH
	Qqo41muhB8Vc4T+RfkU2qLAdEjoy+Vpg1YezP4kbxymy8rzgZdsbdzwZ6fZ8AW9Q4ITNSOFXUTn
	hXvMVkhJJEqTGRYcDLvqbRtVOuLhyWYKtacziywm8=
X-Received: by 2002:a17:90b:1282:b0:2d8:b205:2345 with SMTP id 98e67ed59e1d1-2e0b8c5664bmr2204678a91.23.1727410131763;
        Thu, 26 Sep 2024 21:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+8JQn190D7srk2QyvuVMaX71FzOF+V2fyLYR5DJhlgEFRRsQ9G8eppOyTOyspFlZ71QpWC6SOUbggYiTetgg=
X-Received: by 2002:a17:90b:1282:b0:2d8:b205:2345 with SMTP id
 98e67ed59e1d1-2e0b8c5664bmr2204660a91.23.1727410131365; Thu, 26 Sep 2024
 21:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240926022557.8771-1-quic_jianguos@quicinc.com>
 <CACGkMEu-r2K1Xb-797YnK80-YeKEsErSe=BBP=xMbBvHcDv6qA@mail.gmail.com> <20240926020709-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240926020709-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 27 Sep 2024 12:08:34 +0800
Message-ID: <CACGkMEshXHRDtxeCJ2VOMh46NMJyYsEo_eFwa4_4TDTa0mA9XQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add polling virtio-mmio device reset completion
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jianguo Sun <quic_jianguos@quicinc.com>, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, virtualization@lists.linux.dev, 
	Sreenad Menon <quic_sreemeno@quicinc.com>, Anant Goel <quic_anantg@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Sep 26, 2024 at 11:21:25AM +0800, Jason Wang wrote:
> > On Thu, Sep 26, 2024 at 10:27=E2=80=AFAM Jianguo Sun <quic_jianguos@qui=
cinc.com> wrote:
> > >
> > > We write 0 to device_status to initiate reset of a virtio-mmio device=
.
> > > The reset operation itself may or may not be completed by the time
> > > write instruction completes. Add polling device_status to return
> > > 0 to ensure reset completion before reinitializing the device.
> > >
> > > Change-Id: If15d11d090dfd0d4972ad35f49af03e076872413
> > > Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> > > Signed-off-by: Sreenad Menon <quic_sreemeno@quicinc.com>
> > > Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
> > > ---
> > >  drivers/virtio/virtio_mmio.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmi=
o.c
> > > index 90e784e7b721..cf1a4a3dd35d 100644
> > > --- a/drivers/virtio/virtio_mmio.c
> > > +++ b/drivers/virtio/virtio_mmio.c
> > > @@ -70,6 +70,7 @@
> > >  #include <linux/virtio_config.h>
> > >  #include <uapi/linux/virtio_mmio.h>
> > >  #include <linux/virtio_ring.h>
> > > +#include <linux/delay.h>
> > >
> > >
> > >
> > > @@ -269,6 +270,11 @@ static void vm_reset(struct virtio_device *vdev)
> > >
> > >         /* 0 status means a reset. */
> > >         writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
> > > +       /* After writing 0 to device_status, the driver MUST wait for=
 a read of
> > > +        * device_status to return 0 before reinitializing the device=
.
> > > +        */
> >
> > Is this copied from the spec? I can only see a similar description in
> > the PCI but not MMIO part.
>
> Not in spec. We can add something like this in spec, but it
> can not be a MUST, has to be a SHOULD.
>
> > > +       while (readl(vm_dev->base + VIRTIO_MMIO_STATUS))
> > > +               msleep(1);
> >
> > Again, we probably need a feature bit to unbreak existing MMIO devices?
> >
> > THanks
>
> We can do this unconditionally since legacy devices return 0
> immediately,

The problem is that we can't audit all legacy device implementations.
Current driver still works if a device doesn't reset status to 0.

> feature negotiation happens after reset, won't be useful
> here.

Right, as said in another thread, it could be mmio specific flag or version=
.

Thanks

>
>
> > >  }
> > >
> > >
> > > --
> > > 2.17.1
> > >
>

