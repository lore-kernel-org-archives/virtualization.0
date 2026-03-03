Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28DE285C8B
	for <virtualization@lists.linux.dev>; Tue,  3 Mar 2026 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522440; cv=none; b=pmHl8O9K6NZh3O/OEDRB0NwdAbGLosbYgHTz2zMFlAHkIalzbYkeJ8teoCCGTk6LGjwTuJ9LkvJHK6f3DaJrRlNOFVlT1gj1rUG5jHaVMRhNGWv6x/SPhcp/JVK3UBI6fBDUf+c07SQZqU+szigPFVFscffPnzCi544GPBSukkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522440; c=relaxed/simple;
	bh=n6i24Y3ToeCOxwi/6iUNfrvz5MfKb3LdGsMrdc0ydPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tr5UzGfRRUetrnKrZsiM9b9AnumxQTJpLOvQQgdLKCTjBztIc5A96y504nDJHndgZW8Opy+A33Le3a/e50OAcUDOJd0bF7qwizs4uQKaOYLcwE6XnADu1mjVylSbkUlIoDjoUHZb284sKwDwuZA/a90dF2VX1I5UbG6A8EiFMqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDTzaEL0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDTzaEL0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772522437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=14+ydao3f/G23UqxiCS9Cg9nGpfr5ZtAKSKcbUtHG2I=;
	b=EDTzaEL0weUqR1T2BPLgkdr4Nvn0gHplSSLHh7wKaoDv6GpbUYbNf1kPqS5d0mMKm63OJO
	1NDZorT+NO9kvi1AIVeH6LBE9ofaLO1NyclraU+1AS65HaxDdVLyi+7EHuQHKDCtBaGZ4u
	9eyha+9XTYORHv7ZgyDCLeFjM1tyCqs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-Q9xPJhdROy6cHcir80QitA-1; Tue, 03 Mar 2026 02:20:36 -0500
X-MC-Unique: Q9xPJhdROy6cHcir80QitA-1
X-Mimecast-MFC-AGG-ID: Q9xPJhdROy6cHcir80QitA_1772522436
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3568090851aso31633070a91.1
        for <virtualization@lists.linux.dev>; Mon, 02 Mar 2026 23:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772522435; x=1773127235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14+ydao3f/G23UqxiCS9Cg9nGpfr5ZtAKSKcbUtHG2I=;
        b=u1yeuvIldwfH9DdvAnu9De0DRuq+tGK7JeX3hmMpVbY1ah8DnXQKqoGmvc/w4z22sm
         acoL+VF+TQfebEbmhV4xYgRTStPG2BYJtWX5tK3JT7QBrLJ8lMtPKa7pSMKYqntlfD4y
         WOKN2mxvBXv33nvXFOyZvx75Abbf33xMJfjFut3YTGj28NwoqdWX2zaDrWfzW4GaZ0jH
         0RwJCJkotM1taUKojrVbFC0tqRpm8zQdb2ir4Bo7r7i2qiwox88nl7HyQUUPxpBVTePC
         ahUle2tq6VnEPs+LXLDj3MRhgwvxSHs5YUihO5+oxI1Op0jraQb+4ywcR/iM4Gg2T9Sa
         ybKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmiEUbrN4jx/Qa4iu5KHVn7Qots+Rt9gqj1ZtLgs9Y7jjsrWzbB3vi5sw0Iw4Qxh10AXopP7rZ5C4nrdKb1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywg5tcEubvWUn42C26VTiDt+hCcQorQcJuvuS9AMOyrN2XDcUW+
	cUcuZVLHtLtkJitaJrNBmyOEIBRNjRpb+0DCF8lAehyCp/TQx828fo1Zxu/ucRFDL5G1u++rNlR
	ZtgbHY0CgMTp+PiFO3JgS4n9fJV9k4lipnFWsqj9mU3DFPJVdHdUTRwCiE2d5juRlxuBSV3VhLj
	lxqJx8rPNSZVEKbeycJp4v884oTzqKj18+ncmdxxh0jq4=
X-Gm-Gg: ATEYQzy38J2ujNP6RSazxudbLGCw+0mf1RsvGHdciMVTc9zhNFJ7VEmCcgBafOsA4WZ
	C761Nu7yoW3EvPb73NP5a0IC+L+gozgw3sz1xGIs8NR6gaV74Z3UCS7/ebcmOvHxLcNMoHqOwUE
	uU2kDR5uTYBXiiqaZcseb9MciTC4QEUfXfWQwdu/gr0vOk8KboYEq7JnPHzHO1VSIJJQKd0xqPz
	ncQbGkd
X-Received: by 2002:a17:90a:e18f:b0:356:8719:f516 with SMTP id 98e67ed59e1d1-35965ceaf7dmr13943450a91.24.1772522435522;
        Mon, 02 Mar 2026 23:20:35 -0800 (PST)
X-Received: by 2002:a17:90a:e18f:b0:356:8719:f516 with SMTP id
 98e67ed59e1d1-35965ceaf7dmr13943418a91.24.1772522435015; Mon, 02 Mar 2026
 23:20:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260210082554.1582553-1-eperezma@redhat.com> <20260210082554.1582553-4-eperezma@redhat.com>
 <CACGkMEtmnV5xJ6crnfTr5Nk8tZe437OgqB22yTOJ+nnrb0LcPg@mail.gmail.com>
 <CAJaqyWdN7xdu_=mUzE3GGBtTeW5g6O0YwWnV_UmX+g2+FNDkZA@mail.gmail.com>
 <CACGkMEuY0f1xjxc4n6QzKfUa-LFrM-X_xtOpTwm5SWjfVvikHA@mail.gmail.com> <CAJaqyWe4V77K7R+d_HvSR_2j+sXqemr+zcLUOf7BPu1hT1-ztA@mail.gmail.com>
In-Reply-To: <CAJaqyWe4V77K7R+d_HvSR_2j+sXqemr+zcLUOf7BPu1hT1-ztA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Mar 2026 15:20:22 +0800
X-Gm-Features: AaiRm51LLj3Genwd6PoRk26KHkgRqGJ09gL5MwiBySVF8FeNeBQbzkvRlOhzFkg
Message-ID: <CACGkMEuADgAONQ6-RF6N9HWouTaVDztUVCW2q-KdLNwDEWfuKg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vduse: add VDUSE_GET_FEATURES ioctl
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ioS5802vRFELVJF_LvCYktfkDjE7OWi_AvKrOn4s5Hc_1772522436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 3:39=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Feb 13, 2026 at 2:25=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Feb 12, 2026 at 4:23=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Thu, Feb 12, 2026 at 9:07=E2=80=AFAM Jason Wang <jasowang@redhat.c=
om> wrote:
> > > >
> > > > On Tue, Feb 10, 2026 at 4:26=E2=80=AFPM Eugenio P=C3=A9rez <eperezm=
a@redhat.com> wrote:
> > > > >
> > > > > Add an ioctl to allow VDUSE instances to query the available feat=
ures
> > > > > supported by the kernel module.
> > > > >
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > A simple u64 bitmap is used for feature flags. While a flexible a=
rray
> > > > > could support indefinite expansion, 64 bits is sufficient for the
> > > > > foreseeable future and simplifies the implementation.
> > > > >
> > > > > Also, dev_dbg is used for logging rather than dev_err as these ca=
n be
> > > > > triggered from userspace.
> > > > > ---
> > > > > v2:
> > > > > * return -EINVAL if ioctl called with version < 2, so userland vi=
sible
> > > > >   reply is kept (Jason).
> > > > > ---
> > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++=
++++
> > > > >  include/uapi/linux/vduse.h         |  7 ++++++-
> > > > >  2 files changed, 34 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vd=
pa_user/vduse_dev.c
> > > > > index d1da7c15d98b..7458cbaed4c7 100644
> > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > @@ -52,6 +52,9 @@
> > > > >
> > > > >  #define IRQ_UNBOUND -1
> > > > >
> > > > > +/* Supported VDUSE features */
> > > > > +static const uint64_t vduse_features;
> > > > > +
> > > > >  /*
> > > > >   * VDUSE instance have not asked the vduse API version, so assum=
e 0.
> > > > >   *
> > > > > @@ -1947,6 +1950,19 @@ static bool vduse_validate_config(struct v=
duse_dev_config *config,
> > > > >                          sizeof(config->reserved)))
> > > > >                 return false;
> > > > >
> > > > > +       if (api_version < VDUSE_API_VERSION_2) {
> > > > > +               if (config->vduse_features) {
> > > > > +                       dev_dbg(vduse_ctrl_dev,
> > > > > +                               "config->vduse_features with vers=
ion %llu",
> > > > > +                               api_version);
> > > > > +                       return false;
> > > > > +               }
> > > > > +       } else {
> > > > > +               if (config->vduse_features & ~vduse_features)
> > > > > +                       return false;
> > > > > +       }
> > > > > +
> > > > > +
> > > > >         if (api_version < VDUSE_API_VERSION_1 &&
> > > > >             (config->ngroups || config->nas))
> > > > >                 return false;
> > > > > @@ -2207,6 +2223,18 @@ static long vduse_ioctl(struct file *file,=
 unsigned int cmd,
> > > > >                 ret =3D vduse_destroy_dev(name);
> > > > >                 break;
> > > > >         }
> > > > > +       case VDUSE_GET_FEATURES:
> > > > > +               if (control->api_version < VDUSE_API_VERSION_2) {
> > > > > +                       dev_dbg(vduse_ctrl_dev,
> > > > > +                               "VDUSE_GET_FEATURES ioctl with ve=
rsion %llu",
> > > > > +                               control->api_version);
> > > > > +                       ret =3D -EINVAL;
> > > > > +                       break;
> > > > > +               }
> > > > > +
> > > > > +               ret =3D put_user(vduse_features, (u64 __user *)ar=
gp);
> > > > > +               break;
> > > > > +
> > > > >         default:
> > > > >                 ret =3D -EINVAL;
> > > > >                 break;
> > > > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vdus=
e.h
> > > > > index 27832d46084c..8898d9daa777 100644
> > > > > --- a/include/uapi/linux/vduse.h
> > > > > +++ b/include/uapi/linux/vduse.h
> > > > > @@ -37,6 +37,7 @@
> > > > >   * @vq_align: the allocation alignment of virtqueue's metadata
> > > > >   * @ngroups: number of vq groups that VDUSE device declares
> > > > >   * @nas: number of address spaces that VDUSE device declares
> > > > > + * @vduse_features: VDUSE features
> > > > >   * @reserved: for future use, needs to be initialized to zero
> > > > >   * @config_size: the size of the configuration space
> > > > >   * @config: the buffer of the configuration space
> > > > > @@ -53,7 +54,8 @@ struct vduse_dev_config {
> > > > >         __u32 vq_align;
> > > > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > > > >         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > > > -       __u32 reserved[11];
> > > > > +       __u64 vduse_features;
> > > >
> > > > Nit: Should we document " /* if VDUSE_API_VERSION >=3D 2 */
> > > >
> > > > But I have an open question, is this better to just introduce a
> > > > VDUSE_SET_FEATURES then we can do negotiation to avoid bumping API
> > > > versions?
> > > >
> > >
> > > How do you know if you can call VDUSE_GET_FEATURES and
> > > VDUSE_SET_FEATURES then? vduse_ioctl does not even return -ENOIOCMD
> > > but -EINVAL if you call the equivalent of VDUSE_GET_FEATURES on
> > > current Linux master. Or should the VDUSE instance assume that if the
> > > ioctl returns -EINVAL the kernel does not support them?
> >
> > If we go that way, yes.
> >
>
> I'm ok with doing the change. Kind of, I still think that increasing
> the API version is way cleaner, so no ioctl returns any error in
> regular initialization. But python's style "ask forgiveness not
> permission" is also ok for me.
>
> But I'm really missing the motivation of it. What's the problem with
> the increase of the version that you are trying to solve here?

For example, if a feature is simply added via a new ioctl. I think we
don't need to bump the version. An example is the umem reg/dereg.
VDUSE starts from this choice so I think we should stick to that.

I think a better time to bump the version are

1) an ioctl is expected to behave differently
2) new ioctls are mutually exclusive with one(s) of the existing ioctls
3) new initialization protocol

etc.

>
> Can we make a rule to know when to increase the version, and when it
> is not needed and it is ok for ioctls to just return -EINVAL or
> -ENOIOCTLCMD, so future series can hit the right behavior from earlier
> versions?

See above.

>
> From your comment I extract that we don't need to increase the API
> version number if we just add ioctls commands to the device, like
> probing if an ioctl exists. Also, we don't need to increase the
> version if we can tell if a member in vduse_dev_config is known to
> exist because a previous ioctl (or feature flag) succeeded.
>
> Am I missing something?

I might be wrong, just some thoughts. Please correct me if I was wrong.

Thanks

>

