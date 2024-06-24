Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265313A86A
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719236199; cv=none; b=I9DKr/+5I5QHgaz7XPN/yShdPVgip/1yhtirn1azXDPxmAEvGyjK48gT1sXEVBtQozzAmMrwTRTJvZxrr0O+Z0v++Pn/Pslb11w4EjbxRkbRZB2qYtQhH9ehSOsoicKE/GCzP9gCXe4Mzb/Wz5ihVULbFKJbsvjvS1Jpz6Goof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719236199; c=relaxed/simple;
	bh=jrAQB+NtOJFdpy9vclSM8pXj9uLaR7lRm1pasI22iUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7WgPHI1Kx9ZVLDUWP/+dg+nQ8nfNaGiUMErtt1/GvkJ5sTFNqQGmsevw9wccbhLL8DiDeZHr04LOB/nBtFJ9Pwp0WrT5cpeh/LuWZXFTpQ3WycsH+lYNcZCDbZxDnHRYJfHcHMscNQpKFJfTbiYP1AfFwIP1ZtfwzHUvwKbsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fnUx+aRa; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fnUx+aRa"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-36532d177a0so2748529f8f.2
        for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1719236196; x=1719840996; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QvSa8ig1h1vloKqUZrRh0kY1osvGu0BYmKQRWOKOHsU=;
        b=fnUx+aRa7w+8sfG2FvouhDg8a1iZiKsvuNyjpVfmN1Je+9pB/zVTX4yrOsIWuqHMGT
         n2Mv5+E3DVN9y5UBMkO3M9kgg6kwNFiUfyNO4EKIRDYVGcae/tOB9cuuW9Xg/EkuZO3A
         WzY4AJoLjOctdPwCkbGfw6ajZ31Q4+n4z/O8ZmAO41BXUYJUK2HMW+hlddM/hueDku3G
         bXObB+I8gCCPIuIlyKlrhglm7ZewREbve+4Xg4+IlzPAGIKbD15MK1NAAbVbQMEEe5Xo
         SRZkaRf7tXGWg4KXoUFsosKPJlw8T1ohw8hSTdIKiY0nRXIRdrw4IcrOgdZMIgziMUW9
         ++oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719236196; x=1719840996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvSa8ig1h1vloKqUZrRh0kY1osvGu0BYmKQRWOKOHsU=;
        b=F4q/3CYEWequIH6S2lRV0mlfAremMTQiZh6E969xijytRmu8ip+hrXdHzkvDLgTDH6
         zr67PPWJTWZETG/YwpejchEN4fWFCjTFOMRJpOw58RyYN4w69tBeOZk6Vk79IWW6jmqr
         dpmLsJeD8SO8p4EnReN6b75eHwQMPA4S7/7uelP9JAQO21PfLvGovh8yz6TGZfO3t65g
         n8RSjfl3t40ubEBbf7CzSavG3+yVcaFSilduV0lvUA0uA38q8azD8xurKgxPLk86EbMo
         dh+461js+Whkp+TzVwiqsOSIRkQWI2dMLC/bxqN4qK7kkAd4UYQoD3tGvOzzf63pAyQa
         Xt2Q==
X-Gm-Message-State: AOJu0YynK7WrOHJH28cOmHg/cdyKGBMp5Pq7Fdc00zkXKN+wAopmjKsy
	8Xg7zUElF2MhUpgca+42101+1w8S6Jn03v5mUaI1yeVehc0qt3ODpkLxbAEqJ+I=
X-Google-Smtp-Source: AGHT+IH6qTNIAl8FBtagpODQGTJbKW8dEZ/2vw9nirjMW62bcIRhObZR8oZQ8+ItklWL2uwUtAsX1A==
X-Received: by 2002:a05:6000:890:b0:35f:30ae:a6e4 with SMTP id ffacd0b85a97d-366e4f00a1dmr3407033f8f.46.1719236195681;
        Mon, 24 Jun 2024 06:36:35 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42481922428sm131256035e9.43.2024.06.24.06.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:36:35 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:36:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue
 commands execution
Message-ID: <Znl2X2ScZMKwXmo9@nanopsycho.orion>
References: <20240624090451.2683976-1-jiri@resnulli.us>
 <20240624070412-mutt-send-email-mst@kernel.org>
 <ZnlwADYkOQs9JClX@nanopsycho.orion>
 <20240624091517-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624091517-mutt-send-email-mst@kernel.org>

Mon, Jun 24, 2024 at 03:16:06PM CEST, mst@redhat.com wrote:
>On Mon, Jun 24, 2024 at 03:09:20PM +0200, Jiri Pirko wrote:
>> Mon, Jun 24, 2024 at 01:07:23PM CEST, mst@redhat.com wrote:
>> >On Mon, Jun 24, 2024 at 11:04:43AM +0200, Jiri Pirko wrote:
>> >> From: Jiri Pirko <jiri@nvidia.com>
>> >> 
>> >> Currently the admin queue command execution is serialized by a lock.
>> >> This patchsets lifts this limitation allowing to execute admin queue
>> >> commands in parallel. To do that, admin queue processing needs to be
>> >> converted from polling to interrupt based completion.
>> >> 
>> >> Patches #1-#6 are preparations, making things a bit smoother as well.
>> >> Patch #7 implements interrupt based completion for admin queue.
>> >> Patch #8 finally removes the admin queue serialization lock.
>> >
>> >Okay ... I assume this is infrastructure for some other need?
>> >I'll review, but I'd like to see this actually used.
>> 
>> No other need. The currently, admin queue cmds are serialized. Note that
>> admin queue is currently created for PF. If you have for example
>> multiple VFs in legacy mode reading and writing pci bar, that virtio
>> vfio driver translates it into admin queue commands. So for example
>> probe on multiple VFs gets serialized. This patchset makes it possible
>> to run in parallel.
>
>
>Well probe is mostly serialized but I think I get what you mean -

I mean probe of multiple VFs that belong under one PF.


>I am guessing you mean something else like legacy access commands.

Yes. For transitional VF, the legacy bar0 access is translated by
virtio vfio driver to admin commands. See virtiovf_pci_bar0_rw().


>> 
>> >
>> >
>> >> Jiri Pirko (8):
>> >>   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
>> >>   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
>> >>   virtio: push out code to vp_avq_index()
>> >>   virtio: create admin queues alongside other virtqueues
>> >>   virtio_pci_modern: create admin queue of queried size
>> >>   virtio_pci_modern: pass cmd as an identification token
>> >>   virtio_pci_modern: use completion instead of busy loop to wait on
>> >>     admin cmd result
>> >>   virtio_pci_modern: remove admin queue serialization lock
>> >> 
>> >>  drivers/virtio/virtio.c            |  28 +----
>> >>  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
>> >>  drivers/virtio/virtio_pci_common.h |   9 +-
>> >>  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
>> >>  include/linux/virtio.h             |   2 +
>> >>  include/linux/virtio_config.h      |   2 -
>> >>  6 files changed, 150 insertions(+), 160 deletions(-)
>> >> 
>> >> -- 
>> >> 2.45.1
>> >
>
