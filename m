Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE191A5BBA
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Mar 2025 09:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463534; cv=none; b=eq2DYUGG5UPBHUyIvdYf1qeEEpR13cJSpLHE90R0qjtqilKv8LzO0AytzlZ/jFwCaQt2rMjQZrsudLASM1ln5+c5PDHvHopejilach6uelpU0CFZyguTawASNf3HjrDFO9UHqkKTO5OCWslKMUG3v1CqDvIVB+nBCE/DXjiVU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463534; c=relaxed/simple;
	bh=NvwTEgcqIQvgrhKODadoVctVr9hgRnboYsTfyWDoafM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGBj3CVre9B4VtUUBQNszAxPOoNt05D5+4En01p1NB0dvGCbSTyHjGTRfuCQS/7lsx6Tmf+UMDHM6qcmo5vj86ZW3b7gjyck5lwIvbkM1QpcXW1t+EOUwsEfs/t1QUFhN+gBTPxJd9Q896QJD9mb8e0+ZwGyvHc4B3WO0332vME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DJTrLui4; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJTrLui4"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A3EC40996
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Mar 2025 09:38:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2hqAxz_vF4BL for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Mar 2025 09:38:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4D86540679
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D86540679
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DJTrLui4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4D86540679
	for <virtualization@lists.linux-foundation.org>; Thu, 20 Mar 2025 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742463529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwCB+221NA1HlCUbvrDRan+r1+9WR16dtU0FT1clSQc=;
	b=DJTrLui474hwBRrn6pQkxAbs4zdE78dILN4cRolVWF0STJPm1wJvmCHnhAn0qdiVSfT6zm
	PrxuiaB/ZFvVXgodycmhQ4mPgrIOKmdeFvOZoYc836/yrUVpk2ds8PXOTXrAbfDB4qUN8r
	BAf+bLpV9rQb6WZuJlcN+funn7yG/q8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-8A6Z76l9Mh-XefUvNzqx-Q-1; Thu, 20 Mar 2025 05:38:48 -0400
X-MC-Unique: 8A6Z76l9Mh-XefUvNzqx-Q-1
X-Mimecast-MFC-AGG-ID: 8A6Z76l9Mh-XefUvNzqx-Q_1742463527
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac384a889easo160900866b.0
        for <virtualization@lists.linux-foundation.org>; Thu, 20 Mar 2025 02:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742463527; x=1743068327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwCB+221NA1HlCUbvrDRan+r1+9WR16dtU0FT1clSQc=;
        b=bxu3m4UVRorusNmsehux9nET+QFFe10+vkSEsEhkaSJ92RgvrDaayyunIZSfPcdXgM
         mpi6XR5tMFKOLxGokZKwCtUWEGjKlRSTvgTBwvhHVVwOnnmUgOCdpno6oyaUqeAdYaqX
         hUl21tMFqzshSnAxQWlB3ritawJ8vYGjizIiQw5h8Xo1dhKwl1r+ZWZQrGy+RHznwMTA
         KEAbvc3ffxpdGwVs/IV2knDlaNibBujldUv+z5uPVRG/LT2ns4eFNyCaIN+xeKY7KTVo
         bH3lUvPkWgUFU2i8pGBvpPJUOGkSwqY6BZ3Gr1phZ7Te+4PaUWVkqj/QP+umjljELlOl
         YcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEu1qez7CEfTL2O12lMvulA/5lH1WGlXP3Z1qAszq4DowgFRqOgIHo9RugUQJrvmfbCDZrV/WZICav0YYa9A==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz29KnSK9tZZZGy8zssHDR+otnx9l33S/NhB+PyXQeRe9Ck7Jrp
	TWhRKCUnGRiQSfu0eSh/SOmmETuog5pRcj7bxw5sdK3r6g1mO/cCi+iJTKJYdPX0RK0TxTC5fmC
	yTkgei2/U3n/jsqtyS6PiPpCjY+njoZ/Ku1pqHh/QOqk3GxZtgq6nRk090d2AZXyLGjGO3y5W5R
	qiNYLOj6UtIYZkqg5wLLG3E8ZIeY+gVcoDxZw2KrVMKAau9OWBAq4gnQ==
X-Gm-Gg: ASbGncvkv5OrbU+CLNgDVmz5b6TNqFF3HzlsAI7hogjejthQ/iMaDSMvfD2qaZfHds5
	F84QoJAYOQ3dLg2fTY+bVLIGCWiKjhoaR8fvP8QooGxDvxbGHFKXU+tWe0v4RSob9KUvFtQLDYA
	==
X-Received: by 2002:a17:907:3f07:b0:abf:6a8d:76b8 with SMTP id a640c23a62f3a-ac3cdb97e7fmr266786366b.11.1742463526695;
        Thu, 20 Mar 2025 02:38:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS736rGGx2A8+WSczB6W42Z9CwPd0Gn80UV17ss/taXw3kNNvyUUG1eyIF1rnivt0a3MXU2if5rE8Mt1epTsg=
X-Received: by 2002:a17:907:3f07:b0:abf:6a8d:76b8 with SMTP id
 a640c23a62f3a-ac3cdb97e7fmr266784166b.11.1742463526251; Thu, 20 Mar 2025
 02:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com>
 <20250303122619-mutt-send-email-mst@kernel.org> <CACGkMEtheNa905789WT20=p84HN9-B6=K7XA8dpB6=jJV0kh-g@mail.gmail.com>
In-Reply-To: <CACGkMEtheNa905789WT20=p84HN9-B6=K7XA8dpB6=jJV0kh-g@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 20 Mar 2025 17:38:09 +0800
X-Gm-Features: AQ5f1JqJXFebt85nCNRI8OoWt-Lrzu6HfqTrrWTpquRBRX6_lR5liGMiQoa1h7Q
Message-ID: <CACLfguW-x76eBcrbicLqLirWDPkpmPB=v48mxVRjWmUwg24C2g@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>
Cc: michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HdDCImMl2TVJq7fcSSsGkOEI4Ny8xXneviEZ_TW_QSA_1742463527
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping :)

On Mon, Mar 10, 2025 at 12:54=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Tue, Mar 4, 2025 at 1:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> >
> > On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> > > On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wr=
ote:
> > > >
> > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > is disabled, and any attempt to use it will result in failure.
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > ---
> > > >  drivers/vhost/Kconfig | 15 +++++++++++++++
> > > >  drivers/vhost/vhost.c | 11 +++++++++++
> > > >  2 files changed, 26 insertions(+)
> > > >
> > > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > > > --- a/drivers/vhost/Kconfig
> > > > +++ b/drivers/vhost/Kconfig
> > > > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> > > >           If unsure, say "N".
> > > >
> > > >  endif
> > > > +
> > > > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > > > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > > > +       default n
> > > > +       help
> > > > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, whic=
h allows
> > > > +         userspace applications to modify the thread mode for vhos=
t devices.
> > > > +
> > > > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is se=
t to `n`,
> > > > +          meaning the ioctl is disabled and any operation using th=
is ioctl
> > > > +          will fail.
> > > > +          When the configuration is enabled (y), the ioctl becomes
> > > > +          available, allowing users to set the mode if needed.
> > > > +
> > > > +         If unsure, say "N".
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index fb0c7fb43f78..09e5e44dc516 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, uns=
igned int ioctl, void __user *argp)
> > > >                 r =3D vhost_dev_set_owner(d);
> > > >                 goto done;
> > > >         }
> > > > +
> > > > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > > >         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > > >                 u8 inherit_owner;
> > > >                 /*inherit_owner can only be modified before owner i=
s set*/
> > > > @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, un=
signed int ioctl, void __user *argp)
> > > >                 r =3D 0;
> > > >                 goto done;
> > > >         }
> > > > +
> > > > +#else
> > > > +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > > > +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n'=
, return error */
> > > > +               r =3D -ENOTTY;
> > > > +               goto done;
> > > > +       }
> >
> > why do we need this? won't it fail as any other unsupported ioctl?
> >
> > > > +#endif
> > > > +
> > > >         /* You must be the owner to do anything else */
> > > >         r =3D vhost_dev_check_owner(d);
> > > >         if (r)
> > > > --
> > > > 2.45.0
> > >
> > > Do we need to change the default value of the inhert_owner? For examp=
le:
> > >
> > > #ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > > inherit_owner =3D false;
> > > #else
> > > inherit_onwer =3D true;
> > > #endif
> > >
> > > ?
> >
> > I feel it is best to keep the default consistent.
>
> Just want to make sure we are on the same page.
>
> For "default", did you mean inherit_owner =3D false which is consistent
> with behaviour without the vhost task?
>
> Or inherit_onwer =3D true, then the new ioctl to make it false is
> useless. And if legacy applications want kthread behaviour it needs to
> be patched which seems self-contradictory.
>
> > All the kconfig should do, is block the ioctl.
> >
>
> Thanks
>
> >
> > > Other patches look good to me.
> > >
> > > Thanks
> > >
> > > >
> >
>

