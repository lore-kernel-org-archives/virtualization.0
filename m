Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F8137758
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228192; cv=none; b=bdoR/Sfs5tQcwOt6tVgNvDVNQcgRc1aO8ks5w1lp4EQkRCJeNtbEQ8+U8b9W+qbjiUyIzB40JXnSHp42lk+PNy6wYA84wDFHdycs0jDUKzCpTtDYau6gYy8GVavzn1++3bfiI/vyoHiM8AVuiJzZLIYlN3fnEzpdHYT7VLr6qHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228192; c=relaxed/simple;
	bh=kfoYEVxCnFKrsOEhuBj3cMQghm85nDI3CqfpfH9f0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iUADT8mIYQfjTJNQ3CBC+o6NEB+jp+CkGY/oGqUrH9PFBOw3vn4B500XGsuDSHboKgwWIAxb9KkJizpaYq6tUhSROkOd6l0LqHRkaZeUfLNQc5Pq39hkIF0sf9lreHWjDHIVwyftgoBUcxgVOlGB6zVtiYyzxroLOFlQXvzn5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWAb/rZE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWAb/rZE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719228189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWJByxYHDfBxIsOEq0qxD1EoS2hNDTtDuS4FUaiFd2k=;
	b=XWAb/rZExBQ1fDENfJ/hKmdWc8mC6YN95+KTUaOlfU6IMwx5ALaaQ3Q7p3f0jVsS5brOfK
	IiZ0UY67SNihclHRTjfnz7Ew29hMHM8I47LkVoN/AWHQvgDRgBNWnkQ91dBZ44fiVb/PZF
	YhNQ1x+RSolDd7ShbFPyWaPdM3MUlzw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-76_CfvdSOVKtnb80PMjCkQ-1; Mon, 24 Jun 2024 07:23:07 -0400
X-MC-Unique: 76_CfvdSOVKtnb80PMjCkQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3625503233eso2588261f8f.0
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 04:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228186; x=1719832986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWJByxYHDfBxIsOEq0qxD1EoS2hNDTtDuS4FUaiFd2k=;
        b=m3DjwZSnkGmLouL2GAakvMLSyeyZMgzut1QXul7oBuqufAjF0YiFhyNS9cUNFmqvAy
         m8vXAeiHre7NtDmxzjrX/gROOUOE1k0LwDH2sQfB+FGO7O496kJGMfelGw82LOm14W70
         pG32bu7HLVAEmt/oHtc1b5Ayj/QlWwRoUwtZ/rO8OpIytjbbEDO78GKhF58XTBSsYQfC
         3yO9zAKf6E3KedmWh114h0XiovzzBhccoSM2fqRgtIUnuHIOAIV6DOPYxkUa7Z8fCTV5
         iO+0UwZ/Lsu6ycvpC+pfHXzKyR2tisInFXCGENxogqjMvZj8JJPAtNOO3ghh4/ShrkRF
         yyxg==
X-Forwarded-Encrypted: i=1; AJvYcCX87IQ0uF4KbebdkeuFikXq1ovZL3nA6geanuNOwgxOImnzWBjjupIEH+q2RIXmUDAmsU/AK/9WDGNh5apSlHK2mYVf+KPoGuqs3NFKz1E=
X-Gm-Message-State: AOJu0YxyT17vG0bqvvNx//7UzLhRUOYSx7kQ6tSiedDz13Dx59vQJ/Bn
	oDkdruoviTKnZs9XVRLEvGafJlJnCDKBi5e3maUeUU37AXNuNwO5IG/VBS8kYAa4zI2otOlU6Cn
	S/rxQRo1EoSuNA03JyjV8qF0a1PI+FaF6NR9moN868ZDn1a8jJ1xcUwmY0zlh3J+x
X-Received: by 2002:adf:eb06:0:b0:35f:204e:bcf0 with SMTP id ffacd0b85a97d-366e32693femr4390106f8f.13.1719228186257;
        Mon, 24 Jun 2024 04:23:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/YzkWpEeM43oGgwaqhSyYSFx9iDP54FpO67paAvoGqa8AyR2ttx5U9WYxviu/eoaTPGLA6g==
X-Received: by 2002:adf:eb06:0:b0:35f:204e:bcf0 with SMTP id ffacd0b85a97d-366e32693femr4390077f8f.13.1719228185462;
        Mon, 24 Jun 2024 04:23:05 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817ab01asm129621265e9.20.2024.06.24.04.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 04:23:04 -0700 (PDT)
Date: Mon, 24 Jun 2024 07:23:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jiri Pirko <jiri@resnulli.us>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <20240624070832-mutt-send-email-mst@kernel.org>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1719222832.5704103-18-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 05:53:52PM +0800, Heng Qi wrote:
> On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> > From: Jiri Pirko <jiri@nvidia.com>
> > 
> > Currently the admin queue command execution is serialized by a lock.
> > This patchsets lifts this limitation allowing to execute admin queue
> > commands in parallel. To do that, admin queue processing needs to be
> > converted from polling to interrupt based completion.
> > 
> > Patches #1-#6 are preparations, making things a bit smoother as well.
> > Patch #7 implements interrupt based completion for admin queue.
> 
> Hi, Jiri
> 
> Before this set, I pushed the cvq irq set [1], and the discussion focused on the
> fact that the newly added irq vector may cause the IO queue to fall back to
> shared interrupt mode.
> But it is true that devices implemented according to the specification should
> not encounter this problem. So what do you think?
> 
> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/

It's true - this can cause guest to run out of vectors for a variety of
reasons.

First we have guest irqs - I am guessing avq could use IRQF_SHARED ?
I am not sure why we don't allow IRQF_SHARED for the config
interrupt though. So I think addressing this part can be deferred.

Second, we might not have enough msix vectors on the device. Here sharing
with e.g. cvq and further with config interrupt would make sense.

Jiri do you think you can help Heng Qi hammer out a solution for cvq?
I feel this will work will then benefit in a similar way,
and having us poll aggressively for cvq but not admin commands
does not make much sense, right?

> > Patch #8 finally removes the admin queue serialization lock.
> > 
> > Jiri Pirko (8):
> >   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
> >   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
> >   virtio: push out code to vp_avq_index()
> >   virtio: create admin queues alongside other virtqueues
> >   virtio_pci_modern: create admin queue of queried size
> >   virtio_pci_modern: pass cmd as an identification token
> >   virtio_pci_modern: use completion instead of busy loop to wait on
> >     admin cmd result
> >   virtio_pci_modern: remove admin queue serialization lock
> > 
> >  drivers/virtio/virtio.c            |  28 +----
> >  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
> >  drivers/virtio/virtio_pci_common.h |   9 +-
> >  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
> >  include/linux/virtio.h             |   2 +
> >  include/linux/virtio_config.h      |   2 -
> >  6 files changed, 150 insertions(+), 160 deletions(-)
> > 
> > -- 
> > 2.45.1
> > 
> > 

