Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91623F429
	for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476750; cv=none; b=iCBWOr6kZHI9cDkq4D+JJ6HGIvGfo6V90aJRk09zaGqsaGNNlv5R4G7uPTSPYmga1vmSPQiPL1gj9j2ATC3s0QOq+4CfC7A7etLLBsDkLmbMqnTBbjhPgrFNowJw4OqiPNsDZnmMGam63j1U+/9Ejdf/CSj2uZwHYaswnVVijRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476750; c=relaxed/simple;
	bh=WwvQk40Glb4XvOASk1LFtrDjxeGKgX2muBFVQuxVnzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HqsW26DyGi4gJ9vIZOHoGGmpJWSixdijRFQs/tWmGRP5YhHyB6WOEVSfoUOi43ESIEylgYfA2oJmiZOqg8ujaLbl6dj5wXMPd+kGIeA9opWs2zO+WVbF+mzNgu+hpcPhr9WrO4KzlixlasjOAL0Rl3g97Xancu6/cLDhcTWVvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGa33++/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGa33++/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758476747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1OlVkMyWhOP7kDhR7luqdc21LW8/q1ATcp0AWEUEzQ=;
	b=YGa33++/Uim0BYdgNzfrVEPya3/sthEl3LqFl2cT3Pl4StPrsaX4oPeB5YrgMKxHRn4v4i
	+l5uKbQqX/Xsbha+/qcc5uwZRPNF5gE3xNOtTXKP0Begm6w9ViJyB50BJF1kutmb86fyjd
	P+1FP4C98M1bPvjbXHmyGOA38pnYcNc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-pcxkPYlJP8Wy6wqTR_VirQ-1; Sun, 21 Sep 2025 13:45:40 -0400
X-MC-Unique: pcxkPYlJP8Wy6wqTR_VirQ-1
X-Mimecast-MFC-AGG-ID: pcxkPYlJP8Wy6wqTR_VirQ_1758476739
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f29c99f99so22478335e9.1
        for <virtualization@lists.linux.dev>; Sun, 21 Sep 2025 10:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476739; x=1759081539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1OlVkMyWhOP7kDhR7luqdc21LW8/q1ATcp0AWEUEzQ=;
        b=L8yD+ppPX+ACG9z48JnCp1FHfMzMFG8Evx2ZdgoSZ1d0hMJH5KkWn1lYe5YM7/sh4R
         FGR8FA8Fx/2h1MKUOfQSF842r2ldoxu0M4FkeDZkggAzo8CoKRiMp9InXut0heqk+PKv
         sM9+QgGFu82CPM2TmFOHJ3pTJaSV4nyfA7gnsstcZrpniJjQndWtLab4OPkYm1FxVdzw
         a+XXG65A0ic8MDykcv+Wydy7QnXmzkYkQB72RovFZdpphMyHksFNgtzBwByKKp6zzZet
         M2m/QDo+nlpoygl/eBkcMBtvNAuZswSs/SYWGCor4A9PHxZ65Ci3ViMm+nMkzutAXF34
         qfKw==
X-Forwarded-Encrypted: i=1; AJvYcCVILWoaJcC/jBC+gnIPXqo+3ZYEYS1245wqT44N2GnUK9s2jUHb/jieuYHEEKRZLVrBe+m06I8cyXMcN6KW0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVwMb4Vz8SPGp+G4lkhbr8D6nvq11tYTWscwgMItKwH43TEeMs
	pBOb+EIV01ROaFMU+y5/B+2kfapBq70zfkqVrgrsKmPJjkz8P687AzN8kg1ICsLTKMLZ+5/t8/t
	LyFDlrjKxNjWuH6fC+eeeIrCH8C9UQlycmK5NNyuipUuPvyybqx7BOVHjsPlRLUktAQONajd3ct
	aK
X-Gm-Gg: ASbGncsNBfud5Ez/gsxvf9ORuTvAO7TJptr6LuprrTP6U9YKhHB/at4vAtVvTHxgXNE
	yZj0Dm7dLdcMPqgbr/R5fSLLvptiBYWlQzqURV6zYtmoHbDfMyAMOttBl0r129ZnBh0+hYDxqgY
	K8htBpAAkFu9OXtx24FMr9TxHY8gn3cQmnyLcGfE04Wo9FEY46weQhrOwJS8rBlCgDq26HVJgrb
	QFbxeirM/qsSbekxFMSEaaGAa9UJFPXP+z9PdcO6M9LKeoSxhndycRG2wJjsnB1pnRZ/l72A82N
	iZvqKVIrXCyIr4BiSmfsVcJdZQxX80+K/7w=
X-Received: by 2002:a05:600c:4714:b0:45b:615c:cd2 with SMTP id 5b1f17b1804b1-467e6b64fb2mr105330975e9.8.1758476738865;
        Sun, 21 Sep 2025 10:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGX5vkXsKpQyY2Ux5CBEzyb6byASk4h+/Il/pigqdryAM+E6y/7Hj/+4Dr77FNhLif4LWHAg==
X-Received: by 2002:a05:600c:4714:b0:45b:615c:cd2 with SMTP id 5b1f17b1804b1-467e6b64fb2mr105330815e9.8.1758476738249;
        Sun, 21 Sep 2025 10:45:38 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d5c1fc13dsm2586065e9.1.2025.09.21.10.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:45:37 -0700 (PDT)
Date: Sun, 21 Sep 2025 13:45:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 07/19] virtio: switch to use vring_virtqueue for
 virtqueue_add variants
Message-ID: <20250921134504-mutt-send-email-mst@kernel.org>
References: <20250919073154.49278-1-jasowang@redhat.com>
 <20250919073154.49278-8-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250919073154.49278-8-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5_WK52PNSjiJwFRU0Zv4AvjeDWhIwJXvJJCfheNbi64_1758476739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Sep 19, 2025 at 03:31:42PM +0800, Jason Wang wrote:
> Those variants are used internally so let's switch to use
> vring_virtqueue as parameter to be consistent with other internal
> virtqueue helpers.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>


This one actually switches virtqueue_get_buf variants.

Previous one is for virtqueue_add



> ---
>  drivers/virtio/virtio_ring.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 93c36314b5e7..3625c7ed2fbb 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -816,11 +816,10 @@ static bool more_used_split(const struct vring_virtqueue *vq)
>  	return virtqueue_poll_split(vq, vq->last_used_idx);
>  }
>  
> -static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
>  					 unsigned int *len,
>  					 void **ctx)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	void *ret;
>  	unsigned int i;
>  	u16 last_used;
> @@ -842,9 +841,9 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	virtio_rmb(vq->weak_barriers);
>  
>  	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
> -	i = virtio32_to_cpu(_vq->vdev,
> +	i = virtio32_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->ring[last_used].id);
> -	*len = virtio32_to_cpu(_vq->vdev,
> +	*len = virtio32_to_cpu(vq->vq.vdev,
>  			vq->split.vring.used->ring[last_used].len);
>  
>  	if (unlikely(i >= vq->split.vring.num)) {
> @@ -866,7 +865,7 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
>  		virtio_store_mb(vq->weak_barriers,
>  				&vring_used_event(&vq->split.vring),
> -				cpu_to_virtio16(_vq->vdev, vq->last_used_idx));
> +				cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx));
>  
>  	LAST_ADD_TIME_INVALID(vq);
>  
> @@ -1720,11 +1719,10 @@ static bool more_used_packed(const struct vring_virtqueue *vq)
>  	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
>  }
>  
> -static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
> +static void *virtqueue_get_buf_ctx_packed(struct vring_virtqueue *vq,
>  					  unsigned int *len,
>  					  void **ctx)
>  {
> -	struct vring_virtqueue *vq = to_vvq(_vq);
>  	u16 last_used, id, last_used_idx;
>  	bool used_wrap_counter;
>  	void *ret;
> @@ -2524,8 +2522,8 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, unsigned int *len,
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> -	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(_vq, len, ctx) :
> -				 virtqueue_get_buf_ctx_split(_vq, len, ctx);
> +	return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ctx) :
> +				 virtqueue_get_buf_ctx_split(vq, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>  
> -- 
> 2.31.1

