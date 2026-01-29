Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646D1372B2B
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769673857; cv=none; b=rhrvsDxlHVRVrZafvhlGN+Y4HzN+EYdbB7z/uswVJ1QugjJyQ334gh+n8hRHyp5+graRVzj7VFRWb5u3XcwPvw+7nKD74SM2mowui2fzF7R/G/7VkT3n58JUz+kO2HBMZKxLQRPVsxgLWQRG0be/qBSpFIwoEdzSRN389LXtNFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769673857; c=relaxed/simple;
	bh=KyK30KLbZWsWo6OTMrCMZZTr+bDK0I0lp19Fd47fee8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ny8D3Nbr+E1i2bwudIjfKiyXI9iwBG28OelzDHK3+90IBGeSE3DxMbsislZtxNhBa/LocbHscfxsvanEyq4tbCf9QmpVj3agrfJa5+Vnr1sQCe2xDLHU5iYsmp/JyxT8nXUcwBWy9REvrISoc+6RFwi68JawdJfm4KAtXv21F/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaDuqIae; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaDuqIae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769673855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wyyME91VUK3kMAxNxgC28ueVu6w2vdmmuYm1Nlh3zLs=;
	b=iaDuqIae0iAPm5JacyWUuIRmEohnYxcs52PjNlk6c8l0dV6dGGBWM5SDY1iiD18m+K3kBk
	0Gwy+gOjpHgpVja5+9HNXIEvR8KbGKi5BzXQrs8bni+8GlGuRWowNy0V1m8Rd+hCkeNstW
	YAhZhBQDr3xcKi2l+USVzckNXid9RtQ=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-HBFMI3otN1GJM3uIT4RCKQ-1; Thu, 29 Jan 2026 03:04:01 -0500
X-MC-Unique: HBFMI3otN1GJM3uIT4RCKQ-1
X-Mimecast-MFC-AGG-ID: HBFMI3otN1GJM3uIT4RCKQ_1769673841
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79478ec5035so10622117b3.1
        for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 00:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769673841; x=1770278641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wyyME91VUK3kMAxNxgC28ueVu6w2vdmmuYm1Nlh3zLs=;
        b=RAxHXkmmyYfXIC+hAwBdaEgP+xxmrEZ6n/pMqYRLpkHBAgckTukHlIacT9/HNStq8t
         cVuSGlI5uvr4gJ1Zpo4m83Yvb0py7IM+SNd27/26eco3YyvbNsRTqJz/Y4MstlQ2fGFA
         kk0plQIBIqR0QS99gnYUx1J0yYTgSJeXrK1x8NKRLaDBmaF3AZWLaFUVnLeXMStahrew
         yLcZl4Nb8fMe4HKFqjmOs1s2errwKnC1hrDTHvQnvm9cPAUf/+BumkXovUg4riCageZG
         8tAM5ELmfOsx9Myfdsr86qNFte/6vQ/SWqzVy+5oa+a/mDp7qGEurtNtHt7O7jeyyQXb
         XDvw==
X-Forwarded-Encrypted: i=1; AJvYcCWEDm7BVYhGKp2/pUIrHkaxGOOn7t6W8n1VQi6Ky0oQ9I2oLKIYjW6DvfXIzk0DDLYXUDSGXyRFb2LUK5Zwjg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQSiKyI/AR8tYyUziJgLTHfNR16vw6kk8USYCa3sQOx+SMb187
	+/m+0nHE9EfbEqKcnkw/C4U2FWv+ktOVI7BiobvLiMt+a0Kd9REVSJsighAAi1D96h+om0Vyc2V
	KDO48bB6EtjwrfSJVo7/+PZ6tgpc1TvPXj55kY0gobdZWFiJhkSTq4PbzWZKMQ2CddFcgCxM1XG
	xj4yc5uxLSP4siU0Cr8oEKxQWX7pR9VRDRRT2GLCGfFnE=
X-Gm-Gg: AZuq6aIQQ+SuoHd+m6/+xkrO9HAMsNSyL9A8Eqt3U1G7+LxcgCWZ2lj4RafsR7bsi5T
	zNiArDzaHmMLDhC7bgwUML0iMLujc20hlH8FhwOuaQjy0gIj6KyUqfpLHILnDtfQBb6OecG4Ws+
	/xL24m7foQ/2CwXWztC7NtuNpPFGr/jpmaql3QyoI2pbxAzY/xWMhGQFJ1j+dpS9PoBg==
X-Received: by 2002:a05:690c:c4fa:b0:794:2fc8:8358 with SMTP id 00721157ae682-7947a9c0f46mr67198727b3.6.1769673840717;
        Thu, 29 Jan 2026 00:04:00 -0800 (PST)
X-Received: by 2002:a05:690c:c4fa:b0:794:2fc8:8358 with SMTP id
 00721157ae682-7947a9c0f46mr67198537b3.6.1769673840283; Thu, 29 Jan 2026
 00:04:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260128124524.875271-1-eperezma@redhat.com> <20260128124524.875271-5-eperezma@redhat.com>
 <CACGkMEtmw-ofTt-EVH7o4dwZEk7qtXCuAsXyb7R71693UW9-RA@mail.gmail.com>
In-Reply-To: <CACGkMEtmw-ofTt-EVH7o4dwZEk7qtXCuAsXyb7R71693UW9-RA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 29 Jan 2026 09:03:23 +0100
X-Gm-Features: AZwV_QjZ0_w-q8WzxvAPjbH4uz3wZ_NpGlZSJNoOZWiA_ec0DVcF8D1HcobzD_8
Message-ID: <CAJaqyWc8GXrmsF4iv2B8VGPBEuRj_YVtRDWVeupQbty4oUw0jg@mail.gmail.com>
Subject: Re: [PATCH 4/6] vduse: add VDUSE_GET_FEATURES ioctl
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Cindy Lu <lulu@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: udKS8GNiV_WXmxX6j2ORVZFnNV3Cef4FOUS2AyrZ8eU_1769673841
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 3:10=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Jan 28, 2026 at 8:45=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redh=
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
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 28 ++++++++++++++++++++++++++++
> >  include/uapi/linux/vduse.h         |  7 ++++++-
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 551ccde0b856..e7da69c2ad71 100644
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
> > @@ -1977,6 +1980,19 @@ static bool vduse_validate_config(struct vduse_d=
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
> > @@ -2237,6 +2253,18 @@ static long vduse_ioctl(struct file *file, unsig=
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
> > +                       ret =3D -ENOIOCTLCMD;
>
> Should we stick to -EINVAL (see below)?
>

Good point! I got fooled by vduse_dev_ioctl that uses ENOIOCTLCMD as
default. I guess it's too late to change the mismatch. Changing for
V2.

Thanks!

>
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
> > index dea89ed281a7..1f68e556cbf2 100644
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
> > 2.52.0
> >
>
> Thanks
>

