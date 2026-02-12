Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE94629DB65
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770884605; cv=none; b=anNZsF3Yc/JceJiiPeLfx8btKAiuUVu4IWC22/zkmiyJOs/5q0s2lHVYYMHWOp/oMyctndemegTZ753UgaQjUT4hvAAbHxxAOGQmKD0K1GHUGmyMMnIfzN/NXleuaYLkaxcZhHQUuUkJlGsD1WCBVy2YjPQ9d8Erq/E5jSwXuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770884605; c=relaxed/simple;
	bh=z/pXn8TXnuxrOSg9k5jd/qAQHE6dn68ko2jnlgTPVzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvmAU43qNHoIuH8FsUUV02ul7NnJhJwGrPycLRWJONN7f9aW7TdJ1s20BXOCLTfyeufo6/DaPnnbpM+HHakigmsSa8wYyatibCE+DkCgt75Eg54nPY4s7SQJ9rDoQV0RX/fVxqrRNT/0pXE3bGnEFaw3ICftD9Oq8B42iAS6/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iniHlXKs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iniHlXKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770884602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OC/VGwjjgLBAUhRxMjswL1yQl5rJUyEJP54DHWNIoA=;
	b=iniHlXKsTOijpsa9bV30qWQc6zC49EfA6fiKxkZ7dWUuWfMFtYsLh88vxuc9SUOFP7iQ9w
	LpKPCq1pIj3uJGz2Hcd2a4xov7AnY7jgpUZJhHSPqkPUVWez2WELOwTjm/TrRFykM4Xb4r
	Dmgiay4FeuV7eprFQVs+h3HpULxDG84=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-f4ZJ_QHLO3u83lBm3MMKsA-1; Thu, 12 Feb 2026 03:23:21 -0500
X-MC-Unique: f4ZJ_QHLO3u83lBm3MMKsA-1
X-Mimecast-MFC-AGG-ID: f4ZJ_QHLO3u83lBm3MMKsA_1770884601
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-794d80fea59so116985677b3.1
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 00:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770884601; x=1771489401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6OC/VGwjjgLBAUhRxMjswL1yQl5rJUyEJP54DHWNIoA=;
        b=B4xmCiBm0QTlyiPgUg6ftzWnsdSE6n+yso2eAdhk/pso9y2GOTMNVW/d4V9yIiCYkk
         WlzSW4Pnsv0FXTLJoihtYxAaWujJ69c6s/ZLcMDPVS1qj90J8aTCUPojiyecWR9PD+43
         +SL9vC6BpQ/aiRPzrbf9tQcbAmTMNKfmCkIyDuzBWFH2L+VtZBQFPQqdT/tvJ1b3ZUqb
         UkII+CbHlgg1FHdCqWlib99f/vM6y36bqlzxHqTud9s2hyAFPnLHkhdOglq6+rNVNMYb
         waMGsSloPAHTZea1FApVLbB4hTxdKdnqPvbYaj+yo6tpzFbrbk8HSO/3vF0oP5P3FKKb
         k7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtUaLGlUixWmXquFCeyC8jWBobDHdeb8xa8eOrpund6HCL1JFnDKObUzV7qfIQK4Q75ZUb6itGU52xykYzSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiNfvvUoyTew8nVmr9a04h/tnthliml66XqcVy0j2lAG9Extdy
	NaQ6Se0X17vQmr4x/J2KEJVOGTSxGgiYGnneu9atiCyj0x5sFJS3EZUK2HZ5KZF7vMarl7WC/fr
	fskR+jQzdUe8e6W936IJL8qNyCvCAFEDiU1N7yoJmlU9JRi+kJUI45rk8i4HjRqTXTuUZEOsNmO
	vZ2rBvzrgfCRboVzRYCWUIVcbI/vxsLcKwVpHtXOjeO/I=
X-Gm-Gg: AZuq6aLR9pN3Ddznq7hcYCDVmSSb9/FHe3dqp5LK0EmCnKjIE90tqoQ1OBaDP4il1k4
	vNbw7OHK1CzsumU2n6sF3uAv62uWVfMQYqGPjMPcMdzgiIVw9awzFHUkQJrG5HqWEjU2dglUnsE
	Fu8NjPc8x6d9tMGVfcKGAnWPj0dfY/nCg0Nzlrdr04rQ/BN5kI/1M5AywmqbA1jN2aw+9lQ7gRP
	A+4PQ==
X-Received: by 2002:a05:690c:39c:b0:796:3753:5373 with SMTP id 00721157ae682-797375d1b40mr21002237b3.29.1770884600903;
        Thu, 12 Feb 2026 00:23:20 -0800 (PST)
X-Received: by 2002:a05:690c:39c:b0:796:3753:5373 with SMTP id
 00721157ae682-797375d1b40mr21002097b3.29.1770884600522; Thu, 12 Feb 2026
 00:23:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260210082554.1582553-1-eperezma@redhat.com> <20260210082554.1582553-4-eperezma@redhat.com>
 <CACGkMEtmnV5xJ6crnfTr5Nk8tZe437OgqB22yTOJ+nnrb0LcPg@mail.gmail.com>
In-Reply-To: <CACGkMEtmnV5xJ6crnfTr5Nk8tZe437OgqB22yTOJ+nnrb0LcPg@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 12 Feb 2026 09:22:44 +0100
X-Gm-Features: AZwV_QidFIQEqbTPMW6NftMAyJ1L5qm_EtYmJNy8mcpLNnnNdZNNfJJ6NGkHi8k
Message-ID: <CAJaqyWdN7xdu_=mUzE3GGBtTeW5g6O0YwWnV_UmX+g2+FNDkZA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vduse: add VDUSE_GET_FEATURES ioctl
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eV3lHO5pJfCXmGvMjGGN8pc16V64-iaX2u0crun4Ugc_1770884601
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 9:07=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Feb 10, 2026 at 4:26=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > Add an ioctl to allow VDUSE instances to query the available features
> > supported by the kernel module.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > A simple u64 bitmap is used for feature flags. While a flexible array
> > could support indefinite expansion, 64 bits is sufficient for the
> > foreseeable future and simplifies the implementation.
> >
> > Also, dev_dbg is used for logging rather than dev_err as these can be
> > triggered from userspace.
> > ---
> > v2:
> > * return -EINVAL if ioctl called with version < 2, so userland visible
> >   reply is kept (Jason).
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++++
> >  include/uapi/linux/vduse.h         |  7 ++++++-
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index d1da7c15d98b..7458cbaed4c7 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -52,6 +52,9 @@
> >
> >  #define IRQ_UNBOUND -1
> >
> > +/* Supported VDUSE features */
> > +static const uint64_t vduse_features;
> > +
> >  /*
> >   * VDUSE instance have not asked the vduse API version, so assume 0.
> >   *
> > @@ -1947,6 +1950,19 @@ static bool vduse_validate_config(struct vduse_d=
ev_config *config,
> >                          sizeof(config->reserved)))
> >                 return false;
> >
> > +       if (api_version < VDUSE_API_VERSION_2) {
> > +               if (config->vduse_features) {
> > +                       dev_dbg(vduse_ctrl_dev,
> > +                               "config->vduse_features with version %l=
lu",
> > +                               api_version);
> > +                       return false;
> > +               }
> > +       } else {
> > +               if (config->vduse_features & ~vduse_features)
> > +                       return false;
> > +       }
> > +
> > +
> >         if (api_version < VDUSE_API_VERSION_1 &&
> >             (config->ngroups || config->nas))
> >                 return false;
> > @@ -2207,6 +2223,18 @@ static long vduse_ioctl(struct file *file, unsig=
ned int cmd,
> >                 ret =3D vduse_destroy_dev(name);
> >                 break;
> >         }
> > +       case VDUSE_GET_FEATURES:
> > +               if (control->api_version < VDUSE_API_VERSION_2) {
> > +                       dev_dbg(vduse_ctrl_dev,
> > +                               "VDUSE_GET_FEATURES ioctl with version =
%llu",
> > +                               control->api_version);
> > +                       ret =3D -EINVAL;
> > +                       break;
> > +               }
> > +
> > +               ret =3D put_user(vduse_features, (u64 __user *)argp);
> > +               break;
> > +
> >         default:
> >                 ret =3D -EINVAL;
> >                 break;
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index 27832d46084c..8898d9daa777 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -37,6 +37,7 @@
> >   * @vq_align: the allocation alignment of virtqueue's metadata
> >   * @ngroups: number of vq groups that VDUSE device declares
> >   * @nas: number of address spaces that VDUSE device declares
> > + * @vduse_features: VDUSE features
> >   * @reserved: for future use, needs to be initialized to zero
> >   * @config_size: the size of the configuration space
> >   * @config: the buffer of the configuration space
> > @@ -53,7 +54,8 @@ struct vduse_dev_config {
> >         __u32 vq_align;
> >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> >         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > -       __u32 reserved[11];
> > +       __u64 vduse_features;
>
> Nit: Should we document " /* if VDUSE_API_VERSION >=3D 2 */
>
> But I have an open question, is this better to just introduce a
> VDUSE_SET_FEATURES then we can do negotiation to avoid bumping API
> versions?
>

How do you know if you can call VDUSE_GET_FEATURES and
VDUSE_SET_FEATURES then? vduse_ioctl does not even return -ENOIOCMD
but -EINVAL if you call the equivalent of VDUSE_GET_FEATURES on
current Linux master. Or should the VDUSE instance assume that if the
ioctl returns -EINVAL the kernel does not support them?

