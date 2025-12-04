Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E730EF92
	for <virtualization@lists.linux.dev>; Thu,  4 Dec 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764848604; cv=none; b=O955IpKce6cDhDpie2La2LH9CfbonLBA9WGL0XAd0Zuc7QrOaVDFd1yKk+CspmZLFI9gXLuxR6/uzcbRLd3T7jMvLOhZhKP+nhc48ndhxIpl6vdIq6BvxttFv1jKEUz05OyFUPHsTZGkEx0asj49nN41HYoY6y2V8uE3d3kNpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764848604; c=relaxed/simple;
	bh=pszKLqYMch9EXWk7hqcO0ilc+Iju7C6OS56hjaodHf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PKmGNhWII+/OXp/n0Q0t0S4Vz7eHzre6ZaD/9EX1l7V2p0eG4xaLRcpESMoPPG8OTHIbng+INr6NVtAIKGzuUxATeLHy2BkTUZdH3MTY5hcDLhSDYL4owomts3N0dQrFKi7tEoQEe71ELWOQu13ePCcvcEuLMDeuJERhzYJLkeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=filccGiF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="filccGiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764848601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2EFMX5ToBprEEJfI3u29l+Jc6cpS50lo6R0NjDBv3jw=;
	b=filccGiFY41NYhyrxMzbt2eYbs5zJpzN063DPgIjkvxwPOhLnJSQ8IF2ZznM0XKrLCrKUZ
	Gf29DEwByUMcf2pOsc7o7AJsCmkcZNKukinjqCboo+Ctb5FcPQFvAXjiBgeUvrg13k1TNi
	KAYuVvTnrgG6UAUCcuYD2r3+/FhkRq0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-uElDMdRxN-GPLKgzt3_fSQ-1; Thu, 04 Dec 2025 06:43:20 -0500
X-MC-Unique: uElDMdRxN-GPLKgzt3_fSQ-1
X-Mimecast-MFC-AGG-ID: uElDMdRxN-GPLKgzt3_fSQ_1764848599
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso16840695e9.1
        for <virtualization@lists.linux.dev>; Thu, 04 Dec 2025 03:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764848599; x=1765453399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EFMX5ToBprEEJfI3u29l+Jc6cpS50lo6R0NjDBv3jw=;
        b=FscgE5WK7pTgDcc04X/jklmKSmtcFF7wEbp8ye5qmhROgct3AZz2akAAx4xxtY/KDo
         fv0+4OyEwUcISe/F+yP2dGsXx2R5ZcYXBbMEfWbSVw4bRzZeHQSY6RUebpkVhr2nk5Ex
         WCwTXEQod2u8Yvw+f+Zi69mRBkCDQKO8kt1tP9g0P/qvfJbz6qc2eYlwJyGUInl6PwIl
         k4yQUdMFl8YFGo7wWNpWNcFJTc5buv2ohJJBhzz0+3OF4lurkuPXadUbwvCJG50Sy8vg
         bdqTF6O1Zk5PekPmL0em6ukGx1XwuNYrpP7pKE8U6LQ8jYEEPoMkmXSPJu1nrNK7lhqT
         RSLA==
X-Forwarded-Encrypted: i=1; AJvYcCWsEsq643sAdHWbIog5JAQFUzDrGaXW3ITnrWLhPWRaei5sbnrh8xJgxx3AWgRhBsnDPU3F4TPp2TV9ajsVzw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIkQAK/kEHy8Aw01m9lUgZx7Dh/2MpXVe7vasVoqtw9grOFibU
	/rR8PjhSM64EDJNaw9ohG8XuFPqW9X68IBKCPBZWzjHronI6B4gmIqP7vjNU29wEvcusZg0hMhf
	uieBbmure+/A6rJ8nvuvkQ3rzSVVPtBZ2WRUTKcJCtzYV9AGQ0gP+s/fC9Zg/0vN0Ey9P
X-Gm-Gg: ASbGncuAzYIt6yVrJ2tGMUdh3Y5IYEsnam+2Jp8NPZO9K21vB/Y+SQ3TVEo21VDOgH+
	vVwQ+tb7J2GL55lYFZ24CVqUB92/TjvUkNOo22l3fPZNVSgeBxb8pB5uDXa8HqTTdH9dJO/jQEK
	Qix2WSFg0LQwp/mDsDzBokohJto9xSo8QMEzqWKe4ooXpNUdG7TECdx+3WHbCUU9XaL0w8bNSO5
	+suYXo/ZjP3m/gBujiIrRBaBueqKbzMnpV+Lkd2y9BSfSrMUmvqGm3tXtokvbeQ7oLcCoDmCgLP
	BbTmOIPM9Sl+stqTwQZztmqzPGGDL/k7DM9UId/rV0CS/UGOR9/aYwsRKGJOKlMKbwAqZ7X2fY8
	85JVAkN0M1TWsoRNsKPiP+bn6xqrkReb8Og==
X-Received: by 2002:a05:600c:5683:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-4792eb5d6bbmr19075725e9.10.1764848599346;
        Thu, 04 Dec 2025 03:43:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHIXX2959hjdYQ9fcDZ2zE6c//85R4NGcAv8WZunwk4afsGqi+eLHn8tuXLqs0cxhWVgNWIw==
X-Received: by 2002:a05:600c:5683:b0:475:dadd:c474 with SMTP id 5b1f17b1804b1-4792eb5d6bbmr19075435e9.10.1764848598837;
        Thu, 04 Dec 2025 03:43:18 -0800 (PST)
Received: from redhat.com (IGLD-80-230-38-228.inter.net.il. [80.230.38.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm24272535e9.13.2025.12.04.03.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 03:43:18 -0800 (PST)
Date: Thu, 4 Dec 2025 06:43:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Gonglei <arei.gonglei@huawei.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] crypto: virtio: Add ecb aes algo support
Message-ID: <20251204064220-mutt-send-email-mst@kernel.org>
References: <20250701030842.1136519-1-maobibo@loongson.cn=20251204112227.2659404-1-maobibo@loongson.cn>
 <20251204112612.2659650-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251204112612.2659650-1-maobibo@loongson.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: deDIzaaYI82ygf1gHMiSkc_XJVG9J4Wicz8LtyzOr1Y_1764848599
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 04, 2025 at 07:26:11PM +0800, Bibo Mao wrote:
> ECB AES also is added here, its ivsize is zero and name is different
> compared with CBC AES algo.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>

you did not post the cover letter, so the mail thread is malformed.

> ---
>  .../virtio/virtio_crypto_skcipher_algs.c      | 74 +++++++++++++------
>  1 file changed, 50 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index b4b79121c37c..9b4ba6a6b9cf 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -559,31 +559,57 @@ static void virtio_crypto_skcipher_finalize_req(
>  					   req, err);
>  }
>  
> -static struct virtio_crypto_algo virtio_crypto_algs[] = { {
> -	.algonum = VIRTIO_CRYPTO_CIPHER_AES_CBC,
> -	.service = VIRTIO_CRYPTO_SERVICE_CIPHER,
> -	.algo.base = {
> -		.base.cra_name		= "cbc(aes)",
> -		.base.cra_driver_name	= "virtio_crypto_aes_cbc",
> -		.base.cra_priority	= 150,
> -		.base.cra_flags		= CRYPTO_ALG_ASYNC |
> -					  CRYPTO_ALG_ALLOCATES_MEMORY,
> -		.base.cra_blocksize	= AES_BLOCK_SIZE,
> -		.base.cra_ctxsize	= sizeof(struct virtio_crypto_skcipher_ctx),
> -		.base.cra_module	= THIS_MODULE,
> -		.init			= virtio_crypto_skcipher_init,
> -		.exit			= virtio_crypto_skcipher_exit,
> -		.setkey			= virtio_crypto_skcipher_setkey,
> -		.decrypt		= virtio_crypto_skcipher_decrypt,
> -		.encrypt		= virtio_crypto_skcipher_encrypt,
> -		.min_keysize		= AES_MIN_KEY_SIZE,
> -		.max_keysize		= AES_MAX_KEY_SIZE,
> -		.ivsize			= AES_BLOCK_SIZE,
> +static struct virtio_crypto_algo virtio_crypto_algs[] = {
> +	{
> +		.algonum = VIRTIO_CRYPTO_CIPHER_AES_CBC,
> +		.service = VIRTIO_CRYPTO_SERVICE_CIPHER,
> +		.algo.base = {
> +			.base.cra_name		= "cbc(aes)",
> +			.base.cra_driver_name	= "virtio_crypto_aes_cbc",
> +			.base.cra_priority	= 150,
> +			.base.cra_flags		= CRYPTO_ALG_ASYNC |
> +				CRYPTO_ALG_ALLOCATES_MEMORY,
> +			.base.cra_blocksize	= AES_BLOCK_SIZE,
> +			.base.cra_ctxsize	= sizeof(struct virtio_crypto_skcipher_ctx),
> +			.base.cra_module	= THIS_MODULE,
> +			.init			= virtio_crypto_skcipher_init,
> +			.exit			= virtio_crypto_skcipher_exit,
> +			.setkey			= virtio_crypto_skcipher_setkey,
> +			.decrypt		= virtio_crypto_skcipher_decrypt,
> +			.encrypt		= virtio_crypto_skcipher_encrypt,
> +			.min_keysize		= AES_MIN_KEY_SIZE,
> +			.max_keysize		= AES_MAX_KEY_SIZE,
> +			.ivsize			= AES_BLOCK_SIZE,
> +		},
> +		.algo.op = {
> +			.do_one_request = virtio_crypto_skcipher_crypt_req,
> +		},
>  	},
> -	.algo.op = {
> -		.do_one_request = virtio_crypto_skcipher_crypt_req,
> -	},
> -} };
> +	{
> +		.algonum = VIRTIO_CRYPTO_CIPHER_AES_ECB,
> +		.service = VIRTIO_CRYPTO_SERVICE_CIPHER,
> +		.algo.base = {
> +			.base.cra_name		= "ecb(aes)",
> +			.base.cra_driver_name	= "virtio_crypto_aes_ecb",
> +			.base.cra_priority	= 150,
> +			.base.cra_flags		= CRYPTO_ALG_ASYNC |
> +				CRYPTO_ALG_ALLOCATES_MEMORY,
> +			.base.cra_blocksize	= AES_BLOCK_SIZE,
> +			.base.cra_ctxsize	= sizeof(struct virtio_crypto_skcipher_ctx),
> +			.base.cra_module	= THIS_MODULE,
> +			.init			= virtio_crypto_skcipher_init,
> +			.exit			= virtio_crypto_skcipher_exit,
> +			.setkey			= virtio_crypto_skcipher_setkey,
> +			.decrypt		= virtio_crypto_skcipher_decrypt,
> +			.encrypt		= virtio_crypto_skcipher_encrypt,
> +			.min_keysize		= AES_MIN_KEY_SIZE,
> +			.max_keysize		= AES_MAX_KEY_SIZE,
> +		},
> +		.algo.op = {
> +			.do_one_request = virtio_crypto_skcipher_crypt_req,
> +		},
> +	}
> +};
>  
>  int virtio_crypto_skcipher_algs_register(struct virtio_crypto *vcrypto)
>  {
> -- 
> 2.39.3

