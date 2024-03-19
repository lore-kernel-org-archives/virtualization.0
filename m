Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7C51036
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710831676; cv=none; b=d8WZJGs0q5zttZsroPbQpsu1N7z87zcLhNpYBrThN95dMaDcHYZlaUNOcj5jJ2K7cI5Suu94fSeapJyMyzQngHYoxHd/YWwJE92rsP/HCY1BUI7t58QtHf7PkckXAC24FQraZlMbF5fWBwXKD5K6Aq7pK2QAPhYWFDFXTDymw9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710831676; c=relaxed/simple;
	bh=+0yGzgO/uZDZuFmdyu9d+sc45NfVqM4uTrSkkmcuopU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jhHnJZoBzTKOvIquKDbH5FuewQw6BhQzTTJ3qCE6FRcVKHWo4Dl7BUWiJkrxSqLL6hx72XfvA21PK+Tb6TwNJTX8bV2XIJUFGdkUuYvA7gB4l3VsdylmvIk4pWp0Xfww15DBi5HNbRsMGuw36FMYDww4QVuhpTHHkzekJee7qMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4xEZ8BT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4xEZ8BT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710831673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=foUSQQGmYmOu8nLXi1AjlC9r9SGWzmdXWf6sigKcUWw=;
	b=Q4xEZ8BTHebHEGjxuRaiHmRJJxWg2reDz/IlKm6iQpudYXM3jPLl0RNa3tjA05gabcheEM
	9LBEiSQzLtHv/DU3+aUpo9WxHgxX1yuu2Pvi8AUrUvBnwxUyxkiFbJX9I3v++eTxRzCxtV
	xO5Wut4p/VNDdiKQCakq9A/wSo5sqSQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-QhStdB0VOVeD5PcgdfPZCA-1; Tue, 19 Mar 2024 03:01:11 -0400
X-MC-Unique: QhStdB0VOVeD5PcgdfPZCA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33eca6f6e4bso2730976f8f.0
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 00:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710831670; x=1711436470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foUSQQGmYmOu8nLXi1AjlC9r9SGWzmdXWf6sigKcUWw=;
        b=sQPkXh98iA2dc35Etc9fxP//rHooZQsJBseNBikJMhr9R9mLNc2QHJkT5JNwmro3ZD
         YBwIvyqgBcd5gjVTh00RlL9NpaORzmJBafRM8RFBuK5+ChbreOwEujXRVUuFLhPvG5VI
         BZRxjLvSI/sWAPKJIT7sUTWV8JdxczafUt4Yum+CYvU/ObbyFYwCX9ELv7s6amsMsNTP
         iBz80mQwV/IWVXXsBWEjR7b70+Ox93cmRULBIiCjSA+kGIUZLLOjFgIbEZyLiJj6XzKL
         1XE5rxPcYN2IQ2jT6QZpyLVdvxp6v4K1CIAnAeMRcPq7/YscmjNvCZXssqpBa2M4qF71
         p7BA==
X-Gm-Message-State: AOJu0YxwtAdx9ghcnI/eUlqP7k29S3SiVm9bAdInu5iE8vXtJhGnhxTA
	7nEtBIysEmw6QyIlR1u+ZH3T4b41wA4bVtA+O6QB644Js3ChtrAvoRdcx7YFMoiacWkuGLi+WAE
	Du6s06fjFoKbZZbRuXXWeDijZs08pY/LQYE3GOgdrCMU2+Zg7I7iuhhBpuNfFjhga
X-Received: by 2002:a05:600c:4f0e:b0:413:ef8e:4cc with SMTP id l14-20020a05600c4f0e00b00413ef8e04ccmr1095500wmq.40.1710831669523;
        Tue, 19 Mar 2024 00:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzg6YzD09DcsuSp1mTE4kCrxMGUWI9Lm91o60NEdPSVsYEnPJ0jVjqFhsmb8yxRUdsUTgvyQ==
X-Received: by 2002:a05:600c:4f0e:b0:413:ef8e:4cc with SMTP id l14-20020a05600c4f0e00b00413ef8e04ccmr1095470wmq.40.1710831668946;
        Tue, 19 Mar 2024 00:01:08 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id fk10-20020a05600c0cca00b0041463334822sm1536373wmb.26.2024.03.19.00.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:01:08 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:01:02 -0400
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
	Jason Wang <jasowang@redhat.com>, linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH vhost v3 0/4] refactor the params of find_vqs()
Message-ID: <20240319025933-mutt-send-email-mst@kernel.org>
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 12, 2024 at 10:10:09AM +0800, Xuan Zhuo wrote:
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


As this came in after merge window was open I'm deferring this
to the next merge window.

Jason, can you pls try to complete the review meanwhile?

> 
> Xuan Zhuo (4):
>   virtio: find_vqs: pass struct instead of multi parameters
>   virtio: vring_create_virtqueue: pass struct instead of multi
>     parameters
>   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
>   virtio_ring: simplify the parameters of the funcs related to
>     vring_create/new_virtqueue()
> 
>  arch/um/drivers/virtio_uml.c             |  31 ++--
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  24 ++--
>  drivers/remoteproc/remoteproc_virtio.c   |  31 ++--
>  drivers/s390/virtio/virtio_ccw.c         |  33 ++---
>  drivers/virtio/virtio_mmio.c             |  30 ++--
>  drivers/virtio/virtio_pci_common.c       |  60 ++++----
>  drivers/virtio/virtio_pci_common.h       |   9 +-
>  drivers/virtio/virtio_pci_legacy.c       |  16 ++-
>  drivers/virtio/virtio_pci_modern.c       |  38 +++--
>  drivers/virtio/virtio_ring.c             | 173 ++++++++---------------
>  drivers/virtio/virtio_vdpa.c             |  45 +++---
>  include/linux/virtio_config.h            |  85 ++++++++---
>  include/linux/virtio_ring.h              |  93 +++++++-----
>  tools/virtio/virtio_test.c               |   4 +-
>  tools/virtio/vringh_test.c               |  28 ++--
>  15 files changed, 363 insertions(+), 337 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f

