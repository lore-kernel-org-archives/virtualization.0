Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9C1AD9DE
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 13:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720098263; cv=none; b=E6h0WDih38UMpLx9g2bnTksABgSAOkgVSItbj7VkD32I7ggAj2tNKn3OaoonWrWU099Ab9vyMri3Lq7DMcZvA1cjIcBW8lHMkBWX+xYKNi406jCbUnfedJvun1HBr0rxKFZOfShqERKpG6dsEMT3FYue2ohqwURQY2UAejRgK6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720098263; c=relaxed/simple;
	bh=zqRLqvakl0FpUmqxBJ0bIeLk6vGTvfQbqw9iIn7m2A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grlad8+s2kT5dz7VKCsbZ1QDElYIRABS1ZOcuRul0uBguzAfCyvC3/hVdl8DsNVOnaEZgCnLwEwYqbXkcEsVM/kOVFqF2JOeu9fDGNjwrA2fqjuX5uGFFA8q/H7UWQzk7vTToSVIlSE53bgYdtktcnIOdkNzx598XfRa4BXqufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oF4wO2nl; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oF4wO2nl"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ee75ffce77so7485961fa.3
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720098260; x=1720703060; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwJdmGY0IL2rc32nkc2sR25Wo0HrrVgm3Jrjy1GrcGM=;
        b=oF4wO2nlt42RZegXEVOTmLDtQuCq3TjB2n3B8vq6gJQ7l54QgQLKlftNZP3fEF4ajn
         43yzJ/1thH0PnKVGqi6H7L1D0FDLU4TXiVRhwkqQZEd1hKGlE8eibkzGPMYR11tXhC1L
         q6ZKayIj3RxiNUmDwMxa40ZDDdU0lMTsGMPt1vuhtYya0zI6IDwELJxWiLNjRn3nWIKO
         3efvOhW6jm+Ny0d0WrP5r3q2AvNuTqqFjWcDJf0KgWCXt8nIStL8tCw1FzCYG+ovTSdi
         1JHdsSAE0WPFHaHxutCma1/1mF6rhdimM915Q67qvvYHXWNp/HxsLqBkdwc2fuV89WaF
         e2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720098260; x=1720703060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwJdmGY0IL2rc32nkc2sR25Wo0HrrVgm3Jrjy1GrcGM=;
        b=eThgATgitPtdRMkeVSssATM4XaHpEhrUIon3hzUUuKD/wiFv9necIA1qydMsXkvDyZ
         9DKvY39qF0NO1oQL5+0Xkwhnw40gFedUZbE/PMkHmY5JjcQjG/8+POCMFnRSQCMEQlTC
         f5nvsr/5Xzrq4r35aD6kxxhWUc/J/53xUPRoLGb0TGVpvVsD87ib48ff2uhmy7pDw7f/
         Te/xfyfvW0WrqN056/+JyUN985Jr4wMpzjAJ3f21aOzar4bjpBWlTofpB3eTq4Zsa8d3
         l6iGkrRjpKzz1nU+ypfHbBa+Ds3gunAZwmRBKNbtWyAE2kjXt35kLQA4vWDRaI5iln/N
         7pAA==
X-Forwarded-Encrypted: i=1; AJvYcCUkica8DL6/3DJs89FIN3XPppv6SQbgsez3lz/k4evcLUOJ0PeCVs1Ws5U4PdnoU1hwmp3CSaWJicubbH66ExrBMoHy158BwZo2lHbtA60=
X-Gm-Message-State: AOJu0YzxKqgILQX4AAa7I9w2naCAMLj5SGIUM6pTCvp1JsFeLedEMmWc
	5QKGB4/OZ876agbPpSpNwEVeHGCmGZ1fUVO1ivS7XOE2lJBHFgQTVF/GG89unBY=
X-Google-Smtp-Source: AGHT+IFTF1CCNzSe1fdg997++4tUeUGqCaJBrmtmHZoFJvGl9V9vbLfWaC1IOctXDcMJuGe9nqxdlQ==
X-Received: by 2002:a2e:bcc2:0:b0:2ec:1e6e:13f9 with SMTP id 38308e7fff4ca-2ee8ee60731mr17319601fa.52.1720098257649;
        Thu, 04 Jul 2024 06:04:17 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab065187sm599093666b.139.2024.07.04.06.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:04:17 -0700 (PDT)
Date: Thu, 4 Jul 2024 15:04:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: mst@redhat.com, jasowang@redhat.com, eperezma@redhat.com,
	parav@nvidia.com, feliu@nvidia.com, hengqi@linux.alibaba.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH virtio v2 00/19] virtio: consolidate vq info args of
 find_vqs()
Message-ID: <ZoadzIfWaXTEbknw@nanopsycho.orion>
References: <20240704064350.1097716-1-jiri@resnulli.us>
 <1720092809.2040446-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720092809.2040446-1-xuanzhuo@linux.alibaba.com>

Thu, Jul 04, 2024 at 01:33:29PM CEST, xuanzhuo@linux.alibaba.com wrote:
>Do you know this: http://lore.kernel.org/all/20240424091533.86949-1-xuanzhuo@linux.alibaba.com
>
>This seems to do the same thing. That works in process.

No clue about this. But your patchset is working thing on a slightly
different level. Still applicable on top of mine, I don't see any
problem.


>
>Thanks.
>
>On Thu,  4 Jul 2024 08:43:31 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>>
>> Currently, virtio_find_vqs() and virtio_find_vqs_ctx() accept array of
>> names, callbacks and ctx (in case of the second one) as separate args.
>> That became inconvenient as the ctx addition showed.
>>
>> For virtio_net control queue, an indication of queue flavour (slow path)
>> is going to be needed to be passed to PCI transport in order to
>> assign vectors properly, another array added to virtio_find_vqs_ctx()
>> arg list would not be nice and convenient.
>>
>> Instead, introduce a structure to carry vq callback, name and ctx. Pass
>> array of these structures to virtio_find_vqs() and all the way down to
>> transport find_vqs() op implementation.
>>
>> That allows to easily extend what needs to be passed down. Also, it
>> makes the code a bit more cleaner. We get rid of separate
>> virtio_find_vqs_ctx() helper.
>>
>> This patchset does the conversion in steps, using temporary _info() op
>> and helper. Note they are renamed back.
>>
>> Patch #1 does one forgotten conversion to virtio_find_single_vq().
>> Patches #2 and #3 do preparations for find_vqs_info() op introduction.
>> Patch #4 introduces new op find_vqs_info() to replace find_vqs() it also
>>   introduces struct virtio_queue_info and virtio_find_vqs_info() helper.
>> Patches #5 and #6 convert transports to implement find_vqs_info() op
>>   that accepts array of virtio_queue_info structs.
>> Patch #7 converts virtio_find_single_vq() to use the new way as well.
>> Patch #8 removes original find_vqs() op.
>> Patch #9 renames find_vqs_info() to find_vqs() and completes first part
>>   of conversion this patches does.
>> Patches #10-#17 convert virtio_find_vqs() and virtio_find_vqs_ctx()
>>   users to use new virtio_find_vqs_info() helper.
>> Patch #18 removes no longer used virtio_find_vqs() and
>>   virtio_find_vqs_ctx() helpers.
>> Patch #19 finalizes the conversion by renaming virtio_find_vqs_info()
>>   to virtio_find_vqs().
>>
>> ---
>> v1->v2:
>> - added forgotten VIRTIO_SND_VQ_MAX for array size in virtio_card.c
>> - s/virtio_queue_info/virtqueue_info/
>> - fixed comments for struct virtqueue_info
>> - rebased on top of recent code changes (virtio_fs.c)
>> - see individual patches changelog for more details
>>
>> Jiri Pirko (19):
>>   caif_virtio: use virtio_find_single_vq() for single virtqueue finding
>>   virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
>>   virtio: make virtio_find_single_vq() call virtio_find_vqs()
>>   virtio: introduce virtio_queue_info struct and find_vqs_info() config
>>     op
>>   virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
>>   virtio: convert find_vqs() op implementations to find_vqs_info()
>>   virtio: call virtio_find_vqs_info() from virtio_find_single_vq()
>>     directly
>>   virtio: remove the original find_vqs() op
>>   virtio: rename find_vqs_info() op to find_vqs()
>>   virtio_blk: convert to use virtio_find_vqs_info()
>>   virtio_console: convert to use virtio_find_vqs_info()
>>   virtio_crypto: convert to use virtio_find_vqs_info()
>>   virtio_net: convert to use virtio_find_vqs_info()
>>   scsi: virtio_scsi: convert to use virtio_find_vqs_info()
>>   virtiofs: convert to use virtio_find_vqs_info()
>>   virtio_balloon: convert to use virtio_find_vqs_info()
>>   virtio: convert the rest virtio_find_vqs() users to
>>     virtio_find_vqs_info()
>>   virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx()
>>     helpers
>>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs()
>>
>>  arch/um/drivers/virt-pci.c                    |  8 ++-
>>  arch/um/drivers/virtio_uml.c                  | 12 ++--
>>  drivers/block/virtio_blk.c                    | 20 +++----
>>  drivers/bluetooth/virtio_bt.c                 | 13 ++--
>>  drivers/char/virtio_console.c                 | 43 ++++++-------
>>  drivers/crypto/virtio/virtio_crypto_core.c    | 31 ++++------
>>  drivers/firmware/arm_scmi/virtio.c            | 11 ++--
>>  drivers/gpio/gpio-virtio.c                    | 10 ++--
>>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++-
>>  drivers/iommu/virtio-iommu.c                  | 11 ++--
>>  drivers/net/caif/caif_virtio.c                |  8 +--
>>  drivers/net/virtio_net.c                      | 34 ++++-------
>>  drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++--
>>  drivers/platform/mellanox/mlxbf-tmfifo.c      | 10 ++--
>>  drivers/remoteproc/remoteproc_virtio.c        | 12 ++--
>>  drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++-
>>  drivers/s390/virtio/virtio_ccw.c              | 13 ++--
>>  drivers/scsi/virtio_scsi.c                    | 32 ++++------
>>  drivers/virtio/virtio_balloon.c               | 32 ++++------
>>  drivers/virtio/virtio_input.c                 |  9 +--
>>  drivers/virtio/virtio_mmio.c                  | 12 ++--
>>  drivers/virtio/virtio_pci_common.c            | 48 ++++++++-------
>>  drivers/virtio/virtio_pci_common.h            |  3 +-
>>  drivers/virtio/virtio_pci_modern.c            |  5 +-
>>  drivers/virtio/virtio_vdpa.c                  | 13 ++--
>>  fs/fuse/virtio_fs.c                           | 22 +++----
>>  include/linux/virtio_config.h                 | 60 +++++++++----------
>>  net/vmw_vsock/virtio_transport.c              | 16 ++---
>>  sound/virtio/virtio_card.c                    | 23 ++++---
>>  29 files changed, 238 insertions(+), 302 deletions(-)
>>
>> --
>> 2.45.2
>>
