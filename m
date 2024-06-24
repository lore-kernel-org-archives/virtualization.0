Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A6142635
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237364; cv=none; b=kSGQOEqh66zDPX3lewQvO34SECnRNUZSA5Yj2ZK90iLiJrTXkWGtLzN5NcIP7cnOsCvtj+kK74v4qDeO35kSnjK2GA+pk3Vo8KcBOrjmGiu7L2Sd2PdvOnsQoE341YVuNfrjQbGriLU6S++L004otCJFB5/ZeyYK7slULs14GAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237364; c=relaxed/simple;
	bh=0KAWka5+kPZhTIYr/7Dv4uYDRJBl1BNMbN/s7FiWa/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M+NFhTbx6lb21T7aeGvtqX/HJe4aCAiwgV5Sf+Ung1lg5Xqv8vWtba7yqEdXJlBBdNG7WpES/MZWQVCGhrwWRdyM1fkouvBAiNHON+RX416p9g5QXPzFy0RcdZNKhPN0qamr8r5ukbqISKA7ONs+3vpEzhplgrXx8TK9X8dZE3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyLaRvxx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyLaRvxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719237361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2o04lTmcmrjMqysaRuHA86FBr57g+H7lRo4DegWHVh0=;
	b=RyLaRvxx2hYh5vuRCwQCXYMDmAgWKpECPzj8F9w46quK6Em4hMDOvBbBoseuLunQgQQGlS
	YmizlXxITu+Snpf3hwuEGwaffle6a5eSq2UYwkHu+OyGCoun5DJwOe88ifiaMOTAa6yLek
	GbsKtrGO8JTKAMW/xpHXF2I0ZyP6OR0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-4MMKFePmNGSbmrNRmtax8Q-1; Mon, 24 Jun 2024 09:56:00 -0400
X-MC-Unique: 4MMKFePmNGSbmrNRmtax8Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6f5e82440cso272231266b.2
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 06:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237359; x=1719842159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o04lTmcmrjMqysaRuHA86FBr57g+H7lRo4DegWHVh0=;
        b=f77JL9iFREa/j5cTyvfyy59nOhnu4Xe3aBN2489lY9LZxevSH379vJfxu4zrT5jyi8
         wj0RfPqEy5cS98auSEFP8Fd9WF6OEIQLgqeQWU6uwE6SE5r5pcAgJJRAntmiEDhJRf3M
         l7SEGUHVfXeGtZ1nFMOrfDaUD8mZdv8auyZNgqh2ckcowfdkDE5C4uBVezkjMQVq3Jhv
         7LL3+QM5ak/aHHCBRM7nJ9ZSsWtKSEkeZWDSIrKoxro5LNKC+NBVM00AhTKQd9F0mbGR
         caI9JXYQQ69Ftq1r95ZR9pavTPowyQbdTpzhRACT48Syqy2n6XZT1BgFbnrL9fgnbKG6
         TRnw==
X-Forwarded-Encrypted: i=1; AJvYcCVS3Qi4mOdb52zep2POagy5gTv++3Msg5pRiwzS5qBoWkMTtw0Avj+5PvQWHXZ8iuIhTpoVLNaJQE3wldUbFvYf6qBjVnj5/YgJT3yn4CI=
X-Gm-Message-State: AOJu0Yzz/cjdks90oSSUgoSp8+6skU98lqOO6dLXaxVZeksikdMEQCrc
	Gsbr1hNjcTfvylRfWOZrC5y0xtcLTQpRzny6ijie0rs7TPrsKqLJYB/Ajak7G+DUh+5fB9MddBf
	rZFEk4+FPz/eZeTx1zrclgkUJNnu8Rca2+YuzUCJphlwlrQzCx6+ZdTLr7GvhB0hm
X-Received: by 2002:a17:907:7782:b0:a6f:a008:7f66 with SMTP id a640c23a62f3a-a7245b648ccmr287988366b.26.1719237358896;
        Mon, 24 Jun 2024 06:55:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHquNF0DS6lM4STtbBvZCu09KbzHXeU2Cscj7xthiRSKTbkuwed3BYxHP0q1mB6L7/GERR2Wg==
X-Received: by 2002:a17:907:7782:b0:a6f:a008:7f66 with SMTP id a640c23a62f3a-a7245b648ccmr287984666b.26.1719237358019;
        Mon, 24 Jun 2024 06:55:58 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a724fe5d3a8sm151848166b.75.2024.06.24.06.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:55:57 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:55:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Heng Qi <hengqi@linux.alibaba.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <20240624095239-mutt-send-email-mst@kernel.org>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <Znl4q_ArglG1aqPv@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <Znl4q_ArglG1aqPv@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 03:46:19PM +0200, Jiri Pirko wrote:
> Mon, Jun 24, 2024 at 01:23:01PM CEST, mst@redhat.com wrote:
> >On Mon, Jun 24, 2024 at 05:53:52PM +0800, Heng Qi wrote:
> >> On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> >> > From: Jiri Pirko <jiri@nvidia.com>
> >> > 
> >> > Currently the admin queue command execution is serialized by a lock.
> >> > This patchsets lifts this limitation allowing to execute admin queue
> >> > commands in parallel. To do that, admin queue processing needs to be
> >> > converted from polling to interrupt based completion.
> >> > 
> >> > Patches #1-#6 are preparations, making things a bit smoother as well.
> >> > Patch #7 implements interrupt based completion for admin queue.
> >> 
> >> Hi, Jiri
> >> 
> >> Before this set, I pushed the cvq irq set [1], and the discussion focused on the
> >> fact that the newly added irq vector may cause the IO queue to fall back to
> >> shared interrupt mode.
> >> But it is true that devices implemented according to the specification should
> >> not encounter this problem. So what do you think?
> 
> Wait. Please note that admin queue is only created and used by PF virtio
> device. And most probably, this is on hypervisor managing the VFs that
> are passed to guest VMs. These VFs does not have admin queue.
> 
> Therefore, this is hardly comparable to control vq.


Well Parav recently posted patches adding admin queue
to VFs, with new "self" group type.


> 
> >> 
> >> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/
> >
> >It's true - this can cause guest to run out of vectors for a variety of
> >reasons.
> >
> >First we have guest irqs - I am guessing avq could use IRQF_SHARED ?
> 
> There is no avq in quest, under normal circumstances. Unless for some
> reason somebody passes trough virtio PF into guest.


At the moment, but this will change soon.


> 
> >I am not sure why we don't allow IRQF_SHARED for the config
> >interrupt though. So I think addressing this part can be deferred.
> >
> >Second, we might not have enough msix vectors on the device. Here sharing
> >with e.g. cvq and further with config interrupt would make sense.
> 
> For cvq irq vector, I believe that sharing with config irq makes sense.
> Even for admin queue maybe. But again, admin queue is on PF. I don't
> think this is a real concern.
> 
> 
> >
> >Jiri do you think you can help Heng Qi hammer out a solution for cvq?
> >I feel this will work will then benefit in a similar way,
> >and having us poll aggressively for cvq but not admin commands
> >does not make much sense, right?
> >
> >> > Patch #8 finally removes the admin queue serialization lock.
> >> > 
> >> > Jiri Pirko (8):
> >> >   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
> >> >   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
> >> >   virtio: push out code to vp_avq_index()
> >> >   virtio: create admin queues alongside other virtqueues
> >> >   virtio_pci_modern: create admin queue of queried size
> >> >   virtio_pci_modern: pass cmd as an identification token
> >> >   virtio_pci_modern: use completion instead of busy loop to wait on
> >> >     admin cmd result
> >> >   virtio_pci_modern: remove admin queue serialization lock
> >> > 
> >> >  drivers/virtio/virtio.c            |  28 +----
> >> >  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
> >> >  drivers/virtio/virtio_pci_common.h |   9 +-
> >> >  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
> >> >  include/linux/virtio.h             |   2 +
> >> >  include/linux/virtio_config.h      |   2 -
> >> >  6 files changed, 150 insertions(+), 160 deletions(-)
> >> > 
> >> > -- 
> >> > 2.45.1
> >> > 
> >> > 
> >

