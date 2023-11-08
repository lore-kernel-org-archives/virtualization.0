Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A1ECF
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAp9XLbR"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5047840583
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 03:04:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5047840583
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BAp9XLbR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ALiYkspcKDad
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 03:04:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 46DC440195
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 03:04:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 46DC440195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699412642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1LQ97ddUdIP3S349Nk8ZXmiilx7zt+gyQAEPt1RKwk=;
	b=BAp9XLbR7HEoy/X9GLv3H42I3WPRhx6+bWdNABCMBszLihXXu6CiW+D0k0mrGg34xLRa6q
	6dW+o9HCOJaDH/4g0VPUFx4U57JkhojBxm+c5i5Y+op5S5cB5cnk43JD7g9SNaPrpyYuVr
	TD2UM2XRVor79ruDut0IZETdr8T6j6A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-6J-Wu1_YN2SixvwwORZXjQ-1; Tue, 07 Nov 2023 22:04:00 -0500
X-MC-Unique: 6J-Wu1_YN2SixvwwORZXjQ-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507f20a111fso208151e87.0
        for <virtualization@lists.linux-foundation.org>; Tue, 07 Nov 2023 19:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412639; x=1700017439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1LQ97ddUdIP3S349Nk8ZXmiilx7zt+gyQAEPt1RKwk=;
        b=QR2wrT+TAByQdqdMu0fOYD31hMRlSX9yxa4XkqIGi+8Orak1XlPqI1ToAqM4RRU9EX
         PrxDD92h2dDJW8mMROG2rC8A1SAkLK+bFcHrGvj1aOOo+YN6II4q8anDbEYFZqUlkivj
         iS6PdrMpzr2EV+1BiwzQElG9fhQyb6RRaapPyeJ3WakVV7GfqCoDMnN+SknEAQfT78jl
         2p5GVh3C9bYGvDQ8GGYvMzgDiRp5Xw/Ixr2wj/3nOagfbI6yTDJpUVSvKhtXYqlpE2sj
         vrxi7eCmlfv8/qAOcoBS09aS20KjqpG3Z67y6pXdjiWt0LwNVPS2sFs/5kJ3BCg6IsGv
         59oQ==
X-Gm-Message-State: AOJu0Yx4S50v75Qd//eJhzzR+MNjrcGR5td9xXtma7RsyTT+f7ZFUkl5
	13Ar1JaxifrVl105UWdEBxUxac+cteJzhnSB3Wldj6lULgXyei7UZ5phdGVTNGG6Uc72t4Gv5xi
	eA97RgPUpdIYn3HcCLTnX+d5FIObFxOPDITI0AUyUWHCdQGx18/46dj6snw==
X-Received: by 2002:a05:6512:3910:b0:509:4d3f:a1c4 with SMTP id a16-20020a056512391000b005094d3fa1c4mr185162lfu.12.1699412639367;
        Tue, 07 Nov 2023 19:03:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/WtWEcYVrA6P1JEZ/+s4O/JbYCESejqz6Phd8UEmQIVsvMMk65SthMYJwstqiEzC8DRLJGzSaYpA8nNqIY1Y=
X-Received: by 2002:a05:6512:3910:b0:509:4d3f:a1c4 with SMTP id
 a16-20020a056512391000b005094d3fa1c4mr185156lfu.12.1699412639102; Tue, 07 Nov
 2023 19:03:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-9-lulu@redhat.com>
 <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com> <CACLfguUPZVY2HDBoir67u0CeR3A9wHjCGvuc3cGLe0L43f8jkg@mail.gmail.com>
In-Reply-To: <CACLfguUPZVY2HDBoir67u0CeR3A9wHjCGvuc3cGLe0L43f8jkg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Nov 2023 11:03:48 +0800
Message-ID: <CACGkMEuA3jg06s9wuxTL60geFm6+nnbEnYXvv8HhTgXoFHyJgQ@mail.gmail.com>
Subject: Re: [RFC v1 8/8] iommu: expose the function iommu_device_use_default_domain
To: Cindy Lu <lulu@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 2:10=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
>
> On Mon, Nov 6, 2023 at 3:26=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Sat, Nov 4, 2023 at 1:18=E2=80=AFAM Cindy Lu <lulu@redhat.com> wrote=
:
> > >
> > > Expose the function iommu_device_use_default_domain() and
> > > iommu_device_unuse_default_domain()=EF=BC=8C
> > > While vdpa bind the iommufd device and detach the iommu device,
> > > vdpa need to call the function
> > > iommu_device_unuse_default_domain() to release the owner
> > >
> > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> >
> > This is the end of the series, who is the user then?
> >
> > Thanks
> >
> hi Jason
> These 2 functions was called in vhost_vdpa_iommufd_set_device(), Vdpa nee=
d to
> release the dma owner, otherwise, the function will fail when
> iommufd called iommu_device_claim_dma_owner() in iommufd_device_bind()
> I will change this sequence, Or maybe will find some other way to fix
> this problem
> thanks

I meant exporting helpers needs to be done before the real users.

Thanks

> cindy
>
>
> > > ---
> > >  drivers/iommu/iommu.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 3bfc56df4f78..987cbf8c9a87 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -3164,6 +3164,7 @@ int iommu_device_use_default_domain(struct devi=
ce *dev)
> > >
> > >         return ret;
> > >  }
> > > +EXPORT_SYMBOL_GPL(iommu_device_use_default_domain);
> > >
> > >  /**
> > >   * iommu_device_unuse_default_domain() - Device driver stops handlin=
g device
> > > @@ -3187,6 +3188,7 @@ void iommu_device_unuse_default_domain(struct d=
evice *dev)
> > >         mutex_unlock(&group->mutex);
> > >         iommu_group_put(group);
> > >  }
> > > +EXPORT_SYMBOL_GPL(iommu_device_unuse_default_domain);
> > >
> > >  static int __iommu_group_alloc_blocking_domain(struct iommu_group *g=
roup)
> > >  {
> > > --
> > > 2.34.3
> > >
> >
>

