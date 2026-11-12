Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794523841;
	b=LgrNkxTXegbbdC7fcA4p2w+0wM9XHy5GxL9g5yVYPbR9fqHTP7OMWjtufZFmSND65Y/A
	 J9gdebkJlaVye/8MSg/RdlODi2M8htdufuqk93zSNmXxLqaLIfODLkmoqSmDifBOK+ZIx
	 qU6StBhMBKlW19oc057/hNjosCCcMrWMeW7yMiOrhKVgx5YBqfkcxuT5bIYmCk3kF6pSW
	 y+tXfLt14rnk/0ZfRw7zbyGqMXBqGVgAF3avMAoAoeB/3lfvNlN8yEuBb9whfvKXd2VKg
	 Z1x1Saqj8aItRe/j6S2spTuK8d26lbjjLqTEEdlGdrqIn4TaluJPGIIdwvAn0X1SUqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794523841;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Bbe/QF3Vlv0xyp1ygk/EdM2oUtmqFKixGf2vCzmUwiY=;
	b=U784bUO/L4J52HiJQAkfzUNPyCxwCwGbbvtjZ1gw+s2hLkLnIp8PDtw0Cfl65ZbHjP8c
	 d9DsT08K64cqnTgPR30nMwUKYa0UgZz4jzKYJAA6yjujAs1x9zhqUbBOhovG8l8N34IzK
	 3QaZYHW1Yisl7AfUUa+aUkFe+6WGmoiXIS+lIX37KCSvjIY8J0o30rqNuqio5G+0ciEFL
	 tEGEHTb4ccFgd56pgKSwnH7Ima6TK0m2EzFeeIgZzIvFX7nXzuimyXd3VE9CTEFcHPr1T
	 LuUKSmfsvjNtjUMUr1pAAaUXKiWLQl1AIHi7OdYnP2GxXdgRY56BpKM+MCp4EZZVi5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UYXVVPL8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CA606A32E
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 22:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 182CA606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UYXVVPL8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794523840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bbe/QF3Vlv0xyp1ygk/EdM2oUtmqFKixGf2vCzmUwiY=;
	b=UYXVVPL8BiO5MyO8rDI6+r/V/LlAt+x4U0TElgGn9dhvuAWpS24H8Mcs+642XVWN/eFzI/
	v33dzw+cUk9YNnQkkdR2yBPOvApMHhSVp9o0apMT2ZpaOPzoEuHDC6ODm4+XIJTHHgzPTy
	VPqQtQPrBAyhLsaUTBBJ3G3yt0CKH6M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-S244n5PNPDGwimlUDq4gpg-1; Thu, 12 Nov 2026 17:50:38 -0500
X-MC-Unique: S244n5PNPDGwimlUDq4gpg-1
X-Mimecast-MFC-AGG-ID: S244n5PNPDGwimlUDq4gpg_1794523837
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4b0a307487aso1085915e9.1
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 14:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794523837; x=1795128637;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bbe/QF3Vlv0xyp1ygk/EdM2oUtmqFKixGf2vCzmUwiY=;
        b=y61+Vc0JlUUdi9zMvwbjkBPZNXjOrNZwz7PU8iS1QGTbQ+k33KcYbzA4m9wpol4Fp+
         Qj/KYrV+kFjjhlY8Ta7dv4t3hMKqitHlrt1WlLTvGbrkopLIQzwYruo16rNhRsguC0bT
         I1XJQg+fqOwwwFesnYGKJXnjvaoXeQtHbH3DMW1kkL5DVm/xySYQ3OONsSQ2eDEx/DJM
         yZYVFZP2Z5hnDB2K8pygF6+V1DpCeoNaVMJAFSRdxkFBPTbz7uewfteCkrwKH1e4ksOC
         U2VpVtrL0/D2c3OGv3UPxCDjJCkrIskOIB+kEXsvnmZqJBt12rGYabxquIyZIodyOk2I
         Y/mg==
X-Forwarded-Encrypted: i=1; AL+hErEvD3V4/83k/e3w9cTPxcatfmxebM2cfd3wx/57opz8HEiSslscM8Ktc752zKyTi/1ACJSP9K29yOLRL5v0ZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8DnssbyJN5JUJKUfVU/6g3Og2T/DVLLmFhq7IJk4/S1q8GDg70
	8fvQstIdn8sFUGDS8qXs5pqyvtLl5KZctwDg57LJbdL+t4zjvegpS/OfuX25uRJCa357+fZjrN8
	f8UbxBDIKwifNGNm2CqSCis5eZlTQFNbS8UsjcVEGRfYYP5Fp3a8314iRRFh/uM2FkXxF9Bc8Jm
	m+
X-Gm-Gg: AYBFou3N63LcPKY59CBq5BdnXodK/HVxsaNWg/a8VYb4zgNcucn+csGU1V1CWlwtvoS
	adaicBgs3TK3jaBHQZBf5f/BjDUtLIQ43wUsGp08ajtQdzdZ3RbbPsfSBQfSRnYjlYePswzJlKj
	z3BEqw0Y24YH06MZMCZl2lfKEeeZsUkcG4NmDLM+CrU9NbqtDZ6/YNvMAT/KtaVL2vKRGNc0ghW
	fdcscTLE7mztzfSz+rlkNQscG+h1MnAONDXFQFdocJO+1KEBjjyuPY6PaZ1m3k56VV9XmdODeE0
	GqqCcBNAWSQDzDiYjEgdU6GAGL5P2LvOGyIppf9C2e9GTcHKKGOl+tEdXHUf0rzCPl6O9qjWOHE
	fwELGRdlakQW3WYd9e6X/uqLU/QJGONmjxBDmUhWP0w==
X-Received: by 2002:a05:600c:310e:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4bb55a5212fmr12640235e9.17.1794523837312;
        Thu, 12 Nov 2026 14:50:37 -0800 (PST)
X-Received: by 2002:a05:600c:310e:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4bb55a5212fmr12639975e9.17.1794523836829;
        Thu, 12 Nov 2026 14:50:36 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55ac1159sm12604485e9.4.2026.11.12.14.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:50:35 -0800 (PST)
Date: Thu, 12 Nov 2026 17:50:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, eperezma@redhat.com, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, tanglongjun@kylinos.cn
Subject: Re: [PATCH 1/3] virtio: add virtqueue_get_last_used_idx() helper
Message-ID: <20261112174936-mutt-send-email-mst@kernel.org>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-2-lange_tang@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261109094310.103979-2-lange_tang@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s5DN_BDB_Y6r8lBsSWJ8--BnL53hSYsx3SeY_wBdHoo_1794523837
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 09, 2026 at 05:43:08PM +0800, Longjun Tang wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> Export a read-only accessor for the last consumed used ring index.
> It's useful for drivers that need to detect whether the device has
> produced buffers that have not been consumed yet, by passing the
> returned value to virtqueue_poll().
> 
> The split ring now writes the field with WRITE_ONCE() (the packed
> ring already did) to document that the new reader can run concurrently
> with the poll path.
> 
> Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>

This is not a good API, packed ring does not have a used ring at all.

> ---
>  drivers/virtio/virtio_ring.c | 18 ++++++++++++++++--
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index db678f5a80e0..6d8485c73881 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1001,7 +1001,7 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
>  	detach_buf_split(vq, i, ctx);
> -	vq->last_used_idx++;
> +	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> @@ -1068,7 +1068,7 @@ static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
>  	ret = vq->split.desc_state[last_used].data;
>  	detach_buf_split_in_order(vq, last_used, ctx);
>  
> -	vq->last_used_idx++;
> +	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
>  	vq->last_used += (vq->vq.num_free - num_free);
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
> @@ -3227,6 +3227,20 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>  
> +/**
> + * virtqueue_get_last_used_idx - get the last consumed used ring index
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Returns the index of the most recently consumed used buffer.
> + */
> +unsigned int virtqueue_get_last_used_idx(const struct virtqueue *_vq)
> +{
> +	const struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return READ_ONCE(vq->last_used_idx);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_last_used_idx);
> +
>  /**
>   * virtqueue_enable_cb - restart callbacks after disable_cb.
>   * @_vq: the struct virtqueue we're talking about.
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index f923e42cfd01..1aed4d9235c8 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -112,6 +112,8 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
>  
>  bool virtqueue_poll(struct virtqueue *vq, unsigned);
>  
> +unsigned int virtqueue_get_last_used_idx(const struct virtqueue *vq);
> +
>  bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>  
>  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
> -- 
> 2.51.0

