Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16426AE8
	for <virtualization@lists.linux.dev>; Fri, 26 Jul 2024 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970935; cv=none; b=XuKly9g+uPevNscFKQ5qovwZbnKR/6Y8BgnbWXkPyU5XnGnlY8bgIbkG78rsZKjfFsFT+rGQ04WDbWu26TjSZlJGHwDatTPbrXme63qOggXGXRfz7l2F870Meaj28CSXoiv4/KdbwY2jK7Xp4qBhA73kvsYE97Y4JLjYS9xDP60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970935; c=relaxed/simple;
	bh=09DOoIifPIR40R/cmm0IPw36wvh1d3gP5Tu6Tj84ZcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HbC+zzjwcvGvjMRh7XdcZq3L7iIq+lxtkXYQgOvGqP5G6vtAbRSPVWiMiF6TxtHMbfREw4SYWvejqsNfGczKvLapjGB4WMj/gzjPxMq6ZLbnNw4L1MTqRxWcPS4AxvZgtjexFO2ZNo6XoYEm85i+l40gpSSXHAOrSSKuAc1wLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyEZOrmb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyEZOrmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721970932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47E47Ih20+cHzIi1eIXQ9204FfnEX8ky7z1yVmn+jN0=;
	b=QyEZOrmbl9eIJWuI0j5bMAJh52oy+4J2kzS2TrQOZb/LJEPa2iLkTVdwxDmZCVnl0ygMu6
	aVGxih55FrxYDE7QlBEmj1zTZ8lvbQZAtdcIobZt0wykWz97agW7zr1qsHGSAUY3HOgDWP
	Q9hFuIDICWEK1IdUv4qnlpUKefYYIdA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-uUiPXO1OOJS0CwdiraA1dQ-1; Fri, 26 Jul 2024 01:15:30 -0400
X-MC-Unique: uUiPXO1OOJS0CwdiraA1dQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280b4a34c8so2854885e9.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jul 2024 22:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721970929; x=1722575729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47E47Ih20+cHzIi1eIXQ9204FfnEX8ky7z1yVmn+jN0=;
        b=bLphNJDzNjYD8ntMdYivBtIdkVllng5F1paKYlA/sHd1eSeygH2pOmCE9s0MkmKD/b
         r0q5GGj4EEDr1deSkvmSFkhBZzK0XBLepo2eQ770Dz1Mqx4g6YtIr4VNh2Y0zaPQA7RM
         Bw+wNwHo71QuXaBKOsTNnWKRCbd1WQmktq0bZVoW35p3zf7hwKE0T2LhgIAmE2OhVYkp
         6+ZnK0CdOn/Yva2GRIbMKwOTSsHh7yk1Gb99g6JMCUY7aEgC6QikgyclRk9gL2OevQhA
         CEvi4jN80mQSN12Zk9/XNhji2E8K7KRjVRH3/KFAcmC6OUELq8pL5XslVeX76WpYdw0z
         ZHjg==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZLF5CHCq482Z1XlZh1J+AhcdhKKfMRVfZzQjO5uMkaIuwILNRsBZjkK60H0aqERc8ILqgKNf06Y4Sh5ZZOeMEyDUJ1oO/SRpuhpjAzc=
X-Gm-Message-State: AOJu0YzZco6VxuYbHm8A1B9pfNLXZqjDyfqfglyY90N8uVC6Dymq89QT
	cQWPrXCOUHfbHJC8c9QkE38OaWDb7nskdkVL8K2g+E0SNgaSirsfc2VEbHLuyfmnR4XmiTJkVWr
	L4IsgiXwhAOlu8N0j5gcLFFu0ESdWJdO7pLlENKzhx4DOesMasR8s9HNQtmYACkI4
X-Received: by 2002:a05:600c:4f14:b0:426:618f:1a31 with SMTP id 5b1f17b1804b1-42805708da8mr29937905e9.34.1721970929021;
        Thu, 25 Jul 2024 22:15:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPPQzgCEY55kxHciO2AHSa7wqaJtGNw7J7VtkvGDcvq918mcg9vv+Z2rJP/QDcYigYRgbIuw==
X-Received: by 2002:a05:600c:4f14:b0:426:618f:1a31 with SMTP id 5b1f17b1804b1-42805708da8mr29937685e9.34.1721970928347;
        Thu, 25 Jul 2024 22:15:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:28ce:f21a:7e1e:6a9:f708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93e667bsm102788595e9.29.2024.07.25.22.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 22:15:27 -0700 (PDT)
Date: Fri, 26 Jul 2024 01:15:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, xieyongji@bytedance.com,
	stefanha@redhat.com, virtio-dev@lists.linux.dev,
	virtualization@lists.linux.dev, quic_mnalajal@quicinc.com,
	quic_eberman@quicinc.com, quic_pheragu@quicinc.com,
	quic_pderrin@quicinc.com, quic_cvanscha@quicinc.com,
	quic_pkondeti@quicinc.com, quic_tsoni@quicinc.com,
	eperezma <eperezma@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Cindy Lu <lulu@redhat.com>
Subject: Re: [RFC] vduse config write support
Message-ID: <20240726011340-mutt-send-email-mst@kernel.org>
References: <20240724033816.GD492231@quicinc.com>
 <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs_FHg6xZAw2V7AKvj5XFCmaA0Xm+ei7z4OFJPNgO5Thw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jul 26, 2024 at 10:47:59AM +0800, Jason Wang wrote:
> On Wed, Jul 24, 2024 at 11:45 AM Srivatsa Vaddagiri
> <quic_svaddagi@quicinc.com> wrote:
> >
> > Currently vduse does not seem to support configuration space writes
> > (vduse_vdpa_set_config does nothing). Is there any plan to lift that
> > limitation? I am aware of the discussions that took place here:
> >
> > https://patchwork.kernel.org/project/netdevbpf/patch/20210615141331.407-11-xieyongji@bytedance.com/
> >
> > Perhaps writes can be supported *selectively* without violating safety concerns
> > expressed in the above email discussion?
> 
> Adding more relevant people here.
> 
> It can probably be done case by case. The main reason for avoiding
> config writing is
> 
> 1) to prevent buggy/malicious userspace from hanging kernel driver for ever
> 2) to prevent buggy/malicious userspace device to break the semantic
> 
> Basically, it is the traditional trust model where the kernel doesn't
> trust userspace.
> 
> E.g current virtio-blk has the following codes:
> 
> tatic ssize_t
> cache_type_store(struct device *dev, struct device_attribute *attr,
>          const char *buf, size_t count)
> {
>         struct gendisk *disk = dev_to_disk(dev);
>         struct virtio_blk *vblk = disk->private_data;
>         struct virtio_device *vdev = vblk->vdev;
>         int i;
> 
>         BUG_ON(!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_CONFIG_WCE));
>         i = sysfs_match_string(virtblk_cache_types, buf);
>         if (i < 0)
>         return i;
> 
>         virtio_cwrite8(vdev, offsetof(struct virtio_blk_config, wce), i);
>         virtblk_update_cache_mode(vdev);
>         return count;
> }

To be fair, I think if you allow a block device in userspace you have already
allowed said userspace to crash the kernel unless you have
also restricted the filesystems mounted on this device to FUSE.

-- 
MST

