Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48F301000
	for <virtualization@lists.linux.dev>; Fri, 13 Feb 2026 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770968385; cv=none; b=J7uFTpAvjWGudd3jtWGaapF+XO1NMfTiEaylV2CEqHTfn2RoGT0eAbSRPWAvYcxv1UPPxJd/I0gwChzF/RqORJLjQPKGEtWhQkuRWoemt4WEfoHzNosFujM3apfCffNos06LHFkzMotLR+sri1yODh6f4MOwRdtvsGImhyZ+4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770968385; c=relaxed/simple;
	bh=dIYWFBVG7P/Dz/QaqzMh9qEVBG2n5v4y43vlt3bjaEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXwDInXIKXmf4Mf4skHyeh4hX2Xrro07mq3CqKCH1tgOKtJzhPZc6jpog35ya0xh56JWd+EQiTah8BlZrxFUQdQKye6n4rNAf+T0C+TJ3yRtZet2cbTohX5jZK5hVXaazY4C2TYgMLGcm96nldGrbzF8ISd6C2+iECdKgoG7bwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqrYCAzU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqrYCAzU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770968381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJ4KuHQ6XsjU8YX9srQm8FvyrAZmX2HORsaGPjhIo3I=;
	b=bqrYCAzUixgelNw80LgenAdBG6g0hGwmG6y6joyLoDuQQPmZd3IUFYAHo4n3UanlBievQm
	nI0RC8duakYn55iXu8E02XgKrXS5c78VGxay5DZJHpQ11Cn2hTopnoI1YGoTV0o93+/eln
	6Z6quQ0TaxxqBXdKNJnWpN9U7rHKyco=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-2DvwOZD0N4GrHLjSSRjfng-1; Fri, 13 Feb 2026 02:39:39 -0500
X-MC-Unique: 2DvwOZD0N4GrHLjSSRjfng-1
X-Mimecast-MFC-AGG-ID: 2DvwOZD0N4GrHLjSSRjfng_1770968379
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7949310b90cso17192197b3.2
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 23:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770968379; x=1771573179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oJ4KuHQ6XsjU8YX9srQm8FvyrAZmX2HORsaGPjhIo3I=;
        b=pIazIAdvIANWmqkTt9DhVqS57oEiOHWNzc5auQANYPy+ZJ79Gm7IH3IdX97kfXn2SG
         PN0H6Y9XXu80FkjlvZ/E0rBOPsNvQbqEmFkrBOFAR+tkbzsciZM1MOWVz3F7ZLRICuy9
         ZpVqdO461vBopRwyKvr24POK+/qQNOS2NRyqsA4GPEWQ/6MV5w678qltqb9Z9pt+qoRY
         Z3i3NWpl5CPfBLJVQT3aHyzmkQCQBBBOGlm2bhGg6y4L9XTsL899WABbBy1Zjf4/ojJL
         0oGhCQcQeIkDerEWxgActrRnxXFQxIaYTDvobghh5tvh3T6AzdqQ8KxuvFcu/xVCWTeZ
         xrkg==
X-Forwarded-Encrypted: i=1; AJvYcCVoUpxB9qlY6oTUaxvMHu3KmLje6pj+tatmY1o+Q+tCTJBNj5AJjOpsm20RkBwk9WMSDF3b+ET+FfukN9sWfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu8bwaB1L9VgBYNvs/B4wfaZ1+15qcoUaR3wqO4TOvy2TNaBY6
	X48QiyzoVqmLa6A6dMOqfTuyEpAJXd/fDjgFeFEpRuq8nB8h2TQcN/X5pXFD39l4U4/4ybcgDfe
	etq2iWVCtERy9TYg4YhmSALtGBVPeA2bIlgJn8INr5h8eEEImhbPBXGJTwPt5O1L7g+Yxl50zNB
	PYxN3dscDuLvQBjX/q2OFqO3XuL6mP4hFra/XVlm0BNVI=
X-Gm-Gg: AZuq6aKL5JBIYhmW+NwhVJ4touxtQzajV8kSDZwXHd8o6wCcuJFF+sK7Rpq3+/l6IT8
	FNTW8kCwB6PzRm0xXnSsOU6zxo7kR1/syOOg73UjHRJyShbDl6fo1oKV0/FJzTjEF4wR3TBOwVJ
	R08aasFdzvYI6ex9r6DiS9rT7QOtCWkGONXvlWRLi6GWUioGXdk/PupXUDX2K5T4PBlo41dmljh
	K6+SQ==
X-Received: by 2002:a05:690c:6612:b0:792:7c6e:35fa with SMTP id 00721157ae682-797a0ce7accmr7374167b3.37.1770968379119;
        Thu, 12 Feb 2026 23:39:39 -0800 (PST)
X-Received: by 2002:a05:690c:6612:b0:792:7c6e:35fa with SMTP id
 00721157ae682-797a0ce7accmr7374037b3.37.1770968378753; Thu, 12 Feb 2026
 23:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260210082554.1582553-1-eperezma@redhat.com> <20260210082554.1582553-4-eperezma@redhat.com>
 <CACGkMEtmnV5xJ6crnfTr5Nk8tZe437OgqB22yTOJ+nnrb0LcPg@mail.gmail.com>
 <CAJaqyWdN7xdu_=mUzE3GGBtTeW5g6O0YwWnV_UmX+g2+FNDkZA@mail.gmail.com> <CACGkMEuY0f1xjxc4n6QzKfUa-LFrM-X_xtOpTwm5SWjfVvikHA@mail.gmail.com>
In-Reply-To: <CACGkMEuY0f1xjxc4n6QzKfUa-LFrM-X_xtOpTwm5SWjfVvikHA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 13 Feb 2026 08:39:02 +0100
X-Gm-Features: AZwV_Qj2-VdyZvDQlJpMAGnIMkGb-tEb4wqxTP5Vgj-DUADdBv_Ps8ld4UL1-SI
Message-ID: <CAJaqyWe4V77K7R+d_HvSR_2j+sXqemr+zcLUOf7BPu1hT1-ztA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vduse: add VDUSE_GET_FEATURES ioctl
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v7_v9IzCruepWRInixneVIKGHThRPhkUSG1Z2k7ApjQ_1770968379
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 2:25=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Feb 12, 2026 at 4:23=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Thu, Feb 12, 2026 at 9:07=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, Feb 10, 2026 at 4:26=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@=
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
> > > > v2:
> > > > * return -EINVAL if ioctl called with version < 2, so userland visi=
ble
> > > >   reply is kept (Jason).
> > > > ---
> > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++=
++
> > > >  include/uapi/linux/vduse.h         |  7 ++++++-
> > > >  2 files changed, 34 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa=
_user/vduse_dev.c
> > > > index d1da7c15d98b..7458cbaed4c7 100644
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
> > > > @@ -1947,6 +1950,19 @@ static bool vduse_validate_config(struct vdu=
se_dev_config *config,
> > > >                          sizeof(config->reserved)))
> > > >                 return false;
> > > >
> > > > +       if (api_version < VDUSE_API_VERSION_2) {
> > > > +               if (config->vduse_features) {
> > > > +                       dev_dbg(vduse_ctrl_dev,
> > > > +                               "config->vduse_features with versio=
n %llu",
> > > > +                               api_version);
> > > > +                       return false;
> > > > +               }
> > > > +       } else {
> > > > +               if (config->vduse_features & ~vduse_features)
> > > > +                       return false;
> > > > +       }
> > > > +
> > > > +
> > > >         if (api_version < VDUSE_API_VERSION_1 &&
> > > >             (config->ngroups || config->nas))
> > > >                 return false;
> > > > @@ -2207,6 +2223,18 @@ static long vduse_ioctl(struct file *file, u=
nsigned int cmd,
> > > >                 ret =3D vduse_destroy_dev(name);
> > > >                 break;
> > > >         }
> > > > +       case VDUSE_GET_FEATURES:
> > > > +               if (control->api_version < VDUSE_API_VERSION_2) {
> > > > +                       dev_dbg(vduse_ctrl_dev,
> > > > +                               "VDUSE_GET_FEATURES ioctl with vers=
ion %llu",
> > > > +                               control->api_version);
> > > > +                       ret =3D -EINVAL;
> > > > +                       break;
> > > > +               }
> > > > +
> > > > +               ret =3D put_user(vduse_features, (u64 __user *)argp=
);
> > > > +               break;
> > > > +
> > > >         default:
> > > >                 ret =3D -EINVAL;
> > > >                 break;
> > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.=
h
> > > > index 27832d46084c..8898d9daa777 100644
> > > > --- a/include/uapi/linux/vduse.h
> > > > +++ b/include/uapi/linux/vduse.h
> > > > @@ -37,6 +37,7 @@
> > > >   * @vq_align: the allocation alignment of virtqueue's metadata
> > > >   * @ngroups: number of vq groups that VDUSE device declares
> > > >   * @nas: number of address spaces that VDUSE device declares
> > > > + * @vduse_features: VDUSE features
> > > >   * @reserved: for future use, needs to be initialized to zero
> > > >   * @config_size: the size of the configuration space
> > > >   * @config: the buffer of the configuration space
> > > > @@ -53,7 +54,8 @@ struct vduse_dev_config {
> > > >         __u32 vq_align;
> > > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > >         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > > -       __u32 reserved[11];
> > > > +       __u64 vduse_features;
> > >
> > > Nit: Should we document " /* if VDUSE_API_VERSION >=3D 2 */
> > >
> > > But I have an open question, is this better to just introduce a
> > > VDUSE_SET_FEATURES then we can do negotiation to avoid bumping API
> > > versions?
> > >
> >
> > How do you know if you can call VDUSE_GET_FEATURES and
> > VDUSE_SET_FEATURES then? vduse_ioctl does not even return -ENOIOCMD
> > but -EINVAL if you call the equivalent of VDUSE_GET_FEATURES on
> > current Linux master. Or should the VDUSE instance assume that if the
> > ioctl returns -EINVAL the kernel does not support them?
>
> If we go that way, yes.
>

I'm ok with doing the change. Kind of, I still think that increasing
the API version is way cleaner, so no ioctl returns any error in
regular initialization. But python's style "ask forgiveness not
permission" is also ok for me.

But I'm really missing the motivation of it. What's the problem with
the increase of the version that you are trying to solve here?

Can we make a rule to know when to increase the version, and when it
is not needed and it is ok for ioctls to just return -EINVAL or
-ENOIOCTLCMD, so future series can hit the right behavior from earlier
versions?

From your comment I extract that we don't need to increase the API
version number if we just add ioctls commands to the device, like
probing if an ioctl exists. Also, we don't need to increase the
version if we can tell if a member in vduse_dev_config is known to
exist because a previous ioctl (or feature flag) succeeded.

Am I missing something?

