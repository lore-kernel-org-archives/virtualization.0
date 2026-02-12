Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560B32DAFAC
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770887135; cv=none; b=KQAsQ79T8aUJIxhcVYxRMZLuTMUjfRiXcYTLlD8QkrFe4EVWrFSoDJi5ttT+YNStCtBaNlm9D8iFr59M5cLSeafcYVID9PsU0wWUdedU8HLk88ZHy/PSOWq9W/EEFgeSqci/+MNXzpvWg4/KMctuZXFgH7Gjz4opfJuGvHDgjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770887135; c=relaxed/simple;
	bh=NxCby+UbuF6E2+yAmhTFRmEhCH2V6hYnjP6N74iQ0gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qadeckNixgqhaIvZd8VGl2zQg7l/PAyBSAC6sXPUfBRl0fkdTuvD2PIrA1f7eiVFBgDMVwysF6Q5MGplQ/iOgk4o5kfSPLJbLhvOUVTxDGjPTREl6dkv0ehcNL6nBuB/WoRvPJ+okNDd+BxBLwu7kk70EXJWcCXqnnPVqupJoDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4mHAOS1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4mHAOS1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770887133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wEwaCwGZ52LqEpV15ca7d15zS+bfhs/HOeedEvJKgQ=;
	b=Y4mHAOS14hSKmOhij/uuoAV06Qhp5+alOyDOwzYfRHOyleWzF2mHdom1cdwrdactC1lrTl
	6aG9MGcYOXTYwdxYv+2ZJP1XObbfLq5PUZHbPt21bW1wtj9DVzUkiLh4Eg/urTEbZpSQ+o
	FFlwOJwYnliVXenyb5VkfjugMdxxhQI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-W-fvOOKAPO6Ll63Zs_kucg-1; Thu, 12 Feb 2026 04:05:32 -0500
X-MC-Unique: W-fvOOKAPO6Ll63Zs_kucg-1
X-Mimecast-MFC-AGG-ID: W-fvOOKAPO6Ll63Zs_kucg_1770887131
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7962e684413so92329837b3.1
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 01:05:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770887131; x=1771491931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wEwaCwGZ52LqEpV15ca7d15zS+bfhs/HOeedEvJKgQ=;
        b=QQLF1qsWbnQCepobisIIkyLPqWgACFLuZ2ZrN5th42AYg0cxHERnnEnvrAUIz4sXa+
         sNW8Krwb9PDfQNav6fvFXWTU/c2CEtKNXAHJM2Tc+YcDCKrQDTaioLOGd57Xusb8YuXO
         qydAL0J+GIvJBXeua299azcxjo9FZMTbVJ6/AJGf90kDw6GWaEFtNP8fAwTWaZ6GbTDE
         nVD/kdojGTFJrHBAqGs5WL9YB5oqajdkgyWnhSYF5vWyOWIf7+pk4FfFu6m+s/1aYdWK
         Yg/FtL717WqmJP5h1qQrStZM1cl6EX+/OggLUFnuH6AEo5Lsvel5RNHs4VS4uvZRIyl0
         1s6A==
X-Forwarded-Encrypted: i=1; AJvYcCWcQs7tZBC3mp0MUZx8MQRe9kFtvFuPehTU9WU13fVLuLN3/D+Nxvn82Nkk9the+xhINmpGDqGOxR29ElTJJw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8B+mOhoMVQw+f88QwiwA9S4bgqkjm2MPoEPfC5St751V04vOv
	L9kj4+w3uM9Rw0kRh3XBPTS24yKFibYDCblJOHDotoMtfoc52k1uTn/0sKlxrDREqCf5brvX2jO
	wQ3M38DwD1J6GxE3FKTEtDzGbPH5Zd09nBQxYXnyfpv0oViszNAB2FQNPCXqJqz1jqabEEQrTXY
	hsFa5341zouj48zXKKdeAh9a4UfBQjZJXdOgpXux3gEzc=
X-Gm-Gg: AZuq6aKwhcFVIPSXbLxrlEgHM+LsvbPiOpp3MymSvNKLuBRJ9nxYuUEMjD7jfaoV7DU
	uLo8eOuoPrgjHiHQWMmhyZnCHJj9a7c89dBvYY6fQAHRcPpjigfXF6MwN7CID95zAq1YFAzlicj
	CGe6Qh3SmPoYUP/vwscCdA35EKj8vQ+0mxoEdcgnYtCulWL6h5ngwZafYy0Ryx1+fTvW2Zcqz1O
	g4aEQ==
X-Received: by 2002:a05:690c:e365:b0:795:1d73:4d7d with SMTP id 00721157ae682-79737691a0cmr20579647b3.12.1770887131580;
        Thu, 12 Feb 2026 01:05:31 -0800 (PST)
X-Received: by 2002:a05:690c:e365:b0:795:1d73:4d7d with SMTP id
 00721157ae682-79737691a0cmr20579487b3.12.1770887131242; Thu, 12 Feb 2026
 01:05:31 -0800 (PST)
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
Date: Thu, 12 Feb 2026 10:04:55 +0100
X-Gm-Features: AZwV_Qham5ruEKqBvjXNPkm-DVoIIdHOBygfH1jG8HzeF-KQYxfL2BVOuzWlBzk
Message-ID: <CAJaqyWdfcoOwif9XuAXOzAV4eq7HJzixV0JZ6a0FULQmY7bwkQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vduse: add VDUSE_GET_FEATURES ioctl
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Maxime Coquelin <mcoqueli@redhat.com>, 
	linux-kernel@vger.kernel.org, Yongji Xie <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8449GSmoMP0lWFbPMnUyte_8CxX5nBnEFMYsGlUT47o_1770887131
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

(I forgot to reply to this one) sure, I'll add the comment for the next ver=
sion.

Thanks!

> But I have an open question, is this better to just introduce a
> VDUSE_SET_FEATURES then we can do negotiation to avoid bumping API
> versions?
>
> Thanks
>
> > +       __u32 reserved[9];
> >         __u32 config_size;
> >         __u8 config[];
> >  };
> > @@ -67,6 +69,9 @@ struct vduse_dev_config {
> >   */
> >  #define VDUSE_DESTROY_DEV      _IOW(VDUSE_BASE, 0x03, char[VDUSE_NAME_=
MAX])
> >
> > +/* Get the VDUSE supported features */
> > +#define VDUSE_GET_FEATURES     _IOR(VDUSE_BASE, 0x04, __u64)
> > +
> >  /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
> >
> >  /**
> > --
> > 2.53.0
> >
>

