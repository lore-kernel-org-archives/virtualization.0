Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56873596D
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550615; cv=none; b=JV9rsb4mG18RMjKEC0g6DyjSfJIqONe1ePiKlchDlfvRM2O2mHSb92jBhRxDqjlfeACT4MdsaVR4nCZfrV8ghDPoUaK3g4/0iJ5PFj46yLqONvDFaCN2HlKqB/B6uysz7BRjGnO/QZV9ozZwgFSZ/nKOsawGN4QKIqgw/u/gYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550615; c=relaxed/simple;
	bh=s7RNNwS1VeCqaA1MtGD3SocRHTpkYCAIDVHP7LurC8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/IcLk7gdZ/nkxCO7pA/3xh9FTGUG87hBLDPtiwA7tW9FmGkimkU3U6f4QbZkv5dilHHTyWqVb0+h82gAIxz7ID1N5j42PMgFseoXtms+nFtwVICviJQuCMKrsP6jGOPPUQ9WtwhEqdxOe9VwPh6Bb0e313gVOyzC6K0Ht60nms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJRw2dJw; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJRw2dJw"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 56164410F0
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 06:16:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sfP-Ce2WNLqI for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Feb 2025 06:16:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 431E3410EA
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 431E3410EA
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LJRw2dJw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 431E3410EA
	for <virtualization@lists.linux-foundation.org>; Wed, 26 Feb 2025 06:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740550611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1FB4LOVmyku7dBx/0yNo7XDVAzCNkcepNULZYDZTsFo=;
	b=LJRw2dJwUhgUDRbsNf92s6C++zkQ38XoxngBfkkkoTodp/uEVMNQsTwAUNFDWtiGd33k0X
	QcU6tBpad3DjeYgQxR0aI3x76/MTOga/TWbQCRUDN10eS3zgPtwgPdNMrokHkWH/QfZy3E
	RwNsaHwL3yGftTk3a1EyD4jFFAB12xQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-VHsjjIfTN9yM_isIYKNnkw-1; Wed, 26 Feb 2025 01:16:49 -0500
X-MC-Unique: VHsjjIfTN9yM_isIYKNnkw-1
X-Mimecast-MFC-AGG-ID: VHsjjIfTN9yM_isIYKNnkw_1740550608
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5dec9d39295so9931397a12.3
        for <virtualization@lists.linux-foundation.org>; Tue, 25 Feb 2025 22:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740550608; x=1741155408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FB4LOVmyku7dBx/0yNo7XDVAzCNkcepNULZYDZTsFo=;
        b=wS0xpDn+S68NywEl2r+JGBqVNz2YiDAXoW8zxEww/zGFdRmhl5dLmXB0bN1Yt+xhCT
         kA/krb38I9CQfQR66306WZhQEZcMKBpcYCqz09dgCT8KlTpgPFyBrfIsG6kRVF8yiB5x
         dEO5ZYCsm3hE4Rb4oaR3PuGPhQuoGrjgqGGBKz01qVlcokLM8DALb3VUmutnukoFspg8
         dYZmnbWNmYFiDaw71pnaAd4p5NNlsT4AjkVNjxwhiv4LuykixymDXjcNHL88an1kuTG5
         4IhnKqEKF2VtjXw9W60W4cmQH53nlmpFSSwuczuRARVsuHDKxvFKc3eFJ4j4lMUTQCxF
         Qn6A==
X-Forwarded-Encrypted: i=1; AJvYcCVTWqu3E25OcPkpBVXKxNFdRYsbPS7GNkwbH5fI0FPMIilmy85n7FDvML9/ipazG6BWdxMPVsY98JUrvp8IPQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyJalXelGTn/TJVE+3+8ur2gcdFmZhxyGx72vqCePehaJ082fKk
	a4aS6DFXtnhvEdqCHYBQPF0KdNchviz0wvIRRJJ+cUjag3AqpAts/xdXz4slysKuXbJZrpbKJ7W
	gdxoiS82z048eJl9KDlWHk0Q2MZS3v2P+2zrxrq6XKmj51LD3OVwsHr+/gUk9oArJE5t0OHS0qU
	2YkP6EXHv1ckl/dSU5hjwxHygtjZL0v+4kaMX7VYvW8CMjw0NblwcvSQ==
X-Gm-Gg: ASbGncvsxCse/ZwLSlI3PbzTp6jw6Rgq+oatullMLQSlWg59wEy7w1dmFja8tKoD7TU
	LPOMYyCqzBohRT7rLGCMveII5ZN4n5I8xExY9lgbAyiOwWr+lWtcPPSZh71Kf2/hawgRNQM6p4A
	==
X-Received: by 2002:a05:6402:34cc:b0:5dc:cfc5:9305 with SMTP id 4fb4d7f45d1cf-5e4a0dfc8b9mr2496863a12.25.1740550607945;
        Tue, 25 Feb 2025 22:16:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1Svm9zCE7jvsU1DaFVhMr5yn9In9YqFnmIGZJOqqstdyPg6Py8o1nFKh/wslu91Gg/91zZXUIrxektg2nXhQ=
X-Received: by 2002:a05:6402:34cc:b0:5dc:cfc5:9305 with SMTP id
 4fb4d7f45d1cf-5e4a0dfc8b9mr2496837a12.25.1740550607523; Tue, 25 Feb 2025
 22:16:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-6-lulu@redhat.com>
 <20250224164312-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250224164312-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 14:16:09 +0800
X-Gm-Features: AQ5f1JoQwYeVFJ0uSnuf6OMlUOLtzkJzFZrJtoyQ-MQBSJ8pPR3vnflY_UdihLw
Message-ID: <CACLfguWpj=-Ad3o731xbRdGRr3NT6oEQ67Z-FPBmd93gYEhAXw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] vhost: Add new UAPI to support change to task mode
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qOlr_N1sPA8H6qu1hyt4jgz30wnznOTlnvyMTPG-6a0_1740550608
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 5:46=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> better subject:
>
> vhost: uapi to control task mode (owner vs kthread)
>
>
> On Sun, Feb 23, 2025 at 11:36:20PM +0800, Cindy Lu wrote:
> > Add a new UAPI to enable setting the vhost device to task mode.
>
> better:
>
> Add a new UAPI to configure the vhost device to use the kthread mode
>
Thanks MST, will change this
>
> > The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > to configure the mode
>
> ... to either owner or kthread.
>
sure, will change this
thanks
cindy
>
> > if necessary.
> > This setting must be applied before VHOST_SET_OWNER, as the worker
> > will be created in the VHOST_SET_OWNER function
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c      | 24 ++++++++++++++++++++++--
> >  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> >  2 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index d8c0ea118bb1..45d8f5c5bca9 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -1133,7 +1133,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev,=
 struct vhost_iotlb *umem)
> >       int i;
> >
> >       vhost_dev_cleanup(dev);
> > -
> > +     dev->inherit_owner =3D true;
> >       dev->umem =3D umem;
> >       /* We don't need VQ locks below since vhost_dev_cleanup makes sur=
e
> >        * VQs aren't running.
> > @@ -2278,15 +2278,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsig=
ned int ioctl, void __user *argp)
> >  {
> >       struct eventfd_ctx *ctx;
> >       u64 p;
> > -     long r;
> > +     long r =3D 0;
> >       int i, fd;
> > +     u8 inherit_owner;
> >
> >       /* If you are not the owner, you can become one */
> >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> >               r =3D vhost_dev_set_owner(d);
> >               goto done;
> >       }
> > +     if (ioctl =3D=3D VHOST_FORK_FROM_OWNER) {
> > +             /*inherit_owner can only be modified before owner is set*=
/
> > +             if (vhost_dev_has_owner(d)) {
> > +                     r =3D -EBUSY;
> > +                     goto done;
> > +             }
> > +             if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
> > +                     r =3D -EFAULT;
> > +                     goto done;
> > +             }
> > +             /* Validate the inherit_owner value, ensuring it is eithe=
r 0 or 1 */
> > +             if (inherit_owner > 1) {
> > +                     r =3D -EINVAL;
> > +                     goto done;
> > +             }
> > +
> > +             d->inherit_owner =3D (bool)inherit_owner;
> >
> > +             goto done;
> > +     }
> >       /* You must be the owner to do anything else */
> >       r =3D vhost_dev_check_owner(d);
> >       if (r)
> > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > index b95dd84eef2d..8f558b433536 100644
> > --- a/include/uapi/linux/vhost.h
> > +++ b/include/uapi/linux/vhost.h
> > @@ -235,4 +235,22 @@
> >   */
> >  #define VHOST_VDPA_GET_VRING_SIZE    _IOWR(VHOST_VIRTIO, 0x82,       \
> >                                             struct vhost_vring_state)
> > +
> > +/**
> > + * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost de=
vice
> > + *
> > + * @param inherit_owner: An 8-bit value that determines the vhost thre=
ad mode
> > + *
> > + * When inherit_owner is set to 1:
> > + *   - The VHOST worker threads inherit its values/checks from
> > + *     the thread that owns the VHOST device, The vhost threads will
> > + *     be counted in the nproc rlimits.
> > + *
> > + * When inherit_owner is set to 0:
> > + *   - The VHOST worker threads will use the traditional kernel thread=
 (kthread)
> > + *     implementation, which may be preferred by older userspace appli=
cations that
> > + *     do not utilize the newer vhost_task concept.
> > + */
> > +#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
> > +
> >  #endif
> > --
> > 2.45.0
>

