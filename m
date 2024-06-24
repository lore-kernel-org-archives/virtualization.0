Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9A19ADB5
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 14:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240706; cv=none; b=Ndq/5Rm7PC6Z3/8eORlnJZIKcjq+7s9KQKOdz2a/Wh7RSzf7ZNTpyi0t++VBEL5Hq85pGX3txSuUnMQn11ilZCQG/bIgwsQ0eZou98f3rNVRgF9II4/yAizmRJvsYZp1+tOv8qRCL2b5IuVQtUk9ZWpUxBfIZVGYT0z5IzfbtxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240706; c=relaxed/simple;
	bh=hnK/iYyRZ73Ofzt5ID2yzxcnXpzWtdm7j3R+zL16B0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkWOaQXRR3qq2BITxL1+KMzSiqxik/stSaAfoMkMiUNSeKkVssRIxdfslheYUYyD+912jUdnGfxjwRhF3MiI6vBb0ZOyYRq0ERsgLN9zcgGiCf8xBserS+RnIvgnsyYcHNcgE7q8JGlTheuK7+D140rgIordNI8ywIWyOfzow7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=F8E612Xh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="F8E612Xh"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52cd6784aa4so3352432e87.3
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719240701; x=1719845501; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W5awh5YvrGcErOGEPMJ3MjyyfzZXLx5oh6fERnq8amA=;
        b=F8E612XhsH9NofLS0HkfYmRd2VhGLkBTDN8SvVGD28ad4LViyFoVZX6PVE6bt2q6RT
         FPKXDeh9Li53YldVRo6ut9hLPoRFsuiERBTg5LW4PcaFEjhWqil9QfuIIS6YCMSa6k0i
         h+2cX8/lIV3Y3OKW+8qm25JfXqMI4l5NPflssOeL/zCo+X9jUaz/nWihHiQVTg7VDht/
         dDa0Y+Txz0B5QJ0yPq7owixaehytCxXj7Vsz7u1dRtPSYEgER65fUsZKnNvUS4cO6dGc
         VMzwc6DNC5HVDazp+3hlx6+t704SkQx9kJsEknnIWh69VI91ZCDou7umBAUH0C8yjZQo
         s0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240701; x=1719845501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5awh5YvrGcErOGEPMJ3MjyyfzZXLx5oh6fERnq8amA=;
        b=TYDaX/PWE8v7sroOopHu1yqno3oIqGcjavMEsnPjpQuP7K6qVKs2o4GDeEGq0H2nDJ
         V0G3Qs1xNRi+lREP3IgudYH2q5pjv1dJkCq4gVPJ6UeBSymfLuLut9D/0342jA0RpvI3
         YgiA/9lTmaZoW3l4x7kXc2yJoIR7quHqV02TI2J2z8Fre0sB9dwVf06TMxdMmUQCS2xi
         XA/up9ekRaCuD56wZODqQRRG81WXvmEvzvp4kidmTjCufSljNZnD6jfeJhBkCipwfuDM
         cS/ItfxDnLNF7Tm+B5rO/nTgbNXX0kRWtqtLyH4z6MwR1QvAMhczcI/N3AMuh2kY+IGz
         EOZw==
X-Forwarded-Encrypted: i=1; AJvYcCUTq6lUkwR4P1BhjrqRi8XJNCdqW/IihOIKL0OmQ+Auf8oJgDHQdJkf41+GsNv/SmjNqDV7+AiW30CloeE8EKRXqQ37nird1NbMBX/OGzY=
X-Gm-Message-State: AOJu0YwH2b1q1iNlVYIZP12oCOVhOBZlWGHN5ndw6vyd2I3ijqS/63bS
	2cEqawlzidKFCJ+oHJGz5gdQ007OeAK8OW9yitalgO3WE5Ly6lND/eLwOqIms0M=
X-Google-Smtp-Source: AGHT+IEPKA+5buHcPTm+JJrr75HmwtlmTHX+udXpDTRukTBjV7YzbZS1yi5YMMl0YXii46XF/192Ig==
X-Received: by 2002:ac2:5a5a:0:b0:52c:d90d:77aa with SMTP id 2adb3069b0e04-52ce1864861mr2851414e87.61.1719240700610;
        Mon, 24 Jun 2024 07:51:40 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d208b60sm177785705e9.37.2024.06.24.07.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:51:40 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:51:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, virtualization@lists.linux.dev
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <ZnmH-eMBfsPkDpkd@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <1719222832.5704103-18-hengqi@linux.alibaba.com>
 <20240624070832-mutt-send-email-mst@kernel.org>
 <Znl4q_ArglG1aqPv@nanopsycho.orion>
 <20240624095239-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624095239-mutt-send-email-mst@kernel.org>

Mon, Jun 24, 2024 at 03:55:53PM CEST, mst@redhat.com wrote:
>On Mon, Jun 24, 2024 at 03:46:19PM +0200, Jiri Pirko wrote:
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
>> 
>> Wait. Please note that admin queue is only created and used by PF virtio
>> device. And most probably, this is on hypervisor managing the VFs that
>> are passed to guest VMs. These VFs does not have admin queue.
>> 
>> Therefore, this is hardly comparable to control vq.
>
>
>Well Parav recently posted patches adding admin queue
>to VFs, with new "self" group type.

Right, but even so, when device implementation decides to implement and
enable admin queue, it should also make sure to provide correct amount
of vectors. My point is, there should not be any breakage in user
expectation, or am I missing something?


>
>
>> 
>> >> 
>> >> [1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/
>> >
>> >It's true - this can cause guest to run out of vectors for a variety of
>> >reasons.
>> >
>> >First we have guest irqs - I am guessing avq could use IRQF_SHARED ?
>> 
>> There is no avq in quest, under normal circumstances. Unless for some
>> reason somebody passes trough virtio PF into guest.
>
>
>At the moment, but this will change soon.
>
>
>> 
>> >I am not sure why we don't allow IRQF_SHARED for the config
>> >interrupt though. So I think addressing this part can be deferred.
>> >
>> >Second, we might not have enough msix vectors on the device. Here sharing
>> >with e.g. cvq and further with config interrupt would make sense.
>> 
>> For cvq irq vector, I believe that sharing with config irq makes sense.
>> Even for admin queue maybe. But again, admin queue is on PF. I don't
>> think this is a real concern.
>> 
>> 
>> >
>> >Jiri do you think you can help Heng Qi hammer out a solution for cvq?
>> >I feel this will work will then benefit in a similar way,
>> >and having us poll aggressively for cvq but not admin commands
>> >does not make much sense, right?
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
