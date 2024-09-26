Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D111D85947
	for <virtualization@lists.linux.dev>; Thu, 26 Sep 2024 03:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727322649; cv=none; b=poJ46tLKlIHODxrC1M+PyQAyfXYR36IhSOlecEyI9IYAm0IZtHnax0wtzS0I0xqua+yg9q4Sv0zsYGH3GWts3Is55y32x3qU+2VyWiWW80xRZig/V1g3OPbnZ2EvB5H6sZ01rVWFz9ayFir6IjCUC4CHCywPw4Eb4LsCHSAG4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727322649; c=relaxed/simple;
	bh=rkqlgz/w9KoztI60QzcrLjkNGAiRyugh0FQ9+AX+cFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbMXNt9mLQrqq0xNiUo8Qsckqk2dqI7PHm27oBi4wE/y3TmzeH1OhLc8jgnOO4H8qfRsYZkP21Ruco2WoUydVFfC7DH1sBeifVzDJiMq4ZTT6V5byVVffX0xNY2l4BDT1N8683ftdoT5ZdXlr2iDddkPxCHFMQYB6FOlqW85yfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iolnzEnf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iolnzEnf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727322646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGr55FlRF+IxJexl+l6ucqpPYc2WvNGscQtG8648wao=;
	b=iolnzEnfIFQERGmCyttkCtqR7HJtdqR3GhbC6T4bUIZwQEPuvrAwXnMsnjuOootSRf3rOJ
	mh/Eh4bQOrEV3vHxd4+4tPm/ZQe4xUGhLyv/zPfVfyOiYhvBqrTrAyw7JIl1n8Loje3cia
	+H8H9Ruie0S6leP1XvxLEzEaXQUyCac=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-R7gXOmJiMDWuG5yUV2DvZg-1; Wed, 25 Sep 2024 23:50:45 -0400
X-MC-Unique: R7gXOmJiMDWuG5yUV2DvZg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2db6527b84aso757968a91.3
        for <virtualization@lists.linux.dev>; Wed, 25 Sep 2024 20:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727322644; x=1727927444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGr55FlRF+IxJexl+l6ucqpPYc2WvNGscQtG8648wao=;
        b=WkjYfofyGPal0HTFXsP/R+v7fjfDXKlbeftj1a7NDNzFBqEtoZ+U6e2Dg3KFo0O3q1
         qQx4RWTwuXt+YG2jiFVZQ0Gzd35eSX9t/oiRYayc14HDculQA8pVY03hkQqNnfBMipy/
         OtjmHEvTfHdSRjXiSPiWiaYovPMeIVk67tZ5lBCi4ER8dHJJrO1V4bH5Neua8/h9QCLs
         jtYY0XNcZw38duHat+1NLNq5LF+b+D0eWw7e5YkP0wf7lTVwkAU/Nb1sO4rfbxEkDSUR
         YQfk3X0X6EiCmKTEP/HTadEXLNzcd+/xBdFquCNOQfb+w7BK6WQjFf2YI64ndU0+U2OX
         XFEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg0kqTDub+GhOD+ieW1Kgrfx+qjEhYklvJ4p2wZJ5eyj7AEqU8l6qBvsupcJKwsmGH/xhmYI8Hz5960YzsLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyiw+DR9yflDvzNEzlpP6OwL5hkgQjPrAM+RwgiYW30Jscfl6Eb
	Fu0xooTTSOYtTxk/j4knN/qGgsiPp3IkJ1FJyBOzZ5GzCSPoBXRG5Ttfeib66JU3NV1fPjn7bAl
	voAXHqVcftWo80BZvBaIgKRA/6IXhbUd75Yp1lIhe6ODfsSqFq3DCnLTUomAiJxp9Dfy5bhWhZv
	zJELjZw9YI6vwKr3YGD+24xmydr9uJx3rbISCWKt1VVrkwZmEeXQ==
X-Received: by 2002:a17:90a:f490:b0:2d8:e524:797b with SMTP id 98e67ed59e1d1-2e06ae77c24mr4571796a91.18.1727322644620;
        Wed, 25 Sep 2024 20:50:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDqaV9bEpaQRvqMY4WvLvCVZff5F4Bvj8hRNPJeAHf1quOQDG83hq/plriV1BhO3RVH9UxhgnMUytqxxS7WMY=
X-Received: by 2002:a17:90a:f490:b0:2d8:e524:797b with SMTP id
 98e67ed59e1d1-2e06ae77c24mr4571776a91.18.1727322644127; Wed, 25 Sep 2024
 20:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240922123435.17946-1-quic_jianguos@quicinc.com>
 <CACGkMEv1ndVVwVrD1J_ghHpyZB0=3sLdSrXxchZ2QoQzMJihdA@mail.gmail.com> <DM5PR02MB3638C8F46A0F3088DE06402EF06A2@DM5PR02MB3638.namprd02.prod.outlook.com>
In-Reply-To: <DM5PR02MB3638C8F46A0F3088DE06402EF06A2@DM5PR02MB3638.namprd02.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Sep 2024 11:50:32 +0800
Message-ID: <CACGkMEuLdxbRxZYqKW1akHJ_Jjse4OatLEVmH4QFsM_K+iAr_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Virtio: Add CONFIG_VIRTIO_MMIO_POLL_RESET
To: "Jianguo Sun (QUIC)" <quic_jianguos@quicinc.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"Anant Goel (QUIC)" <quic_anantg@quicinc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:31=E2=80=AFAM Jianguo Sun (QUIC)
<quic_jianguos@quicinc.com> wrote:
>
> Hi @Jason
>
> Both hypervisor and backend device may need to support virtio-mmio device=
 reset

Then you need to patch the virtio spec first. Or it is already
supported by the spec?

> Adding CONFIG_VIRTIO_MMIO_POLL_RESET is for the system that has such supp=
ort.

And we will probably have a feature or transport bit/flag for this.

Thanks

>
> A config option (feature bit) is a better approach.
> Thanks for the review.
>
> BR
> Jianguo
>
> -----Original Message-----
> From: Jason Wang <jasowang@redhat.com>
> Sent: Tuesday, September 24, 2024 3:39 PM
> To: Jianguo Sun (QUIC) <quic_jianguos@quicinc.com>
> Cc: mst@redhat.com; xuanzhuo@linux.alibaba.com; eperezma@redhat.com; virt=
ualization@lists.linux.dev; Anant Goel (QUIC) <quic_anantg@quicinc.com>
> Subject: Re: [PATCH 1/2] Virtio: Add CONFIG_VIRTIO_MMIO_POLL_RESET
>
> On Sun, Sep 22, 2024 at 8:35=E2=80=AFPM Jianguo Sun <quic_jianguos@quicin=
c.com> wrote:
> >
> > Add CONFIG_VIRTIO_MMIO_POLL_RESET to as an option to enable
> > synchronous reset for the MMIO based transport for virtio.
> >
> > Change-Id: Ifa7e29b4c0cfa26922535f921c6ab69eacdc4cfc
> > Signed-off-by: Jianguo Sun <quic_jianguos@quicinc.com>
> > Signed-off-by: Anant Goel <quic_anantg@quicinc.com>
>
> Any reason this is not a feature but a config option?
>
> > ---
> >  drivers/virtio/Kconfig | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig index
> > 42a48ac763ee..fb17b1078d53 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -188,4 +188,12 @@ config VIRTIO_DEBUG
> >
> >           If unsure, say N.
> >
> > +config VIRTIO_MMIO_POLL_RESET
> > +       bool "Virti-mmio device synchronous reset support"
> > +       depends on VIRTIO_MMIO
> > +       help
> > +         Say y here to enable synchronous reset for the MMIO transport=
 based
> > +         virtio device. After writing 0 to device_status, the driver m=
ust
> > +         wait for a read of device_status to return 0 before reinitial=
izing
> > +         the device.
> >  endif # VIRTIO_MENU
> > --
> > 2.17.1
> >
>
> Thanks
>

