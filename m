Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035F2989B5
	for <virtualization@lists.linux.dev>; Fri, 13 Mar 2026 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773381391; cv=none; b=Wt+qHTQstEKglNjB+ex7xpj3M1sszC+UjrbSPkcQ/wvE7diWV/Jfq7sdcIGD/yHkRwweF+UhgJqdIvALz3iROBK6dOGg2UZ5PRvKoog7YJ432UbmYDF9KLbgpcqzB0h+DcgFhp3PjPC49p88UmID6TNvohpCtQSfNyxgzfLF+Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773381391; c=relaxed/simple;
	bh=KMkBYjsflTmLSE7cSPHf/abczcXCK6cJTS+sebYefVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYB9KPMxKCmZ32p1dCVVWPTyCI3IdAwlJ8fzofkdp/bT0tD+qJKyp4ncjcu0U/KGJoiAw5WHqOy7wTZQBozqHMcRtEhacXZkOg8vQEa86rMnKikALIGUBUVEXNZVJ1n0wh2TdTBINgq9m7reXQDWbvNnP0vCtvKtYDVAxtj1pBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cY7mjf8F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cY7mjf8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773381388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uMb43zuYUxUP2sHguUvyWzKcDiqC2RDt4x/CEkDAnA=;
	b=cY7mjf8FTE/K0yUxZWbB/BBQejtD+yjnmr95etpf7rI8vMf//UOniaggyMqocjhpUJPTit
	0cOybXyDBh8zUlGhLSD0XpKwgvMJnJXC5ZdI1Ns+8MlDowNnuhY+2ArANuVNEGZq6bynNT
	nNtixmKmWlszR/PW+QFhxDhIfvZ8llE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-e9E2QvKPPBejg5wOk_gZFA-1; Fri, 13 Mar 2026 01:56:26 -0400
X-MC-Unique: e9E2QvKPPBejg5wOk_gZFA-1
X-Mimecast-MFC-AGG-ID: e9E2QvKPPBejg5wOk_gZFA_1773381386
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aecd4f7ca1so4496935ad.2
        for <virtualization@lists.linux.dev>; Thu, 12 Mar 2026 22:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773381386; x=1773986186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1uMb43zuYUxUP2sHguUvyWzKcDiqC2RDt4x/CEkDAnA=;
        b=eydvQ2OFBjOW2hcMlvSNdEw9FCcl9+X4E9Wsr7dfKZxPWsVcCbw/g61rodUmPnl94I
         jfCPuFZ3Q1i+UF6027vqcwY6BSpsEq+x0n17rgGp8dqsRrJIsiHcRxsR+IJQGLCpXT9T
         5AJplaVAkKzKlsD7LwXLCOqdljhNn7qigKxppwSQo1m5KnwZHxNBUlU82gVkRal2fIv0
         HrydLkblH1oQPHe1DzD6vDFL7L7HaFgraj7/zqPDsAyjAS1ujYEkxPgU5LEOJYWIPs8A
         h/cDkDZi9aDbgzx1LwvrWVMdJEX1m5/ji43KhFpzJj6s16GdTFERKGT6MeFalvBg9ElW
         uAtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCSdD8FyCDv8eY3SR9Z2+5hQIS00arXzM78311bspcqw5hr6vij0Mctk5qiti337x2qJ5RXK3fhE+UzRPwpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnooFkhwcCaW4oz4I06vuRnwmaztJTpt1wb0GTsREYzhcAHALm
	zOhKtcDeNkYnEWG4/TEtJIa5FP3Qul9dTPUs2Qj39qrxGpiN9P7ObdmlGjcQx/5btkof7augMqR
	w2WVJgQU5c5ZyLSk51kI2Kpo44UIJvjSOPBAdKmbi5+8rUZ8p5G2SoxjXqcazuKaseuRAU4LAfi
	0PeGudo9ouiSGYJPQ3ku1I6slSi5rUzP7sGagePEBh5x4=
X-Gm-Gg: ATEYQzxpgrF8wQqmZxd9UKS0f2EmWBtekkKbxQwk3cNVGlK+5x8SUDgkqHmHDxNiSBK
	M28r44d1qJd+E/2u8zY+/y9fkd/d6NjjJ+h5XNZFhqMepK/4P8oZFqsWRQQsHo/5aLEn/d8nH1y
	ImAYZwMbIQfKT7ttuONR7H3HXHdT+D1wwrHtqPL78lgWED9tidS5Z3Btt0SIsE/X5FgDlDinkUZ
	kg=
X-Received: by 2002:a17:903:1b2f:b0:2ae:3e73:2b43 with SMTP id d9443c01a7336-2aecaa053ecmr20920495ad.22.1773381385749;
        Thu, 12 Mar 2026 22:56:25 -0700 (PDT)
X-Received: by 2002:a17:903:1b2f:b0:2ae:3e73:2b43 with SMTP id
 d9443c01a7336-2aecaa053ecmr20920315ad.22.1773381385304; Thu, 12 Mar 2026
 22:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260310190759.1097506-1-eperezma@redhat.com> <20260310190759.1097506-3-eperezma@redhat.com>
 <CACGkMEvafXSWZBsDtt5-zit5_po6U35ciP_-yhbv-MtKo4uG7Q@mail.gmail.com> <CAJaqyWf3kgjQ5AQs3yYipNTDvGnF-arcXvJkAJP3G6+eoSB5aQ@mail.gmail.com>
In-Reply-To: <CAJaqyWf3kgjQ5AQs3yYipNTDvGnF-arcXvJkAJP3G6+eoSB5aQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Mar 2026 13:56:14 +0800
X-Gm-Features: AaiRm51Fg5AE333KBzrIOD9Aqo5hMR7r6mkPKu5GJWHHiXDATN3Ihtw17R8zxFg
Message-ID: <CACGkMEvmA4BnMQoQfzhROmWx1XfQYgHYuZd8JgUy-2zb-ZeLWg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vduse: add VDUSE_GET_FEATURES ioctl
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoqueli@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JI0Tok2X2EaLNKLtbrCNLz3kh6wjgYSwFZJNDTbceOs_1773381386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 3:12=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Mar 12, 2026 at 4:56=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Mar 11, 2026 at 3:08=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > Add an ioctl to allow VDUSE instances to query the available features
> > > supported by the kernel module.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > > A simple u64 bitmap is used for feature flags. While a flexible array
> > > could support indefinite expansion, 64 bits is sufficient for the
> > > foreseeable future and simplifies the implementation.
> > >
> > > Also, dev_dbg is used for logging rather than dev_err as these can be
> > > triggered from userspace.
> > > ---
> > > v3:
> > > * Remove check for API_VERSION < 2
> > > * Add comment about struct vduse_dev_config:vduse_features is only va=
lid
> > >   if VDUSE_GET_FEATURES success.
> > >
> > > v2:
> > > * return -EINVAL if ioctl called with version < 2, so userland visibl=
e
> > >   reply is kept (Jason).
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++++++
> > >  include/uapi/linux/vduse.h         | 7 ++++++-
> > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_u=
ser/vduse_dev.c
> > > index d1da7c15d98b..17e0358d3a68 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -52,6 +52,9 @@
> > >
> > >  #define IRQ_UNBOUND -1
> > >
> > > +/* Supported VDUSE features */
> > > +static const uint64_t vduse_features;
> > > +
> > >  /*
> > >   * VDUSE instance have not asked the vduse API version, so assume 0.
> > >   *
> > > @@ -2207,6 +2210,10 @@ static long vduse_ioctl(struct file *file, uns=
igned int cmd,
> > >                 ret =3D vduse_destroy_dev(name);
> > >                 break;
> > >         }
> > > +       case VDUSE_GET_FEATURES:
> > > +               ret =3D put_user(vduse_features, (u64 __user *)argp);
> > > +               break;
> > > +
> > >         default:
> > >                 ret =3D -EINVAL;
> > >                 break;
> > > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > > index 361eea511c21..e9b5f32a452d 100644
> > > --- a/include/uapi/linux/vduse.h
> > > +++ b/include/uapi/linux/vduse.h
> > > @@ -33,6 +33,7 @@
> > >   * @vq_align: the allocation alignment of virtqueue's metadata
> > >   * @ngroups: number of vq groups that VDUSE device declares
> > >   * @nas: number of address spaces that VDUSE device declares
> > > + * @vduse_features: VDUSE features
> > >   * @reserved: for future use, needs to be initialized to zero
> > >   * @config_size: the size of the configuration space
> > >   * @config: the buffer of the configuration space
> > > @@ -49,7 +50,8 @@ struct vduse_dev_config {
> > >         __u32 vq_align;
> > >         __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > >         __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > > -       __u32 reserved[11];
> > > +       __u64 vduse_features; /* if VDUSE_GET_FEATURES is not EINVAL =
*/
> > > +       __u32 reserved[9];
> >
> > If we go with VDUSE_GET_FEATURES, I'd perfer to go with
> > VDUSE_SET_FEATURES intead of this.
> >
>
> I didn't realize the lack of symmetry, but that approach grows and
> complicates the possible states of struct vduse_control and the
> vduse_ioctl code for little benefit in my opinion. Making it atomic in
> VDUSE_CREATE_DEV ioctl helps centralize all the potential errors.
> Also, from previous experience with vhost_vdpa, the ioctls slow down
> the device creation, which could affect things like VDUSE adoption for
> containers etc.

Maybe, but if we really care about the time spent on device creation,
uAPI needs redesigning. Or at least more feature in the future
wouldn't slow down further.

>
> On the other hand, it would make it easier to tell if the device
> couldn't be created because of invalid features set. This is highly
> unlikely, as the VDUSE device should retrieve the features by calling
> VDUSE_GET_FEATURES earlier.
>
> I don't think it is worth it, but if you think we should go that way
> I'm ok with the change.

It depends on the intialziation flow. After getting features, I'd
expect it's something like this

A:

1) GET_API_VERSION
2) SET_API_VERSION
3) GET_FEATURES
4) SET_FEATURES
5) CREATE_DEV

Or B in this patch:

1) GET_API_VERSION
2) SET_API_VERSION
3) GET_FEATURES
4) CREATE_DEV

I think it's better to stick the symmetry as API_VERSION (technically,
API could be set via config as well?)

BTW, I found VDUSE_SET_API_VERSION could be set multiple times (even
after the device is create), do we need to fix this?

Thanks

>
> > But we can hear from others.
> >
> > >         __u32 config_size;
> > >         __u8 config[];
> > >  };
> > > @@ -63,6 +65,9 @@ struct vduse_dev_config {
> > >   */
> > >  #define VDUSE_DESTROY_DEV      _IOW(VDUSE_BASE, 0x03, char[VDUSE_NAM=
E_MAX])
> > >
> > > +/* Get the VDUSE supported features */
> > > +#define VDUSE_GET_FEATURES     _IOR(VDUSE_BASE, 0x04, __u64)
> > > +
> > >  /* The ioctls for VDUSE device (/dev/vduse/$NAME) */
> > >
> > >  /**
> > > --
> > > 2.53.0
> > >
> >
> > Thanks
> >
>

