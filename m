Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E162D9EDC
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780815; cv=none; b=iYvS3nYq+r6OrGrJJ0YmZ2h+WVai1bm31McUApub245T4bDJ3g4PpD6YeoD8LK+9S7tV/0RBx3QT6znpvj4N5f3Xr7WtbwNzH4NxZbgGFjBiDsd8Qi0fEcBy+L4unwS77pv+UgVMn8yMS5B1EnDWqOd6erdxWUpBFRE3XC1qRAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780815; c=relaxed/simple;
	bh=4OBMsQorin7i5YrnkLTLeZBVWNw5NVUTy6o8R3DlhAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dHC/Un4E2swPiOEgqQaLkv7sL2cwza/e8Nj1C6+aCoeZU3OUIfSdzj1sI4I7ksWod+mK/eAIKVTgP1VKzND4sipeP697FMEtb3BLsdHT4b4u7zt+cp+K6fAGvTrh9qdKw63YBQd1Tx2ubX42uYBdaPq86cSgsoMxG2SWID/8mxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=INdwuF10; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INdwuF10"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758780812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=779hgb75Reg08Cvo2KhD/Ld5MMgvSX2Yfj69Y+vZ9iA=;
	b=INdwuF10rxe/XQbwigQJjsok2adlj2phq8B7sOmExwbVftsYl/OixlVWLs29Q9KhdA7/ww
	FUjSlw1jw80zl7iw1m50TlkODVKBvQJrVpcBy3YT070V/b8jlZWuOHgciiBj73HoaOb4w5
	5bxzbvnJN+WL4FfWHykCes7nPRO/yeA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-22z6He12MeKoobDr5mq1yA-1; Thu, 25 Sep 2025 02:13:30 -0400
X-MC-Unique: 22z6He12MeKoobDr5mq1yA-1
X-Mimecast-MFC-AGG-ID: 22z6He12MeKoobDr5mq1yA_1758780810
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ee12ab7f33so342966f8f.2
        for <virtualization@lists.linux.dev>; Wed, 24 Sep 2025 23:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758780809; x=1759385609;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=779hgb75Reg08Cvo2KhD/Ld5MMgvSX2Yfj69Y+vZ9iA=;
        b=ef/jLqYZwabNVocGx/W2a4Qv8XBvfUG1kiWCdWUvQtY5SURUv5s/SlsT73rhqTa6H1
         Zyz4FjdBoDdoCoM6olyhn2GRCXBJ0qE/Nbwdz/epv2O/yFxt8Gm3gqf6tXcjL4Yv+rNd
         4JJTatQM8l2p7gqAkbZIU7SmmxurWwR++KwNiD/qBeSMCJi2K1A5dy4K+VRuGTN+Wq3t
         XNytJ3lUSMuri2E0+VkhpDiTyLcV5O+Hw62J1WRSkU03u6Wzmc/NHZufJ7WXme/JQOoZ
         hDkAz9S1JLc0tOYfmj+D6T4em/ssIFKt48Ljj+ol8Og/GMHteGdprOZHa+7JsLvUgFeN
         bA3A==
X-Forwarded-Encrypted: i=1; AJvYcCWhAMuH1C18/aXktSLkmBvj+Ps0jf/c9hbhytvmBQGPlshA6mtYLwW7kSqWCUN57SKi9fJH44FhWpfYVQywZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeiD+GhLaQwPzcOq6ajNsdLRFn7xpET3i/m3REN3f69NtHeJL0
	jq1FFSD9AhUHn3MnuN2QDWeGwcal5nsTcLEYaZyTcLu48WZtK6OLhRjO6G2XIBB3VaskBASjkzx
	EjFPGWdpeX1fVbfgHiawuqpyBt+X5dyqn1utzxNolbj1xsVcLmCZhNMKtKg2WJaMTPvFV
X-Gm-Gg: ASbGncurh22IQm2TKf+ntBsr0JnIQkApPDvzPyJbfs5S3phPLj8NSo0ZSjv0nAJ1K4a
	T8EjyHS9RuYQlPccMvw6RhZHDvr5dzzCq7XRPIhG0W8nPw+0jVSzJlUic3y6qiZj833fXU+Sz9u
	fmoz4/6D9DKl7Je0Ac8nmNocKBmq0lldPT6qJ6E90zxPV5KDxf+7AexBoyQ3/7KqOmDP7Kxsv5Q
	Er9TwNZ8K3DCCUKraDlcGRmb5CCxfYkaE5PdNSPnJi+nDOuVVhN75yhDXZnutgdRldIbR0bU5Cm
	+2Uyv/yp9h0d7Ra57Rmdh7jwbXmrt81nkw==
X-Received: by 2002:a05:6000:3101:b0:3eb:df84:60f with SMTP id ffacd0b85a97d-40e4cc62f3fmr2096300f8f.48.1758780809417;
        Wed, 24 Sep 2025 23:13:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd3gPUaddOxHhaM4zxRbAKZo3GkMqD8lYJqJHAkZBRMdwuYQbur7YGDLsrI8r4aB8V3WwUaw==
X-Received: by 2002:a05:6000:3101:b0:3eb:df84:60f with SMTP id ffacd0b85a97d-40e4cc62f3fmr2096264f8f.48.1758780808816;
        Wed, 24 Sep 2025 23:13:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fac4a5e41sm1575462f8f.0.2025.09.24.23.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:13:28 -0700 (PDT)
Date: Thu, 25 Sep 2025 02:13:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Daniel Jurgens <danielj@nvidia.com>, virtualization@lists.linux.dev,
	parav@nvidia.com, shshitrit@nvidia.com, yohadt@nvidia.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com, netdev@vger.kernel.org,
	jasowang@redhat.com, alex.williamson@redhat.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 03/11] virtio_net: Create virtio_net directory
Message-ID: <20250925020502-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-4-danielj@nvidia.com>
 <1758772569.13948-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1758772569.13948-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NLIod7obqhRH_FF9TDlJ0C9zucsq4UGj5hgtGom-kXY_1758780810
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Sep 25, 2025 at 11:56:09AM +0800, Xuan Zhuo wrote:
> On Tue, 23 Sep 2025 09:19:12 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> > The flow filter implementaion requires minimal changes to the
> > existing virtio_net implementation. It's cleaner to separate it into
> > another file. In order to do so, move virtio_net.c into the new
> > virtio_net directory, and create a makefile for it. Note the name is
> > changed to virtio_net_main.c, so the module can retain the name
> > virtio_net.
> >
> > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> 
> To help this work move forward smoothly, I don't recommend splitting the
> directory structure within this patchset. Directory reorganization can be a
> separate effortâ€”I've previously experimented with this myself. I'd really
> like to see this work progress smoothly.
> 
> Thanks.

Indeed.

> 
> > ---
> >  MAINTAINERS                                               | 2 +-
> >  drivers/net/Makefile                                      | 2 +-
> >  drivers/net/virtio_net/Makefile                           | 8 ++++++++
> >  .../net/{virtio_net.c => virtio_net/virtio_net_main.c}    | 0
> >  4 files changed, 10 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/net/virtio_net/Makefile
> >  rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (100%)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a8a770714101..09d26c4225a9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26685,7 +26685,7 @@ F:	Documentation/devicetree/bindings/virtio/
> >  F:	Documentation/driver-api/virtio/
> >  F:	drivers/block/virtio_blk.c
> >  F:	drivers/crypto/virtio/
> > -F:	drivers/net/virtio_net.c
> > +F:	drivers/net/virtio_net/
> >  F:	drivers/vdpa/
> >  F:	drivers/virtio/
> >  F:	include/linux/vdpa.h
> > diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> > index 73bc63ecd65f..cf28992658a6 100644
> > --- a/drivers/net/Makefile
> > +++ b/drivers/net/Makefile
> > @@ -33,7 +33,7 @@ obj-$(CONFIG_NET_TEAM) += team/
> >  obj-$(CONFIG_TUN) += tun.o
> >  obj-$(CONFIG_TAP) += tap.o
> >  obj-$(CONFIG_VETH) += veth.o
> > -obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> > +obj-$(CONFIG_VIRTIO_NET) += virtio_net/
> >  obj-$(CONFIG_VXLAN) += vxlan/
> >  obj-$(CONFIG_GENEVE) += geneve.o
> >  obj-$(CONFIG_BAREUDP) += bareudp.o
> > diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Makefile
> > new file mode 100644
> > index 000000000000..c0a4725ddd69
> > --- /dev/null
> > +++ b/drivers/net/virtio_net/Makefile
> > @@ -0,0 +1,8 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Makefile for the VirtIO Net driver
> > +#
> > +
> > +obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> > +
> > +virtio_net-objs := virtio_net_main.o
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net/virtio_net_main.c
> > similarity index 100%
> > rename from drivers/net/virtio_net.c
> > rename to drivers/net/virtio_net/virtio_net_main.c
> > --
> > 2.45.0
> >

