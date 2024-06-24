Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBDE1DFEA
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242650; cv=none; b=l2iG7TzSAAsNZJM7RY3boFqwqHyiiBebk19pqrWf4Qn6y61LO4Bc/CyDOiaxcwfkVpMbQCbNZUfuUww9fYQ0wvGFT3I2cEtw0M7frXx9t4t/q1eSe2d6+jLkyrh/BxM818xZRwkScS6VWJLxA987yS5KHB3Q1BwdOlvh9GwjqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242650; c=relaxed/simple;
	bh=ViqQF+gWlL/SluvvDrcbQtNj+GdZx5rgwmPtL8Z+9Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gd2lqVms/q69WoYx6e+fECqTXgo6bQe54klNBmCWKsNlfSrpM1JFWcBmnY4SURMMJYOPfDV36b7muKP9cjh9rpNr5EadG2c13YqcVWk+nAsfKHuch9PcBTzkZLTBO61XlwP4090Ackn08bul/vq5g33gwT2LPVP4eEo5fjbzF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hh1NHgZT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hh1NHgZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719242647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PaoTMxaKs+L+juWwTLuyVoHyTVoPb/uqPpkJ5NrEhKc=;
	b=Hh1NHgZTdtG/nQgH9YVdq1m/+0Logt75v5pxpY0MYWiuGzu1pdhcmgC454PY8zFcTAUkjL
	Lbhq2TkLJjAviPSzjVAQs2LgdvVytwDEUankGxaQSCC45JmNGQkJVWJ4Gq2jIkdOmV2Xm3
	WJJ6NbTVjvkzM6/PBZnS2b9ik2uCY4w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-VU0Fu9rjO6exdl3hGC8lbg-1; Mon, 24 Jun 2024 11:24:04 -0400
X-MC-Unique: VU0Fu9rjO6exdl3hGC8lbg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ec584f36bfso13197421fa.3
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 08:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719242643; x=1719847443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaoTMxaKs+L+juWwTLuyVoHyTVoPb/uqPpkJ5NrEhKc=;
        b=tlBTeryoKEyn5Z+Q9GyjEo62U/QcZUJx5Wl7kw2tdBT0xSRVIyep/kaTT+2Rx8h/9d
         wvLKpUEbaTP+4YIauFTuEFDXTp8n64c01edXNvgQjR8FUy5jHFcsrrFKoxM/O/mq7NYU
         3Igx4iX1ErxYs1P1UWRRan/JeDfbCZiSbb2nZu0qRlJZcDu10VLPRctlc75GGLnWqoyy
         gHHEI8/00qaBlA/bI9XlfK56AgHYnZXq0E4Rc1M6waMZ6JAyenihcWjUT3MCoHCAO5fX
         /Rh4SUtcDYxQDLfw6fDSKm63MSb2UbP31txLKrt/Xrrhz7iT7VlOlFM7F5JIEZfcyM0a
         EHtA==
X-Forwarded-Encrypted: i=1; AJvYcCV391Z40Mnp37AWoO1/Urkl/YOJPimu+ARYqU9e5sWqYoS8hSvsmgxgzh3vZ0X1zbKq1NkBkBFPA4hb1ViwexhSQMYmpoVuy57X/8foIPA=
X-Gm-Message-State: AOJu0YwNPU8iSBwIxzRE9PT1j+QvtT0yGfBH3y0kzL1KCCxEWgW+G2Aq
	dM9S6f/9sePEHm4hy+Sicvkc+C5IenvVaykDLgx/840MerD+1c2uijHUm5UHuAljEhGSGhjhgv3
	l5nTnk73heekQ2sDflB7pMGsgbBYSGqXo9+KSKKhaH5+/fDT5hd6iNfFl/LHK9oI8
X-Received: by 2002:a05:651c:152:b0:2ec:4d82:9e93 with SMTP id 38308e7fff4ca-2ec5b39c278mr26925361fa.44.1719242642919;
        Mon, 24 Jun 2024 08:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqr4GKkVVNX9Y20bsixRM9vDYjBe4NOPANSfr7qI30iy7MmLKnBK1xulYb6s1Lmj5Gr6o0kQ==
X-Received: by 2002:a05:651c:152:b0:2ec:4d82:9e93 with SMTP id 38308e7fff4ca-2ec5b39c278mr26925181fa.44.1719242642112;
        Mon, 24 Jun 2024 08:24:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:f72:b8c7:9fc2:4c8b:feb3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f670csm10425013f8f.11.2024.06.24.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:24:01 -0700 (PDT)
Date: Mon, 24 Jun 2024 11:23:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Heng Qi <hengqi@linux.alibaba.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <20240624112114-mutt-send-email-mst@kernel.org>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <ZnmMbPA--SyTF-6R@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZnmMbPA--SyTF-6R@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 24, 2024 at 05:10:36PM +0200, Jiri Pirko wrote:
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
> >> 
> >> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/
> >
> >It's true - this can cause guest to run out of vectors for a variety of
> >reasons.
> >
> >First we have guest irqs - I am guessing avq could use IRQF_SHARED ?
> >I am not sure why we don't allow IRQF_SHARED for the config
> >interrupt though. So I think addressing this part can be deferred.
> >
> >Second, we might not have enough msix vectors on the device. Here sharing
> >with e.g. cvq and further with config interrupt would make sense.
> >
> >Jiri do you think you can help Heng Qi hammer out a solution for cvq?
> >I feel this will work will then benefit in a similar way,
> >and having us poll aggressively for cvq but not admin commands
> >does not make much sense, right?
> 
> 
> How about to enhance existing fallback in vp_find_vqs() to something
> like this:
> 
>         /* Try MSI-X with one vector per queue. */
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, ONE_FOR_EACH_VQ, ctx, desc);
>         if (!err)
>                 return 0;
>         /* Try MSI-X with one vector per data queue, share one for the
>          * rest of the queues and config. */
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, ONE_FOR_EACH_DATA_VQ_ONE_FOR_REST, ctx, desc);
>         if (!err)
>                 return 0;
>         /* Fallback: MSI-X with one vector for config, one shared for queues. */
>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, ONE_DATA_VQS_ONE_FOR_REST, ctx, desc);
>         if (!err)
>                 return 0;
> 
> I can implement this for admin queue, control queue can benefit from
> this eventually.
> 

OKay superficially except in attempt 3 I would still combine
adminq with config, for consistency.

> 
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

