Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A41D183CA2
	for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725999574; cv=none; b=eot/51tML1OfH3NXWec5IwwhGd5Qj4R3TRyBYxscSqe3qB1xE8v7OVQed2bKgD3NVulu+QRNEdCYLCKfenNYgv0NizPSEsgpeGId+oYCsD2mdd4I0ZHZFY9JgFam0bqcn59pwZ1wJL8JNlnQ2d3tx8If4UYvdmIp+SaCLBhF1FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725999574; c=relaxed/simple;
	bh=8CCuLYWdWTSFpLwKxbqHrDLHqq2DH1fE8m6jNkhdCNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KKVVoaJ7CILBUBMvDzx1ElmMJ2PbtNhX/rd8+TyrIjwgxjYQlALAfxpgTX/I46Bxh+jtVoFc4KX0PyMK3e2eLTF9WSkimnvsGvn8nu6s0v6DXE4+A91WeCM4E70gAmebN4Gyb3FmKxIIdUL50IOVCkXxEOmNko4ZCUTIQdk0pio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MLzM4pe8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MLzM4pe8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725999571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/Ek58qaXc13SAy2fWa0xfKNbuHUlKabbBtKkvuJifU=;
	b=MLzM4pe8Cd6CWC1GRHcTtOTqHdfustqG23h0ZZOa4bbQKmM1E5AiMyzpi3E8U0TOnjHbZH
	9OZUy01OSq1di7KiAIfgbHLdSwtpi0Uu7pm8v3CoOlUWIF0B+rAQ4S9cb1CN8loxsCzx83
	aIklLZuzkKjmpYrMJN8105bdUhz55B8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-Ti3muFqlOUyOlsfFQGqH2w-1; Tue, 10 Sep 2024 16:19:30 -0400
X-MC-Unique: Ti3muFqlOUyOlsfFQGqH2w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8d2ecdf414so198714866b.2
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 13:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725999568; x=1726604368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/Ek58qaXc13SAy2fWa0xfKNbuHUlKabbBtKkvuJifU=;
        b=o14C351W9oBZoXFwdmHEvEc/iLIUrIvaoD5xa3zFV5JakzNhQryub9Z4RYb8Tg4gdj
         ue69VRDV/cTfD716EbldFC277Adw4VMFc/fZmDyDjbt6O1KxKRklUav6QwEUejFlGm8y
         GBJ5EA+PBUtM3kKPjQSJTAFMuon8dhp84b0sspkT9TCHbDh+DrIeCs6eo6XxAEdpiB0U
         o/L+0RM/1H4hNtjmmRliUnsiGWWQuDVSlGiNl0Ot1jbwu/nydR+zxC8oqN6W3SWhIdOe
         jDi/cWAMmyxnJjkTYFU8FpY/M3mjSktSa7qQcZN76Jts5vA/S0c6vgMnMc0UI3ArtTp5
         SByw==
X-Forwarded-Encrypted: i=1; AJvYcCWE18eHiwzIO/FVXDK5aQmZgMNV/boPVi6/I9Gk9mCRWTLflJ2sdrzFvAftZPtONxLLTTGv6TaCtXCf7IAANQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh+pjuZfQK2D0oZ2cTQD62eVa/RRH5Tbr+/rwMHsCbx7GD1vH8
	sstRTAJWBMUOwfzAUbN6R3kTVxvCAhaGHQFbl59yBbBEGUf/DVn3lhXxBuXiIYMz2YJUf7k8Z0V
	JP8Jv692qXprFDNMauNEw6uRvNSVObzrV/0oU/bD0qbM44xAeYdbJvD7MMrAOyHFK
X-Received: by 2002:a17:907:9812:b0:a88:b90b:bd5e with SMTP id a640c23a62f3a-a8ffaaacfa1mr185691766b.3.1725999568239;
        Tue, 10 Sep 2024 13:19:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIpn+zlExuTE3yAX+xjiMRNjjie27yYDse9XLe2ciVUQSSxwhcmURZ5WywfpEvPrJPhC6Cgg==
X-Received: by 2002:a17:907:9812:b0:a88:b90b:bd5e with SMTP id a640c23a62f3a-a8ffaaacfa1mr185687666b.3.1725999567396;
        Tue, 10 Sep 2024 13:19:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:f5ce:2d9:5bfa:9916:aa0a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c62485sm519926966b.104.2024.09.10.13.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 13:19:26 -0700 (PDT)
Date: Tue, 10 Sep 2024 16:19:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 0/5] virtio-mem: s390x support
Message-ID: <20240910161847-mutt-send-email-mst@kernel.org>
References: <20240910191541.2179655-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240910191541.2179655-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Sep 10, 2024 at 09:15:34PM +0200, David Hildenbrand wrote:
> Let's finally add s390x support for virtio-mem; my last RFC was sent
> 4 years ago, and a lot changed in the meantime.
> 
> This is based on mm/stable.
> 
> I sent out the QEMU part earlier today [1], that contains some more details
> and a usage example on s390x (last patch).
> 
> There is not too much in here: The biggest part is querying a new diag(500)
> STORAGE_LIMIT hypercall to obtain the proper "max_physmem_end". Once this
> and the QEMU part will go upstream, it will get documented in [2]
> 
> The last two patches are not strictly required but certainly nice-to-have.
> 
> Note that -- in contrast to standby memory -- virtio-mem memory must be
> configured to be automatically onlined as soon as hotplugged. The easiest
> approach is using the "memhp_default_state=" kernel parameter or by using
> proper udev rules. More details can be found at [3].
> 
> I have reviving+upstreaming a systemd service to handle configuring
> that on my todo list, but for some reason I keep getting distracted ...
> 
> I tested various things, including:
>  * Various memory hotplug/hotunplug combinations
>  * Device hotplug/hotunplug
>  * /proc/iomem output
>  * reboot
>  * kexec
>  * kdump: make sure we don't hotplug memory
> 
> One remaining work item is kdump support for virtio-mem memory. I
> am working on a prototype that will be fairly straight forward,
> because the virtio-mem driver already supports a special kdump mode and
> dracut will already include it in the initrd as default. With
> holiday and conferences coming up I rather sent this out now.
> 
> [1] https://lkml.kernel.org/r/20240910175809.2135596-1-david@redhat.com
> [2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
> [3] https://virtio-mem.gitlab.io/user-guide/user-guide-linux.html
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>


It's mostly s390 changes, so should be merged through that tree.
I acked the only virtio specific patch.

> David Hildenbrand (5):
>   s390/kdump: implement is_kdump_kernel()
>   s390/physmem_info: query diag500(STORAGE_LIMIT) to support QEMU/KVM
>     memory devices
>   virtio-mem: s390x support
>   lib/Kconfig.debug: default STRICT_DEVMEM to "y" on s390x
>   s390/sparsemem: reduce section size to 128 MiB
> 
>  arch/s390/boot/physmem_info.c        | 46 ++++++++++++++++++++++++++--
>  arch/s390/include/asm/kexec.h        |  4 +++
>  arch/s390/include/asm/physmem_info.h |  3 ++
>  arch/s390/include/asm/sparsemem.h    |  2 +-
>  arch/s390/kernel/crash_dump.c        |  6 ++++
>  drivers/virtio/Kconfig               | 12 ++++----
>  lib/Kconfig.debug                    |  2 +-
>  7 files changed, 64 insertions(+), 11 deletions(-)
> 
> -- 
> 2.46.0

