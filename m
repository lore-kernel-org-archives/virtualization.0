Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7616626B095
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Jun 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749996458; cv=none; b=r7VmaJDAlooZlQzIBnnnwGOJHWwDW4k3sjFgkHX2poX2YKh29eE2Eq9Jmje4ljZTjnXdH3qHXy+AfWDOMY4STbYGn1UAc//hMXd29vzVck9dDlcE++Q8Jwy/fQqxk65AEdAOwC+YR0eObLYgCJAgnR7HzCv8Ma8LXa54s77OmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749996458; c=relaxed/simple;
	bh=jepLbbOJGxCtAqyma/HZzE4xJ9rkrsv4QZicL7bfPcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qu0LBnVE0Nkna2X/ExzkK8DJwy2yfHxt4xnQVinLabDdHI2dd5kWdBGX3KBGzGHsp7FAV2oyJbMT6cJN57cYEEJFoYkGtAnUm1XkDCLpz3MaRHhCymgQNyT3blHHtkosRrz8M7+rY1GwLqhEY/ijFB4ST42ylavRBUm+yVmHL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlzopJKf; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlzopJKf"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A860B40111
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Jun 2025 14:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DSbHpwGDyBRH for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Jun 2025 14:07:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9DCC040109
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DCC040109
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XlzopJKf
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9DCC040109
	for <virtualization@lists.linux-foundation.org>; Sun, 15 Jun 2025 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749996451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpvfPquWEoPv1qftMnP3EaVgh/vM8Dl1IeS2VTYnWq8=;
	b=XlzopJKf2KCNoJJGmvZY3lyv1wtr9QXPa3DigoPZjP7m1tjOyuuS6y1rdJNZ4In72GR1/E
	wQplwqoey/5nsPBsC8QkU/z+20Is4X7WrwVmFWNDwjfDxGrrscaNycy3Ii698pO7htda6S
	9PCr5R7SUQ/ZuMNhIlTMLouNl22eGt8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-G9OKnA89MCu5MqCQ7_iPpg-1; Sun, 15 Jun 2025 10:07:29 -0400
X-MC-Unique: G9OKnA89MCu5MqCQ7_iPpg-1
X-Mimecast-MFC-AGG-ID: G9OKnA89MCu5MqCQ7_iPpg_1749996449
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d0981315c8so343283185a.0
        for <virtualization@lists.linux-foundation.org>; Sun, 15 Jun 2025 07:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749996449; x=1750601249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpvfPquWEoPv1qftMnP3EaVgh/vM8Dl1IeS2VTYnWq8=;
        b=u9WhCG4TED0SvcUynAFXR27+ooWdIkFn6YGNGqjxESMHE3SvTwhLipbX3NyTJSE7YV
         N2u+VznkHcisRO9CNOZ7hQCkwOyKiWGDVXSXCErY/CTWBzD6f3RxYv9Z+WCSkHP8IpI5
         +whlaUDrCcGmmVArAhE25aSRTUKTlSwaFIFCgUSA40Z38OKtxH62Tfq85piex65x7opC
         ZpGR60Z9cH96prHD1Tvcs9h5Nd3CilAScuDr1mwF55kH6r9gc8j71NitpDPkrimDEhyh
         PTmo4cQGu5SLyc85I9waFus5rTYLwGZ9Li8IiDrItyod6ddEE1o4zrc4OrP1LwNpgCQ2
         c+QA==
X-Forwarded-Encrypted: i=1; AJvYcCWSFsGbMC98JdZleYO4Y7lXpwNqxcLeYUa00FzKiDwpljXTKQaUESAUiZ6mdIoPOIZPQCBTZEE1DovIQm5yVg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwRuLGS/X2qgkCn4pPb8F8x+nBpEtaNDd1GsBBNM297g/sZSKuW
	U8GKKkyIwR9DJmXZdHVzS4gN6kuBrgpNWm4KIhrcqRE6JK2qpeVAdKazuIsMpaEf/cXgaMwkOdT
	HTbFRGge5+glXqflFauyP3B80ka6Kd9xkSu++sW93xFAcuutLW4pM/47dtD6aJzsGfCdhJ7Lzhk
	dWoy0Jr0kb+I3Wq1MKwtYTblCifrhmP0LGwhFACZIr6rpJTuy+UetsxT1kXQ==
X-Gm-Gg: ASbGncvMfygKjwrSMUXAYZQVJ2knBC92/ODSU/To1/81Egnatso+SOUhwRKzIjOF/8o
	9y31lQqhsl8Vu9zpgaiuQ9wfeiQ32zFXUT9yC9VtevS1PbZNGzOQ3CA5Y1JuGj8NuJDO5oxrmWH
	CtbjGD
X-Received: by 2002:a05:620a:370f:b0:7c5:6678:ab18 with SMTP id af79cd13be357-7d3c6cf11efmr684336885a.42.1749996448791;
        Sun, 15 Jun 2025 07:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQfd3Jg+za2A2otcwQoRQPivaXBv48NJhSap+53dPBVNEvIqD8CTtK5u8X5NDCCMNb0CRWiye3EoWlyPRqsDE=
X-Received: by 2002:a05:620a:370f:b0:7c5:6678:ab18 with SMTP id
 af79cd13be357-7d3c6cf11efmr684333885a.42.1749996448345; Sun, 15 Jun 2025
 07:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250609073430.442159-1-lulu@redhat.com> <20250609073430.442159-4-lulu@redhat.com>
 <20250612022053-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250612022053-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Sun, 15 Jun 2025 22:06:51 +0800
X-Gm-Features: AX0GCFuavf4F9QSSduL1i-CbZH_0D6GbiTWvUTGYMpPvjCVBJlOzCw6TvLbCB5c
Message-ID: <CACLfguVUnpxCczJ5NdtWdiDVSsYDNG6XPFGdjqdgwncX4y74UA@mail.gmail.com>
Subject: Re: [PATCH v11 3/3] vhost: Add configuration controls for vhost
 worker's mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jcnWMM3LpFliO0cHv8WYTRIur58m7VeuEgVYeUz1LJ8_1749996449
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 2:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jun 09, 2025 at 03:33:09PM +0800, Cindy Lu wrote:
> > This patch introduces functionality to control the vhost worker mode:
> >
> > - Add two new IOCTLs:
> >   * VHOST_SET_FORK_FROM_OWNER: Allows userspace to select between
> >     task mode (fork_owner=3D1) and kthread mode (fork_owner=3D0)
> >   * VHOST_GET_FORK_FROM_OWNER: Retrieves the current thread mode
> >     setting
> >
> > - Expose module parameter 'fork_from_owner_default' to allow system
> >   administrators to configure the default mode for vhost workers
> >
> > - Add KConfig option CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL to
> >   control the availability of these IOCTLs and parameter, allowing
> >   distributions to disable them if not needed
> >
> > - The VHOST_NEW_WORKER functionality requires fork_owner to be set
> >   to true, with validation added to ensure proper configuration
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
>
> getting there. yet something to improve.
>
> > ---
> >  drivers/vhost/Kconfig      | 17 +++++++++++++++
> >  drivers/vhost/vhost.c      | 44 ++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vhost.h | 25 ++++++++++++++++++++++
> >  3 files changed, 86 insertions(+)
> >
> > diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
> > index 020d4fbb947c..49e1d9dc92b7 100644
> > --- a/drivers/vhost/Kconfig
> > +++ b/drivers/vhost/Kconfig
> > @@ -96,3 +96,20 @@ config VHOST_CROSS_ENDIAN_LEGACY
> >         If unsure, say "N".
> >
> >  endif
> > +
> > +config CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
> > +     bool "Enable CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL"
> > +     default n
> > +     help
> > +       This option enables two IOCTLs: VHOST_SET_FORK_FROM_OWNER and
> > +       VHOST_GET_FORK_FROM_OWNER. These allow userspace applications
> > +       to modify the vhost worker mode for vhost devices.
> > +
> > +       Also expose module parameter 'fork_from_owner_default' to allow=
 users
> > +       to configure the default mode for vhost workers.
> > +
> > +       By default, `CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL` is set to =
`n`,
> > +       which disables the IOCTLs and parameter.
> > +       When enabled (y), users can change the worker thread mode as ne=
eded.
> > +
> > +       If unsure, say "N".
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index 37d3ed8be822..903d9c3f6784 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -43,6 +43,11 @@ module_param(max_iotlb_entries, int, 0444);
> >  MODULE_PARM_DESC(max_iotlb_entries,
> >       "Maximum number of iotlb entries. (default: 2048)");
> >  static bool fork_from_owner_default =3D true;
>
> Add empty lines around ifdef to make it clear what code do they
> delimit.
>
>
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
> > +module_param(fork_from_owner_default, bool, 0444);
> > +MODULE_PARM_DESC(fork_from_owner_default,
> > +              "Set task mode as the default(default: Y)");
> > +#endif
> >
> >  enum {
> >       VHOST_MEMORY_F_LOG =3D 0x1,
> > @@ -1019,6 +1024,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, u=
nsigned int ioctl,
> >       switch (ioctl) {
> >       /* dev worker ioctls */
> >       case VHOST_NEW_WORKER:
> > +             /*
> > +              * vhost_tasks will account for worker threads under the =
parent's
> > +              * NPROC value but kthreads do not. To avoid userspace ov=
erflowing
> > +              * the system with worker threads fork_owner must be true=
.
> > +              */
> > +             if (!dev->fork_owner)
> > +                     return -EFAULT;
>
> An empty line here would make the code clearer.
>
> >               ret =3D vhost_new_worker(dev, &state);
> >               if (!ret && copy_to_user(argp, &state, sizeof(state)))
> >                       ret =3D -EFAULT;
> > @@ -1136,6 +1148,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev,=
 struct vhost_iotlb *umem)
> >
> >       vhost_dev_cleanup(dev);
> >
> > +     dev->fork_owner =3D fork_from_owner_default;
> >       dev->umem =3D umem;
> >       /* We don't need VQ locks below since vhost_dev_cleanup makes sur=
e
> >        * VQs aren't running.
> > @@ -2289,6 +2302,37 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsign=
ed int ioctl, void __user *argp)
> >               goto done;
> >       }
> >
> > +#ifdef CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL
> > +     u8 fork_owner;
>
> Do not declare variables in the middle of a scope please.
> This one is not needed in this scope, so just move it down
> to within if (yes you will repeat the declaration twice then).
>
>
>
> > +
> > +     if (ioctl =3D=3D VHOST_SET_FORK_FROM_OWNER) {
> > +             /*fork_owner can only be modified before owner is set*/
>
> bad comment style.
>
> > +             if (vhost_dev_has_owner(d)) {
> > +                     r =3D -EBUSY;
> > +                     goto done;
> > +             }
> > +             if (copy_from_user(&fork_owner, argp, sizeof(u8))) {
>
> get_user is a better fit for this. In particular, typesafe.
>
>
> > +                     r =3D -EFAULT;
> > +                     goto done;
> > +             }
> > +             if (fork_owner > 1) {
>
> so 0 and 1 are the only legal values?
> maybe add an enum or defines in the header then.
>
>
> > +                     r =3D -EINVAL;
> > +                     goto done;
> > +             }
> > +             d->fork_owner =3D (bool)fork_owner;
>
>                 !!fork_owner is shorter and idiomatic.
>
> > +             r =3D 0;
> > +             goto done;
> > +     }
> > +     if (ioctl =3D=3D VHOST_GET_FORK_FROM_OWNER) {
> > +             fork_owner =3D d->fork_owner;
> > +             if (copy_to_user(argp, &fork_owner, sizeof(u8))) {
>
> put_user
>
Thanks, Micheal. I'll address all above comments and send a revised version=
.
Thanks
cindy
> > +                     r =3D -EFAULT;
> > +                     goto done;
> > +             }
> > +             r =3D 0;
> > +             goto done;
> > +     }
> > +#endif
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index d4b3e2ae1314..e51d6a347607 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,29 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE    _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> > +
> > +/**
> > + * VHOST_SET_FORK_FROM_OWNER - Set the fork_owner flag for the vhost d=
evice,
> > + * This ioctl must called before VHOST_SET_OWNER.
> > + * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=3Dy
> > + *
> > + * @param fork_owner: An 8-bit value that determines the vhost thread =
mode
> > + *
> > + * When fork_owner is set to 1(default value):
> > + *   - Vhost will create vhost worker as tasks forked from the owner,
> > + *     inheriting all of the owner's attributes.
> > + *
> > + * When fork_owner is set to 0:
> > + *   - Vhost will create vhost workers as kernel threads.
> > + */
> > +#define VHOST_SET_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +
> > +/**
> > + * VHOST_GET_FORK_OWNER - Get the current fork_owner flag for the vhos=
t device.
> > + * Only available when CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=3Dy
> > + *
> > + * @return: An 8-bit value indicating the current thread mode.
> > + */
> > +#define VHOST_GET_FORK_FROM_OWNER _IOR(VHOST_VIRTIO, 0x84, __u8)
> > +
> >  #endif
> > --
> > 2.45.0
>

