Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABAA19D8A8
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 12:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852381; cv=none; b=es5frgIYfaZ7kujXaoloH9XqB0fvHrCKSD/B/wgcKhrNmKwqgrq7wJWntD6gxNW1g0byhF1KiFO5/jc/vdjZJoFzZaI6LJeaOf2D7AN0l+BfNU/ivlZQgwdrXj60aw8Y6OiRwG6lwYGKwtOrX31CN5ecdl1JPQmKUMJTRnCF7cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852381; c=relaxed/simple;
	bh=k2d6AKIbxjDNvI+iSHhx9EKEQwXZyEmjVW0faFK8DDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E42w801nO0XafHNi6cD8Oa6lO14rAo97VD9hb1QbDalEk5yfX5pGEv+H2CFmgK6xPLC42Gm7onCQ3eXSCyC9OLFhRjY69aqrOTjRUpA10XHn16ZEw8jAMIIaOkiFZe/j7IZwq02H/K3bP+MlbR0egoKkZdVarFjMowECX7UYNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FNSQV8/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNSQV8/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764852377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CeTXlItwEjkfILL3F/GDxGRgx6cCYk34DZi75wL0heE=;
	b=FNSQV8/X1OGjMC52XOhLrTjNDJY1E2ZNMcQY8gNtjY70lEY9IBPDhVJJC5FeZNMaRbAGFu
	lc7gobhdHi5StKhIkPj4FCpsXtilXWphLNUeXgPxs9bKvHk+GBy0h+vkWCxTe8FiR1Aai2
	5o93i2JWz0D8wchT3cNAO7gGW/wbZ+Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-Jp19Ql9-OCK_8TzWRnfvMA-1; Thu, 04 Dec 2025 07:46:16 -0500
X-MC-Unique: Jp19Ql9-OCK_8TzWRnfvMA-1
X-Mimecast-MFC-AGG-ID: Jp19Ql9-OCK_8TzWRnfvMA_1764852376
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so4780775e9.3
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 04:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764852375; x=1765457175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeTXlItwEjkfILL3F/GDxGRgx6cCYk34DZi75wL0heE=;
        b=Lq2CvFeNHPsNPCCqdL7dt/XLD6wrc/Q+/fjGCE3lib8mHZ7lESCzVuM0g/UdqA864d
         Ei+o4RBMu46PQSVgG7MZf2mI+GQrtV4GunQopqymB9Qt7njWNOmKN1z28mYG9jtnJIyr
         Ulszh9ZgnbcMHswoCGwTSMLicVodAgwCW1kyA6AK3JVif1MjhYsZn/LWPHoGCor4GkQ0
         KJ4Jc3tGN2zXhFJyz4KzV/EnA3lo4vzWKmqddN/j7VgIQQjHAsUSh9JWwAS8DkXy+aTh
         pUnaA+/Ku/TRzMJxF5QCLMa+Sb58mSimdXNBbQkcV73udquAX0Z/8atxSe4xU6T548nP
         wbhA==
X-Forwarded-Encrypted: i=1; AJvYcCUm1LGeJ9ZOcBeoxGRlyMOiL8s7ldkSYt0odcY7H0Qz+FfGZ+LGrRCr4KjSNKr7WSZEczUF72RMVYq2m7ooBg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvtQgdVRHYlMmUibTyxV7RyXz2LTWEHUrZDYWRW/NZ8sOLGcEN
	tmtFL5rLaEdraEExLKBmrWbKeTeek1TtZD4uZND65RaDD4R5v3Ej7RI5OYXNfKZuqW0TCjGMj4w
	g+I9/YObQOjOGoV763Mpr7TfXYZ/S6EmVmnd3JYzNBcHt268F179OinhDyDl0t85TNRGy
X-Gm-Gg: ASbGncu3qfMS16QZvU18hlDkbQzP/L8nsxc2DYiBZRtygt0BlJq2w/SASYfAvrmuMFr
	DDydNBm8WpJyjU0jRgj0tLuwYHnnmfGHpqomHjT7v9BH0lInJTlX4vEsQHRF/hfe+3OdZNY7hwb
	F3B11pEQOHvcvSSFVD/8tCshdjggz3qaN1ktnP3jShMU8XaYdX5IUZDN4ReRWcRsWuCfy2+iIa+
	tGrqGp930tPk6c0+4krrwq3Diyolf9KKumJ/X+ugmicQ55MB/JgD0rIyeBYunLq2PbL34XOAEOZ
	m8LTrsQ3BrqxjeWLrFnCg8SnFotswT7p4dknpielM1rDx0HDoqkgU+/k/iUKt6pEWRkjN/p09ul
	+1KRbOuYv5FN4O20C+iymsmgWGM+arM4nzA==
X-Received: by 2002:a05:600c:548a:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-4792f39cb06mr27308905e9.33.1764852375510;
        Thu, 04 Dec 2025 04:46:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeqahDkXcX70vDduTq7HLlftnPzdScbCOHAGJylBXRuVjbzCCIVcrHwCKumENhm/jymdPb+A==
X-Received: by 2002:a05:600c:548a:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-4792f39cb06mr27308625e9.33.1764852375047;
        Thu, 04 Dec 2025 04:46:15 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b1522e6sm37484525e9.13.2025.12.04.04.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 04:46:14 -0800 (PST)
Date: Thu, 4 Dec 2025 07:46:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gonglei <arei.gonglei@huawei.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] crypto: virtio: Add req_data with structure
 virtio_crypto_sym_request
Message-ID: <20251204074310-mutt-send-email-mst@kernel.org>
References: <20251204112227.2659404-1-maobibo@loongson.cn>
 <20251204112227.2659404-7-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251204112227.2659404-7-maobibo@loongson.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JR8kHfVBJAyKA1_Qdxr2g5Tzx_eNoVby8pMytc8hF5s_1764852376
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2025 at 07:22:23PM +0800, Bibo Mao wrote:
> With normal encrypt/decrypt workflow, req_data with struct type
> virtio_crypto_op_data_req will be allocated. Here put req_data in
> virtio_crypto_sym_request, it is pre-allocated when encrypt/decrypt
> interface is called.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/crypto/virtio/virtio_crypto_core.c          |  3 ++-
>  drivers/crypto/virtio/virtio_crypto_skcipher_algs.c | 12 +++---------
>  2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> index ccc6b5c1b24b..e60ad1d94e7f 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -17,7 +17,8 @@ void
>  virtcrypto_clear_request(struct virtio_crypto_request *vc_req)
>  {
>  	if (vc_req) {
> -		kfree_sensitive(vc_req->req_data);
> +		if (vc_req->req_data)
> +			kfree_sensitive(vc_req->req_data);

kfree of NULL is a nop, why make this change?

>  		kfree(vc_req->sgs);
>  	}
>  }
> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index 7b3f21a40d78..a7c7c726e6d9 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -26,6 +26,7 @@ struct virtio_crypto_skcipher_ctx {
>  
>  struct virtio_crypto_sym_request {
>  	struct virtio_crypto_request base;
> +	struct virtio_crypto_op_data_req req_data;
>  
>  	/* Cipher or aead */
>  	uint32_t type;
> @@ -350,14 +351,8 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
>  	if (!sgs)
>  		return -ENOMEM;
>  
> -	req_data = kzalloc_node(sizeof(*req_data), GFP_KERNEL,
> -				dev_to_node(&vcrypto->vdev->dev));
> -	if (!req_data) {
> -		kfree(sgs);
> -		return -ENOMEM;
> -	}
> -
> -	vc_req->req_data = req_data;
> +	req_data = &vc_sym_req->req_data;
> +	vc_req->req_data = NULL;
>  	vc_sym_req->type = VIRTIO_CRYPTO_SYM_OP_CIPHER;
>  	/* Head of operation */
>  	if (vc_sym_req->encrypt) {
> @@ -450,7 +445,6 @@ __virtio_crypto_skcipher_do_req(struct virtio_crypto_sym_request *vc_sym_req,
>  free_iv:
>  	kfree_sensitive(iv);
>  free:
> -	kfree_sensitive(req_data);


So the request is no longer erased with memset on error. Is that not
a problem?

>  	kfree(sgs);
>  	return err;
>  }
> -- 
> 2.39.3

