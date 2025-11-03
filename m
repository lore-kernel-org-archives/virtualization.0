Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E872D7384
	for <virtualization@lists.linux.dev>; Mon,  3 Nov 2025 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160213; cv=none; b=pVDwpCNR18D/v4QmrjhsgdLz4hOt9TenPk0/8MxBLWhYg4UnxrXx8Jp+gHbO0ozu/cspEmlDbDBZRpp9fZUmt0RdYklIPCX1BCpZvFluIFoAn/LhxKRnXyAGeTqPs4V/0xPqk6rF3nXv1o4sgvmrGQ+7Ts2StvrmJK2T6ADK8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160213; c=relaxed/simple;
	bh=PH/jPLBzDMGCq5OJD73AN+aX4oj9vzpm//4imQ+N4Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlgZEAxw34uRmR1vi7KSkVTGTTzSu7pjUakoGzgZ2iibruJ4xS4/veGQFgb/LUWIluSUilrWbrqNcfa0C1GQYB4FlnnQ1gXdhz06Zjvoo1wTpCvZVYZvLMC4ieO7pJozN7+PEGdrZpR+HkPQlDaxIaCjuBRV9QQvK2KgusM4fBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dvcHNE30; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dvcHNE30"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29516a36affso27834585ad.3
        for <virtualization@lists.linux.dev>; Mon, 03 Nov 2025 00:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762160210; x=1762765010; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsJeiC9giUOuUOptSD2up1xgt2HYKMe/BW7XxMHpabE=;
        b=dvcHNE30yM1Px+mQHwDLLv/OfAAFyo2HbbaptO23eWPZqXi9WdoRMRMr499U0RESpX
         hloeV6YmZ2aDhJS0ayj6QzdbwgRgyFkwVzBdrJ3TRnRuySM+FInl8d1LQTynfHhgBnMc
         UXW+KcgRTO4BpMXJ1jV95O0zwzS3/TYCXqN9uVI2osnm225qvkREIYA7g1o+8JO+VtnH
         HGimzZsRSrZYhpzn2iPNZA1CoyeqyuoYRgnr+cJeccUsyj+dKar/haCL650ukGWUwsll
         CvkvFLrBAnKPepzUKr8SIxYjyiU7wC6BCq5Q9w0kVSYnST19DrDZFGyRp+BdXgfcLQpy
         +tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762160210; x=1762765010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsJeiC9giUOuUOptSD2up1xgt2HYKMe/BW7XxMHpabE=;
        b=Ze2HV+QS3ctoWbrl+OhjwSUUFB3flRIqbeLLr6VrO39FEFdSXV3PlS/YiGsxvn3WEA
         XiglOF/AxPa0gii8AoyB1vgW9i0SAS7G4YmTM9ZxBVoxsuXdjhjP7IZAU76fJcOzWDG7
         YCVQ3ii2cA//5VUY8S9h6IKmx1FuqGBsJkLrfwqJ1K7wga1pkIB+w+4cIQ/bNCdqUF50
         /OvZsyCfjfcE/1YjGnihhBzlWt+mO3HCfgfG/uc7xtDzPYZLeg/FSKo/qzYU0hysCa14
         ZaOzEmKNZ5PCuc6+Qh+QTX6VBviXfuWm/aN7j897mG6QmagZ6Y9YuxrxiqrFhdy8494d
         tOQA==
X-Forwarded-Encrypted: i=1; AJvYcCVKvyQsGG2OtPYHDLV0cKF/+nTeTPqn3muVVtGjvUajfGTG8UHhilJOAIjeDDj56i4W9AfhaqA83n2xjkiqjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxH3mDYO1GqTlEDB8Lq2xVR1PYgU7ttoewiFAm+eVAM81qep6Yd
	XBgPElnIjcjeydqhk2po8ZYcLTzSJliXwmjNSDSQnZMEutuDxq1L/kFGPzlAQ6DrX+Tf4hydo7o
	urq7Qj7DRDMOphPfsjtLxYs9HvITWCkyx3gbX0awg
X-Gm-Gg: ASbGncsBFaTOxiUCw+MDFpS5/l3MS95MbAna0mLxLHdJ2Iv+qsgZuCnBXgYDFhoeJ5n
	3d5ma/l+AUXkVieA33aIKZ92214FlVApsblbVrJQdtpKd9tXMnDuOpR10RDVKbLc30hbL77w9xW
	J513JWdKMBqrMEHqIEm0XGg35xjxAxXp8XQbGuxL6ITW+X/bzZouQ13JGUYoK4P40L9cFxZfx7K
	YdEb0kIvzNDKIKF6MWgvF7oAYlfeKSxZgx/QkqRknFznkPH9cc68zSV++JW1hOCKBM1tbgsdnpc
	2z/nDfHYUpYGmFhXKXdV0uPjorM+
X-Google-Smtp-Source: AGHT+IFeAxFutzNw8+i3VzwLFJRBANb9AQgI56q7WNbYmHNtmeERsiMUV6ZS5eIjAQQbNoplTB1SO0F+omWQd4alf4U=
X-Received: by 2002:a17:902:d48b:b0:295:fac:7b72 with SMTP id
 d9443c01a7336-2951a4b3595mr136603085ad.52.1762160210028; Mon, 03 Nov 2025
 00:56:50 -0800 (PST)
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
 <CACycT3u4AS3=8sQuDhLWoyg5ExTPyfDf8GTB23pAepGZizMBhQ@mail.gmail.com> <CAJaqyWdaHE70L9csnWq5NekdxEvyJz=QO7xat7N_ZeqD7meiSg@mail.gmail.com>
In-Reply-To: <CAJaqyWdaHE70L9csnWq5NekdxEvyJz=QO7xat7N_ZeqD7meiSg@mail.gmail.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 3 Nov 2025 16:56:38 +0800
X-Gm-Features: AWmQ_bknQPw31ZOQhMFkqTXUBLHBzFMr25ZrTW61zNxowGFV1Qj-zOfgb-pFvlI
Message-ID: <CACycT3uOee8Mkf6C08-gfscDgtuChtMHSvfx8W7UxaPt3bE+Cg@mail.gmail.com>
Subject: Re: Re: Re: Re: [PATCH v8 5/6] vduse: add vq group asid support
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, virtualization@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 4:20=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Nov 3, 2025 at 8:13=E2=80=AFAM Yongji Xie <xieyongji@bytedance.co=
m> wrote:
> >
> > On Mon, Nov 3, 2025 at 2:41=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Mon, Nov 3, 2025 at 3:55=E2=80=AFAM Yongji Xie <xieyongji@bytedanc=
e.com> wrote:
> > > >
> > > > On Fri, Oct 31, 2025 at 10:09=E2=80=AFPM Eugenio Perez Martin
> > > > <eperezma@redhat.com> wrote:
> > > > >
> > > > > On Fri, Oct 31, 2025 at 8:01=E2=80=AFAM Yongji Xie <xieyongji@byt=
edance.com> wrote:
> > > > > >
> > > > > > On Fri, Oct 31, 2025 at 2:31=E2=80=AFPM Eugenio Perez Martin
> > > > > > <eperezma@redhat.com> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 30, 2025 at 12:52=E2=80=AFPM Yongji Xie <xieyongj=
i@bytedance.com> wrote:
> > > > > > > >
> > > > > > > > On Thu, Oct 30, 2025 at 6:01=E2=80=AFPM Eugenio P=C3=A9rez =
<eperezma@redhat.com> wrote:
> > > > > > > > >
> > > > > > > > > Add support for assigning Address Space Identifiers (ASID=
s) to each VQ
> > > > > > > > > group.  This enables mapping each group into a distinct m=
emory space.
> > > > > > > > >
> > > > > > > > > Now that the driver can change ASID in the middle of oper=
ation, the
> > > > > > > > > domain that each vq address point is also protected by do=
main_lock.
> > > > > > > > >
> > > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > > > > ---
> > > > > > > > > v8:
> > > > > > > > > * Revert the mutex to rwlock change, it needs proper prof=
iling to
> > > > > > > > >   justify it.
> > > > > > > > >
> > > > > > > > > v7:
> > > > > > > > > * Take write lock in the error path (Jason).
> > > > > > > > >
> > > > > > > > > v6:
> > > > > > > > > * Make vdpa_dev_add use gotos for error handling (MST).
> > > > > > > > > * s/(dev->api_version < 1) ?/(dev->api_version < VDUSE_AP=
I_VERSION_1) ?/
> > > > > > > > >   (MST).
> > > > > > > > > * Fix struct name not matching in the doc.
> > > > > > > > >
> > > > > > > > > v5:
> > > > > > > > > * Properly return errno if copy_to_user returns >0 in VDU=
SE_IOTLB_GET_FD
> > > > > > > > >   ioctl (Jason).
> > > > > > > > > * Properly set domain bounce size to divide equally betwe=
en nas (Jason).
> > > > > > > > > * Exclude "padding" member from the only >V1 members in
> > > > > > > > >   vduse_dev_request.
> > > > > > > > >
> > > > > > > > > v4:
> > > > > > > > > * Divide each domain bounce size between the device bounc=
e size (Jason).
> > > > > > > > > * revert unneeded addr =3D NULL assignment (Jason)
> > > > > > > > > * Change if (x && (y || z)) return to if (x) { if (y) ret=
urn; if (z)
> > > > > > > > >   return; } (Jason)
> > > > > > > > > * Change a bad multiline comment, using @ caracter instea=
d of * (Jason).
> > > > > > > > > * Consider config->nas =3D=3D 0 as a fail (Jason).
> > > > > > > > >
> > > > > > > > > v3:
> > > > > > > > > * Get the vduse domain through the vduse_as in the map fu=
nctions
> > > > > > > > >   (Jason).
> > > > > > > > > * Squash with the patch creating the vduse_as struct (Jas=
on).
> > > > > > > > > * Create VDUSE_DEV_MAX_AS instead of comparing agains a m=
agic number
> > > > > > > > >   (Jason)
> > > > > > > > >
> > > > > > > > > v2:
> > > > > > > > > * Convert the use of mutex to rwlock.
> > > > > > > > >
> > > > > > > > > RFC v3:
> > > > > > > > > * Increase VDUSE_MAX_VQ_GROUPS to 0xffff (Jason). It was =
set to a lower
> > > > > > > > >   value to reduce memory consumption, but vqs are already=
 limited to
> > > > > > > > >   that value and userspace VDUSE is able to allocate that=
 many vqs.
> > > > > > > > > * Remove TODO about merging VDUSE_IOTLB_GET_FD ioctl with
> > > > > > > > >   VDUSE_IOTLB_GET_INFO.
> > > > > > > > > * Use of array_index_nospec in VDUSE device ioctls.
> > > > > > > > > * Embed vduse_iotlb_entry into vduse_iotlb_entry_v2.
> > > > > > > > > * Move the umem mutex to asid struct so there is no conte=
ntion between
> > > > > > > > >   ASIDs.
> > > > > > > > >
> > > > > > > > > RFC v2:
> > > > > > > > > * Make iotlb entry the last one of vduse_iotlb_entry_v2 s=
o the first
> > > > > > > > >   part of the struct is the same.
> > > > > > > > > ---
> > > > > > > > >  drivers/vdpa/vdpa_user/vduse_dev.c | 348 +++++++++++++++=
+++++---------
> > > > > > > > >  include/uapi/linux/vduse.h         |  53 ++++-
> > > > > > > > >  2 files changed, 292 insertions(+), 109 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers=
/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > index 97be04f73fbf..c6909d73d06d 100644
> > > > > > > > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > > > > > > > @@ -41,6 +41,7 @@
> > > > > > > > >
> > > > > > > > >  #define VDUSE_DEV_MAX (1U << MINORBITS)
> > > > > > > > >  #define VDUSE_DEV_MAX_GROUPS 0xffff
> > > > > > > > > +#define VDUSE_DEV_MAX_AS 0xffff
> > > > > > > > >  #define VDUSE_MAX_BOUNCE_SIZE (1024 * 1024 * 1024)
> > > > > > > > >  #define VDUSE_MIN_BOUNCE_SIZE (1024 * 1024)
> > > > > > > > >  #define VDUSE_BOUNCE_SIZE (64 * 1024 * 1024)
> > > > > > > > > @@ -86,7 +87,14 @@ struct vduse_umem {
> > > > > > > > >         struct mm_struct *mm;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > +struct vduse_as {
> > > > > > > > > +       struct vduse_iova_domain *domain;
> > > > > > > > > +       struct vduse_umem *umem;
> > > > > > > > > +       struct mutex mem_lock;
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > >  struct vduse_vq_group {
> > > > > > > > > +       struct vduse_as *as;
> > > > > > > > >         struct vduse_dev *dev;
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > > @@ -94,7 +102,7 @@ struct vduse_dev {
> > > > > > > > >         struct vduse_vdpa *vdev;
> > > > > > > > >         struct device *dev;
> > > > > > > > >         struct vduse_virtqueue **vqs;
> > > > > > > > > -       struct vduse_iova_domain *domain;
> > > > > > > > > +       struct vduse_as *as;
> > > > > > > > >         char *name;
> > > > > > > > >         struct mutex lock;
> > > > > > > > >         spinlock_t msg_lock;
> > > > > > > > > @@ -122,9 +130,8 @@ struct vduse_dev {
> > > > > > > > >         u32 vq_num;
> > > > > > > > >         u32 vq_align;
> > > > > > > > >         u32 ngroups;
> > > > > > > > > -       struct vduse_umem *umem;
> > > > > > > > > +       u32 nas;
> > > > > > > > >         struct vduse_vq_group *groups;
> > > > > > > > > -       struct mutex mem_lock;
> > > > > > > > >         unsigned int bounce_size;
> > > > > > > > >         struct mutex domain_lock;
> > > > > > > > >  };
> > > > > > > > > @@ -314,7 +321,7 @@ static int vduse_dev_set_status(struc=
t vduse_dev *dev, u8 status)
> > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > -static int vduse_dev_update_iotlb(struct vduse_dev *dev,
> > > > > > > > > +static int vduse_dev_update_iotlb(struct vduse_dev *dev,=
 u32 asid,
> > > > > > > > >                                   u64 start, u64 last)
> > > > > > > > >  {
> > > > > > > > >         struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > @@ -323,8 +330,14 @@ static int vduse_dev_update_iotlb(st=
ruct vduse_dev *dev,
> > > > > > > > >                 return -EINVAL;
> > > > > > > > >
> > > > > > > > >         msg.req.type =3D VDUSE_UPDATE_IOTLB;
> > > > > > > > > -       msg.req.iova.start =3D start;
> > > > > > > > > -       msg.req.iova.last =3D last;
> > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1) {
> > > > > > > > > +               msg.req.iova.start =3D start;
> > > > > > > > > +               msg.req.iova.last =3D last;
> > > > > > > > > +       } else {
> > > > > > > > > +               msg.req.iova_v2.start =3D start;
> > > > > > > > > +               msg.req.iova_v2.last =3D last;
> > > > > > > > > +               msg.req.iova_v2.asid =3D asid;
> > > > > > > > > +       }
> > > > > > > > >
> > > > > > > > >         return vduse_dev_msg_sync(dev, &msg);
> > > > > > > > >  }
> > > > > > > > > @@ -436,14 +449,29 @@ static __poll_t vduse_dev_poll(stru=
ct file *file, poll_table *wait)
> > > > > > > > >         return mask;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +/* Force set the asid to a vq group without a message to=
 the VDUSE device */
> > > > > > > > > +static void vduse_set_group_asid_nomsg(struct vduse_dev =
*dev,
> > > > > > > > > +                                      unsigned int group=
, unsigned int asid)
> > > > > > > > > +{
> > > > > > > > > +       mutex_lock(&dev->domain_lock);
> > > > > > > > > +       dev->groups[group].as =3D &dev->as[asid];
> > > > > > > > > +       mutex_unlock(&dev->domain_lock);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static void vduse_dev_reset(struct vduse_dev *dev)
> > > > > > > > >  {
> > > > > > > > >         int i;
> > > > > > > > > -       struct vduse_iova_domain *domain =3D dev->domain;
> > > > > > > > >
> > > > > > > > >         /* The coherent mappings are handled in vduse_dev=
_free_coherent() */
> > > > > > > > > -       if (domain && domain->bounce_map)
> > > > > > > > > -               vduse_domain_reset_bounce_map(domain);
> > > > > > > > > +       for (i =3D 0; i < dev->nas; i++) {
> > > > > > > > > +               struct vduse_iova_domain *domain =3D dev-=
>as[i].domain;
> > > > > > > > > +
> > > > > > > > > +               if (domain && domain->bounce_map)
> > > > > > > > > +                       vduse_domain_reset_bounce_map(dom=
ain);
> > > > > > > > > +       }
> > > > > > > > > +
> > > > > > > > > +       for (i =3D 0; i < dev->ngroups; i++)
> > > > > > > > > +               vduse_set_group_asid_nomsg(dev, i, 0);
> > > > > > > > >
> > > > > > > > >         down_write(&dev->rwsem);
> > > > > > > > >
> > > > > > > > > @@ -623,6 +651,29 @@ static union virtio_map vduse_get_vq=
_map(struct vdpa_device *vdpa, u16 idx)
> > > > > > > > >         return ret;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static int vduse_set_group_asid(struct vdpa_device *vdpa=
, unsigned int group,
> > > > > > > > > +                               unsigned int asid)
> > > > > > > > > +{
> > > > > > > > > +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > > +       struct vduse_dev_msg msg =3D { 0 };
> > > > > > > > > +       int r;
> > > > > > > > > +
> > > > > > > > > +       if (dev->api_version < VDUSE_API_VERSION_1 ||
> > > > > > > > > +           group >=3D dev->ngroups || asid >=3D dev->nas=
)
> > > > > > > > > +               return -EINVAL;
> > > > > > > > > +
> > > > > > > > > +       msg.req.type =3D VDUSE_SET_VQ_GROUP_ASID;
> > > > > > > > > +       msg.req.vq_group_asid.group =3D group;
> > > > > > > > > +       msg.req.vq_group_asid.asid =3D asid;
> > > > > > > > > +
> > > > > > > > > +       r =3D vduse_dev_msg_sync(dev, &msg);
> > > > > > > > > +       if (r < 0)
> > > > > > > > > +               return r;
> > > > > > > > > +
> > > > > > > > > +       vduse_set_group_asid_nomsg(dev, group, asid);
> > > > > > > > > +       return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static int vduse_vdpa_get_vq_state(struct vdpa_device *v=
dpa, u16 idx,
> > > > > > > > >                                 struct vdpa_vq_state *sta=
te)
> > > > > > > > >  {
> > > > > > > > > @@ -794,13 +845,13 @@ static int vduse_vdpa_set_map(struc=
t vdpa_device *vdpa,
> > > > > > > > >         struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> > > > > > > > >         int ret;
> > > > > > > > >
> > > > > > > > > -       ret =3D vduse_domain_set_map(dev->domain, iotlb);
> > > > > > > > > +       ret =3D vduse_domain_set_map(dev->as[asid].domain=
, iotlb);
> > > > > > > > >         if (ret)
> > > > > > > > >                 return ret;
> > > > > > > > >
> > > > > > > > > -       ret =3D vduse_dev_update_iotlb(dev, 0ULL, ULLONG_=
MAX);
> > > > > > > > > +       ret =3D vduse_dev_update_iotlb(dev, asid, 0ULL, U=
LLONG_MAX);
> > > > > > > > >         if (ret) {
> > > > > > > > > -               vduse_domain_clear_map(dev->domain, iotlb=
);
> > > > > > > > > +               vduse_domain_clear_map(dev->as[asid].doma=
in, iotlb);
> > > > > > > > >                 return ret;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > @@ -843,6 +894,7 @@ static const struct vdpa_config_ops v=
duse_vdpa_config_ops =3D {
> > > > > > > > >         .get_vq_affinity        =3D vduse_vdpa_get_vq_aff=
inity,
> > > > > > > > >         .reset                  =3D vduse_vdpa_reset,
> > > > > > > > >         .set_map                =3D vduse_vdpa_set_map,
> > > > > > > > > +       .set_group_asid         =3D vduse_set_group_asid,
> > > > > > > > >         .get_vq_map             =3D vduse_get_vq_map,
> > > > > > > > >         .free                   =3D vduse_vdpa_free,
> > > > > > > > >  };
> > > > > > > > > @@ -858,9 +910,10 @@ static void vduse_dev_sync_single_fo=
r_device(union virtio_map token,
> > > > > > > > >                 return;
> > > > > > > > >
> > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > -
> > > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > > > +       domain =3D token.group->as->domain;
> > > > > > > > >         vduse_domain_sync_single_for_device(domain, dma_a=
ddr, size, dir);
> > > > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static void vduse_dev_sync_single_for_cpu(union virtio_m=
ap token,
> > > > > > > > > @@ -874,9 +927,10 @@ static void vduse_dev_sync_single_fo=
r_cpu(union virtio_map token,
> > > > > > > > >                 return;
> > > > > > > > >
> > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > -
> > > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > > > +       domain =3D token.group->as->domain;
> > > > > > > > >         vduse_domain_sync_single_for_cpu(domain, dma_addr=
, size, dir);
> > > > > > > > > +       mutex_unlock(&vdev->domain_lock);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > >  static dma_addr_t vduse_dev_map_page(union virtio_map to=
ken, struct page *page,
> > > > > > > > > @@ -886,14 +940,18 @@ static dma_addr_t vduse_dev_map_pag=
e(union virtio_map token, struct page *page,
> > > > > > > > >  {
> > > > > > > > >         struct vduse_dev *vdev;
> > > > > > > > >         struct vduse_iova_domain *domain;
> > > > > > > > > +       dma_addr_t r;
> > > > > > > > >
> > > > > > > > >         if (!token.group)
> > > > > > > > >                 return DMA_MAPPING_ERROR;
> > > > > > > > >
> > > > > > > > >         vdev =3D token.group->dev;
> > > > > > > > > -       domain =3D vdev->domain;
> > > > > > > > > +       mutex_lock(&vdev->domain_lock);
> > > > > > > >
> > > > > > > > The mutex_lock can't be used here since the dma ops might b=
e called in
> > > > > > > > atomic context. And I think we can just remove it since cre=
ation and
> > > > > > > > deletion operations of the iova domain are guaranteed not t=
o execute
> > > > > > > > concurrently with I/O operations.
> > > > > > > >
> > > > > > >
> > > > > > > That would be great indeed! Can you expand on this, what prot=
ects here
> > > > > > > from the moment the two syscalls are issues from userland?
> > > > > > >
> > > > > >
> > > > > > The domain mutex lock is introduced in commit
> > > > > > d4438d23eeeef8bb1b3a8abe418abffd60bb544a ("vduse: Delay iova do=
main
> > > > > > creation"). It's used to prevent concurrent execution between
> > > > > > vdpa_dev_add() and some vduse device ioctl which needs to acces=
s the
> > > > > > iova domain such as VDUSE_IOTLB_REG_UMEM/DEREG_UMEM. But the dm=
a ops
> > > > > > would not be called until vdpa_dev_add() completed, so the mute=
x lock
> > > > > > is not needed.
> > > > > >
> > > > >
> > > > > Yes, but the usage is extended here to also protect from concurre=
nt
> > > > > calls to vduse_dev_map_page and vduse_set_group_asid or similar.
> > > > >
> > > > > So I guess the best is to replace it with a spinlock or RCU.
> > > > >
> > > >
> > > > OK, I see, we simply aim to prevent concurrent access to the group-=
>as
> > > > variable here. But I wonder if the .set_group_asid function can be
> > > > called during I/O.
> > >
> > > At least a malicious userland app could do it.
> > >
> > > > I think the unmap_page() would fail if we change
> > > > the group->as between map_page() and unmap_page().
> > >
> > > I guess a SIGSEGV or similar could be a valid outcome of that, but we
> > > need to protect the "as" pointer anyway.
> > >
> > > > Besides, it seems
> > > > that .set_group_asid is only called in the vhost-vdpa case currentl=
y,
> > > > but the dma ops such as map_page/unmap_page only service the
> > > > virtio-vdpa case, so they would not be called concurrently with
> > > > .set_group_asid now.
> > > >
> > >
> > > That's totally true but a malicious app can do it anyway. So it is
> > > better to protect it properly.
> > >
> >
> > Actually there is no interface for userspace to call .set_group_asid
> > if the vduse device is binded to the virtio-vdpa driver.
> >
>
> It is possible from vhost-vdpa.
>

Then there is no interface for userspace to call dma_ops such as
map_page/unmap_page if the device is binded to the vhost-vdpa driver.

Thanks,
Yongji
