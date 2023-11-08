Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F58CA70
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlcdwY3M"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6062E4071B
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 07:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6062E4071B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IlcdwY3M
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5HV3PW6kP3zW
	for <virtualization@lists.linux-foundation.org>;
	Wed,  8 Nov 2023 07:06:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B757340640
	for <virtualization@lists.linux-foundation.org>; Wed,  8 Nov 2023 07:06:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B757340640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699427166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DUoSm2Iv7a2UwdhQ6s1wKH58JFgFQEsPFOv1WpRND8=;
	b=IlcdwY3MTyg4kzhDWuWn944uTQHsE5EXNIaobWYcagJxsBbO01uKUaPTJTAxC3xrmRz/jr
	1+31cHvSgNFr4+RH2fklZ+PKPSova2yokpPKHWiyDpSCpzh0+Hz994eaOaI7oKN3PCLlkb
	PPtJ12MqwYQ7kBMUIWCDptQ3mwLdpE4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-wVlXeUuIMPuN2kK519aJdw-1; Wed, 08 Nov 2023 02:06:04 -0500
X-MC-Unique: wVlXeUuIMPuN2kK519aJdw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54461b294daso591389a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 07 Nov 2023 23:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699427163; x=1700031963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DUoSm2Iv7a2UwdhQ6s1wKH58JFgFQEsPFOv1WpRND8=;
        b=svKtASijwxyh/ElB4oGjp2mCKpXvD91hXDG4FLhSaHFOVRP00LQFZWh3HKL0wektp4
         U6z5+4hFXF9IZ60bfw0vgMaqDnR+WGOGx9vubJC+vl5kePi8vASeHSUwrQkpLKefovZE
         k0FKpcv6cT8j50YJHieohU8rT0RiGVgBjm7VzsDXZZUFwB0YO7u7iqe0C/BA6NPUb5kG
         GWh4zao9XoukZ/nVyQOkaPxONQ2wX7cUxwCEeAUxjFCxy3IoF/EXe7BFb9Z9GjAZb4k9
         ATMLsyCqby4bZ4Pbw+RePkL/juFTF8po1LdBHvnj70cfnf+WDqYrhuxdpXN9GW2/G8qn
         6N3Q==
X-Gm-Message-State: AOJu0Yz6q7BBpdu4fcJEsoExUzv+7stFTchb8dSVYy7AM+wlhiAn2kIG
	0wF7jY4G7Fwu2iKfjK9kae8tjVzWgbdYuJjPgJ3A/GY3GyQlNIQjMtsGZxeb4ixqJrbc75pObq2
	mOIYbyCnhO+Bs9AVU3rVhoCEhRyYuZvlPvvjWuZu8L438iaAYkhLoq1q4XQ==
X-Received: by 2002:a17:906:51d1:b0:9dd:be2b:34ea with SMTP id v17-20020a17090651d100b009ddbe2b34eamr4377395ejk.31.1699427163091;
        Tue, 07 Nov 2023 23:06:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDM7EhI+swyyvkDM3u6Pfk6QmXHKd/4wym/b/QMJOFFCkjCTPCMaznbGWByhlORtrmXpffeg/s+KQz4nYEGw8=
X-Received: by 2002:a17:906:51d1:b0:9dd:be2b:34ea with SMTP id
 v17-20020a17090651d100b009ddbe2b34eamr4377383ejk.31.1699427162806; Tue, 07
 Nov 2023 23:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20231103171641.1703146-9-lulu@redhat.com>
 <CACGkMEtRJ6-KRQ1qrrwC3FVBosMfYvV6Q47enoE9cE9C8MYYOg@mail.gmail.com>
 <CACLfguUPZVY2HDBoir67u0CeR3A9wHjCGvuc3cGLe0L43f8jkg@mail.gmail.com> <CACGkMEuA3jg06s9wuxTL60geFm6+nnbEnYXvv8HhTgXoFHyJgQ@mail.gmail.com>
In-Reply-To: <CACGkMEuA3jg06s9wuxTL60geFm6+nnbEnYXvv8HhTgXoFHyJgQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 8 Nov 2023 15:05:24 +0800
Message-ID: <CACLfguVny1MEOddJiQG4x5RWhxwF2OdzVtKcN3kVGtMP-2XXDQ@mail.gmail.com>
Subject: Re: [RFC v1 8/8] iommu: expose the function iommu_device_use_default_domain
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 11:04=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Tue, Nov 7, 2023 at 2:10=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > On Mon, Nov 6, 2023 at 3:26=E2=80=AFPM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Sat, Nov 4, 2023 at 1:18=E2=80=AFAM Cindy Lu <lulu@redhat.com> wro=
te:
> > > >
> > > > Expose the function iommu_device_use_default_domain() and
> > > > iommu_device_unuse_default_domain()=EF=BC=8C
> > > > While vdpa bind the iommufd device and detach the iommu device,
> > > > vdpa need to call the function
> > > > iommu_device_unuse_default_domain() to release the owner
> > > >
> > > > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > >
> > > This is the end of the series, who is the user then?
> > >
> > > Thanks
> > >
> > hi Jason
> > These 2 functions was called in vhost_vdpa_iommufd_set_device(), Vdpa n=
eed to
> > release the dma owner, otherwise, the function will fail when
> > iommufd called iommu_device_claim_dma_owner() in iommufd_device_bind()
> > I will change this sequence, Or maybe will find some other way to fix
> > this problem
> > thanks
>
> I meant exporting helpers needs to be done before the real users.
>
> Thanks
>
sure will fix
Thanks
Cindy
> > cindy
> >
> >
> > > > ---
> > > >  drivers/iommu/iommu.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > index 3bfc56df4f78..987cbf8c9a87 100644
> > > > --- a/drivers/iommu/iommu.c
> > > > +++ b/drivers/iommu/iommu.c
> > > > @@ -3164,6 +3164,7 @@ int iommu_device_use_default_domain(struct de=
vice *dev)
> > > >
> > > >         return ret;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(iommu_device_use_default_domain);
> > > >
> > > >  /**
> > > >   * iommu_device_unuse_default_domain() - Device driver stops handl=
ing device
> > > > @@ -3187,6 +3188,7 @@ void iommu_device_unuse_default_domain(struct=
 device *dev)
> > > >         mutex_unlock(&group->mutex);
> > > >         iommu_group_put(group);
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(iommu_device_unuse_default_domain);
> > > >
> > > >  static int __iommu_group_alloc_blocking_domain(struct iommu_group =
*group)
> > > >  {
> > > > --
> > > > 2.34.3
> > > >
> > >
> >
>

