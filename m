Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0503191D4
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114441; cv=none; b=uMsyFjQOudGypXJ/oKwzoTWg5zxG4I1Pn5q1elulKzomkvBgETnKGz/fUy+W1MIVWZYDa5jRbzxjZuQvWRaAlUevXW6AKS3e+H4SbShdoDWnUYVKeLnszPapY2EFsPAE6MwjMkmpIOQq8+9e4DrLXhH0ZOA6F7TYLLYerZXMd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114441; c=relaxed/simple;
	bh=HhpAzoexONqBRfMann0YeEk4K22xyRssx8IfzbrtrLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m7KsVF1EBqu+XwcCYJgjLI6tgEfKvCcIUQf1GgMa6hrc4JrKiY0sWm/je+OD0am4H/WoLR3VxuDHBBobzRktbzxwDXilUY/+BG4u+s+xlwRI6Q1k8eHCv+R8GEOeqW6CViqSx0+bFckP3wuApC2OYUKuD6SjsjkB691OL+sUTtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Owy4Mp9o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Owy4Mp9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770114438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kA8qyidkR7INyra5mnWciv78DJNfJc/S9cwmeexYPIA=;
	b=Owy4Mp9oJyVhpsPblHGGTpvy37WhN3Ir7CqH2heM8fHc40va8KM8ABTLInPWYk+G/YWyXf
	X+nBsgteEnDIHFZDeYs0a7bvhNNjbshwjBeI4vkdpWm7mGZKlce58O9SPx/NQbmrIkd9nW
	z5HPpZSfgpBNvXwxky9zp5WLYrdilxI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-P2buDL-yNQmrs186B1yv8A-1; Tue, 03 Feb 2026 05:27:17 -0500
X-MC-Unique: P2buDL-yNQmrs186B1yv8A-1
X-Mimecast-MFC-AGG-ID: P2buDL-yNQmrs186B1yv8A_1770114436
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-430fcf10287so5024478f8f.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 02:27:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114436; x=1770719236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA8qyidkR7INyra5mnWciv78DJNfJc/S9cwmeexYPIA=;
        b=SC/KUjleqnSYxDJjB4Z1QUVGCY3gURuR4GblPswmSZAyhq2b1/wZLKMqG6aKgaeLNn
         i7UUNl0Pj1tIA9Fp1FZZdMlqnTPUC1r45on0hLbWoKjR4UxBEWMozRu/Wk0WxYtP8yyz
         W9puAg3dAQd9jq/aB19EyNzqGnW9Dp41nouCzKJyU6EtZIvn010Nyv92unvXaKI1Pnmq
         JPDi1AfHR4XoeZiLftxzXaziI+huONS+aE7+I28rLR1c8gfEawBZRr0oExx5jLMlGU0J
         YU1zBJseFX4Ych8D2PIW0D3hPjLF1/Zp2W37FGMKkciUdvsf9FMh/xdzOsL8a1bR4hOL
         pliQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuW7bj4j2i0sDe06uNMI7nbrrZ0rH13Nx5LCOKjSUQlCdAw61+UVsdx2cSEES5zIX5zp/cHc/E7XJOJAMR6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNRcTjZCm9L4cY1aWLoN1gwqET3HJ8fPunKEqlTfst2JASFbTx
	FnFXUuda9s+Mngtbsc088k+Nzkguc8v3R6a2gomfqHyfG7iB6tFYnfGD+nf25F7NFYzQswWwwRd
	hDeU8pCvwnEg8bUvVlu6cccarKm90MjTLuJ4L7GvU2hXavSEECL9pFhlQvAxnjmgfcf8R
X-Gm-Gg: AZuq6aK2NIe552SCmS10mXgVgFunHWUHyi24hn6THKmWW1vTrrcZKJC7WgZ45popj/i
	fAnyyaMCn+udj4x4AexBGFL/o7hyaGl6Ho6EI4yn3DibJNV9ABh2vgJ2IWgnOEvTwqrhAdg/rvL
	Bmi2KtW6VqvcDwfJuxX099PUCVBr9Rfmo9KjqMMSbUPACxQ7XLdatIhYnt+rKx/mITa1oyRy9dJ
	POgbtzxcj7MsEJUxgbmqEpFu2LRvhT57A8dWpB/GhmgLpOY87god9xjAKK2MJ/d+tVA7ob0offp
	X0qEZfq1P/GNi554CoZXywkXOuJfRsBUWrPzAMCDAhIGMhaJ6dYDrf3rmngyCJtyQ9beU4c2KKs
	xnjLlruPhpiOw4wWgsKNTSeKvkk75KvzbwA==
X-Received: by 2002:a5d:4851:0:b0:436:1e6:e1e3 with SMTP id ffacd0b85a97d-43601e6e2damr9992060f8f.46.1770114436119;
        Tue, 03 Feb 2026 02:27:16 -0800 (PST)
X-Received: by 2002:a5d:4851:0:b0:436:1e6:e1e3 with SMTP id ffacd0b85a97d-43601e6e2damr9992025f8f.46.1770114435579;
        Tue, 03 Feb 2026 02:27:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131ce64sm53894663f8f.26.2026.02.03.02.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:27:15 -0800 (PST)
Date: Tue, 3 Feb 2026 05:27:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Chen <me@linux.beauty>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvdimm: virtio_pmem: serialize flush requests
Message-ID: <20260203052616-mutt-send-email-mst@kernel.org>
References: <20260203021353.121091-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260203021353.121091-1-me@linux.beauty>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YAweAe8DHBDa4ZtibRa2f3QSK5GpPEQlkr-DIFO4gqg_1770114436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2026 at 10:13:51AM +0800, Li Chen wrote:
> Under heavy concurrent flush traffic, virtio-pmem can overflow its request
> virtqueue (req_vq): virtqueue_add_sgs() starts returning -ENOSPC and the
> driver logs "no free slots in the virtqueue". Shortly after that the
> device enters VIRTIO_CONFIG_S_NEEDS_RESET and flush requests fail with
> "virtio pmem device needs a reset".
> 
> Serialize virtio_pmem_flush() with a per-device mutex so only one flush
> request is in-flight at a time. This prevents req_vq descriptor overflow
> under high concurrency.
> 
> Reproducer (guest with virtio-pmem):
>   - mkfs.ext4 -F /dev/pmem0
>   - mount -t ext4 -o dax,noatime /dev/pmem0 /mnt/bench
>   - fio: ioengine=io_uring rw=randwrite bs=4k iodepth=64 numjobs=64
>         direct=1 fsync=1 runtime=30s time_based=1
>   - dmesg: "no free slots in the virtqueue"
>            "virtio pmem device needs a reset"
> 
> Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> Signed-off-by: Li Chen <me@linux.beauty>


Thanks!
And the commit message looks good now and includes the
reproducer.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Ira are you picking this up?


> ---
> v2:
> - Use guard(mutex)() for flush_lock (as suggested by Ira Weiny).
> - Drop redundant might_sleep() next to guard(mutex)() (as suggested by Michael S. Tsirkin).
> 
>  drivers/nvdimm/nd_virtio.c   | 3 ++-
>  drivers/nvdimm/virtio_pmem.c | 1 +
>  drivers/nvdimm/virtio_pmem.h | 4 ++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index c3f07be4aa22..af82385be7c6 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -44,6 +44,8 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>  	unsigned long flags;
>  	int err, err1;
>  
> +	guard(mutex)(&vpmem->flush_lock);
> +
>  	/*
>  	 * Don't bother to submit the request to the device if the device is
>  	 * not activated.
> @@ -53,7 +55,6 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>  		return -EIO;
>  	}
>  
> -	might_sleep();
>  	req_data = kmalloc(sizeof(*req_data), GFP_KERNEL);
>  	if (!req_data)
>  		return -ENOMEM;
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 2396d19ce549..77b196661905 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -64,6 +64,7 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>  		goto out_err;
>  	}
>  
> +	mutex_init(&vpmem->flush_lock);
>  	vpmem->vdev = vdev;
>  	vdev->priv = vpmem;
>  	err = init_vq(vpmem);
> diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> index 0dddefe594c4..f72cf17f9518 100644
> --- a/drivers/nvdimm/virtio_pmem.h
> +++ b/drivers/nvdimm/virtio_pmem.h
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <uapi/linux/virtio_pmem.h>
>  #include <linux/libnvdimm.h>
> +#include <linux/mutex.h>
>  #include <linux/spinlock.h>
>  
>  struct virtio_pmem_request {
> @@ -35,6 +36,9 @@ struct virtio_pmem {
>  	/* Virtio pmem request queue */
>  	struct virtqueue *req_vq;
>  
> +	/* Serialize flush requests to the device. */
> +	struct mutex flush_lock;
> +
>  	/* nvdimm bus registers virtio pmem device */
>  	struct nvdimm_bus *nvdimm_bus;
>  	struct nvdimm_bus_descriptor nd_desc;
> -- 
> 2.52.0

