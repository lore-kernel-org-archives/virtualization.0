Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002B82FA0F2
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 10:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956891; cv=none; b=Dz+pO2DkHt1QTZj/dnhwu+UkTeZuXwxsjHfqerzoTlFs1cnfp8rk9c1yxouHk9tpKKmycKxJm0IKiuZmP/Ct3HnhJtJNw+tLGneznzRVq7OazZmxRQIL626PVD+xW2w5wWKPnL+9X34DYT4xN82SdQPrmkMShU+KtNhWJZ7OCpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956891; c=relaxed/simple;
	bh=CcQkYsoG2la8PjGJg4TbayykuTETfZyzuwQgmX5Fxm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HrQGzi+RTh8mVOwUCRBcPvGEYR0BqGbovGAjctGzJIHMumTR8knQQeP9f400HF7JLwBgdlbYWtnnpgPu6OQgRtl65mFRKwtItCjC8/ZwgZutZPeAuRYU5fZOPy9ld7o5jikRt9KS+YJvYr3lrBR6tC0aPbEqk83N7KMAZDS/Q3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKvkmfpD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKvkmfpD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760956889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bD4hMybcacQqgtz97VVu7SE15VjVlFQ+1w1a1zq8NKk=;
	b=ZKvkmfpD0OPyuQi6ewROwLmBj6ewgl4llxENJEs4jRYA17rF0MB5hHmAjV77gXSBgPZLl9
	O9nt2/Ctl+nS9/aBFo2OH8uQsUukUD98cp4N8+aXvx8uEj8zAZEv8vdsKMfLhwrj88ofnc
	DijjPZIkEXlFi+kLaCd65Ogko7DxJJw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-3mSw2PILPLOlNA1w1L78NQ-1; Mon, 20 Oct 2025 06:41:22 -0400
X-MC-Unique: 3mSw2PILPLOlNA1w1L78NQ-1
X-Mimecast-MFC-AGG-ID: 3mSw2PILPLOlNA1w1L78NQ_1760956881
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4283bf540ceso980103f8f.1
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 03:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760956881; x=1761561681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD4hMybcacQqgtz97VVu7SE15VjVlFQ+1w1a1zq8NKk=;
        b=K8f5ipHvzpzt461DnhIVxtDe7SSFQFtJ9hw3AVeA1gnth65xd61Y+nO39uUqMi7ScH
         UAPBpn2lMK8/iaApDut5q/005y3Fnw3goZSwabOVx3TUrgSeqPtzwletlu6ORSktYvbf
         kkhZd7ks3xzdoUgeEqAX5tDRWqFCu1mNocHC1UbMQOV4naLK0LSjz5iOG4PaiPlYoYAf
         +Kb7cIXSPaWNda2XQa9b6+zes17DKnMO9gXvew4gUl1FtTFtQhwdA1MFrewBTi3FqEYY
         AWsFlbfXDwUb+FUqMJfagsFo4Y87p2+RsrzE0BNy9iAAfTzRckVoHWZlhvasrcJQPxBh
         zy4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEiicvTomkp0ftA71wnXdfCc914SDtyzFXosMD0SIE+qIqHF2iyGKIAAts8Db36w2AHIVeKyXS6Wf4lprzlw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx60SrgmreR3b0xMWlXObvCV1UbgSL8aHhmqv8t2vxbvwbKsSoM
	OXQZOvVWX262RdspIeNjoxYBdGsL0wl3s+Hh4SRAj42g9cLdN5QUJnpMJqs5UmnGV3V5yvje9OA
	YwzGOYVEMz9WaL8qS2K+O3K/qO3EdlQfF1fC2JJINc8uUiS/rIup/uz91Uq/81/9ZXLne
X-Gm-Gg: ASbGncvHaAUaDqdXS1FNfeynHtSWQWgP3djQg9DJ2umt7VkCUPC86LL62oXDs9q3Wv4
	aFASKaqq/pU6nOZeH8liZE39bTykMAgmEbuCsOjK0zQu7e7YC24m1qhI4w+7u/VkCUkSQ73c1nC
	c9anY/h/REWs/u2YSxvnqyKBxVh37sq9VOzXHTKjUgoIfJjItVWZBAnEqQofsxawZQsSPX6ujF2
	W4pBls5vmjjIyWq9g0vfYcobgVeDKQzmkqxq7hBJxA0GqMgGdcpVjaGd7KoqG4CJ0xxk1bERRKH
	z1+1zwSM1h2S/9IccJvOdomf1ThMruKq27ThEoEA3FAutkAk3bnN2X22UWHj0Xq7xawM
X-Received: by 2002:a05:6000:22c6:b0:403:8cc:db66 with SMTP id ffacd0b85a97d-42704db5bb3mr7676839f8f.32.1760956880949;
        Mon, 20 Oct 2025 03:41:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESGkrK8BdZiWqHNVZP5dwff667CqbFjjVNbL+HTFadnfLILbeuzj4kC09sLI16/SoNU9SPqA==
X-Received: by 2002:a05:6000:22c6:b0:403:8cc:db66 with SMTP id ffacd0b85a97d-42704db5bb3mr7676817f8f.32.1760956880483;
        Mon, 20 Oct 2025 03:41:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm14621716f8f.36.2025.10.20.03.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:41:19 -0700 (PDT)
Date: Mon, 20 Oct 2025 06:41:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 13/19] virtio_ring: introduce virtqueue ops
Message-ID: <20251020063831-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-14-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020071003.28834-14-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wq2MjzLISyZLTl32cuxlLm81OcU1GrVPDaw5wShF__k_1760956881
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2025 at 03:09:57PM +0800, Jason Wang wrote:
> @@ -2782,7 +2874,8 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  	if (!num)
>  		return -EINVAL;
>  
> -	if ((vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num) == num)
> +	if ((virtqueue_is_packed(vq) ? vq->packed.vring.num :
> +			               vq->split.vring.num) == num)
>  		return 0;
>  
>  	err = virtqueue_disable_and_recycle(_vq, recycle);


This is exactly virtqueue_get_vring_size:




> @@ -2985,7 +3072,8 @@ unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
>  
>  	const struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num;
> +	return virtqueue_is_packed(vq) ? vq->packed.vring.num :
> +				      vq->split.vring.num;
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
>

-- 
MST  

