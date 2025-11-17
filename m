Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A650313264
	for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 10:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373788; cv=none; b=nzH+z5er5hC7UhbZdW7gA8qdRd7CL+hRUr41PZgWv862ChfEcVmYF5BHCRqQGu4haRypo09AAuZ7oD03KwCKiEY+wUPKirPArnV/lEk1AIjomG4GBr68r+tN6M44wl77F1jyCxXSH1Fzq7qB9yxevwxA1F3NdpNAYn7FKpLoHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373788; c=relaxed/simple;
	bh=Jjg4Iyd/07DTsm5qkOr6BIQlspwf+2NqiRbHnRlshMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qIT8p1qiboTinnJg6v/KowTGlXyyxo4DRmWWuM+BsF7mx1cHJQgLvN+FBlApcY2hoZhS835yAtgoxDe0aXLTM+gp/BpGqGthquP8lE2uLN71F2109D89enLvt3FaJQehQU4GmCdN6SMZPIkg5FaoNu+pO8qpGkmRCrU0qlN8tmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1/Zi+0O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1/Zi+0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763373783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9OoW97iXrHDq8mXDdV4L+0O0Y0xQp8TMPGSKNutW8hk=;
	b=h1/Zi+0OTvSk40ZUokYkayI6cK20XupbHnTiTLWYbGnOqnTOI5UYk63Pf1Rpb/+6zwNegL
	w2plvM/M+/hOJWiY66a5MbXKKEf5w7yEBAXY4aax0gOG8bOl0WEmkwLPNz8P1gecuvlUlL
	Q/tY1CQ9qlD2gJ+TC6uHA/s5fx9V3kM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-3gqvCPbiPlG_5Q_E14HR5g-1; Mon, 17 Nov 2025 05:03:02 -0500
X-MC-Unique: 3gqvCPbiPlG_5Q_E14HR5g-1
X-Mimecast-MFC-AGG-ID: 3gqvCPbiPlG_5Q_E14HR5g_1763373781
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so11224915e9.1
        for <virtualization@lists.linux.dev>; Mon, 17 Nov 2025 02:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763373781; x=1763978581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OoW97iXrHDq8mXDdV4L+0O0Y0xQp8TMPGSKNutW8hk=;
        b=fenJ6AFQuG6JWtUPSr0yVbeVoVza45B+nIfE3zQ3ILgLcDVWmBJfB9R7WtGWsV3vN1
         HGtFGLL7fF2sfWdUyZr4AlfqIyCSDPLrcbQpuOpFAaLwjf+o/fGiqSwrKz/u/dfTFjoS
         TmrcMoMgPmSZIMrqv15E/U4ZSRYgA/QRqpNwol0U0iaUNwQCbm1ejUPD/6ew3GkV6hk0
         R/qQb/cT5nTS4Ka76WZEkbnoMJZtJEl1EIfUYGVtmeaQGb7JpvrZb0rI8IP/AR0rgiJI
         iUpF/y0KvkDgW1OBhIXcHuWpVF+TeVFGh/6OyTQuIW6frIn6KcLUHfntByBEiIln2fnY
         kObQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPQFBNszqG0DZOIysVthj+Li1D9FLRUBW71f+qOijAqur+Ll/AXsaR+TVsgQIELXx+7t0I8ORpThOfAT/hYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXHwRXDh1d9D6p9/nMQFgfY821YI5uHCEcL4aghWgazCQEah9F
	SsfjT1ljWL0Gfmt5TR9xcfzMMEp8twPaWZDFIYqUEcj7d0146zZVyaOVwgX9qHhAPF0tdv+n0A1
	QzLe/1dkZ3JRHhx0ydT5ezkra0pDoKuh2T2SJmzIOTDJg3KArZSS5CKzy6S4JCOUJ8cSsjKkkOo
	jl
X-Gm-Gg: ASbGncvqKIKjGmp24FcTioZvQ3BjlZc4rkKtnPaPgOazaV9YHF+RkNqryeakbEk2Im/
	h+GlzLISLWVQODx4eC9VGOiQy8UttoJwfnRXwOvDgvbv96c71eOviP1qpSM0xJgHU/mgdUPSSAQ
	J+gCxzle7FXy5ApoSaS4rni81dKC+QrtcKv0Rt2wOiteMVleopV46p00UVl+4G6qfjHFm4xF94H
	EHW4AeKlgOYRikUkr7nEdDyhfobWUbfaKzSEdBNgaRMBooRG6FXfbhiYSlNU+wA0xb0epi50xmq
	RMfOawPCy1xUnh4IKhOHcSkwN+4u95gdUhrMAW0YID4aMPqTrZvsFaAJttpGY9+TW2pYviJIRdR
	FhVi8O+9zioLH62zSp6Q=
X-Received: by 2002:a05:600c:3baa:b0:477:54b3:3484 with SMTP id 5b1f17b1804b1-4778febd2eamr102341605e9.37.1763373780641;
        Mon, 17 Nov 2025 02:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsCVRVH8yi3mxQpF+a3sceLn+huBmPLQphd4cPau/Xd1zOyTQvr9xQ1+/sl1GzpkLtclk+xQ==
X-Received: by 2002:a05:600c:3baa:b0:477:54b3:3484 with SMTP id 5b1f17b1804b1-4778febd2eamr102341085e9.37.1763373779845;
        Mon, 17 Nov 2025 02:02:59 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b8d6sm26300205f8f.28.2025.11.17.02.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:02:59 -0800 (PST)
Date: Mon, 17 Nov 2025 05:02:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shameerali.kolothum.thodi@huawei.com,
	jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v10 00/12] virtio_net: Add ethtool flow rules
 support
Message-ID: <20251117050228-mutt-send-email-mst@kernel.org>
References: <20251112193132.1909-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251112193132.1909-1-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OUKcSowmsbRJ3_qJvGGpfyyFk7BTw83s1S759yykQn4_1763373781
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2025 at 01:31:20PM -0600, Daniel Jurgens wrote:
> This series implements ethtool flow rules support for virtio_net using the
> virtio flow filter (FF) specification. The implementation allows users to
> configure packet filtering rules through ethtool commands, directing
> packets to specific receive queues, or dropping them based on various
> header fields.

Bad threading here Daniel, so tools that rely on threading break.


> The series starts with infrastructure changes to expose virtio PCI admin
> capabilities and object management APIs. It then creates the virtio_net
> directory structure and implements the flow filter functionality with support
> for:
> 
> - Layer 2 (Ethernet) flow rules
> - IPv4 and IPv6 flow rules  
> - TCP and UDP flow rules (both IPv4 and IPv6)
> - Rule querying and management operations
> 
> Setting, deleting and viewing flow filters, -1 action is drop, positive
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
> ---
> v2: https://lore.kernel.org/netdev/20250908164046.25051-1-danielj@nvidia.com/
>   - Fix sparse warnings
>   - Fix memory leak on subsequent failure to allocate
>   - Fix some Typos
> 
> v3: https://lore.kernel.org/netdev/20250923141920.283862-1-danielj@nvidia.com/
>   - Added admin_ops to virtio_device kdoc.
> 
> v4:
>   - Fixed double free bug inserting flows
>   - Fixed incorrect protocol field check parsing ip4 headers.
>   - (u8 *) changed to (void *)
>   - Added kdoc comments to UAPI changes.
>   - No longer split up virtio_net.c
>   - Added config op to execute admin commands.
>       - virtio_pci assigns vp_modern_admin_cmd_exec to this callback.
>   - Moved admin command API to new core file virtio_admin_commands.c
> 
> v5: 
>   - Fixed compile error
>   - Fixed static analysis warning on () after macro
>   - Added missing fields to kdoc comments
>   - Aligned parameter name between prototype and kdoc
> 
> v6:
>   - Fix sparse warning "array of flexible structures" Jakub K/Simon H
>   - Use new variable and validate ff_mask_size before set_cap. MST
> 
> v7:
>   - Change virtnet_ff_init to return a value. Allow -EOPNOTSUPP. Xuan
>   - Set ff->ff_{caps, mask, actions} NULL in error path. Paolo Abini
>   - Move for (int i removal hung back a patch. Paolo Abini
> 
> v8
>   - Removed unused num_classifiers. Jason Wang
>   - Use real_ff_mask_size when setting the selector caps. Jason Wang
> 
> v9:
>   - Set err to -ENOMEM after alloc failures in virtnet_ff_init. Simon H
> 
> v10:
>   - Return -EOPNOTSUPP in virnet_ff_init before allocing any memory.
>     Jason Wang/Paolo Abeni
> 
> 
> Daniel Jurgens (12):
>   virtio_pci: Remove supported_cap size build assert
>   virtio: Add config_op for admin commands
>   virtio: Expose generic device capability operations
>   virtio: Expose object create and destroy API
>   virtio_net: Query and set flow filter caps
>   virtio_net: Create a FF group for ethtool steering
>   virtio_net: Implement layer 2 ethtool flow rules
>   virtio_net: Use existing classifier if possible
>   virtio_net: Implement IPv4 ethtool flow rules
>   virtio_net: Add support for IPv6 ethtool steering
>   virtio_net: Add support for TCP and UDP ethtool rules
>   virtio_net: Add get ethtool flow rules ops
> 
>  drivers/net/virtio_net.c               | 1147 ++++++++++++++++++++++++
>  drivers/virtio/Makefile                |    2 +-
>  drivers/virtio/virtio_admin_commands.c |  165 ++++
>  drivers/virtio/virtio_pci_common.h     |    1 -
>  drivers/virtio/virtio_pci_modern.c     |   10 +-
>  include/linux/virtio_admin.h           |  125 +++
>  include/linux/virtio_config.h          |    6 +
>  include/uapi/linux/virtio_net_ff.h     |  156 ++++
>  include/uapi/linux/virtio_pci.h        |    7 +-
>  9 files changed, 1608 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/virtio/virtio_admin_commands.c
>  create mode 100644 include/linux/virtio_admin.h
>  create mode 100644 include/uapi/linux/virtio_net_ff.h
> 
> -- 
> 2.50.1

