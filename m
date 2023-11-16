Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC130F88
	for <virtualization@lists.linux.dev>; Thu, 16 Nov 2023 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doYrnXJs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700173609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8WbDjbsJAViEtzpdu0gpHjopViguXknXd0a5LRav6Rg=;
	b=doYrnXJssqbNtzQng3npvUvqM00km4Zvb43ZNe7XH4tP6HFedvgOoe8WkWdU9tv//liYv+
	3IpFFBeWXk6+cl6k5QG4KCzYgAMz8R24lqHkCJx3nQmZJCeI8VgbCQ1oPA1FcB70FgQL1j
	p5rsuzb0OcuVLhMIg8GWFiF8st8mJY0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-9VPOTKhLN3KihuzcAiujCA-1; Thu, 16 Nov 2023 17:26:47 -0500
X-MC-Unique: 9VPOTKhLN3KihuzcAiujCA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32fa25668acso703755f8f.1
        for <virtualization@lists.linux.dev>; Thu, 16 Nov 2023 14:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700173606; x=1700778406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WbDjbsJAViEtzpdu0gpHjopViguXknXd0a5LRav6Rg=;
        b=FIgXnYkDoxfihFtJ+0mKpyBS/662Mu3o/v9DlGo2RmuYsiOZjJ2CvlFcxTCori7ayK
         wwB09vzgpThnrCNldNh7ULZNzqBImHI65aVJ1b7uNJPKCeoyRNzy4O+nqflwymZVxpL3
         XzVo54wDprq86TShZNSOjnhV2a0Mya/SuV8P8x4W//WA4SydDf9rkdiwb1s1keYsTyPP
         06GxbTEd6IBzE633mASJVbTlSAgO71IW26T9QpeqnYOnVE1xlBubBYCDPVZ42KpGhXdr
         GLohygkH8reXnxMjy26XUJYsyIXH8kdLxcQkDmBMJhJLUTEWRhkhcsubfs8bOhD5UkO/
         R8VQ==
X-Gm-Message-State: AOJu0Yx58DzvrEV+rKF21FHUH6scLejxK1VlyelmKplF52I1NjgyeFGi
	oRn9S1i1WzgzJZkO6qVaBZ56ENCrwqHvfZUGNNpQZTX/jQxFa2tkR+2druNCUhx0wiCADUE7xOT
	JZgx602sipZV5cnRk/f1KdjHfcV0kzv9V+PY=
X-Received: by 2002:a05:6000:1541:b0:32f:7bb6:9695 with SMTP id 1-20020a056000154100b0032f7bb69695mr16218540wry.44.1700173606111;
        Thu, 16 Nov 2023 14:26:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiBu3ri5t/Dwj5Bs0QAq+RqVRBJLFuPR0Pj59OSodujceUq5Vh0d8dsTukm0J4AGxscW8WjQ==
X-Received: by 2002:a05:6000:1541:b0:32f:7bb6:9695 with SMTP id 1-20020a056000154100b0032f7bb69695mr16218528wry.44.1700173605769;
        Thu, 16 Nov 2023 14:26:45 -0800 (PST)
Received: from redhat.com ([2.52.147.183])
        by smtp.gmail.com with ESMTPSA id r7-20020a056000014700b0032fab28e9c9sm487814wrx.73.2023.11.16.14.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 14:26:45 -0800 (PST)
Date: Thu, 16 Nov 2023 17:26:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: elena.reshetova@intel.com, virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux.dev
Subject: Re: Using packed virtqueues in Confidential VMs
Message-ID: <20231116172507-mutt-send-email-mst@kernel.org>
References: <20231116200245.GA336841@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231116200245.GA336841@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2023 at 03:02:45PM -0500, Stefan Hajnoczi wrote:
> Hi Elena,
> You raised concerns about using packed virtqueues with untrusted devices at
> Linux Plumbers Conference. I reviewed the specification and did not find
> fundamental issues that would preclude the use of packed virtqueues in
> untrusted devices. Do you have more information about issues with packed
> virtqueues?
> 
> I also reviewed Linux's virtio_ring.c to look for implementation issues. One
> thing I noticed was that detach_buf_packed -> vring_unmap_desc_packed trusts
> the fields of indirect descriptors that have been mapped to the device:
> 
>   flags = le16_to_cpu(desc->flags);
> 
>   dma_unmap_page(vring_dma_dev(vq),
>                  le64_to_cpu(desc->addr),
>                  le32_to_cpu(desc->len),
>                  (flags & VRING_DESC_F_WRITE) ?
>                  DMA_FROM_DEVICE : DMA_TO_DEVICE);
> 
> This could be problematic if the device is able to modify indirect descriptors.
> However, the indirect descriptor table is mapped with DMA_TO_DEVICE:
> 
>   addr = vring_map_single(vq, desc,
>                           total_sg * sizeof(struct vring_packed_desc),
>                           DMA_TO_DEVICE);
> 
> There is no problem when there is an enforcing IOMMU that maps the page with
> read-only permissions but that's not always the case. Software devices (QEMU,
> vhost kernel, or vhost-user) usually have full access to guest RAM.

Not with encrypted memory.

> They can
> cause dma_unmap_page() to be invoked with arguments of their choice (except for
> the first argument) by modifying indirect descriptors.

> I am not sure if this poses a danger since software devices already have access
> to guest RAM, but I think this code is risky. It would be safer for the driver
> to stash away the arguments needed for dma_unmap_page() in memory that is not
> mapped to the device.
> 
> Other than that, I didn't find any issues with the packed virtqueue
> implementation.
> 
> Stefan


