Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9331C4F895
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfcnyHaz"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2134883DDE
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 23:27:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2134883DDE
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NfcnyHaz
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-jsw1mAijtY
	for <virtualization@lists.linux-foundation.org>;
	Wed, 10 Jan 2024 23:27:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 61F6583DDD
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 23:27:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61F6583DDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704929241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SrNHEIe3ea+e/UXJPqy7LTP7mhEx2H+CbelvED2S6dg=;
	b=NfcnyHazphUWURZH5d3sLNcRFUCjxrEZJRRLi66TYBPSjjSgSbiy5cOBsqE8urXjoCsdad
	+DWhsd1JA/xhondZGcy5RoDjMH1eUQwwTMlH8JMMkF3uh1O1N5aPTijhhzpbGAlvvE9nCm
	MHS3OndGWV3sfpEWqs6JCs/bacdwgjk=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-_OU9RRrhN8a6pyZfJ1gESw-1; Wed, 10 Jan 2024 18:27:20 -0500
X-MC-Unique: _OU9RRrhN8a6pyZfJ1gESw-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6dde701a6ccso2360899a34.3
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 15:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704929239; x=1705534039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrNHEIe3ea+e/UXJPqy7LTP7mhEx2H+CbelvED2S6dg=;
        b=F9t0oMGHlWJSjCZtXaJfS5clUi6k2fPvyfRHtnxIBGi67B9sXbnf3KtLvjYetAVNXn
         n0eP27IZRrw1zZZhexjnoPCY5BvG0WZaOFy4mPW9JcAOjLOH0XLZH71f+wgnrzbGhbTv
         XDUysdF2dZfGEO28Jau5fNIpOUJYSKvgHDJ3+uvH40oPlXGHX+G/bbsHzhIkWJ3oMj0Q
         KnCFo4TSexpMQHZmfRBdptD0p37WbGgKafMpMC3vtgs3jbavchQmoP5Mcrn9UCJZ/oXB
         orttm/i85d5QmQvXQlQAJaJOde/ibwQcgjb+hdXmwTuD5ZmjDlewIKlkRyQEJuSPFbVN
         3/dQ==
X-Gm-Message-State: AOJu0YwdPPH/TkInkqJ2fdReNiUNwtz/h59XpDfhsKOcgIbCpVeJfsDx
	BtqMbj6W5mjvlb1LfnfUvqhr7R4mZVbeiubCYecWd6f0osaHrDPaMOIHNz7MpywWFyS2kCqEzGs
	vePB1HRnv41xcxPdTUyrJUpI7DMcA0+X1AE/xKhuRRjQJiLW80w==
X-Received: by 2002:a05:6830:1114:b0:6da:531d:9af2 with SMTP id w20-20020a056830111400b006da531d9af2mr406998otq.10.1704929239323;
        Wed, 10 Jan 2024 15:27:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2C6jpBhPHNx973PLEU/pQRswb7lqo3Py9HGD/W0KEfAfyz3J8fHg+rAd2j5LDlltJSi4l0g==
X-Received: by 2002:a05:6830:1114:b0:6da:531d:9af2 with SMTP id w20-20020a056830111400b006da531d9af2mr406985otq.10.1704929239066;
        Wed, 10 Jan 2024 15:27:19 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id w10-20020a9d70ca000000b006dec024acffsm115655otj.57.2024.01.10.15.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 15:27:18 -0800 (PST)
Date: Wed, 10 Jan 2024 16:27:16 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Yishai Hadas <yishaih@nvidia.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe
 <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: fix virtio-pci dependency
Message-ID: <20240110162716.64d37d66.alex.williamson@redhat.com>
In-Reply-To: <20240109075731.2726731-1-arnd@kernel.org>
References: <20240109075731.2726731-1-arnd@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jan 2024 08:57:19 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The new vfio-virtio driver already has a dependency on VIRTIO_PCI_ADMIN_LEGACY,
> but that is a bool symbol and allows vfio-virtio to be built-in even if
> virtio-pci itself is a loadable module. This leads to a link failure:
> 
> aarch64-linux-ld: drivers/vfio/pci/virtio/main.o: in function `virtiovf_pci_probe':
> main.c:(.text+0xec): undefined reference to `virtio_pci_admin_has_legacy_io'
> aarch64-linux-ld: drivers/vfio/pci/virtio/main.o: in function `virtiovf_pci_init_device':
> main.c:(.text+0x260): undefined reference to `virtio_pci_admin_legacy_io_notify_info'
> aarch64-linux-ld: drivers/vfio/pci/virtio/main.o: in function `virtiovf_pci_bar0_rw':
> main.c:(.text+0x6ec): undefined reference to `virtio_pci_admin_legacy_common_io_read'
> aarch64-linux-ld: main.c:(.text+0x6f4): undefined reference to `virtio_pci_admin_legacy_device_io_read'
> aarch64-linux-ld: main.c:(.text+0x7f0): undefined reference to `virtio_pci_admin_legacy_common_io_write'
> aarch64-linux-ld: main.c:(.text+0x7f8): undefined reference to `virtio_pci_admin_legacy_device_io_write'
> 
> Add another explicit dependency on the tristate symbol.
> 
> Fixes: eb61eca0e8c3 ("vfio/virtio: Introduce a vfio driver over virtio devices")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/vfio/pci/virtio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/virtio/Kconfig b/drivers/vfio/pci/virtio/Kconfig
> index fc3a0be9d8d4..bd80eca4a196 100644
> --- a/drivers/vfio/pci/virtio/Kconfig
> +++ b/drivers/vfio/pci/virtio/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config VIRTIO_VFIO_PCI
>          tristate "VFIO support for VIRTIO NET PCI devices"
> -        depends on VIRTIO_PCI_ADMIN_LEGACY
> +        depends on VIRTIO_PCI && VIRTIO_PCI_ADMIN_LEGACY
>          select VFIO_PCI_CORE
>          help
>            This provides support for exposing VIRTIO NET VF devices which support

Applied to vfio next branch for v6.8.  Thanks!

Alex

