Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD70C13D504
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736737771; cv=none; b=MA+WSlsIsx3d+GjDy/bs66RQf65DJExJ0OyoaJiw0YHq96w6CGtZJbsanjjVnAqB+meUp89DQelXQAx5z2VBNOvymMNI7J+QvR2MQB1hXcLvlw7aSeoaEGKZKDOKwmdeOVemER7gtZG4p8dPMr///5u6GGpvVSdxVyiwwaXSd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736737771; c=relaxed/simple;
	bh=DEmsliNdq5xOag2xI3ibIDh1W5iQhPZ8XezFY/pQJFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LazhVzR8D8MsF9ricmecPFaovEK9Op+ZemGxr4HTX1Q520KS+XpRXmJ2IyVWyVqRFwhmmnIZqRnch69fz7KXYLEooqMKXOtmtxXvZr3NIo6nShIHWyC/Zl+qpVT9B88tKGCMKPRNmJ+DYjEtg8PwVg4F1M0mqpJuv4wls2p9YZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TuPh54Ai; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuPh54Ai"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 351B84078B
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 03:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZvBoiZcftZ3b for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jan 2025 03:09:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1878D4070D
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1878D4070D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TuPh54Ai
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1878D4070D
	for <virtualization@lists.linux-foundation.org>; Mon, 13 Jan 2025 03:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736737767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4oyhgO+Y+dGyeymACnXpTGA+/wZIqJR9I06xr+q/V18=;
	b=TuPh54AibJ6tg9UdxiNrHdzklH2IxiIA/jqDW4Nx5/2hPPVVYXl4tqhHNa29J5b1rPlFEd
	U8p4eOtvMLxIiLZeZ0Bz/jqoZptyy9ijOsPwKSz2/D8wwABYlx1F+KaMAoUhviq/p8Thqh
	zYFPvFeWtkpWQr/19Z4FbTKtk6KEaL8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-ZKFtrpEIPICcTetPPrTt6g-1; Sun, 12 Jan 2025 22:09:26 -0500
X-MC-Unique: ZKFtrpEIPICcTetPPrTt6g-1
X-Mimecast-MFC-AGG-ID: ZKFtrpEIPICcTetPPrTt6g
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef909597d9so11155395a91.3
        for <virtualization@lists.linux-foundation.org>; Sun, 12 Jan 2025 19:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736737765; x=1737342565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4oyhgO+Y+dGyeymACnXpTGA+/wZIqJR9I06xr+q/V18=;
        b=kMUbBbnQv+3/2EQ9vVuPxT780mCmiUHjPcB5TAKfnYv8qPfUfHi4Whbp0c6qnPtGTR
         D4toIP01tU6CIdlP6Iz8dIvqupGvqMrHK9MbOVePtfW3BA58D6Ln0GDdu8Lg62Y501fI
         jTZUgSehWP9nqLn5FJQppLHGKZZIqFnd17lffg/gYqeUSKlnX+gnZFUkCeXYXX1tq+RV
         JSdZwg3Lv0tfVE4LT+owpzhChkUNqja8tOmXbXSs2py8aP1Oe20P1wTMb8Y8I29epbG9
         VkZ8oDhhU2zrRQqqwvJZjVB9gMcZx60tYLz81690AB3/9JOk8k1a5HNItaLIPABen8cv
         mPyw==
X-Forwarded-Encrypted: i=1; AJvYcCUWpMfgOW6jdSeT3UXsRwPWhfjZhDcx0RYrhFdn2wBjwic0SnCfdJJ+31gEMeHDa5+9j403MJ244a5rhcCdqA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzrktLuOztLJEiZbAE+RBnlbWhevr9XLJsj6BZ9Qn/FB4SeASC/
	d4VKpLgjbCttdHx3yYXI9g5yiAOS87ozsC9xJhAwbRzBJkuq3Dr+C4iKvz0QBR74I5hFpXlo2kE
	P7S4kk4FbC9LuaKoc3X2cejekRwLZlyulA6rdtDaASUh9yf1GdJ2r56L8L6ynHS4TMsj4uETxfn
	4OZXWPJeYm1ukz68l6mAoHj3WL/uoMbe3vZAU776PHVyMRUV6iQX4pNA==
X-Gm-Gg: ASbGncvhIM2I2Na5IY2JYcMWcjsmXCSvSm1OzK4Wt9x0cja/NmZnZ3fb66lZMxez7F/
	Kk9iRNwmprsV3oWMbBmVg34CYyS9Om+JFg/K599U=
X-Received: by 2002:a17:90a:f94b:b0:2f6:d266:f45c with SMTP id 98e67ed59e1d1-2f6d266fa1dmr9941333a91.2.1736737764867;
        Sun, 12 Jan 2025 19:09:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGohapCCDXR2L+ZpUh6iRr3Bw3OXaBXas3XBlaBBL6vXp8bpmWOnOAEMGsKxTXRiiS5FRgfDDtEjErspybbiQ8=
X-Received: by 2002:a17:90a:f94b:b0:2f6:d266:f45c with SMTP id
 98e67ed59e1d1-2f6d266fa1dmr9941297a91.2.1736737764407; Sun, 12 Jan 2025
 19:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-8-lulu@redhat.com>
 <20250108071107-mutt-send-email-mst@kernel.org> <CACLfguUffb-kTZgUoBnJAJxhpxh-xq8xBM-Hv5CZeWzDoha6tA@mail.gmail.com>
In-Reply-To: <CACLfguUffb-kTZgUoBnJAJxhpxh-xq8xBM-Hv5CZeWzDoha6tA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jan 2025 11:09:13 +0800
X-Gm-Features: AbW1kvYpKg5bc48boHvJUONg_Pla6QVv4Otx4hHwhyndxlFNHaTavvyqRkE_aXk
Message-ID: <CACGkMEsDjFgyFFxz9Gdi2dFbk+JHP6cr7e1xGnLYuPBce-aLHw@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lxwrD_9OdMLf6WGjwuJf__w12hEfBNBxvVSdJLrxn9k_1736737765
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 10:36=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote:
>
> On Wed, Jan 8, 2025 at 8:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
> >
> > On Wed, Dec 11, 2024 at 12:41:46AM +0800, Cindy Lu wrote:
> > > Add a new UAPI to enable setting the vhost device to task mode.
> > > The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > > to configure the mode if necessary.
> > > This setting must be applied before VHOST_SET_OWNER, as the worker
> > > will be created in the VHOST_SET_OWNER function
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> >
> > Good.  I would like to see an option to allow/block this ioctl,
> > to prevent exceeding nproc limits.

VHOST_SET_INHERIT_FROM_OWNER is for fork() alike behaviour. Without
this ioctl we will go for kthread.

> A Kconfig option is probably
> > sufficient.  "allow legacy threading mode" and default to yes?

How could we block legacy threading mode in this case?

> >
> sure I will add this in the new version, the legacy thread mode here
> is  kthread mode
> I will change these commit comments and make it more clear
> Thanks
> Cindy

Thanks

>
> >
> > > ---
> > >  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> > >  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > >  2 files changed, 39 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index 3e9cb99da1b5..12c3bf3d1ed4 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, uns=
igned int ioctl, void __user *argp)
> > >  {
> > >       struct eventfd_ctx *ctx;
> > >       u64 p;
> > > -     long r;
> > > +     long r =3D 0;
> > >       int i, fd;
> > > +     u8 inherit_owner;
> > >
> > >       /* If you are not the owner, you can become one */
> > >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> > >               r =3D vhost_dev_set_owner(d);
> > >               goto done;
> > >       }
> > > +     if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
> > > +             /*inherit_owner can only be modified before owner is se=
t*/
> > > +             if (vhost_dev_has_owner(d)) {
> > > +                     r =3D -EBUSY;
> > > +                     goto done;
> > > +             }
> > > +             if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > > +                     r =3D -EFAULT;
> > > +                     goto done;
> > > +             }
> > > +             /* Validate the inherit_owner value, ensuring it is eit=
her 0 or 1 */
> > > +             if (inherit_owner > 1) {
> > > +                     r =3D -EINVAL;
> > > +                     goto done;
> > > +             }
> > > +
> > > +             d->inherit_owner =3D (bool)inherit_owner;
> > >
> > > +             goto done;
> > > +     }
> > >       /* You must be the owner to do anything else */
> > >       r =3D vhost_dev_check_owner(d);
> > >       if (r)
> > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > index b95dd84eef2d..d7564d62b76d 100644
> > > --- a/include/uapi/linux/vhost.h
> > > +++ b/include/uapi/linux/vhost.h
> > > @@ -235,4 +235,22 @@
> > >   */
> > >  #define VHOST_VDPA_GET_VRING_SIZE    _IOWR(VHOST_VIRTIO, 0x82,      =
 \
> > >                                             struct vhost_vring_state)
> > > +
> > > +/**
> > > + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for the=
 vhost device
> > > + *
> > > + * @param inherit_owner: An 8-bit value that determines the vhost th=
read mode
> > > + *
> > > + * When inherit_owner is set to 1:
> > > + *   - The VHOST worker threads inherit its values/checks from
> > > + *     the thread that owns the VHOST device, The vhost threads will
> > > + *     be counted in the nproc rlimits.
> > > + *
> > > + * When inherit_owner is set to 0:
> > > + *   - The VHOST worker threads will use the traditional kernel thre=
ad (kthread)
> > > + *     implementation, which may be preferred by older userspace app=
lications that
> > > + *     do not utilize the newer vhost_task concept.
> > > + */
> > > +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > > +
> > >  #endif
> > > --
> > > 2.45.0
> >
>

