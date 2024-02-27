Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074D1468FE
	for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048941; cv=none; b=VGljqesMJgweMyEMdRHJ7CgtQiTgftLK2TyC1dMtmaM2UIEawvFKQUi7L7XXmV4cRrEvKXa7L5reyky0orfrDP8K5dRk+GYrqg5iHR/HOPYeVO5eWBgWYlJ7PcXKvh02ddt2tRTiRXsB4TaHENCPJlU7ImV7wVtdCEV8UjrdHtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048941; c=relaxed/simple;
	bh=up+DCN5ChGl/E+3j2L4zs+YPx9EtncoGLVBvu8pAspA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S0dxqufKHr6wLLJGUDidRUOXjva4HVfgAPJZTdc2OGT4SxIW3kVJyEg0Tjcg3PFYaBjs9Q9s9O2+VuGyqfy5c8WsQpSp+Bu0kgf7788E6fjIcdFH7jhjY/3SZlTa9Itea8D21zP+NmufnocZGMmh+hAYmeTdQNoExplkUZe1p0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO5g2sSg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO5g2sSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709048937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/xbnPq7RXIvNg+PfYUQ/SxQLN6DLHw3idVYtn+kLNDc=;
	b=YO5g2sSgOA9ZUeviweCeFCQ4DH0bxYJCawiNTNqm0voftXnIsfR1qJVAVEHMRrCJ427qG6
	39PGcW0pYoPvkFmHQIl/SeZY0sAGoFtXWXm8OHkWvM9pGNspHNnMrM5Be82GBym1yMH9WT
	3uLjAXEE1CU9fN9DGZnmR5zFclMe1MQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-3gYvVTwVNVO9ep30bp_aAw-1; Tue, 27 Feb 2024 10:48:55 -0500
X-MC-Unique: 3gYvVTwVNVO9ep30bp_aAw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33dadb50731so2330757f8f.1
        for <virtualization@lists.linux.dev>; Tue, 27 Feb 2024 07:48:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709048934; x=1709653734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xbnPq7RXIvNg+PfYUQ/SxQLN6DLHw3idVYtn+kLNDc=;
        b=vYFJRkpSGaU53MLkKjKQrTXe3uLyhzWMVq4kC4etL4Hw448rCCb/HuUuJAwoMpZdHz
         iICJOQqIwojWwHqkMhwEvk98bHK7I0t4nxXj3mwStEAy6N5PEeAQ5EP6vhq1t1HE+RRN
         8tQHdlhapbP8b5SFBPIzPCfBkQCNqAVJzWlaD8sjw7W4AGy4G/1xoBhROM573GtlfeuL
         WycWbtSeVLtrAWIK54sbJTlnxDqgVmYaRLXith4Zdi01hs/QolFIqCMr1F+rLeMUwRdM
         hZ5QTQZGUSOfpQArY/23V2c0nytEi+Yq7XPd4xEiW9yWgcY996NdjHzLKpfzVnRoaxvT
         0CDg==
X-Forwarded-Encrypted: i=1; AJvYcCWxrkJrhnQVpZCn53vhCriIJY70CuVCTvWuz6fXxYjZogHOEHIScQ6TS2cRAaJ+hdxl2icP2oefYWt7sL1ahI5bc0MudsosDYhjCjSlQSU=
X-Gm-Message-State: AOJu0YzYpLFvFO0waBbOy3VTYqPlt5GqOJ4mLXICTBTz1QrqpU+HnfD3
	csfsIImSwj49VH8svFQJeQ7pMm7BCmTel7o1EXoXXfqSY44hnSDRmluEs5LxQEba/BQiIo1xofA
	cPyUpc6BXHq7GvOR1HV4eGR/+xVH2bcfT0beOEqemfPzrZSzLfJWnoXmFgwRM/OhX
X-Received: by 2002:adf:e702:0:b0:33d:509c:5692 with SMTP id c2-20020adfe702000000b0033d509c5692mr7613809wrm.31.1709048934561;
        Tue, 27 Feb 2024 07:48:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhhMpgy8POimkjUANc+4RteuVbX4FX4SRQYH18i2c3XpSnO3gd/o0FCmDM1lLUaZunxWosww==
X-Received: by 2002:adf:e702:0:b0:33d:509c:5692 with SMTP id c2-20020adfe702000000b0033d509c5692mr7613789wrm.31.1709048934215;
        Tue, 27 Feb 2024 07:48:54 -0800 (PST)
Received: from redhat.com ([2.52.10.44])
        by smtp.gmail.com with ESMTPSA id t9-20020adfeb89000000b0033dbeb2eb4dsm11575355wrn.110.2024.02.27.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:48:53 -0800 (PST)
Date: Tue, 27 Feb 2024 10:48:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <20240227104743-mutt-send-email-mst@kernel.org>
References: <e26476e0-68ae-412d-a5d9-4996bc30d038@moroto.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <e26476e0-68ae-412d-a5d9-4996bc30d038@moroto.mountain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 27, 2024 at 06:21:46PM +0300, Dan Carpenter wrote:
> The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> reading one element beyond the end of the array.
> 
> Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>


Oh wow and does this not come from userspace? If yes we
need the speculation magic macro when using the index, do we not?

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index b7a1fb88c506..9150c8281953 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1532,7 +1532,7 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
>  	if ((vma->vm_flags & VM_SHARED) == 0)
>  		return -EINVAL;
>  
> -	if (index > dev->vq_num)
> +	if (index >= dev->vq_num)
>  		return -EINVAL;
>  
>  	vq = dev->vqs[index];
> -- 
> 2.43.0

