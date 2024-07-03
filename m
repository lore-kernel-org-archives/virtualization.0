Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA413A25B
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013097; cv=none; b=OOfikbB/XDsJx+py8zBRTLvfUI06KuPLywonqJx59/GwgMU79esYrUvQ2HivNg6Iv39OyGPcLsth4ddi0inj2lD9DQculKNTg/TG92bBFIrWRodXBaqw1tBOvGOqdwMwfxrCmWJuBPIPkaA3AbabEfnubvVjGdw1y+nstVw264E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013097; c=relaxed/simple;
	bh=EWa81fYAp4VXZrj0j5D0nnldDOb8RVnp+NBOo8o65JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryH4BH1rO0/lv7Ixf34jHQEKhJ6UT+GIxLdp0ViZhylaUo4EtYPBT09XA61iXhLeW/kW5qYYVBwreBPLQXny0+ciuuBwrMG50httW6AvuYmugD3bfjM/GLKtBsyJ1DdG7OzycngNMkEFyxUqzriBuarvX7kQ7t9XGiEn6VH0B4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IEoQrAd1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IEoQrAd1"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36733f09305so2929545f8f.3
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 06:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720013094; x=1720617894; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndfOiYs6h6Un++kFKm8u1bW4bdG3ljzYF1ADJHPDszA=;
        b=IEoQrAd1MnRIvYzlvc2O2xr9aZ2qNqg6YSGh60bgf0dzMOEPZ3TK3ATcm8OnEMIP0l
         tPwCF1DgXI/3BMvaLl7NhxX7zHIqEAiDrwas2sL2J5wGRjwc8hQwwEQmgtyKxhEkYWv3
         1v7z21sv4f2LoDOuqTDrm2TLcxWx5V+uZe0USqQIA3HIg0D39WsyaVnhGe0KctDYOcBO
         BBfIO3IYw4eT7ljoDtSIEuwzYjSX/C0Y8/uTaxGIG8+ZF0iV5J2hRF+zYMt1oAsa6MTm
         rcC0vH0YbFFxyTnSQckR7/jNqErBvh+RY1Ffj+NwL+AynrK4vZDhtLfDRSFny0lwonLb
         uClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720013094; x=1720617894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndfOiYs6h6Un++kFKm8u1bW4bdG3ljzYF1ADJHPDszA=;
        b=mjPok0GfonPDKWTMQCG/O+4OHHxPBTVElPFlFm/qMvvE4IXin2+hD+Kho7DtXVqYOM
         7bq4FcW/X982wwGxbm2/TwOUw9L1dPN/NDZSSs3VPi5k3YZy8zqLr7ZjjdyN67nhvl11
         SHlyldrx1DEuOgNpfnk1Iv3bKbuI+X9GDUu+huwGCqThTH23nsq7O66pBmOkSyLpAZa8
         kS5imHJ9bFWqPOCuc51ime/usCR0tnUJgZJ7hzJBJlfmFODDFlbtEtfGnkskqmJ/5xA0
         frRGMyF0wbOibfxuXkAQU7lzfcXUStYjnZAAKF/VpLvizmLky6/j1unX/NHLaHJx5mHT
         jcDQ==
X-Gm-Message-State: AOJu0YzEX9yLkq1dLxhcoxXt6zwDIB/8g/H92ZRJk4o8gl9U17f07crr
	bDKexTpl1MpoHxkAxGB7GNW1i0TzGU8HA3xsYmBrAIW05hjwsNCo36WGmXQWkqU=
X-Google-Smtp-Source: AGHT+IF2wv3LcJ/ADm6L1ruq0RJrHqbA0EhUVE9awjnMAa/99G6PruQutYM4gMtDCufIMz99qd/DOQ==
X-Received: by 2002:a5d:648c:0:b0:367:89fd:1e06 with SMTP id ffacd0b85a97d-36789fd1e4amr3661986f8f.36.1720013093509;
        Wed, 03 Jul 2024 06:24:53 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af376easm239795335e9.5.2024.07.03.06.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:24:53 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:24:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio 00/19] virtio: consolidate vq info args of
 find_vqs()
Message-ID: <ZoVRIwZGbQNKwfqA@nanopsycho.orion>
References: <20240703123913.969202-1-jiri@resnulli.us>
 <20240703084954-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703084954-mutt-send-email-mst@kernel.org>

Wed, Jul 03, 2024 at 02:50:36PM CEST, mst@redhat.com wrote:
>On Wed, Jul 03, 2024 at 02:38:54PM +0200, Jiri Pirko wrote:
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
>
>Thanks a lot Jiri, looks very good.
>Some minor comments.

Will fix and send v2 tomorrow. I have my admin queue patchset rebased on
top of this and code will be ready for control queue to benefit from
vector allocation.


>
>
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
>>  drivers/virtio/virtio_pci_common.c            | 49 ++++++++-------
>>  drivers/virtio/virtio_pci_common.h            |  4 +-
>>  drivers/virtio/virtio_pci_modern.c            |  5 +-
>>  drivers/virtio/virtio_vdpa.c                  | 13 ++--
>>  fs/fuse/virtio_fs.c                           | 22 +++----
>>  include/linux/virtio_config.h                 | 60 +++++++++----------
>>  net/vmw_vsock/virtio_transport.c              | 16 ++---
>>  sound/virtio/virtio_card.c                    | 23 ++++---
>>  29 files changed, 240 insertions(+), 302 deletions(-)
>> 
>> -- 
>> 2.45.2
>
