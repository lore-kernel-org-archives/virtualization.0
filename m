Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2641835EDCB
	for <virtualization@lists.linux.dev>; Sat, 31 Jan 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769881589; cv=none; b=FKA2hY26CONmH0pZFbAAIEDDIzufCWdum0LKVIL/WNXiua9cp5JQoMkSbiI3TanKKr0ouHxAEStzs030Z1D3kWEmwEiGS0TT4oRU4a3slznRiUD1LJskkmo5x2wha7eb5ewi7GKzXvZdG1NLn68nY2629+bzwmUtdNDN3hM0RU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769881589; c=relaxed/simple;
	bh=FO0XxGiW7YqfVtzLltyctsCxTlWqT0+V7VxlKQHFZjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GFvysBrQGQtiFd+FIoOzYAOYvyFxKBZ7NwaNLFs4cypjTWJNe2r8xTuUdqBpUr+l+Otta3AzhVnG4d27o9tI45X7x83MNsQwsaFAFk6yjiCViqgr8XO+j/HT/yu4jnBju0a0rwvy+gSUq9sBZgTzkkV7z9xY2Y/EYT0rVfIncKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXzVlO8v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXzVlO8v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769881586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5XwIcJJrN88f5EmnbhwkMpwuoOxnaOad2/ndcUFOcSM=;
	b=LXzVlO8vs4axWQd715chtDsx9UvKnJxT9ejNqnRJLzH+1wlomTjR9l4v/DwGcWR2syUTUZ
	7SoI7z2mQakNK1L4juxewjagoUFVB3PTQKzGEuxCZInxhxIOa6GUToHA2E2TMby1WtC/37
	pp2TsIxAyT+jkZs3LfxI3TNjjFUnt0Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-gepnafg5OmyfHoJayBu2iA-1; Sat, 31 Jan 2026 12:46:24 -0500
X-MC-Unique: gepnafg5OmyfHoJayBu2iA-1
X-Mimecast-MFC-AGG-ID: gepnafg5OmyfHoJayBu2iA_1769881583
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fcb6b2ebso2453504f8f.2
        for <virtualization@lists.linux.dev>; Sat, 31 Jan 2026 09:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769881583; x=1770486383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XwIcJJrN88f5EmnbhwkMpwuoOxnaOad2/ndcUFOcSM=;
        b=kP7Qwq6FwIOq4N6x7bpcvIxtb8y0eR69wQkif65Up5Dnx3yywFCGPQKLuVIr0jkM2q
         TzgudraiC8EN7U/X6rGRJIRAZa5jQe6qsWDfxHicgU8/Wwbln3MKhAWo5r5GplDieTKR
         1sb9jcR6b6i+6KH+2aba7tZ5SdBjCyuw9FQpDUVhzdoCkqdjPopDh2mWEodr1WtgPc0O
         lzJ8j10/wJghCkJzn4S1kEliVQu2IIjCEJmMPOoqvd6mNDKhfGN4wftId5TXgSE6aflB
         VIm9KmM2fmaBelxAEm55VmQ0KZHQP7QunW01m/VvADRHzKJfusECFU7BDnnFFRxV+G8I
         M/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXskeFzS7yC5zLqlJlFvdRfVAt0EW4EErCSX3YpyvvvjeHRNvhCMdzfSCdX3hHKmVIp9DhwKRdeBVX+UHApxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YybrwOKYsAAIPfepfCawr/SyxeT2JjTheqmOzpA8aZQBPXCe9CF
	NO/nSz8vB35wF4mQkXxvFZoR9flQi5q0AcY9WXwX3TgjVWLqyUMkf3obvFRaeesbbYJXcYUey3O
	hjZB0CgA1Syb53gSVP2R9MAGHc66i3YVpPummhlwfsPa5jHGH3bCRkXo6F7JKZJezrCNZ
X-Gm-Gg: AZuq6aL8kH88LpZsdQPgxVAASBrQPQmYkJh/j8L1txegWvWmL1EyL8F5VXF7asBKCBc
	eYZzdggemTlMsyO+Yin4pA8KgbBE5BlIwj2YJP5ma/uxBMi1Mv9hzJqKoG5mMEf0jzErYOgBWrV
	Kch3/81Z6NPQKh2U7fMTpGYFuk5+X220JDheRaW71mQs3iV7GUFYpBdQ8ZqvUwIbKmX4eGwMXT2
	USVBxwFLOpMbBDK26YCfh1YKAiF6bDgP+qnaZxGXDQO+mabjyTgbYIjd7RiFGBRHGX9R9v/Pyl3
	Hv7soilsRpXwgbOcj95Xe5RB6lC4Sugi5vYMAK33J/10bX+6VjOEYsxwXn+CZMZpf9o8Xn59nAa
	osCi3Fw==
X-Received: by 2002:a05:600c:34c4:b0:480:52fd:d2e4 with SMTP id 5b1f17b1804b1-482db012dd7mr87513055e9.0.1769881583158;
        Sat, 31 Jan 2026 09:46:23 -0800 (PST)
X-Received: by 2002:a05:600c:34c4:b0:480:52fd:d2e4 with SMTP id 5b1f17b1804b1-482db012dd7mr87512805e9.0.1769881582675;
        Sat, 31 Jan 2026 09:46:22 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e3:8f00:866c:5eeb:fc46:7674])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c3d1sm289628525e9.9.2026.01.31.09.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 09:46:21 -0800 (PST)
Date: Sat, 31 Jan 2026 12:46:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Li Chen <me@linux.beauty>, Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Jakub Staron <jstaron@google.com>, nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvdimm: virtio_pmem: serialize flush requests
Message-ID: <20260131124554-mutt-send-email-mst@kernel.org>
References: <20260113034552.62805-1-me@linux.beauty>
 <697d19fc772ad_f6311008@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <697d19fc772ad_f6311008@iweiny-mobl.notmuch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: I0GewIEm5LIekaPjjFszOeojQcO44L9uTyKP9aRdIG0_1769881583
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 30, 2026 at 02:52:12PM -0600, Ira Weiny wrote:
> Li Chen wrote:
> > Under heavy concurrent flush traffic, virtio-pmem can overflow its request
> > virtqueue (req_vq): virtqueue_add_sgs() starts returning -ENOSPC and the
> > driver logs "no free slots in the virtqueue". Shortly after that the
> > device enters VIRTIO_CONFIG_S_NEEDS_RESET and flush requests fail with
> > "virtio pmem device needs a reset".
> > 
> > Serialize virtio_pmem_flush() with a per-device mutex so only one flush
> > request is in-flight at a time. This prevents req_vq descriptor overflow
> > under high concurrency.
> > 
> > Reproducer (guest with virtio-pmem):
> >   - mkfs.ext4 -F /dev/pmem0
> >   - mount -t ext4 -o dax,noatime /dev/pmem0 /mnt/bench
> >   - fio: ioengine=io_uring rw=randwrite bs=4k iodepth=64 numjobs=64
> >         direct=1 fsync=1 runtime=30s time_based=1
> 
> I don't see this error.
> 
> <file>
> 13:28:50 > cat foo.fio 
> # test http://lore.kernel.org/20260113034552.62805-1-me@linux.beauty
> 
> [global]
> filename=/mnt/bench/foo
> ioengine=io_uring
> size=1G
> bs=4K
> iodepth=64
> numjobs=64
> direct=1
> fsync=1
> runtime=30s
> time_based=1
> 
> [rand-write]
> rw=randwrite
> </file>
> 
> It's possible I'm doing something wrong.  Can you share your qemu cmdline
> or more details on the bug yall see.
> 
> >   - dmesg: "no free slots in the virtqueue"
> >            "virtio pmem device needs a reset"
> > 
> > Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> > Signed-off-by: Li Chen <me@linux.beauty>
> > ---
> >  drivers/nvdimm/nd_virtio.c   | 15 +++++++++++----
> >  drivers/nvdimm/virtio_pmem.c |  1 +
> >  drivers/nvdimm/virtio_pmem.h |  4 ++++
> >  3 files changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > index c3f07be4aa22..827a17fe7c71 100644
> > --- a/drivers/nvdimm/nd_virtio.c
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -44,19 +44,24 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
> >  	unsigned long flags;
> >  	int err, err1;
> >  
> > +	might_sleep();


for that matter might_sleep not really needed near mutex_lock.


> > +	mutex_lock(&vpmem->flush_lock);
> 
> Assuming this does fix a bug I'd rather use guard here.
> 
> 	guard(mutex)(&vpmem->flush_lock);
> 
> Then skip all the gotos and out_unlock stuff.
> 
> Also, does this affect performance at all?
> 
> Ira
> 
> > +
> >  	/*
> >  	 * Don't bother to submit the request to the device if the device is
> >  	 * not activated.
> >  	 */
> >  	if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_NEEDS_RESET) {
> >  		dev_info(&vdev->dev, "virtio pmem device needs a reset\n");
> > -		return -EIO;
> > +		err = -EIO;
> > +		goto out_unlock;
> >  	}
> >  
> > -	might_sleep();
> >  	req_data = kmalloc(sizeof(*req_data), GFP_KERNEL);
> > -	if (!req_data)
> > -		return -ENOMEM;
> > +	if (!req_data) {
> > +		err = -ENOMEM;
> > +		goto out_unlock;
> > +	}
> >  
> >  	req_data->done = false;
> >  	init_waitqueue_head(&req_data->host_acked);
> > @@ -103,6 +108,8 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
> >  	}
> >  
> >  	kfree(req_data);
> > +out_unlock:
> > +	mutex_unlock(&vpmem->flush_lock);
> >  	return err;
> >  };
> 
> [snip]

