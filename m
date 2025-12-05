Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48F2FC87E
	for <virtualization@lists.linux.dev>; Fri,  5 Dec 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764948664; cv=none; b=ls23dMeQc4jfE+X7QZPhh5puUtdZqmfGqSIiLlPnJMXBQhYsTLs9epVr7C7yzT6bbJP3kAdz5CQwRXqocEIoepOw8W4O7sau66E3UdqyOmqseHA00I4B5gsYlXPhjoRHfACQ9KxJseCLWy7Qw1VKOn73lIglGL75csgVuMgevwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764948664; c=relaxed/simple;
	bh=NEiJh92pq3LDcv6VfFCeYcvWYfapZK47Jwx09BzBVS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPuARxMfRo7Yvi/SMaMnzb65AsfqfnQdcWlPy5K6Fxj9Qqbs4si9cxNLlHsWLT7V8CdvPedmaVjvLpxBExOZoYlmQe2odJ2aRBrJPfgPQ2nCgcAgJ9MKBOVL4GKgURmxlHU1xtcmFeY7qyXJwJyn3qf3IhuAL6EPpCRSRx/osM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlOaJCvh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlOaJCvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764948650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuvPXQP0cLwUjz9nWB7o0/2FOhvPYzNLfPhDrXBHCjw=;
	b=LlOaJCvhDUBYdhRFcidqM7L08CaOnLbaNXBnwIJhiVNjCLy2WVSs5xC42VIHnw7uMrkX6h
	B2SIPZxvPcfrotfCPIrbz7ldSbJmXuAPGZlvE/Pb81Sz7f6xDDJ9kEo5Ndi8Fzl1A5MNIO
	Cpo1HXjC4PaN+kpNmi41kc5qAJ23G2A=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-sQKZEYMlPFy-pVWoBNEnJw-1; Fri, 05 Dec 2025 10:30:49 -0500
X-MC-Unique: sQKZEYMlPFy-pVWoBNEnJw-1
X-Mimecast-MFC-AGG-ID: sQKZEYMlPFy-pVWoBNEnJw_1764948648
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-78c2e75f918so4304147b3.3
        for <virtualization@lists.linux.dev>; Fri, 05 Dec 2025 07:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764948648; x=1765553448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NuvPXQP0cLwUjz9nWB7o0/2FOhvPYzNLfPhDrXBHCjw=;
        b=tdqZGKRr2GJYPol0nAemSbwxUMNUKPDKHXDlVdTYnz72eYiOUU+yvAuZeWNVCZv+DI
         zmM8rV2oQBQMzSxL2+Dxpvvl/d2HOxmXFdkBiNEMcpf1l3KFcXer3dUXFQLctZ0NepJD
         FF1qIQvAFwKlHBpD6yCClm3NhxHic9JPFseOPYvC1lC/hUG0mWv6utJryNz3jZktNyjH
         f+nsq95djJy+zOosZhE7DO8dPuZnxu5jvqc57IPcMA6JFbovSaoOQnW+lzO/jolkt+j9
         wIAWtaRJN+9ioSRJSy+ghb8a5VXxlLwJH2jx2q+yMJV6/cJReaNVSuniLt2dJ9xSEi1J
         FH4A==
X-Forwarded-Encrypted: i=1; AJvYcCXpI0RB4uIawJlO4BY6x19s5mFoPj138j25DSbntAV+2vsU34U1bHa/gEDaBpsHt/2vQGnb/3o9ENUQuS8gpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoD6E4/mPm1L2YsSiy7P9le5vSkyDNrBY9S9D9KHLxFsJyKtHD
	QbySTZVQzmxiSxQGMc8rCOVD+Cwiq3IWsDLurwMSyNH1Ucr78P1TDm6NB1/f/dw9WySsGs3sPn9
	q/V7tkWh8gB2zYWtb6B0WC8q72PrQV1BASaI68SLQnAMbx7YvP09gseyZIUZTwmGHBkE3+H1EGA
	OFbpY4VY35d+Or27+EqiSQ6SR5beA9jmDJ/uHnUPufND8=
X-Gm-Gg: ASbGncvvRR9QygESsU2+LO0puPpa90jM5vFbn3lXUaa7ke9b9yuSk9rpd06xC2/yZpi
	Wwa0uw6JJU8TxNca2ixTa2MoE8p1IDPU82Ypo5gklFOZ/BYFbuw3TcwRvzZ0GkPyhAgsU0/p1Kh
	wYoueUQ8JJdjj4q/M3QFWwY1ryKh3Z4mqyxaA6Hy74i55b6/gWhMb35TiFbHhHWOb0PFg=
X-Received: by 2002:a05:690c:d8d:b0:786:5379:afa4 with SMTP id 00721157ae682-78c188c8670mr59379227b3.41.1764948647547;
        Fri, 05 Dec 2025 07:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUCvA/Ws74FSuoD54vnjQBk2jMQCnuRF5r8jH0H8nPYtF1XEIR+DSKzcV1GytFatvjuz07m4vOLiEZJvS28yM=
X-Received: by 2002:a05:690c:d8d:b0:786:5379:afa4 with SMTP id
 00721157ae682-78c188c8670mr59378497b3.41.1764948646461; Fri, 05 Dec 2025
 07:30:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251113115558.1277981-1-eperezma@redhat.com> <20251113115558.1277981-6-eperezma@redhat.com>
 <CACGkMEuwzmSmrh5PBhuokzt6Tf5b4+6JGmAuTAC-y-Sm04FZPA@mail.gmail.com>
 <CAJaqyWex0rE+KO-UE_qxqkG3RWWP4ntNy+9Nzvb+CZ+auR3mVw@mail.gmail.com>
 <CACGkMEtavEOcWKaHZGdHD5MH94dvL=f8qe-kUS==bPB66i=-yw@mail.gmail.com>
 <CAJaqyWdgGmnaQ3=j-6S9E4mfPSHc872FQZfVna_eX_UnipX2UA@mail.gmail.com>
 <CACGkMEuzAo2jRgUwkxhM=bgS4a4NvpP6BYZB1zed00C6J8eiyg@mail.gmail.com>
 <CAJaqyWeVCZOyBu2jPEc3iyP1uP=mzs2z7X=4JfYdBS6fLvPdxA@mail.gmail.com>
 <CACGkMEtMyte91bbdb0hfUo+YgSpZdjoWe0meKwbDc18CfWdATA@mail.gmail.com>
 <CAJaqyWfsuSobzdr522NvXHAZmczFvOB4vBUAfeOjfnz6GewP1A@mail.gmail.com>
 <CACGkMEsJXaOszR4UfY7+y=FfP8n-z3V1N+0QpDfePvs8=RY5Bg@mail.gmail.com>
 <CAJaqyWdQnv9E6dy8hma13SKwMJL16zKjT=8f9ns9MMy8-iovFw@mail.gmail.com> <CACGkMEvqgKASBEaw6HVj6+joaZuQzDFndO9UnYXLH2bAhZ5shQ@mail.gmail.com>
In-Reply-To: <CACGkMEvqgKASBEaw6HVj6+joaZuQzDFndO9UnYXLH2bAhZ5shQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Dec 2025 16:30:09 +0100
X-Gm-Features: AWmQ_bnjhtw2xxvJVBPU5tXob4rtIVo0PgvH1LnJyjcUT3xw2ZCveE-AId-swz0
Message-ID: <CAJaqyWeDjBfzrA93riYTmefY4oLbctWWBMPcpR5Q6r50dUGOEw@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DvlLXxHltjadYKb4SeV9ooPZMJZxpLtTgxTN3DfM630_1764948648
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 2:52=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Dec 4, 2025 at 4:33=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Thu, Dec 4, 2025 at 3:15=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Wed, Dec 3, 2025 at 3:58=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Thu, Nov 20, 2025 at 2:38=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> > > > >
> > > > > On Wed, Nov 19, 2025 at 5:27=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 19, 2025 at 3:39=E2=80=AFAM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > >
> > > > > > > On Mon, Nov 17, 2025 at 8:16=E2=80=AFPM Eugenio Perez Martin
> > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Nov 17, 2025 at 5:23=E2=80=AFAM Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Nov 14, 2025 at 7:25=E2=80=AFPM Eugenio Perez Mar=
tin
> > > > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Nov 14, 2025 at 1:55=E2=80=AFAM Jason Wang <jas=
owang@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Thu, Nov 13, 2025 at 7:56=E2=80=AFPM Eugenio P=C3=
=A9rez <eperezma@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Add support for assigning Address Space Identifiers=
 (ASIDs) to each VQ
> > > > > > > > > > > > group.  This enables mapping each group into a dist=
inct memory space.
> > > > > > > > > > > >
> > > > > > > > > > > > Now that the driver can change ASID in the middle o=
f operation, the
> > > > > > > > > > > > domain that each vq address point is also protected=
 by domain_lock.
> > > > > > > > > > >
> > > > > > > > > > > Maybe it's better to document what is protected by RC=
U and how.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I added the _rcu annotation but I can expand it for sur=
e. I can also
> > > > > > > > > > modify the commit message.
> > > > > > > > > >
> > > > > > > > > > > More below.
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > >
> > > > > > > > > > I forgot to remove this, my bad!
> > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.=
com>
> > > > > > > > > > > > ---
> > > > > > > > > > > > v9:
> > > > > > > > > > > > * Replace mutex with RCU, as the vdpa map_ops can r=
un from atomic
> > > > > > > > > > > >   context.
> > > > > > > > > > > >
> > > > > > > > > > > > v8:
> > > > > > > > > > > > * Revert the mutex to rwlock change, it needs prope=
r profiling to
> > > > > > > > > > > >   justify it.
> > > > > > > > > > > >
> > > > > > > > > > > > v7:
> > > > > > > > > > > > * Take write lock in the error path (Jason).
> > > > > > > > > > > >
> > > > > > > > > > > > v6:
> > > > > > > > > > > > * Make vdpa_dev_add use gotos for error handling (M=
ST).
> > > > > > > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VD=
USE_API_VERSION_1) ?/
> > > > > > > > > > > >   (MST).
> > > > > > > > > > > > * Fix struct name not matching in the doc.
> > > > > > > > > > > >
> > > > > > > > > > > > v5:
> > > > > > > > > > > > * Properly return errno if copy_to_user returns >0 =
in VDUSE_IOTLB_GET_FD
> > > > > > > > > > > >   ioctl (Jason).
> > > > > > > > > > > > * Properly set domain bounce size to divide equally=
 between nas (Jason).
> > > > > > > > > > > > * Exclude "padding" member from the only >V1 member=
s in
> > > > > > > > > > > >   vduse_dev_request.
> > > > > > > > > > > >
> > > > > > > > > > > > v4:
> > > > > > > > > > > > * Divide each domain bounce size between the device=
 bounce size (Jason).
> > > > > > > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > > > > > > * Change if (x && (y || z)) return to if (x) { if (=
y) return; if (z)
> > > > > > > > > > > >   return; } (Jason)
> > > > > > > > > > > > * Change a bad multiline comment, using @ caracter =
instead of * (Jason).
> > > > > > > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > > > > > > >
> > > > > > > > > > > > v3:
> > > > > > > > > > > > * Get the vduse domain through the vduse_as in the =
map functions
> > > > > > > > > > > >   (Jason).
> > > > > > > > > > > > * Squash with the patch creating the vduse_as struc=
t (Jason).
> > > > > > > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agai=
ns a magic number
> > > > > > > > > > > >   (Jason)
> > > > > > > > > > > >
> > > > > > > > > > > > v2:
> > > > > > > > > > > > * Convert the use of mutex to rwlock.
> > > > > > > > > > > >
> > > > > > > > > > > > RFC v3:
> > > > > > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). I=
t was set to a lower
> > > > > > > > > > > >   value to reduce memory consumption, but vqs are a=
lready limited to
> > > > > > > > > > > >   that value and userspace VDUSE is able to allocat=
e that many vqs.
> > > > > > > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioct=
l with
> > > > > > > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2=
.
> > > > > > > > > > > > * Move the umem mutex to asid struct so there is no=
 contention between
> > > > > > > > > > > >   ASIDs.
> > > > > > > > > > > >
> > > > > > > > > > > > RFC v2:
> > > > > > > > > > > > * Make iotlb entry the last one of vduse_iotlb_entr=
y_v2 so the first
> > > > > > > > > > > >   part of the struct is the same.
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 370 +++++++++=
+++++++++++---------
> > > > > > > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > > > > > > >  2 files changed, 314 insertions(+), 109 deletions(=
-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/d=
rivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > > > index 97be04f73fbf..ff95ed56f22d 100644
> > > > > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > > > @@ -11,6 +11,7 @@
> > > > > > > > > > > >  #include "linux/virtio_net.h"
> > > > > > > > > > > >  #include <linux/init.h>
> > > > > > > > > > > >  #include <linux/module.h>
> > > > > > > > > > > > +#include <linux/rcupdate.h>
> > > > > > > > > > > >  #include <linux/cdev.h>
> > > > > > > > > > > >  #include <linux/device.h>
> > > > > > > > > > > >  #include <linux/eventfd.h>
> > > > > > > > > > > > @@ -41,6 +42,7 @@
> > > > > > > > > > > >
> > > > > > > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > > > > > > @@ -86,7 +88,14 @@ struct vduse_umem {
> > > > > > > > > > > >         struct mm_struct *mm;
> > > > > > > > > > > >  };
> > > > > > > > > > > >
> > > > > > > > > > > > +struct vduse_as {
> > > > > > > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > > > > > > +       struct vduse_umem *umem;
> > > > > > > > > > > > +       struct mutex mem_lock;
> > > > > > > > > > > > +};
> > > > > > > > > > > > +
> > > > > > > > > > > >  struct vduse_vq_group {
> > > > > > > > > > > > +       struct vduse_as *as __rcu;
> > > > > > > > > > > >         struct vduse_dev *dev;
> > > > > > > > > > > >  };
> > > > > > > > > > > >
> > > > > > > > > > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > > > > > > > > > >         struct vduse_vdpa *vdev;
> > > > > > > > > > > >         struct device *dev;
> > > > > > > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > > > > > > +       struct vduse_as *as;
> > > > > > > > > > > >         char *name;
> > > > > > > > > > > >         struct mutex lock;
> > > > > > > > > > > >         spinlock_t msg_lock;
> > > > > > > > > > > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > > > > > > > > > > >         u32 vq_num;
> > > > > > > > > > > >         u32 vq_align;
> > > > > > > > > > > >         u32 ngroups;
> > > > > > > > > > > > -       struct vduse_umem *umem;
> > > > > > > > > > > > +       u32 nas;
> > > > > > > > > > > >         struct vduse_vq_group *groups;
> > > > > > > > > > > > -       struct mutex mem_lock;
> > > > > > > > > > > >         unsigned int bounce_size;
> > > > > > > > > > > >         struct mutex domain_lock;
> > > > > > > > > > > >  };
> > > > > > > > > > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_status=
(struct vduse_dev *dev, u8 status)
> > > > > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev=
 *dev,
> > > > > > > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev=
 *dev, u32 asid,
> > > > > > > > > > > >                                   u64 start, u64 la=
st)
> > > > > > > > > > > >  {
> > > > > > > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_io=
tlb(struct vduse_dev *dev,
> > > > > > > > > > > >                 return -EINVAL;
> > > > > > > > > > > >
> > > > > > > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1)=
 {
> > > > > > > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > > > > > > +       } else {
> > > > > > > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > > > > > > +       }
> > > > > > > > > > > >
> > > > > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > > >  }
> > > > > > > > > > > > @@ -436,14 +450,32 @@ static __poll_t vduse_dev_pol=
l(struct file *file, poll_table *wait)
> > > > > > > > > > > >         return mask;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > +/* Force set the asid to a vq group without a mess=
age to the VDUSE device */
> > > > > > > > > > > > +static void vduse_set_group_asid_nomsg(struct vdus=
e_dev *dev,
> > > > > > > > > > > > +                                      unsigned int=
 group, unsigned int asid)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +       /*
> > > > > > > > > > > > +        * Two concurrent updates to this pointer a=
re valid as they cannot
> > > > > > > > > > > > +        * point to an invalid region.  It is ok fo=
r them to race as long as
> > > > > > > > > > > > +        * the readers see a consistent state throu=
gh RCU.
> > > > > > > > > > > > +        */
> > > > > > > > > > > > +       rcu_assign_pointer(dev->groups[group].as, &=
dev->as[asid]);
> > > > > > > > > > >
> > > > > > > > > > > I'd expect at least a synchronize_rcu() here to wait =
for the read is done?
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > What's the use? The only thing left here is to return f=
rom
> > > > > > > > > > vduse_set_group_asid_nomsg, and we don't need to wait f=
or readers
> > > > > > > > > > here, do we?
> > > > > > > > >
> > > > > > > > > See below.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > > > > > > >  {
> > > > > > > > > > > >         int i;
> > > > > > > > > > > > -       struct vduse_iova_domain *domain =3D dev->d=
omain;
> > > > > > > > > > > >
> > > > > > > > > > > >         /* The coherent mappings are handled in vdu=
se_dev_free_coherent() */
> > > > > > > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > > > > > > -               vduse_domain_reset_bounce_map(domai=
n);
> > > > > > > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > > > > > > +               struct vduse_iova_domain *domain =
=3D dev->as[i].domain;
> > > > > > > > > > > > +
> > > > > > > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > > > > > > +                       vduse_domain_reset_bounce_m=
ap(domain);
> > > > > > > > > > > > +       }
> > > > > > > > > > > > +
> > > > > > > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > > > > > > +               vduse_set_group_asid_nomsg(dev, i, =
0);
> > > > > > > > > > > >
> > > > > > > > > > > >         down_write(&dev->rwsem);
> > > > > > > > > > > >
> > > > > > > > > > > > @@ -623,6 +655,29 @@ static union virtio_map vduse_=
get_vq_map(struct vdpa_device *vdpa, u16 idx)
> > > > > > > > > > > >         return ret;
> > > > > > > > > > > >  }
> > > > > > > > > > > >
> > > > > > > > > > > > +static int vduse_set_group_asid(struct vdpa_device=
 *vdpa, unsigned int group,
> > > > > > > > > > > > +                               unsigned int asid)
> > > > > > > > > > > > +{
> > > > > > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdp=
a);
> > > > > > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > > > +       int r;
> > > > > > > > > > > > +
> > > > > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 =
||
> > > > > > > > > > > > +           group >=3D dev->ngroups || asid >=3D de=
v->nas)
> > > > > > > > > > > > +               return -EINVAL;
> > > > > > > > > > > > +
> > > > > > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > > > > > > +
> > > > > > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > > > +       if (r < 0)
> > > > > > > > > > > > +               return r;
> > > > > > > > > > > > +
> > > > > > > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid=
);
> > > > > > > > > > > > +       return 0;
> > > > > > > > > > > > +}
> > > > > > > > > > > > +
> > > > > > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_dev=
ice *vdpa, u16 idx,
> > > > > > > > > > > >                                 struct vdpa_vq_stat=
e *state)
> > > > > > > > > > > >  {
> > > > > > > > > > > > @@ -794,13 +849,13 @@ static int vduse_vdpa_set_map=
(struct vdpa_device *vdpa,
> > > > > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdp=
a);
> > > > > > > > > > > >         int ret;
> > > > > > > > > > > >
> > > > > > > > > > > > -       ret =3D vduse_domain_set_map(dev->domain, i=
otlb);
> > > > > > > > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].=
domain, iotlb);
> > > > > > > > > > > >         if (ret)
> > > > > > > > > > > >                 return ret;
> > > > > > > > > > > >
> > > > > > > > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, U=
LLONG_MAX);
> > > > > > > > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0=
ULL, ULLONG_MAX);
> > > > > > > > > > > >         if (ret) {
> > > > > > > > > > > > -               vduse_domain_clear_map(dev->domain,=
 iotlb);
> > > > > > > > > > > > +               vduse_domain_clear_map(dev->as[asid=
].domain, iotlb);
> > > > > > > > > > > >                 return ret;
> > > > > > > > > > > >         }
> > > > > > > > > > > >
> > > > > > > > > > > > @@ -843,6 +898,7 @@ static const struct vdpa_config=
_ops vduse_vdpa_config_ops =3D {
> > > > > > > > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_=
vq_affinity,
> > > > > > > > > > > >         .reset                  =3D vduse_vdpa_rese=
t,
> > > > > > > > > > > >         .set_map                =3D vduse_vdpa_set_=
map,
> > > > > > > > > > > > +       .set_group_asid         =3D vduse_set_group=
_asid,
> > > > > > > > > > > >         .get_vq_map             =3D vduse_get_vq_ma=
p,
> > > > > > > > > > > >         .free                   =3D vduse_vdpa_free=
,
> > > > > > > > > > > >  };
> > > > > > > > > > > > @@ -852,14 +908,17 @@ static void vduse_dev_sync_si=
ngle_for_device(union virtio_map token,
> > > > > > > > > > > >                                              enum d=
ma_data_direction dir)
> > > > > > > > > > > >  {
> > > > > > > > > > > >         struct vduse_dev *vdev;
> > > > > > > > > > > > +       struct vduse_as *as;
> > > > > > > > > > > >         struct vduse_iova_domain *domain;
> > > > > > > > > > > >
> > > > > > > > > > > >         if (!token.group)
> > > > > > > > > > > >                 return;
> > > > > > > > > > > >
> > > > > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > > > > -
> > > > > > > > > > > > +       rcu_read_lock();
> > > > > > > > > > > > +       as =3D rcu_dereference(token.group->as);
> > > > > > > > > > > > +       domain =3D as->domain;
> > > > > > > > > > > > +       rcu_read_unlock();
> > > > > > > > > > > >         vduse_domain_sync_single_for_device(domain,=
 dma_addr, size, dir);
> > > > > > > > > > >
> > > > > > > > > > > This is suspicious, at least we should do rcu_read_un=
lock() after
> > > > > > > > > > > vduse_domain_sync_single_for_device(), otherwise I do=
n't see how RCU
> > > > > > > > > > > works.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > RCU is protecting that the address space pointer of the=
 vq group is
> > > > > > > > > > not modified concurrently with the access. Ideally, thi=
s should be a
> > > > > > > > > > full lock, but just making sure that all accesses from =
the reader are
> > > > > > > > > > coherent is enough. Userspace should expect nothing if =
it uses the map
> > > > > > > > > > and modifies the vq group ASID at the same time anyway,=
 but the kernel
> > > > > > > > > > needs to be sure that it does not see intermediate stat=
es. TBH, we
> > > > > > > > > > could move to a READ_ONCE / WRITE_ONCE, would that be m=
ore clear?
> > > > > > > > >
> > > > > > > > > Using READ_ONCE/WRITE_ONCE() needs to make sure the order=
ing is
> > > > > > > > > handled correctly.
> > > > > > > > >
> > > > > > > > > But I meant what happens if
> > > > > > > > >
> > > > > > > > > [cpu0]rcu_read_lock()
> > > > > > > > > [cpu0]as =3D rcu_dereference(token.group->as)
> > > > > > > > > [cpu0]...
> > > > > > > > > [cpu0]rcu_read_unlock()
> > > > > > > > > [cpu1]rcu_assign_pointer(token.group->as)
> > > > > > > > > [cpu0]vduse_domain_sync_single_for_device()
> > > > > > > > >
> > > > > > > >
> > > > > > > > That should go ok. What I'm trying to protect here is the i=
terations
> > > > > > > > in vduse_domain_sync_single_for_device -> vduse_domain_boun=
ce.
> > > > > > > >
> > > > > > > > I'm going to embed that function here in
> > > > > > > > vduse_dev_sync_single_for_device and omit RCU and some deta=
ils to make
> > > > > > > > the point easier:
> > > > > > > >
> > > > > > > > vduse_dev_sync_single_for_device(union virtio_map token, dm=
a_addr_t
> > > > > > > > iova, size_t size, ...) {
> > > > > > > >   read_lock(&token.group->as->domain);
> > > > > > > >   while (size)
> > > > > > > >     map =3D token.group->as->domain->bounce_maps[iova];
> > > > > > > >     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
> > > > > > > >
> > > > > > > >     ...
> > > > > > > >     page =3D token_group->as->domain->bounce_maps
> > > > > > > >     addr =3D kmap_local_page(page);
> > > > > > > >     do_bounce(map->orig_phys, addr, sz, dir);
> > > > > > > >     kunmap_local(addr);
> > > > > > > >     size -=3D sz;
> > > > > > > >     iova +=3D sz;
> > > > > > > >   }
> > > > > > > >   read_unlock(&token.group->as->domain);
> > > > > > > > }
> > > > > > >
> > > > > > > Right, so I meant for rwlock like semantic (let's forget the =
sleeping here).
> > > > > > >
> > > > > > > vduse_set_group_asid_nomsg() should use "write lock" so it mu=
st wait
> > > > > > > for the "read lock" to be done.
> > > > > >
> > > > > > No, it doesn't need to wait as long as the reader part uses its=
 own copy.
> > > > >
> > > > > It probably won't crash but I meant if we have logic issues. For
> > > > > example, once set_group_asid() return, there should still be a pe=
nding
> > > > > DMA that is using the old as.
> > > > >
> > > > > >
> > > > > > > But this is not the logic that is
> > > > > > > implemented in this patch as there's no synchronize_rcu() in =
the
> > > > > > > vduse_set_group_asid_nomsg().
> > > > > >
> > > > > > We only set the pointer on the writer's side, we do nothing lik=
e
> > > > > > freeing resources. Should we set the pointer before or after
> > > > > > syncrhonize_rcu()? What do we need to do on the other side of
> > > > > > syncrhonize_rcu()?
> > > > >
> > > > > Usually we don't need special care on the read side. But as discu=
ssed,
> > > > > synchronize_rcu() is not a must but we need to explain why it is =
safe
> > > > > and I'm not sure Michael is fine with that.
> > > > > If we just want to make sure the order of publish and read, we ca=
n
> > > > > switch to use smp_store_release() and smp_load_acqurie().
> > > > >
> > > > > >
> > > > > > > We need to explain why set_group_asid()
> > > > > > > doesn't need to wait and if this is true, we probably don't n=
eed RCU
> > > > > > > but to make sure the load/store is atomic.
> > > > > > >
> > > > > >
> > > > > > What about:
> > > > > >
> > > > > > * It does not matter if other thread modify group->as as long a=
s the
> > > > > > reader uses the same as for all its operation. It performs a lo=
cal
> > > > > > copy for that reason.
> > > > > > * It does not matter if multiple threads modify group->as as lo=
ng as
> > > > > > the update is atomic.
> > > > >
> > > > > See above reply.
> > > > >
> > > > > >
> > > > > > ?
> > > > > >
> > > > > > > >
> > > > > > > > Now, depending on the point where another execution thread =
changes
> > > > > > > > token_group->as and how the compiler has chosen to generate=
 the
> > > > > > > > machine code, the outcome could be:
> > > > > > > > 1) The domain read lock of one ASID is taken but the domain=
 lock of
> > > > > > > > another as is unlocked.
> > > > > > > > 2) We iterate until iova is ok for the ASID we're handling,=
 but not
> > > > > > > > for the other one. So we access an invalid offset in
> > > > > > > > bounce_maps[iova].
> > > > > > > >
> > > > > > > > And I guess there are other possible outcomes too.
> > > > > > > >
> > > > > > > > So I need to make sure that the pointer accesses in all
> > > > > > > > vduse_domain_bounce is coherent.
> > > > > > >
> > > > > > > I'm not sure I got here, but it looks like it accepts a domai=
n
> > > > > > > parameter and is protected by the bounce lock so we are proba=
bly fine
> > > > > > > here?
> > > > > > >
> > > > > >
> > > > > > The bounce lock only protects the iotlb tree, not the pointer t=
o that
> > > > > > iotlb tree.
> > > > > >
> > > > > > > > I'm ok if it takes the one before the
> > > > > > > > concurrent call to vduse_set_group_asid_nomsg or the one af=
ter that,
> > > > > > > > as the lifetime of all domains are bound to the device. But=
 it cannot
> > > > > > > > change in the middle of the operation:
> > > > > > > >
> > > > > > > > vduse_dev_sync_single_for_device(union virtio_map token, dm=
a_addr_t
> > > > > > > > iova, size_t size, ...) {
> > > > > > > >   as =3D token.group->as;
> > > > > > > >   // Tell the compiler to never replace "as" by "token.grou=
p->as" after this.
> > > > > > > >   read_lock(&as->domain);
> > > > > > > >   while (size)
> > > > > > > >     map =3D as->domain->bounce_maps[iova];
> > > > > > > >     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
> > > > > > > >
> > > > > > > >     ...
> > > > > > > >     page =3D as->domain->bounce_maps
> > > > > > > >     addr =3D kmap_local_page(page);
> > > > > > > >     do_bounce(map->orig_phys, addr, sz, dir);
> > > > > > > >     kunmap_local(addr);
> > > > > > > >     size -=3D sz;
> > > > > > > >     iova +=3D sz;
> > > > > > > >   }
> > > > > > > >   read_unlock(&as->domain);
> > > > > > > > }
> > > > > > > >
> > > > > > > > That can be done in many ways. Probably the read_lock is al=
ready
> > > > > > > > enough but it is not explicit that it is protecting token.g=
roup->as,
> > > > > > > > and future changes could remove it. To me, RCU is the most =
clear way
> > > > > > > > to do it, but even a volatile read (READ_ONCE?) would do.
> > > > > > >
> > > > > > > I wonder if another group rwlock is sufficient here:
> > > > > > >
> > > > > > > for set_group_as_id()
> > > > > > >
> > > > > > > write_lock(&dev->groups[group].lock);
> > > > > > > dev->groups[group].as =3D &dev->as[asid];
> > > > > > > write_unlock(&dev->groups[group].lock);
> > > > > > >
> > > > > > > for the case where we need defer as
> > > > > > >
> > > > > > > read_lock(&dev->groups[group].lock);
> > > > > > > as =3D dev->groups[group].as;
> > > > > > > //using as
> > > > > > > read_unlock(&dev->groups[group].lock);
> > > > > > >
> > > > > > > If this works, we don't need to bother with thinking if the
> > > > > > > wait/synchronizre_rcu() is really needed or not?
> > > > > > >
> > > > > >
> > > > > > A rwlock is sufficient but we need to modify the allocation cod=
e
> > > > > > somehow. Also, I thought we wanted to avoid the overhead of tak=
ing the
> > > > > > read lock in the DMA ops too.
> > > > >
> > > > > Right, but it would always be a balance. We can make sure it work=
s
> > > > > correctly first then do optimization on top.
> > > > >
> > > > > >
> > > > > > Another disadvantage of the lock vs RCU or READ_ONCE is that th=
e vq
> > > > > > group ASID change needs to wait for the DMA operation to finish
> > > > > > instead of just applying for the next DMA ops. Not like vq grou=
p ASID
> > > > > > change would be in the hot path anyway, just pointing it out.
> > > > > >
> > > > > > > >
> > > > > > > > > If this is not an issue, RCU is not a must, but please ex=
plain why.
> > > > > > > > > If this is an issue, we need to fix it.
> > > > > > > > >
> > > > > > > > > It's basically a question that
> > > > > > > > >
> > > > > > > > > 1) should we need to wait for the DMA to be completed bef=
ore assigning
> > > > > > > > > to the new as
> > > > > > > >
> > > > > > > > I don't think so, it is valid to assign a new as and let th=
e ongoing
> > > > > > > > operation to continue. It is racy and the operation could f=
ail, but
> > > > > > > > the kernel just returns an error and doesn't access invalid=
 memory or
> > > > > > > > similar.
> > > > > > >
> > > > > > > See below.
> > > > > > >
> > > > > > > >
> > > > > > > > > 2) should we track the set_group_asid() for the group tha=
t has pending
> > > > > > > > > DMA to avoid potential issue
> > > > > > > > >
> > > > > > > >
> > > > > > > > No, the group will outlive the operation as it is bound to =
the device.
> > > > > > >
> > > > > > > I meant e.g the DMA could be triggered by the device. For exa=
mple, the
> > > > > > > device may try to trigger an interrupt when the kernel is try=
ing to
> > > > > > > assign a new asid. So I wonder if guest can use this to poke =
Qemu's
> > > > > > > memory etc.
> > > > > >
> > > > > > I'm not sure I get this point. If QEMU changes the ASID of the =
vq
> > > > > > group sent to the guest the race does not matter anymore: it is
> > > > > > explicitly opening the possibility from the guest to poke QEMU'=
s
> > > > > > memory unless the guest is totally paused.
> > > > >
> > > > > Basically what I meant, assuming group0.as =3D as0
> > > > >
> > > > > cpu0] dma_map(group0.as, addr, DMA_FROM_DEVICE)
> > > > > cpu1] set_group_asid(group0.as, as1)
> > > > > cpu0] dma_unmap(group0.as, addr, DMA_FROM_DEVICE)

[1]

> > > > >
> > > > > cpu0 may read as1 while it wants as0 actually?
> > > > >
> > > >
> > > > Yes, kind of. That's my point: adding synchronization at vduse leve=
l
> > > > does not fix it.
> > > >
> > > > There is no way to do that call from vhost/vdpa or userland, as the=
re
> > > > is no way to get the AS of a vq group, only to set it. The closest
> > > > thing is to add a cache at that level, but that implies to add
> > > > mutithreading sync on that upper layer, either vhost/vdpa or userla=
nd,
> > > > not in VDUSE.

[2]

> > >
> > > Probably.
> > >
> > > >
> > > > From vhost/vdpa level, all mapping calls (.set_map, .dma_map,
> > > > .dma_unmap) calls take the ASID directly, not the vq group. So the
> > > > call to set_group_asid does not need to access the vq group.
> > > >

[3]

> > > > Now let's say that we add that vdpa_ops callback (and ioctls) that
> > > > maps and unmap based on a vq_group. And all of the operations
> > > > (dma_map, set_group_asid, and dma_unmap) are serialized by taking t=
he
> > > > same mutex. cpu0 still may dma_unmap over as0 if set_group_asid is =
not
> > > > properly serialized at vhost/vdpa or userland level:
> > > >
> > > > void* thread0_func(void* arg) {
> > > > struct {
> > > >         int vq_group =3D 0,
> > > >         int iova, size, perm, ...
> > > >     } s;
> > > >     int fd =3D (intptr_t)arg;
> > > >
> > > >     ioctl(fd, VHOST_VDPA_VQ_GROUP_DMA_MAP, &s);
>
> I don't get the semantic of VHOST_VDPA_VQ_GROUP_DMA_MAP. And it's
> probably wrong to allow userspace to map based on group.
>
> We have VHOST_IOTLB_UPDATE which map pages based on as (asid) this is cor=
rect.
>

Yes, I said that at [2], in reply to your scenario at [1] :). Did I
misunderstand?

> More below
>
> > > >     // TODO: Signal thread0 that it can proceed with SET_GROUP_ASID
> > > >     // TODO: Wait until thread0 complete SET_GROUP_ASID
> > > >
> > > >     ioctl(fd, VHOST_VDPA_VQ_GROUP_DMA_UNMAP, &data);
> > > >
> > > >     return NULL;
> > > > }
> > > >
> > > > void* thread1_func(void* arg) {
> > > >     struct vhost_vring_state s =3D {
> > > >         .index =3D 0,
> > > >         .num =3D 1,
> > > >     };
> > > >     int fd =3D (int)(intptr_t)arg;
> > > >
> > > >     // TODO: Wait until thread2 calls dma_map
> > >
> > > This is something exactly rwlock or synchronize_rcu() can do? Or is
> > > this the charge of the vDPA parent to do that?
> > >
> >
> > No, that's an userland synchronization problem that cannot be solved
> > at kernel level. If we need to do something similar at vdpa core level
> > (unlikely), we will need to synchronize at that level too.
>
> Ok, basically I think we are talking about different things. That's fine.
>
> If I understand you correctly, you mean we need to synchronize between
> IOTLB updating (IOTLB_UPDATE/IOTLB_INVALIDATE) and set_group_asid()?
>
> This sounds unnecessary since:
>
> 1) IOTLB_UPDATE/IOTLB_INVALIDATE is updating the address space internal m=
appings
> 2) set_group_asid() is to assign an AS to a group
>

Right, we're on the same page here [3].

> >
> > If we add an rwlock but don't implement the synchronization in the
> > userland program marked as TODO, this sequence is also possible:
> >
> > cpu0] DMA map ioctl call in userland
> > -> Take read_lock in the vduse module
> > -> Update the IOTLB tree of ASID 0
> > -> unlock read_lock
> >
> > Now we have two possibilities: either cpu0] DMA_UNMAP is called or
> > cpu1] set_group_asid is called. The VDUSE module rwlock protects that
> > they will not run at the same time, but we need to implement something
> > at the userland level if we want a predictive outcome, marked as the
> > TODO in the comments. If, by chance, the DMA unmap is the one that
> > comes next, the AS updated is the 0:
> >
> > cpu0] DMA unmap ioctl call in userland
> > -> Take read_lock in the vduse module
> > -> Update the IOTLB tree of ASID 0
> > -> unlock read_lock
> > cpu1] set_group_asid ioctl call in userland
> > -> Take write_lock in the vduse module
> > -> Update ASID of the VQ GROUP 0 to 1
> > -> unlock write_lock
> >
> > If set_group_asid run first by chance, ASID 1 is the one that is update=
d:
> > cpu1] set_group_asid ioctl call in userland
> > -> Take write_lock in the vduse module
> > -> Update ASID of the VQ GROUP 0 to 1
> > -> unlock write_lock
> > cpu0] DMA unmap ioctl call in userland
> > -> Take read_lock in the vduse module
> > -> Update the IOTLB tree of ASID 0
> > -> unlock read_lock
> >
> > On the other hand we have this version of the series that allows these
> > actions to run at the same time. It just makes sure that the update of
> > the IOTLB tree is coherent, by copying the vq group ASID value at one
> > point in time and making sure it sticks to that ASID until the end of
> > the set_map call. I'm not adding the synchronize_rcu call because we
> > stated it should not be called from userland, but the outcome is
> > similar.
>
> I think we should figure out if VHOST_VDPA_VQ_GROUP_DMA_MAP is useful or =
not.
>

It's not. I just wanted to expand how I understood your scenario, but
let me know if I missed something!

> >
> > Let me put another example: It's like calling fdup() and write() from
> > different threads over the same set of fds without userland
> > synchronization to me. The kernel protects things like not write part
> > of the content in one file and another part on the other file, but the
> > content of the files at the end of the writes() is just not
> > predictable. And the kernel just cannot make it predictable.
> >
> > static int fd_a;
> > static int fd_b;
> >
> > void *write_thread(void *arg) {
> >     const char *msg =3D "Writing to fd_b\n";
> >     write(fd_b, msg, strlen(msg));
> >     return NULL;
> > }
> >
> > void *dup_thread(void *arg) {
> >     dup2(fd_a, fd_b);
> >     return NULL;
> > }
> >
> > int main() {
> >     pthread_t writer, duper;
> >
> >     fd_a =3D open("/tmp/a", O_WRONLY | O_CREAT | O_TRUNC, 0644);
> >     fd_b =3D open("/tmp/b", O_WRONLY | O_CREAT | O_TRUNC, 0644);
> >
> >     pthread_create(&writer, NULL, write_thread, NULL);
> >     pthread_create(&duper, NULL, dup_thread, NULL);
> >
> >     pthread_join(writer, NULL);
> >     pthread_join(duper, NULL);
> >
> >     close(fd_a);
> >     close(fd_b);
> >
> >     return 0;
> > }
> > --
> >
> > > If it's the responsibility of the parent, it would be much harder for
> > > VDUSE as the datapath is implemented in usersapce via mmap() or
> > > umem_reg.
> > >
> > > Looking at existing implementation:
> > >
> > > - for mlx5e, it looks like it assumes the set_group_asid() works only
> > > without DRIVER_OK.
> > > - for the simulator, it looks like it can synchronize with the
> > > datapath with the spinlock as datapath is emulated
> > >
> >
> > Yes, the next version will use the rwlock spinlock. I just need to
> > take out the allocation of the domain for it to be valid.
> >
> > > >     ioctl(fd, VHOST_VDPA_SET_GROUP_ASID, &s)
> > > >     // TODO: Signal thread2 that can proceed with dma_unmap
> > >
> > > But the issue I mention is that the, from the view of the vDPA bus:
> > >
> > > 1) it offers set_group_as_id()
> > > 2) it doesn't know if virtio-vdpa or vhost-vdpa is used
> > >
> > > So theoretically, set_group_as_id() could happen between
> > >
> > > dma_addr =3D dma_map();
> > >
> > > and
> > >
> > > dma_unmap(dma_adrr);
> > >
> > > But those two dma_addr refers to the different address space.
> >
> > I don't get this, these calls take the ASID as the parameter, not the
> > vq group. I thought this was by design, as telling what vq groups
> > update seems way more difficult to me. Can you put an example of an
> > userland application that has the race you describe with the existing
> > ioctls?
>
> Just to clarify, I for dma_map()/dma_unmap() this is not the UAPI part
> (and we don't have that). I basically mean the dma API which is used
> by virtio-vDPA.
>

So let's say that the virtio_vdpa driver is able to call
.set_group_asid just to explain how much it is protected:

->vduse_dev_map_page and ->vduse_dev_unmap_page
In this series, rcu_dereference makes sure that only the stack copy of
the domain pointer is used, but the next version the code will have a
read_lock taken protecting that set_group_asid actions on
token.group->as cannot run at the same time that the
vduse_domain_map_page(...) or vduse_domain_unmap_page(...) function
call run in cpu0:

static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page *p=
age,
                                     unsigned long offset, size_t size,
                                     enum dma_data_direction dir,
                                     unsigned long attrs)
{
        struct vduse_iova_domain *domain;
        dma_addr_t r;

        if (!token.group)
                return DMA_MAPPING_ERROR;

        read_lock(&dev->groups[group].as_lock);
        domain =3D token.group->as->domain;
        r =3D vduse_domain_map_page(domain, page, offset, size, dir, attrs)=
;
        read_unlock(&dev->groups[group].as_lock);

        return r;
}

static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_add=
r,
                                 size_t size, enum dma_data_direction dir,
                                 unsigned long attrs)
{
        struct vduse_iova_domain *domain;

        if (!token.group)
                return;

        read_lock(&dev->groups[group].as_lock);
        domain =3D token.group->as->domain;
        vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
        read_unlock(&dev->groups[group].as_lock);
}
---

-> vduse_set_group_asid will have the corresponding write_lock, so it
cannot modify any vq group AS pointer while they're mapping or
unmapping pages from a domain:
static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
                                       unsigned int group, unsigned int asi=
d)
{
        write_lock(&dev->groups[group].as_lock);
        dev->groups[group].as =3D &dev->as[asid];
        write_unlock(&dev->groups[group].as_lock);
}
---

Now your question:

assuming group0.as =3D as0

cpu0] dma_map(group0.as, addr, DMA_FROM_DEVICE)
cpu1] set_group_asid(group0.as, as1)
cpu0] dma_unmap(group0.as, addr, DMA_FROM_DEVICE)

cpu0 may read as1 while it wants as0 actually?
--

Yes, it can happen even with the rwlock or any other synchronization
in VDUSE, as it does not order the vdpa core calls.

This is the code I have in mind to prove this, let me know if I'm
missing something from your scenario:

static int thread1_func(void *data)
{
    vduse_dev_map_page(token, ...);
    printk(KERN_INFO "map_page called\n");

    // TODO: Need a way to know if the group ASID has changed to
    // know if this unmap is valid or not.
    vduse_dev_unmap_page(token, ...);
    printk(KERN_INFO "unmap_page called\n");

    return 0;
}

static int thread2_func(void *data)
{
    u32 vq_group =3D 0;
    u32 asid =3D 1;

    vdpa->ops->set_group_asid(global_vdpa, vq_group, asid);
    printk(KERN_INFO "set_group_asid called\n");

    return 0;
}

static int __init kernel_threads_init(void)
{
    struct task_struct *thread1, *thread2;

    thread1 =3D kthread_run(thread1_func, NULL, "vdpa_map_unmap");
    thread2 =3D kthread_run(thread2_func, NULL, "vdpa_set_asid");

    return 0;
}

---

I keep thinking that this is a race condition in the hypothetical vdpa
core or the module that runs this code, not solvable in VDUSE. We need
to add barriers at this level, not VDUSE.

But I think it is a good idea to add some code in VDUSE to mitigate
it. Maybe just adding the expected vq queue index to
vdev->map->map_page and vdev->map->unmap_page? This way we can issue
an error if the race happens.

> >
> > > Instead
> > > of trying to do synchronization, maybe we can simply fail
> > > set_group_asid if DRIVER_OK is set.
> > >
> >
> > That's a good possibility, especially since mlx5 already does it.
> > There is ongoing work to enable dataplane SVQ dynamically without
> > needing to reset the whole device, but we will need a new feature flag
> > to know if the parent driver supports it.
>
> Did you mean the SVQ may update the group asid while DRIVER_OK is set?
> If yes, we need to fix that.
>

Not at this moment.

> >
> > > >
> > > >     return NULL;
> > > > }
> > > >
> > > > int main() {
> > > >     pthread_t thread0, thread1;
> > > >     int fd =3D open("/dev/vhost-vdpa-0", ...)
> > > >
> > > >     pthread_create(&thread0, NULL, thread0_func, (void *)(intptr_t)=
fd);
> > > >     pthread_create(&thread1, NULL, thread1_func, (void *)(intptr_t)=
fd);
> > > >
> > > >     pthread_join(thread1, NULL);
> > > >     pthread_join(thread2, NULL);
> > > >
> > > >     return EXIT_SUCCESS;
> > > > }
> > > > ---
> > > >
> > > > We need something to synchronize at userland level here, filling th=
e TODOs.
> > > >
> > > > We can replace the hypothetical VHOST_VDPA_VQ_GROUP_DMA_MAP and _UN=
MAP
> > > > with access to vqs, and the result is the same: The userland
> > > > application is the one that needs to serialize the access from thre=
ad0
> > > > if it wants predictive outcome against the accesses from thread1.
> > > > There is no way to do it at vduse level.
> > > >
> > > > We need some syncrhonization to avoid malicious or buggy userland t=
o
> > > > mess things, that's for sure. So DMA_MAP and DMA_UNMAP does not hal=
f
> > > > update the iotlb tree. And I'll send the next version with rwlock,
> > > > protecting as much as possible. But I want to make clear that it wi=
ll
> > > > not avoid the race you describe here.
> > >
> > > See above.
> > >
> > > >
> > > > > >
> > > > > > > But if you mean we depend on the IOTLB to guard against
> > > > > > > this, I'm fine, but let's document why we don't need it and h=
ow the
> > > > > > > IOTLB layer can help to eliminate such risk.
> > > > > > >
> > > > > >
> > > > > > No, I'm not happy about letting iotlb lock to protect this too =
as
> > > > > > they're at different levels actually: One is protecting iotlb t=
rees
> > > > > > modifications while they're being read and the other is protect=
ing the
> > > > > > ASID assignment to different vq groups. To reuse them means a
> > > > > > modification in any tree blocks the change of vq group ASID, fo=
r
> > > > > > example.
> > > > > >
> > > > > > > Anyhow, tracking and failing seems to be more robust.
> > > > > >
> > > > > > I'm not sure I get this. If a DMA read starts in one ASID and t=
hen
> > > > > > QEMU changes the ASID of the vq group, do you prefer it to fail=
 rather
> > > > > > than continue reading from the original ASID?
> > > > >
> > > > > If possible, it would be better.
> > > > >
> > > >
> > > > It's hard for me to think in some way that does not add a lot of
> > > > overhead or it is very complex. But it is good to know this is
> > > > acceptable.
> > > >
> > > > > > It seems hard to
> > > > > > communicate that the ASID has changed to the DMA operation call=
back.
> > > > >
> > > > > Maybe we can encode this into iova.
> > > > >
> > > >
> > > > I'm adding the full rwlock, but can you expand on your idea on this=
?
> > >
> > > Encode the asid to the upper bits of IOVA, so when doing dma_unmap()
> > > we can compare the group/as with the one that is encoded in dma_addr.
> > > If it differs, warn or bug.
> > >
> >
> > But the ASID is already a parameter in the dma_unmap. I thought you
> > meant to encode in the device's memory read.
>
> To avoid unmap a address that is not belong to the this ASID.
>
> >
> > > If we can make sure there's no set_group_asid() when DRIVER_OK is set=
,
> > > it's not a must then (or could be treated as a kind of hardening).
> > >
> > > > It would be great to have it documented in case we need future
> > > > optimizations.
> > > >
> > >
> > > Thanks
> > >
>
> Thanks
>

