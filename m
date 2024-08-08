Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA81487C8
	for <virtualization@lists.linux.dev>; Thu,  8 Aug 2024 12:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119045; cv=none; b=I2qiNEdvudURftsOzve6M6ZB9G63GXYZ5Iwg92Vlb7gxqPhI7/f9jUqJhmavJ0nQTBMTF7CuWTn88eROuPxxNEro6eyGDD7FI11DJA3xbD5ZM2VZc7aXd6oC542RBxgiKMJRT53gXRjcV8hlAO8j0NcOdYukF3L2n32yBIM7QAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119045; c=relaxed/simple;
	bh=9bc7aDzprpbcgS4WFLHvkOB53uMBGrapeaVhrEf3Z7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QqLQlZdH2Njv9b6jGpx0qyIjlvjaZTqtCsp/ypUb/9Qt0nLWAyAtQs1a9wwJ3NAdlv6Bl2tD+0MWt7IYTIKcrwfuU3qgSBd+gOeIgx0PkqNGxUKyyLWmSGKH522lGUEB8EeaI97FLDLX/3hFTchY5PnGEnrZuM8SsmUu+CtIsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJQRtkOv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJQRtkOv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723119042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1M/Bbzbm2m4qddYa34fpB/kjEFz/ogrNcSTJJcSrSIw=;
	b=NJQRtkOvv8YTh+u2lGROIUG0L3Jk+mUYquMtTzB+uxYDs0WvwzwbgB9DSXxN86B4Ncbuk+
	IPDaMO3VowmONKFVVTSD1zEFX/Oiib7TYdbDa7NI9qVxZ0mp6rQlG0F7COkTvJ5pB9u25j
	arMTCW+lyV+Xy5AzirVBB9HFeLEc8SY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-8WQgg5C0MlucB8FT-i8Xcw-1; Thu, 08 Aug 2024 08:10:40 -0400
X-MC-Unique: 8WQgg5C0MlucB8FT-i8Xcw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5baf6eb9f5bso675940a12.0
        for <virtualization@lists.linux.dev>; Thu, 08 Aug 2024 05:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119039; x=1723723839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1M/Bbzbm2m4qddYa34fpB/kjEFz/ogrNcSTJJcSrSIw=;
        b=sb5nbMFoYegJUE4VklxILaHMN4D5T7SIDRsfMlZmR3Sv2CEGu2wHxU5ic4ES2COFTy
         HT+NakUGklSZdJyKP7rPtG53cX4G/2XQncs65obsyzEuibTfKyZEC0dnMMyjCvrTMox1
         iut1JSXn4NJxTc5aHVZVWCeSWD03sg56+1A0OnxnIXQqFkg5+cYDhSxkdh8PMSmBZn5/
         bFxBQ/abahU0SkLsm00Ol2vxsaggmKW5BS6q3LS3XJqOcIbL5zEEI0bSnkjNJm5O1VNB
         k6ge8BvVDWF6tdHK3HXmhWfqtC/fgJ/g/ULr5M+UJlD9MYDABhuML3rn2kgyOU5jjt2Y
         dlfg==
X-Forwarded-Encrypted: i=1; AJvYcCUqrMFlH+TepKs8PrPb6KhviLo+9UtX78nfCAEfh2AiUPrtkO7N3+zmwUjgKTuqYshgbL6VB+LsIGZv4h4u2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKXEhfA2n2F0QGLBaMTF/czADlJXeccxZUBkSSREpY6UE9K8ah
	3j3f+jZGASjXJOQVRSk57pXUNtXRa0XhUNUKzEYOZkaYFaDfKaMSTvZMn5ZjAUHy6x3JG/tD65X
	OXr2UO5C7MutyCEjQDOQl0z3wmS5leIKkcereVq3CzLyTCkudVDlyBs6qyNShVEl3
X-Received: by 2002:a05:6402:2803:b0:5a1:24fc:9a47 with SMTP id 4fb4d7f45d1cf-5bbb23decc5mr1357328a12.27.1723119039465;
        Thu, 08 Aug 2024 05:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLx/yjqoXNv7pgu3Db5bjZDcuVQRkJcyOheFnVizNfuaxPT8z3LRIP3msZG+5UgTn6kRv+YQ==
X-Received: by 2002:a05:6402:2803:b0:5a1:24fc:9a47 with SMTP id 4fb4d7f45d1cf-5bbb23decc5mr1357292a12.27.1723119038645;
        Thu, 08 Aug 2024 05:10:38 -0700 (PDT)
Received: from redhat.com ([2.55.14.119])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf841asm564212a12.5.2024.08.08.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:10:37 -0700 (PDT)
Date: Thu, 8 Aug 2024 08:10:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Hongyu Ning <hongyu.ning@linux.intel.com>
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Message-ID: <20240808075701-mutt-send-email-mst@kernel.org>
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 08, 2024 at 10:51:41AM +0300, Kirill A. Shutemov wrote:
> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
> accesses during the hang.
> 
> 	Invalid read at addr 0x102877002, size 2, region '(null)', reason: rejected
> 	Invalid write at addr 0x102877A44, size 2, region '(null)', reason: rejected
> 	...
> 
> It was traced down to virtio-console. Kexec works fine if virtio-console
> is not in use.

virtio is not doing a lot of 16 bit reads.
Are these the reads:

                virtio_cread(vdev, struct virtio_console_config, cols, &cols);
                virtio_cread(vdev, struct virtio_console_config, rows, &rows);

?

write is a bit puzzling too. This one?

bool vp_notify(struct virtqueue *vq)
{       
        /* we write the queue's selector into the notification register to
         * signal the other end */
        iowrite16(vq->index, (void __iomem *)vq->priv);
        return true;
}
        
> 
> Looks like virtio-console continues to write to the MMIO even after
> underlying virtio-pci device is removed.

You mention both MMIO and pci, I am confused.
Removed by what? In what sense?




> 
> The problem can be mitigated by removing all virtio devices on virtio
> bus shutdown.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>

A bit worried about doing so much activity on shutdown,
and for all devices, too. I'd like to understand what
is going on a bit better - could be a symptom of
a bigger problem (e.g. missing handling for suprise
removal?).




> ---
>  drivers/virtio/virtio.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a9b93e99c23a..6c2f908eb22c 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>  	of_node_put(dev->dev.of_node);
>  }
>  
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +	struct virtio_device *dev = dev_to_virtio(_d);
> +	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> +
> +	if (drv && drv->remove)
> +		drv->remove(dev);
> +}
> +
>  static const struct bus_type virtio_bus = {
>  	.name  = "virtio",
>  	.match = virtio_dev_match,
> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
>  	.uevent = virtio_uevent,
>  	.probe = virtio_dev_probe,
>  	.remove = virtio_dev_remove,
> +	.shutdown = virtio_dev_shutdown,
>  };
>  
>  int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
> -- 
> 2.43.0

