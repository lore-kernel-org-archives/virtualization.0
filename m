Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB965103F
	for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710832990; cv=none; b=nlkMluzrPaSdcvwMneXYUZ3T3Vxn3CtnqzWQE8ENiBfwPSjI0OauOZ7+R8mC6Kh4U8VO3uSqBAe+fEJiiFk/ldjByBldxZ9G2Yg1djYaVuEEQkGpUciJo7rTawY3Iq61KAJ/VetgD/8svj7tlZHR+appSeTeYfxd3tj3Su/wey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710832990; c=relaxed/simple;
	bh=gqHMvDqH0GXe3nNnNKZOzNASEO3LjbY4EVAyXt8HAfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=G2zLnpR0npxG2HoDNWQA646r+uizRBdoXOc0lG5LPNGKJbwr5qGRL5+jrh9C7tLpvx1SwK1I7qzjvsZTw0u7uzBtLEVXcWfmaDJm5GL1JdaCgkGXW5ckmp+Rj8nihWPpX88mrqKUWME6lO31PMaL7uWg5xoDdq+ao/NJEPVGd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwNEHwuF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwNEHwuF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710832987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VuSY72tnFKw3HBgsDczhmcUm8blV9e3YgrUys0sfBAo=;
	b=IwNEHwuFMvHhmkgjjuwi76dcFW41E9wsPqVEms/+VzRNZcGjZGl5DjkLox5FcKHhpkEBV+
	8xiihux8+jabQFn96rlXDQoUoBqUqyJgIJJS3Mzy59QbKpmXW0/SonLX+MOqBrljMoz8U+
	J2/HCddIpGv/gzq/bxvYTu0qlgSXj2g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-9GJixVaCMKKxuqiPIlgdnQ-1; Tue, 19 Mar 2024 03:23:06 -0400
X-MC-Unique: 9GJixVaCMKKxuqiPIlgdnQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4140408c7faso19995845e9.1
        for <virtualization@lists.linux.dev>; Tue, 19 Mar 2024 00:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710832985; x=1711437785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuSY72tnFKw3HBgsDczhmcUm8blV9e3YgrUys0sfBAo=;
        b=oewW5aLZ5zPg2XDzud5Seh/wYBldr6JIV6qWIPYHkGU+Ldcfv5WxGEHKghoVwwCBW/
         5fc/HTFpVUVwIzfPwf/NkoVyAQ03IM77fvBqIRqnBcY+fkpbPUP6jgHIOM96kCJMB4RZ
         N2BJ4MEl5KT5H9q9zRyTj3wn0AEcHnZ5OM1tlNuP+v7rNvynEVa0hSBwMVGySglEJgKJ
         TBPGptpP38db3ZuX5vet9aKZs89TUlYK7BxWFdN47uNqsevCUUcQOYQtn9Dr6lCoZ4WT
         OCDP0An4tdeVwdQMuhnDnCPl9jbgcpVPuZSJPF2ptwWuCnYWL9W+JcQOIfS1tdMkgkYT
         9tow==
X-Forwarded-Encrypted: i=1; AJvYcCXiLc/+D8xeQ0Stwl9AA51mxDoEGat5UKRSf9C60clCr9XPvN7rsT1VuPR/H7o73FXjMTMqWrF3tuteYPGqKaumz1kcdCvlJ0CXMKvMTdk=
X-Gm-Message-State: AOJu0YxYid4apKssrNZ1+m6uLn77+ra0xqPKboAmpWVoVipmQMArQjDg
	3pjya6pUr/0xTxEilKKBCuXfLB2IwxOtFtIhkhN7THwxeVPrHKezIJcl2xz/dXrH3svlFwNalqD
	CSBdnpQt8ocyHjMKjy9oeIrl2PKiHjVWjgh09ys36xQJEyKVfI+Z8K7mDlqTLianCgviJLZzq
X-Received: by 2002:a05:600c:1ca8:b0:414:1351:8662 with SMTP id k40-20020a05600c1ca800b0041413518662mr2829454wms.12.1710832984750;
        Tue, 19 Mar 2024 00:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpzVhgY4JbDOMx+gLoAdQmLnA6ngQJMNzK4g2rbZEkR6NI+HOgZjEDBPCMFSZnVPXHqFGHSA==
X-Received: by 2002:a05:600c:1ca8:b0:414:1351:8662 with SMTP id k40-20020a05600c1ca800b0041413518662mr2829433wms.12.1710832984278;
        Tue, 19 Mar 2024 00:23:04 -0700 (PDT)
Received: from redhat.com ([2.52.6.254])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b00413e4ff2884sm20338273wmb.40.2024.03.19.00.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 00:23:03 -0700 (PDT)
Date: Tue, 19 Mar 2024 03:23:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Cindy Lu <lulu@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <20240319032236-mutt-send-email-mst@kernel.org>
References: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 28, 2024 at 09:24:07PM +0300, Dan Carpenter wrote:
> The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
> vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
> reading one element beyond the end of the array.
> 
> Add an array_index_nospec() as well to prevent speculation issues.
> 
> Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks a lot!
I assume this will be squashed in the relevant patch when that is
re-spun.

> ---
> v2: add array_index_nospec()
> v3: I accidentally corrupted v2.  Try again.
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index b7a1fb88c506..eb914084c650 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
>  	if ((vma->vm_flags & VM_SHARED) == 0)
>  		return -EINVAL;
>  
> -	if (index > dev->vq_num)
> +	if (index >= dev->vq_num)
>  		return -EINVAL;
>  
> +	index = array_index_nospec(index, dev->vq_num);
>  	vq = dev->vqs[index];
>  	vaddr = vq->vdpa_reconnect_vaddr;
>  	if (vaddr == 0)
> -- 
> 2.43.0

