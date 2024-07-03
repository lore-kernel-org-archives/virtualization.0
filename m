Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F4133402
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013839; cv=none; b=lWIMbRjNUwfAvYe+t+CUfeIfg+vSBQPM/dVDdXiNN2KGUvg/BkBAa6CU/9r1IdtgYRXpdc9XvNok3ZU11LFwrtlrsJdV3Zg3CBW+cmwVMbTv58lvVONjgpQ+ll2yW0hePydlf3Is8za7hkzHtDWyQBIK0+4LU+Ph1YiYvHRkN6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013839; c=relaxed/simple;
	bh=pkoQFAJllfaJW9D1GSi9RXOYsMD1ZfXgo0MagKDG0lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZKcbZH9jhEWBwa1axpTWuHIdteL35sQ541penczOetIvb3nbnUpLyI/VJHbRu0+tJ1iClwjRfjScplPd4aSjKzW6RgpRHUFBIiP4k9J75bbJs4weg/34X0n9S1jdJ+BYSKo2/TuMQu+U0h8LNeXBBk5lR/mlPsiop0uJivh43Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3XZsjWn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3XZsjWn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720013836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ijw3XgP7/ZNwpNGsdhz+7ABq+72NLrNDHpr9peTi0fs=;
	b=d3XZsjWnEn3WprM7+EJRTI6c2fR48p48dKLhG0TPqvWGeXFTrFqMZIdpBjdVJTLx4eue1b
	D0O8Hmw8HuDFCMVljYsSJB+1S3XzfnqWzmhUi9SmlX9LKFprZxsBpBd0NG4aZNR2iM+7v9
	dRxVbqBoNHXb2nsWaFMqQllvUgS4mk4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-v28fGkyRMf67ZUNzGTXo_w-1; Wed, 03 Jul 2024 09:37:15 -0400
X-MC-Unique: v28fGkyRMf67ZUNzGTXo_w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4258675a4f9so21696265e9.2
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 06:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720013834; x=1720618634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijw3XgP7/ZNwpNGsdhz+7ABq+72NLrNDHpr9peTi0fs=;
        b=PqepZRbiQgB0rp5/KgWLjSa21KLXl5XLQJmH+uUzIMGE46Z+CkIk22GAGXJ3MwY6G6
         egJox9LYHt9gfOMDRtCu63DLPTsEHDZkueX2TzFsxmbK4hehqG+z0WTvV4NoBjWzgKNT
         nFrmNH8XEPbHkJcZ1H7qStVNhsChem9QmViYvHEXzEXpR52ig6ywZFFZbHWikDY2J8+z
         aUOrcuoUgjzxUAxLlUD1nOnsjCcV4RIaIpmh/1HUAJv61WcUYNI6fgSD6K1OzzmkE3MA
         2MMzJQA2FYY4HisZ51+ArxDwlpjvo4IGXNJn2DDKSaqlPUppQqw9itR0MqaGukQkrIBo
         JHxg==
X-Gm-Message-State: AOJu0YwQOyP9eSEKb0F9IimdAg7GbIGHQMsJ51rAnS9OzwAwpP2XERVs
	C6BKbZ5vTmDc/JloolZozZjWvOQj+Bhog3kF7nLUbl0NzYQzFjaeNNV+hjL7yNuBWfRnnVyWZlr
	w0VEeic7o04O4ast4Flj107sqH4+32Uzdwh5/+J9or4mtRfuRDWocYNxT77A2hOTG
X-Received: by 2002:a05:6000:ec7:b0:367:8a6f:8c0e with SMTP id ffacd0b85a97d-3678a6f8d51mr2442302f8f.21.1720013834179;
        Wed, 03 Jul 2024 06:37:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx4rUgVHAjRVe33VORZ5505LDEcH9fhuILwK/ll1IO9o1uSS+Kw+0mINY5aUPumg4Xb4cLeA==
X-Received: by 2002:a05:6000:ec7:b0:367:8a6f:8c0e with SMTP id ffacd0b85a97d-3678a6f8d51mr2442273f8f.21.1720013833527;
        Wed, 03 Jul 2024 06:37:13 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36796a6053fsm983983f8f.57.2024.07.03.06.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:37:13 -0700 (PDT)
Date: Wed, 3 Jul 2024 09:37:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio 00/19] virtio: consolidate vq info args of
 find_vqs()
Message-ID: <20240703093649-mutt-send-email-mst@kernel.org>
References: <20240703123913.969202-1-jiri@resnulli.us>
 <20240703084954-mutt-send-email-mst@kernel.org>
 <ZoVRIwZGbQNKwfqA@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZoVRIwZGbQNKwfqA@nanopsycho.orion>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2024 at 03:24:51PM +0200, Jiri Pirko wrote:
> Wed, Jul 03, 2024 at 02:50:36PM CEST, mst@redhat.com wrote:
> >On Wed, Jul 03, 2024 at 02:38:54PM +0200, Jiri Pirko wrote:
> >> From: Jiri Pirko <jiri@nvidia.com>
> >> 
> >> Currently, virtio_find_vqs() and virtio_find_vqs_ctx() accept array of
> >> names, callbacks and ctx (in case of the second one) as separate args.
> >> That became inconvenient as the ctx addition showed.
> >> 
> >> For virtio_net control queue, an indication of queue flavour (slow path)
> >> is going to be needed to be passed to PCI transport in order to
> >> assign vectors properly, another array added to virtio_find_vqs_ctx()
> >> arg list would not be nice and convenient.
> >> 
> >> Instead, introduce a structure to carry vq callback, name and ctx. Pass
> >> array of these structures to virtio_find_vqs() and all the way down to
> >> transport find_vqs() op implementation.
> >> 
> >> That allows to easily extend what needs to be passed down. Also, it
> >> makes the code a bit more cleaner. We get rid of separate
> >> virtio_find_vqs_ctx() helper.
> >> 
> >> This patchset does the conversion in steps, using temporary _info() op
> >> and helper. Note they are renamed back.
> >
> >Thanks a lot Jiri, looks very good.
> >Some minor comments.
> 
> Will fix and send v2 tomorrow. I have my admin queue patchset rebased on
> top of this and code will be ready for control queue to benefit from
> vector allocation.


Excellent, I hope it makes it in next in time for the next merge window.

> 
> >
> >
> >> Patch #1 does one forgotten conversion to virtio_find_single_vq().
> >> Patches #2 and #3 do preparations for find_vqs_info() op introduction.
> >> Patch #4 introduces new op find_vqs_info() to replace find_vqs() it also
> >>   introduces struct virtio_queue_info and virtio_find_vqs_info() helper.
> >> Patches #5 and #6 convert transports to implement find_vqs_info() op
> >>   that accepts array of virtio_queue_info structs.
> >> Patch #7 converts virtio_find_single_vq() to use the new way as well.
> >> Patch #8 removes original find_vqs() op.
> >> Patch #9 renames find_vqs_info() to find_vqs() and completes first part
> >>   of conversion this patches does.
> >> Patches #10-#17 convert virtio_find_vqs() and virtio_find_vqs_ctx()
> >>   users to use new virtio_find_vqs_info() helper.
> >> Patch #18 removes no longer used virtio_find_vqs() and
> >>   virtio_find_vqs_ctx() helpers.
> >> Patch #19 finalizes the conversion by renaming virtio_find_vqs_info()
> >>   to virtio_find_vqs().
> >> 
> >> Jiri Pirko (19):
> >>   caif_virtio: use virtio_find_single_vq() for single virtqueue finding
> >>   virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
> >>   virtio: make virtio_find_single_vq() call virtio_find_vqs()
> >>   virtio: introduce virtio_queue_info struct and find_vqs_info() config
> >>     op
> >>   virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
> >>   virtio: convert find_vqs() op implementations to find_vqs_info()
> >>   virtio: call virtio_find_vqs_info() from virtio_find_single_vq()
> >>     directly
> >>   virtio: remove the original find_vqs() op
> >>   virtio: rename find_vqs_info() op to find_vqs()
> >>   virtio_blk: convert to use virtio_find_vqs_info()
> >>   virtio_console: convert to use virtio_find_vqs_info()
> >>   virtio_crypto: convert to use virtio_find_vqs_info()
> >>   virtio_net: convert to use virtio_find_vqs_info()
> >>   scsi: virtio_scsi: convert to use virtio_find_vqs_info()
> >>   virtiofs: convert to use virtio_find_vqs_info()
> >>   virtio_balloon: convert to use virtio_find_vqs_info()
> >>   virtio: convert the rest virtio_find_vqs() users to
> >>     virtio_find_vqs_info()
> >>   virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx()
> >>     helpers
> >>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs()
> >> 
> >>  arch/um/drivers/virt-pci.c                    |  8 ++-
> >>  arch/um/drivers/virtio_uml.c                  | 12 ++--
> >>  drivers/block/virtio_blk.c                    | 20 +++----
> >>  drivers/bluetooth/virtio_bt.c                 | 13 ++--
> >>  drivers/char/virtio_console.c                 | 43 ++++++-------
> >>  drivers/crypto/virtio/virtio_crypto_core.c    | 31 ++++------
> >>  drivers/firmware/arm_scmi/virtio.c            | 11 ++--
> >>  drivers/gpio/gpio-virtio.c                    | 10 ++--
> >>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++-
> >>  drivers/iommu/virtio-iommu.c                  | 11 ++--
> >>  drivers/net/caif/caif_virtio.c                |  8 +--
> >>  drivers/net/virtio_net.c                      | 34 ++++-------
> >>  drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++--
> >>  drivers/platform/mellanox/mlxbf-tmfifo.c      | 10 ++--
> >>  drivers/remoteproc/remoteproc_virtio.c        | 12 ++--
> >>  drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++-
> >>  drivers/s390/virtio/virtio_ccw.c              | 13 ++--
> >>  drivers/scsi/virtio_scsi.c                    | 32 ++++------
> >>  drivers/virtio/virtio_balloon.c               | 32 ++++------
> >>  drivers/virtio/virtio_input.c                 |  9 +--
> >>  drivers/virtio/virtio_mmio.c                  | 12 ++--
> >>  drivers/virtio/virtio_pci_common.c            | 49 ++++++++-------
> >>  drivers/virtio/virtio_pci_common.h            |  4 +-
> >>  drivers/virtio/virtio_pci_modern.c            |  5 +-
> >>  drivers/virtio/virtio_vdpa.c                  | 13 ++--
> >>  fs/fuse/virtio_fs.c                           | 22 +++----
> >>  include/linux/virtio_config.h                 | 60 +++++++++----------
> >>  net/vmw_vsock/virtio_transport.c              | 16 ++---
> >>  sound/virtio/virtio_card.c                    | 23 ++++---
> >>  29 files changed, 240 insertions(+), 302 deletions(-)
> >> 
> >> -- 
> >> 2.45.2
> >

