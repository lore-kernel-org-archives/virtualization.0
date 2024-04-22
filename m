Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7061BC2F
	for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819864; cv=none; b=DuRnimpiShwL57mElhFyVO8/ACGVy5Sw/EAPpUJGA7O1isDuyvq+nWIkGaM/T3yVdSb+5fS451xZA+LXZCkI49Cg30PqHCGBjzYLvndfzvUA7ThgBlC2eO2UHLkQxW8zWLpxwlv7tzZEPHBk0PSnjxhSWg3cxiBixPNAwmyfris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819864; c=relaxed/simple;
	bh=W171TFM5VU0GmHCaO6R45CQK9rr900bDzzrfhGJgbJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mha5EdEONkDQ3kvUAz8bIKGE1dInBPKxOCdJsvSYXoCYTvoIVmNkPBytAts/UuLrAXumziBco/N7Vo+j3DRoJeTOOIiSpbZ7O1ndo1HnXtPb8mfRZc723jzFVo8OWNHjFpR1J0+7HH7d9DJ+U8FEjAqpRln0yHPZfAzlneobPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YngYn6H0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YngYn6H0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713819861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DCBlw9Y3eyV4XXcYVaIC/t/CS+f8jLueDhczaKF6fWs=;
	b=YngYn6H0eF663W+tRHsDXEjHrSOvkIizYsV1dlKmhtSv7XoD8OTuq7Kr8EDdQhbUUkv+3Y
	DWgJ0W+HKofCNXOp4iKgEjqK/Y6vkliYU35WZ7ovrxVkMbqf1REzqP74cOkJi+fZ5C2wE2
	zvBZ5LocqVjoSw/YYfK1r8v3Q+9hboA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-z-0XM3z_NJeKt0sfRIB9Rg-1; Mon, 22 Apr 2024 17:04:19 -0400
X-MC-Unique: z-0XM3z_NJeKt0sfRIB9Rg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343c6bb1f21so3080665f8f.1
        for <virtualization@lists.linux.dev>; Mon, 22 Apr 2024 14:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713819859; x=1714424659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCBlw9Y3eyV4XXcYVaIC/t/CS+f8jLueDhczaKF6fWs=;
        b=gqRbJAb1+wfCQLXgshciN1Sk5dhoS7qli9dmZExn0x1QbI9js1PDUvudXKlAcBvCvo
         vCxICjN+sqP9Lv+O4vr5nANh7zVBQukf2VPCSJRtdbtjv1XmFrwHRs0RKAN4TURFigeB
         wnv1AQB2U7g8WZwzcFSB4s+cVH3wqRWbZhiYk9zTKYy96Kgx72a4qlbvOtUURoul3+WE
         YJoO2cVLXh8zyclgsFBAgFTqTQ0YwGm1asAFC0ZdgxwN5H8xNIMq7JxQhFW3yVY2ux+S
         zfBi5vSQZc9MPvmlR0k4KhW1e5vGSR2wxDmN0Z0kPBvLJFzkgmO9MaBeLCSIt9xbmt4D
         PcEg==
X-Forwarded-Encrypted: i=1; AJvYcCWKyV2/+leGk4dmpI5o2pONMTkaRYcJOvZPd7csag8ea0CEW7xWHlRo8WLqNjgQSeREw2sO66O8WAJXMsRTyahgbdh8IRza6nuLjdxnSMU=
X-Gm-Message-State: AOJu0YyiBkVSa/uHi8X3omJ5ZinysgmREgBPerckVTfbJqKcbY4AxGFa
	FUt75vcILFZA3Y4+6tVLi5FLQuHBhtodYvkgsDwWH8nK/aNJMb4lKJUJqep5Ng945iMH+Mtvw6U
	HRk/Pme/8YXZNG1KlrziCfJ4Uxyjj6CI2OVP9oNi07drbTta8bTkT/qPVXv8uddte
X-Received: by 2002:adf:e80c:0:b0:34a:9adc:c36e with SMTP id o12-20020adfe80c000000b0034a9adcc36emr6730136wrm.40.1713819858621;
        Mon, 22 Apr 2024 14:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv7PHtb4y8fNhZfRcBU265fpkd1KK31Zm+V98qWA5end8Pwrx3mlxsQybYi5iYjw+SD9chew==
X-Received: by 2002:adf:e80c:0:b0:34a:9adc:c36e with SMTP id o12-20020adfe80c000000b0034a9adcc36emr6730112wrm.40.1713819858107;
        Mon, 22 Apr 2024 14:04:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041638a085d3sm21513127wmq.15.2024.04.22.14.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 14:04:17 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:04:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, parav@nvidia.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
	petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v4 0/6] selftests: virtio_net: introduce initial
 testing infrastructure
Message-ID: <20240422170405-mutt-send-email-mst@kernel.org>
References: <20240418160830.3751846-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240418160830.3751846-1-jiri@resnulli.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2024 at 06:08:24PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This patchset aims at introducing very basic initial infrastructure
> for virtio_net testing, namely it focuses on virtio feature testing.
> 
> The first patch adds support for debugfs for virtio devices, allowing
> user to filter features to pretend to be driver that is not capable
> of the filtered feature.


virtio things:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Example:
> $ cat /sys/bus/virtio/devices/virtio0/features
> 1110010111111111111101010000110010000000100000000000000000000000
> $ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
> $ cat /sys/kernel/debug/virtio/virtio0/filter_features
> 5
> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
> $ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
> $ cat /sys/bus/virtio/devices/virtio0/features
> 1110000111111111111101010000110010000000100000000000000000000000
> 
> Leverage that in the last patch that lays ground for virtio_net
> selftests testing, including very basic F_MAC feature test.
> 
> To run this, do:
> $ make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests
> 
> It is assumed, as with lot of other selftests in the net group,
> that there are netdevices connected back-to-back. In this case,
> two virtio_net devices connected back to back. If you use "tap" qemu
> netdevice type, to configure this loop on a hypervisor, one may use
> this script:
> #!/bin/bash
> 
> DEV1="$1"
> DEV2="$2"
> 
> sudo tc qdisc add dev $DEV1 clsact
> sudo tc qdisc add dev $DEV2 clsact
> sudo tc filter add dev $DEV1 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV2
> sudo tc filter add dev $DEV2 ingress protocol all pref 1 matchall action mirred egress redirect dev $DEV1
> sudo ip link set $DEV1 up
> sudo ip link set $DEV2 up
> 
> Another possibility is to use virtme-ng like this:
> $ vng --network=loop
> or directly:
> $ vng --network=loop -- make -C tools/testing/selftests/ TARGETS=drivers/net/virtio_net/ run_tests
> 
> "loop" network type will take care of creating two "hubport" qemu netdevs
> putting them into a single hub.
> 
> To do it manually with qemu, pass following command line options:
> -nic hubport,hubid=1,id=nd0,model=virtio-net-pci
> -nic hubport,hubid=1,id=nd1,model=virtio-net-pci
> 
> ---
> v3->v4:
> - addressed comments from Petr and Benjamin, more or less cosmetical
>   issues. See individual patches changelog for details.
> - extended cover letter by vng usage
> v2->v3:
> - added forgotten kdoc entry in patch #1.
> v1->v2:
> - addressed comments from Jakub and Benjamin, see individual
>   patches #3, #5 and #6 for details.
> 
> Jiri Pirko (6):
>   virtio: add debugfs infrastructure to allow to debug virtio features
>   selftests: forwarding: move initial root check to the beginning
>   selftests: forwarding: add ability to assemble NETIFS array by driver
>     name
>   selftests: forwarding: add check_driver() helper
>   selftests: forwarding: add wait_for_dev() helper
>   selftests: virtio_net: add initial tests
> 
>  MAINTAINERS                                   |   1 +
>  drivers/virtio/Kconfig                        |   9 ++
>  drivers/virtio/Makefile                       |   1 +
>  drivers/virtio/virtio.c                       |   8 ++
>  drivers/virtio/virtio_debug.c                 | 109 +++++++++++++++
>  include/linux/virtio.h                        |  35 +++++
>  tools/testing/selftests/Makefile              |   1 +
>  .../selftests/drivers/net/virtio_net/Makefile |  15 ++
>  .../drivers/net/virtio_net/basic_features.sh  | 131 ++++++++++++++++++
>  .../selftests/drivers/net/virtio_net/config   |   2 +
>  .../net/virtio_net/virtio_net_common.sh       |  99 +++++++++++++
>  tools/testing/selftests/net/forwarding/lib.sh |  70 +++++++++-
>  12 files changed, 477 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/virtio/virtio_debug.c
>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/Makefile
>  create mode 100755 tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/config
>  create mode 100644 tools/testing/selftests/drivers/net/virtio_net/virtio_net_common.sh
> 
> -- 
> 2.44.0

