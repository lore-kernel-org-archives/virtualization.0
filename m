Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6523113D61A
	for <virtualization@lists.linux.dev>; Wed, 22 May 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381841; cv=none; b=VgaOnLC4gBs1Yv2ExEe9SC6UIFOQfwpu/AL1tDiwIInwbE6Y403a7lYo983L6y1CQHEvQyq/Lm2B+O8ef2nBlPsZTUUzIpMKxa2s178/jkBEKzAxQtCxhGswmBxhAP+rspxgHi2jPtnvCXmlg+k1cZNI/cFJwuWZ/KfpKfK4Xzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381841; c=relaxed/simple;
	bh=579+PwZAall9CCUoOjULlOHgIo8Ra+uTvd5iStPs+fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YX2rj5U2QnzCF2lI50LG7fdd/Ec86QMwS9aYwh/azed+MZeqmE1vUvSoqkHIh9IhnPSDOYactTZnPugk39HDVbZoY6xZxqCRilfJUlUn1z0Gx52jYAf3UsJf0Iecx4irTM25I8FeFrNcMdHJg/H/C9PEGeoMkL24qbI5t339dvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIb4zsM/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIb4zsM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716381838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KUgbrkFHxg4F+kRJ096ILydWxQUTBg55cdfx2xz7DQs=;
	b=MIb4zsM//phhMe9DD3D8BWq/u/D2MrJTolBH6gPlhbAk1xMZBI6VAZR0QS/LP71wcebKWB
	XuHVs4NP5Ta+cUYW2RfBDEySU/Fj6IcQqlhm+QcWCodb5pb4Kazz6blav9pghwFPcEy3aE
	06zO+iMQod+ByS/rQc78pXyvG1/kiKs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401--lForuQ-MZKC09pFW_miRw-1; Wed, 22 May 2024 08:43:54 -0400
X-MC-Unique: -lForuQ-MZKC09pFW_miRw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-351d13dd8aeso4005240f8f.2
        for <virtualization@lists.linux.dev>; Wed, 22 May 2024 05:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381833; x=1716986633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUgbrkFHxg4F+kRJ096ILydWxQUTBg55cdfx2xz7DQs=;
        b=G9WFRGNyPdlu6RJ/4IDHANujdaTn+ANTsofUZVv0JPsim7yY70i5dJuST3MdJwZbBf
         aDqD/UOTQGRzEPS+ryCoyOVsuZOwGSCKWevJhiFKRPJtcYhXAt41VsJGyTyxYlRtoqeq
         K++HzP9PdMJF79pk5Il8eS0SgDdEgyhKWJv2lxHBE1KO9Bg/L7L95HGCNMxSYy8R3env
         28FzcK7k63+vRygNrdBDZU2pUXFFbqW451TclQ1fjp77LNpabfGRttmjQhawojB8wmNR
         MZviRMxDRGupi1g+G9APquJ7mlQqtWLexdijqp1INLn3VCuh8v+5BvbJM/pyet0b+Cc8
         h6MQ==
X-Gm-Message-State: AOJu0YxgYHiSH7Od8OH7HMZKdNVjBiBJMrrqDy7zntQjc/5zQK5iYeEp
	FEaaNgi50Nnyz++L073q/CT57EbqXqLFdt0ndQdiccWlPlztNxsRsg+155aooxwKAJwOy8hY75a
	FwlKDQCBxOr/ba19JC9z9ztht3H1AYX+RyBvUygm6PuBM+1K0CqMK4Ouil5LAEIRy
X-Received: by 2002:a05:6000:d1:b0:354:c2c3:a319 with SMTP id ffacd0b85a97d-354d8dad7camr1537113f8f.61.1716381832829;
        Wed, 22 May 2024 05:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxFpLqeLCJUrO7rqx1MM8b891NleWkGLj5GGveBxw1L4XYP6vJDRZB7/pPW2A9B5hgEhmBdw==
X-Received: by 2002:a05:6000:d1:b0:354:c2c3:a319 with SMTP id ffacd0b85a97d-354d8dad7camr1537078f8f.61.1716381832095;
        Wed, 22 May 2024 05:43:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:e862:558a:a573:a176:1825])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354c7df311esm7583246f8f.3.2024.05.22.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:43:51 -0700 (PDT)
Date: Wed, 22 May 2024 08:43:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v9 0/6] refactor the params of find_vqs()
Message-ID: <20240522084221-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240522082732-mutt-send-email-mst@kernel.org>
 <1716381321.6426032-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1716381321.6426032-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 22, 2024 at 08:35:21PM +0800, Xuan Zhuo wrote:
> On Wed, 22 May 2024 08:28:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Apr 24, 2024 at 05:15:27PM +0800, Xuan Zhuo wrote:
> > > This pathset is splited from the
> > >
> > >      http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com
> > >
> > > That may needs some cycles to discuss. But that notifies too many people.
> > >
> > > But just the four commits need to notify so many people.
> > > And four commits are independent. So I split that patch set,
> > > let us review these first.
> > >
> > > The patch set try to  refactor the params of find_vqs().
> > > Then we can just change the structure, when introducing new
> > > features.
> > >
> > > Thanks.
> >
> > It's nice but I'd like to see something that uses this before I bother
> > merging. IIUC premapped is dropped - are we going to use this in practice?
> 
> 
> 1. You know this modification makes sense.
> 2. This modification is difficult. Unlike modifying virtio ring or virtio-net,
>    this patch set requires modifying many modules and being reviewed by
>    many people.
> 3. If you do not merge it now, then this patch set will most likely be
>    abandoned. And I worked a lot on that.
> 4. premapped has not been abandoned, I have been advancing this work. What was
>    abandoned was just virtio-net big mode's support for premapped.
> 5. My plan is to complete virtio-net support for af-xdp in 6.10. This must
>    depend on premapped.
> 
> So, I hope you merge this patch set.
> 
> Thanks.

If this makes thing easier for you, I can put it in my tree post
release. This way you do not need to keep reposting it.
I'll then merge it with premapped.


> 
> >
> > > v8:
> > >   1. rebase the vhost branch
> > >
> > > v7:
> > >   1. fix two bugs. @Jason
> > >
> > > v6:
> > >   1. virtio_balloon: a single variable for both purposes.
> > >   2. if names[i] is null, return error
> > >
> > > v5:
> > >   1. virtio_balloon: follow David Hildenbrand's suggest
> > >     http://lore.kernel.org/all/3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com
> > >   2. fix bug of the reference of "cfg_idx"
> > >     http://lore.kernel.org/all/202403222227.Sdp23Lcb-lkp@intel.com
> > >
> > > v4:
> > >   1. remove support for names array entries being null
> > >   2. remove cfg_idx from virtio_vq_config
> > >
> > > v3:
> > >   1. fix the bug: "assignment of read-only location '*cfg.names'"
> > >
> > > v2:
> > >   1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen
> > >
> > > v1:
> > >   1. fix some comments from ilpo.jarvinen@linux.intel.com
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > >
> > > Xuan Zhuo (6):
> > >   virtio_balloon: remove the dependence where names[] is null
> > >   virtio: remove support for names array entries being null.
> > >   virtio: find_vqs: pass struct instead of multi parameters
> > >   virtio: vring_create_virtqueue: pass struct instead of multi
> > >     parameters
> > >   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
> > >   virtio_ring: simplify the parameters of the funcs related to
> > >     vring_create/new_virtqueue()
> > >
> > >  arch/um/drivers/virtio_uml.c             |  36 +++--
> > >  drivers/platform/mellanox/mlxbf-tmfifo.c |  23 +--
> > >  drivers/remoteproc/remoteproc_virtio.c   |  37 +++--
> > >  drivers/s390/virtio/virtio_ccw.c         |  38 ++---
> > >  drivers/virtio/virtio_balloon.c          |  48 +++---
> > >  drivers/virtio/virtio_mmio.c             |  36 +++--
> > >  drivers/virtio/virtio_pci_common.c       |  69 ++++-----
> > >  drivers/virtio/virtio_pci_common.h       |   9 +-
> > >  drivers/virtio/virtio_pci_legacy.c       |  16 +-
> > >  drivers/virtio/virtio_pci_modern.c       |  37 +++--
> > >  drivers/virtio/virtio_ring.c             | 177 ++++++++---------------
> > >  drivers/virtio/virtio_vdpa.c             |  51 +++----
> > >  include/linux/virtio_config.h            |  76 +++++++---
> > >  include/linux/virtio_ring.h              |  93 +++++++-----
> > >  tools/virtio/virtio_test.c               |   4 +-
> > >  tools/virtio/vringh_test.c               |  28 ++--
> > >  16 files changed, 384 insertions(+), 394 deletions(-)
> > >
> > > --
> > > 2.32.0.3.g01195cf9f
> >

