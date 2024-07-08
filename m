Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025A013D61D
	for <virtualization@lists.linux.dev>; Mon,  8 Jul 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447095; cv=none; b=p249ZGVsPfxcSN3d3sy84qfO9X64fhWh6frle1lrvp0tx+x/lvnyedgHVpp960gBeSXqKg0vDdS67WHM9a9KORlnWk4VrKfbQv58aRE+Vp0B7Kr+U6K0s75PsMFz6xs1CuNycxIHOTifV4k7y4Dn/lpxkQG0RuyIvsdp+g0F1dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447095; c=relaxed/simple;
	bh=W7XqPrKOOnjTtSN2L5KMEHRoUD0/leHmmyj2WiZeYv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r3DA8bnQtyiHB2nByH8TDyBelYBR/cfpccGCrHDpgMz8sbh50XrP1cdMknRvtaYomhZCBglj8I79ltFFdNl0BGYR9KGLNfMvy43pBHTqzc+xKlCUpes348uJS2765q8wMaW/cF0xM18LRr47UxD8uvlaT1yU1ejPNFSzXCGM8IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+RpWeon; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+RpWeon"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720447092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BvULCL0hJt1IMTqNg+rqtpEJ3Oj2Eiymeyx6qlNTExg=;
	b=W+RpWeonrznzrYfQdWwJxhsFTQnhqEcq29k6mZP31LXCW4qthmXib6UyhyZYHktvUmzpv7
	7zrucdU5r+fv0vvEwwSRta80J0xs8mdZhIrYn/KLy7SWqpe1jiVzmZa7wkSFoi4gEYjyz+
	1pjejBruxHroBjV3VT/BRlIIa0gej9A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-T8SSJAxzNuWUly18hyBhog-1; Mon, 08 Jul 2024 09:58:11 -0400
X-MC-Unique: T8SSJAxzNuWUly18hyBhog-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42667e82901so7512585e9.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jul 2024 06:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720447090; x=1721051890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BvULCL0hJt1IMTqNg+rqtpEJ3Oj2Eiymeyx6qlNTExg=;
        b=I0x420x9AT4OjETIcCLfd+95Osgyxaoldte2Yj/snB71+kdfBK1RkxX1NlQsEJons+
         SpYhCCQtcG0wYKtj98roWVLUxtko1GBKHaOH3a+HyelimJ795jOu2rTpOs8PFjpbKqYb
         LUds3E/E94VsUsDcCMh0H0dUOoj1kwXzyeee+FnbjRjNspqc11b4xaBbMqC76JwFnBrF
         2sOMoD/dMpDw8P/gGKermqkm3s1+U5AmEnEtkMXsHr7IIERju8hzVVnMK0CyeSIjenxV
         9SFp7LKOO4y8KALI/Rpc0RI0wYdSrM8RFWYKIefL+/zCX2Qu18JdOMmX+lrz3m0yzF9h
         SbhA==
X-Gm-Message-State: AOJu0YzkSfKFybjey+Tm1K/dPaZc5Tlje1k39uYEyRx6TW028gUoRxyu
	iJ38jCIhFvIZGmVSckXQ/+N+5MmWw4Y872GTgNG9Y9EXiRL3puY7DafKXhFEzuf9od1JmNdsg1d
	zfJJDE6/RT4au5FqPjd5RZggx6YmL8lrPWa39G6MOQUoOsVsQuz6v2h1oQh/NtCJI
X-Received: by 2002:a05:600c:46cc:b0:426:59f3:d976 with SMTP id 5b1f17b1804b1-42659f3dceamr57380025e9.38.1720447090264;
        Mon, 08 Jul 2024 06:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWWqevAcGYmP/LEb9lcHw0N796UZh8i9bwlU85KsuWZNj7M8GlRLyoVUOew2pmRVg5ZuqXOw==
X-Received: by 2002:a05:600c:46cc:b0:426:59f3:d976 with SMTP id 5b1f17b1804b1-42659f3dceamr57379835e9.38.1720447089697;
        Mon, 08 Jul 2024 06:58:09 -0700 (PDT)
Received: from redhat.com ([2.52.29.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367a1805e53sm10347879f8f.22.2024.07.08.06.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:58:09 -0700 (PDT)
Date: Mon, 8 Jul 2024 09:58:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: virtualization@lists.linux.dev, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, parav@nvidia.com,
	feliu@nvidia.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH virtio v4 00/19] virtio: consolidate vq info args of
 find_vqs()
Message-ID: <20240708095632-mutt-send-email-mst@kernel.org>
References: <20240708074814.1739223-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240708074814.1739223-1-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2024 at 09:47:55AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently, virtio_find_vqs() and virtio_find_vqs_ctx() accept array of
> names, callbacks and ctx (in case of the second one) as separate args.
> That became inconvenient as the ctx addition showed.
> 
> For virtio_net control queue, an indication of queue flavour (slow path)
> is going to be needed to be passed to PCI transport in order to
> assign vectors properly, another array added to virtio_find_vqs_ctx()
> arg list would not be nice and convenient.
> 
> Instead, introduce a structure to carry vq callback, name and ctx. Pass
> array of these structures to virtio_find_vqs() and all the way down to
> transport find_vqs() op implementation.
> 
> That allows to easily extend what needs to be passed down. Also, it
> makes the code a bit more cleaner. We get rid of separate
> virtio_find_vqs_ctx() helper.
> 
> This patchset does the conversion in steps, using temporary _info() op
> and helper. Note they are renamed back.
> 
> Patch #1 does one forgotten conversion to virtio_find_single_vq().
> Patches #2 and #3 do preparations for find_vqs_info() op introduction.
> Patch #4 introduces new op find_vqs_info() to replace find_vqs() it also
>   introduces struct virtio_queue_info and virtio_find_vqs_info() helper.
> Patches #5 and #6 convert transports to implement find_vqs_info() op
>   that accepts array of virtio_queue_info structs.
> Patch #7 converts virtio_find_single_vq() to use the new way as well.
> Patch #8 removes original find_vqs() op.
> Patch #9 renames find_vqs_info() to find_vqs() and completes first part
>   of conversion this patches does.
> Patches #10-#17 convert virtio_find_vqs() and virtio_find_vqs_ctx()
>   users to use new virtio_find_vqs_info() helper.
> Patch #18 removes no longer used virtio_find_vqs() and
>   virtio_find_vqs_ctx() helpers.
> Patch #19 finalizes the conversion by renaming virtio_find_vqs_info()
>   to virtio_find_vqs().

Thanks!
I want to wait a couple of days for my current tree to get merged
into linux-next, since otherwise all the other stuff there does not
get tested. Once there, I'll add your stuff on top - if all this happens
to get into next before the merge window opens, we are good.
If not it'll have to wait until the next window.


> ---
> v3->v4:
> - changes in patch #5 and #6, one cosmetic issue, one compile issue
> 
> v2->v3:
> - added proper struct description comment to patch #4
> - added suggested by tag to patches #4, #10-#17
> 
> v1->v2:
> - added forgotten VIRTIO_SND_VQ_MAX for array size in virtio_card.c
> - s/virtio_queue_info/virtqueue_info/
> - fixed comments for struct virtqueue_info
> - rebased on top of recent code changes (virtio_fs.c)
> - see individual patches changelog for more details
> 
> 
> Jiri Pirko (19):
>   caif_virtio: use virtio_find_single_vq() for single virtqueue finding
>   virtio: make virtio_find_vqs() call virtio_find_vqs_ctx()
>   virtio: make virtio_find_single_vq() call virtio_find_vqs()
>   virtio: introduce virtio_queue_info struct and find_vqs_info() config
>     op
>   virtio_pci: convert vp_*find_vqs() ops to find_vqs_info()
>   virtio: convert find_vqs() op implementations to find_vqs_info()
>   virtio: call virtio_find_vqs_info() from virtio_find_single_vq()
>     directly
>   virtio: remove the original find_vqs() op
>   virtio: rename find_vqs_info() op to find_vqs()
>   virtio_blk: convert to use virtio_find_vqs_info()
>   virtio_console: convert to use virtio_find_vqs_info()
>   virtio_crypto: convert to use virtio_find_vqs_info()
>   virtio_net: convert to use virtio_find_vqs_info()
>   scsi: virtio_scsi: convert to use virtio_find_vqs_info()
>   virtiofs: convert to use virtio_find_vqs_info()
>   virtio_balloon: convert to use virtio_find_vqs_info()
>   virtio: convert the rest virtio_find_vqs() users to
>     virtio_find_vqs_info()
>   virtio: remove unused virtio_find_vqs() and virtio_find_vqs_ctx()
>     helpers
>   virtio: rename virtio_find_vqs_info() to virtio_find_vqs()
> 
>  arch/um/drivers/virt-pci.c                    |  8 ++-
>  arch/um/drivers/virtio_uml.c                  | 12 ++--
>  drivers/block/virtio_blk.c                    | 20 +++---
>  drivers/bluetooth/virtio_bt.c                 | 13 ++--
>  drivers/char/virtio_console.c                 | 43 +++++--------
>  drivers/crypto/virtio/virtio_crypto_core.c    | 31 ++++-----
>  drivers/firmware/arm_scmi/virtio.c            | 11 ++--
>  drivers/gpio/gpio-virtio.c                    | 10 +--
>  drivers/gpu/drm/virtio/virtgpu_kms.c          |  9 ++-
>  drivers/iommu/virtio-iommu.c                  | 11 ++--
>  drivers/net/caif/caif_virtio.c                |  8 +--
>  drivers/net/virtio_net.c                      | 34 ++++------
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 12 ++--
>  drivers/platform/mellanox/mlxbf-tmfifo.c      | 10 +--
>  drivers/remoteproc/remoteproc_virtio.c        | 12 ++--
>  drivers/rpmsg/virtio_rpmsg_bus.c              |  8 ++-
>  drivers/s390/virtio/virtio_ccw.c              | 13 ++--
>  drivers/scsi/virtio_scsi.c                    | 32 ++++------
>  drivers/virtio/virtio_balloon.c               | 32 ++++------
>  drivers/virtio/virtio_input.c                 |  9 +--
>  drivers/virtio/virtio_mmio.c                  | 12 ++--
>  drivers/virtio/virtio_pci_common.c            | 48 +++++++-------
>  drivers/virtio/virtio_pci_common.h            |  3 +-
>  drivers/virtio/virtio_pci_modern.c            |  5 +-
>  drivers/virtio/virtio_vdpa.c                  | 13 ++--
>  fs/fuse/virtio_fs.c                           | 22 +++----
>  include/linux/virtio_config.h                 | 64 ++++++++++---------
>  net/vmw_vsock/virtio_transport.c              | 16 ++---
>  sound/virtio/virtio_card.c                    | 23 +++----
>  29 files changed, 242 insertions(+), 302 deletions(-)
> 
> -- 
> 2.45.2

