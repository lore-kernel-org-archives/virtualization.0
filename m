Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1121B1F0E4B
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 06:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751352355; cv=none; b=hJ+HLc6/K/hV4Q1832ssySxLQno4+jkJqrCFXCHEiJ5KGc9aQ60iWBvpEMm7BUIxFXailAaqio6mIJ55Sf1woW8AmvUT9RXowpXpo/9bhP8n543s+eU1M+/uSy6DOaqLzY3FCHbn7n5/MxmwRFNbKGlxRcnXRrOVVsNFyff0dnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751352355; c=relaxed/simple;
	bh=gLhUqpMgS9yLqJKaBfIOhojwMZScqGvBOte8jL4p3oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mp4EehLTNJ/7t6OC9gw3RRIuL6AUlvuMuhkizKU4PHKObzTJjJCFJ0wSe4SUzx1Jp/f2hE91QzWDxSgq26T6sPFnqWUmMqI97IIdppM1N627PTVcqEbSqxcOZIaXvvxHqb8Pelcuq1zuZPQ2DNLs1FIglFlawG7gSttPfWrfVYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPfo+yPl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPfo+yPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751352352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/FB/rr13rxhfU8eE4uQBrYdSojlxrnS1P6/7C5rZKVs=;
	b=NPfo+yPlTGByTIJra44vCbexSLY4MJ7F2yX+l3HLPnIdOFdLGp1UKOtz2SjV3feFgVivKZ
	FhBt/qwK7htnRu+kuA5sU37RJdgDQrr8DL3FVoZn62hxd6iP4CLIDSiqtSl4C5bWms9BDr
	KkOH4aSYVpLjRXLVc8qA4WzKY5fSaZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-7k_IKh1HPy-D0M0TO3C01A-1; Tue, 01 Jul 2025 02:45:51 -0400
X-MC-Unique: 7k_IKh1HPy-D0M0TO3C01A-1
X-Mimecast-MFC-AGG-ID: 7k_IKh1HPy-D0M0TO3C01A_1751352351
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450d64026baso27045115e9.1
        for <virtualization@lists.linux.dev>; Mon, 30 Jun 2025 23:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751352350; x=1751957150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FB/rr13rxhfU8eE4uQBrYdSojlxrnS1P6/7C5rZKVs=;
        b=e84JrK3wPCMuQiC95i2ewf+w82SF/2Az1AU+8kGYMu/C4i7He+osnJ9leiIuK18Xk1
         XJq5ta1Hfys/2xshwvxGQDQNTPRzrcLuiLJ85X01HXsgfpL3IpgNl4P9FcVOVMwnbabp
         CF5sTC/q+KeY1p2XdAKft0aR3SdAm+0vTYfjfU0Nlvh2f1yOFBRIOYciU+d+owbGZt3P
         B64bYiPoaR+MQBLQ8dWSWuriEQhLEhCaDB37LAlHMUX49GXXc0VRKEXVlwD8MlB4czdi
         q638GK4MuU8Zxsq79DvbfVJX0JvJ8BB7McjsVtQ/aaKzY/RstNFw1W7vOnEhqwG8yzAe
         JvSg==
X-Forwarded-Encrypted: i=1; AJvYcCU2J/DTldK3JUqYEg3+wGJQDd0JXPWfbTGO3or6D6sc5wuV8OYQ8q903otLK/er2v+ZWXJyAhzS8I9goHM9ew==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywxt3TfMeMTE5oF8Ec9H1rYqjYbZnw5kg6dPKYOyHdX2qj9Uf/8
	85L8oMWtCvltQOabgAkpYPygtlzgQn7e5/86Cs7rZaKQrpv+QKYzoShVbrAUEXb8G+bSQhOKJXq
	+zYFWJZR0DE+9lyKbiESCm4nm9jl48vX8YRaDvWKI3zcZGssyIOIhzM8liNxk7dtTxe5z
X-Gm-Gg: ASbGncuL8qpxDyTWhQLNnGEgF4hvBQ93sT+02Ci+wbGZrDSFVtHBCjLYh1SwnMyINZC
	McG4v71Q2bjOyx09cUNH8BjyJjM19PFtzVFFCVylFqIrCl1orkOnDM3zbFCmNNSdMWaYb7F2XtB
	LbjDB3uWQnzSGxNROsEuYmNQnACZSfbZZUErJKLfNpS1e9PNOXn5JsTkU0D6EdEgkWOABm3+wzJ
	Rqm9qCIp9Y7kQpsCJPAFP0ThMHJD1/m2vqro+N6VR38SBYPPB2WA0NMYEf70X6ZJfDV8iSvS4KV
	HTvq46nJiaj/uMNP
X-Received: by 2002:a05:600c:8518:b0:442:f482:c421 with SMTP id 5b1f17b1804b1-4538ee7df51mr140275755e9.22.1751352350383;
        Mon, 30 Jun 2025 23:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNqYmg2q01DPQRmv8jE+6E8iA13iSfpZEeDhKnGAq6nzxNu9hatrBH/eHkSndzvZVUAhPbfw==
X-Received: by 2002:a05:600c:8518:b0:442:f482:c421 with SMTP id 5b1f17b1804b1-4538ee7df51mr140275485e9.22.1751352349874;
        Mon, 30 Jun 2025 23:45:49 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad03asm187631545e9.23.2025.06.30.23.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 23:45:49 -0700 (PDT)
Date: Tue, 1 Jul 2025 02:45:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 18/19] virtio_ring: factor out split detaching logic
Message-ID: <20250701024506-mutt-send-email-mst@kernel.org>
References: <20250616082518.10411-1-jasowang@redhat.com>
 <20250616082518.10411-19-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250616082518.10411-19-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VW-eSRh7-n4Gax_kYOltwPIAdnH1dXwX69GQc5eVFnE_1751352351
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2025 at 04:25:16PM +0800, Jason Wang wrote:
> This patch factors out the split core detaching logic that could be
> reused by in order feature into a dedicated function.

you mean 

Factor out the split core detaching logic  into a dedicated function
so it cn be reused by the in order feature


> 
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 259380797ec4..27a9459a0555 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -804,8 +804,9 @@ static void detach_indirect_split(struct vring_virtqueue *vq,
>  	vq->split.desc_state[head].indir_desc = NULL;
>  }
>  
> -static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> -			     void **ctx)
> +static unsigned detach_buf_split_in_order(struct vring_virtqueue *vq,
> +					  unsigned int head,
> +					  void **ctx)
>  {
>  	struct vring_desc_extra *extra;
>  	unsigned int i;
> @@ -826,8 +827,6 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	}
>  
>  	vring_unmap_one_split(vq, &extra[i]);
> -	vq->split.desc_extra[i].next = vq->free_head;
> -	vq->free_head = head;
>  
>  	/* Plus final descriptor */
>  	vq->vq.num_free++;
> @@ -836,6 +835,17 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  		detach_indirect_split(vq, head);
>  	else if (ctx)
>  		*ctx = vq->split.desc_state[head].indir_desc;
> +
> +	return i;
> +}
> +
> +static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
> +			     void **ctx)
> +{
> +	unsigned int i = detach_buf_split_in_order(vq, head, ctx);
> +
> +	vq->split.desc_extra[i].next = vq->free_head;
> +	vq->free_head = head;
>  }
>  
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> -- 
> 2.34.1

