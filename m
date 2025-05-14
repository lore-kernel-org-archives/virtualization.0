Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A02581
	for <virtualization@lists.linux.dev>; Wed, 14 May 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226520; cv=none; b=UzRcH9Yhrfj8kakulEJnE8/nexNgdyteumlxoapEBtmefU5GuxInxQjXtyOV9ekvF6CoAdf/EoOM1BFybYYOkFpXrESI0lf0XQt3d+gCsTCjIFmthXnfzKwvH12/ZGUZiHjeRdh/piATzXzOH0cM4mMvYRx7L4D2HHjzHItuejU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226520; c=relaxed/simple;
	bh=EEGfYDjUdSZy0/RFIcEvsmm9uPhga5AdR3yZjbpPimk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YgebNPwjzFwDJWdF68XLT6bzn9R6GGQnOfHc+kCrCcxuSXvEqnUvKN/r+OZCn0Y7bQlpHWHcanXz8XVcF8Ypl9iaW9xAmdCmtoUA9E5UgjhkwWBECdWmPiIJtJjN9t7Ze+STeBrErdyxTTjlNKr57bEQ7w67G6zM/yNimc6TIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6WiB3SC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6WiB3SC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747226517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BHHDRyYIIxfuAzn8skJQ0/Rzmdn0HuqApROcitBMMpk=;
	b=f6WiB3SCdX+5nhu3DI5XmdOFThx8ui/Msp+rmck/QgaNmAtqt6UTz22MLO7ezOeJKiiewN
	eIXEA26hf4W7cnkpN8zHhHFwd6J6YgmQRRh5puXE10DcUITeq0mdHHooL+JhEWz2Bg+NBw
	HbYmjThHsf4Ssy9UuvRrEO9FCh5fm24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-DgtEvqr1MQiAalsJ2Tmfsg-1; Wed, 14 May 2025 08:41:55 -0400
X-MC-Unique: DgtEvqr1MQiAalsJ2Tmfsg-1
X-Mimecast-MFC-AGG-ID: DgtEvqr1MQiAalsJ2Tmfsg_1747226515
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-440667e7f92so32924165e9.3
        for <virtualization@lists.linux.dev>; Wed, 14 May 2025 05:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747226514; x=1747831314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHHDRyYIIxfuAzn8skJQ0/Rzmdn0HuqApROcitBMMpk=;
        b=Lmp2RHhfjTen9uuHfbLIWbETICwSuot36jS0yqoFTQ5DZrwbkrp1+6JJEuozsLpEQR
         YA1d1OdBhDa5LtbepjAeObE8Uou9EqUBzbwzukSfXwuX3u1qdp9XnwM1fHS9eFJ1xibB
         v4BQ+9rkDphj74+fQXJvYo2ylsmhxGkZ2VLiTsageXw8N9H2NviOgxAuKC2YCIosWT3S
         hcQw88XQwsOBNpfGS0LCBCCKRaeXmukPfnms4B1CBR3/Wg7Fk3vrK2Sn8HMHkwfvOz0Z
         Qo0RTH6NSWhSrbojdTlg2MofPYC5RZJchA4VQc50Db+u6mXoYBIzF70FjZD/9UMHUqnt
         U1oA==
X-Forwarded-Encrypted: i=1; AJvYcCX7esRXA6pdpxkUQS7nZpJmlTBR2WYPjjOpvSsQfhdXe1zTB+kD9uNthKyDvnxnjjMy/B887QSk6UzuYc/FOg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvENNpApzl5NMKzvVcVJ2ORO/YjECeS83dDrfDmzwfCxL+yaA6
	hnATQWKC2zn3X9KxlcImZasv6zTxR7S8/zgFKWDngS/uesLJnnb3QSsokrjj0CpEg8eKP6oKjvk
	1YqbQk0Ez0B3TpdX/NfGfdbqhnmlAX5Ti9ZzkK5trLawsTyE4ArmVPeJ3ofSCmy2R
X-Gm-Gg: ASbGncuntUNp7Voliktrp6BTb2Z7NMgei8RJpDQLeEnyOZLGlnzBs6XFBiU9ZrY9VKR
	Qc5F+dz532OwmrIEERLqSiho/sxssDzpn2FECbo3QhpQVNcwDoA/e0XJFs7jSZt3LcjKJDgO5j+
	4dURmdQ8DOh7ii9KNTDj6jCqklsE7DWpKjOzd2N3aq7x/8ITe3gbdRCJyyr4EZrxXONRZgYMKij
	mEQaLbiefFYDCYSwIPplxmcoczedCQHonA4U0El9u4uUQxD5Sp66KmtyyhlHglZcMIv78ApFLoh
	OaROcA==
X-Received: by 2002:a05:600c:4e0e:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-442f20bae9amr29141595e9.6.1747226514674;
        Wed, 14 May 2025 05:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE48EoGZ2uk0nrpc2KvJ3SdazvxaUIGvnXn9PXwiAZf3ac9pN6HJ4xaShBQmCTJtS3wZo97WQ==
X-Received: by 2002:a05:600c:4e0e:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-442f20bae9amr29141345e9.6.1747226514281;
        Wed, 14 May 2025 05:41:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f8csm19330179f8f.42.2025.05.14.05.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 05:41:53 -0700 (PDT)
Date: Wed, 14 May 2025 08:41:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: israelr@nvidia.com, stefanha@redhat.com, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, oren@nvidia.com, nitzanc@nvidia.com,
	dbenbasat@nvidia.com, smalin@nvidia.com, larora@nvidia.com,
	izach@nvidia.com, aaptel@nvidia.com, parav@nvidia.com,
	kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio_blk: add length check for device writable
 portion
Message-ID: <20250514084133-mutt-send-email-mst@kernel.org>
References: <20250224233106.8519-1-mgurtovoy@nvidia.com>
 <20250224233106.8519-2-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250224233106.8519-2-mgurtovoy@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YylVv99rd4QEMX3wNnHwq39FHlQh59JZ4mWJWGhRbHo_1747226515
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2025 at 01:31:05AM +0200, Max Gurtovoy wrote:
> Add a safety check to ensure that the length of data written by the
> device is at least as large the expected length. If this condition is
> not met, it indicates a potential error in the device's response.
> 
> This change aligns with the virtio specification, which states:
> "The driver MUST NOT make assumptions about data in device-writable
> buffers beyond the first len bytes, and SHOULD ignore this data."
> 
> By setting an error status when len is insufficient, we ensure that the
> driver does not process potentially invalid or incomplete data from the
> device.
> 
> Reviewed-by: Aurelien Aptel <aaptel@nvidia.com>
> Signed-off-by: Lokesh Arora <larora@nvidia.com>
> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---



my question is, is the device out of spec, too?



>  drivers/block/virtio_blk.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6a61ec35f426..58407cfee3ee 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -331,6 +331,20 @@ static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
>  	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
>  }
>  
> +static inline void virtblk_vbr_set_err_status_upon_len_err(struct virtblk_req *vbr,
> +		struct request *req, unsigned int len)
> +{
> +	unsigned int expected_len = vbr->in_hdr_len;
> +
> +	if (rq_dma_dir(req) == DMA_FROM_DEVICE)
> +		expected_len += blk_rq_payload_bytes(req);
> +
> +	if (unlikely(len < expected_len)) {
> +		u8 *status_ptr = (u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1;
> +		*status_ptr = VIRTIO_BLK_S_IOERR;
> +	}
> +}
> +
>  static inline void virtblk_request_done(struct request *req)
>  {
>  	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> @@ -362,6 +376,9 @@ static void virtblk_done(struct virtqueue *vq)
>  		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
>  			struct request *req = blk_mq_rq_from_pdu(vbr);
>  
> +			/* Check device writable portion length, and fail upon error */
> +			virtblk_vbr_set_err_status_upon_len_err(vbr, req, len);
> +
>  			if (likely(!blk_should_fake_timeout(req->q)))
>  				blk_mq_complete_request(req);
>  			req_done = true;
> @@ -1208,6 +1225,9 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
>  		struct request *req = blk_mq_rq_from_pdu(vbr);
>  
> +		/* Check device writable portion length, and fail upon error */
> +		virtblk_vbr_set_err_status_upon_len_err(vbr, req, len);
> +
>  		found++;
>  		if (!blk_mq_complete_request_remote(req) &&
>  		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
> -- 
> 2.18.1

