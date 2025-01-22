Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85832AD11
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Jan 2025 02:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737511685; cv=none; b=lWg+zXS8IuY7gc3LoH8ijNPMRzV/Wea2yDD4bmuZxcZduf6tFPY3OCwRzrfdafZPGF9gdcWadl1u5h/Y1dWKRAmgN5mZ/3RJkcxp561OZ4rZsxEkESzAu2sWYTIK6mM1ZWPs/zvxElif0h12nhUhBmBufJczZh5u6BepUEMZlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737511685; c=relaxed/simple;
	bh=ls9psBx7TPq9ztMIH0aRG9uDFRZpcTRyuBXhHRTLCbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCRpemPUWpxaWj4clx5gKkOHaxLvNUlaD7PNCNgKmrGyFHn6d4G+twK+O0yZDE35fLbI6CGyrLdYefagpq+ckrMMRjwM/ZSNltXve6sGWkLfWcvglxlK9vskXsAdxeDe5CSYEGLE6hm6xBcVmDUVLvB7xD1BY0VAFEK1BqCpL6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VboA25Mw; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VboA25Mw"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BE4A40305
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Jan 2025 02:08:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Re7VTaSykcu1 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Jan 2025 02:08:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 45C19402FD
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 45C19402FD
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VboA25Mw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 45C19402FD
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Jan 2025 02:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737511680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSiDnxfmG50D8AZ5O1R9UgcZ+8BuAhlML/4D6Zy6YNo=;
	b=VboA25MwwvVpCh/F37u2kiHByxCOJPdroh8JXSisOt+oaVR8gTZit89XVSWMvLSssc5AJH
	ofrddihomrQUFYPbjoi7ErleR+MwMt92EnWBPKwl47VuoWCUXoHf1O23c1m3dO24ps8jPF
	AIG5rT/gjpH4K44OA/dYYLoZWgzqX1E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-M5hBRbKhP7uGQRWzjgDAEw-1; Tue, 21 Jan 2025 21:07:58 -0500
X-MC-Unique: M5hBRbKhP7uGQRWzjgDAEw-1
X-Mimecast-MFC-AGG-ID: M5hBRbKhP7uGQRWzjgDAEw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab2b300e5daso688775466b.1
        for <virtualization@lists.linux-foundation.org>; Tue, 21 Jan 2025 18:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737511677; x=1738116477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSiDnxfmG50D8AZ5O1R9UgcZ+8BuAhlML/4D6Zy6YNo=;
        b=Sdxd1GfwY4dB4mWOomaKms4ZXrImtBcBOv/mov2KqZpKZkYvh+ry/Fc4rGc3OtfpSB
         WQWc1L4tOIWtjVKpP8nWEq13fh3qHxSNlY4l4dDGZWRhfKpfLVFzvxkerb/Iu78mgIsv
         YBItlH1IjKi5lV8NGf6NTVf8kFznwqfZ1eMBsC9bxYP1Ypo6L4J4Vnj+zCZDMHUcwXLR
         exNaFYbqJ/aimtMOLij7qwuDUw/MRPjgpWx0acb4Cndi5A+EhY/+2Txz3uz//tSxm9ck
         4CiBRlU7zmmkWcE1rtu495aE2bOe/G+26gKNPR12/qR4gBWcdz4Aia6rz60AS7nN2UyB
         38jw==
X-Forwarded-Encrypted: i=1; AJvYcCXRo1jsc2F8r1qEnH9lhhNPGBJjFP+iZqCUGjI27hgiYX44wU5rapVyJa2Mkct9nIutLMkji6kN8+fjfNUfzg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzlk1mBDAcKp2Za/zfvl2vbGIdIg2l4/ESI56GSlGrJd6Va+/fn
	5KdgQSZxlacSsW/l3hu7/iKgI2T2zwoy/eFFaX6wIfeOUWn+n0/Q+xcoTIeAc+GJVfiwN9siCo5
	ZIAtHLtaEdI00AjtVGFjB7ZsnVdtzvLjSmf/h78b6F4hGqoov9D2/zrwHm15/T6yCfi2T8pJvzS
	ubZny8bX7QJMufgq61mUI1PvPz6HaO1El7n6LDtXNmhJkZJwG/GBneaQ==
X-Gm-Gg: ASbGncuSfqh0Ypt5jN7RVtUrarttKErlajHSJUVNh3vViW18BFdflB44l7CxWsZBzAX
	zmiWmg04Y2qkT9n0l+VYUNyHGG0VjMrDWCa0PNIklsKnoMTALj3rr
X-Received: by 2002:a17:907:3da5:b0:aae:b259:ef6c with SMTP id a640c23a62f3a-ab38ada039bmr1677541166b.0.1737511676960;
        Tue, 21 Jan 2025 18:07:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwXFN3ZUYNclGwr/w4DStIS7fDxdix4SunnRl5ysFfEyziUEJ9MDWE4e37xf9sRCWG7qUgv33RbTGMhX9AwhI=
X-Received: by 2002:a17:907:3da5:b0:aae:b259:ef6c with SMTP id
 a640c23a62f3a-ab38ada039bmr1677539866b.0.1737511676585; Tue, 21 Jan 2025
 18:07:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210164456.925060-1-lulu@redhat.com> <20241210164456.925060-8-lulu@redhat.com>
 <20250108071107-mutt-send-email-mst@kernel.org> <CACLfguUffb-kTZgUoBnJAJxhpxh-xq8xBM-Hv5CZeWzDoha6tA@mail.gmail.com>
 <CACGkMEsDjFgyFFxz9Gdi2dFbk+JHP6cr7e1xGnLYuPBce-aLHw@mail.gmail.com>
In-Reply-To: <CACGkMEsDjFgyFFxz9Gdi2dFbk+JHP6cr7e1xGnLYuPBce-aLHw@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 22 Jan 2025 10:07:19 +0800
X-Gm-Features: AbW1kvataw9AB8chSnUK8KAVGfVrKXAdOPIKjIbzy_TzUq55ESNJ0F3WLqwBZa4
Message-ID: <CACLfguVoJP-yruzy-6UVb2SBD_hv-4aF-kBU0oLAooi8X56E7Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vhost: Add new UAPI to support change to task mode
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0dr2rlcc85TCZff3YOizjXUljl0ARDTU8N6VZVy3-HA_1737511677
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping for review, Hi MST and Jason, do you have any comments on this?
Thanks
Cindy
On Mon, Jan 13, 2025 at 11:09=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Jan 13, 2025 at 10:36=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > On Wed, Jan 8, 2025 at 8:13=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Wed, Dec 11, 2024 at 12:41:46AM +0800, Cindy Lu wrote:
> > > > Add a new UAPI to enable setting the vhost device to task mode.
> > > > The userspace application can use VHOST_SET_INHERIT_FROM_OWNER
> > > > to configure the mode if necessary.
> > > > This setting must be applied before VHOST_SET_OWNER, as the worker
> > > > will be created in the VHOST_SET_OWNER function
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >
> > > Good.  I would like to see an option to allow/block this ioctl,
> > > to prevent exceeding nproc limits.
>
> VHOST_SET_INHERIT_FROM_OWNER is for fork() alike behaviour. Without
> this ioctl we will go for kthread.
>
> > A Kconfig option is probably
> > > sufficient.  "allow legacy threading mode" and default to yes?
>
> How could we block legacy threading mode in this case?
>
> > >
> > sure I will add this in the new version, the legacy thread mode here
> > is  kthread mode
> > I will change these commit comments and make it more clear
> > Thanks
> > Cindy
>
> Thanks
>
> >
> > >
> > > > ---
> > > >  drivers/vhost/vhost.c      | 22 +++++++++++++++++++++-
> > > >  include/uapi/linux/vhost.h | 18 ++++++++++++++++++
> > > >  2 files changed, 39 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index 3e9cb99da1b5..12c3bf3d1ed4 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -2257,15 +2257,35 @@ long vhost_dev_ioctl(struct vhost_dev *d, u=
nsigned int ioctl, void __user *argp)
> > > >  {
> > > >       struct eventfd_ctx *ctx;
> > > >       u64 p;
> > > > -     long r;
> > > > +     long r =3D 0;
> > > >       int i, fd;
> > > > +     u8 inherit_owner;
> > > >
> > > >       /* If you are not the owner, you can become one */
> > > >       if (ioctl =3D=3D VHOST_SET_OWNER) {
> > > >               r =3D vhost_dev_set_owner(d);
> > > >               goto done;
> > > >       }
> > > > +     if (ioctl =3D=3D VHOST_SET_INHERIT_FROM_OWNER) {
> > > > +             /*inherit_owner can only be modified before owner is =
set*/
> > > > +             if (vhost_dev_has_owner(d)) {
> > > > +                     r =3D -EBUSY;
> > > > +                     goto done;
> > > > +             }
> > > > +             if (copy_from_user(&inherit_owner, argp, sizeof(u8)))=
 {
> > > > +                     r =3D -EFAULT;
> > > > +                     goto done;
> > > > +             }
> > > > +             /* Validate the inherit_owner value, ensuring it is e=
ither 0 or 1 */
> > > > +             if (inherit_owner > 1) {
> > > > +                     r =3D -EINVAL;
> > > > +                     goto done;
> > > > +             }
> > > > +
> > > > +             d->inherit_owner =3D (bool)inherit_owner;
> > > >
> > > > +             goto done;
> > > > +     }
> > > >       /* You must be the owner to do anything else */
> > > >       r =3D vhost_dev_check_owner(d);
> > > >       if (r)
> > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.=
h
> > > > index b95dd84eef2d..d7564d62b76d 100644
> > > > --- a/include/uapi/linux/vhost.h
> > > > +++ b/include/uapi/linux/vhost.h
> > > > @@ -235,4 +235,22 @@
> > > >   */
> > > >  #define VHOST_VDPA_GET_VRING_SIZE    _IOWR(VHOST_VIRTIO, 0x82,    =
   \
> > > >                                             struct vhost_vring_stat=
e)
> > > > +
> > > > +/**
> > > > + * VHOST_SET_INHERIT_FROM_OWNER - Set the inherit_owner flag for t=
he vhost device
> > > > + *
> > > > + * @param inherit_owner: An 8-bit value that determines the vhost =
thread mode
> > > > + *
> > > > + * When inherit_owner is set to 1:
> > > > + *   - The VHOST worker threads inherit its values/checks from
> > > > + *     the thread that owns the VHOST device, The vhost threads wi=
ll
> > > > + *     be counted in the nproc rlimits.
> > > > + *
> > > > + * When inherit_owner is set to 0:
> > > > + *   - The VHOST worker threads will use the traditional kernel th=
read (kthread)
> > > > + *     implementation, which may be preferred by older userspace a=
pplications that
> > > > + *     do not utilize the newer vhost_task concept.
> > > > + */
> > > > +#define VHOST_SET_INHERIT_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8=
)
> > > > +
> > > >  #endif
> > > > --
> > > > 2.45.0
> > >
> >
>

