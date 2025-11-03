Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23C2EA151
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161991; cv=none; b=YWUKssJR1H8Pi9JAVacn/Am6m0NGOnJSbSixCAovNMMWpEuqNushcihIb4oftxGBU5SbIW3xIK4tUxJqRPKHSvq9PTRIM7Pmr86Sh+SVsx7jGUyzWj7hl3DmJuJayB20TXnRnt/Ii2tnX5zZ0qbbtznkpF8wEr115dU5vsq0lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161991; c=relaxed/simple;
	bh=sq4G95Gh30S8xQ73KcEjOhqgZV8ahD3KiHtZ1dntXi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7dEHUeWYgunpjMgfmOpxLmbqi1P2HjVkxWwHBW6TLzPhbDHBAJzTGLqlorM6NDsmdkEuw7mgvDnJU+5ub89zlWifCeZke3tb5lHVDKkdOaOLzBY4MvoFMrenN64++kZABRDVdUA+b67CNj7BJ8Efe0DKg8jfDMGNE2oc0jIOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEa4e57x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEa4e57x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762161988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdByqwMWlnxxSQR21PS2QeY0G8cmHhUsHtquOwZ97iY=;
	b=TEa4e57xaAK4BSKXrI2AHF319YWBYyLv5H3RHmKjVCH2O+AFuVXuBIXqjNV195oTwn44Jr
	Fqmjw0W24apsod8Jf7gNsu/Gui4Whyo14Yp3FxKWS3tXoUzPV61KATQm4bh0QFclN8+6Ri
	OQm2icpffa327v7LXExQZLPjswzJacg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-cGTQcw7kMCm1UbuMnaWXOA-1; Mon, 03 Nov 2025 04:26:27 -0500
X-MC-Unique: cGTQcw7kMCm1UbuMnaWXOA-1
X-Mimecast-MFC-AGG-ID: cGTQcw7kMCm1UbuMnaWXOA_1762161986
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340e10797a8so1227911a91.1
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 01:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762161986; x=1762766786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdByqwMWlnxxSQR21PS2QeY0G8cmHhUsHtquOwZ97iY=;
        b=m7Uh+RiMRyCoSTDNbTzUlEcAgrSzw8X9wf9TSZHEiX2tZUJLfZ45Ru5YvANMXpoTYk
         kFO7Em4oPt/EmVoo1CQM+zpBfZMLJtDeH4qQujMpJ/uS/J+jSsu3D10nEec6YtUoNSoC
         HzOwEZ8wOy6yClhLwBLi6pOCmt2iaSiz5kedI1lCM0EiAjH/FVmrp99LLcHb+oPrHn2f
         YNr4EL0JoKFTcBczbmpuQWC+CwqDcv1mLHGQBYWSvoyz781L59yaInS39dUADx5/dV6Z
         An064I71OzswZeQYu5h3VQxcp9cQodz7ZriuhjtAIt6P+VmOw+SmOWPmwWxF5qOUkVU/
         M5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXobxlVCvSDnvyUupG+UJnYLFFBBBC1VS6WfJsYHtaNs2C9HtltJ9r7UITH2kwx3TqMZATe0FcP+TvvMbXd3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCiFYPtQMogj1scKuhBjLPxqKEV03OGYhSd3lAXyFDMNao8gmK
	CZ7hAkBdtxs6Ffx1KNd0kd1YDiEzmx6OVTI5K6xOJMXTYV/zIcmXtVPFUua/pHn3hHSM+PA2WMZ
	Gkj0nsxLsxtqVTh2z15l8z+Dv6c/kmP5lNW2qDkVbpXdZ7mflU8P1e8lvKPZHUflZ1IhbbLmxea
	r0I9vw0P7b2UQpOxnrfhXgtURuZWBeSB9xgb/wKnzxkUc=
X-Gm-Gg: ASbGncu1xqKoKneL1i5yRvCKRUU54rNDtln32TIbjjRimGw3t1rmL18efUMPhA6cSCw
	UZCJqQa8aBHzVAhHWSxsfPgZi39N1lvjmShsIM2KY5C5Vrl8oHQxUy8rFO7NfA1lA6Lr2w/mcLR
	Hx2IBeW5HGKpQUlQPR7jZS7M3Ed4ALZeutgCX/h6RQIq+Ce9534v94wyqj
X-Received: by 2002:a17:90b:3952:b0:340:d1b5:bfda with SMTP id 98e67ed59e1d1-340d1b5c124mr8302887a91.3.1762161985830;
        Mon, 03 Nov 2025 01:26:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvNn9LSEPqXwnTN010A/lfc5yuXBxhotfi/JtR72i5ktPh+JSUhFil8RLJgf4qoXcmmWQaqnhvzjF+CLSLJyk=
X-Received: by 2002:a17:90b:3952:b0:340:d1b5:bfda with SMTP id
 98e67ed59e1d1-340d1b5c124mr8302847a91.3.1762161985250; Mon, 03 Nov 2025
 01:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251030100025.95113-1-eperezma@redhat.com> <20251030100025.95113-6-eperezma@redhat.com>
 <CACycT3sYzQM88dkqHiT-g9eRtfo-8PjW7XcRtZ=5q++=By4RVw@mail.gmail.com>
 <CAJaqyWexPHJiZjC+RPvVH4J6gS55fCOfPQmKay2eWO-nqrjcRQ@mail.gmail.com>
 <CACycT3v4zp_uDRA6ELwcZB287TYLsJfx34EepAhSRJ+w6B0hvw@mail.gmail.com>
 <CAJaqyWe31w=Z--Sh6ufwvhaBsBaKypUjHzLy9qm6NyDJM-NgDQ@mail.gmail.com>
 <CACycT3sKofWfottqAzRWscCWNaodnqXiFtvuhSv7Pqz1F0+90A@mail.gmail.com>
 <CAJaqyWdzeOsTG2YT3wJCuoFMffDmGXAsPp4GwL+Jq1h-O8h9SQ@mail.gmail.com>
 <CACycT3u4AS3=8sQuDhLWoyg5ExTPyfDf8GTB23pAepGZizMBhQ@mail.gmail.com>
 <CAJaqyWdaHE70L9csnWq5NekdxEvyJz=QO7xat7N_ZeqD7meiSg@mail.gmail.com> <CACycT3uOee8Mkf6C08-gfscDgtuChtMHSvfx8W7UxaPt3bE+Cg@mail.gmail.com>
In-Reply-To: <CACycT3uOee8Mkf6C08-gfscDgtuChtMHSvfx8W7UxaPt3bE+Cg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 3 Nov 2025 17:26:13 +0800
X-Gm-Features: AWmQ_bnjCX4W7AX7sFLbIrutfqyqxVDMM7jb9C9jQHBN17SPDtKeEX8CZvIU11w
Message-ID: <CACGkMEvRQ86dYeY3Enqoj1vkSpefU3roq4XGS+y5B5kmsXEkYg@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Yongji Xie <xieyongji@bytedance.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Hzl9FMOUfCRT24ehEaGRpeH1C-DDn-CK49a4fl98_I_1762161986
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 4:56=E2=80=AFPM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> On Mon, Nov 3, 2025 at 4:20=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Mon, Nov 3, 2025 at 8:13=E2=80=AFAM Yongji Xie <xieyongji@bytedance.=
com> wrote:
> > >
> > > On Mon, Nov 3, 2025 at 2:41=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Mon, Nov 3, 2025 at 3:55=E2=80=AFAM Yongji Xie <xieyongji@byteda=
nce.com> wrote:
> > > > >
> > > > > On Fri, Oct 31, 2025 at 10:09=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 31, 2025 at 8:01=E2=80=AFAM Yongji Xie <xieyongji@b=
ytedance.com> wrote:
> > > > > > >
> > > > > > > On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
> > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyon=
gji@bytedance.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9re=
z <eperezma@redhat.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Add support for assigning Address Space Identifiers (AS=
IDs) to each VQ
> > > > > > > > > > group.  This enables mapping each group into a distinct=
 memory space.
> > > > > > > > > >
> > > > > > > > > > Now that the driver can change ASID in the middle of op=
eration, the
> > > > > > > > > > domain that each vq address point is also protected by =
domain_lock.
> > > > > > > > > >
> > > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > > ---
> > > > > > > > > > v8:
> > > > > > > > > > * Revert the mutex to rwlock change, it needs proper pr=
ofiling to
> > > > > > > > > >   justify it.
> > > > > > > > > >
> > > > > > > > > > v7:
> > > > > > > > > > * Take write lock in the error path (Jason).
> > > > > > > > > >
> > > > > > > > > > v6:
> > > > > > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_=
API_VERSION_1) ?/
> > > > > > > > > >   (MST).
> > > > > > > > > > * Fix struct name not matching in the doc.
> > > > > > > > > >
> > > > > > > > > > v5:
> > > > > > > > > > * Properly return errno if copy_to_user returns >0 in V=
DUSE_IOTLB_GET_FD
> > > > > > > > > >   ioctl (Jason).
> > > > > > > > > > * Properly set domain bounce size to divide equally bet=
ween nas (Jason).
> > > > > > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > > > > > >   vduse_dev_request.
> > > > > > > > > >
> > > > > > > > > > v4:
> > > > > > > > > > * Divide each domain bounce size between the device bou=
nce size (Jason).
> > > > > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > > > > * Change if (x && (y || z)) return to if (x) { if (y) r=
eturn; if (z)
> > > > > > > > > >   return; } (Jason)
> > > > > > > > > > * Change a bad multiline comment, using @ caracter inst=
ead of * (Jason).
> > > > > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > > > > >
> > > > > > > > > > v3:
> > > > > > > > > > * Get the vduse domain through the vduse_as in the map =
functions
> > > > > > > > > >   (Jason).
> > > > > > > > > > * Squash with the patch creating the vduse_as struct (J=
ason).
> > > > > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a=
 magic number
> > > > > > > > > >   (Jason)
> > > > > > > > > >
> > > > > > > > > > v2:
> > > > > > > > > > * Convert the use of mutex to rwlock.
> > > > > > > > > >
> > > > > > > > > > RFC v3:
> > > > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It wa=
s set to a lower
> > > > > > > > > >   value to reduce memory consumption, but vqs are alrea=
dy limited to
> > > > > > > > > >   that value and userspace VDUSE is able to allocate th=
at many vqs.
> > > > > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl wi=
th
> > > > > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > > > > > * Move the umem mutex to asid struct so there is no con=
tention between
> > > > > > > > > >   ASIDs.
> > > > > > > > > >
> > > > > > > > > > RFC v2:
> > > > > > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2=
 so the first
> > > > > > > > > >   part of the struct is the same.
> > > > > > > > > > ---
> > > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 +++++++++++++=
+++++++---------
> > > > > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > > > > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drive=
rs/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > index 97be04f73fbf..c6909d73d06d 100644
> > > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > @@ -41,6 +41,7 @@
> > > > > > > > > >
> > > > > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > > > > @@ -86,7 +87,14 @@ struct vduse_umem {
> > > > > > > > > >         struct mm_struct *mm;
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > > +struct vduse_as {
> > > > > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > > > > +       struct vduse_umem *umem;
> > > > > > > > > > +       struct mutex mem_lock;
> > > > > > > > > > +};
> > > > > > > > > > +
> > > > > > > > > >  struct vduse_vq_group {
> > > > > > > > > > +       struct vduse_as *as;
> > > > > > > > > >         struct vduse_dev *dev;
> > > > > > > > > >  };
> > > > > > > > > >
> > > > > > > > > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > > > > > > > > >         struct vduse_vdpa *vdev;
> > > > > > > > > >         struct device *dev;
> > > > > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > > > > +       struct vduse_as *as;
> > > > > > > > > >         char *name;
> > > > > > > > > >         struct mutex lock;
> > > > > > > > > >         spinlock_t msg_lock;
> > > > > > > > > > @@ -122,9 +130,8 @@ struct vduse_dev {
> > > > > > > > > >         u32 vq_num;
> > > > > > > > > >         u32 vq_align;
> > > > > > > > > >         u32 ngroups;
> > > > > > > > > > -       struct vduse_umem *umem;
> > > > > > > > > > +       u32 nas;
> > > > > > > > > >         struct vduse_vq_group *groups;
> > > > > > > > > > -       struct mutex mem_lock;
> > > > > > > > > >         unsigned int bounce_size;
> > > > > > > > > >         struct mutex domain_lock;
> > > > > > > > > >  };
> > > > > > > > > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(str=
uct vduse_dev *dev, u8 status)
> > > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *de=
v,
> > > > > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *de=
v, u32 asid,
> > > > > > > > > >                                   u64 start, u64 last)
> > > > > > > > > >  {
> > > > > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(=
struct vduse_dev *dev,
> > > > > > > > > >                 return -EINVAL;
> > > > > > > > > >
> > > > > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > > > > +       } else {
> > > > > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > > > > +       }
> > > > > > > > > >
> > > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > >  }
> > > > > > > > > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(st=
ruct file *file, poll_table *wait)
> > > > > > > > > >         return mask;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +/* Force set the asid to a vq group without a message =
to the VDUSE device */
> > > > > > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_de=
v *dev,
> > > > > > > > > > +                                      unsigned int gro=
up, unsigned int asid)
> > > > > > > > > > +{
> > > > > > > > > > +       mutex_lock(&dev->domain_lock);
> > > > > > > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > > > > > > +       mutex_unlock(&dev->domain_lock);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > > > > >  {
> > > > > > > > > >         int i;
> > > > > > > > > > -       struct vduse_iova_domain *domain =3D dev->domai=
n;
> > > > > > > > > >
> > > > > > > > > >         /* The coherent mappings are handled in vduse_d=
ev_free_coherent() */
> > > > > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > > > > +               struct vduse_iova_domain *domain =3D de=
v->as[i].domain;
> > > > > > > > > > +
> > > > > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > > > > +                       vduse_domain_reset_bounce_map(d=
omain);
> > > > > > > > > > +       }
> > > > > > > > > > +
> > > > > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > > > > > > >
> > > > > > > > > >         down_write(&dev->rwsem);
> > > > > > > > > >
> > > > > > > > > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_=
vq_map(struct vdpa_device *vdpa, u16 idx)
> > > > > > > > > >         return ret;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static int vduse_set_group_asid(struct vdpa_device *vd=
pa, unsigned int group,
> > > > > > > > > > +                               unsigned int asid)
> > > > > > > > > > +{
> > > > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > +       int r;
> > > > > > > > > > +
> > > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > > > > > +           group >=3D dev->ngroups || asid >=3D dev->n=
as)
> > > > > > > > > > +               return -EINVAL;
> > > > > > > > > > +
> > > > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > > > > +
> > > > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > +       if (r < 0)
> > > > > > > > > > +               return r;
> > > > > > > > > > +
> > > > > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > > > > > > +       return 0;
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device =
*vdpa, u16 idx,
> > > > > > > > > >                                 struct vdpa_vq_state *s=
tate)
> > > > > > > > > >  {
> > > > > > > > > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(str=
uct vdpa_device *vdpa,
> > > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > >         int ret;
> > > > > > > > > >
> > > > > > > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb=
);
> > > > > > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].doma=
in, iotlb);
> > > > > > > > > >         if (ret)
> > > > > > > > > >                 return ret;
> > > > > > > > > >
> > > > > > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLON=
G_MAX);
> > > > > > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL,=
 ULLONG_MAX);
> > > > > > > > > >         if (ret) {
> > > > > > > > > > -               vduse_domain_clear_map(dev->domain, iot=
lb);
> > > > > > > > > > +               vduse_domain_clear_map(dev->as[asid].do=
main, iotlb);
> > > > > > > > > >                 return ret;
> > > > > > > > > >         }
> > > > > > > > > >
> > > > > > > > > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops=
 vduse_vdpa_config_ops =3D {
> > > > > > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_a=
ffinity,
> > > > > > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > > > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > > > > > > +       .set_group_asid         =3D vduse_set_group_asi=
d,
> > > > > > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > > > > > >  };
> > > > > > > > > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_=
for_device(union virtio_map token,
> > > > > > > > > >                 return;
> > > > > > > > > >
> > > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > > -
> > > > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > > > > +       domain =3D token.group->as->domain;
> > > > > > > > > >         vduse_domain_sync_single_for_device(domain, dma=
_addr, size, dir);
> > > > > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  static void vduse_dev_sync_single_for_cpu(union virtio=
_map token,
> > > > > > > > > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_=
for_cpu(union virtio_map token,
> > > > > > > > > >                 return;
> > > > > > > > > >
> > > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > > -
> > > > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > > > > +       domain =3D token.group->as->domain;
> > > > > > > > > >         vduse_domain_sync_single_for_cpu(domain, dma_ad=
dr, size, dir);
> > > > > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > >  static dma_addr_t vduse_dev_map_page(union virtio_map =
token, struct page *page,
> > > > > > > > > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_p=
age(union virtio_map token, struct page *page,
> > > > > > > > > >  {
> > > > > > > > > >         struct vduse_dev *vdev;
> > > > > > > > > >         struct vduse_iova_domain *domain;
> > > > > > > > > > +       dma_addr_t r;
> > > > > > > > > >
> > > > > > > > > >         if (!token.group)
> > > > > > > > > >                 return DMA_MAPPING_ERROR;
> > > > > > > > > >
> > > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > > >
> > > > > > > > > The mutex_lock can't be used here since the dma ops might=
 be called in
> > > > > > > > > atomic context. And I think we can just remove it since c=
reation and
> > > > > > > > > deletion operations of the iova domain are guaranteed not=
 to execute
> > > > > > > > > concurrently with I/O operations.
> > > > > > > > >
> > > > > > > >
> > > > > > > > That would be great indeed! Can you expand on this, what pr=
otects here
> > > > > > > > from the moment the two syscalls are issues from userland?
> > > > > > > >
> > > > > > >
> > > > > > > The domain mutex lock is introduced in commit
> > > > > > > d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iova =
domain
> > > > > > > creation"). It's used to prevent concurrent execution between
> > > > > > > vdpa_dev_add() and some vduse device ioctl which needs to acc=
ess the
> > > > > > > iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But the =
dma ops
> > > > > > > would not be called until vdpa_dev_add() completed, so the mu=
tex lock
> > > > > > > is not needed.
> > > > > > >
> > > > > >
> > > > > > Yes, but the usage is extended here to also protect from concur=
rent
> > > > > > calls to vduse_dev_map_page and vduse_set_group_asid or similar=
.
> > > > > >
> > > > > > So I guess the best is to replace it with a spinlock or RCU.
> > > > > >
> > > > >
> > > > > OK, I see, we simply aim to prevent concurrent access to the grou=
p->as
> > > > > variable here. But I wonder if the .set_group_asid function can b=
e
> > > > > called during I/O.
> > > >
> > > > At least a malicious userland app could do it.
> > > >
> > > > > I think the unmap_page() would fail if we change
> > > > > the group->as between map_page() and unmap_page().

It's better for the VUDSE to prepare for this.

> > > >
> > > > I guess a SIGSEGV or similar could be a valid outcome of that, but =
we
> > > > need to protect the "as" pointer anyway.

SIGSEGV is probably not suitable for the case of map/unmap as they
might be executed in bh.

> > > >
> > > > > Besides, it seems
> > > > > that .set_group_asid is only called in the vhost-vdpa case curren=
tly,
> > > > > but the dma ops such as map_page/unmap_page only service the
> > > > > virtio-vdpa case, so they would not be called concurrently with
> > > > > .set_group_asid now.
> > > > >
> > > >
> > > > That's totally true but a malicious app can do it anyway. So it is
> > > > better to protect it properly.
> > > >
> > >
> > > Actually there is no interface for userspace to call .set_group_asid
> > > if the vduse device is binded to the virtio-vdpa driver.
> > >
> >
> > It is possible from vhost-vdpa.
> >
>
> Then there is no interface for userspace to call dma_ops such as
> map_page/unmap_page if the device is binded to the vhost-vdpa driver.
>
> Thanks,
> Yongji
>

Right now, but we can't say that for the future drivers. Unless we
have a guard in the vdpa core, we probably need to prepare for that.

Thanks

