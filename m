Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7AD1D53C
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243944; cv=none; b=J8QOsFkx0bfLJw9ZwFcgMddut+PvhRtfN76xA7qUq0h2Rq0tTwVYllz5vFWIyf04Z0Gu1NOfY48Is+J7c6AxCvH0ZiZlyErNBSC0MpYZ3QdN9KDgtrLfmBjApCiNRRG4uFwspb815NEKh5UY6rTP+8kfr+rq7CPK0ZL9nb+NwuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243944; c=relaxed/simple;
	bh=2jt0mg7Iy5VwmJfDSlo4x06pZaRTfKfziw2iPrGfZwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0BldSXSdSRWkYDzi/wFZwxXMAtpIj4OfY2MFF1chSQzfOVhEpDRdcetpwKYBdb8iLxx6aceIwFwaWgad6psLvSDxBeIHu7+b1iLaZdA9OMQeqcMiCnk8YWupwHuAZxVyBxVhkZdFlMcdk2WvLtioeNb0ANMVjH3EMOlemq46q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=B7S1FSvn; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="B7S1FSvn"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52ce6c8db7bso1382250e87.1
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719243939; x=1719848739; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg1JqQSXLbU/YVUF8ztYgMYVPDWNzAIskXZ+m9Uefp4=;
        b=B7S1FSvnHGOLw1FnosnprcpOoatFhY3jdSN+x3yC9b1m9f4lytfztlBmoO1rNYNeQz
         6lROkYbM8x5lgnblry+44xg4YhqoONEUo3y/ebQpxnYVOP7HOSHw4KyoH1MpifOmeUoN
         zPgxMWpnpfFv66kd8d+UyepY1xhFxiBVs/VUT2rjTyO7515Uw7M0+hb/d0xWKRVDgdHp
         oLutjVr0rDQXruo15fx4BtBHcvNnwIBQoWtEAgRtIobQ9eki5ODKcRdngDDzkkuxbhH/
         d4f13oXBBfhRoNr7nanbQtaZ3iOZm5Jop1wDKC+LeGHVs4NjdxF6QZvzcKmFoXcnegXs
         zBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243939; x=1719848739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vg1JqQSXLbU/YVUF8ztYgMYVPDWNzAIskXZ+m9Uefp4=;
        b=seieh5jStaXrDpetcK3yuxN8pW0Tfrz2UkuTZ2kCVkRBBwAK09FGHM+vm4MR0+a6r2
         lwFCKzEtqBggkd17QDFscIVGZ+F+MQcdL9liIK8XDR8YC6BsovrU1pGmz1bEVyihPoXG
         6jpuf0mUIO42nFEIYm1Kk/ynB4ajoAy7DBhEzB0uPAVxcA61cJKez1RUnPkZMQGUSDut
         +CDkmt76mrmlCAUNFqMGOkAzR4NCz8eyEBtz3HVX/5t9IuQX73GRkA1zmfTwkrhPkPOg
         ethVcEaSHVzbZOhxHKgk7is1SXuxCVwEuq6EqHZfwq4eB917Dhx8ubNam58o9pVWx1Io
         ZRYA==
X-Forwarded-Encrypted: i=1; AJvYcCU7d4t7XDW+/Nx0PawSB2KvETOGh1Zb5eUXRDZ3RMOUjTV+jUSadD4MsxkN/VNZ0yxGcezLtGc5kEkF7eTuh0Vhy4Z5WxlMXal5eb2xzjg=
X-Gm-Message-State: AOJu0Ywqe5m7KlhUzodDsYcDafbCOL8kI7e8fPtFrdfkvkKycA2yclJj
	YAwsgvelKmoUW1qs1eJnctOB0iZUxEWSV0yVCjUxTJDcwFy+k0cXPseQBDaJfr8=
X-Google-Smtp-Source: AGHT+IE5Wp/8jxENXn1zvIqtBorr9z2jGTvMqsAlT/unpjcZMAC8O+FUWgideZUyRVLYMnqjmzuzjw==
X-Received: by 2002:a05:6512:3285:b0:52c:df9c:5983 with SMTP id 2adb3069b0e04-52ce183b3d6mr2607529e87.40.1719243939125;
        Mon, 24 Jun 2024 08:45:39 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c5492sm179991095e9.24.2024.06.24.08.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:45:38 -0700 (PDT)
Date: Mon, 24 Jun 2024 17:45:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <ZnmUnwufjp-iiF3W@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <ZnmMbPA--SyTF-6R@nanopsycho.orion>
 <20240624112114-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624112114-mutt-send-email-mst@kernel.org>

Mon, Jun 24, 2024 at 05:23:56PM CEST, mst@redhat.com wrote:
>On Mon, Jun 24, 2024 at 05:10:36PM +0200, Jiri Pirko wrote:
>> Mon, Jun 24, 2024 at 01:23:01PM CEST, mst@redhat.com wrote:
>> >On Mon, Jun 24, 2024 at 05:53:52PM +0800, Heng Qi wrote:
>> >> On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> >> > From: Jiri Pirko <jiri@nvidia.com>
>> >> > 
>> >> > Currently the admin queue command execution is serialized by a lock.
>> >> > This patchsets lifts this limitation allowing to execute admin queue
>> >> > commands in parallel. To do that, admin queue processing needs to be
>> >> > converted from polling to interrupt based completion.
>> >> > 
>> >> > Patches #1-#6 are preparations, making things a bit smoother as well.
>> >> > Patch #7 implements interrupt based completion for admin queue.
>> >> 
>> >> Hi, Jiri
>> >> 
>> >> Before this set, I pushed the cvq irq set [1], and the discussion focused on the
>> >> fact that the newly added irq vector may cause the IO queue to fall back to
>> >> shared interrupt mode.
>> >> But it is true that devices implemented according to the specification should
>> >> not encounter this problem. So what do you think?
>> >> 
>> >> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/
>> >
>> >It's true - this can cause guest to run out of vectors for a variety of
>> >reasons.
>> >
>> >First we have guest irqs - I am guessing avq could use IRQF_SHARED ?
>> >I am not sure why we don't allow IRQF_SHARED for the config
>> >interrupt though. So I think addressing this part can be deferred.
>> >
>> >Second, we might not have enough msix vectors on the device. Here sharing
>> >with e.g. cvq and further with config interrupt would make sense.
>> >
>> >Jiri do you think you can help Heng Qi hammer out a solution for cvq?
>> >I feel this will work will then benefit in a similar way,
>> >and having us poll aggressively for cvq but not admin commands
>> >does not make much sense, right?
>> 
>> 
>> How about to enhance existing fallback in vp_find_vqs() to something
>> like this:
>> 
>>         /* Try MSI-X with one vector per queue. */
>>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, ONE_FOR_EACH_VQ, ctx, desc);
>>         if (!err)
>>                 return 0;
>>         /* Try MSI-X with one vector per data queue, share one for the
>>          * rest of the queues and config. */
>>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, ONE_FOR_EACH_DATA_VQ_ONE_FOR_REST, ctx, desc);
>>         if (!err)
>>                 return 0;
>>         /* Fallback: MSI-X with one vector for config, one shared for queues. */
>>         err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, ONE_DATA_VQS_ONE_FOR_REST, ctx, desc);
>>         if (!err)
>>                 return 0;
>> 
>> I can implement this for admin queue, control queue can benefit from
>> this eventually.
>> 
>
>OKay superficially except in attempt 3 I would still combine
>adminq with config, for consistency.

Yeah, I thought about that when I wrote that. Makes sense.
I'm on it.


>
>> 
>> >
>> >> > Patch #8 finally removes the admin queue serialization lock.
>> >> > 
>> >> > Jiri Pirko (8):
>> >> >   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
>> >> >   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
>> >> >   virtio: push out code to vp_avq_index()
>> >> >   virtio: create admin queues alongside other virtqueues
>> >> >   virtio_pci_modern: create admin queue of queried size
>> >> >   virtio_pci_modern: pass cmd as an identification token
>> >> >   virtio_pci_modern: use completion instead of busy loop to wait on
>> >> >     admin cmd result
>> >> >   virtio_pci_modern: remove admin queue serialization lock
>> >> > 
>> >> >  drivers/virtio/virtio.c            |  28 +----
>> >> >  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
>> >> >  drivers/virtio/virtio_pci_common.h |   9 +-
>> >> >  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
>> >> >  include/linux/virtio.h             |   2 +
>> >> >  include/linux/virtio_config.h      |   2 -
>> >> >  6 files changed, 150 insertions(+), 160 deletions(-)
>> >> > 
>> >> > -- 
>> >> > 2.45.1
>> >> > 
>> >> > 
>> >
>
