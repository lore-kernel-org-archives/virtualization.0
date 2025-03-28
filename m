Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A9212FB1
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 08:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743150302; cv=none; b=StiE2po/fy7PZmLWWbvuVR0LWm2Tqm9SU2Gbiaj5KUNhCmLA5zdnfKIR9Gg9QJTxgUoH0Pq+P0u7Qo9Nncg6qOmAqKkP/URdqDTnSZRL9avcq0aZzDViN6lUIMG+qQGoTGkS3AKPPqaYhshfz9MCFUnSHc76hwDFo5E+M5ncKMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743150302; c=relaxed/simple;
	bh=2SQ18ucLJlA/WDehkdf9V9I8lMbGgu+W41AmkvrU9lA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAWvxWwToExWcPKtr4ng8SB2HhgBgp4lhlpMUYD3qJ6/MxPueDWJ2NVnQFtaHQ1c2uMRXw7wwzYWOvmmnK7JmziZ0ORlb5QBvHhoYwkLYWzqdBU5QSToOsQeiPbqNkAAbArtc4GfiUmVJDtIgKKN+uzffebOnLaix+0Q1bAMsnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYddYJ2n; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYddYJ2n"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 92D8742193
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 08:25:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIb5lcMGzM26 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Mar 2025 08:25:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DEDED41E69
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEDED41E69
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DYddYJ2n
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEDED41E69
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 08:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743150298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BByPHc1EbJ+bRVfFsgitlx6Z4FNGFeovzxNX8sqbyWM=;
	b=DYddYJ2nugGS7NMIjFembvaw2Mpal9YM4NkhetUJorV8RsgoiXdD4p/PfAMmY1/UNNffAJ
	lV2wKzrrGmeRkBVyD69xMFkYBhYiLwU0jYMoQkShorlUIyA05xkOwexTXjRwHPfvfbtn4U
	0gl3yzNciKyYVUv3btYPJlsZdqd2Bko=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-3jkSCIPNPaOnjh6fpp0A5Q-1; Fri, 28 Mar 2025 04:24:55 -0400
X-MC-Unique: 3jkSCIPNPaOnjh6fpp0A5Q-1
X-Mimecast-MFC-AGG-ID: 3jkSCIPNPaOnjh6fpp0A5Q_1743150294
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac3e0c13278so146642466b.1
        for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 01:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743150294; x=1743755094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BByPHc1EbJ+bRVfFsgitlx6Z4FNGFeovzxNX8sqbyWM=;
        b=urYpZmg2PBH8d0eFt8xvTpNqPDlgR6JOgFqFUmMKNk5y5NUTlhpbnIOIz7LJBSKLKA
         8rC1atOc1WxLgRNCHKnoiYmbNSKwTU7Zxxev3ZpdWmvo/ClmaMlrxqtzuwWqk0tjiB2T
         fdtCMbPzRH4oN7SbP6nV2Ydcz6+HN+XrZu5TnGcAfH6AYOY5y9R3c4Xra9ZNb+rPzNwj
         TCtN+NrImAOJXboE4BllQV1tLZRGOV+oHSMgnXCpVhz0U23Vo6aLxZMRGZpDWztKKbJ+
         MM3WkE/8GHmofzqVrv+ProtO30VRN27NmH8Bx9wvNAE+sOeX4tYcsdgCg5PSVREzyjiC
         ij2A==
X-Forwarded-Encrypted: i=1; AJvYcCUvA8PuVaHEBrbCOB29IkITUT2NT1DDsFWuNi4SmPNlpiFMBpoe28/g09zzokmuBm1BVE5pqHWRc185G2jPKA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxiJTkMrT34RpXh8shPg8hQH+TVUKBZca5qw2xqUFs//3h/DGdE
	0/8wddjQfCN8p0lcep97Lq20761C6FCwh6s2PcUeZdqK2N9oGYPMuayMfxPHlrUfmtEaMm1P58G
	fVdN0syw5ktrBSOa+5wCYaDvC8FR5R1ZRfhWdPDe/xbrpQu3//sMLPDMce9UQyaLMkBFFefbZVF
	6G0gIKxInL/mYzeIGJMliwr5TPYTULQbgsIhlSw9EkhAkwFhm+CwHj7Q==
X-Gm-Gg: ASbGncsUMesh18cUO7A0w5CFBUPlY/v5EtfeW97KT4ZtNzAG7wPc/vcR39Lapy3b5bL
	hzynsOWe285xAlvt54jNh9srFvFbmO1WV5Ahsta8bxZhSYOJoeMESNKqU8iBV/U41BXRTYT7ipw
	==
X-Received: by 2002:a17:907:3da1:b0:ac2:6bb5:413c with SMTP id a640c23a62f3a-ac6faf45fbcmr606738566b.31.1743150293892;
        Fri, 28 Mar 2025 01:24:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtMhfeTWQPQjJeKYr+nJHbqXTHzDbGeqlUciCnVAp35iT66VTiKxpvEvBTFOnIR4IcWISTOodMTXSNsbNA918=
X-Received: by 2002:a17:907:3da1:b0:ac2:6bb5:413c with SMTP id
 a640c23a62f3a-ac6faf45fbcmr606736266b.31.1743150293417; Fri, 28 Mar 2025
 01:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250302143259.1221569-1-lulu@redhat.com> <20250302143259.1221569-9-lulu@redhat.com>
 <CACGkMEv7WdOds0D+QtfMSW86TNMAbjcdKvO1x623sLANkE5jig@mail.gmail.com> <20250303122619-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250303122619-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 28 Mar 2025 16:24:16 +0800
X-Gm-Features: AQ5f1JqvVP-O68vnR03mHsDRfnjJbKsFvNhVjO1Pg4znL65FpHw8MZuudqkctsg
Message-ID: <CACLfguWmXVDr6hgGvCEsNBpTEd-3zePR2fMk6BhBf7z8F4r0uA@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K9C5rC5QopIgb2GZekbTsKd7CD2m8Tok_qjvjeE5Si8_1743150294
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
Sure, will remove  this
thanks
cindy
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
> All the kconfig should do, is block the ioctl.
>
>
> > Other patches look good to me.
> >
> > Thanks
> >
> > >
>

