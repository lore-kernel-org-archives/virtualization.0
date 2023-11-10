Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C337215C6
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cztS69RE"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 39E2B40424
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 02:32:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 39E2B40424
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cztS69RE
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FEVYTBLIxWE8
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 02:32:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3C786403A7
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 02:32:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C786403A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699583522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNS2IyMSqXQW2yu+EGl6Ot8gwOdMjojW7LaUfYQpOEw=;
	b=cztS69RE4hVZONwV1Op+tg/pcYEeNmWWGPyJupNf0l4tlohw+o/N2/NaS2wsOjt0PRcjSe
	4kEydKIZH3xuu5hz0HFhE9D/nFJ5FDuWTGTDD2BpdrYDI/ZfdOBkOnXJkui1StZItjUp0i
	PH8JiycENXaExyD8mAiQfDIU79PEQqY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-ZgtkJTPFPiiHbGNBd38lkQ-1; Thu, 09 Nov 2023 21:32:01 -0500
X-MC-Unique: ZgtkJTPFPiiHbGNBd38lkQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5079a3362afso1496404e87.3
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Nov 2023 18:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583520; x=1700188320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNS2IyMSqXQW2yu+EGl6Ot8gwOdMjojW7LaUfYQpOEw=;
        b=MKNKA5Yt7VJgtl7lMFJA8l+IymGnZPGu9sX+9Pa+xX6PxPi1k5E4cfNTFKZHM8y4Oq
         o/2Idc5LbmN6c0fMfN9DAKJHJamyKfriCnoWEKlY1t9UYt7g1noa3HJXtJIHRFYhVkDQ
         w671HRFhjdi1UBQi8ql2lTuzixHRFkrrhTTwopI7lWyDezpvck8/Rpun1SH3f475KyEz
         ZNJRpR5CH6O+3KkCGmztUyvki11wYbcz3HO9e0syUd3/C5igbU3oM+jGgQbFegqR5jzA
         q5AidFw9Rq/xKHCQjmqlx9kuaAmBHUDpZ0kL4eIxixqCn8IQqhqI8K5l7LcYvgcmpjZN
         jXaQ==
X-Gm-Message-State: AOJu0YylP+1kPRcmV0XkfgzvunpftaqG8hpe3xKvcY/2tO3+vV/KGwKc
	fSUeGep4MWmyG/LyJd+5gGIhqpA70JrO41rcOYkOgT++NipREkFp8dX0BmF5s3GTmbCV50j87qs
	ZHad7OCCKDHKCcecURdZCZjLsdm+zVyY0SnfKaVboh42o8/VtHxRIe69ldQ==
X-Received: by 2002:a05:6512:3b0d:b0:50a:5b7b:3de3 with SMTP id f13-20020a0565123b0d00b0050a5b7b3de3mr628502lfv.48.1699583519952;
        Thu, 09 Nov 2023 18:31:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5TlKYjD+BKd37dlAum2ISONImb/e0UdH9nWCcDO4HKzLaHEqEN/Kb8/dl/VFEMFjHAbPjUBm65YDovYK3SSs=
X-Received: by 2002:a05:6512:3b0d:b0:50a:5b7b:3de3 with SMTP id
 f13-20020a0565123b0d00b0050a5b7b3de3mr628487lfv.48.1699583519532; Thu, 09 Nov
 2023 18:31:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
 <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com>
 <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
 <CACGkMEsp_rg+_01hwxCtZNOk2itB1L89mdOc1W1DG3umfEt5bw@mail.gmail.com>
 <CACLfguW3NZawOL0ET2K7bmtGZuzQwUfJ2HSgnirswzZK1ayPnA@mail.gmail.com> <CACGkMEvnNXC8PhBNQn_F0ROGRX3CvwmXM6wP2A69aydSuzThYw@mail.gmail.com>
In-Reply-To: <CACGkMEvnNXC8PhBNQn_F0ROGRX3CvwmXM6wP2A69aydSuzThYw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Nov 2023 10:31:47 +0800
Message-ID: <CACGkMEtVqAYP3ec0+uxmdiOdXXevjy5S+7Vuc9s=PcS3ry0nCg@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 3:09=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Wed, Nov 8, 2023 at 2:39=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Wed, Nov 8, 2023 at 11:03=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Tue, Nov 7, 2023 at 2:57=E2=80=AFPM Cindy Lu <lulu@redhat.com> wro=
te:
> > > >
> > > > On Mon, Nov 6, 2023 at 3:30=E2=80=AFPM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com>=
 wrote:
> > > > > >
> > > > > > VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
> > > > > >
> > > > > > VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommu=
fd
> > > > > > address space specified by IOAS id.
> > > > > >
> > > > > > VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> > > > > > from the iommufd address space
> > > > > >
> > > > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > > > > ---
> > > > >
> > > > > [...]
> > > > >
> > > > > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vh=
ost.h
> > > > > > index f5c48b61ab62..07e1b2c443ca 100644
> > > > > > --- a/include/uapi/linux/vhost.h
> > > > > > +++ b/include/uapi/linux/vhost.h
> > > > > > @@ -219,4 +219,70 @@
> > > > > >   */
> > > > > >  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
> > > > > >
> > > > > > +/* vhost_vdpa_set_iommufd
> > > > > > + * Input parameters:
> > > > > > + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> > > > > > + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_=
IOAS_ALLOC)
> > > > > > + * Output parameters:
> > > > > > + * @out_dev_id: device identifier
> > > > > > + */
> > > > > > +struct vhost_vdpa_set_iommufd {
> > > > > > +       __s32 iommufd;
> > > > > > +       __u32 iommufd_ioasid;
> > > > > > +       __u32 out_dev_id;
> > > > > > +};
> > > > > > +
> > > > > > +#define VHOST_VDPA_SET_IOMMU_FD \
> > > > > > +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> > > > > > +
> > > > > > +/*
> > > > > > + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> > > > > > + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_=
as)
> > > > > > + *
> > > > > > + * Attach a vdpa device to an iommufd address space specified =
by IOAS
> > > > > > + * id.
> > > > > > + *
> > > > > > + * Available only after a device has been bound to iommufd via
> > > > > > + * VHOST_VDPA_SET_IOMMU_FD
> > > > > > + *
> > > > > > + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> > > > > > + *
> > > > > > + * @argsz:     user filled size of this data.
> > > > > > + * @flags:     must be 0.
> > > > > > + * @ioas_id:   Input the target id which can represent an ioas
> > > > > > + *             allocated via iommufd subsystem.
> > > > > > + *
> > > > > > + * Return: 0 on success, -errno on failure.
> > > > > > + */
> > > > > > +struct vdpa_device_attach_iommufd_as {
> > > > > > +       __u32 argsz;
> > > > > > +       __u32 flags;
> > > > > > +       __u32 ioas_id;
> > > > > > +};
> > > > >
> > > > > I think we need to map ioas to vDPA AS, so there should be an ASI=
D
> > > > > from the view of vDPA?
> > > > >
> > > > > Thanks
> > > > >
> > > > The qemu will have a structure save and  maintain this information,=
So
> > > > I didn't add this
> > > >  in kernel=EF=BC=8Cwe can add this but maybe only for check?
> > >
> > > I meant for example, a simulator has two AS. How can we attach an ioa=
s
> > > to a specific AS with the above uAPI?
> > >
> > > Thank>
> > this   __u32 ioas_id here is alloc from the iommufd system. maybe I
> > need to change to new name iommuds_asid to
> > make this more clear
> > the process in qemu is
> >
> > 1) qemu want to use AS 0 (for example)
> > 2) checking the existing asid. the asid 0 not used before
> > 3 )alloc new asid from iommufd system, get new ioas_id (maybe 3 for exa=
mple)
> > qemu will save this relation 3<-->0 in the driver.
> > 4) setting the ioctl VDPA_DEVICE_ATTACH_IOMMUFD_AS to attach new ASID
> > to the kernel
>
> So if we want to map IOMMUFD AS 3 to VDPA AS 0, how can it be done?
>
> For example I didn't see a vDPA AS parameter in the above uAPI.
>
> vhost_vdpa_set_iommufd has iommufd_ioasid which is obviously not the vDPA=
 AS.
>
> And ioas_id of vdpa_device_attach_iommufd_as (as you explained above)
> is not vDPA AS.

For example, the simulator/mlx5e has two ASes. It needs to know the
mapping between vDPA AS and iommufd AS. Otherwise the translation will
be problematic.

Thanks

>
> Thanks
>
>
> > 5=EF=BC=89 while map the memory=EF=BC=8C qemu will use ASID 3 to map /u=
map
> > and use ASID 0 for legacy mode map/umap
> >
> > So kernel here will not maintain the ioas_id from iommufd=EF=BC=8C
> > and this also make the code strange since there will 2 different asid
> > for the same AS, maybe we can save these information in the kernel
> > Thanks
> > cindy
> > > > Thanks
> > > > Cindy
> > > > > > +
> > > > > > +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> > > > > > +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iomm=
ufd_as)
> > > > > > +
> > > > > > +/*
> > > > > > + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> > > > > > + *
> > > > > > + * Detach a vdpa device from the iommufd address space it has =
been
> > > > > > + * attached to. After it, device should be in a blocking DMA s=
tate.
> > > > > > + *
> > > > > > + * Available only after a device has been bound to iommufd via
> > > > > > + * VHOST_VDPA_SET_IOMMU_FD
> > > > > > + *
> > > > > > + * @argsz:     user filled size of this data.
> > > > > > + * @flags:     must be 0.
> > > > > > + *
> > > > > > + * Return: 0 on success, -errno on failure.
> > > > > > + */
> > > > > > +struct vdpa_device_detach_iommufd_as {
> > > > > > +       __u32 argsz;
> > > > > > +       __u32 flags;
> > > > > > +};
> > > > > > +
> > > > > > +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> > > > > > +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iomm=
ufd_as)
> > > > > > +
> > > > > >  #endif
> > > > > > --
> > > > > > 2.34.3
> > > > > >
> > > > >
> > > >
> > >
> >

