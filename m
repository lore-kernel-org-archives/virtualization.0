Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FB51BD517
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745207184; cv=none; b=Z14v/o+jOZ4FMm42jb5kh1dqvrxmckaH5N9P4HsL+sF4W2lYkyq1DR8xndH7i5NqKJP7UmT/AJr4897pNrx4I3mQej267Mv9H7SnhmPVw0goXfsJwTq+keDGVhrkayMRgZM+JDE8DS1nimGdjrm7rUiiWOXstM3f4MgEF8WFVUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745207184; c=relaxed/simple;
	bh=WDWbIvSU773gRjsi9Bt8QnyBPdTx2jqcvGDaCCgw+xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoCKemUOiWq2zZzN6YGfHkIu6jSY3sBD8ptnN/3tCa0Drlqu1w28pt/6cDTOqO7GQSOhfK5jfYPn+jrRN9oqNEG6Jg0SKmWiS2G1sikgloQTd+shM6Ys/31MaHx+2ehZvrG7HGNl6O+XXBEktz5IgOrAkzaua5aUMSAmT/qKXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=amXJeF/l; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amXJeF/l"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F0A9581297
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:46:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GkWPxB7hpL7t for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Apr 2025 03:46:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3A85F811D2
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A85F811D2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=amXJeF/l
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3A85F811D2
	for <virtualization@lists.linux-foundation.org>; Mon, 21 Apr 2025 03:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745207180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MmNHzTsOXktJvVrWiuSPufs0RXIPgJ4SHes9h94zrI=;
	b=amXJeF/lCBMyjF1s9UU5bC1B8DMJJgi/nRtOE/p6bAk849LOkyiUIL15Hfs5OOm2+ThP/f
	egAl1xHzom0ortYWVD5tIII9D59n3NkkPyWtaGsJQR9eWdfju65XbHDhySk+8CJVt3hhco
	xFqMoG+EZQdvGPBZRzSZ+HyUebIzgmo=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-1nvYgjd7PAysJEeUtcFOBw-1; Sun, 20 Apr 2025 23:46:18 -0400
X-MC-Unique: 1nvYgjd7PAysJEeUtcFOBw-1
X-Mimecast-MFC-AGG-ID: 1nvYgjd7PAysJEeUtcFOBw_1745207177
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-524021ac776so815426e0c.2
        for <virtualization@lists.linux-foundation.org>; Sun, 20 Apr 2025 20:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745207177; x=1745811977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MmNHzTsOXktJvVrWiuSPufs0RXIPgJ4SHes9h94zrI=;
        b=ViraRILmFYqOlYHwI7fd27x9r4E8XOKYmzMd2yeeHsLKb/e/BTVSlM7BYF/cOEzipr
         FJU8on2BuCJTbvq2r/yWsRAWBRU4BlqxcH2h4HxKIxg5oS50eS8Q7vYsnVvvDGPTEcxn
         vJ/NAL4PKchiXcXrz7Wii5O5pfQwrV5q6Vh3hME2+05qm/RkcYQHFyRA5I/t9Hfi1sSy
         JjUvZEZXYwIl/r2oJShnEqKYWJK0Q6HdwqbzTCdngFuYRqM3AaQw2nsixUFRqCawuTTP
         3zX0soAtRQ/aBsb1pvceyDMC2uEVrPAuU639SoH4atjDOJJiKquDcgFXErTUoGuuB7cU
         wieg==
X-Forwarded-Encrypted: i=1; AJvYcCUyLjVx41kNiJkT4vaxikNuZIXs0KIyisurXHlk11gpiUP21J9d5nY6eWqwNU36wRUeMDoOunlvr13S4SMInQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxpOMW9PYspiTlrJ9Oy1OT8hmw1PbdaX1GyDeoSxfXVkjoAmS5I
	u6fCVfJ6APrcgZip/HyCMSitAwU9VW6XDnzJ6CSo7EcGAZk49PCZE5HCS+rQx4gpA5jN+JySUqO
	8Xag9aL4T6lk9RERYd8vvugkUbUqRanVj8pcLLCrFkvWXfVxpzV4L4MmuIvzobv1FRw7AC+X3e4
	uwdScF/cQpKgWQQmyOCiVNmi7OW5vQLOVP5bwx9Ju/jDziENQp+lWNqw==
X-Gm-Gg: ASbGncs2LcdT2MotWKp+glD9RzAtj95pesxdXAaIEhLliMNLtq3o3xBHhkz1yf4IZNQ
	NnztBbbGRkkfTAJYgnococh4+uPzUev/36jPqmQfrDOjMVv5ZQ+2kOV2GXoEVWRMjwSgBnA==
X-Received: by 2002:a67:f085:0:b0:4cb:5d6e:e6c8 with SMTP id ada2fe7eead31-4cb80128dcamr5512635137.9.1745207177642;
        Sun, 20 Apr 2025 20:46:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjeQwKCOfHzvN3lUTtfHim7VBEQTh/TCbfRNy3QnFlzQ8hxPYthyT/QZOXVv5k8ci+MMU+1s1BplANJT3lPBo=
X-Received: by 2002:a67:f085:0:b0:4cb:5d6e:e6c8 with SMTP id
 ada2fe7eead31-4cb80128dcamr5512625137.9.1745207177278; Sun, 20 Apr 2025
 20:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250421024457.112163-1-lulu@redhat.com> <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
In-Reply-To: <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Apr 2025 11:46:04 +0800
X-Gm-Features: ATxdqUHeO85TtbIdV-aJBSr0-Cr6xqgcKTQNuiFED9cSXLQ7VllgtcbY3bYiDRg
Message-ID: <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL VHOST_FORK_FROM_OWNER
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V53H9AtKjQx9IG3LJgZdX3COrbNKmi-VnE6TserXgTc_1745207177
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 11:45=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Apr 21, 2025 at 10:45=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > is disabled, and any attempt to use it will result in failure.
>
> I think we need to describe why the default value was chosen to be false.
>
> What's more, should we document the implications here?
>
> inherit_owner was set to false: this means "legacy" userspace may

I meant "true" actually.

> still be broken unless it can do VHOST_FORK_FROM_OWNER which is
> impractical. Does this defeat the purpose of this series actually?
>
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/Kconfig | 15 +++++++++++++++
> >  drivers/vhost/vhost.c |  3 +++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index 020d4fbb947c..bc8fadb06f98 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -96,3 +96,18 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >           If unsure, say "N".
> >
> >  endif
> > +
> > +config VHOST_ENABLE_FORK_OWNER_IOCTL
> > +       bool "Enable IOCTL VHOST_FORK_FROM_OWNER"
> > +       default n
> > +       help
> > +         This option enables the IOCTL VHOST_FORK_FROM_OWNER, which al=
lows
> > +         userspace applications to modify the thread mode for vhost de=
vices.
> > +
> > +          By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL` is set to=
 `n`,
> > +          meaning the ioctl is disabled and any operation using this i=
octl
> > +          will fail.
> > +          When the configuration is enabled (y), the ioctl becomes
> > +          available, allowing users to set the mode if needed.
> > +
> > +         If unsure, say "N".
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index fb0c7fb43f78..568e43cb54a9 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -2294,6 +2294,8 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >                 r =3D vhost_dev_set_owner(d);
> >                 goto done;
> >         }
> > +
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL
> >         if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> >                 u8 inherit_owner;
> >                 /*inherit_owner can only be modified before owner is se=
t*/
> > @@ -2313,6 +2315,7 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigne=
d int ioctl, void __user *argp)
> >                 r =3D 0;
> >                 goto done;
> >         }
> > +#endif
> >         /* You must be the owner to do anything else */
> >         r =3D vhost_dev_check_owner(d);
> >         if (r)
> > --
> > 2.45.0
> >
>
> Thanks

Thanks

