Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789227465C
	for <virtualization@lists.linux.dev>; Mon,  8 Dec 2025 02:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765162722; cv=none; b=W+nDlVrMCmsdsh+flFTAFK/r2DVng6tyK2omBQgxdGcx8nWRt8ACnAQM6lgTpe5TNNpiThI6+GU3qXf6bxbImPj+J8M79824S93JwGC/22aClCgatI8HjntuaA/syXZ31U4kfypA2Q/Vq960SBNYhgu3BrLtnNSGHzku3KEJwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765162722; c=relaxed/simple;
	bh=lDj6edZ+/kw4VwDKW381LTCyM65LreU+0Fmjx5N/W5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJYZpb3Srp1MAR6+Jkqbj0HbCaFjhej0OoJOIClgWrxsEF11aQc4TXT0e5a3DAxAijxa+7SLg8MEI1evGGqLwiLCtUOVRRv0LPOB6m/D5YNFSXc8ZasBuZyYAhHAVJvwp23PiDhYMEMDinI1vG0hTx52Mk+A1zfpEKy2SwFh/7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bUm1ZoXe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUm1ZoXe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765162716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkiK6QuCJmWjVdlECsy0CqVKBGJNyWPy8i29+LnzLTg=;
	b=bUm1ZoXeK6T0gLRVPKjZmFWZoytw99K5fQ4LgZzhLbXCJmNY/yyTK6R0NCKNattyoQrPZH
	TopvIu7jdglgspxooXTnCK+r2yX7tPUQ8+3wAVFJgKTO+IrPN1xY+0U2FSMGTIlSP7IErF
	BJOyzjDi+djVgHEUDmPRxRYHDmZt9O8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-DKsQy5HLOle17bvly6tl9A-1; Sun, 07 Dec 2025 21:58:25 -0500
X-MC-Unique: DKsQy5HLOle17bvly6tl9A-1
X-Mimecast-MFC-AGG-ID: DKsQy5HLOle17bvly6tl9A_1765162704
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3436d81a532so7281833a91.3
        for <virtualization@lists.linux.dev>; Sun, 07 Dec 2025 18:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765162704; x=1765767504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qkiK6QuCJmWjVdlECsy0CqVKBGJNyWPy8i29+LnzLTg=;
        b=Eazrg3H2Rltn3pW0BnnngpeXLCzmpWTpivuBAshRWBEc4fCm2QWrAWTyTkJx+pBtyU
         BGsaf9TGP8H4llSIuNTPwJ8MAIQLqzqX6JCauN7Zrr2/LvW7+o35Xnkzf1FFPnHpH5Ug
         82eE4LEBVTszhlNRAr8E/u5V73J3Ad67j2V0K9HQ0oWBqlb2M2kkw5vM5hnL8RNMwlxS
         gU7Wg0B7+K973ChSEldQgxGlqIkrYAcuztcDdiRc8ykZAW5rpUC47DGnZef0b9gNl1Ne
         vo4AtQVYsa/crEaQM+z/m43WVQ70gLEGeOtC90HQQrCMs+lT0Qi+AzoAawd/CzH6ILWu
         CShA==
X-Forwarded-Encrypted: i=1; AJvYcCWBm94qCexI28GmKoNnwdUrjPH1Cce7MLsCSBPNj6mR06L1/jl/3xMNta5+m+cAieoEPzvmvM86l2lZ8CqKDg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxy5Y87sjnBqmVimg+3SFq2vEMBLrsbPJ+dZd/DDNYh7uKcIeMW
	ZUaeQlI+30BwRE18M8oRzuqZiOpCMp6AJxkFx2QF9cxSOhVVeRyBOacqbS3yn5JU8+u84MSdTDX
	C4Tc7dOP+ih7BcUrLIwduIFa1bVdALN+zV0H/Uw0vC1vvfeldnNoqfJfmdxUYYwDrGIhOErv/R4
	cvyfu0gqEL20oiG7/DF+wc8mVFoG9uCF3Y/66tivDyHv0=
X-Gm-Gg: ASbGnctmqZiGnKVrmNyglls+V948OkVCIXw4tk4xuQINNGAdR1ZkVZxcmkHskRdKWCm
	9fu3x2vMmLkI2YezuqUBFACoz+iCGFmanKwcfPULWBny45nSNCeI/JnTD+K/OaUj84VFCpuL0iA
	udSPopGzcrw799JE3eeN80MlUeK95qxT4lEYwZiCQEMptD5lJUCOWFD4lmk/EcuEJJ9FG4
X-Received: by 2002:a17:90b:2d92:b0:33b:d74b:179 with SMTP id 98e67ed59e1d1-349a25cee1emr4308584a91.27.1765162703595;
        Sun, 07 Dec 2025 18:58:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrzWsj3TGJ2KFah8RKPebGkL83pOGFdr4NMylsinzk4cEUuEcQ04JxbLW2jn4KOVsizyn7+zMsqdjRjiYmmn8=
X-Received: by 2002:a17:90b:2d92:b0:33b:d74b:179 with SMTP id
 98e67ed59e1d1-349a25cee1emr4308551a91.27.1765162702870; Sun, 07 Dec 2025
 18:58:22 -0800 (PST)
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
 <CAJaqyWdQnv9E6dy8hma13SKwMJL16zKjT=8f9ns9MMy8-iovFw@mail.gmail.com>
 <CACGkMEvqgKASBEaw6HVj6+joaZuQzDFndO9UnYXLH2bAhZ5shQ@mail.gmail.com> <CAJaqyWeDjBfzrA93riYTmefY4oLbctWWBMPcpR5Q6r50dUGOEw@mail.gmail.com>
In-Reply-To: <CAJaqyWeDjBfzrA93riYTmefY4oLbctWWBMPcpR5Q6r50dUGOEw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Dec 2025 10:58:09 +0800
X-Gm-Features: AQt7F2rzgwW0vKKIOGaxGtiV36fMYSFE9E_2MKUlBsUx4azrQn_Vc-hHlqo-qGA
Message-ID: <CACGkMEsRRNoSvBwM=onwr1nbZGQUvK=c=_-1cBgATHujsDaf2w@mail.gmail.com>
Subject: Re: [PATCH v9 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, virtualization@lists.linux.dev, 
	Maxime Coquelin <mcoqueli@redhat.com>, Cindy Lu <lulu@redhat.com>, linux-kernel@vger.kernel.org, 
	Yongji Xie <xieyongji@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Az9V9bxBxMNFXvYjH4GdA2jbnpaPGQuIZexn4AbLKUc_1765162704
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 11:40=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Fri, Dec 5, 2025 at 2:52=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, Dec 4, 2025 at 4:33=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Thu, Dec 4, 2025 at 3:15=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Wed, Dec 3, 2025 at 3:58=E2=80=AFPM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Thu, Nov 20, 2025 at 2:38=E2=80=AFAM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > >
> > > > > > On Wed, Nov 19, 2025 at 5:27=E2=80=AFPM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Nov 19, 2025 at 3:39=E2=80=AFAM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Nov 17, 2025 at 8:16=E2=80=AFPM Eugenio Perez Marti=
n
> > > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Nov 17, 2025 at 5:23=E2=80=AFAM Jason Wang <jasow=
ang@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Nov 14, 2025 at 7:25=E2=80=AFPM Eugenio Perez M=
artin
> > > > > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Nov 14, 2025 at 1:55=E2=80=AFAM Jason Wang <j=
asowang@redhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Thu, Nov 13, 2025 at 7:56=E2=80=AFPM Eugenio P=
=C3=A9rez <eperezma@redhat.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > Add support for assigning Address Space Identifie=
rs (ASIDs) to each VQ
> > > > > > > > > > > > > group.  This enables mapping each group into a di=
stinct memory space.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Now that the driver can change ASID in the middle=
 of operation, the
> > > > > > > > > > > > > domain that each vq address point is also protect=
ed by domain_lock.
> > > > > > > > > > > >
> > > > > > > > > > > > Maybe it's better to document what is protected by =
RCU and how.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > I added the _rcu annotation but I can expand it for s=
ure. I can also
> > > > > > > > > > > modify the commit message.
> > > > > > > > > > >
> > > > > > > > > > > > More below.
> > > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > >
> > > > > > > > > > > I forgot to remove this, my bad!
> > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redha=
t.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > v9:
> > > > > > > > > > > > > * Replace mutex with RCU, as the vdpa map_ops can=
 run from atomic
> > > > > > > > > > > > >   context.
> > > > > > > > > > > > >
> > > > > > > > > > > > > v8:
> > > > > > > > > > > > > * Revert the mutex to rwlock change, it needs pro=
per profiling to
> > > > > > > > > > > > >   justify it.
> > > > > > > > > > > > >
> > > > > > > > > > > > > v7:
> > > > > > > > > > > > > * Take write lock in the error path (Jason).
> > > > > > > > > > > > >
> > > > > > > > > > > > > v6:
> > > > > > > > > > > > > * Make vdpa_dev_add use gotos for error handling =
(MST).
> > > > > > > > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < =
VDUSE_API_VERSION_1) ?/
> > > > > > > > > > > > >   (MST).
> > > > > > > > > > > > > * Fix struct name not matching in the doc.
> > > > > > > > > > > > >
> > > > > > > > > > > > > v5:
> > > > > > > > > > > > > * Properly return errno if copy_to_user returns >=
0 in VDUSE_IOTLB_GET_FD
> > > > > > > > > > > > >   ioctl (Jason).
> > > > > > > > > > > > > * Properly set domain bounce size to divide equal=
ly between nas (Jason).
> > > > > > > > > > > > > * Exclude "padding" member from the only >V1 memb=
ers in
> > > > > > > > > > > > >   vduse_dev_request.
> > > > > > > > > > > > >
> > > > > > > > > > > > > v4:
> > > > > > > > > > > > > * Divide each domain bounce size between the devi=
ce bounce size (Jason).
> > > > > > > > > > > > > * revert unneeded addr =3D NULL assignment (Jason=
)
> > > > > > > > > > > > > * Change if (x && (y || z)) return to if (x) { if=
 (y) return; if (z)
> > > > > > > > > > > > >   return; } (Jason)
> > > > > > > > > > > > > * Change a bad multiline comment, using @ caracte=
r instead of * (Jason).
> > > > > > > > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason)=
.
> > > > > > > > > > > > >
> > > > > > > > > > > > > v3:
> > > > > > > > > > > > > * Get the vduse domain through the vduse_as in th=
e map functions
> > > > > > > > > > > > >   (Jason).
> > > > > > > > > > > > > * Squash with the patch creating the vduse_as str=
uct (Jason).
> > > > > > > > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing ag=
ains a magic number
> > > > > > > > > > > > >   (Jason)
> > > > > > > > > > > > >
> > > > > > > > > > > > > v2:
> > > > > > > > > > > > > * Convert the use of mutex to rwlock.
> > > > > > > > > > > > >
> > > > > > > > > > > > > RFC v3:
> > > > > > > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason).=
 It was set to a lower
> > > > > > > > > > > > >   value to reduce memory consumption, but vqs are=
 already limited to
> > > > > > > > > > > > >   that value and userspace VDUSE is able to alloc=
ate that many vqs.
> > > > > > > > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD io=
ctl with
> > > > > > > > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > > > > > > > * Use of array_index_nospec in VDUSE device ioctl=
s.
> > > > > > > > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_=
v2.
> > > > > > > > > > > > > * Move the umem mutex to asid struct so there is =
no contention between
> > > > > > > > > > > > >   ASIDs.
> > > > > > > > > > > > >
> > > > > > > > > > > > > RFC v2:
> > > > > > > > > > > > > * Make iotlb entry the last one of vduse_iotlb_en=
try_v2 so the first
> > > > > > > > > > > > >   part of the struct is the same.
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 370 +++++++=
+++++++++++++---------
> > > > > > > > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > > > > > > > >  2 files changed, 314 insertions(+), 109 deletion=
s(-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b=
/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > > > > index 97be04f73fbf..ff95ed56f22d 100644
> > > > > > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > > > > @@ -11,6 +11,7 @@
> > > > > > > > > > > > >  #include "linux/virtio_net.h"
> > > > > > > > > > > > >  #include <linux/init.h>
> > > > > > > > > > > > >  #include <linux/module.h>
> > > > > > > > > > > > > +#include <linux/rcupdate.h>
> > > > > > > > > > > > >  #include <linux/cdev.h>
> > > > > > > > > > > > >  #include <linux/device.h>
> > > > > > > > > > > > >  #include <linux/eventfd.h>
> > > > > > > > > > > > > @@ -41,6 +42,7 @@
> > > > > > > > > > > > >
> > > > > > > > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > > > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > > > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 102=
4)
> > > > > > > > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > > > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > > > > > > > @@ -86,7 +88,14 @@ struct vduse_umem {
> > > > > > > > > > > > >         struct mm_struct *mm;
> > > > > > > > > > > > >  };
> > > > > > > > > > > > >
> > > > > > > > > > > > > +struct vduse_as {
> > > > > > > > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > > > > > > > +       struct vduse_umem *umem;
> > > > > > > > > > > > > +       struct mutex mem_lock;
> > > > > > > > > > > > > +};
> > > > > > > > > > > > > +
> > > > > > > > > > > > >  struct vduse_vq_group {
> > > > > > > > > > > > > +       struct vduse_as *as __rcu;
> > > > > > > > > > > > >         struct vduse_dev *dev;
> > > > > > > > > > > > >  };
> > > > > > > > > > > > >
> > > > > > > > > > > > > @@ -94,7 +103,7 @@ struct vduse_dev {
> > > > > > > > > > > > >         struct vduse_vdpa *vdev;
> > > > > > > > > > > > >         struct device *dev;
> > > > > > > > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > > > > > > > +       struct vduse_as *as;
> > > > > > > > > > > > >         char *name;
> > > > > > > > > > > > >         struct mutex lock;
> > > > > > > > > > > > >         spinlock_t msg_lock;
> > > > > > > > > > > > > @@ -122,9 +131,8 @@ struct vduse_dev {
> > > > > > > > > > > > >         u32 vq_num;
> > > > > > > > > > > > >         u32 vq_align;
> > > > > > > > > > > > >         u32 ngroups;
> > > > > > > > > > > > > -       struct vduse_umem *umem;
> > > > > > > > > > > > > +       u32 nas;
> > > > > > > > > > > > >         struct vduse_vq_group *groups;
> > > > > > > > > > > > > -       struct mutex mem_lock;
> > > > > > > > > > > > >         unsigned int bounce_size;
> > > > > > > > > > > > >         struct mutex domain_lock;
> > > > > > > > > > > > >  };
> > > > > > > > > > > > > @@ -314,7 +322,7 @@ static int vduse_dev_set_stat=
us(struct vduse_dev *dev, u8 status)
> > > > > > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > > > >  }
> > > > > > > > > > > > >
> > > > > > > > > > > > > -static int vduse_dev_update_iotlb(struct vduse_d=
ev *dev,
> > > > > > > > > > > > > +static int vduse_dev_update_iotlb(struct vduse_d=
ev *dev, u32 asid,
> > > > > > > > > > > > >                                   u64 start, u64 =
last)
> > > > > > > > > > > > >  {
> > > > > > > > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > > > > @@ -323,8 +331,14 @@ static int vduse_dev_update_=
iotlb(struct vduse_dev *dev,
> > > > > > > > > > > > >                 return -EINVAL;
> > > > > > > > > > > > >
> > > > > > > > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_=
1) {
> > > > > > > > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > > > > > > > +       } else {
> > > > > > > > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > > > > > > > +       }
> > > > > > > > > > > > >
> > > > > > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > > > >  }
> > > > > > > > > > > > > @@ -436,14 +450,32 @@ static __poll_t vduse_dev_p=
oll(struct file *file, poll_table *wait)
> > > > > > > > > > > > >         return mask;
> > > > > > > > > > > > >  }
> > > > > > > > > > > > >
> > > > > > > > > > > > > +/* Force set the asid to a vq group without a me=
ssage to the VDUSE device */
> > > > > > > > > > > > > +static void vduse_set_group_asid_nomsg(struct vd=
use_dev *dev,
> > > > > > > > > > > > > +                                      unsigned i=
nt group, unsigned int asid)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +       /*
> > > > > > > > > > > > > +        * Two concurrent updates to this pointer=
 are valid as they cannot
> > > > > > > > > > > > > +        * point to an invalid region.  It is ok =
for them to race as long as
> > > > > > > > > > > > > +        * the readers see a consistent state thr=
ough RCU.
> > > > > > > > > > > > > +        */
> > > > > > > > > > > > > +       rcu_assign_pointer(dev->groups[group].as,=
 &dev->as[asid]);
> > > > > > > > > > > >
> > > > > > > > > > > > I'd expect at least a synchronize_rcu() here to wai=
t for the read is done?
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > What's the use? The only thing left here is to return=
 from
> > > > > > > > > > > vduse_set_group_asid_nomsg, and we don't need to wait=
 for readers
> > > > > > > > > > > here, do we?
> > > > > > > > > >
> > > > > > > > > > See below.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > > >  static void vduse_dev_reset(struct vduse_dev *de=
v)
> > > > > > > > > > > > >  {
> > > > > > > > > > > > >         int i;
> > > > > > > > > > > > > -       struct vduse_iova_domain *domain =3D dev-=
>domain;
> > > > > > > > > > > > >
> > > > > > > > > > > > >         /* The coherent mappings are handled in v=
duse_dev_free_coherent() */
> > > > > > > > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > > > > > > > -               vduse_domain_reset_bounce_map(dom=
ain);
> > > > > > > > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > > > > > > > +               struct vduse_iova_domain *domain =
=3D dev->as[i].domain;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > > > > > > > +                       vduse_domain_reset_bounce=
_map(domain);
> > > > > > > > > > > > > +       }
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > > > > > > > +               vduse_set_group_asid_nomsg(dev, i=
, 0);
> > > > > > > > > > > > >
> > > > > > > > > > > > >         down_write(&dev->rwsem);
> > > > > > > > > > > > >
> > > > > > > > > > > > > @@ -623,6 +655,29 @@ static union virtio_map vdus=
e_get_vq_map(struct vdpa_device *vdpa, u16 idx)
> > > > > > > > > > > > >         return ret;
> > > > > > > > > > > > >  }
> > > > > > > > > > > > >
> > > > > > > > > > > > > +static int vduse_set_group_asid(struct vdpa_devi=
ce *vdpa, unsigned int group,
> > > > > > > > > > > > > +                               unsigned int asid=
)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(v=
dpa);
> > > > > > > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > > > > +       int r;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_=
1 ||
> > > > > > > > > > > > > +           group >=3D dev->ngroups || asid >=3D =
dev->nas)
> > > > > > > > > > > > > +               return -EINVAL;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > > > > +       if (r < 0)
> > > > > > > > > > > > > +               return r;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +       vduse_set_group_asid_nomsg(dev, group, as=
id);
> > > > > > > > > > > > > +       return 0;
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_d=
evice *vdpa, u16 idx,
> > > > > > > > > > > > >                                 struct vdpa_vq_st=
ate *state)
> > > > > > > > > > > > >  {
> > > > > > > > > > > > > @@ -794,13 +849,13 @@ static int vduse_vdpa_set_m=
ap(struct vdpa_device *vdpa,
> > > > > > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(v=
dpa);
> > > > > > > > > > > > >         int ret;
> > > > > > > > > > > > >
> > > > > > > > > > > > > -       ret =3D vduse_domain_set_map(dev->domain,=
 iotlb);
> > > > > > > > > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid=
].domain, iotlb);
> > > > > > > > > > > > >         if (ret)
> > > > > > > > > > > > >                 return ret;
> > > > > > > > > > > > >
> > > > > > > > > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL,=
 ULLONG_MAX);
> > > > > > > > > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid,=
 0ULL, ULLONG_MAX);
> > > > > > > > > > > > >         if (ret) {
> > > > > > > > > > > > > -               vduse_domain_clear_map(dev->domai=
n, iotlb);
> > > > > > > > > > > > > +               vduse_domain_clear_map(dev->as[as=
id].domain, iotlb);
> > > > > > > > > > > > >                 return ret;
> > > > > > > > > > > > >         }
> > > > > > > > > > > > >
> > > > > > > > > > > > > @@ -843,6 +898,7 @@ static const struct vdpa_conf=
ig_ops vduse_vdpa_config_ops =3D {
> > > > > > > > > > > > >         .get_vq_affinity        =3D vduse_vdpa_ge=
t_vq_affinity,
> > > > > > > > > > > > >         .reset                  =3D vduse_vdpa_re=
set,
> > > > > > > > > > > > >         .set_map                =3D vduse_vdpa_se=
t_map,
> > > > > > > > > > > > > +       .set_group_asid         =3D vduse_set_gro=
up_asid,
> > > > > > > > > > > > >         .get_vq_map             =3D vduse_get_vq_=
map,
> > > > > > > > > > > > >         .free                   =3D vduse_vdpa_fr=
ee,
> > > > > > > > > > > > >  };
> > > > > > > > > > > > > @@ -852,14 +908,17 @@ static void vduse_dev_sync_=
single_for_device(union virtio_map token,
> > > > > > > > > > > > >                                              enum=
 dma_data_direction dir)
> > > > > > > > > > > > >  {
> > > > > > > > > > > > >         struct vduse_dev *vdev;
> > > > > > > > > > > > > +       struct vduse_as *as;
> > > > > > > > > > > > >         struct vduse_iova_domain *domain;
> > > > > > > > > > > > >
> > > > > > > > > > > > >         if (!token.group)
> > > > > > > > > > > > >                 return;
> > > > > > > > > > > > >
> > > > > > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > > > > > -
> > > > > > > > > > > > > +       rcu_read_lock();
> > > > > > > > > > > > > +       as =3D rcu_dereference(token.group->as);
> > > > > > > > > > > > > +       domain =3D as->domain;
> > > > > > > > > > > > > +       rcu_read_unlock();
> > > > > > > > > > > > >         vduse_domain_sync_single_for_device(domai=
n, dma_addr, size, dir);
> > > > > > > > > > > >
> > > > > > > > > > > > This is suspicious, at least we should do rcu_read_=
unlock() after
> > > > > > > > > > > > vduse_domain_sync_single_for_device(), otherwise I =
don't see how RCU
> > > > > > > > > > > > works.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > RCU is protecting that the address space pointer of t=
he vq group is
> > > > > > > > > > > not modified concurrently with the access. Ideally, t=
his should be a
> > > > > > > > > > > full lock, but just making sure that all accesses fro=
m the reader are
> > > > > > > > > > > coherent is enough. Userspace should expect nothing i=
f it uses the map
> > > > > > > > > > > and modifies the vq group ASID at the same time anywa=
y, but the kernel
> > > > > > > > > > > needs to be sure that it does not see intermediate st=
ates. TBH, we
> > > > > > > > > > > could move to a READ_ONCE / WRITE_ONCE, would that be=
 more clear?
> > > > > > > > > >
> > > > > > > > > > Using READ_ONCE/WRITE_ONCE() needs to make sure the ord=
ering is
> > > > > > > > > > handled correctly.
> > > > > > > > > >
> > > > > > > > > > But I meant what happens if
> > > > > > > > > >
> > > > > > > > > > [cpu0]rcu_read_lock()
> > > > > > > > > > [cpu0]as =3D rcu_dereference(token.group->as)
> > > > > > > > > > [cpu0]...
> > > > > > > > > > [cpu0]rcu_read_unlock()
> > > > > > > > > > [cpu1]rcu_assign_pointer(token.group->as)
> > > > > > > > > > [cpu0]vduse_domain_sync_single_for_device()
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > That should go ok. What I'm trying to protect here is the=
 iterations
> > > > > > > > > in vduse_domain_sync_single_for_device -> vduse_domain_bo=
unce.
> > > > > > > > >
> > > > > > > > > I'm going to embed that function here in
> > > > > > > > > vduse_dev_sync_single_for_device and omit RCU and some de=
tails to make
> > > > > > > > > the point easier:
> > > > > > > > >
> > > > > > > > > vduse_dev_sync_single_for_device(union virtio_map token, =
dma_addr_t
> > > > > > > > > iova, size_t size, ...) {
> > > > > > > > >   read_lock(&token.group->as->domain);
> > > > > > > > >   while (size)
> > > > > > > > >     map =3D token.group->as->domain->bounce_maps[iova];
> > > > > > > > >     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
> > > > > > > > >
> > > > > > > > >     ...
> > > > > > > > >     page =3D token_group->as->domain->bounce_maps
> > > > > > > > >     addr =3D kmap_local_page(page);
> > > > > > > > >     do_bounce(map->orig_phys, addr, sz, dir);
> > > > > > > > >     kunmap_local(addr);
> > > > > > > > >     size -=3D sz;
> > > > > > > > >     iova +=3D sz;
> > > > > > > > >   }
> > > > > > > > >   read_unlock(&token.group->as->domain);
> > > > > > > > > }
> > > > > > > >
> > > > > > > > Right, so I meant for rwlock like semantic (let's forget th=
e sleeping here).
> > > > > > > >
> > > > > > > > vduse_set_group_asid_nomsg() should use "write lock" so it =
must wait
> > > > > > > > for the "read lock" to be done.
> > > > > > >
> > > > > > > No, it doesn't need to wait as long as the reader part uses i=
ts own copy.
> > > > > >
> > > > > > It probably won't crash but I meant if we have logic issues. Fo=
r
> > > > > > example, once set_group_asid() return, there should still be a =
pending
> > > > > > DMA that is using the old as.
> > > > > >
> > > > > > >
> > > > > > > > But this is not the logic that is
> > > > > > > > implemented in this patch as there's no synchronize_rcu() i=
n the
> > > > > > > > vduse_set_group_asid_nomsg().
> > > > > > >
> > > > > > > We only set the pointer on the writer's side, we do nothing l=
ike
> > > > > > > freeing resources. Should we set the pointer before or after
> > > > > > > syncrhonize_rcu()? What do we need to do on the other side of
> > > > > > > syncrhonize_rcu()?
> > > > > >
> > > > > > Usually we don't need special care on the read side. But as dis=
cussed,
> > > > > > synchronize_rcu() is not a must but we need to explain why it i=
s safe
> > > > > > and I'm not sure Michael is fine with that.
> > > > > > If we just want to make sure the order of publish and read, we =
can
> > > > > > switch to use smp_store_release() and smp_load_acqurie().
> > > > > >
> > > > > > >
> > > > > > > > We need to explain why set_group_asid()
> > > > > > > > doesn't need to wait and if this is true, we probably don't=
 need RCU
> > > > > > > > but to make sure the load/store is atomic.
> > > > > > > >
> > > > > > >
> > > > > > > What about:
> > > > > > >
> > > > > > > * It does not matter if other thread modify group->as as long=
 as the
> > > > > > > reader uses the same as for all its operation. It performs a =
local
> > > > > > > copy for that reason.
> > > > > > > * It does not matter if multiple threads modify group->as as =
long as
> > > > > > > the update is atomic.
> > > > > >
> > > > > > See above reply.
> > > > > >
> > > > > > >
> > > > > > > ?
> > > > > > >
> > > > > > > > >
> > > > > > > > > Now, depending on the point where another execution threa=
d changes
> > > > > > > > > token_group->as and how the compiler has chosen to genera=
te the
> > > > > > > > > machine code, the outcome could be:
> > > > > > > > > 1) The domain read lock of one ASID is taken but the doma=
in lock of
> > > > > > > > > another as is unlocked.
> > > > > > > > > 2) We iterate until iova is ok for the ASID we're handlin=
g, but not
> > > > > > > > > for the other one. So we access an invalid offset in
> > > > > > > > > bounce_maps[iova].
> > > > > > > > >
> > > > > > > > > And I guess there are other possible outcomes too.
> > > > > > > > >
> > > > > > > > > So I need to make sure that the pointer accesses in all
> > > > > > > > > vduse_domain_bounce is coherent.
> > > > > > > >
> > > > > > > > I'm not sure I got here, but it looks like it accepts a dom=
ain
> > > > > > > > parameter and is protected by the bounce lock so we are pro=
bably fine
> > > > > > > > here?
> > > > > > > >
> > > > > > >
> > > > > > > The bounce lock only protects the iotlb tree, not the pointer=
 to that
> > > > > > > iotlb tree.
> > > > > > >
> > > > > > > > > I'm ok if it takes the one before the
> > > > > > > > > concurrent call to vduse_set_group_asid_nomsg or the one =
after that,
> > > > > > > > > as the lifetime of all domains are bound to the device. B=
ut it cannot
> > > > > > > > > change in the middle of the operation:
> > > > > > > > >
> > > > > > > > > vduse_dev_sync_single_for_device(union virtio_map token, =
dma_addr_t
> > > > > > > > > iova, size_t size, ...) {
> > > > > > > > >   as =3D token.group->as;
> > > > > > > > >   // Tell the compiler to never replace "as" by "token.gr=
oup->as" after this.
> > > > > > > > >   read_lock(&as->domain);
> > > > > > > > >   while (size)
> > > > > > > > >     map =3D as->domain->bounce_maps[iova];
> > > > > > > > >     sz =3D min_t(size_t, BOUNCE_MAP_SIZE, size);
> > > > > > > > >
> > > > > > > > >     ...
> > > > > > > > >     page =3D as->domain->bounce_maps
> > > > > > > > >     addr =3D kmap_local_page(page);
> > > > > > > > >     do_bounce(map->orig_phys, addr, sz, dir);
> > > > > > > > >     kunmap_local(addr);
> > > > > > > > >     size -=3D sz;
> > > > > > > > >     iova +=3D sz;
> > > > > > > > >   }
> > > > > > > > >   read_unlock(&as->domain);
> > > > > > > > > }
> > > > > > > > >
> > > > > > > > > That can be done in many ways. Probably the read_lock is =
already
> > > > > > > > > enough but it is not explicit that it is protecting token=
.group->as,
> > > > > > > > > and future changes could remove it. To me, RCU is the mos=
t clear way
> > > > > > > > > to do it, but even a volatile read (READ_ONCE?) would do.
> > > > > > > >
> > > > > > > > I wonder if another group rwlock is sufficient here:
> > > > > > > >
> > > > > > > > for set_group_as_id()
> > > > > > > >
> > > > > > > > write_lock(&dev->groups[group].lock);
> > > > > > > > dev->groups[group].as =3D &dev->as[asid];
> > > > > > > > write_unlock(&dev->groups[group].lock);
> > > > > > > >
> > > > > > > > for the case where we need defer as
> > > > > > > >
> > > > > > > > read_lock(&dev->groups[group].lock);
> > > > > > > > as =3D dev->groups[group].as;
> > > > > > > > //using as
> > > > > > > > read_unlock(&dev->groups[group].lock);
> > > > > > > >
> > > > > > > > If this works, we don't need to bother with thinking if the
> > > > > > > > wait/synchronizre_rcu() is really needed or not?
> > > > > > > >
> > > > > > >
> > > > > > > A rwlock is sufficient but we need to modify the allocation c=
ode
> > > > > > > somehow. Also, I thought we wanted to avoid the overhead of t=
aking the
> > > > > > > read lock in the DMA ops too.
> > > > > >
> > > > > > Right, but it would always be a balance. We can make sure it wo=
rks
> > > > > > correctly first then do optimization on top.
> > > > > >
> > > > > > >
> > > > > > > Another disadvantage of the lock vs RCU or READ_ONCE is that =
the vq
> > > > > > > group ASID change needs to wait for the DMA operation to fini=
sh
> > > > > > > instead of just applying for the next DMA ops. Not like vq gr=
oup ASID
> > > > > > > change would be in the hot path anyway, just pointing it out.
> > > > > > >
> > > > > > > > >
> > > > > > > > > > If this is not an issue, RCU is not a must, but please =
explain why.
> > > > > > > > > > If this is an issue, we need to fix it.
> > > > > > > > > >
> > > > > > > > > > It's basically a question that
> > > > > > > > > >
> > > > > > > > > > 1) should we need to wait for the DMA to be completed b=
efore assigning
> > > > > > > > > > to the new as
> > > > > > > > >
> > > > > > > > > I don't think so, it is valid to assign a new as and let =
the ongoing
> > > > > > > > > operation to continue. It is racy and the operation could=
 fail, but
> > > > > > > > > the kernel just returns an error and doesn't access inval=
id memory or
> > > > > > > > > similar.
> > > > > > > >
> > > > > > > > See below.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > 2) should we track the set_group_asid() for the group t=
hat has pending
> > > > > > > > > > DMA to avoid potential issue
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > No, the group will outlive the operation as it is bound t=
o the device.
> > > > > > > >
> > > > > > > > I meant e.g the DMA could be triggered by the device. For e=
xample, the
> > > > > > > > device may try to trigger an interrupt when the kernel is t=
rying to
> > > > > > > > assign a new asid. So I wonder if guest can use this to pok=
e Qemu's
> > > > > > > > memory etc.
> > > > > > >
> > > > > > > I'm not sure I get this point. If QEMU changes the ASID of th=
e vq
> > > > > > > group sent to the guest the race does not matter anymore: it =
is
> > > > > > > explicitly opening the possibility from the guest to poke QEM=
U's
> > > > > > > memory unless the guest is totally paused.
> > > > > >
> > > > > > Basically what I meant, assuming group0.as =3D as0
> > > > > >
> > > > > > cpu0] dma_map(group0.as, addr, DMA_FROM_DEVICE)
> > > > > > cpu1] set_group_asid(group0.as, as1)
> > > > > > cpu0] dma_unmap(group0.as, addr, DMA_FROM_DEVICE)
>
> [1]
>
> > > > > >
> > > > > > cpu0 may read as1 while it wants as0 actually?
> > > > > >
> > > > >
> > > > > Yes, kind of. That's my point: adding synchronization at vduse le=
vel
> > > > > does not fix it.
> > > > >
> > > > > There is no way to do that call from vhost/vdpa or userland, as t=
here
> > > > > is no way to get the AS of a vq group, only to set it. The closes=
t
> > > > > thing is to add a cache at that level, but that implies to add
> > > > > mutithreading sync on that upper layer, either vhost/vdpa or user=
land,
> > > > > not in VDUSE.
>
> [2]
>
> > > >
> > > > Probably.
> > > >
> > > > >
> > > > > From vhost/vdpa level, all mapping calls (.set_map, .dma_map,
> > > > > .dma_unmap) calls take the ASID directly, not the vq group. So th=
e
> > > > > call to set_group_asid does not need to access the vq group.
> > > > >
>
> [3]
>
> > > > > Now let's say that we add that vdpa_ops callback (and ioctls) tha=
t
> > > > > maps and unmap based on a vq_group. And all of the operations
> > > > > (dma_map, set_group_asid, and dma_unmap) are serialized by taking=
 the
> > > > > same mutex. cpu0 still may dma_unmap over as0 if set_group_asid i=
s not
> > > > > properly serialized at vhost/vdpa or userland level:
> > > > >
> > > > > void* thread0_func(void* arg) {
> > > > > struct {
> > > > >         int vq_group =3D 0,
> > > > >         int iova, size, perm, ...
> > > > >     } s;
> > > > >     int fd =3D (intptr_t)arg;
> > > > >
> > > > >     ioctl(fd, VHOST_VDPA_VQ_GROUP_DMA_MAP, &s);
> >
> > I don't get the semantic of VHOST_VDPA_VQ_GROUP_DMA_MAP. And it's
> > probably wrong to allow userspace to map based on group.
> >
> > We have VHOST_IOTLB_UPDATE which map pages based on as (asid) this is c=
orrect.
> >
>
> Yes, I said that at [2], in reply to your scenario at [1] :). Did I
> misunderstand?

Nope, it looks like it's me that misread your reply.

>
> > More below
> >
> > > > >     // TODO: Signal thread0 that it can proceed with SET_GROUP_AS=
ID
> > > > >     // TODO: Wait until thread0 complete SET_GROUP_ASID
> > > > >
> > > > >     ioctl(fd, VHOST_VDPA_VQ_GROUP_DMA_UNMAP, &data);
> > > > >
> > > > >     return NULL;
> > > > > }
> > > > >
> > > > > void* thread1_func(void* arg) {
> > > > >     struct vhost_vring_state s =3D {
> > > > >         .index =3D 0,
> > > > >         .num =3D 1,
> > > > >     };
> > > > >     int fd =3D (int)(intptr_t)arg;
> > > > >
> > > > >     // TODO: Wait until thread2 calls dma_map
> > > >
> > > > This is something exactly rwlock or synchronize_rcu() can do? Or is
> > > > this the charge of the vDPA parent to do that?
> > > >
> > >
> > > No, that's an userland synchronization problem that cannot be solved
> > > at kernel level. If we need to do something similar at vdpa core leve=
l
> > > (unlikely), we will need to synchronize at that level too.
> >
> > Ok, basically I think we are talking about different things. That's fin=
e.
> >
> > If I understand you correctly, you mean we need to synchronize between
> > IOTLB updating (IOTLB_UPDATE/IOTLB_INVALIDATE) and set_group_asid()?
> >
> > This sounds unnecessary since:
> >
> > 1) IOTLB_UPDATE/IOTLB_INVALIDATE is updating the address space internal=
 mappings
> > 2) set_group_asid() is to assign an AS to a group
> >
>
> Right, we're on the same page here [3].
>
> > >
> > > If we add an rwlock but don't implement the synchronization in the
> > > userland program marked as TODO, this sequence is also possible:
> > >
> > > cpu0] DMA map ioctl call in userland
> > > -> Take read_lock in the vduse module
> > > -> Update the IOTLB tree of ASID 0
> > > -> unlock read_lock
> > >
> > > Now we have two possibilities: either cpu0] DMA_UNMAP is called or
> > > cpu1] set_group_asid is called. The VDUSE module rwlock protects that
> > > they will not run at the same time, but we need to implement somethin=
g
> > > at the userland level if we want a predictive outcome, marked as the
> > > TODO in the comments. If, by chance, the DMA unmap is the one that
> > > comes next, the AS updated is the 0:
> > >
> > > cpu0] DMA unmap ioctl call in userland
> > > -> Take read_lock in the vduse module
> > > -> Update the IOTLB tree of ASID 0
> > > -> unlock read_lock
> > > cpu1] set_group_asid ioctl call in userland
> > > -> Take write_lock in the vduse module
> > > -> Update ASID of the VQ GROUP 0 to 1
> > > -> unlock write_lock
> > >
> > > If set_group_asid run first by chance, ASID 1 is the one that is upda=
ted:
> > > cpu1] set_group_asid ioctl call in userland
> > > -> Take write_lock in the vduse module
> > > -> Update ASID of the VQ GROUP 0 to 1
> > > -> unlock write_lock
> > > cpu0] DMA unmap ioctl call in userland
> > > -> Take read_lock in the vduse module
> > > -> Update the IOTLB tree of ASID 0
> > > -> unlock read_lock
> > >
> > > On the other hand we have this version of the series that allows thes=
e
> > > actions to run at the same time. It just makes sure that the update o=
f
> > > the IOTLB tree is coherent, by copying the vq group ASID value at one
> > > point in time and making sure it sticks to that ASID until the end of
> > > the set_map call. I'm not adding the synchronize_rcu call because we
> > > stated it should not be called from userland, but the outcome is
> > > similar.
> >
> > I think we should figure out if VHOST_VDPA_VQ_GROUP_DMA_MAP is useful o=
r not.
> >
>
> It's not. I just wanted to expand how I understood your scenario, but
> let me know if I missed something!
>
> > >
> > > Let me put another example: It's like calling fdup() and write() from
> > > different threads over the same set of fds without userland
> > > synchronization to me. The kernel protects things like not write part
> > > of the content in one file and another part on the other file, but th=
e
> > > content of the files at the end of the writes() is just not
> > > predictable. And the kernel just cannot make it predictable.
> > >
> > > static int fd_a;
> > > static int fd_b;
> > >
> > > void *write_thread(void *arg) {
> > >     const char *msg =3D "Writing to fd_b\n";
> > >     write(fd_b, msg, strlen(msg));
> > >     return NULL;
> > > }
> > >
> > > void *dup_thread(void *arg) {
> > >     dup2(fd_a, fd_b);
> > >     return NULL;
> > > }
> > >
> > > int main() {
> > >     pthread_t writer, duper;
> > >
> > >     fd_a =3D open("/tmp/a", O_WRONLY | O_CREAT | O_TRUNC, 0644);
> > >     fd_b =3D open("/tmp/b", O_WRONLY | O_CREAT | O_TRUNC, 0644);
> > >
> > >     pthread_create(&writer, NULL, write_thread, NULL);
> > >     pthread_create(&duper, NULL, dup_thread, NULL);
> > >
> > >     pthread_join(writer, NULL);
> > >     pthread_join(duper, NULL);
> > >
> > >     close(fd_a);
> > >     close(fd_b);
> > >
> > >     return 0;
> > > }
> > > --
> > >
> > > > If it's the responsibility of the parent, it would be much harder f=
or
> > > > VDUSE as the datapath is implemented in usersapce via mmap() or
> > > > umem_reg.
> > > >
> > > > Looking at existing implementation:
> > > >
> > > > - for mlx5e, it looks like it assumes the set_group_asid() works on=
ly
> > > > without DRIVER_OK.
> > > > - for the simulator, it looks like it can synchronize with the
> > > > datapath with the spinlock as datapath is emulated
> > > >
> > >
> > > Yes, the next version will use the rwlock spinlock. I just need to
> > > take out the allocation of the domain for it to be valid.
> > >
> > > > >     ioctl(fd, VHOST_VDPA_SET_GROUP_ASID, &s)
> > > > >     // TODO: Signal thread2 that can proceed with dma_unmap
> > > >
> > > > But the issue I mention is that the, from the view of the vDPA bus:
> > > >
> > > > 1) it offers set_group_as_id()
> > > > 2) it doesn't know if virtio-vdpa or vhost-vdpa is used
> > > >
> > > > So theoretically, set_group_as_id() could happen between
> > > >
> > > > dma_addr =3D dma_map();
> > > >
> > > > and
> > > >
> > > > dma_unmap(dma_adrr);
> > > >
> > > > But those two dma_addr refers to the different address space.
> > >
> > > I don't get this, these calls take the ASID as the parameter, not the
> > > vq group. I thought this was by design, as telling what vq groups
> > > update seems way more difficult to me. Can you put an example of an
> > > userland application that has the race you describe with the existing
> > > ioctls?
> >
> > Just to clarify, I for dma_map()/dma_unmap() this is not the UAPI part
> > (and we don't have that). I basically mean the dma API which is used
> > by virtio-vDPA.
> >
>
> So let's say that the virtio_vdpa driver is able to call
> .set_group_asid just to explain how much it is protected:
>
> ->vduse_dev_map_page and ->vduse_dev_unmap_page
> In this series, rcu_dereference makes sure that only the stack copy of
> the domain pointer is used, but the next version the code will have a
> read_lock taken protecting that set_group_asid actions on
> token.group->as cannot run at the same time that the
> vduse_domain_map_page(...) or vduse_domain_unmap_page(...) function
> call run in cpu0:
>
> static dma_addr_t vduse_dev_map_page(union virtio_map token, struct page =
*page,
>                                      unsigned long offset, size_t size,
>                                      enum dma_data_direction dir,
>                                      unsigned long attrs)
> {
>         struct vduse_iova_domain *domain;
>         dma_addr_t r;
>
>         if (!token.group)
>                 return DMA_MAPPING_ERROR;
>
>         read_lock(&dev->groups[group].as_lock);
>         domain =3D token.group->as->domain;
>         r =3D vduse_domain_map_page(domain, page, offset, size, dir, attr=
s);
>         read_unlock(&dev->groups[group].as_lock);
>
>         return r;
> }
>
> static void vduse_dev_unmap_page(union virtio_map token, dma_addr_t dma_a=
ddr,
>                                  size_t size, enum dma_data_direction dir=
,
>                                  unsigned long attrs)
> {
>         struct vduse_iova_domain *domain;
>
>         if (!token.group)
>                 return;
>
>         read_lock(&dev->groups[group].as_lock);
>         domain =3D token.group->as->domain;
>         vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
>         read_unlock(&dev->groups[group].as_lock);
> }
> ---
>
> -> vduse_set_group_asid will have the corresponding write_lock, so it
> cannot modify any vq group AS pointer while they're mapping or
> unmapping pages from a domain:
> static void vduse_set_group_asid_nomsg(struct vduse_dev *dev,
>                                        unsigned int group, unsigned int a=
sid)
> {
>         write_lock(&dev->groups[group].as_lock);
>         dev->groups[group].as =3D &dev->as[asid];
>         write_unlock(&dev->groups[group].as_lock);
> }
> ---
>
> Now your question:
>
> assuming group0.as =3D as0
>
> cpu0] dma_map(group0.as, addr, DMA_FROM_DEVICE)
> cpu1] set_group_asid(group0.as, as1)
> cpu0] dma_unmap(group0.as, addr, DMA_FROM_DEVICE)
>
> cpu0 may read as1 while it wants as0 actually?
> --
>
> Yes, it can happen even with the rwlock or any other synchronization
> in VDUSE, as it does not order the vdpa core calls.
>
> This is the code I have in mind to prove this, let me know if I'm
> missing something from your scenario:
>
> static int thread1_func(void *data)
> {
>     vduse_dev_map_page(token, ...);
>     printk(KERN_INFO "map_page called\n");
>
>     // TODO: Need a way to know if the group ASID has changed to
>     // know if this unmap is valid or not.
>     vduse_dev_unmap_page(token, ...);
>     printk(KERN_INFO "unmap_page called\n");
>
>     return 0;
> }
>
> static int thread2_func(void *data)
> {
>     u32 vq_group =3D 0;
>     u32 asid =3D 1;
>
>     vdpa->ops->set_group_asid(global_vdpa, vq_group, asid);
>     printk(KERN_INFO "set_group_asid called\n");
>
>     return 0;
> }
>
> static int __init kernel_threads_init(void)
> {
>     struct task_struct *thread1, *thread2;
>
>     thread1 =3D kthread_run(thread1_func, NULL, "vdpa_map_unmap");
>     thread2 =3D kthread_run(thread2_func, NULL, "vdpa_set_asid");
>
>     return 0;
> }
>
> ---
>
> I keep thinking that this is a race condition in the hypothetical vdpa
> core or the module that runs this code, not solvable in VDUSE. We need
> to add barriers at this level, not VDUSE.
>
> But I think it is a good idea to add some code in VDUSE to mitigate
> it. Maybe just adding the expected vq queue index to
> vdev->map->map_page and vdev->map->unmap_page?

This seems to be more complicated than encoding asid to the iova.

> This way we can issue
> an error if the race happens.

As discussed, it could be avoided by disallowing the call to
set_group_asid() when DRIVER_OK is set.

>
> > >
> > > > Instead
> > > > of trying to do synchronization, maybe we can simply fail
> > > > set_group_asid if DRIVER_OK is set.
> > > >
> > >
> > > That's a good possibility, especially since mlx5 already does it.
> > > There is ongoing work to enable dataplane SVQ dynamically without
> > > needing to reset the whole device, but we will need a new feature fla=
g
> > > to know if the parent driver supports it.
> >
> > Did you mean the SVQ may update the group asid while DRIVER_OK is set?
> > If yes, we need to fix that.
> >
>
> Not at this moment.

Great.

Thanks

