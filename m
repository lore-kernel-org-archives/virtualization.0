Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2B21B192
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758831010; cv=none; b=QrjaL8lvQGTIpyf1cesTngGnJimDsor+MLLFos2KHMxQAGnNEIPUqki3tsSkez9GBYE6UTrBBqZZ/A7lkpLsmtg8Gt/cawndy3cH5XEmYDwW+nN5y+njxH8fC7kEt4j9/U1ep5HU+Gnn0RIa3FPkchZh23/EXdEJ1vZi+ItOKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758831010; c=relaxed/simple;
	bh=5q9JIo3KLieaE5pI8ZxnPCMucm30a6FLRGi7TL7iPgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dx1bH9oUIZqF8T1Dlpr62xqE1h3ctdqdj+2ZjiGFNb8YNWxV160rr6xU3tSb7scw4v87Si5NuZeJ28LRLvw5pw5fhz1MKYXMmc1QtrFgYT40bKC0FnLY13486eQgHasKUj2acvL+J9RYOEVR1NTSxFYq8/ULtSacf15hfQg9eTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QX7bw5oZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QX7bw5oZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758831007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKUzh+6/MIhf5DygkxBAiYjFTYmRYgnUbT3TytAjqVI=;
	b=QX7bw5oZqrmxRfoYIB5foerOPWYt35qvFXrjB4VBxkPDtJPXruZz5C2lOr56zIS1yoSNVx
	UpNErSOoOxF2KY3ADXSBRkuIGmajCPuVMO9LdRbTJb6ysdiBPg7AwUmiOc0K8cBTGOUcjM
	iDJoZOIlO7QhJ9aWgespLn8bnw0aSGY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-NA6POlUyOKy9v4mCASiC5g-1; Thu, 25 Sep 2025 16:10:06 -0400
X-MC-Unique: NA6POlUyOKy9v4mCASiC5g-1
X-Mimecast-MFC-AGG-ID: NA6POlUyOKy9v4mCASiC5g_1758831005
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso8687805e9.0
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 13:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758831005; x=1759435805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKUzh+6/MIhf5DygkxBAiYjFTYmRYgnUbT3TytAjqVI=;
        b=nu6e5Y7YXPCq6yANXgN0zorxxA++5wo3CQbR2jbEbJFFDy2MtTHtyHwmHuUBrlbxvj
         0hhmR0ksLDLpJahxdwohQCpsaLaKmotroe//5PcRjSg+ekT+kDBSVZXoT/3N55s3i9pg
         7Qb8el293VIqVB4eSE0DOClu1xmtcVMAvEXZ9Sstca0wFDlPOIKY1BUbqvsvdbMcfzjd
         NUEMxwezHnW6vkFxd4898CxRWo0Hc53pLf1iGalp8OnjRcxPXhtBE8DgmyLguAYpBBea
         4fAsbr0jU55FWx2e2ffZwBEcQ/JzUw0Zd8lQFRERZuRp8r4JUu2iWmwpmC5qvs9jIPw1
         4IWA==
X-Forwarded-Encrypted: i=1; AJvYcCWVxCsCDtq8y8UhFeho2UjHwPPqkkrVHvYjEEtAoqgtiFtbm6W6NBOmebUvSm7Lfc+F8Oij4YFodcIsNztXUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFmk90uR3FqhU6oWqnc16tlgIPPKOUg07KX65ggVZX7cSNiGA8
	4J45jfXyT0ooLLytSjskQzeC9T9nhMEOH2fyJbCiG5IynNgTstlvUAsR6xNtaABFXRClKWmg995
	oNOZR30Hw9PgW1A6v6LdiagtMfaPvagDBa3Gew67g6UMJP79RolazqYeDP1i+InRt2cFR
X-Gm-Gg: ASbGnctK2FrGBzeUXqtL2DPfoRsxuEXIttwvfz4Lm1tlz24fiOFW1RIQWKJS3jjYs+H
	U3OluIZlNme+hh2WwtmkecHRHFXluMSRT0EOLhnFq+gHIqIIQtusDIGBOq+EgXO4M/6fzM7jRUM
	fp510XBdoaT2573Sp629K1NCl/L5QszZ4pYTTuaZPmlAhJT+WlV3c5BBul9vyTzhTHpSmEzofRv
	iB4bs+byDMscotGPXUHeSs7YCTz4kNyIDo6SMR2ETq6Hdpfwyb/bQPgR4EAu5B6ezmXVcsY3wCx
	Q56+WgWvUMkIRiD4NN94EEQx7WH+2owPiQ==
X-Received: by 2002:a05:600c:4ecc:b0:46e:33ed:bca4 with SMTP id 5b1f17b1804b1-46e33edbe6fmr36885845e9.15.1758831004764;
        Thu, 25 Sep 2025 13:10:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb0foLyn8BdOVO+XT9dVRVlV1ZV+l+zWtvaf06kGYu+7b1V0Ug6vXebnLP2usKOZV99mkksA==
X-Received: by 2002:a05:600c:4ecc:b0:46e:33ed:bca4 with SMTP id 5b1f17b1804b1-46e33edbe6fmr36885485e9.15.1758831004257;
        Thu, 25 Sep 2025 13:10:04 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72fb21esm4243920f8f.7.2025.09.25.13.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:10:03 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:10:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
	parav@nvidia.com, shshitrit@nvidia.com, yohadt@nvidia.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com, netdev@vger.kernel.org,
	jasowang@redhat.com, alex.williamson@redhat.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v3 03/11] virtio_net: Create virtio_net directory
Message-ID: <20250925160542-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-4-danielj@nvidia.com>
 <1758772569.13948-1-xuanzhuo@linux.alibaba.com>
 <20250925020502-mutt-send-email-mst@kernel.org>
 <5caddf7a-b67c-432e-8c32-9b9a134f8b00@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5caddf7a-b67c-432e-8c32-9b9a134f8b00@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mCm-BHSh8xaLUs5d1HtBeO1TMB5GwKgbO-5QCIPzG2o_1758831005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Sep 25, 2025 at 10:48:24AM -0500, Dan Jurgens wrote:
> On 9/25/25 1:13 AM, Michael S. Tsirkin wrote:
> > On Thu, Sep 25, 2025 at 11:56:09AM +0800, Xuan Zhuo wrote:
> >> On Tue, 23 Sep 2025 09:19:12 -0500, Daniel Jurgens <danielj@nvidia.com> wrote:
> >>> The flow filter implementaion requires minimal changes to the
> >>> existing virtio_net implementation. It's cleaner to separate it into
> >>> another file. In order to do so, move virtio_net.c into the new
> >>> virtio_net directory, and create a makefile for it. Note the name is
> >>> changed to virtio_net_main.c, so the module can retain the name
> >>> virtio_net.
> >>>
> >>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> >>> Reviewed-by: Parav Pandit <parav@nvidia.com>
> >>> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
> >>
> >> To help this work move forward smoothly, I don't recommend splitting the
> >> directory structure within this patchset. Directory reorganization can be a
> >> separate effortâ€”I've previously experimented with this myself. I'd really
> >> like to see this work progress smoothly.
> >>
> >> Thanks.
> > 
> > Indeed.
> 
> It's not a hill I'm willing to die on, but breaking this up into files
> makes sense. virtio_main.c is already huge, and this would make it 15%
> bigger.


Oh I agee - I think it's the largest single file driver now -
but let's do this on top pls.

And when we do it I'd like to see us split it up to some
logical chunks with as small interaction between them
as possible, and I want to see how they look.

And I think "ethtool support" would be a reasonable chunk,
for example, and this might be better as a part of it.


> > 
> >>
> >>> ---
> >>>  MAINTAINERS                                               | 2 +-
> >>>  drivers/net/Makefile                                      | 2 +-
> >>>  drivers/net/virtio_net/Makefile                           | 8 ++++++++
> >>>  .../net/{virtio_net.c => virtio_net/virtio_net_main.c}    | 0
> >>>  4 files changed, 10 insertions(+), 2 deletions(-)
> >>>  create mode 100644 drivers/net/virtio_net/Makefile
> >>>  rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (100%)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index a8a770714101..09d26c4225a9 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -26685,7 +26685,7 @@ F:	Documentation/devicetree/bindings/virtio/
> >>>  F:	Documentation/driver-api/virtio/
> >>>  F:	drivers/block/virtio_blk.c
> >>>  F:	drivers/crypto/virtio/
> >>> -F:	drivers/net/virtio_net.c
> >>> +F:	drivers/net/virtio_net/
> >>>  F:	drivers/vdpa/
> >>>  F:	drivers/virtio/
> >>>  F:	include/linux/vdpa.h
> >>> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> >>> index 73bc63ecd65f..cf28992658a6 100644
> >>> --- a/drivers/net/Makefile
> >>> +++ b/drivers/net/Makefile
> >>> @@ -33,7 +33,7 @@ obj-$(CONFIG_NET_TEAM) += team/
> >>>  obj-$(CONFIG_TUN) += tun.o
> >>>  obj-$(CONFIG_TAP) += tap.o
> >>>  obj-$(CONFIG_VETH) += veth.o
> >>> -obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> >>> +obj-$(CONFIG_VIRTIO_NET) += virtio_net/
> >>>  obj-$(CONFIG_VXLAN) += vxlan/
> >>>  obj-$(CONFIG_GENEVE) += geneve.o
> >>>  obj-$(CONFIG_BAREUDP) += bareudp.o
> >>> diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Makefile
> >>> new file mode 100644
> >>> index 000000000000..c0a4725ddd69
> >>> --- /dev/null
> >>> +++ b/drivers/net/virtio_net/Makefile
> >>> @@ -0,0 +1,8 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only
> >>> +#
> >>> +# Makefile for the VirtIO Net driver
> >>> +#
> >>> +
> >>> +obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
> >>> +
> >>> +virtio_net-objs := virtio_net_main.o
> >>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net/virtio_net_main.c
> >>> similarity index 100%
> >>> rename from drivers/net/virtio_net.c
> >>> rename to drivers/net/virtio_net/virtio_net_main.c
> >>> --
> >>> 2.45.0
> >>>
> > 

