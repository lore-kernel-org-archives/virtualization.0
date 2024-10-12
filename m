Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBD145B07
	for <virtualization@lists.linux.dev>; Sat, 12 Oct 2024 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728721450; cv=none; b=NuMKwyOHOUGeo6HQ+J+sYueUeSoihsG0BqWRtNhfLsvpsZzr0VNa2nb5xDWxb6l5Tb6AlKsV1U15Y9flEjqgTVWfK3Us1dVxVipTobzVdUJMfOEBDXt/BY3krmnrEPhX5xVDuYCnFZXm7tUFLCXG8QgRqiAsMnAqgVKk0/yk05o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728721450; c=relaxed/simple;
	bh=O1XrseMxKPU3CSygOcpj6EQy4x8ye3XrJ2wkPTMw+Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHtix7CzzoOMkE36LUWikOi9WWBlXj3EReYeRsEBMHshIdAhx0O97dDnABjEB3D97oqH3G7bC08XA5FiWyGzF/Seb/e9tskhQl6p3O13aj2aiYB95u/xZEfRLmAHwkEWrTnNGaveVE5RO4a79847VQFz9H+kjeiPZgFn3qoQV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hH2qZNQb; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hH2qZNQb"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e02249621so2249814b3a.1
        for <virtualization@lists.linux.dev>; Sat, 12 Oct 2024 01:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728721448; x=1729326248; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQ0uJFCIUzT5iNpWEa5laAuFLJ9LFFMlsGAFCSG8b8k=;
        b=hH2qZNQbuQBcNNYt4pEPzxi+JZmiNjkwc7ACCzPneeptegLjFlLJlaxsO6yoqcknfT
         Fm1IyKZUkwboWftEkXwmzdW8Hyq09LVf0Rapldl1P5o5dDNgEcXFA7r7TZY1FD+mNHs9
         /TK+YlwCzto4Uson0sLZvUJ3Y/VE3JJhf7NFDYVrGvv0kXTK3JjH/JpOn1GAlp26GTnz
         DagAl1U7mah8IPDYopY5SBv7sALmoYWHyWE+jZXywaBU3KjOAFYemcI4QHFnpjsEXUcE
         Hk4jnetnbLulldyZENVVNccVAR+Nh3hQo+cYofqAtGiQJd1ex0Uoz0+NpqPvPXh2gvTD
         J3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728721448; x=1729326248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQ0uJFCIUzT5iNpWEa5laAuFLJ9LFFMlsGAFCSG8b8k=;
        b=kpUZpL7gj4IFpbP0AYKrmWCuMTNgl3sE+lu6504Y8ffsFNQHGGoEPTQN+pd4Rprdoo
         cqUl2HHSV7Nss5Iej2UXA4X8OE6lxF6cy3DDC0ro7aGV01XNrn1XyfYtqhxwmaARgzfo
         eZuVOw4uy6BxE46Vj0xzO8EOLHoQUGx5+RJXzzQWbT0XomOi0MAJl8/GO2V0aKN70TcU
         ZEv0ozyINajWmR5hVZSW1ytRVwtTsNyV/9x6qhhQx41AWokLTijsNd2g4ny0G3PWFjoV
         jQUI7r0HpQiQ3Hy/9v5f9xppLN9leSbHi7sc0MRp1jz8mK2rLpYfS3IlYlLatyKuH0eR
         Nr4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFThIjw8geSAR/1/rvNfwSOUUYvJPpP9xs9F6kqqJtX1S7r0eGZwE+p0ef0tZZS8bratmLVu5NNkZ9+GuZZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8jLC37iUvd3hdEayXOgjiZ7onq/T0LaP1iokb1t9G8oReq6P3
	aRju1+Z+RDGbYbIWEsqIuy1FZvbQ9qmd0C+XGUHBx8ZxSwMK+NlJaBkLz9rGcig=
X-Google-Smtp-Source: AGHT+IGIAD2RleNINJaOlV1Ndb7siGou9hMwoYmXRnCufbaqLw2AzkPv1vfWjneW5pepG/UvMddXsg==
X-Received: by 2002:a05:6a21:1304:b0:1d4:e56e:93b5 with SMTP id adf61e73a8af0-1d8c9594fa2mr2733839637.16.1728721447658;
        Sat, 12 Oct 2024 01:24:07 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f6982sm3764098b3a.77.2024.10.12.01.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 01:24:07 -0700 (PDT)
Message-ID: <870327e4-2391-4f42-82ad-2d9593a70ebe@bytedance.com>
Date: Sat, 12 Oct 2024 16:24:01 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: virtio/akcipher - Move a pointer assignment in
 virtio_crypto_rsa_set_key()
To: Markus Elfring <Markus.Elfring@web.de>, Gonglei <arei.gonglei@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-crypto@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Nathan Chancellor
 <nathan@kernel.org>, virtualization@lists.linux.dev,
 lei he <helei.sig11@bytedance.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "David S. Miller" <davem@davemloft.net>
References: <80b91321-138c-41de-95c7-47c3be07fe76@web.de>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <80b91321-138c-41de-95c7-47c3be07fe76@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/12/24 16:06, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 12 Oct 2024 09:51:58 +0200
> 
> Move the reset of the data structure member “n” to a null pointer
> into an if branch so that this assignment will be performed only after
> a key parsing failure.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 48fee07b7e51..56557d4778b0 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -355,7 +355,6 @@ static int virtio_crypto_rsa_set_key(struct crypto_akcipher *tfm,
> 
>   	/* mpi_free will test n, just free it. */
>   	mpi_free(rsa_ctx->n);
> -	rsa_ctx->n = NULL;
> 
>   	if (private) {
>   		keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE;
> @@ -365,8 +364,10 @@ static int virtio_crypto_rsa_set_key(struct crypto_akcipher *tfm,
>   		ret = rsa_parse_pub_key(&rsa_key, key, keylen);
>   	}
> 
> -	if (ret)
> +	if (ret) {
> +		rsa_ctx->n = NULL;
>   		return ret;
> +	}
> 
>   	rsa_ctx->n = mpi_read_raw_data(rsa_key.n, rsa_key.n_sz);
>   	if (!rsa_ctx->n)
> --

Hi,

This change only reduces a single assignment on a key parsing failure, 
however it breaks the original "free a pointer, and set it to NULL".
I prefer the original style.

Lei, what's your opinion?


> 2.46.1
> 

