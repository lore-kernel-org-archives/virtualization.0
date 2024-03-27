Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F486136E2D
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 12:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541293; cv=none; b=DLbQRimr/bAjD8I1XZvw+HDnT17qFQOwA0DPkvb9en2Wr+LSLCn8vYnuKWLTs536ltbCYbE4CkvxJ4JiXHfB9p62ir47wrqikE3D5erxmOGccCcfSpcFm9MRsFVpwQ4mC4MjCNq3NLkIxy811jErK2tHym4fS3PsExuYXKwopnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541293; c=relaxed/simple;
	bh=lKLG3UiaMdK6ulFJvlHav6o8D9DIxUzc0+qtoqM54VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nz9BOawve5u3t0rxbM48NGfbxbloDDgKMqhIIYrHAUhh1hzDkOw6NrQxle7tUVQURS/4XqkCG4wph/DkdZqqoeV5ot7muKAJj1ynYdU7fU5kFC9ACo2LuDpSCMjV8BatZLH9NE+YvJ0o/XVemcdhirFweJTvxSSCOO+Y5tGRN7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TruiT/wm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TruiT/wm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711541290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bi+ZQnYSyNBVd43PK67DW5yA3+DYZIo1uqQGHuPLUr4=;
	b=TruiT/wmqJDbvGYyCA7DgpuI9M2PUcY+Ias38wX4Rt7aitMRl5hBgLYdv57Hyr58YW6s9q
	1TRwKtp3OzptLPJvhO6CTbYXsWtgwSckmC5tS5gIdff0x62sK6wGHMYjkEJJLVPz3vDmPs
	0ARAA3pWXVAwRDDI6l4etSkqG4WynSQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-wkdd5HKwPCyLXxCI2_IZsA-1; Wed, 27 Mar 2024 08:08:09 -0400
X-MC-Unique: wkdd5HKwPCyLXxCI2_IZsA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4148a697e35so13057225e9.1
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 05:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711541287; x=1712146087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bi+ZQnYSyNBVd43PK67DW5yA3+DYZIo1uqQGHuPLUr4=;
        b=VrdhRHAR9IHYUcmPpYTpNMwKFvZLgUYReVXMS22Qom/OPIapyE//Lu7fZO9CFdXj1H
         evo+BYXZyOKzKKjRIMegdkKOoMdQ1ys8i2h3kgOF1wbkLeZiUzFIHWMPSZt6bXWtyOHP
         DViTlG+viSo8iRz2aUl1ySF9+eFCPmbRU6z6UTE5MI/aqnVr+hGTCU0EThmBPXFUuRCS
         JJxQnuMeC9A7BYtnPHjaulDeo9IjJOpM21tcJOTof09q57U5U6mb6f7INta7vv70vOkx
         oGbGS4X9ilNpYJfvmpaUl4jPosn0Q4clQtu3uM8S2ls61eHXKseInuWiwa6UhCuH5Ywe
         VNyw==
X-Gm-Message-State: AOJu0Yy6FLtosq78Zal9PZHwG8i6rWRYVxzlwWhNP2jMODc/HrxY6CXI
	BQ4BTION+2QN3poBhWzyppDygiDqxkVG60iWDD4RvZyzrszDBMngxwSvgYWSnjMnkkaQEEn0Dzj
	j9dUEtXu9MfLCX+ktdZENrwDsWAKTd9s8yGX+rW92/OPjn413Y5t1egzUKKxRzag4huPQutP9
X-Received: by 2002:a05:600c:5716:b0:413:f7c4:f4fc with SMTP id jv22-20020a05600c571600b00413f7c4f4fcmr1708275wmb.15.1711541286789;
        Wed, 27 Mar 2024 05:08:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrGIPFjXov8faB+sPfLv/7odN1taQWiMTqh1DDC2SOAY/ynb3YOFq7GV+r4op9aeSbHg+BTA==
X-Received: by 2002:a05:600c:5716:b0:413:f7c4:f4fc with SMTP id jv22-20020a05600c571600b00413f7c4f4fcmr1708253wmb.15.1711541286235;
        Wed, 27 Mar 2024 05:08:06 -0700 (PDT)
Received: from redhat.com ([2.52.20.36])
        by smtp.gmail.com with ESMTPSA id z18-20020a05600c0a1200b00414928360bbsm2000995wmp.6.2024.03.27.05.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:08:05 -0700 (PDT)
Date: Wed, 27 Mar 2024 08:07:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, davem@davemloft.net, stefanha@redhat.com,
	sgarzare@redhat.com, keirf@google.com, yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: Re: [PATCH v2 1/2] vhost: Add smp_rmb() in vhost_vq_avail_empty()
Message-ID: <20240327075940-mutt-send-email-mst@kernel.org>
References: <20240326233846.1086253-1-gshan@redhat.com>
 <20240326233846.1086253-2-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240326233846.1086253-2-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2024 at 09:38:45AM +1000, Gavin Shan wrote:
> A smp_rmb() has been missed in vhost_vq_avail_empty(), spotted by
> Will Deacon <will@kernel.org>. Otherwise, it's not ensured the
> available ring entries pushed by guest can be observed by vhost
> in time, leading to stale available ring entries fetched by vhost
> in vhost_get_vq_desc(), as reported by Yihuang Yu on NVidia's
> grace-hopper (ARM64) platform.
> 
>   /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
>   -accel kvm -machine virt,gic-version=host -cpu host          \
>   -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
>   -m 4096M,slots=16,maxmem=64G                                 \
>   -object memory-backend-ram,id=mem0,size=4096M                \
>    :                                                           \
>   -netdev tap,id=vnet0,vhost=true                              \
>   -device virtio-net-pci,bus=pcie.8,netdev=vnet0,mac=52:54:00:f1:26:b0
>    :
>   guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
>   virtio_net virtio0: output.0:id 100 is not a head!
> 
> Add the missed smp_rmb() in vhost_vq_avail_empty(). Note that it
> should be safe until vq->avail_idx is changed by commit 275bf960ac697
> ("vhost: better detection of available buffers").
> 
> Fixes: 275bf960ac697 ("vhost: better detection of available buffers")
> Cc: <stable@kernel.org> # v4.11+
> Reported-by: Yihuang Yu <yihyu@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  drivers/vhost/vhost.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 045f666b4f12..00445ab172b3 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2799,9 +2799,18 @@ bool vhost_vq_avail_empty(struct vhost_dev *dev, struct vhost_virtqueue *vq)
>  	r = vhost_get_avail_idx(vq, &avail_idx);
>  	if (unlikely(r))
>  		return false;
> +
>  	vq->avail_idx = vhost16_to_cpu(vq, avail_idx);
> +	if (vq->avail_idx != vq->last_avail_idx) {
> +		/* Similar to what's done in vhost_get_vq_desc(), we need
> +		 * to ensure the available ring entries have been exposed
> +		 * by guest.
> +		 */

A slightly clearer comment:

/* Since we have updated avail_idx, the following call to
 * vhost_get_vq_desc will read available ring entries.
 * Make sure that read happens after the avail_idx read.
 */

Pls repost with that, and I will apply.

Also add suggested-by for will.


> +		smp_rmb();
> +		return false;
> +	}
>  
> -	return vq->avail_idx == vq->last_avail_idx;
> +	return true;
>  }
>  EXPORT_SYMBOL_GPL(vhost_vq_avail_empty);

As a follow-up patch, we should clean out code duplication that
accumulated with 3 places reading avail idx in essentially
the same way - this duplication is what causes the mess in
the 1st place.






> -- 
> 2.44.0

