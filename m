Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63963B38BF
	for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299559; cv=none; b=c7xcqBDEGXMJIZyUBQk/DfKFWpFTMl5p/hmV9RFEmLGwpsvPQU1lkjloL7Bk/aRHK3DAYnZ0piYez4ywf6tOIAtwxbYaSLjgEXnd/KqNWDVUtBBM1gf8DcfCN5uBU7l+4jzarhBLfsitpU/k29TERYYDWwXsoPjkm4eJOZeoOiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299559; c=relaxed/simple;
	bh=Dg0RQJL3pKNCKGgHU3DQttBlMKl3Ioc9rNUFx7fqhx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTOjil0Ih/5hSU6EqhE/zaILpkBmBvVONZdFcND9s/++2jDMDq2sAmBk3Kx0NQF+IgSQmlwVSTEG4DwACbt6SJwFLdL/vetKLxVaezwoFtp9nSSFlz0YPX5qfWEWO2CyitqQ5mciby1QQC/bsCX51QRBg8+Xhtqd+n3Y7iuCc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eruqjYEf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eruqjYEf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773299556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GaQ4VhlBOZrlJTelM6NwJ7mpCyQ8riP1bnSM17x/a0Q=;
	b=eruqjYEfMB+vHelam2xq8v9vWB5LOrrFMzIKgmoUiUmhOq3oGUx6crHF2SbXWDljlVOHQD
	pPD3LGr9AeInMcRfZCk7lNLBZ646mqKh8Ey/gJqSYFT8lff3HMP3/An3uQ+UrZnBK4hvca
	NDA9piD51Ys6z9DconP9utkLm3BOWW8=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-kX_YQ1eaM_qzsBf_-R6LiQ-1; Thu, 12 Mar 2026 03:12:35 -0400
X-MC-Unique: kX_YQ1eaM_qzsBf_-R6LiQ-1
X-Mimecast-MFC-AGG-ID: kX_YQ1eaM_qzsBf_-R6LiQ_1773299555
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64cb3951982so1501737d50.3
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 00:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773299555; x=1773904355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GaQ4VhlBOZrlJTelM6NwJ7mpCyQ8riP1bnSM17x/a0Q=;
        b=i1EVdknLh5ozGtRljtUApjjv571X/3FnED9eBAwubaM6bnZRINQaooEN/m5cwPX4Ke
         TQGO+zjuoTI+z0ginNAn55l09c1f3bv0zymXJqazCBVIuAu4uCU8cXFQQV396INtm3zu
         5Jk9mrlp/niGRJ+2jIK0ksurg4MgnlIT1yRnP50Q6+C/SoX38+mic1eBYayzmZQpC7KE
         OdvfrQ79M+YRoCvMdfabvvxpiqckG3QNJSfH4wyWfRtWwDHoAUK/RM+MSuG3uh9Agt7M
         nKTuOY8YAOKe5vBAYzYsg1rZFCCRaHv52WYioCYHqNNxQr48G8ldnVSSULUMIb6PAi/0
         pGIg==
X-Forwarded-Encrypted: i=1; AJvYcCV8UGgeoJvWKJ1APUjDk080cGw8fjqh6jpdz3bO7YR9F1kHLPOayORx1gcfSPLExE/+lRU1HMVhV83AbEIPxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2RU6LUXLJI3nXMOy/F77aGRStTBZq/WfTk4wz7WGlsg2OdZ8E
	lyg4uet+lIvppc1EAAZEGGAT4x7dPh0JBSQ1y+XMZkONG6CgikB7VSorN6oCRLt1PUW//pDGf1y
	yJ9rMW2PYxTZRa2gCmjEiwAVcV+cC1f/XcOepO62msorx1qZgTTph6W4QGiLWcUMN2K1/cNf9pU
	svYQm6kr1UbpQR7OxD8L9JJI7Xiam/jUIKtcYrwM1H5Pk=
X-Gm-Gg: ATEYQzyk9DDsPvIIlWBtqoxmrcDFW2h1IPU0sPuiRHI8AWTrkdd5ju2Z8NGsCXzntkb
	8LCQLTp5H80pBLEulnlAbq9G6zVk2cWJX0scDUMhca6pxG+JoU/hnmXOeKU1VwA0ffoclrh5c9e
	dIZEEJVD9vWINmb6di+fBIPZmVUken3Sps13uGVrGDPf0xU/cpXm1ng/eXkwB8j4lH88V2eyIFR
	FnYig==
X-Received: by 2002:a05:690e:e84:b0:64a:d74f:258c with SMTP id 956f58d0204a3-64d656a541dmr4573252d50.5.1773299555003;
        Thu, 12 Mar 2026 00:12:35 -0700 (PDT)
X-Received: by 2002:a05:690e:e84:b0:64a:d74f:258c with SMTP id
 956f58d0204a3-64d656a541dmr4573234d50.5.1773299554564; Thu, 12 Mar 2026
 00:12:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-3-eperezma@redhat.com>
 <CACGkMEvafXSWZBsDtt5-zit5_po6U35ciP_-yhbv-MtKo4uG7Q@mail.gmail.com>
In-Reply-To: <CACGkMEvafXSWZBsDtt5-zit5_po6U35ciP_-yhbv-MtKo4uG7Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 12 Mar 2026 08:11:58 +0100
X-Gm-Features: AaiRm51VMmIQiwXoNftm8bX4jR8eTefKv7M_V2MLs-G3dHrI9DDkSsOSMOJ2qvg
Message-ID: <CAJaqyWf3kgjQ5AQs3yYipNTDvGnF-arcXvJkAJP3G6+eoSB5aQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vduse: add VDUSE_GET_FEATURES ioctl
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MbhlRfv7OXE2_l8lL0TfXxcN-z0R-2Br3XEpTB56Nuw_1773299555
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 4:56=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
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
> > v3:
> > * Remove check for API_VERSION < 2
> > * Add comment about struct vduse_dev_config:vduse_features is only vali=
d
> >   if VDUSE_GET_FEATURES success.
> >
> > v2:
> > * return -EINVAL if ioctl called with version < 2, so userland visible
> >   reply is kept (Jason).
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
> >  include/uapi/linux/vduse.h         | 7 ++++++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index d1da7c15d98b..17e0358d3a68 100644
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
> > @@ -2207,6 +2210,10 @@ static long vduse_ioctl(struct file *file, unsig=
ned int cmd,
> >                 ret =3D vduse_destroy_dev(name);
> >                 break;
> >         }
> > +       case VDUSE_GET_FEATURES:
> > +               ret =3D put_user(vduse_features, (u64 __user *)argp);
> > +               break;
> > +
> >         default:
> >                 ret =3D -EINVAL;
> >                 break;
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index 361eea511c21..e9b5f32a452d 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -33,6 +33,7 @@
> >   * @vq_align: the allocation alignment of virtqueue's metadata
> >   * @ngroups: number of vq groups that VDUSE device declares
> >   * @nas: number of address spaces that VDUSE device declares
> > + * @vduse_features: VDUSE features
> >   * @reserved: for future use, needs to be initialized to zero
> >   * @config_size: the size of the configuration space
> >   * @config: the buffer of the configuration space
> > @@ -49,7 +50,8 @@ struct vduse_dev_config {
> >         __u32 vq_align;
> >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> >         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > -       __u32 reserved[11];
> > +       __u64 vduse_features; /* if VDUSE_GET_FEATURES is not EINVAL */
> > +       __u32 reserved[9];
>
> If we go with VDUSE_GET_FEATURES, I'd perfer to go with
> VDUSE_SET_FEATURES intead of this.
>

I didn't realize the lack of symmetry, but that approach grows and
complicates the possible states of struct vduse_control and the
vduse_ioctl code for little benefit in my opinion. Making it atomic in
VDUSE_CREATE_DEV ioctl helps centralize all the potential errors.
Also, from previous experience with vhost_vdpa, the ioctls slow down
the device creation, which could affect things like VDUSE adoption for
containers etc.

On the other hand, it would make it easier to tell if the device
couldn't be created because of invalid features set. This is highly
unlikely, as the VDUSE device should retrieve the features by calling
VDUSE_GET_FEATURES earlier.

I don't think it is worth it, but if you think we should go that way
I'm ok with the change.

> But we can hear from others.
>
> >         __u32 config_size;
> >         __u8 config[];
> >  };
> > @@ -63,6 +65,9 @@ struct vduse_dev_config {
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
> Thanks
>

