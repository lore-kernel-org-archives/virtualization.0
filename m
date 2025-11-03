Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA451296BAB
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163148; cv=none; b=jGVgwxBhAnZvv5l2jAur1yz7y2SiXaec//9rJ0VIZC+ia1K7A0/T0xlFtpiCYoL6fKZzdhyIa5CDPrd1TBrdrIp3MCHRn7hLz2Ih/RTephPmwwQuFgsTlMR7dILcJu7d07vqOoOgMh51Wd7Z9IfO+9vFzbjQtYbr0oL3IF7fllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163148; c=relaxed/simple;
	bh=IDC5FBlxA06MLkHrdLa6UGtn0D0SbBC7p+XQpTexeo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0Kjm5I7ydw5gjat/Hu2cDe/aMKoj2JRVdybNmsZ/lJHOAd6eK8jiUVp+hjhsNE0M/pZCju4H+lQyDUnpD4steVxIj9wDh0Wa6j31DOHttQRSCFQHzzg4IgN2SQmFJN3IYEoXM6JHlSBDf9nW63otU6xt1irhgx2ggppa06bcGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IYOKuiwH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IYOKuiwH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27c369f8986so42578025ad.3
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 01:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762163145; x=1762767945; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1Mu6Hx9wKi32buCt969qXiJuPrnVmBZjMavJ+n6F+Q=;
        b=IYOKuiwHoRR6kOQO0qc37gdiEtRVBF8wa7BBls4AQGYKOzCVXx69LtCERd1InRl/ep
         T56Ng857Jw5/wFHG2NzPt8bNXG8e91QY+n0r2ET7cbzmjJubbsw+OJUtKX33nmny5W9w
         02XcWCseF5PEVbfV/FW+xqpxv0QpMufMHp7GdbBjKz1cOScoOiZRQh4Eub7R0q7X/x3Q
         oKtRQor5EL1SKdt189Mtia/CtcEQjnLTGD5kLn8qjuL9fNbG/LN/FJH/VJYorXaPmpIZ
         C+UJEnvpkwwWMq/qy8mTZSTJYie2Q01vWFqDxjWFRdL7VDPdjaZ0ww0vfHJhosrYGfjv
         NYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163145; x=1762767945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1Mu6Hx9wKi32buCt969qXiJuPrnVmBZjMavJ+n6F+Q=;
        b=Tbbi2sVFmklFJ2v9PWxFhLVqc7gMr9LApOhww3WuWG5qSwhRLGBIds9JjDdMTTzOA7
         fEpu+Vi1Zoi2gRK0/7gRTdOIKOPOfisPPu6p+TAUmWh0X6kBltO1Z36T/1kjcR41CC2F
         YvzB4JqwQ1qK4mN1PvtZKHAoy6ph1dSCP/rwtnpyQJkBYYqDNpCTBCWL9cEP/Vs4V12L
         OZArDRyy4kHng84H8P6+3Zs8CuoX5NTcTE4FrZ/D4Qh1izzZq+NbSp0p2xyg9nHRA2hh
         8ga5Skp8+kYlrvGh/P1wW2hmUsZBkWwwCwrwPXa5bS1sGNpmARHgDivPAxqijLsbiAmz
         /Ffg==
X-Forwarded-Encrypted: i=1; AJvYcCVBk0bgQfRTQrfpZQ6BWPVfGsRgwpg2sq00ruRRju3Ix16agQ4j6vT/QSWV796+bY2ThU1lTtbm2Ii+ZH0xRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtCMNyr5O/QOcb94NDGqZ9qbAko4DkCy/sQZeyrYNz0nVzUZxs
	jhgoGnMQ/8/3Pm16HBAfQ63Kfz3be6N2YZjgijimKAQ7149r5Y0veeH7p4XupZCACZnkAW9h5GB
	vAKtJW7aUK2Bl5tEGr7RP+rvHoe2SrhEWXGDpUFrt
X-Gm-Gg: ASbGncsCcAFwMpQJnuskvc76Rlp0siT5nwYeuJgJSKeQUa0GmiNTcC4GHkiqr+b1K/n
	xCHB4eFBpA+tdJ4AQrpEIPbgWoLcRouYMDtSspmnt+F/k8NTwbFokBpmWbGB+k6eSziHo/2tkrs
	xxnOo7P0C7BgWYV0v/qSZ7o/gV57+KFo8wtjV3Nh33X5Cca6aDUTI2eNlJMOV2Duk4aaoPgv8qf
	HmoPy7voLGzPWsI/hE6Ddi9cK+nDparx950xTyX2ovWzw4UiF7coUYAgAHZFlter0QOS2Oomys1
	S2F2mEzt+PaGSFzNSn///qOz7Jrd
X-Google-Smtp-Source: AGHT+IH/nq0BNZ6gYBlDDkGyMfVl8bwpsVavL0P4SI7GFL8DKXWKLTuMwpF8zYPSJdCPMvUcWk870B1+4wt3Vtpbfuc=
X-Received: by 2002:a17:903:41ce:b0:295:745a:8016 with SMTP id
 d9443c01a7336-295745a855amr83821125ad.11.1762163144639; Mon, 03 Nov 2025
 01:45:44 -0800 (PST)
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
 <CAJaqyWdaHE70L9csnWq5NekdxEvyJz=QO7xat7N_ZeqD7meiSg@mail.gmail.com>
 <CACycT3uOee8Mkf6C08-gfscDgtuChtMHSvfx8W7UxaPt3bE+Cg@mail.gmail.com> <CACGkMEvRQ86dYeY3Enqoj1vkSpefU3roq4XGS+y5B5kmsXEkYg@mail.gmail.com>
In-Reply-To: <CACGkMEvRQ86dYeY3Enqoj1vkSpefU3roq4XGS+y5B5kmsXEkYg@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 3 Nov 2025 17:45:33 +0800
X-Gm-Features: AWmQ_bkJT_zhp7oSoeGtJOcaSZ7APPP9yn2DoMglDm_fFvgj5fpt374DTXDLLZU
Message-ID: <CACycT3suYWFz9vKBR0ojenYBuG_75jMcyc1a-OUJ0BSTWs50KQ@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Jason Wang <jasowang@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 5:26=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Nov 3, 2025 at 4:56=E2=80=AFPM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Mon, Nov 3, 2025 at 4:20=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Mon, Nov 3, 2025 at 8:13=E2=80=AFAM Yongji Xie <xieyongji@bytedanc=
e.com> wrote:
> > > >
> > > > On Mon, Nov 3, 2025 at 2:41=E2=80=AFPM Eugenio Perez Martin <eperez=
ma@redhat.com> wrote:
> > > > >
> > > > > On Mon, Nov 3, 2025 at 3:55=E2=80=AFAM Yongji Xie <xieyongji@byte=
dance.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 31, 2025 at 10:09=E2=80=AFPM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Oct 31, 2025 at 8:01=E2=80=AFAM Yongji Xie <xieyongji=
@bytedance.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Marti=
n
> > > > > > > > <eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xiey=
ongji@bytedance.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9=
rez <eperezma@redhat.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Add support for assigning Address Space Identifiers (=
ASIDs) to each VQ
> > > > > > > > > > > group.  This enables mapping each group into a distin=
ct memory space.
> > > > > > > > > > >
> > > > > > > > > > > Now that the driver can change ASID in the middle of =
operation, the
> > > > > > > > > > > domain that each vq address point is also protected b=
y domain_lock.
> > > > > > > > > > >
> > > > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.co=
m>
> > > > > > > > > > > ---
> > > > > > > > > > > v8:
> > > > > > > > > > > * Revert the mutex to rwlock change, it needs proper =
profiling to
> > > > > > > > > > >   justify it.
> > > > > > > > > > >
> > > > > > > > > > > v7:
> > > > > > > > > > > * Take write lock in the error path (Jason).
> > > > > > > > > > >
> > > > > > > > > > > v6:
> > > > > > > > > > > * Make vdpa_dev_add use gotos for error handling (MST=
).
> > > > > > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUS=
E_API_VERSION_1) ?/
> > > > > > > > > > >   (MST).
> > > > > > > > > > > * Fix struct name not matching in the doc.
> > > > > > > > > > >
> > > > > > > > > > > v5:
> > > > > > > > > > > * Properly return errno if copy_to_user returns >0 in=
 VDUSE_IOTLB_GET_FD
> > > > > > > > > > >   ioctl (Jason).
> > > > > > > > > > > * Properly set domain bounce size to divide equally b=
etween nas (Jason).
> > > > > > > > > > > * Exclude "padding" member from the only >V1 members =
in
> > > > > > > > > > >   vduse_dev_request.
> > > > > > > > > > >
> > > > > > > > > > > v4:
> > > > > > > > > > > * Divide each domain bounce size between the device b=
ounce size (Jason).
> > > > > > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > > > > > * Change if (x && (y || z)) return to if (x) { if (y)=
 return; if (z)
> > > > > > > > > > >   return; } (Jason)
> > > > > > > > > > > * Change a bad multiline comment, using @ caracter in=
stead of * (Jason).
> > > > > > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > > > > > >
> > > > > > > > > > > v3:
> > > > > > > > > > > * Get the vduse domain through the vduse_as in the ma=
p functions
> > > > > > > > > > >   (Jason).
> > > > > > > > > > > * Squash with the patch creating the vduse_as struct =
(Jason).
> > > > > > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains=
 a magic number
> > > > > > > > > > >   (Jason)
> > > > > > > > > > >
> > > > > > > > > > > v2:
> > > > > > > > > > > * Convert the use of mutex to rwlock.
> > > > > > > > > > >
> > > > > > > > > > > RFC v3:
> > > > > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It =
was set to a lower
> > > > > > > > > > >   value to reduce memory consumption, but vqs are alr=
eady limited to
> > > > > > > > > > >   that value and userspace VDUSE is able to allocate =
that many vqs.
> > > > > > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl =
with
> > > > > > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > > > > > > * Move the umem mutex to asid struct so there is no c=
ontention between
> > > > > > > > > > >   ASIDs.
> > > > > > > > > > >
> > > > > > > > > > > RFC v2:
> > > > > > > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_=
v2 so the first
> > > > > > > > > > >   part of the struct is the same.
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 +++++++++++=
+++++++++---------
> > > > > > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > > > > > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/dri=
vers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > > index 97be04f73fbf..c6909d73d06d 100644
> > > > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > > > @@ -41,6 +41,7 @@
> > > > > > > > > > >
> > > > > > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > > > > > @@ -86,7 +87,14 @@ struct vduse_umem {
> > > > > > > > > > >         struct mm_struct *mm;
> > > > > > > > > > >  };
> > > > > > > > > > >
> > > > > > > > > > > +struct vduse_as {
> > > > > > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > > > > > +       struct vduse_umem *umem;
> > > > > > > > > > > +       struct mutex mem_lock;
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > >  struct vduse_vq_group {
> > > > > > > > > > > +       struct vduse_as *as;
> > > > > > > > > > >         struct vduse_dev *dev;
> > > > > > > > > > >  };
> > > > > > > > > > >
> > > > > > > > > > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > > > > > > > > > >         struct vduse_vdpa *vdev;
> > > > > > > > > > >         struct device *dev;
> > > > > > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > > > > > +       struct vduse_as *as;
> > > > > > > > > > >         char *name;
> > > > > > > > > > >         struct mutex lock;
> > > > > > > > > > >         spinlock_t msg_lock;
> > > > > > > > > > > @@ -122,9 +130,8 @@ struct vduse_dev {
> > > > > > > > > > >         u32 vq_num;
> > > > > > > > > > >         u32 vq_align;
> > > > > > > > > > >         u32 ngroups;
> > > > > > > > > > > -       struct vduse_umem *umem;
> > > > > > > > > > > +       u32 nas;
> > > > > > > > > > >         struct vduse_vq_group *groups;
> > > > > > > > > > > -       struct mutex mem_lock;
> > > > > > > > > > >         unsigned int bounce_size;
> > > > > > > > > > >         struct mutex domain_lock;
> > > > > > > > > > >  };
> > > > > > > > > > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(s=
truct vduse_dev *dev, u8 status)
> > > > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *=
dev,
> > > > > > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *=
dev, u32 asid,
> > > > > > > > > > >                                   u64 start, u64 last=
)
> > > > > > > > > > >  {
> > > > > > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotl=
b(struct vduse_dev *dev,
> > > > > > > > > > >                 return -EINVAL;
> > > > > > > > > > >
> > > > > > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > > > > > +       } else {
> > > > > > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > > > > > +       }
> > > > > > > > > > >
> > > > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > >  }
> > > > > > > > > > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(=
struct file *file, poll_table *wait)
> > > > > > > > > > >         return mask;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +/* Force set the asid to a vq group without a messag=
e to the VDUSE device */
> > > > > > > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_=
dev *dev,
> > > > > > > > > > > +                                      unsigned int g=
roup, unsigned int asid)
> > > > > > > > > > > +{
> > > > > > > > > > > +       mutex_lock(&dev->domain_lock);
> > > > > > > > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > > > > > > > +       mutex_unlock(&dev->domain_lock);
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > > > > > >  {
> > > > > > > > > > >         int i;
> > > > > > > > > > > -       struct vduse_iova_domain *domain =3D dev->dom=
ain;
> > > > > > > > > > >
> > > > > > > > > > >         /* The coherent mappings are handled in vduse=
_dev_free_coherent() */
> > > > > > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > > > > > -               vduse_domain_reset_bounce_map(domain)=
;
> > > > > > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > > > > > +               struct vduse_iova_domain *domain =3D =
dev->as[i].domain;
> > > > > > > > > > > +
> > > > > > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > > > > > +                       vduse_domain_reset_bounce_map=
(domain);
> > > > > > > > > > > +       }
> > > > > > > > > > > +
> > > > > > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0)=
;
> > > > > > > > > > >
> > > > > > > > > > >         down_write(&dev->rwsem);
> > > > > > > > > > >
> > > > > > > > > > > @@ -623,6 +651,29 @@ static union virtio_map vduse_ge=
t_vq_map(struct vdpa_device *vdpa, u16 idx)
> > > > > > > > > > >         return ret;
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +static int vduse_set_group_asid(struct vdpa_device *=
vdpa, unsigned int group,
> > > > > > > > > > > +                               unsigned int asid)
> > > > > > > > > > > +{
> > > > > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa)=
;
> > > > > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > > > +       int r;
> > > > > > > > > > > +
> > > > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > > > > > > +           group >=3D dev->ngroups || asid >=3D dev-=
>nas)
> > > > > > > > > > > +               return -EINVAL;
> > > > > > > > > > > +
> > > > > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > > > > > +
> > > > > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > > > +       if (r < 0)
> > > > > > > > > > > +               return r;
> > > > > > > > > > > +
> > > > > > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > > > > > > > +       return 0;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_devic=
e *vdpa, u16 idx,
> > > > > > > > > > >                                 struct vdpa_vq_state =
*state)
> > > > > > > > > > >  {
> > > > > > > > > > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(s=
truct vdpa_device *vdpa,
> > > > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa)=
;
> > > > > > > > > > >         int ret;
> > > > > > > > > > >
> > > > > > > > > > > -       ret =3D vduse_domain_set_map(dev->domain, iot=
lb);
> > > > > > > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].do=
main, iotlb);
> > > > > > > > > > >         if (ret)
> > > > > > > > > > >                 return ret;
> > > > > > > > > > >
> > > > > > > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULL=
ONG_MAX);
> > > > > > > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0UL=
L, ULLONG_MAX);
> > > > > > > > > > >         if (ret) {
> > > > > > > > > > > -               vduse_domain_clear_map(dev->domain, i=
otlb);
> > > > > > > > > > > +               vduse_domain_clear_map(dev->as[asid].=
domain, iotlb);
> > > > > > > > > > >                 return ret;
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > > @@ -843,6 +894,7 @@ static const struct vdpa_config_o=
ps vduse_vdpa_config_ops =3D {
> > > > > > > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq=
_affinity,
> > > > > > > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > > > > > > >         .set_map                =3D vduse_vdpa_set_ma=
p,
> > > > > > > > > > > +       .set_group_asid         =3D vduse_set_group_a=
sid,
> > > > > > > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > > > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > > > > > > >  };
> > > > > > > > > > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_singl=
e_for_device(union virtio_map token,
> > > > > > > > > > >                 return;
> > > > > > > > > > >
> > > > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > > > -
> > > > > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > > > > > +       domain =3D token.group->as->domain;
> > > > > > > > > > >         vduse_domain_sync_single_for_device(domain, d=
ma_addr, size, dir);
> > > > > > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  static void vduse_dev_sync_single_for_cpu(union virt=
io_map token,
> > > > > > > > > > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_singl=
e_for_cpu(union virtio_map token,
> > > > > > > > > > >                 return;
> > > > > > > > > > >
> > > > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > > > -
> > > > > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > > > > > +       domain =3D token.group->as->domain;
> > > > > > > > > > >         vduse_domain_sync_single_for_cpu(domain, dma_=
addr, size, dir);
> > > > > > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > >  static dma_addr_t vduse_dev_map_page(union virtio_ma=
p token, struct page *page,
> > > > > > > > > > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map=
_page(union virtio_map token, struct page *page,
> > > > > > > > > > >  {
> > > > > > > > > > >         struct vduse_dev *vdev;
> > > > > > > > > > >         struct vduse_iova_domain *domain;
> > > > > > > > > > > +       dma_addr_t r;
> > > > > > > > > > >
> > > > > > > > > > >         if (!token.group)
> > > > > > > > > > >                 return DMA_MAPPING_ERROR;
> > > > > > > > > > >
> > > > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > > > >
> > > > > > > > > > The mutex_lock can't be used here since the dma ops mig=
ht be called in
> > > > > > > > > > atomic context. And I think we can just remove it since=
 creation and
> > > > > > > > > > deletion operations of the iova domain are guaranteed n=
ot to execute
> > > > > > > > > > concurrently with I/O operations.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > That would be great indeed! Can you expand on this, what =
protects here
> > > > > > > > > from the moment the two syscalls are issues from userland=
?
> > > > > > > > >
> > > > > > > >
> > > > > > > > The domain mutex lock is introduced in commit
> > > > > > > > d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iov=
a domain
> > > > > > > > creation"). It's used to prevent concurrent execution betwe=
en
> > > > > > > > vdpa_dev_add() and some vduse device ioctl which needs to a=
ccess the
> > > > > > > > iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But th=
e dma ops
> > > > > > > > would not be called until vdpa_dev_add() completed, so the =
mutex lock
> > > > > > > > is not needed.
> > > > > > > >
> > > > > > >
> > > > > > > Yes, but the usage is extended here to also protect from conc=
urrent
> > > > > > > calls to vduse_dev_map_page and vduse_set_group_asid or simil=
ar.
> > > > > > >
> > > > > > > So I guess the best is to replace it with a spinlock or RCU.
> > > > > > >
> > > > > >
> > > > > > OK, I see, we simply aim to prevent concurrent access to the gr=
oup->as
> > > > > > variable here. But I wonder if the .set_group_asid function can=
 be
> > > > > > called during I/O.
> > > > >
> > > > > At least a malicious userland app could do it.
> > > > >
> > > > > > I think the unmap_page() would fail if we change
> > > > > > the group->as between map_page() and unmap_page().
>
> It's better for the VUDSE to prepare for this.
>
> > > > >
> > > > > I guess a SIGSEGV or similar could be a valid outcome of that, bu=
t we
> > > > > need to protect the "as" pointer anyway.
>
> SIGSEGV is probably not suitable for the case of map/unmap as they
> might be executed in bh.
>
> > > > >
> > > > > > Besides, it seems
> > > > > > that .set_group_asid is only called in the vhost-vdpa case curr=
ently,
> > > > > > but the dma ops such as map_page/unmap_page only service the
> > > > > > virtio-vdpa case, so they would not be called concurrently with
> > > > > > .set_group_asid now.
> > > > > >
> > > > >
> > > > > That's totally true but a malicious app can do it anyway. So it i=
s
> > > > > better to protect it properly.
> > > > >
> > > >
> > > > Actually there is no interface for userspace to call .set_group_asi=
d
> > > > if the vduse device is binded to the virtio-vdpa driver.
> > > >
> > >
> > > It is possible from vhost-vdpa.
> > >
> >
> > Then there is no interface for userspace to call dma_ops such as
> > map_page/unmap_page if the device is binded to the vhost-vdpa driver.
> >
> > Thanks,
> > Yongji
> >
>
> Right now, but we can't say that for the future drivers. Unless we
> have a guard in the vdpa core, we probably need to prepare for that.
>

OK, then I think we can introduce a new RCU lock here which is hurtless.

Thanks,
Yongji
