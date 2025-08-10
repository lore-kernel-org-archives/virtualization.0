Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AE19E97A
	for <virtualization@lists.linux.dev>; Sun, 10 Aug 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754819158; cv=none; b=LV0VxrXemy9diaUoLqH5qEZEN871yQV6aP9opscf9jhludcAJynKWe3CZ1X0fiYUzFCtRRDjDCcGnLFEJvMmt7b5jWQl+VEUoOz5axFRB1C/QBQKz0tpXYfjOPuz4l0uv4z+TFWTL4FOBTiwxK0PC0QOmLnavYitspMcARWFZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754819158; c=relaxed/simple;
	bh=zUrNJw5KCyuPIT/2MYMWIMwi9Mii8MMO+nFvlFlxcnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5rmMrLmnnXbARVHco/s3cQ1gE+jAhPZCvXmEXod6ZCAGHn2qenu0uzhiTj7eIrHfU72hU3XUA5tjSOBNxFQJPIuQJWNkAep1X4Wlsue2E5GEIbbDB/vBqLB5HYR5rbXzo+AbSbFifpi7k2iWuw4IpYnRCxJQ/lPB/4gqoLllQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OIElfDo5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIElfDo5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754819155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYqoKKAs3JUx+DxFrg2IMR5YpWxx998Htycfaz+QPVc=;
	b=OIElfDo5PTBjFfJYF+yiuSbsje6mo8NCO5lXL0XNgQUPD8v3Bv6LiRDrk5k1UxoBJgf/N0
	WYtn1nq7MgIJWm7EMBHzpga/Ba7GYhzkMWg7g1eCvdhCyD68jpzIhE+IxVTtyXEhncaAJ2
	yNX7JiyJz53NktosVjLmKEeIDUfO6Tw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-TSl-oirWOTWcvChLGknXjw-1; Sun, 10 Aug 2025 05:45:53 -0400
X-MC-Unique: TSl-oirWOTWcvChLGknXjw-1
X-Mimecast-MFC-AGG-ID: TSl-oirWOTWcvChLGknXjw_1754819152
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b38d8ee46a5so3475829a12.1
        for <virtualization@lists.linux.dev>; Sun, 10 Aug 2025 02:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754819152; x=1755423952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WYqoKKAs3JUx+DxFrg2IMR5YpWxx998Htycfaz+QPVc=;
        b=PWhLLExwlSp14EcEn/Vr7g06FbzvyLErHRsocTtV9U9iCLW6fRnKGLb22begRxKeRR
         NU6UCKZthtQMcx7/lc7amf5RMenKBkHhmITGw0aayX+FT2wGDtBlF67QnQ6ZiHd6pIi5
         vPx4YMPg1SlyO4s9jkcRg65gUT7q+kTxqsbTd9+lo51R9VzRsm7wAgsur3RmEtReHpVu
         o0oxZVxCRjc1w9r0WP30a5AB0w1NmidvtdqLc5NpmMJLQXD2qEqzasMjAbUJ8yBYWklR
         9PpYPIs7/3k09B14xBFbfJ/44x/l3S50rqV4Rk93GTCANgAF9scd5XcIPBhW9Dhmu21J
         6Jpg==
X-Forwarded-Encrypted: i=1; AJvYcCU2hDVd+kpTcfdIoVWdGW/ZuOxu58ElPImLRbGEYpmEpiGZYPJ/XeUyFqiglEKwzQ7nx2fhCuTASPb/xn5Rmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEQycH+8UvHJ0NP+2GDCfFSpaaai19wo6V/H80qEtBX/TdEtOh
	6aglRQ9me5AkCJK157wLbsP1JtoeZEpCUGz0XbNepXRwLhT60u2l2RMLsrAKRRLbLNBPdr5Da7S
	YZ1Jbdj93RPuReCdjFt/RzTl2pjPJJwXZ9omIj0A726/5xREzmHU4vuaqdTwpzU2kBkJqNjZ+kk
	HK8QbdM43yLKdoZfVPoGDM5GWYQE44ZMEeSDmj020G6Fk=
X-Gm-Gg: ASbGncu3FS+6kROfu9ljTMWl7dN7TFLKJmMj+blMBXSszN4onw85v14p304p/gk6oZm
	51QBa+tzYjEkUoafXGEdSk1g48xrP1g1KlhroIBA+akYi+QHDxzaxD/wqFZikFj/dv2+pw70Is0
	5Tm4oc5MlvDIkDXo8aVSjP
X-Received: by 2002:a17:902:e84c:b0:23f:ed0f:8dd4 with SMTP id d9443c01a7336-242b07940a6mr188155215ad.23.1754819152126;
        Sun, 10 Aug 2025 02:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3VmcJMb+fKyzh2eropeS8kzbXx6MkPWPFWpThYHuztmqtZjehzHYzrwD7X9QcmvcWptoMYVrw5OhZ0cBqYyM=
X-Received: by 2002:a17:902:e84c:b0:23f:ed0f:8dd4 with SMTP id
 d9443c01a7336-242b07940a6mr188154955ad.23.1754819151692; Sun, 10 Aug 2025
 02:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250807115752.1663383-1-eperezma@redhat.com> <20250807115752.1663383-6-eperezma@redhat.com>
 <edf19f09-bd54-4297-8c5e-da331c24fc4c@redhat.com>
In-Reply-To: <edf19f09-bd54-4297-8c5e-da331c24fc4c@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Sun, 10 Aug 2025 11:45:15 +0200
X-Gm-Features: Ac12FXxiGID8AW94vngfEmBWhzBUSS3xWFDvZD5F09p7QM7EFiDyRjdInni3pLE
Message-ID: <CAJaqyWcNR620aOsVVJB6wb5stkNjF37JTue511Guh3OZtfeAXA@mail.gmail.com>
Subject: Re: [RFC v2 5/7] vduse: add vq group asid support
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Yongji Xie <xieyongji@bytedance.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Laurent Vivier <lvivier@redhat.com>, 
	linux-kernel@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	jasowang@redhat.com, Maxime Coquelin <mcoqueli@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LMa4fkrfND7mBHWM6qr3tA-bPlzDkU1dG79WHQnmNz4_1754819152
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 9:45=E2=80=AFAM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
>
>
> On 8/7/25 1:57 PM, Eugenio P=C3=A9rez wrote:
> > diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
> > index b4b139dc76bb..d300fd5f867f 100644
> > --- a/include/uapi/linux/vduse.h
> > +++ b/include/uapi/linux/vduse.h
> > @@ -47,7 +47,8 @@ struct vduse_dev_config {
> >       __u32 vq_num;
> >       __u32 vq_align;
> >       __u32 ngroups; /* if VDUSE_API_VERSION >=3D 1 */
> > -     __u32 reserved[12];
> > +     __u32 nas; /* if VDUSE_API_VERSION >=3D 1 */
> > +     __u32 reserved[11];
> >       __u32 config_size;
> >       __u8 config[];
> >   };
> > @@ -82,6 +83,17 @@ struct vduse_iotlb_entry {
> >       __u8 perm;
> >   };
> >
> > +struct vduse_iotlb_entry_v2 {
> > +     __u64 offset;
> > +     __u64 start;
> > +     __u64 last;
> > +#define VDUSE_ACCESS_RO 0x1
> > +#define VDUSE_ACCESS_WO 0x2
> > +#define VDUSE_ACCESS_RW 0x3
> > +     __u8 perm;
> > +     __u32 asid;
> > +};
> > +
> >   /*
> >    * Find the first IOVA region that overlaps with the range [start, la=
st]
> >    * and return the corresponding file descriptor. Return -EINVAL means=
 the
> > @@ -172,6 +184,16 @@ struct vduse_vq_group {
> >       __u32 num;
> >   };
> >
> > +/**
> > + * struct vduse_vq_group - virtqueue group
> > + @ @group: Index of the virtqueue group
> > + * @asid: Address space ID of the group
> > + */
> > +struct vduse_vq_group_asid {
> > +     __u32 group;
> > +     __u32 asid;
> > +};
> > +
> >   /**
> >    * struct vduse_vq_info - information of a virtqueue
> >    * @index: virtqueue index
> > @@ -232,6 +254,7 @@ struct vduse_vq_eventfd {
> >    * @uaddr: start address of userspace memory, it must be aligned to p=
age size
> >    * @iova: start of the IOVA region
> >    * @size: size of the IOVA region
> > + * @asid: Address space ID of the IOVA region
> >    * @reserved: for future use, needs to be initialized to zero
> >    *
> >    * Structure used by VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM
> > @@ -241,7 +264,8 @@ struct vduse_iova_umem {
> >       __u64 uaddr;
> >       __u64 iova;
> >       __u64 size;
> > -     __u64 reserved[3];
> > +     __u32 asid;
> > +     __u32 reserved[5];
> >   };
> >
> >   /* Register userspace memory for IOVA regions */
> > @@ -265,7 +289,8 @@ struct vduse_iova_info {
> >       __u64 last;
> >   #define VDUSE_IOVA_CAP_UMEM (1 << 0)
> >       __u64 capability;
> > -     __u64 reserved[3];
> > +     __u32 asid; /* Only if device API version >=3D 1 */
> > +     __u32 reserved[5];
> >   };
> >
> >   /*
> > @@ -289,6 +314,7 @@ enum vduse_req_type {
> >       VDUSE_UPDATE_IOTLB,
> >       VDUSE_GET_VQ_GROUP,
> >       VDUSE_GET_VRING_DESC_GROUP,
> > +     VDUSE_SET_VQ_GROUP_ASID,
> >   };
> >
> >   /**
> > @@ -344,6 +370,8 @@ struct vduse_dev_request {
> >               struct vduse_dev_status s;
> >               struct vduse_iova_range iova;
> >               struct vduse_vq_group vq_group; /* Only if vduse api vers=
ion >=3D 1 */
> > +             /* Only if vduse api version >=3D 1 */
> > +             struct vduse_vq_group_asid vq_group_asid;
> >               __u32 padding[32];
>
> I think you need to update padding size here.
>

Nope, that's an union so u32[32] is the total size. Modifying it would
change uapi :).

> >       };
> >   };
> > @@ -367,6 +395,8 @@ struct vduse_dev_response {
> >       union {
> >               struct vduse_vq_state vq_state;
> >               struct vduse_vq_group vq_group; /* Only if vduse api vers=
ion >=3D 1 */
> > +             /* Only if vduse api version >=3D 1 */
> > +             struct vduse_vq_group_asid vq_group_asid;
> >               __u32 padding[32];
> >       };
> >   };
>
> Same
>
> Regards,
> Maxime
>

