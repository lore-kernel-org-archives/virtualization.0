Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12EA223339
	for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835162; cv=none; b=Z6LNeA3q4v+2UIspYWF/KcLptOqQvJ7FK59naMjVRJ8BP9d4GDtxFzKzFaN9imXmdkcpWzqOyYD1ziq2/rU1E6yvOAgkDj9BwRbHGA7mmfaUGXWTnf3FJgHBb8mQ00zcCAO2dhdH7Nppj9AMQll68D7+iJTffzzFWMb2q70pjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835162; c=relaxed/simple;
	bh=zjFx9117l39A4vOTTnDLIMm/8H5D3mIi8yTZGob+8C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nkpFCrLf4U9CgQrHSZe9Myxa+KjPYZ3YOtHUKWAVR8mHcNS9p1UBv+qvBSpARPbAN8mZaqAyPGQ8jJSYoDFoyKYDfUvGEWj8WeSnNaKNh7WCG9ICEq2/aoAWUxdDVneYXzMw7MM40nCy2t2d9L6g6MGkMnvGO3k5y5t2+1WbWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ljhm+KwM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ljhm+KwM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758835158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=spQeOOTFPyEeu2h1tbBdRDU1K8uKLDHL8VB189R02sk=;
	b=Ljhm+KwM81vNMnOQFo5tVrk8SJfQ6oD1TSmcMH0+sbJK/394t7k2G2zSkxxigghvo+Uazv
	+TLljZAQCak0VJTnNTU1N2784ezds9iPhvTXTi8QWM+ZZCpIzs67e3DkBhB68wi+wwtI5T
	X0D/ccaQZBnzjThuwr250nCBzTfV5AI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-cDQBee34OR6xurMYTN5KrA-1; Thu, 25 Sep 2025 17:19:17 -0400
X-MC-Unique: cDQBee34OR6xurMYTN5KrA-1
X-Mimecast-MFC-AGG-ID: cDQBee34OR6xurMYTN5KrA_1758835156
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f4fbdf144dso805588f8f.2
        for <virtualization@lists.linux.dev>; Thu, 25 Sep 2025 14:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758835156; x=1759439956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spQeOOTFPyEeu2h1tbBdRDU1K8uKLDHL8VB189R02sk=;
        b=Whh5CWe7VcboXCbKsOlzDIT1Jjka29PoNORX5P4rsrrK0E5ml+8lLogbSsklPq4bGe
         EvL/IBGxxnv7C4cHoPAE5JfumQou4buzrCmlpzlpinXkkCwg35xeNBNagxUMf81Oixhd
         GxC92GWJeVVJx1mg/ZZPpJxcMP76rnXuZlo6JXcV7SRDitnZmVlaeTEPTW/akKmUmbeO
         VZi/EffU2bUegcF8nvSkR3Z6mG9OyFqid4YM0XQKXcVud5v6CS5wP/0gJvrClgRl3s85
         yw2QmTc05uqZAeEY0KJPCIb6+/pet7W9QNVWtOopSQ0l/Kb2mRsTMfQgV08Hhwv2fVQX
         l+Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXYdBMZbTayMcwj7cdLECh5s51xf4RKsrwKc6yn5Xo6JRLwuan89zW5kYWmy/zzSgkv7YOweutDviRtdM5T2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHx/PygaluUC3+bLimuAh/oXGi/Z4JZw6Xzk+jRxe909HlsJ0n
	pg3vydVZD69MuUmQNjty66UCJhO2/7mdIb/5EpUYThohRr+qBHKxrxlDDko4/y38EliMNaE7y42
	82kha6bQdaj0IpimkKMunsA1nILMLmGLyZqkpDwyYbWqo74PdaIxr/tmA6xx6x+yCUo76
X-Gm-Gg: ASbGnctX3p8oWrg8OfMH1wHFguaCNS/HEPpuoEWyAfuKqWEAEd/2RHm+hfEB6NJ1Fow
	6KBjvsym2pnrAoFDHSjjxAAmpGzPz4Gyin7LWYO8DTgyEaJZnVIJ1vfi6S4uzjmBE6B7TVViTZW
	i6kOaojBCxW2xBcyIspG+IZ4Zfyc3QMIK45aHmseSjaVLeIwYK+9t2t+U/TISjze2iP39fknC6N
	XjKil3GiHUa1PKXIDWYrVyoBqMQ3ac1GqUWsJZYr0+xWstSjyRxQv34+8QTre8ELF2ZxGpmIqrR
	ZS920dGILDqhjnuVwiSIrUhWuO/r5tV5lw==
X-Received: by 2002:a05:6000:2507:b0:40b:c42e:fe39 with SMTP id ffacd0b85a97d-40e4ece625cmr4906443f8f.40.1758835156133;
        Thu, 25 Sep 2025 14:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnj4SMuw4upcu484HaL+BNgTuNhf2ZatiJq97ndUq/IzG5WhKojug19ivgk+en20R8S6e0Kg==
X-Received: by 2002:a05:6000:2507:b0:40b:c42e:fe39 with SMTP id ffacd0b85a97d-40e4ece625cmr4906422f8f.40.1758835155727;
        Thu, 25 Sep 2025 14:19:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bede39sm50301295e9.18.2025.09.25.14.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:19:15 -0700 (PDT)
Date: Thu, 25 Sep 2025 17:19:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, alex.williamson@redhat.com,
	pabeni@redhat.com, virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v3 00/11] virtio_net: Add ethtool flow rules
 support
Message-ID: <20250925171744-mutt-send-email-mst@kernel.org>
References: <20250923141920.283862-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250923141920.283862-1-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ltWADygOHPRq5QyBxtaJI0ZP0XFTd3249maiTys4-Xg_1758835156
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 23, 2025 at 09:19:09AM -0500, Daniel Jurgens wrote:
> This series implements ethtool flow rules support for virtio_net using the
> virtio flow filter (FF) specification. The implementation allows users to
> configure packet filtering rules through ethtool commands, directing
> packets to specific receive queues, or dropping them based on various
> header fields.
> 
> The series starts with infrastructure changes to expose virtio PCI admin
> capabilities and object management APIs. It then creates the virtio_net
> directory structure and implements the flow filter functionality with support
> for:



ok i took a quick look as you asked

main things:


	1. I am not sure device output is validated sufficiently
	and can not cause all kind of overflows
	can be an issues esp for coco


	2. avoid u8* just to do pointer math. void* is better for this.



	

> - Layer 2 (Ethernet) flow rules
> - IPv4 and IPv6 flow rules  
> - TCP and UDP flow rules (both IPv4 and IPv6)
> - Rule querying and management operations
> 
> Setting, deleting and viewing flow filters, -1 action is drop, postive
> integers steer to that RQ:
> 
> $ ethtool -u ens9
> 4 RX rings available
> Total 0 rules
> 
> $ ethtool -U ens9 flow-type ether src 1c:34:da:4a:33:dd action 0
> Added rule with ID 0
> $ ethtool -U ens9 flow-type udp4 dst-port 5001 action 3
> Added rule with ID 1
> $ ethtool -U ens9 flow-type tcp6 src-ip fc00::2 dst-port 5001 action 2
> Added rule with ID 2
> $ ethtool -U ens9 flow-type ip4 src-ip 192.168.51.101 action 1
> Added rule with ID 3
> $ ethtool -U ens9 flow-type ip6 dst-ip fc00::1 action -1
> Added rule with ID 4
> $ ethtool -U ens9 flow-type ip6 src-ip fc00::2 action -1
> Added rule with ID 5
> $ ethtool -U ens9 delete 4
> $ ethtool -u ens9
> 4 RX rings available
> Total 5 rules
> 
> Filter: 0
>         Flow Type: Raw Ethernet
>         Src MAC addr: 1C:34:DA:4A:33:DD mask: 00:00:00:00:00:00
>         Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>         Ethertype: 0x0 mask: 0xFFFF
>         Action: Direct to queue 0
> 
> Filter: 1
>         Rule Type: UDP over IPv4
>         Src IP addr: 0.0.0.0 mask: 255.255.255.255
>         Dest IP addr: 0.0.0.0 mask: 255.255.255.255
>         TOS: 0x0 mask: 0xff
>         Src port: 0 mask: 0xffff
>         Dest port: 5001 mask: 0x0
>         Action: Direct to queue 3
> 
> Filter: 2
>         Rule Type: TCP over IPv6
>         Src IP addr: fc00::2 mask: ::
>         Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>         Traffic Class: 0x0 mask: 0xff
>         Src port: 0 mask: 0xffff
>         Dest port: 5001 mask: 0x0
>         Action: Direct to queue 2
> 
> Filter: 3
>         Rule Type: Raw IPv4
>         Src IP addr: 192.168.51.101 mask: 0.0.0.0
>         Dest IP addr: 0.0.0.0 mask: 255.255.255.255
>         TOS: 0x0 mask: 0xff
>         Protocol: 0 mask: 0xff
>         L4 bytes: 0x0 mask: 0xffffffff
>         Action: Direct to queue 1
> 
> Filter: 5
>         Rule Type: Raw IPv6
>         Src IP addr: fc00::2 mask: ::
>         Dest IP addr: :: mask: ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff
>         Traffic Class: 0x0 mask: 0xff
>         Protocol: 0 mask: 0xff
>         L4 bytes: 0x0 mask: 0xffffffff
>         Action: Drop
> 
> v2:
>   - Fix sparse warnings
>   - Fix memory leak on subsequent failure to allocate
>   - Fix some Typos
> 
> v3:
>   - Rebased
> 	- Added back get|set_rxnfc to virtio_net
>   - Added admin_ops to virtio_device kdoc.
> 
> Daniel Jurgens (11):
>   virtio-pci: Expose generic device capability operations
>   virtio-pci: Expose object create and destroy API
>   virtio_net: Create virtio_net directory
>   virtio_net: Query and set flow filter caps
>   virtio_net: Create a FF group for ethtool steering
>   virtio_net: Implement layer 2 ethtool flow rules
>   virtio_net: Use existing classifier if possible
>   virtio_net: Implement IPv4 ethtool flow rules
>   virtio_net: Add support for IPv6 ethtool steering
>   virtio_net: Add support for TCP and UDP ethtool rules
>   virtio_net: Add get ethtool flow rules ops
> 
>  MAINTAINERS                                   |    2 +-
>  drivers/net/Makefile                          |    2 +-
>  drivers/net/virtio_net/Makefile               |    8 +
>  drivers/net/virtio_net/virtio_net_ff.c        | 1029 +++++++++++++++++
>  drivers/net/virtio_net/virtio_net_ff.h        |   42 +
>  .../virtio_net_main.c}                        |   46 +
>  drivers/vfio/pci/virtio/migrate.c             |    8 +-
>  drivers/virtio/virtio.c                       |  141 +++
>  drivers/virtio/virtio_pci_common.h            |    1 -
>  drivers/virtio/virtio_pci_modern.c            |  320 ++---
>  include/linux/virtio.h                        |   22 +
>  include/linux/virtio_admin.h                  |  101 ++
>  include/linux/virtio_pci_admin.h              |    7 +-
>  include/uapi/linux/virtio_net_ff.h            |   82 ++
>  include/uapi/linux/virtio_pci.h               |    7 +-
>  15 files changed, 1677 insertions(+), 141 deletions(-)
>  create mode 100644 drivers/net/virtio_net/Makefile
>  create mode 100644 drivers/net/virtio_net/virtio_net_ff.c
>  create mode 100644 drivers/net/virtio_net/virtio_net_ff.h
>  rename drivers/net/{virtio_net.c => virtio_net/virtio_net_main.c} (99%)
>  create mode 100644 include/linux/virtio_admin.h
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
> 
> -- 
> 2.45.0

