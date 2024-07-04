Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC91AED35
	for <virtualization@lists.linux.dev>; Thu,  4 Jul 2024 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097762; cv=none; b=GY0K0wlS4deZ/fE0GnA53TBYpDGo41rIyZImFEhXnRgNu14kSrBWl+sFmKDCknNmXBv94voTOv3DpfKjTukrseETpMuBzxK25sG5eBj7sjvPFzNIhYnZpfAMV3s2D5H8qtx9+xAYsr9qNlPoluFkcZd5Rd/AqPZ045cgmKSbuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097762; c=relaxed/simple;
	bh=EQz2aiTkDXzF1Sw3KbQRIMo5Lm3IUtKojPn3W9ShW1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pi4efygA9VP1xNsz2GZIpLGG9mIrZdNKMwH6q3uYULrOSExDLLJhxhOyG9KMkQjmxzppCq8bZv71KT7/iMgTnJPnaCvtN+srKsJBHts3RA+PPL/A5MCkn0DAXGY+utMuLl9Yi8x/QMX+Scqzbe+/xATzTVdh7nlS/HonFOGwpO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ei5wWl3V; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ei5wWl3V"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e976208f8so627963e87.2
        for <virtualization@lists.linux.dev>; Thu, 04 Jul 2024 05:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1720097756; x=1720702556; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuEf+0zk4L3q3DntPYnHHPIr622I2try5Ud1At7/nt8=;
        b=ei5wWl3VzUOLdz5WS7N2NyH1BHVbmmcIO5W6wRX8ckcXV4ixyqop5pAPsNPuFHZqro
         V5iA1NYr3O8eJkFPKvPVPZIl4lN1e+lJKEHuBIIl7uAzmSnxPZjCHBagTSW9XRa70pGk
         oQ26pZH4JxO5ObcdJm6h8tkJr+Ka+MTyIW/6ZaCjzq2inlhxyX9aUnduS9GGqo/xaXqu
         2cHeJT0c7EqIwvWG3C03wwto4APRWH1q9SpUrHLmA2dKKE56Mb39Ye686DB4EiP41HOq
         WFlzjdkf++oX/tkEyQptquCWa9iPGkqWHkguMURBnbStHoxhdYzCFJFzZgxEw4WBTWI4
         ZqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097756; x=1720702556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuEf+0zk4L3q3DntPYnHHPIr622I2try5Ud1At7/nt8=;
        b=SDSTzlRCOczHZPOZNrtfIlwX4yYg+VlsEIKvxluy4hn92umUi54jZei6B0nRDCfgiX
         qpxpZX3L0vwOCG3n4r38KQX2+zY5y0iXa61pja08KhQkpQaGSOKaWmk1Ta76aQG1zmaj
         5C3Unr+Onxir/HtxXV9XrEI96TnNz6/13AJXYBD/uygX5vkeitFhuh8ZK+bZ3qsXDxFQ
         7Gs/7Srt4zPfWf1HxHD5tKtI7ViUatmTSnQxx40A6/z7tdt6EMNOyLBBTjHGeoH0936O
         hxXU8BDG7bmiPbh6UD+fYAZi2yFmet1mR2GUWQI0vIpPOKX7GvdSQchxSsaLezcHUxYX
         YQPw==
X-Forwarded-Encrypted: i=1; AJvYcCWqzwe/99lj7ZfgCT2bGz+KsJbxhR04n659GSNngmq+n+2J+Fbea4xpKdywNLnu0S4L8XOkHi6bZY0nM91JETLBKfjpbF7ZzOzGoyJZGSU=
X-Gm-Message-State: AOJu0Ywf55gVvcK8PaWGOz0WH0FPNmTNFYq39g0p46lNPOYcP4UZz3j7
	bvF+a5AW7EzStO0qRsTTHH1ACpUUeE5Djh3rqtsLPLnLMpoaLddZGhiiSpfVn8M=
X-Google-Smtp-Source: AGHT+IGNMLrZCEkvbYWkQBA1pgzff+TlLObOSvm5L5hWJ86PkbwReLznelCJJJWN7chBbpg7QhteFA==
X-Received: by 2002:a05:6512:2fb:b0:52e:8141:1b27 with SMTP id 2adb3069b0e04-52ea06b0f0dmr1243805e87.43.1720097756259;
        Thu, 04 Jul 2024 05:55:56 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58bef78662fsm3153922a12.70.2024.07.04.05.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:55:55 -0700 (PDT)
Date: Thu, 4 Jul 2024 14:55:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev,
	jasowang@redhat.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio 00/19] virtio: consolidate vq info args of
 find_vqs()
Message-ID: <Zoab1mOX9Hta--Ef@nanopsycho.orion>
References: <20240703123913.969202-1-jiri@resnulli.us>
 <20240703084954-mutt-send-email-mst@kernel.org>
 <ZoVRIwZGbQNKwfqA@nanopsycho.orion>
 <20240703093649-mutt-send-email-mst@kernel.org>
 <1720093115.9907808-2-xuanzhuo@linux.alibaba.com>
 <20240704083515-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704083515-mutt-send-email-mst@kernel.org>

Thu, Jul 04, 2024 at 02:39:36PM CEST, mst@redhat.com wrote:
>On Thu, Jul 04, 2024 at 07:38:35PM +0800, Xuan Zhuo wrote:
>> On Wed, 3 Jul 2024 09:37:10 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > On Wed, Jul 03, 2024 at 03:24:51PM +0200, Jiri Pirko wrote:
>> > > Wed, Jul 03, 2024 at 02:50:36PM CEST, mst@redhat.com wrote:
>> > > >On Wed, Jul 03, 2024 at 02:38:54PM +0200, Jiri Pirko wrote:
>> > > >> From: Jiri Pirko <jiri@nvidia.com>
>> > > >>
>> > > >> Currently, virtio_find_vqs() and virtio_find_vqs_ctx() accept array of
>> > > >> names, callbacks and ctx (in case of the second one) as separate args.
>> > > >> That became inconvenient as the ctx addition showed.
>> > > >>
>> > > >> For virtio_net control queue, an indication of queue flavour (slow path)
>> > > >> is going to be needed to be passed to PCI transport in order to
>> > > >> assign vectors properly, another array added to virtio_find_vqs_ctx()
>> > > >> arg list would not be nice and convenient.
>> > > >>
>> > > >> Instead, introduce a structure to carry vq callback, name and ctx. Pass
>> > > >> array of these structures to virtio_find_vqs() and all the way down to
>> > > >> transport find_vqs() op implementation.
>> > > >>
>> > > >> That allows to easily extend what needs to be passed down. Also, it
>> > > >> makes the code a bit more cleaner. We get rid of separate
>> > > >> virtio_find_vqs_ctx() helper.
>> > > >>
>> > > >> This patchset does the conversion in steps, using temporary _info() op
>> > > >> and helper. Note they are renamed back.
>> > > >
>> > > >Thanks a lot Jiri, looks very good.
>> > > >Some minor comments.
>> > >
>> > > Will fix and send v2 tomorrow. I have my admin queue patchset rebased on
>> > > top of this and code will be ready for control queue to benefit from
>> > > vector allocation.
>> >
>> >
>> > Excellent, I hope it makes it in next in time for the next merge window.
>> 
>> Hi, Michael, you know I was working on this.
>> 
>> Is the virtio community already in such a mess?
>
>Sorry you feel that way.  Jiri, I think it's fair to add
>
>Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>to patches 4 and 10-17.

Sure, no problem.


>
>
>
>> >
>> > >
>> > > >
>> > > >
>> > > >> Patch #1 does one forgotten conversion to virtio_find_single_vq().
>> > > >> Patches #2 and #3 do preparations for find_vqs_info() op introduction.
>> > > >> Patch #4 introduces new op find_vqs_info() to replace find_vqs() it also
>> > > >>   introduces struct virtio_queue_info and virtio_find_vqs_info() helper.
>> > > >> Patches #5 and #6 convert transports to implement find_vqs_info() op
>> > > >>   that accepts array of virtio_queue_info structs.
>> > > >> Patch #7 converts virtio_find_single_vq() to use the new way as well.
>> > > >> Patch #8 removes original find_vqs() op.
>> > > >> Patch #9 renames find_vqs_info() to find_vqs() and completes first part
>> > > >>   of conversion this patches does.
>> > > >> Patches #10-#17 convert virtio_find_vqs() and virtio_find_vqs_ctx()
>> > > >>   users to use new virtio_find_vqs_info() helper.
>> > > >> Patch #18 removes no longer used virtio_find_vqs() and
>> > > >>   virtio_find_vqs_ctx() helpers.
>> > > >> Patch #19 finalizes the conversion by renaming virtio_find_vqs_info()
>> > > >>   to virtio_find_vqs().
>> > > >>
>> > > >> Jiri Pirko (19):
>> > > >>   caif_virtio: use virtio_find_single_vq() for single virtqueue finding
>> > > >>   virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
>> > > >>   virtio: make virtio_find_single_vq() call virtio_find_vqs()
>> > > >>   virtio: introduce virtio_queue_info struct and find_vqs_info() config
>> > > >>     op
>> > > >>   virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
>> > > >>   virtio: convert find_vqs() op implementations to find_vqs_info()
>> > > >>   virtio: call virtio_find_vqs_info() from virtio_find_single_vq()
>> > > >>     directly
>> > > >>   virtio: remove the original find_vqs() op
>> > > >>   virtio: rename find_vqs_info() op to find_vqs()
>> > > >>   virtio_blk: convert to use virtio_find_vqs_info()
>> > > >>   virtio_console: convert to use virtio_find_vqs_info()
>> > > >>   virtio_crypto: convert to use virtio_find_vqs_info()
>> > > >>   virtio_net: convert to use virtio_find_vqs_info()
>> > > >>   scsi: virtio_scsi: convert to use virtio_find_vqs_info()
>> > > >>   virtiofs: convert to use virtio_find_vqs_info()
>> > > >>   virtio_balloon: convert to use virtio_find_vqs_info()
>> > > >>   virtio: convert the rest virtio_find_vqs() users to
>> > > >>     virtio_find_vqs_info()
>> > > >>   virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx()
>> > > >>     helpers
>> > > >>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs()
>> > > >>
>> > > >>  arch/um/drivers/virt-pci.c                    |  8 ++-
>> > > >>  arch/um/drivers/virtio_uml.c                  | 12 ++--
>> > > >>  drivers/block/virtio_blk.c                    | 20 +++----
>> > > >>  drivers/bluetooth/virtio_bt.c                 | 13 ++--
>> > > >>  drivers/char/virtio_console.c                 | 43 ++++++-------
>> > > >>  drivers/crypto/virtio/virtio_crypto_core.c    | 31 ++++------
>> > > >>  drivers/firmware/arm_scmi/virtio.c            | 11 ++--
>> > > >>  drivers/gpio/gpio-virtio.c                    | 10 ++--
>> > > >>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++-
>> > > >>  drivers/iommu/virtio-iommu.c                  | 11 ++--
>> > > >>  drivers/net/caif/caif_virtio.c                |  8 +--
>> > > >>  drivers/net/virtio_net.c                      | 34 ++++-------
>> > > >>  drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++--
>> > > >>  drivers/platform/mellanox/mlxbf-tmfifo.c      | 10 ++--
>> > > >>  drivers/remoteproc/remoteproc_virtio.c        | 12 ++--
>> > > >>  drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++-
>> > > >>  drivers/s390/virtio/virtio_ccw.c              | 13 ++--
>> > > >>  drivers/scsi/virtio_scsi.c                    | 32 ++++------
>> > > >>  drivers/virtio/virtio_balloon.c               | 32 ++++------
>> > > >>  drivers/virtio/virtio_input.c                 |  9 +--
>> > > >>  drivers/virtio/virtio_mmio.c                  | 12 ++--
>> > > >>  drivers/virtio/virtio_pci_common.c            | 49 ++++++++-------
>> > > >>  drivers/virtio/virtio_pci_common.h            |  4 +-
>> > > >>  drivers/virtio/virtio_pci_modern.c            |  5 +-
>> > > >>  drivers/virtio/virtio_vdpa.c                  | 13 ++--
>> > > >>  fs/fuse/virtio_fs.c                           | 22 +++----
>> > > >>  include/linux/virtio_config.h                 | 60 +++++++++----------
>> > > >>  net/vmw_vsock/virtio_transport.c              | 16 ++---
>> > > >>  sound/virtio/virtio_card.c                    | 23 ++++---
>> > > >>  29 files changed, 240 insertions(+), 302 deletions(-)
>> > > >>
>> > > >> --
>> > > >> 2.45.2
>> > > >
>> >
>
