Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9D2DEA87
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852492; cv=none; b=gQav22r5AeY/l+M/eoZkZHjgoo7VfRZhf3SNl0mzuZFykv+EBZQoHOTY4E70q3vC9c5jMw3Ycylf/Vf+VZyGkdoksdO/WeixIHyq3RSBlrW/zp4ymJZWyNHoF6CCIohhZNdQ5F4fwDFWIOHns4uHxLsA7e+z6NlHJ9G+gihPLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852492; c=relaxed/simple;
	bh=B0hEugrCXqGGN4ALbIJPeG3+AtscP9Y0qNOYxWjUgkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KJ1jhUHlFBkNCYOAq3Slh2zo5V1VaqfR8Y1oZ6+zcAQFKaHR2k5PN9N+Ush9lBqcfBZT3wVxro29+aMVeaAaw8ebhqpCTZ+wqvyaJ7XIJ1/nnMR3sVqmEjurVJvQ5geGSjWf5l8DSATpJeDzSzOdaj5DulpNLiXqt6/cGgc6Vyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dz0E5ayc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dz0E5ayc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764852490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pX7y99mmj0giZ9y5FDPCfhmCiPPHpiTX9nP/IatHpZ4=;
	b=Dz0E5ayc/8aIVg0AI9ED4nI7LLudQs5IKEZDLfb37Rj36DAXrCbB1EpnLZ1exn6O8Gf7XJ
	Z/evEH4llEgGY4PSR5RAkOS1y5DAJsP33bp0l/3MO08LK90soPCK7Jb7deAXP5OYHEVqKU
	o78M7D40MJICcny46Pn43UmYJj0FyUE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-rlrBCeUeMFW6uM7kxDMSnw-1; Thu, 04 Dec 2025 07:48:09 -0500
X-MC-Unique: rlrBCeUeMFW6uM7kxDMSnw-1
X-Mimecast-MFC-AGG-ID: rlrBCeUeMFW6uM7kxDMSnw_1764852488
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477771366cbso6072735e9.0
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 04:48:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764852488; x=1765457288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX7y99mmj0giZ9y5FDPCfhmCiPPHpiTX9nP/IatHpZ4=;
        b=vCrD4z0uKKynAwjHyqCCW9IteEkp2/zFI73/Onm4cnilxSjJuAfJ8Lp/hD08+rYIWw
         cpFcK61kH7ZtXfRS78mrYsAZjP8UGxNcDYFo30caEhXEMqZSOTxvFQsen3oYH+ML7fLl
         mIfBMf2xmSBCtIH7sj5225kZnuj6vQmcDjQoVs8psTmLo+4nXv5Jgvsjd4lXjYD0FXyr
         RR8UYEFM9RcHSlI6gUzvgSyjvwVJ7zHxSStBPNHOVi1NYlRnFjMGY6PAHNSodgCS62gv
         TpEPkLEpVDrQ2hQjGJtr7txIxr348uktx2vh5UEBI39jbHeXiVDkddR8d8nt2DHMCm8W
         mbYA==
X-Forwarded-Encrypted: i=1; AJvYcCVz/sY3/cvA0jXiuJUbQd3f89oum8RhbDzNFbEg4J6k/hnaGuyqfP2ityQ774oEjwxdz3sDQ0ImJ+s60bJe8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5Kxmu7pyp8shyYB3HWO/MwJgsC9//byIQMTcuoa27S9tlFyXg
	0CwOsbkVM0ezXGf3TeZTnAZgAjTX24hWjzz+aBh8o4KUlqRKWKqwyy+kjL6OL3CB9aN5K1LHTjc
	fVpUhCLG+roqDrQiaFBd/HU2xvUf129W6c/zxDefftDGPB4HJeNp5K1NCsMMiOsIHK8BH
X-Gm-Gg: ASbGncs4sbdEi1J1CVdtlQmYIefXqWfsPdGCi7w3jruV0NjNFqskF4TXczmmxcRi9cw
	/F1mP7e2osbrqf0jpAKjVvX5FYZtcgcuRYGyGuQHoFReZmJ7zr7s0FGH9iBCWUuZw5m1vus5ifq
	V5YYfEXRUpqJHsMpaUxXW2YOK/6kBCcF93zVy8ikExsLQ1Lze5nSDzvEgXXaxycZhUrKUGwcpTJ
	4nwoRgp2zlGhWVj26f8WhG7Crc3gN4oRWo+TRCRPKggJbxpb43nDIAGJnheXLCv4O2GQoaRyH/m
	2jV2PLDVrP3nfkbdEqswoctwOIwnfv52kt3Ka2LUp9HSnVJFyCtRPCM64+vmgoI9Qo4txzSnZiM
	uR56gLP6M+sVCYZjt5gANcU2ue/F7cIG63Q==
X-Received: by 2002:a05:600c:1f0d:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-4792aef32d7mr60372135e9.12.1764852487638;
        Thu, 04 Dec 2025 04:48:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbNFqgJDX5+7XQi3p9LS6ZXlKNMGmlWKhpbg0dum6lKVbLtjuX2TB10rq5OVbED8RR0dMGsw==
X-Received: by 2002:a05:600c:1f0d:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-4792aef32d7mr60371715e9.12.1764852487110;
        Thu, 04 Dec 2025 04:48:07 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b178959sm43289225e9.8.2025.12.04.04.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 04:48:06 -0800 (PST)
Date: Thu, 4 Dec 2025 07:48:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gonglei <arei.gonglei@huawei.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/9] crypto: virtio: Add IV buffer in structure
 virtio_crypto_sym_request
Message-ID: <20251204074712-mutt-send-email-mst@kernel.org>
References: <20250701030842.1136519-1-maobibo@loongson.cn=20251204112227.2659404-1-maobibo@loongson.cn>
 <20251204112502.2659544-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251204112502.2659544-1-maobibo@loongson.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jk9xeOBCZiVBkxbtmfmx0qbIUP0simGLzsHwOyfgQ_Y_1764852488
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2025 at 07:25:02PM +0800, Bibo Mao wrote:
> Add IV buffer in structure virtio_crypto_sym_request to avoid unnecessary
> IV buffer allocation in encrypt/decrypt process. And IV buffer is cleared
> when encrypt/decrypt is finished.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  .../virtio/virtio_crypto_skcipher_algs.c      | 20 +++++++------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index a7c7c726e6d9..c911b7ba8f13 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -30,9 +30,9 @@ struct virtio_crypto_sym_request {
>  
>  	/* Cipher or aead */
>  	uint32_t type;
> -	uint8_t *iv;
>  	/* Encryption? */
>  	bool encrypt;
> +	uint8_t iv[0];
>  };
>  
>  struct virtio_crypto_algo {
> @@ -402,12 +402,7 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
>  	 * Avoid to do DMA from the stack, switch to using
>  	 * dynamically-allocated for the IV
>  	 */
> -	iv = kzalloc_node(ivsize, GFP_ATOMIC,
> -				dev_to_node(&vcrypto->vdev->dev));
> -	if (!iv) {
> -		err = -ENOMEM;
> -		goto free;
> -	}
> +	iv = vc_sym_req->iv;
>  	memcpy(iv, req->iv, ivsize);
>  	if (!vc_sym_req->encrypt)
>  		scatterwalk_map_and_copy(req->iv, req->src,
> @@ -416,7 +411,6 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
>  
>  	sg_init_one(&iv_sg, iv, ivsize);
>  	sgs[num_out++] = &iv_sg;
> -	vc_sym_req->iv = iv;
>  
>  	/* Source data */
>  	for (sg = req->src; src_nents; sg = sg_next(sg), src_nents--)
> @@ -438,12 +432,10 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
>  	virtqueue_kick(data_vq->vq);
>  	spin_unlock_irqrestore(&data_vq->lock, flags);
>  	if (unlikely(err < 0))
> -		goto free_iv;
> +		goto free;
>  
>  	return 0;
>  
> -free_iv:
> -	kfree_sensitive(iv);

so iv is no longer cleared on error. problem?

>  free:
>  	kfree(sgs);
>  	return err;
> @@ -501,8 +493,10 @@ static int virtio_crypto_skcipher_init(struct crypto_skcipher *tfm)
>  {
>  	struct virtio_crypto_skcipher_ctx *ctx = crypto_skcipher_ctx(tfm);
>  	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
> +	int size;
>  
> -	crypto_skcipher_set_reqsize(tfm, sizeof(struct virtio_crypto_sym_request));
> +	size = sizeof(struct virtio_crypto_sym_request) + crypto_skcipher_ivsize(tfm);
> +	crypto_skcipher_set_reqsize(tfm, size);
>  	ctx->alg = container_of(alg, struct virtio_crypto_algo, algo.base);
>  
>  	return 0;
> @@ -552,7 +546,7 @@ static void virtio_crypto_skcipher_finalize_req(
>  		scatterwalk_map_and_copy(req->iv, req->dst,
>  					 req->cryptlen - ivsize,
>  					 ivsize, 0);
> -	kfree_sensitive(vc_sym_req->iv);
> +	memzero_explicit(vc_sym_req->iv, ivsize);
>  	virtcrypto_clear_request(&vc_sym_req->base);
>  
>  	crypto_finalize_skcipher_request(vc_sym_req->base.dataq->engine,
> -- 
> 2.39.3

