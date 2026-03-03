Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247838C417
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530834; cv=none; b=kW58Yrg6HGasiC3F9hZ8bl1mV/ZzjmK0LR39R0IZNcgLKMhdJXZ3h6tLcz0I6KoHjNda7gcF22as25dljts3fCoAwLJQPe54Bx3joskjFfggsZiJLyMeVqrOnk9hqy+wIebDAet6BsoOrUIDE0L1WS2r/RS4JcUl90UNDQVPFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530834; c=relaxed/simple;
	bh=u73vccNeIknkXFMjQNQEdLPdsfazttc0Rv4CdOtXj28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKzTjXY0USE3b2tiU44eUz0oCYaDzYsNCHYOzutZUi4+l6TdhcWC8Uk/JURsft9zPr3+kIgbEDsSSZWOo9/XItWehElxowmGbfUNyWzA2bO94GeBYi3HasdxkKRHf7fsH6TYM/kgjNhb0L7xpgbJqs4GjOXr42eW704mHkhkcmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBVIJbnl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBVIJbnl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772530832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1RwaNOlsDPDXV9mKJRBBpMxDcmRICMR1EGZ3rz2o2i8=;
	b=bBVIJbnlPq07FH4a+cLCW1GnfRstfKWNBkbvplZdYVg6/R7aAF4Fm14ZIK/8Y4L0ci5vty
	LhrKLywRdh9heVq4D38o0RCZ3dysh5BZhbRvKn4OPEiKeTywidZq34fhgCDougNpyt03YQ
	XS8oNh3yaOD8mGTI+rtYbHMyPMlLqHQ=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-BIgiDjNRPVSiIu-hi84CuA-1; Tue, 03 Mar 2026 04:40:31 -0500
X-MC-Unique: BIgiDjNRPVSiIu-hi84CuA-1
X-Mimecast-MFC-AGG-ID: BIgiDjNRPVSiIu-hi84CuA_1772530830
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-64ca4e3767dso6049802d50.2
        for <virtualization@lists.linux.dev>; Tue, 03 Mar 2026 01:40:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530830; x=1773135630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1RwaNOlsDPDXV9mKJRBBpMxDcmRICMR1EGZ3rz2o2i8=;
        b=wUdQovDGtugYuUOAXo0jzmgn8dr+TdTXBor72LHkKUM+36ZsdzhitP4PzCjhM0Z2HB
         woHyV5xGlwxskh1PdXQ9Epi1JytICrGdP6rKVH9+hplpxKf1MX1u01iZMmxkrU/sFo5j
         5VZ3LT8mHO6c18rf2+F3z2CRna/+926edFZzA3IY5sk5vj4z96vrRpF/n/yy7W33VgaP
         g1/29yprrn/pCXCnpFsMaz0LtdOUq4gnkIuL6/OAiP4wWxW/aEX8gadPjIkxf5mCWWmQ
         vPRxjnHs0aovDYZ48KSyVLlMz5vtFeyLQQXBTO0WGQyJXKt/cZ7SnkYC/GuxMbLEsaEu
         PLsw==
X-Forwarded-Encrypted: i=1; AJvYcCXcGbZMTXaOCPpErA59Mk6B9EeprPsaNpA/oGMDdVg4YwDOVakIxmDXXRLPD8+bIkzhYMmN86LtbL+8b58tZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQZwX6fnw9jLxbmIPIAiNvsOHf8zK7hR3SD5xgKTET1hNnuks0
	fZAS4+0gtnjKpsRoAEFyBNUZw3r0SB4gESlt9/DWwbwJ0hA1eVz5r1WsIXlER6Iz640YdXiJPZ1
	xPe9tcwcwvqf9d+JX2HaDx52TXZs3ddtOIteYzoIT3KG81XyfShAny9PZUN3vrmjoilLlxb+8Gx
	SaqD0tRyka6uV1++r6FW4DdQ56Gnp6Edrs7sbtIHVhgok=
X-Gm-Gg: ATEYQzyLzd5kOCU75INzONhkctuOnWY5bri+MmzsLXseWhDVA/o9oLQF8xPiivm0dZW
	2kew2VotAcpqMreQX7Oz6BZKPvN9EV3JrZsbas7mZrL3fDca+3e7wtu/DfoJgioc8abhksx47zM
	bzP76I19IwnxTNtFzkR8k2DLjD/CBhZHuIjxCxCDNaHf9o+atoTaTkABsG2c2IQ99D2pi9vacIT
	doQVQ==
X-Received: by 2002:a05:690e:691:b0:64a:d310:6113 with SMTP id 956f58d0204a3-64cc23355b7mr9783902d50.78.1772530830520;
        Tue, 03 Mar 2026 01:40:30 -0800 (PST)
X-Received: by 2002:a05:690e:691:b0:64a:d310:6113 with SMTP id
 956f58d0204a3-64cc23355b7mr9783892d50.78.1772530830082; Tue, 03 Mar 2026
 01:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260210082554.1582553-1-eperezma@redhat.com> <20260210082554.1582553-4-eperezma@redhat.com>
 <CACGkMEtmnV5xJ6crnfTr5Nk8tZe437OgqB22yTOJ+nnrb0LcPg@mail.gmail.com>
 <CAJaqyWdN7xdu_=mUzE3GGBtTeW5g6O0YwWnV_UmX+g2+FNDkZA@mail.gmail.com>
 <CACGkMEuY0f1xjxc4n6QzKfUa-LFrM-X_xtOpTwm5SWjfVvikHA@mail.gmail.com>
 <CAJaqyWe4V77K7R+d_HvSR_2j+sXqemr+zcLUOf7BPu1hT1-ztA@mail.gmail.com> <CACGkMEuADgAONQ6-RF6N9HWouTaVDztUVCW2q-KdLNwDEWfuKg@mail.gmail.com>
In-Reply-To: <CACGkMEuADgAONQ6-RF6N9HWouTaVDztUVCW2q-KdLNwDEWfuKg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Mar 2026 10:39:53 +0100
X-Gm-Features: AaiRm52AcIVACM_8QAsvqvl5f_ANRLdwss4LS7GV5c1MLRqdJ1jqzl0ofsRrFkk
Message-ID: <CAJaqyWfAfDEroH4C6bXrfUD-oWoEzvNwsBVg5kr-8OZJbAXHUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vduse: add VDUSE_GET_FEATURES ioctl
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1sIxmwY7bKMmMiAXWf2XbCqLy6uB2W87hDs_LWI0MoA_1772530830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 8:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Fri, Feb 13, 2026 at 3:39=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Fri, Feb 13, 2026 at 2:25=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Thu, Feb 12, 2026 at 4:23=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Thu, Feb 12, 2026 at 9:07=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Tue, Feb 10, 2026 at 4:26=E2=80=AFPM Eugenio P=C3=A9rez <epere=
zma@redhat.com> wrote:
> > > > > >
> > > > > > Add an ioctl to allow VDUSE instances to query the available fe=
atures
> > > > > > supported by the kernel module.
> > > > > >
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > ---
> > > > > > A simple u64 bitmap is used for feature flags. While a flexible=
 array
> > > > > > could support indefinite expansion, 64 bits is sufficient for t=
he
> > > > > > foreseeable future and simplifies the implementation.
> > > > > >
> > > > > > Also, dev_dbg is used for logging rather than dev_err as these =
can be
> > > > > > triggered from userspace.
> > > > > > ---
> > > > > > v2:
> > > > > > * return -EINVAL if ioctl called with version < 2, so userland =
visible
> > > > > >   reply is kept (Jason).
> > > > > > ---
> > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++=
++++++
> > > > > >  include/uapi/linux/vduse.h         |  7 ++++++-
> > > > > >  2 files changed, 34 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/=
vdpa_user/vduse_dev.c
> > > > > > index d1da7c15d98b..7458cbaed4c7 100644
> > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > @@ -52,6 +52,9 @@
> > > > > >
> > > > > >  #define IRQ_UNBOUND -1
> > > > > >
> > > > > > +/* Supported VDUSE features */
> > > > > > +static const uint64_t vduse_features;
> > > > > > +
> > > > > >  /*
> > > > > >   * VDUSE instance have not asked the vduse API version, so ass=
ume 0.
> > > > > >   *
> > > > > > @@ -1947,6 +1950,19 @@ static bool vduse_validate_config(struct=
 vduse_dev_config *config,
> > > > > >                          sizeof(config->reserved)))
> > > > > >                 return false;
> > > > > >
> > > > > > +       if (api_version < VDUSE_API_VERSION_2) {
> > > > > > +               if (config->vduse_features) {
> > > > > > +                       dev_dbg(vduse_ctrl_dev,
> > > > > > +                               "config->vduse_features with ve=
rsion %llu",
> > > > > > +                               api_version);
> > > > > > +                       return false;
> > > > > > +               }
> > > > > > +       } else {
> > > > > > +               if (config->vduse_features & ~vduse_features)
> > > > > > +                       return false;
> > > > > > +       }
> > > > > > +
> > > > > > +
> > > > > >         if (api_version < VDUSE_API_VERSION_1 &&
> > > > > >             (config->ngroups || config->nas))
> > > > > >                 return false;
> > > > > > @@ -2207,6 +2223,18 @@ static long vduse_ioctl(struct file *fil=
e, unsigned int cmd,
> > > > > >                 ret =3D vduse_destroy_dev(name);
> > > > > >                 break;
> > > > > >         }
> > > > > > +       case VDUSE_GET_FEATURES:
> > > > > > +               if (control->api_version < VDUSE_API_VERSION_2)=
 {
> > > > > > +                       dev_dbg(vduse_ctrl_dev,
> > > > > > +                               "VDUSE_GET_FEATURES ioctl with =
version %llu",
> > > > > > +                               control->api_version);
> > > > > > +                       ret =3D -EINVAL;
> > > > > > +                       break;
> > > > > > +               }
> > > > > > +
> > > > > > +               ret =3D put_user(vduse_features, (u64 __user *)=
argp);
> > > > > > +               break;
> > > > > > +
> > > > > >         default:
> > > > > >                 ret =3D -EINVAL;
> > > > > >                 break;
> > > > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vd=
use.h
> > > > > > index 27832d46084c..8898d9daa777 100644
> > > > > > --- a/include/uapi/linux/vduse.h
> > > > > > +++ b/include/uapi/linux/vduse.h
> > > > > > @@ -37,6 +37,7 @@
> > > > > >   * @vq_align: the allocation alignment of virtqueue's metadata
> > > > > >   * @ngroups: number of vq groups that VDUSE device declares
> > > > > >   * @nas: number of address spaces that VDUSE device declares
> > > > > > + * @vduse_features: VDUSE features
> > > > > >   * @reserved: for future use, needs to be initialized to zero
> > > > > >   * @config_size: the size of the configuration space
> > > > > >   * @config: the buffer of the configuration space
> > > > > > @@ -53,7 +54,8 @@ struct vduse_dev_config {
> > > > > >         __u32 vq_align;
> > > > > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > > > >         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > > > > -       __u32 reserved[11];
> > > > > > +       __u64 vduse_features;
> > > > >
> > > > > Nit: Should we document " /* if VDUSE_API_VERSION >=3D 2 */
> > > > >
> > > > > But I have an open question, is this better to just introduce a
> > > > > VDUSE_SET_FEATURES then we can do negotiation to avoid bumping AP=
I
> > > > > versions?
> > > > >
> > > >
> > > > How do you know if you can call VDUSE_GET_FEATURES and
> > > > VDUSE_SET_FEATURES then? vduse_ioctl does not even return -ENOIOCMD
> > > > but -EINVAL if you call the equivalent of VDUSE_GET_FEATURES on
> > > > current Linux master. Or should the VDUSE instance assume that if t=
he
> > > > ioctl returns -EINVAL the kernel does not support them?
> > >
> > > If we go that way, yes.
> > >
> >
> > I'm ok with doing the change. Kind of, I still think that increasing
> > the API version is way cleaner, so no ioctl returns any error in
> > regular initialization. But python's style "ask forgiveness not
> > permission" is also ok for me.
> >
> > But I'm really missing the motivation of it. What's the problem with
> > the increase of the version that you are trying to solve here?
>
> For example, if a feature is simply added via a new ioctl. I think we
> don't need to bump the version. An example is the umem reg/dereg.
> VDUSE starts from this choice so I think we should stick to that.
>

That's a good example, yes.

> I think a better time to bump the version are
>
> 1) an ioctl is expected to behave differently
> 2) new ioctls are mutually exclusive with one(s) of the existing ioctls
> 3) new initialization protocol
>

My line of thought was that the config struct initialization changed,
but modern devices can also support no features so the features field
keeps being 0.

> etc.
>
> >
> > Can we make a rule to know when to increase the version, and when it
> > is not needed and it is ok for ioctls to just return -EINVAL or
> > -ENOIOCTLCMD, so future series can hit the right behavior from earlier
> > versions?
>
> See above.
>
> >
> > From your comment I extract that we don't need to increase the API
> > version number if we just add ioctls commands to the device, like
> > probing if an ioctl exists. Also, we don't need to increase the
> > version if we can tell if a member in vduse_dev_config is known to
> > exist because a previous ioctl (or feature flag) succeeded.
> >
> > Am I missing something?
>
> I might be wrong, just some thoughts. Please correct me if I was wrong.
>

I'm happy with that, modern userland with the old kernel modules will
just see -ENOIOCTLCMD and take the right path. I guess it's the same
as umem reg/dereg.

Resending without bumping the API version.

