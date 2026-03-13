Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87547306B37
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384426; cv=none; b=J0PUbhHziZy7oupGebqy5UtzoF1m3ZNp5H0BC47l+GhTxwpIsdgIKZOstG2TNtqsDC7S7RFK6SfllOnBcGE1N4nCrKSBxdnz+r2ruAgCm+DSWcOZyOc3a+eDA37DU+mJv+ShGlL4J32dli8aoCqZGJ1GzdIF8KtTSYY0BzSsRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384426; c=relaxed/simple;
	bh=pMLLmkIps2g3RFhDfWvNns8B+ZWWTpg2gGLI+w0yOXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wwj4MuG5b5v/60JXKhSC6fUQETYs8hg/od8xnFREerLxQL4sMgpr4PlAt1M7Fpbn8LYNgApK+1ecMvbgSaR0z5ETTVRcEDZhqZDYFLp+JI7ejDK4OCYRT6wEajadv6xEyZqLJYMfX+5U7XPw8pXWh6hXYebzGg083/ebsFPblj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGe5IBZ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGe5IBZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773384422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5FKnFDsAdr487eFPRYI5nKwa5rmRjcCiHtypxJS97Jk=;
	b=RGe5IBZ4c6PzPOpG0sJ0/RfMg1M/LLpoieDEZQCPE47CeDLKYl3pot65wdC86w2MGNxCkp
	xFTJ00/NCsm8+BROzjJJQS4rp4gM4L03SwS5fovqR7OXj5AK1VlOYWbrp719gqPxVPfZ/y
	n3OvV6aRtgZdOUA0h24NKGszOqcTDPs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-2zAjpAnfMl2vz-P54nAPCg-1; Fri, 13 Mar 2026 02:47:00 -0400
X-MC-Unique: 2zAjpAnfMl2vz-P54nAPCg-1
X-Mimecast-MFC-AGG-ID: 2zAjpAnfMl2vz-P54nAPCg_1773384420
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7985951fa83so42810537b3.3
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 23:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773384418; x=1773989218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5FKnFDsAdr487eFPRYI5nKwa5rmRjcCiHtypxJS97Jk=;
        b=YuyRstdJUCb22d7mWnhlwInhdd9jakgn7lQzrpsWM+y3dF6EdnLO+LqO9K2CasKEhs
         vOFZFIgH07sQoqm4ufKIWwci0XbzSPeFBb4Eq3DUqAHk1oh301eoQgJEW4xipvzStX7D
         utAy6XrA/p5kVPIBHenGSXmou0G+D+GGA3a7S+dLj+EXslPEnm2k7pYjWQWKyHRTvMPS
         ivrE+cF+eh4bRnVjHjERL7nyHC9IJvuVCKlrLx0a3zPV32lLswtgg/ZGpDtiZJIPZPqZ
         LCFn6yfKv+GN3WRPrewX9RZTTLCBOTzOvv1GOpK7M0eRPXmdMcJnJIeT+T5ZBELtfddA
         jjfg==
X-Forwarded-Encrypted: i=1; AJvYcCWech0NIHqWewOlXIWwHzxDlZf0bwB7ms56LMt8rXJpCLYfqGEuK0RLN9gPyFMvWGrOyNM8ALZd6lLr8Qhnrg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq84kmxQHMXrau24cIni4X2JppT0QqyhNJ7OrL5eB+93f4qW5J
	Tm/3VG0OaPIx2NNFBFbECnUhYXIO+90LfOyK8DIhWpfAth7i7zzGiMzedOG9lPrbcsjwk2H5P+P
	rYC1uoBvNDHrtcNDFLt3J1qQ270IJoRnPAlI1117T2SPg36nAP0zdZFg5ZAZJq19+uxu62u7xcw
	uRDkiz8fj0Vmz6X4zVl/EcktwRssf3IUXba7Sgcbc619o=
X-Gm-Gg: ATEYQzwBuZY+QxNOKt945PVynDdg+woXQOULA9+9PT8H3e7pn4aFMLlQBgFqtnbQ5s5
	wf3AwhFL8CIha+PSfrkTO/pVgPcMXhqwZop0DqJQyOTqRc3jJW2LV9guuk1TbkhWyBl5FrrBjn0
	v/nlz2+BESQso5Yn6t8Ioh2pvVJ6amhVc9UiYov5aluC7LeCM99ME/2AbeO4eMkvBcj+RhqLND6
	Zn7rw==
X-Received: by 2002:a05:690c:6989:b0:798:9158:8fde with SMTP id 00721157ae682-79a1c23cc57mr21936897b3.65.1773384417837;
        Thu, 12 Mar 2026 23:46:57 -0700 (PDT)
X-Received: by 2002:a05:690c:6989:b0:798:9158:8fde with SMTP id
 00721157ae682-79a1c23cc57mr21936717b3.65.1773384417417; Thu, 12 Mar 2026
 23:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-3-eperezma@redhat.com>
 <CACGkMEvafXSWZBsDtt5-zit5_po6U35ciP_-yhbv-MtKo4uG7Q@mail.gmail.com>
 <CAJaqyWf3kgjQ5AQs3yYipNTDvGnF-arcXvJkAJP3G6+eoSB5aQ@mail.gmail.com> <CACGkMEvmA4BnMQoQfzhROmWx1XfQYgHYuZd8JgUy-2zb-ZeLWg@mail.gmail.com>
In-Reply-To: <CACGkMEvmA4BnMQoQfzhROmWx1XfQYgHYuZd8JgUy-2zb-ZeLWg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 13 Mar 2026 07:46:21 +0100
X-Gm-Features: AaiRm51fBkQ6wBOSGaNtk3FL7Vp0w8Q2C4ObJ8HIa4RaY4PgEvhjTDzFL101IQA
Message-ID: <CAJaqyWdQ-a1YbCER30noeGacWeaC=RQuUdPbFA4ke-r0p9boRw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vduse: add VDUSE_GET_FEATURES ioctl
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UkZPblhMXhnqXRuL6ZhCvN45QlJdMNG0ykeD8A8fVuI_1773384420
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 6:56=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Mar 12, 2026 at 3:12=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Mar 12, 2026 at 4:56=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@=
redhat.com> wrote:
> > > >
> > > > Add an ioctl to allow VDUSE instances to query the available featur=
es
> > > > supported by the kernel module.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > A simple u64 bitmap is used for feature flags. While a flexible arr=
ay
> > > > could support indefinite expansion, 64 bits is sufficient for the
> > > > foreseeable future and simplifies the implementation.
> > > >
> > > > Also, dev_dbg is used for logging rather than dev_err as these can =
be
> > > > triggered from userspace.
> > > > ---
> > > > v3:
> > > > * Remove check for API_VERSION < 2
> > > > * Add comment about struct vduse_dev_config:vduse_features is only =
valid
> > > >   if VDUSE_GET_FEATURES success.
> > > >
> > > > v2:
> > > > * return -EINVAL if ioctl called with version < 2, so userland visi=
ble
> > > >   reply is kept (Jason).
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
> > > >  include/uapi/linux/vduse.h         | 7 ++++++-
> > > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index d1da7c15d98b..17e0358d3a68 100644
> > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > @@ -52,6 +52,9 @@
> > > >
> > > >  #define IRQ_UNBOUND -1
> > > >
> > > > +/* Supported VDUSE features */
> > > > +static const uint64_t vduse_features;
> > > > +
> > > >  /*
> > > >   * VDUSE instance have not asked the vduse API version, so assume =
0.
> > > >   *
> > > > @@ -2207,6 +2210,10 @@ static long vduse_ioctl(struct file *file, u=
nsigned int cmd,
> > > >                 ret =3D vduse_destroy_dev(name);
> > > >                 break;
> > > >         }
> > > > +       case VDUSE_GET_FEATURES:
> > > > +               ret =3D put_user(vduse_features, (u64 __user *)argp=
);
> > > > +               break;
> > > > +
> > > >         default:
> > > >                 ret =3D -EINVAL;
> > > >                 break;
> > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.=
h
> > > > index 361eea511c21..e9b5f32a452d 100644
> > > > --- a/include/uapi/linux/vduse.h
> > > > +++ b/include/uapi/linux/vduse.h
> > > > @@ -33,6 +33,7 @@
> > > >   * @vq_align: the allocation alignment of virtqueue's metadata
> > > >   * @ngroups: number of vq groups that VDUSE device declares
> > > >   * @nas: number of address spaces that VDUSE device declares
> > > > + * @vduse_features: VDUSE features
> > > >   * @reserved: for future use, needs to be initialized to zero
> > > >   * @config_size: the size of the configuration space
> > > >   * @config: the buffer of the configuration space
> > > > @@ -49,7 +50,8 @@ struct vduse_dev_config {
> > > >         __u32 vq_align;
> > > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > >         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > > -       __u32 reserved[11];
> > > > +       __u64 vduse_features; /* if VDUSE_GET_FEATURES is not EINVA=
L */
> > > > +       __u32 reserved[9];
> > >
> > > If we go with VDUSE_GET_FEATURES, I'd perfer to go with
> > > VDUSE_SET_FEATURES intead of this.
> > >
> >
> > I didn't realize the lack of symmetry, but that approach grows and
> > complicates the possible states of struct vduse_control and the
> > vduse_ioctl code for little benefit in my opinion. Making it atomic in
> > VDUSE_CREATE_DEV ioctl helps centralize all the potential errors.
> > Also, from previous experience with vhost_vdpa, the ioctls slow down
> > the device creation, which could affect things like VDUSE adoption for
> > containers etc.
>
> Maybe, but if we really care about the time spent on device creation,
> uAPI needs redesigning. Or at least more feature in the future
> wouldn't slow down further.
>
> >
> > On the other hand, it would make it easier to tell if the device
> > couldn't be created because of invalid features set. This is highly
> > unlikely, as the VDUSE device should retrieve the features by calling
> > VDUSE_GET_FEATURES earlier.
> >
> > I don't think it is worth it, but if you think we should go that way
> > I'm ok with the change.
>
> It depends on the intialziation flow. After getting features, I'd
> expect it's something like this
>
> A:
>
> 1) GET_API_VERSION
> 2) SET_API_VERSION
> 3) GET_FEATURES
> 4) SET_FEATURES
> 5) CREATE_DEV
>
> Or B in this patch:
>
> 1) GET_API_VERSION
> 2) SET_API_VERSION
> 3) GET_FEATURES
> 4) CREATE_DEV
>
> I think it's better to stick the symmetry as API_VERSION (technically,
> API could be set via config as well?)
>

Yes, I'd have chosen to set the API_VERSION via config too.

> BTW, I found VDUSE_SET_API_VERSION could be set multiple times (even
> after the device is create), do we need to fix this?
>

It shouldn't be a problem, each device has its own copy of
api_version. It seems clear to me that the API setting only affects
devices created after the change, but I can add a guard after the
first device is created.

> Thanks
>
> >
> > > But we can hear from others.
> > >
> > > >         __u32 config_size;
> > > >         __u8 config[];
> > > >  };
> > > > @@ -63,6 +65,9 @@ struct vduse_dev_config {
> > > >   */
> > > >  #define VDUSE_DESTROY_DEV      _IOW(VDUSE_BASE, 0x03, char[VDUSE_N=
AME_MAX])
> > > >
> > > > +/* Get the VDUSE supported features */
> > > > +#define VDUSE_GET_FEATURES     _IOR(VDUSE_BASE, 0x04, __u64)
> > > > +
> > > >  /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
> > > >
> > > >  /**
> > > > --
> > > > 2.53.0
> > > >
> > >
> > > Thanks
> > >
> >
>

