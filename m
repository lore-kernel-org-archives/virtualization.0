Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD182DAFD8
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158026; cv=none; b=OSDLAaitIFzEGi7LTThVd3VfYOKam98xDybtUJMzm/HLr2pX//lRSXriFPImdrW+SiJafbIaKAGkseAgr8AG1ODo2J4wXz5K08HfgaF/dU1grQEqU/WdGX3QCBU3cMWQNABiYut9j1jC3FsqY2qQokyi2y9zGHaTBMY019Sc6oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158026; c=relaxed/simple;
	bh=LZCwnmKeNC+3saGRUSGeFwOizRBIEdarhU0Eec2yur0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j07CWuPYITqVKngwM2X0rTrDMZIOsknjZxDlXasWyOrzvXbkPLh3o+b9eRbq55migO+WcCW0nxYZqwMiSHeFO5EHUcpav3uwQtspuWOOnr59FoaqROHYcjbgrColR8EoG5SG1xNIGMuI2X1pRpjZBFdWC9OIy1GgADyc81qPr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hBtEVLEL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBtEVLEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762158023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rbg9oZ9IB1DWkUdRnK51qmALoHEEFExBlfTZu03JcXs=;
	b=hBtEVLELBTCb8KK7zpCnAvhcfUoNiTB6rG1CapXXeteH8XV/3Hpiphd7QYtIU/n+WnUyEP
	RGeucqs/leOCnEBT19il02bcGtQJP00pb03m+H9P/7nX9yA6Jf/1urccqL7aqqfIgb7aVW
	yQ/PUd0xWDPeCYZ3n0tWt50wqHmYw3U=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-FkqZIwd1NTi-a_Tzkrxxiw-1; Mon, 03 Nov 2025 03:20:21 -0500
X-MC-Unique: FkqZIwd1NTi-a_Tzkrxxiw-1
X-Mimecast-MFC-AGG-ID: FkqZIwd1NTi-a_Tzkrxxiw_1762158020
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-786527e82caso32884867b3.3
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 00:20:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762158020; x=1762762820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbg9oZ9IB1DWkUdRnK51qmALoHEEFExBlfTZu03JcXs=;
        b=wlSH1AeoEH9zOEFMXRw1fkhrja24XnTKv3nZN6xs5ovpXG4ZIjE2uVK/D0UWsAofPi
         RgYZqsRgpmAaBOPZBmnjbGFVMkDEt4FGCAMqYxYdtRvtOQeBYi1x4Bkch/jmk7kibkl5
         ARLpQBNchmJ7xAgxEKP/EkwjL976CZvlZBzCrM2LgWU/nWtnuXcT8NjMH3f0LCNUcFGl
         I68CY243faLwr0ypGZCfDgrgjZc3qyyfjI55vfOgjWDjXMmTfFiJ5gTEmR6rHOyJ6nsy
         OH+VnwZdACBgJ5kMW5WS6j5+rT36ew8ArqBqDNu1ZBFndznQbDe3orIk216s+YYNCSoA
         PX8g==
X-Forwarded-Encrypted: i=1; AJvYcCU7FUYi5uJ3ye5gijfDy7mEEI4mBAIUYQHPdNS2zfiWRQiacu5PJAOoL3MgOuEDjAFmRll31JK2iKnZdAJ4ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzXCtOtwPb/A0Nnqd5qAOxiDcOZfJhzSaULqjPoGtwNkM31oWC
	Zh0QRbYDKAE42QAV/5tIeUtcc4dauPXys3UVizhbuyvRJ+GqK06Qf43s6nSZ0/xOI7r1qz2AySz
	+wgbdOhbwrSMzPQ0KywDLo8TY3UGay76og4OocC4d5W0YSij63Bxy0FnX043zBTQi9oSKAdVuN3
	FpWNyrQnPXI8kjWmUc+GF0cuOKPc5qVugc5EqkxLUI8LU=
X-Gm-Gg: ASbGnctXqnJ0sPgqGyXLoZUjT609b27onLMcbuliRNzEHR/2ZCZHhKdnh73HpwfKZzs
	EjYSunJi27uZtVsCE6SkmgxELtYMV0ddArp/RWq5bE2FaWiYlGn4dbewOLAlODN5959r28vmW9r
	o95KnprvAeFNoXZ8lgq918fdzJh0lf82gXhLYzu5SPb0BRBdieckr5YfLx
X-Received: by 2002:a05:690c:9b0a:b0:780:ff13:23a7 with SMTP id 00721157ae682-786483ea6a8mr93664877b3.14.1762158020379;
        Mon, 03 Nov 2025 00:20:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeAPcS34zw7sYBHFeuJbf2+eR1SPlDOen1ZYjk5//zlDm3QWSzwpAbfdtsCeGdG3+SQs2T/P1d+acZQcfe1T0=
X-Received: by 2002:a05:690c:9b0a:b0:780:ff13:23a7 with SMTP id
 00721157ae682-786483ea6a8mr93664627b3.14.1762158019902; Mon, 03 Nov 2025
 00:20:19 -0800 (PST)
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
 <CAJaqyWdzeOsTG2YT3wJCuoFMffDmGXAsPp4GwL+Jq1h-O8h9SQ@mail.gmail.com> <CACycT3u4AS3=8sQuDhLWoyg5ExTPyfDf8GTB23pAepGZizMBhQ@mail.gmail.com>
In-Reply-To: <CACycT3u4AS3=8sQuDhLWoyg5ExTPyfDf8GTB23pAepGZizMBhQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 3 Nov 2025 09:19:42 +0100
X-Gm-Features: AWmQ_bmiZDwamhjHRBmWwj5XgNmlGhZffnHyo5jp86ZA_jUwmocJUJnHCfyvGv8
Message-ID: <CAJaqyWdaHE70L9csnWq5NekdxEvyJz=QO7xat7N_ZeqD7meiSg@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Yongji Xie <xieyongji@bytedance.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZUzi3fOFDWdUaJqc4gD1umz2GgBn1oJ4w7WPlaWbq50_1762158020
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:13=E2=80=AFAM Yongji Xie <xieyongji@bytedance.com>=
 wrote:
>
> On Mon, Nov 3, 2025 at 2:41=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Mon, Nov 3, 2025 at 3:55=E2=80=AFAM Yongji Xie <xieyongji@bytedance.=
com> wrote:
> > >
> > > On Fri, Oct 31, 2025 at 10:09=E2=80=AFPM Eugenio Perez Martin
> > > <eperezma@redhat.com> wrote:
> > > >
> > > > On Fri, Oct 31, 2025 at 8:01=E2=80=AFAM Yongji Xie <xieyongji@byted=
ance.com> wrote:
> > > > >
> > > > > On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
> > > > > <eperezma@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongji@=
bytedance.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez <e=
perezma@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Add support for assigning Address Space Identifiers (ASIDs)=
 to each VQ
> > > > > > > > group.  This enables mapping each group into a distinct mem=
ory space.
> > > > > > > >
> > > > > > > > Now that the driver can change ASID in the middle of operat=
ion, the
> > > > > > > > domain that each vq address point is also protected by doma=
in_lock.
> > > > > > > >
> > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > ---
> > > > > > > > v8:
> > > > > > > > * Revert the mutex to rwlock change, it needs proper profil=
ing to
> > > > > > > >   justify it.
> > > > > > > >
> > > > > > > > v7:
> > > > > > > > * Take write lock in the error path (Jason).
> > > > > > > >
> > > > > > > > v6:
> > > > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_API_=
VERSION_1) ?/
> > > > > > > >   (MST).
> > > > > > > > * Fix struct name not matching in the doc.
> > > > > > > >
> > > > > > > > v5:
> > > > > > > > * Properly return errno if copy_to_user returns >0 in VDUSE=
_IOTLB_GET_FD
> > > > > > > >   ioctl (Jason).
> > > > > > > > * Properly set domain bounce size to divide equally between=
 nas (Jason).
> > > > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > > > >   vduse_dev_request.
> > > > > > > >
> > > > > > > > v4:
> > > > > > > > * Divide each domain bounce size between the device bounce =
size (Jason).
> > > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > > * Change if (x && (y || z)) return to if (x) { if (y) retur=
n; if (z)
> > > > > > > >   return; } (Jason)
> > > > > > > > * Change a bad multiline comment, using @ caracter instead =
of * (Jason).
> > > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > > >
> > > > > > > > v3:
> > > > > > > > * Get the vduse domain through the vduse_as in the map func=
tions
> > > > > > > >   (Jason).
> > > > > > > > * Squash with the patch creating the vduse_as struct (Jason=
).
> > > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a mag=
ic number
> > > > > > > >   (Jason)
> > > > > > > >
> > > > > > > > v2:
> > > > > > > > * Convert the use of mutex to rwlock.
> > > > > > > >
> > > > > > > > RFC v3:
> > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was se=
t to a lower
> > > > > > > >   value to reduce memory consumption, but vqs are already l=
imited to
> > > > > > > >   that value and userspace VDUSE is able to allocate that m=
any vqs.
> > > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > > > * Move the umem mutex to asid struct so there is no content=
ion between
> > > > > > > >   ASIDs.
> > > > > > > >
> > > > > > > > RFC v2:
> > > > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 so =
the first
> > > > > > > >   part of the struct is the same.
> > > > > > > > ---
> > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 +++++++++++++++++=
+++---------
> > > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/v=
dpa/vdpa_user/vduse_dev.c
> > > > > > > > index 97be04f73fbf..c6909d73d06d 100644
> > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > @@ -41,6 +41,7 @@
> > > > > > > >
> > > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > > @@ -86,7 +87,14 @@ struct vduse_umem {
> > > > > > > >         struct mm_struct *mm;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > +struct vduse_as {
> > > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > > +       struct vduse_umem *umem;
> > > > > > > > +       struct mutex mem_lock;
> > > > > > > > +};
> > > > > > > > +
> > > > > > > >  struct vduse_vq_group {
> > > > > > > > +       struct vduse_as *as;
> > > > > > > >         struct vduse_dev *dev;
> > > > > > > >  };
> > > > > > > >
> > > > > > > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > > > > > > >         struct vduse_vdpa *vdev;
> > > > > > > >         struct device *dev;
> > > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > > +       struct vduse_as *as;
> > > > > > > >         char *name;
> > > > > > > >         struct mutex lock;
> > > > > > > >         spinlock_t msg_lock;
> > > > > > > > @@ -122,9 +130,8 @@ struct vduse_dev {
> > > > > > > >         u32 vq_num;
> > > > > > > >         u32 vq_align;
> > > > > > > >         u32 ngroups;
> > > > > > > > -       struct vduse_umem *umem;
> > > > > > > > +       u32 nas;
> > > > > > > >         struct vduse_vq_group *groups;
> > > > > > > > -       struct mutex mem_lock;
> > > > > > > >         unsigned int bounce_size;
> > > > > > > >         struct mutex domain_lock;
> > > > > > > >  };
> > > > > > > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struct =
vduse_dev *dev, u8 status)
> > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > >  }
> > > > > > > >
> > > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev, u=
32 asid,
> > > > > > > >                                   u64 start, u64 last)
> > > > > > > >  {
> > > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(stru=
ct vduse_dev *dev,
> > > > > > > >                 return -EINVAL;
> > > > > > > >
> > > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > > +       } else {
> > > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > > +       }
> > > > > > > >
> > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > >  }
> > > > > > > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(struct=
 file *file, poll_table *wait)
> > > > > > > >         return mask;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +/* Force set the asid to a vq group without a message to t=
he VDUSE device */
> > > > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev *d=
ev,
> > > > > > > > +                                      unsigned int group, =
unsigned int asid)
> > > > > > > > +{
> > > > > > > > +       mutex_lock(&dev->domain_lock);
> > > > > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > > > > +       mutex_unlock(&dev->domain_lock);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > > >  {
> > > > > > > >         int i;
> > > > > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > > > > >
> > > > > > > >         /* The coherent mappings are handled in vduse_dev_f=
ree_coherent() */
> > > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > > +               struct vduse_iova_domain *domain =3D dev->a=
s[i].domain;
> > > > > > > > +
> > > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > > +                       vduse_domain_reset_bounce_map(domai=
n);
> > > > > > > > +       }
> > > > > > > > +
> > > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > > > > >
> > > > > > > >         down_write(&dev->rwsem);
> > > > > > > >
> > > > > > > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq_m=
ap(struct vdpa_device *vdpa, u16 idx)
> > > > > > > >         return ret;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa, =
unsigned int group,
> > > > > > > > +                               unsigned int asid)
> > > > > > > > +{
> > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > +       int r;
> > > > > > > > +
> > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas)
> > > > > > > > +               return -EINVAL;
> > > > > > > > +
> > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > > +
> > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > +       if (r < 0)
> > > > > > > > +               return r;
> > > > > > > > +
> > > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *vdp=
a, u16 idx,
> > > > > > > >                                 struct vdpa_vq_state *state=
)
> > > > > > > >  {
> > > > > > > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struct =
vdpa_device *vdpa,
> > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > >         int ret;
> > > > > > > >
> > > > > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain, =
iotlb);
> > > > > > > >         if (ret)
> > > > > > > >                 return ret;
> > > > > > > >
> > > > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MA=
X);
> > > > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, ULL=
ONG_MAX);
> > > > > > > >         if (ret) {
> > > > > > > > -               vduse_domain_clear_map(dev->domain, iotlb);
> > > > > > > > +               vduse_domain_clear_map(dev->as[asid].domain=
, iotlb);
> > > > > > > >                 return ret;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops vdu=
se_vdpa_config_ops =3D {
> > > > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_affin=
ity,
> > > > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > > > >  };
> > > > > > > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_for_=
device(union virtio_map token,
> > > > > > > >                 return;
> > > > > > > >
> > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > -
> > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > > +       domain =3D token.group->as->domain;
> > > > > > > >         vduse_domain_sync_single_for_device(domain, dma_add=
r, size, dir);
> > > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static void vduse_dev_sync_single_for_cpu(union virtio_map=
 token,
> > > > > > > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_for_=
cpu(union virtio_map token,
> > > > > > > >                 return;
> > > > > > > >
> > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > -
> > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > > +       domain =3D token.group->as->domain;
> > > > > > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr, =
size, dir);
> > > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static dma_addr_t vduse_dev_map_page(union virtio_map toke=
n, struct page *page,
> > > > > > > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_page(=
union virtio_map token, struct page *page,
> > > > > > > >  {
> > > > > > > >         struct vduse_dev *vdev;
> > > > > > > >         struct vduse_iova_domain *domain;
> > > > > > > > +       dma_addr_t r;
> > > > > > > >
> > > > > > > >         if (!token.group)
> > > > > > > >                 return DMA_MAPPING_ERROR;
> > > > > > > >
> > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > >
> > > > > > > The mutex_lock can't be used here since the dma ops might be =
called in
> > > > > > > atomic context. And I think we can just remove it since creat=
ion and
> > > > > > > deletion operations of the iova domain are guaranteed not to =
execute
> > > > > > > concurrently with I/O operations.
> > > > > > >
> > > > > >
> > > > > > That would be great indeed! Can you expand on this, what protec=
ts here
> > > > > > from the moment the two syscalls are issues from userland?
> > > > > >
> > > > >
> > > > > The domain mutex lock is introduced in commit
> > > > > d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iova doma=
in
> > > > > creation"). It's used to prevent concurrent execution between
> > > > > vdpa_dev_add() and some vduse device ioctl which needs to access =
the
> > > > > iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But the dma =
ops
> > > > > would not be called until vdpa_dev_add() completed, so the mutex =
lock
> > > > > is not needed.
> > > > >
> > > >
> > > > Yes, but the usage is extended here to also protect from concurrent
> > > > calls to vduse_dev_map_page and vduse_set_group_asid or similar.
> > > >
> > > > So I guess the best is to replace it with a spinlock or RCU.
> > > >
> > >
> > > OK, I see, we simply aim to prevent concurrent access to the group->a=
s
> > > variable here. But I wonder if the .set_group_asid function can be
> > > called during I/O.
> >
> > At least a malicious userland app could do it.
> >
> > > I think the unmap_page() would fail if we change
> > > the group->as between map_page() and unmap_page().
> >
> > I guess a SIGSEGV or similar could be a valid outcome of that, but we
> > need to protect the "as" pointer anyway.
> >
> > > Besides, it seems
> > > that .set_group_asid is only called in the vhost-vdpa case currently,
> > > but the dma ops such as map_page/unmap_page only service the
> > > virtio-vdpa case, so they would not be called concurrently with
> > > .set_group_asid now.
> > >
> >
> > That's totally true but a malicious app can do it anyway. So it is
> > better to protect it properly.
> >
>
> Actually there is no interface for userspace to call .set_group_asid
> if the vduse device is binded to the virtio-vdpa driver.
>

It is possible from vhost-vdpa.

