Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5987C1373
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 03:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZYok7l6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF97260E39
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 03:03:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF97260E39
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZYok7l6
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KmIYwVHDjyq
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 03:03:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7573660A94
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 03:03:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7573660A94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699412609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdkmOE2i/X8mF+g84XXuwPONDq0bjsNF8/LqNbQhs1I=;
	b=WZYok7l6a966HKtwKCNyjLBfYXALE8dJpgc2M9+RwJPuPHA9xR1pFFFfROnKlhlB6rj4zG
	AMqyxOgbATQ9K9yYv3BC/+KWu10tDAoZQxNUHTocRDO97Ji1lhZ8zA1Am+erDZE+azwkxq
	KjmD0MUQQSqryll+5Z9AkU7p7SFff0I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-ZuHC_4l8Prae1o5Ypem-Sg-1; Tue, 07 Nov 2023 22:03:25 -0500
X-MC-Unique: ZuHC_4l8Prae1o5Ypem-Sg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507ee71fc4eso6575111e87.2
        for <virtualization@lists.linux-foundation.org>; Tue, 07 Nov 2023 19:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412604; x=1700017404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdkmOE2i/X8mF+g84XXuwPONDq0bjsNF8/LqNbQhs1I=;
        b=ekm+LE7VCshzkLJysyBTeaFF+m3H5PYOEVJ+e+9cbe1aPrbBCAnkn13Mu+UwTHzn6G
         Q/bF0SH64r4WlKGsxbxEeMlrZyh3vg94k31yu69w2BBdrEQ9tTHbEMU88jd0ovHyb8pC
         Fx6s2YOSccqnJEhdlYGwU6aPBidUUO59b3GPPXLQ5MMvWHUWQHtJMy2HKhp41R4WYw+H
         46jE04Mj0FYP59DDdVzVktQIkA9Z3tVeDpjq0VE0lK/k3+HrHIENjDoCaTvmwOulYsku
         xYBPIGlP9xGA3d9RPgSvxw2ysgi/RjDfRtI/9BaMh1XmEFbPzKJzKRH2QBDr5fhQr073
         fHWw==
X-Gm-Message-State: AOJu0Yxu/zAFUxdrqkaGSja5u7SmCNw1Leeu3EKJ0FSAM1XBMSPQs30y
	EcBK5mLOBXlSFQktuTi7dIaB3YK91KW3WwPnMv4fSjaCTGJazuzv9oEpV/pBYzey831Bm/KbDmx
	vjLAVIs7Jxf/+hV91U89U9KdRXchTNjuSLzLyOc2iu5OcRmdQvmqLFvUVeg==
X-Received: by 2002:ac2:593b:0:b0:507:9a33:f105 with SMTP id v27-20020ac2593b000000b005079a33f105mr225713lfi.69.1699412603997;
        Tue, 07 Nov 2023 19:03:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfDeEEm3NoVSDw//ZEF2zrrCfMM8SZhj75WuhxEmVScFVNfxLlrPPD9qUMwz+h8100tBYfGU3SiaSXtv2KmjY=
X-Received: by 2002:ac2:593b:0:b0:507:9a33:f105 with SMTP id
 v27-20020ac2593b000000b005079a33f105mr225701lfi.69.1699412603658; Tue, 07 Nov
 2023 19:03:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-4-lulu@redhat.com>
 <CACGkMEtVfHL2WPwxkYEfTKBE10uWfB2a75QQOO8rzn3=Y9FiBg@mail.gmail.com> <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
In-Reply-To: <CACLfguX9-wEQPUyZkJZoRMmgPDRFNyZCmt0nvHROhyP1yooiYA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Nov 2023 11:03:12 +0800
Message-ID: <CACGkMEsp_rg+_01hwxCtZNOk2itB1L89mdOc1W1DG3umfEt5bw@mail.gmail.com>
Subject: Re: [RFC v1 3/8] vhost: Add 3 new uapi to support iommufd
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 2:57=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, Nov 6, 2023 at 3:30=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Sat, Nov 4, 2023 at 1:17=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > VHOST_VDPA_SET_IOMMU_FD: bind the device to iommufd device
> > >
> > > VDPA_DEVICE_ATTACH_IOMMUFD_AS: Attach a vdpa device to an iommufd
> > > address space specified by IOAS id.
> > >
> > > VDPA_DEVICE_DETACH_IOMMUFD_AS: Detach a vdpa device
> > > from the iommufd address space
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > > ---
> >
> > [...]
> >
> > > diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> > > index f5c48b61ab62..07e1b2c443ca 100644
> > > --- a/include/uapi/linux/vhost.h
> > > +++ b/include/uapi/linux/vhost.h
> > > @@ -219,4 +219,70 @@
> > >   */
> > >  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
> > >
> > > +/* vhost_vdpa_set_iommufd
> > > + * Input parameters:
> > > + * @iommufd: file descriptor from /dev/iommu; pass -1 to unset
> > > + * @iommufd_ioasid: IOAS identifier returned from ioctl(IOMMU_IOAS_A=
LLOC)
> > > + * Output parameters:
> > > + * @out_dev_id: device identifier
> > > + */
> > > +struct vhost_vdpa_set_iommufd {
> > > +       __s32 iommufd;
> > > +       __u32 iommufd_ioasid;
> > > +       __u32 out_dev_id;
> > > +};
> > > +
> > > +#define VHOST_VDPA_SET_IOMMU_FD \
> > > +       _IOW(VHOST_VIRTIO, 0x7F, struct vhost_vdpa_set_iommufd)
> > > +
> > > +/*
> > > + * VDPA_DEVICE_ATTACH_IOMMUFD_AS -
> > > + * _IOW(VHOST_VIRTIO, 0x7f, struct vdpa_device_attach_iommufd_as)
> > > + *
> > > + * Attach a vdpa device to an iommufd address space specified by IOA=
S
> > > + * id.
> > > + *
> > > + * Available only after a device has been bound to iommufd via
> > > + * VHOST_VDPA_SET_IOMMU_FD
> > > + *
> > > + * Undo by VDPA_DEVICE_DETACH_IOMMUFD_AS or device fd close.
> > > + *
> > > + * @argsz:     user filled size of this data.
> > > + * @flags:     must be 0.
> > > + * @ioas_id:   Input the target id which can represent an ioas
> > > + *             allocated via iommufd subsystem.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +struct vdpa_device_attach_iommufd_as {
> > > +       __u32 argsz;
> > > +       __u32 flags;
> > > +       __u32 ioas_id;
> > > +};
> >
> > I think we need to map ioas to vDPA AS, so there should be an ASID
> > from the view of vDPA?
> >
> > Thanks
> >
> The qemu will have a structure save and  maintain this information,So
> I didn't add this
>  in kernel=EF=BC=8Cwe can add this but maybe only for check?

I meant for example, a simulator has two AS. How can we attach an ioas
to a specific AS with the above uAPI?

Thanks

> this in
> Thanks
> Cindy
> > > +
> > > +#define VDPA_DEVICE_ATTACH_IOMMUFD_AS \
> > > +       _IOW(VHOST_VIRTIO, 0x82, struct vdpa_device_attach_iommufd_as=
)
> > > +
> > > +/*
> > > + * VDPA_DEVICE_DETACH_IOMMUFD_AS
> > > + *
> > > + * Detach a vdpa device from the iommufd address space it has been
> > > + * attached to. After it, device should be in a blocking DMA state.
> > > + *
> > > + * Available only after a device has been bound to iommufd via
> > > + * VHOST_VDPA_SET_IOMMU_FD
> > > + *
> > > + * @argsz:     user filled size of this data.
> > > + * @flags:     must be 0.
> > > + *
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +struct vdpa_device_detach_iommufd_as {
> > > +       __u32 argsz;
> > > +       __u32 flags;
> > > +};
> > > +
> > > +#define VDPA_DEVICE_DETACH_IOMMUFD_AS \
> > > +       _IOW(VHOST_VIRTIO, 0x83, struct vdpa_device_detach_iommufd_as=
)
> > > +
> > >  #endif
> > > --
> > > 2.34.3
> > >
> >
>

