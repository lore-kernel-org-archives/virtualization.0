Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2B35BDBF
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770033090; cv=none; b=eJGQre2cxf9/2dkjIP2xr0V3AmYegC0pQjvt0kzdjppEmNukV8VSvtdw80NyoJe4lktkiybybeycpVn3mL2M4xYWpfkojud0PoHH/t95J71Sk8VQuIonARkQ8mdw6EnBhcSp8DbXjsaAwZEI1qWDMIT/B2mzZPEoeWxxZzItiIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770033090; c=relaxed/simple;
	bh=gHh+VPFBnlGNU0heiqIn5Gifmm8y3egjJN/otrcyoJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp0tzEPvcw1X2Q2ftCUSKBnWoZTr5f8zr+ncnAIkmy3p5RNfKquVh/gcBQ86eZkjntUBGaVJHnbydP6zjv/37Ay8a6rhKiEtq91RAdxAYZBpCOwk6ecuxDdNqw2KLmDaxQi/DYi85mTzOGUCeANlhviPCJ7wuB3JIj3gijfkYeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdWKwgI0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdWKwgI0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770033088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iuAe26jLjQBjz7TYbqOs18lcvLcD28qSaAF3l4WHdsE=;
	b=EdWKwgI0KuH6uxXJSuPU8DBY+d3bsZPVR6EwYXgl8evuGXbNPxi3jvaMhHW5JSS6BHjHF1
	qmhOR4Zj6W8VTQfJ+sEt41Rn4Yc3CcfMvSZp4bYP0LEfXDTnO+oqs8MZCXlaO/OmBxzfMy
	DR4tlpa0bExUf5PNu0nDWyorGA6mUwk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-hqHViFFyNFGtViR3bTX6Rw-1; Mon, 02 Feb 2026 06:51:26 -0500
X-MC-Unique: hqHViFFyNFGtViR3bTX6Rw-1
X-Mimecast-MFC-AGG-ID: hqHViFFyNFGtViR3bTX6Rw_1770033086
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-794b240c0d3so36882657b3.0
        for <virtualization@lists.linux.dev>; Mon, 02 Feb 2026 03:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770033086; x=1770637886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iuAe26jLjQBjz7TYbqOs18lcvLcD28qSaAF3l4WHdsE=;
        b=td/epbdFICJg7YjYiLCzysQytxG/Wh3L82Olp4A6od3expGpA5nj4Xrj6sVdi2HVEN
         kRg6lsey3cNozF4vC01gP1E1b+Ov0a7BbhIttp/BCm90/xtRevCyDLiC2lv1rCyELE9/
         bXEU0dG2mtp0K34h4r0pTNyoQyXamqBqVf334ksYPEfGLCgG3UrGwXxRkB6jqdG3V+RT
         JT6PIIXn64an/AiCriv8Gxq7+cgdBf16IqA33OBPzWK8Hb/39yvUhqOdzXs9qxI38R2j
         I3pS2Q86RNqJFMtVGsD8c4nu/rdy5/CV3Pq+Fs3na5gHmv3nQoige6NMqA9qkwJyUzwA
         xTTA==
X-Forwarded-Encrypted: i=1; AJvYcCXQEYeCw0ROEJCTT3BA8w3kibolxzIOi5397loZ2iSlZehHENefOlO0RXPnNFszk+mmYuQKT8lPY2pakckWOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKKwl1hW+YKkWee82DsWg9rzlj2DT+Ouu6l4kl9SSlGNIRzFTS
	k8jTCnZG5coKwueie385J0nxpsoqguM1E3tn/oWysuuTXButgUipAmR+jAyRw8q4wiebatn0W7W
	SPMmJ2qFFrUPE6HyjyRyXsda69H/b+wbx/50VC9gcPj7m/dRudrx2BIUUNT1k2qTMnfSYjADQ1h
	NI6rlpLXzXiRtszL0B++Z1fraEny0CpehawUnt+Lu4hyQ=
X-Gm-Gg: AZuq6aJ6yiDJdm8kWPWxy/+E+ZI5uTQ5rhkYrR7TFiwgcmkzJj3gmiA6fMlTbwMVzGg
	Msj6HznoeHYkVCbky08xHa7fp7SsujkDvr5pqvX+UqsBGkpTJvibr4qVy2OD17+Ij7tP3x85iW4
	169ab6QRs+9d1bf+XYH+MLD09nXU7xyZhP3byjVgTNkOf1v51txs6JG3a6Fv3sqDjC4Q==
X-Received: by 2002:a05:690c:7008:b0:794:1798:88a9 with SMTP id 00721157ae682-79490e07b0cmr123821497b3.35.1770033085948;
        Mon, 02 Feb 2026 03:51:25 -0800 (PST)
X-Received: by 2002:a05:690c:7008:b0:794:1798:88a9 with SMTP id
 00721157ae682-79490e07b0cmr123821337b3.35.1770033085584; Mon, 02 Feb 2026
 03:51:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260202095940.1358613-1-arnd@kernel.org> <CAJaqyWcrjuQAp=sTfpiQsBu4pS7sxix-ggS4BPCzxyDwW5MZQQ@mail.gmail.com>
In-Reply-To: <CAJaqyWcrjuQAp=sTfpiQsBu4pS7sxix-ggS4BPCzxyDwW5MZQQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 2 Feb 2026 12:50:49 +0100
X-Gm-Features: AZwV_QhwJYEfGfkLTTwW7B15NhblXZ9Fp2jea_64rdKWVgbdpFHO1gFbFbg9wCI
Message-ID: <CAJaqyWeLYCTmOAqOPuLZWaJWGn8Tg3uf4DtYTZYpvZUCXxxYzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vduse: avoid adding implicit padding
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Anders Roxell <anders.roxell@linaro.org>, Marco Crivellari <marco.crivellari@suse.com>, 
	Ashwini Sahu <ashwini@wisig.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: It-pD1tlfSHnVf5fVeTvYbO-QK47Co3iX_xCMRx6Mpc_1770033086
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 12:28=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Feb 2, 2026 at 11:06=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> w=
rote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The vduse_iova_range_v2 and vduse_iotlb_entry_v2 structures are both
> > defined in a way that adds implicit padding and is incompatible between
> > i386 and x86_64 userspace because of the different structure alignment
> > requirements. Building the header with -Wpadded shows these new warning=
s:
> >
> > vduse.h:305:1: error: padding struct size to alignment boundary with 4 =
bytes [-Werror=3Dpadded]
> > vduse.h:374:1: error: padding struct size to alignment boundary with 4 =
bytes [-Werror=3Dpadded]
> >
> > Change the amount of padding in these two structures to align them to
> > 64 bit words and avoid those problems. Since the v1 vduse_iotlb_entry
> > already has an inconsistent size, do not attempt to reuse the structure
> > but rather list the members indiviudally, with a fixed amount of
>
> s/indiviudally/individually/ if v2
>
> > padding.
> >
>
> That's something I didn't take into account, thanks!
>
> > Fixes: 079212f6877e ("vduse: add vq group asid support")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 40 +++++++++++-------------------
> >  include/uapi/linux/vduse.h         |  9 +++++--
> >  2 files changed, 21 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 73d1d517dc6c..405d59610f76 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1301,7 +1301,7 @@ static int vduse_dev_iotlb_entry(struct vduse_dev=
 *dev,
> >         int r =3D -EINVAL;
> >         struct vhost_iotlb_map *map;
> >
> > -       if (entry->v1.start > entry->v1.last || entry->asid >=3D dev->n=
as)
> > +       if (entry->start > entry->last || entry->asid >=3D dev->nas)
> >                 return -EINVAL;
> >
> >         asid =3D array_index_nospec(entry->asid, dev->nas);
> > @@ -1312,18 +1312,18 @@ static int vduse_dev_iotlb_entry(struct vduse_d=
ev *dev,
> >
> >         spin_lock(&dev->as[asid].domain->iotlb_lock);
> >         map =3D vhost_iotlb_itree_first(dev->as[asid].domain->iotlb,
> > -                                     entry->v1.start, entry->v1.last);
> > +                                     entry->start, entry->last);
> >         if (map) {
> >                 if (f) {
> >                         const struct vdpa_map_file *map_file;
> >
> >                         map_file =3D (struct vdpa_map_file *)map->opaqu=
e;
> > -                       entry->v1.offset =3D map_file->offset;
> > +                       entry->offset =3D map_file->offset;
> >                         *f =3D get_file(map_file->file);
> >                 }
> > -               entry->v1.start =3D map->start;
> > -               entry->v1.last =3D map->last;
> > -               entry->v1.perm =3D map->perm;
> > +               entry->start =3D map->start;
> > +               entry->last =3D map->last;
> > +               entry->perm =3D map->perm;
> >                 if (capability) {
> >                         *capability =3D 0;
> >
> > @@ -1363,14 +1363,8 @@ static long vduse_dev_ioctl(struct file *file, u=
nsigned int cmd,
> >                         break;
> >
> >                 ret =3D -EFAULT;
> > -               if (cmd =3D=3D VDUSE_IOTLB_GET_FD2) {
> > -                       if (copy_from_user(&entry, argp, sizeof(entry))=
)
> > -                               break;
> > -               } else {
> > -                       if (copy_from_user(&entry.v1, argp,
> > -                                          sizeof(entry.v1)))
> > -                               break;
> > -               }
> > +               if (copy_from_user(&entry, argp, _IOC_SIZE(cmd)))
>
> I did not know about _IOC_SIZE and I like how it reduces the complexity, =
thanks!
>
> As a proposal, maybe we can add MIN(_IOC_SIZE, sizeof(entry)) ? Not
> sure if it is too much boilerplate for nothing as the compiler should
> make the code identical and the uapi ioctl part should never change.
> But it seems to me future changes to the code are better tied with the
> MIN.
>
> I'm ok with not including MIN() either way.
>
> > +                       break;
> >
> >                 ret =3D -EINVAL;
> >                 if (!is_mem_zero((const char *)entry.reserved,
> > @@ -1385,19 +1379,13 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                 if (!f)
> >                         break;
> >
> > -               if (cmd =3D=3D VDUSE_IOTLB_GET_FD2)
> > -                       ret =3D copy_to_user(argp, &entry,
> > -                                          sizeof(entry));
> > -               else
> > -                       ret =3D copy_to_user(argp, &entry.v1,
> > -                                          sizeof(entry.v1));
> > -
> > +               ret =3D copy_to_user(argp, &entry, _IOC_SIZE(cmd));
> >                 if (ret) {
> >                         ret =3D -EFAULT;
> >                         fput(f);
> >                         break;
> >                 }
> > -               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.v1=
.perm));
> > +               ret =3D receive_fd(f, NULL, perm_to_file_flags(entry.pe=
rm));
> >                 fput(f);
> >                 break;
> >         }
> > @@ -1603,16 +1591,16 @@ static long vduse_dev_ioctl(struct file *file, =
unsigned int cmd,
> >                 } else if (info.asid >=3D dev->nas)
> >                         break;
> >
> > -               entry.v1.start =3D info.start;
> > -               entry.v1.last =3D info.last;
> > +               entry.start =3D info.start;
> > +               entry.last =3D info.last;
> >                 entry.asid =3D info.asid;
> >                 ret =3D vduse_dev_iotlb_entry(dev, &entry, NULL,
> >                                             &info.capability);
> >                 if (ret < 0)
> >                         break;
> >
> > -               info.start =3D entry.v1.start;
> > -               info.last =3D entry.v1.last;
> > +               info.start =3D entry.start;
> > +               info.last =3D entry.last;
> >                 info.asid =3D entry.asid;
> >
> >                 ret =3D -EFAULT;
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index faae7718bd2e..deca8c7b9178 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -299,9 +299,13 @@ struct vduse_iova_info {
> >   * Structure used by VDUSE_IOTLB_GET_FD2 ioctl to find an overlapped I=
OVA region.
> >   */
> >  struct vduse_iotlb_entry_v2 {
> > -       struct vduse_iotlb_entry v1;
> > +       __u64 offset;
> > +       __u64 start;
> > +       __u64 last;
> > +       __u8 perm;
> > +       __u8 padding[7];
> >         __u32 asid;
> > -       __u32 reserved[12];
> > +       __u32 reserved[11];

(I hit "Send" too early).

We could make this padding[3] so reserved keeps being [12]. This way
the struct members keep the same alignment between the commits. Not
super important as there should not be a lot of users of this right
now, we're just introducing it.

> >  };
> >
> >  /*
> > @@ -371,6 +375,7 @@ struct vduse_iova_range_v2 {
> >         __u64 start;
> >         __u64 last;
> >         __u32 asid;
> > +       __u32 padding;
> >  };
> >

