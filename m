Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4012E1F1
	for <virtualization@lists.linux.dev>; Tue,  9 Jul 2024 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519033; cv=none; b=E9fTjTFsfi9jjJjcsYmF2OHmWRo7LIX+YKWKrjDM+quTXU/Kd9nZ8CtQwfoqCs47K6wuEdkPfZIIOdSfPRTykN+05ojis6weXyihi5T3uzzTk5X1ZTococSXW05L5KHQagAHZNoHrG/KFwBawUEA/siFDsJelqkneQ0DgoCg8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519033; c=relaxed/simple;
	bh=07NUeemcLtWy6qEz5y/eWffEHqNLCEAmOp4Lmh25URU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra04f2PLTBKjVSRTeZ3iu3khWhmZcTKmIouuKfsIAT3vtc1uqYqs3vHrjPsjsFH1Djm4DT1Gd+CZNRksP0UXh3E/uusgBqkqZdEc0AQrJO0JdOD8HYgLIWz7tpBQGZGBtlNq4qJI4PldIuR5KsLZRIR7h2GqGSlC5XkZvow7qX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=jAvJ4P2T; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jAvJ4P2T"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-426717a2d12so4320145e9.0
        for <virtualization@lists.linux.dev>; Tue, 09 Jul 2024 02:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720519029; x=1721123829; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UDpLGTJDFqUc/TrcTQUiBmzT3UKTtXsDWsH0/mtbIyo=;
        b=jAvJ4P2TK3OogLvTPp7GDSJmqnl9zTV8VCMKsYXVRz63R8ZHVildqh9+0cGJnJYG7y
         bQq+LuHLpJBx3mQnFL+e5gk2susnngLMA1E/A7ZFtvdd4nk/nwMcy+PMBkzePUs3twpT
         +SnVLdo09pXKE5yPv1t+JzNhUt3bg8gxydyEfpKf30cJ9LHFcXHqAW5DMNMuDOyxlTv0
         QCn2hpbkGXY8sv1yM7ENCmcNNZbnMtVZHIJzJRinUhi0MN/tjLp7lXxV8kaW8bTSU8xn
         3wkk7I0OhVtQn1vZgIZ6fMPu87toKeXWpjDxG9wUAed55o3lY2UYgryvzYZQci/NG+ua
         VO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720519029; x=1721123829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDpLGTJDFqUc/TrcTQUiBmzT3UKTtXsDWsH0/mtbIyo=;
        b=d4MHXX1ULGxY5UOCKz3uuqR5PIhgo4t/gUbcCHp1UMjHPC+nLWQA6ZmvcKIteVGzgX
         jgUiQV6oqS+79AoM/wzpwUgLTJLd7pHlqY2QwSuxDsvzRxoni5xoj0wFgKUduPkwHadM
         2Bc1vuNSypdPpsjo7ZUtUxVpdJIxRhRgv7se+kv+PrSbEbXNrJy47p0xqjmAU/yK97Fa
         RbhGORq86dHiG1wniV0WGbF/826SAuduMxy0sXWr4b0ZJVeK/84DqUtMjvJTaGAUHICy
         MlvCXslg3h2wuPWEMgV5+88+854/KBpyu9Cnyj/JSFUYkEFS6AydclMTSc41Sh8GJDeD
         uUYQ==
X-Gm-Message-State: AOJu0YyiYDl/Lz0gzuELh5ribSylUHW+PMJOnFVoWKGFX1Levw6/9d7K
	yUtT0lp+RSjpE423mRFRbHb0yr5q7OS2t7KKw/FfXv/FMAB1meK5cHdm0NpgSMA=
X-Google-Smtp-Source: AGHT+IH6GbZA+TJHtD2P24tcL05uW7MLWugTBXpI7Bf50DISkiA+5HG4BLUOu19eNLn/u7VptA9Ffw==
X-Received: by 2002:a05:600c:63ce:b0:424:895c:b84b with SMTP id 5b1f17b1804b1-426722c5b9emr14420425e9.4.1720519029489;
        Tue, 09 Jul 2024 02:57:09 -0700 (PDT)
Received: from localhost ([37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266b03feecsm66791325e9.10.2024.07.09.02.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 02:57:08 -0700 (PDT)
Date: Tue, 9 Jul 2024 11:57:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v4 00/19] virtio: consolidate vq info args of
 find_vqs()
Message-ID: <Zo0Jc3gF0E9V-pIA@nanopsycho.orion>
References: <20240708074814.1739223-1-jiri@resnulli.us>
 <20240708095632-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708095632-mutt-send-email-mst@kernel.org>

Mon, Jul 08, 2024 at 03:58:05PM CEST, mst@redhat.com wrote:
>On Mon, Jul 08, 2024 at 09:47:55AM +0200, Jiri Pirko wrote:
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
>
>Thanks!
>I want to wait a couple of days for my current tree to get merged
>into linux-next, since otherwise all the other stuff there does not
>get tested. Once there, I'll add your stuff on top - if all this happens
>to get into next before the merge window opens, we are good.
>If not it'll have to wait until the next window.

Looks like the linux-next merge is done:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=28ab424895157dfea418c12418c5d0fc9263e850


>
>
>> ---
>> v3->v4:
>> - changes in patch #5 and #6, one cosmetic issue, one compile issue
>> 
>> v2->v3:
>> - added proper struct description comment to patch #4
>> - added suggested by tag to patches #4, #10-#17
>> 
>> v1->v2:
>> - added forgotten VIRTIO_SND_VQ_MAX for array size in virtio_card.c
>> - s/virtio_queue_info/virtqueue_info/
>> - fixed comments for struct virtqueue_info
>> - rebased on top of recent code changes (virtio_fs.c)
>> - see individual patches changelog for more details
>> 
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
>>  drivers/block/virtio_blk.c                    | 20 +++---
>>  drivers/bluetooth/virtio_bt.c                 | 13 ++--
>>  drivers/char/virtio_console.c                 | 43 +++++--------
>>  drivers/crypto/virtio/virtio_crypto_core.c    | 31 ++++-----
>>  drivers/firmware/arm_scmi/virtio.c            | 11 ++--
>>  drivers/gpio/gpio-virtio.c                    | 10 +--
>>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++-
>>  drivers/iommu/virtio-iommu.c                  | 11 ++--
>>  drivers/net/caif/caif_virtio.c                |  8 +--
>>  drivers/net/virtio_net.c                      | 34 ++++------
>>  drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++--
>>  drivers/platform/mellanox/mlxbf-tmfifo.c      | 10 +--
>>  drivers/remoteproc/remoteproc_virtio.c        | 12 ++--
>>  drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++-
>>  drivers/s390/virtio/virtio_ccw.c              | 13 ++--
>>  drivers/scsi/virtio_scsi.c                    | 32 ++++------
>>  drivers/virtio/virtio_balloon.c               | 32 ++++------
>>  drivers/virtio/virtio_input.c                 |  9 +--
>>  drivers/virtio/virtio_mmio.c                  | 12 ++--
>>  drivers/virtio/virtio_pci_common.c            | 48 +++++++-------
>>  drivers/virtio/virtio_pci_common.h            |  3 +-
>>  drivers/virtio/virtio_pci_modern.c            |  5 +-
>>  drivers/virtio/virtio_vdpa.c                  | 13 ++--
>>  fs/fuse/virtio_fs.c                           | 22 +++----
>>  include/linux/virtio_config.h                 | 64 ++++++++++---------
>>  net/vmw_vsock/virtio_transport.c              | 16 ++---
>>  sound/virtio/virtio_card.c                    | 23 +++----
>>  29 files changed, 242 insertions(+), 302 deletions(-)
>> 
>> -- 
>> 2.45.2
>
