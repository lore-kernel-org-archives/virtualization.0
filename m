Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036B6FC0B
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2/SKDGA"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6641C83E78
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 09:03:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6641C83E78
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b2/SKDGA
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id srvng4twPwuF
	for <virtualization@lists.linux-foundation.org>;
	Thu, 11 Jan 2024 09:03:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6538C83E64
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 09:03:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6538C83E64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704963789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fiVGhyMQqpemmt2172xI1+ogtFZA6yGakCsHppFUzcE=;
	b=b2/SKDGA6xPEdQiosC5UBe1Azh2hBQURDvtzGDPszeOgqtIrHkcp8z/Uu0Kyj1F4iEetOO
	xe+pRhUfjAugCNQ279ijqF8VC/2Av7rP914tr1RO3AuaqwEihlb+MPXGrHjPzwZe5PyeRY
	HHPXNZOW/iGCseVBluEWELqb0KherNE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-jJalFTcTMcGvfFHx3Efz5w-1; Thu, 11 Jan 2024 04:03:07 -0500
X-MC-Unique: jJalFTcTMcGvfFHx3Efz5w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a2c2f913b25so27980666b.3
        for <virtualization@lists.linux-foundation.org>; Thu, 11 Jan 2024 01:03:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963786; x=1705568586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiVGhyMQqpemmt2172xI1+ogtFZA6yGakCsHppFUzcE=;
        b=ufmRbZ9/QF+1jsoqV7BcxjRKONcSz54azL5hrfyCFdOAnO0/9haJZRA95D8cHXkJsO
         OUfkEDIWlQG928Y8rP/BKssrz2tdWlxh9t1Tunj7o+Hg95XCtk+GuXsjZrmm/SxwP8Gp
         5ER/4bu2Vx8BiOgVHaZ2FTW8vpON9SePs9fQzaA88c6jXVUD8TeaTG4BEihm5Ykqmcko
         hG/6CS7BqrW4GM/TZfntoHbs8+m0SVWsIG2g+6kls+tyWeB270UOtRPf+sfz+52ny/Au
         +Hnu+TfkLIrBxwwjxcB/SxrT+V6nEH45YxDNvMqGuk5rfXHnqgPp57Zd8qzExOrOibUd
         ItxQ==
X-Gm-Message-State: AOJu0Yxjl57tjereAHs3eTVpntFDmkWB2yskgJml8rQzSoU7ZuG1NOnK
	v6PUP99urv7w2D1LLcPYacYDGrvhl8W7xaunFS0DV7vygJVIYJXL98u2FcssTuh9tonXHnDnKnc
	ZUiLRLAiU05Et2FmvnSqzSPZbT0s0alH0SA4iClxNhB1xtRK1V2C34SFvEEDE06n6/g==
X-Received: by 2002:a17:906:3542:b0:a29:40fe:254d with SMTP id s2-20020a170906354200b00a2940fe254dmr364318eja.69.1704963786583;
        Thu, 11 Jan 2024 01:03:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHK7Ui4uGInFgVXo+NZqkjdPTK8VVW9Bqv6J5hojrs+GmhQPMTzNaI+7+HiAGH04fzV7CRFN3n0SvAxRkyMRTk=
X-Received: by 2002:a17:906:3542:b0:a29:40fe:254d with SMTP id
 s2-20020a170906354200b00a2940fe254dmr364310eja.69.1704963786312; Thu, 11 Jan
 2024 01:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231103171641.1703146-1-lulu@redhat.com> <20240110172459-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240110172459-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 11 Jan 2024 17:02:27 +0800
Message-ID: <CACLfguVpiJY2h9MXEfJBEtaEeqaRnScp3X-SoAn7anPjqi9WiQ@mail.gmail.com>
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 6:25=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> >
> > Hi All
> > This code provides the iommufd support for vdpa device
> > This code fixes the bugs from the last version and also add the asid su=
pport. rebase on kernel
> > v6,6-rc3
> > Test passed in the physical device (vp_vdpa), but  there are still some=
 problems in the emulated device (vdpa_sim_net),
> > I will continue working on it
> >
> > The kernel code is
> > https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC_v1
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Was this abandoned?
>
Thanks Micheal. I'm really sorry for the delay. I will continue working on =
this
Thanks
Cindy
> >
> > Cindy Lu (8):
> >   vhost/iommufd: Add the functions support iommufd
> >   Kconfig: Add the new file vhost/iommufd
> >   vhost: Add 3 new uapi to support iommufd
> >   vdpa: Add new vdpa_config_ops to support iommufd
> >   vdpa_sim :Add support for iommufd
> >   vdpa: change the map/unmap process to support iommufd
> >   vp_vdpa::Add support for iommufd
> >   iommu: expose the function iommu_device_use_default_domain
> >
> >  drivers/iommu/iommu.c             |   2 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c  |   8 ++
> >  drivers/vdpa/virtio_pci/vp_vdpa.c |   4 +
> >  drivers/vhost/Kconfig             |   1 +
> >  drivers/vhost/Makefile            |   1 +
> >  drivers/vhost/iommufd.c           | 178 +++++++++++++++++++++++++
> >  drivers/vhost/vdpa.c              | 210 +++++++++++++++++++++++++++++-
> >  drivers/vhost/vhost.h             |  21 +++
> >  include/linux/vdpa.h              |  38 +++++-
> >  include/uapi/linux/vhost.h        |  66 ++++++++++
> >  10 files changed, 525 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/vhost/iommufd.c
> >
> > --
> > 2.34.3
>

