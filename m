Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDEF1C173C
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741582485; cv=none; b=QMUqpmM66QpsTeBn9gnTM8G6S6LN2cX1TLFQgehx7pEP+lybfR5yGJPJnmNd5UI48TlbNhhEDSFa1mZNIsCUZqxamsN8hgCQqQ1B+6MjCgUrS3FrVA2KoFyYXwaGq3z45jrd/nBX3S/OqntfqNZ0cHMZRkKIrPQwxHtC75Q5Y9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741582485; c=relaxed/simple;
	bh=Ej3GMGlHpVfzanKsBYzCcPizoBxxPLk+vmAC5dehH98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWcYo+T/udKJfcz3Lnvok5AN0m3m2VkO6h1aqHmJ4DODIo5buYmczuGL0JZfo4+99i5YPLwq8Nq3CDTBQhH9raRFb2lbqKRsSaUoMo+Qd5UKI3jawYmoX4OxVp/IbmqPBjjFRJae3abZaVuwZl1QDqZQCxt511TMmMX7LaJKSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxsUKWEC; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxsUKWEC"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 08C6440128
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 04:54:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I2EFFz9qJ6BX for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Mar 2025 04:54:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org CEDAD400BA
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CEDAD400BA
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YxsUKWEC
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CEDAD400BA
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 04:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741582481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbceALFOAXDwlrKk6BKJ6uMiVvCY64LvSE/YeKmsmrM=;
	b=YxsUKWECTRhfU2usd9ltQifPHNpEJsS3pXRXWP5ezzKBSeTOA1YTPgQ6pxhVzp1LXlSs5n
	ZbFN7lEPl6HC+9+rHVY1LxE3iaYhJiXxmUaAdaEuqYutbglBSqb6KGOfVDNuzkS8FoxHAY
	lhfUWkqbOaRi/PX7q+H6PakRQinnUzQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-h7hX87PRPB-wUDCEwIKleA-1; Mon, 10 Mar 2025 00:54:39 -0400
X-MC-Unique: h7hX87PRPB-wUDCEwIKleA-1
X-Mimecast-MFC-AGG-ID: h7hX87PRPB-wUDCEwIKleA_1741582479
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff798e8c93so5411549a91.2
        for <virtualization@lists.linux-foundation.org>; Sun, 09 Mar 2025 21:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741582478; x=1742187278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbceALFOAXDwlrKk6BKJ6uMiVvCY64LvSE/YeKmsmrM=;
        b=EJVmwTQeHYLwHvR06lpNzw283AINO2Cakb6LFAghI7tIuN9nYYbhVX5dmTbpbOvWLo
         FaJfO/JFfpavSBK+UnWBh9oJgKPc4tsyFOD4x1vep7piSTAwPLGxfUBAZXnPjTCaJzYC
         JQIaMPyt9AMYObztjCFzyEqGcOPEFvCuVgg8tb/1dgB3ny8NhhcFwMW18o8fG105HmTJ
         pYNh1yIeVf2W7Irw/l6qdulUYnDWyxTvmD8PbvyKZJ6fp6DL2Lm7rj9aZrhoLlwMVeza
         /pwxDmePSoJMl/E5iOv9lz9qB427cFR5GRIePPCR9m89NeKuwT2Ni3M6wYSdiAXHQA6E
         yHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2wPS0L+F4PW1979zgwyKDCIM9YIuLDFDgDgkWwm3oz/XLqA3udF3t9BwAsEK2Mf/fc1ZcFyqWCYYP5x0HJQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz8OCsNP6wJWfRBpzPANlLo/hQv1BdbbOqaj+a0C9LLr7ldja/n
	B6BEvyIxJt/XrM+a4hIWJ/uu5znwipSMYK0kni88a9yC6fFdTGkWbbRCy3fPkNqYZ+l7OSXnSTC
	26AZ7ve+dRrzOBUEKaLRbC/0E1akDfT37IVubEUKEhTJb/gKHsKXNnM3p7LHHzHxLHzMvxysBiW
	pPnJwHs1mkMEM3OwjstAZjBvEqKIDb2o+sEUaXYe+cmR+7u+K7QyyMSA==
X-Gm-Gg: ASbGnct8KIdpaWOfxVPnLk4NeAy+RdExzy3vonQvfKBcyGvnEzpAx1GHy1mhLTUiTAe
	ohRHsLgvUqzpENAE8XYNFZUwdcctAFZ86tiWRj23b8Ta11owIjyfH9Ik6u6t3NemzGSYia0tf4w
	==
X-Received: by 2002:a17:90b:17c3:b0:2ff:784b:ffe with SMTP id 98e67ed59e1d1-2ff7ce8361fmr20103668a91.11.1741582478658;
        Sun, 09 Mar 2025 21:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOy4wkubfdY4rmjE4nVYH3EzfIy63HlIimFfPmtjEVryCYR1AfKHQgA7u4tps+tBzTrdofki7L500MLPtq6VE=
X-Received: by 2002:a17:90b:17c3:b0:2ff:784b:ffe with SMTP id
 98e67ed59e1d1-2ff7ce8361fmr20103635a91.11.1741582478041; Sun, 09 Mar 2025
 21:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com> <20250303122619-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250303122619-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Mar 2025 12:54:26 +0800
X-Gm-Features: AQ5f1Jp343rEJyx66YRk5WfInd8kOaRENHB4oOZ_ZHycTTo0oYdMS29y7Ll8IMo
Message-ID: <CACGkMEtheNa905789WT20=p84HN9-B6=K7XA8dpB6=jJV0kh-g@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fMMfjq8UBW4RriD_Tw6qRs5eqZNgc7oqjZdNTPJx42A_1741582479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 1:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Mon, Mar 03, 2025 at 01:52:06PM +0800, Jason Wang wrote:
> > On Sun, Mar 2, 2025 at 10:34=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrot=
e:
> > >
> > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > is disabled, and any attempt to use it will result in failure.
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> > >  drivers/vhost/Kconfig | 15 +++++++++++++++
> > >  drivers/vhost/vhost.c | 11 +++++++++++
> > >  2 files changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > > index b455d9ab6f3d..e5b9dcbf31b6 100644
> > > --- a/drivers/vhost/Kconfig
> > > +++ b/drivers/vhost/Kconfig
> > > @@ -95,3 +95,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> > >           If unsure, say "N".
> > >
> > >  endif
> > > +
> > > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > > +       default n
> > > +       help
> > > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which =
allows
> > > +         userspace applications to modify the thread mode for vhost =
devices.
> > > +
> > > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set =
to `n`,
> > > +          meaning the ioctl is disabled and any operation using this=
 ioctl
> > > +          will fail.
> > > +          When the configuration is enabled (y), the ioctl becomes
> > > +          available, allowing users to set the mode if needed.
> > > +
> > > +         If unsure, say "N".
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index fb0c7fb43f78..09e5e44dc516 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> > >                 r =3D vhost_dev_set_owner(d);
> > >                 goto done;
> > >         }
> > > +
> > > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > >         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > >                 u8 inherit_owner;
> > >                 /*inherit_owner can only be modified before owner is =
set*/
> > > @@ -2313,6 +2315,15 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsi=
gned int ioctl, void __user *argp)
> > >                 r =3D 0;
> > >                 goto done;
> > >         }
> > > +
> > > +#else
> > > +       if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > > +               /* When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is 'n', =
return error */
> > > +               r =3D -ENOTTY;
> > > +               goto done;
> > > +       }
>
> why do we need this? won't it fail as any other unsupported ioctl?
>
> > > +#endif
> > > +
> > >         /* You must be the owner to do anything else */
> > >         r =3D vhost_dev_check_owner(d);
> > >         if (r)
> > > --
> > > 2.45.0
> >
> > Do we need to change the default value of the inhert_owner? For example=
:
> >
> > #ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> > inherit_owner =3D false;
> > #else
> > inherit_onwer =3D true;
> > #endif
> >
> > ?
>
> I feel it is best to keep the default consistent.

Just want to make sure we are on the same page.

For "default", did you mean inherit_owner =3D false which is consistent
with behaviour without the vhost task?

Or inherit_onwer =3D true, then the new ioctl to make it false is
useless. And if legacy applications want kthread behaviour it needs to
be patched which seems self-contradictory.

> All the kconfig should do, is block the ioctl.
>

Thanks

>
> > Other patches look good to me.
> >
> > Thanks
> >
> > >
>

