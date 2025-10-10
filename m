Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5B2C0F6E
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089312; cv=none; b=oiLjbOV1nc5NcQ+rXsYahYGw3sBGvVDvGOyhW3hn/Em3YpdQUDgnzqU9V2pcUDrEjuVMPSN7zYpMEdwdDrwY4v+kahXXQETKg55kRBcMtT+rHKh/liEKVOx4OC09RshQivQg5osROaBRwDhKMn/kIXHk1jCyR66oosCubvf0zJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089312; c=relaxed/simple;
	bh=TCxe8AKQudXrjI6Ezcpx/IM4UKhmFZ9JhyxcqMdvoqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qygkl8gU/Zc1/2j1NUjrlhLkriSuyj3lWlnsVwfz91uq9lDNW9/3d4Uds/5BX8pipDCi0wjjbJaMp/Pmk7/SdCBUTeK8sLe8EkaQoxkbq/Y4IXbJaqWceuJhj+ZFeRdc3oRS+zcJB7mIPy4cuVjxBk7yeaLZzLNEwnBItaH0/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H8b8ePCk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H8b8ePCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760089304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRU9De0ZG84MmWJ0E/AfuolzoTzmUWqKv+6ReOBq7PQ=;
	b=H8b8ePCkmRn3O59KXWpVmnNXrya1pscFG0bFMutIKIlcA+WO8rPCXLWnGMSOXBuQG9ch85
	VqhETGOTpR73jFw+xL90y5ogcPigzUIA48ZLAhC8G2cAqAnPWCTIhwgMoEvgLlsNfIeUjJ
	8DEeiBLAOFDp+Q+oT5wDKtaGxie6eu4=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-9eoLAS66P2uBO3MxVjDsGQ-1; Fri, 10 Oct 2025 05:41:42 -0400
X-MC-Unique: 9eoLAS66P2uBO3MxVjDsGQ-1
X-Mimecast-MFC-AGG-ID: 9eoLAS66P2uBO3MxVjDsGQ_1760089302
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-633afc46d21so4153453d50.2
        for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 02:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760089302; x=1760694102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRU9De0ZG84MmWJ0E/AfuolzoTzmUWqKv+6ReOBq7PQ=;
        b=nG6Xi1WiB+ieIJk7NXvURnENXBIR+fyJXpa6jIw0BMr8nUlvtt0ZP4QBl0cOTjOsAl
         FiGQv5gVEWNTYHFnbeImkj/Bbx+DgvXh5pC9IQr62f6IzoBcvX1LggNf5DSXYBYlBe02
         qbFtmOOOwk3wiz+onZ6vGFV/q0Fkp1R9KHMZ3kRwwvvDYPavUktD90mDngv0YOmmcc3R
         SUzZOkhpEdTC+QmeOnA4/YXJkJ48IiQEpW+5m6QQSKziaJMsU7nqG4wAANEpddmeSv1X
         WGdKsaQ7PDenWI7pFwqijdwzQJ1jTVGCFPA5SY55m/JUMbOAhPJNZwSlNjXNHnpRuR2/
         MJGg==
X-Forwarded-Encrypted: i=1; AJvYcCVZVV7ZIzwM0bjEph3Ppi8ZjtCgwQNr9c/61dEgDP2dNmi1Z0fAcy7QaOQOQgzQfL1x7kFEtD/mZjuId2aNig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxn2frMa49RXE7Gyqo014e9hPSOkess8dvcTsCNs7xpXEzlDLXm
	nO1cRPx+7XWzyqD/Ne1/8BTZC8YKcohuMrwiZYMmiR5ibhD6Q7SA2cBTdAnH7dFdmfOPby/sUap
	xqoQbd0ZvRSypl3G6oBMGawtiM+nzNUt9mQ4Gc8lSBLEIOKFe+hGmpq94yF5fm2UOhnt//MHP8I
	xDOLIzvb2BlPq7iIRyL/YZXzbhTDhpiOHoWceWXT8biBE=
X-Gm-Gg: ASbGncvAF+iJoAsA1X/+J28qlZAdOctaF9KwNIRnWolsgRGfkuBdR5EeektPdH4/FEM
	onpGXEB2WT0xtdGYcL5S9rkHNLNx02Dk3S4XMufe5JUeDAP1IK6bb5S622hGjWXSWFBwJArt3g0
	Ui8ag8HQFJiJAJ150+RxiqSfyGupJh7PgIzOWtKeh0O39Wuk6f1iNrXhfr6x7l+FEjCQRdNGEVl
	tFgkh2C
X-Received: by 2002:a53:e02a:0:b0:63b:6340:8e64 with SMTP id 956f58d0204a3-63ccb9030ccmr7879081d50.39.1760089301984;
        Fri, 10 Oct 2025 02:41:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlUiPsiwWpvI3oTDKYUNUVRFCMnRJmvebTbfIc4uDv865d8wTOTnPHEKhrULJ+5FLnqrcuR9Jto3LombTI4u4=
X-Received: by 2002:a53:e02a:0:b0:63b:6340:8e64 with SMTP id
 956f58d0204a3-63ccb9030ccmr7879067d50.39.1760089301559; Fri, 10 Oct 2025
 02:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251002103537.308717-1-eperezma@redhat.com> <20251002103537.308717-2-eperezma@redhat.com>
 <59eb64f1-7019-450d-96bb-a9398d2af602@oracle.com>
In-Reply-To: <59eb64f1-7019-450d-96bb-a9398d2af602@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 10 Oct 2025 11:41:05 +0200
X-Gm-Features: AS18NWCjM5wvi9XlNJHpYwkkr8FMsHSPm7e0O_6hZ2XlqsH_hMhNdnOb8X4OZb4
Message-ID: <CAJaqyWcxooE69w+P-M24FTkKi37WGthrhhdJ0BC+GBQV0xxngg@mail.gmail.com>
Subject: Re: [RFC 1/2] vduse: support feature provisioning
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: mst@redhat.com, Laurent Vivier <lvivier@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Dragos Tatulea DE <dtatulea@nvidia.com>, Cindy Lu <lulu@redhat.com>, 
	Maxime Coquelin <mcoqueli@redhat.com>, Yongji Xie <xieyongji@bytedance.com>, jasowang@redhat.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	Jonah Palmer <jonah.palmer@oracle.com>, virtualization@lists.linux.dev, 
	=?UTF-8?Q?Be=C3=B1at_Gartzia_Arruabarrena?= <bgartzia@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GGZECsoMQ4wleotQow_DEf6ATj61Zk74Z_fNmBRDXL4_1760089302
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 6:40=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/2/2025 3:35 AM, Eugenio P=C3=A9rez wrote:
> > This patch implements features provisioning for vduse devices.  This
> > allows the device provisioner to clear the features exposed by the
> > userland device, so the driver never see them.  The intended use case i=
s
> > to provision more than one different device with the same feature set,
> > allowing live migration between them.
> >
> > The device addition validates the provisioned features to be a subset o=
f
> > the parent features, as the rest of the backends.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   drivers/vdpa/vdpa_user/vduse_dev.c | 17 ++++++++++++++---
> >   1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_use=
r/vduse_dev.c
> > index 6c74282d5721..ef8fc795cfeb 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -121,6 +121,7 @@ struct vduse_dev {
> >       bool connected;
> >       u64 api_version;
> >       u64 device_features;
> > +     u64 supported_features;
> >       u64 driver_features;
> >       u32 device_id;
> >       u32 vendor_id;
> > @@ -698,7 +699,7 @@ static u64 vduse_vdpa_get_device_features(struct vd=
pa_device *vdpa)
> >   {
> >       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >
> > -     return dev->device_features;
> > +     return dev->supported_features;
> >   }
> >
> >   static int vduse_vdpa_set_driver_features(struct vdpa_device *vdpa, u=
64 features)
> > @@ -2256,13 +2257,22 @@ struct vduse_mgmt_dev {
> >
> >   static struct vduse_mgmt_dev *vduse_mgmt;
> >
> > -static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name=
)
> > +static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name=
,
> > +                            const struct vdpa_dev_set_config *config)
> >   {
> >       struct vduse_vdpa *vdev;
> >
> >       if (dev->vdev)
> >               return -EEXIST;
> >
> > +     if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> > +             if (config->device_features & ~dev->device_features)
> > +                     return -EINVAL;
> > +             dev->supported_features =3D config->device_features;
> > +     } else {
> > +             dev->supported_features =3D dev->device_features;
> > +     }
> > +
> Why this feature filter can't be done in the client (library) of vduse
> itself, similar to other device specific features of the existing vduse
> client? I thought those vduse clients are never managed by vdpa tool,
> while the device class can't be bound until client had registered with
> vduse. What is the point to define the feature bit in one place, but the
> value of the feature (for e.g. mac, mtu) is still or has to be provided
> by the client itself? Is it the right behavior to filter features in a
> separate layer rather than contain all relevant feature bits and
> attributes in one central location?
>

Maxime can expand on this, but the user of the vdpa command should not
need to know if the backend device is VDUSE, HW, or other device: It
should just call the vdpa command the same way, and expect the same
results.

That also implies that it should handle the same way if a HW device
has its own MAC address and then you set a different one with the vdpa
command, but device_featues just came first in the pending list :).

