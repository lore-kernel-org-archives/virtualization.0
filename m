Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738113D623
	for <virtualization@lists.linux.dev>; Wed, 22 May 2024 12:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716380937; cv=none; b=iybkR8WXcY83S3/Ww99897efYGwEfrr/Ln/jHYg7zAf2+nq9qGeDq6uUEZW4m36yfl3VXQD6q6nhXZMdAocsutWv8BsVA1RI4WQD8o0aZlVF+PMyQxKJAQeKrXWbHkchzLTxQm9C183MN2YEUdx93S4sU0ihD4MvEdyI7ypg0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716380937; c=relaxed/simple;
	bh=IjhE+2UdQAnuXtlylaE+JoyaTsfKnza85kdSkCPXqCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uBU8LsX4TjllSHcAEb/Qj5A/FxXAKBcvMlV0LiqAdxUl06tPcNPrLBBkTwu1rAkFWe8kcs3PYYobkpMuQdbdEOORDlyu+04Ur81WjT2X8EgV/MAPr5oaJnqPT/J8AjYnvMdxtBv/JZzWJxxWReuhkfZfEkMZJIH+9b5ssnijj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qds0YO0+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qds0YO0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716380935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a+cu2mi6DrTCATyynjShlX3nyC2W5Pcy/CJyML1HBmE=;
	b=Qds0YO0+JqDsQm2ufPGkIWdTqt2K5G4Lz39qw6me2gHUrprn5tECSLMLJoLccAwJR/6RM3
	8zd6MLL/HMdoCrIov/JzKejUfYOa8VlbcGYuL63RtQXfsJcnUgb7SbMIRhp3vvCJ2qwUYT
	n46ZLWWZ28C/vaBZjW5VpEQl44U3Aw4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-1GcixycKMA2F84R3L4fNIQ-1; Wed, 22 May 2024 08:28:53 -0400
X-MC-Unique: 1GcixycKMA2F84R3L4fNIQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-354df3e1b0fso281007f8f.1
        for <virtualization@lists.linux.dev>; Wed, 22 May 2024 05:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716380932; x=1716985732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+cu2mi6DrTCATyynjShlX3nyC2W5Pcy/CJyML1HBmE=;
        b=LI0DrES/VKhVwA6Jc8pjQrwjSfG1WTsJ9vhy1E9EumBd5PwH4pdbtZyJyF6JXLzwvh
         lgTDtBDJiwu+scPsLbVmbeX+tT/BZbKremFvwVXBYiYaGfR7j5ZOscz/4zeEuuWyEfQE
         ncnOsnHGek4QgcKJjHsUG4TFVVy8LaSdWKIkmG8TsTYG61pNAIdJ7EIEFgpJTi0Jlu4j
         u16965z8aSkMfMFD7GT/M8o+0GkMBRhG3f+AVjXAODV3ftbjPB+ROOxXIWaik4mjcxyT
         PkKi+x/lfT8pp7DaA+VNx1p6+qHtQvn/CwVH7ro0Mhtf/iS2ceSocLPE/082axASUdhY
         0Swg==
X-Gm-Message-State: AOJu0YyGJkRoFZZPO4wHd4KvwdeV8O8sDa0z16D/1mhHSniiGIcBaXWb
	Jzn+xOHxhDE9lT6sy6u7aMLSWI2Ei9uTeiJoy5XQlwkQvH/z+W0zWM6fN/ChpYBjtGR2945NyYK
	C0G2E3ZvU+WzMQk/zAItlRwJQkRcmIwhmTqity8JJTOIouqC1arWoN4XA5AJAe3uN
X-Received: by 2002:adf:e60a:0:b0:354:e22c:ea86 with SMTP id ffacd0b85a97d-354e22cebaemr1323585f8f.9.1716380932415;
        Wed, 22 May 2024 05:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzJHem68umXpabzX/QCksQommVuGzFjAE3Wqkqn0Byb8srELzLVtz9M/YE9lepG/jLnJp0Rg==
X-Received: by 2002:adf:e60a:0:b0:354:e22c:ea86 with SMTP id ffacd0b85a97d-354e22cebaemr1323532f8f.9.1716380931656;
        Wed, 22 May 2024 05:28:51 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55d:e862:558a:a573:a176:1825])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bdc7sm34184149f8f.22.2024.05.22.05.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 05:28:50 -0700 (PDT)
Date: Wed, 22 May 2024 08:28:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v9 0/6] refactor the params of find_vqs()
Message-ID: <20240522082732-mutt-send-email-mst@kernel.org>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 24, 2024 at 05:15:27PM +0800, Xuan Zhuo wrote:
> This pathset is splited from the
> 
>      http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com
> 
> That may needs some cycles to discuss. But that notifies too many people.
> 
> But just the four commits need to notify so many people.
> And four commits are independent. So I split that patch set,
> let us review these first.
> 
> The patch set try to  refactor the params of find_vqs().
> Then we can just change the structure, when introducing new
> features.
> 
> Thanks.

It's nice but I'd like to see something that uses this before I bother
merging. IIUC premapped is dropped - are we going to use this in practice?

> v8:
>   1. rebase the vhost branch
> 
> v7:
>   1. fix two bugs. @Jason
> 
> v6:
>   1. virtio_balloon: a single variable for both purposes.
>   2. if names[i] is null, return error
> 
> v5:
>   1. virtio_balloon: follow David Hildenbrand's suggest
>     http://lore.kernel.org/all/3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com
>   2. fix bug of the reference of "cfg_idx"
>     http://lore.kernel.org/all/202403222227.Sdp23Lcb-lkp@intel.com
> 
> v4:
>   1. remove support for names array entries being null
>   2. remove cfg_idx from virtio_vq_config
> 
> v3:
>   1. fix the bug: "assignment of read-only location '*cfg.names'"
> 
> v2:
>   1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen
> 
> v1:
>   1. fix some comments from ilpo.jarvinen@linux.intel.com
> 
> 
> 
> 
> 
> 
> 
> 
> 
> Xuan Zhuo (6):
>   virtio_balloon: remove the dependence where names[] is null
>   virtio: remove support for names array entries being null.
>   virtio: find_vqs: pass struct instead of multi parameters
>   virtio: vring_create_virtqueue: pass struct instead of multi
>     parameters
>   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
>   virtio_ring: simplify the parameters of the funcs related to
>     vring_create/new_virtqueue()
> 
>  arch/um/drivers/virtio_uml.c             |  36 +++--
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  23 +--
>  drivers/remoteproc/remoteproc_virtio.c   |  37 +++--
>  drivers/s390/virtio/virtio_ccw.c         |  38 ++---
>  drivers/virtio/virtio_balloon.c          |  48 +++---
>  drivers/virtio/virtio_mmio.c             |  36 +++--
>  drivers/virtio/virtio_pci_common.c       |  69 ++++-----
>  drivers/virtio/virtio_pci_common.h       |   9 +-
>  drivers/virtio/virtio_pci_legacy.c       |  16 +-
>  drivers/virtio/virtio_pci_modern.c       |  37 +++--
>  drivers/virtio/virtio_ring.c             | 177 ++++++++---------------
>  drivers/virtio/virtio_vdpa.c             |  51 +++----
>  include/linux/virtio_config.h            |  76 +++++++---
>  include/linux/virtio_ring.h              |  93 +++++++-----
>  tools/virtio/virtio_test.c               |   4 +-
>  tools/virtio/vringh_test.c               |  28 ++--
>  16 files changed, 384 insertions(+), 394 deletions(-)
> 
> -- 
> 2.32.0.3.g01195cf9f

