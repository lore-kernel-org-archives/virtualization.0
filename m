Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4619CD0B
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241845; cv=none; b=jzEAjTk8a9fdTbvCkRjOzvqOGCVzrHCi9xxAaiYVlN0dLDZ/gB2T4WKbfbMxYi+3dig51wvXQRzvSM09n5D5Eo/OlcHLRnKgYIzb4aVnAshTvFY/hylMurDok+Y7hCKcJ1LdYUkTmDzjPXFoessedK19wAsfocby9CZIE9OhGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241845; c=relaxed/simple;
	bh=rjouR878ufRtpHfKA5QsA0Rs0gIlZlAcJc/Bxy/ub0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyCl85TUujv3JDCkTuZLxwGNCIMv8lVS4rXGH/J9s8UutjWhuQ30qMi5rIMxQe+W0F9AJcg6Xo0PEeBcPEQtJiYU/9O+14YAOuO6XYmveShL3/oZMrFNyOuuXriRnWN8RHs8hDuqu90rwUKOowvR40d27HMLFexQsWPYSnkpJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RUMrHuTl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RUMrHuTl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4247f36f689so31516705e9.1
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719241840; x=1719846640; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8Eqy59QNWCHYRQMXXTrp6W0Jnunm51Ozr95NTCXvMc=;
        b=RUMrHuTlzB33Hg1VWmrlLAedJAGgej3vB8eTpHaFLH1eu8CGR0uPN4g3rUX1eNAY8V
         b7w/dG+QJQKqtAnfsja9OixPlMCSy4h47zlieJ34CLR9GbWUqucCuyE4EiMd8ggCvXNt
         ZyTY+v3K3z/ULkTx/U5Yvv39lLEPQjP+4ypdZd2I0VkaNioR5UoNhEYOhrgIr68pa0gh
         lCUiChlAWXK4T072xvBSFasUuqrDm+ZnZ9n1/sYcuC0c9mv5VZrrQI3sCJqNijtML9/I
         4dNxcP3/V+0j+dNGwXiY0d4vihRgy3n5qIhd+ggZ2eaA1qPqFvIgWsl2J1GlNu6h8+pW
         6bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719241840; x=1719846640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8Eqy59QNWCHYRQMXXTrp6W0Jnunm51Ozr95NTCXvMc=;
        b=IBckFrWEwnmo0AZ/oXEGCvLBce7YZ5V6o+RUiTmm6+PaDZ3ymmCSVUy4CLkH0xl8J0
         a8lCKmncELM3FPAGE1Mp7m4/4R8YHpYPqh/ErWdCEN4Yk6GDC6eHVXhPkkoezwaCPkjn
         c/8LwBGSpzjTRReRGvVicIM0gleSL2WRW+/PoTrELsX0XmJXTs6KBileDA8xN83dWY1D
         Mx/gnJXdhDtQDcFKWf59Kt49NCznGP/9WVLpmOsmhTykA8t2sKkKzTuE4FN4lNk2wbsx
         aORhJxCOxCGmqG0BGus/gAFA/b3mGseJifx7N7jtBPFdmob6akejN2BEzbw5KBLLqkt6
         4Lww==
X-Forwarded-Encrypted: i=1; AJvYcCVUWmhNjtSP0R9Z0kYvSqP95wylPvS9RpYv2JJIZg9B4IptX9tSxGOz/QNyRY23f6MkuMVS7qfrfZwqeBUwFxjyFZvPskT2JCpKEHSxlbs=
X-Gm-Message-State: AOJu0YxlSmqSQ4o6IDxpn98m1UG1lyKLbTEZXGllDGhBC9ZFhUKGclfR
	oGEEKo18zBfr9jDQYLfBMW6g8RxlkWPrBv/OkLfWoAJDYo+b59yhCN5a3Ophr2M=
X-Google-Smtp-Source: AGHT+IG59vW0iMofwmmtca1895vj4ObPPykdHn930zb/7gzITEDmZu1xbvsjwBCMLDmXXoCJmU9SQw==
X-Received: by 2002:a05:600c:340a:b0:421:7caa:7a6f with SMTP id 5b1f17b1804b1-4248b9cfaa6mr52113025e9.31.1719241840168;
        Mon, 24 Jun 2024 08:10:40 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0bea05sm176762665e9.18.2024.06.24.08.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:10:39 -0700 (PDT)
Date: Mon, 24 Jun 2024 17:10:36 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <ZnmMbPA--SyTF-6R@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624070832-mutt-send-email-mst@kernel.org>

Mon, Jun 24, 2024 at 01:23:01PM CEST, mst@redhat.com wrote:
>On Mon, Jun 24, 2024 at 05:53:52PM +0800, Heng Qi wrote:
>> On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> > From: Jiri Pirko <jiri@nvidia.com>
>> > 
>> > Currently the admin queue command execution is serialized by a lock.
>> > This patchsets lifts this limitation allowing to execute admin queue
>> > commands in parallel. To do that, admin queue processing needs to be
>> > converted from polling to interrupt based completion.
>> > 
>> > Patches #1-#6 are preparations, making things a bit smoother as well.
>> > Patch #7 implements interrupt based completion for admin queue.
>> 
>> Hi, Jiri
>> 
>> Before this set, I pushed the cvq irq set [1], and the discussion focused on the
>> fact that the newly added irq vector may cause the IO queue to fall back to
>> shared interrupt mode.
>> But it is true that devices implemented according to the specification should
>> not encounter this problem. So what do you think?
>> 
>> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/
>
>It's true - this can cause guest to run out of vectors for a variety of
>reasons.
>
>First we have guest irqs - I am guessing avq could use IRQF_SHARED ?
>I am not sure why we don't allow IRQF_SHARED for the config
>interrupt though. So I think addressing this part can be deferred.
>
>Second, we might not have enough msix vectors on the device. Here sharing
>with e.g. cvq and further with config interrupt would make sense.
>
>Jiri do you think you can help Heng Qi hammer out a solution for cvq?
>I feel this will work will then benefit in a similar way,
>and having us poll aggressively for cvq but not admin commands
>does not make much sense, right?


How about to enhance existing fallback in vp_find_vqs() to something
like this:

        /* Try MSI-X with one vector per queue. */
        err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, ONE_FOR_EACH_VQ, ctx, desc);
        if (!err)
                return 0;
        /* Try MSI-X with one vector per data queue, share one for the
         * rest of the queues and config. */
        err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, ONE_FOR_EACH_DATA_VQ_ONE_FOR_REST, ctx, desc);
        if (!err)
                return 0;
        /* Fallback: MSI-X with one vector for config, one shared for queues. */
        err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, ONE_DATA_VQS_ONE_FOR_REST, ctx, desc);
        if (!err)
                return 0;

I can implement this for admin queue, control queue can benefit from
this eventually.



>
>> > Patch #8 finally removes the admin queue serialization lock.
>> > 
>> > Jiri Pirko (8):
>> >   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
>> >   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
>> >   virtio: push out code to vp_avq_index()
>> >   virtio: create admin queues alongside other virtqueues
>> >   virtio_pci_modern: create admin queue of queried size
>> >   virtio_pci_modern: pass cmd as an identification token
>> >   virtio_pci_modern: use completion instead of busy loop to wait on
>> >     admin cmd result
>> >   virtio_pci_modern: remove admin queue serialization lock
>> > 
>> >  drivers/virtio/virtio.c            |  28 +----
>> >  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
>> >  drivers/virtio/virtio_pci_common.h |   9 +-
>> >  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
>> >  include/linux/virtio.h             |   2 +
>> >  include/linux/virtio_config.h      |   2 -
>> >  6 files changed, 150 insertions(+), 160 deletions(-)
>> > 
>> > -- 
>> > 2.45.1
>> > 
>> > 
>
