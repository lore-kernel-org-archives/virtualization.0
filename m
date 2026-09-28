Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C6346FBC
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 06:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576704; cv=none; b=CYlTYkaVexomSA5CYf+AuHA36uNC3TUJgmWm13UUF+xJ//VFuJGiGT7daJqVLEii0faGIiY0Bjk/9b0X3IwEiJg3Ps9I0vSd1MgQTtTJdNQrRPvSFG+v2o4f9P2tCBOeLBVU7Iiihk2k81ZvFiMZtYZURUNZzrYQ2cyvdnJhU4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576704; c=relaxed/simple;
	bh=KZb4zjaYKCS4prlQQxqBP05QDUbZxcdOc3sMTeygcKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWnzLwCPkIbwKurUjXEm/MVorOwntSV90Ph70E7kVA5TfmsKxeo5HOQ4DcKsHi7gjATlik1AqhCDPzN3a/o/y+d227uAKYelEuftGPbEcBcBpUj+DcWd9Hy2FQxpZM6egc3QKKM0Tv8KS4cMiKGA9873+uEmCwOt/SfnbPcKbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oz7ml5OX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oz7ml5OX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790576701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H3RYVBRS6lci+skHKVw9nj7+rFhqDojBssvDAah2vNM=;
	b=Oz7ml5OXqvYSHToMfrolh3wm2LMOZXX7dqeNpw9NCnR+C07WNtX9LjJI865x7zUctMym9c
	9Ux87eQO7PUYX3vUdR92xSNfQjAaL0MGa7o5jwwwYqMqgxu2kyfrH51rwntRnytM0kPK4j
	FfQWavaIapa+ilBgrs90YHiBcorTIFg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-PMA3TLHKP7WYUqiXHn58JQ-1; Mon, 28 Sep 2026 02:25:00 -0400
X-MC-Unique: PMA3TLHKP7WYUqiXHn58JQ-1
X-Mimecast-MFC-AGG-ID: PMA3TLHKP7WYUqiXHn58JQ_1790576699
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49fcc575709so26232545e9.3
        for <virtualization@lists.linux.dev>; Sun, 27 Sep 2026 23:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576699; x=1791181499;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H3RYVBRS6lci+skHKVw9nj7+rFhqDojBssvDAah2vNM=;
        b=MHHOqsA9TcyOzYoQD26d7mTgl4NAUqXublgIaMpgUPqQATa4fb+zPpFia9IllL/DUt
         o1WoqtRa4ikpKM/kw4Jvt4r4ztKNN0Ml14QNc9A56azjuZtQeBzppWxZ+1S8E49ihM5n
         4hDKRe25RZGoyancDp+gUuRBAr10vb/XXRLVGaUt1ZRtvosxL6WTAJrfc/QC26S4phOs
         LCrMn5gCQ47rlQQd6Tict9n9aNFxuT9K+zCeqC6xEciPIfGKSWYzByLeW08nMN9u4WWX
         tcv/4rfQuJ3CzzbxAxYPRBCDW0x6tg8heDV9xOn2TF0MA5c5/AMv2oRtk4sn3kEp/1d/
         OA9w==
X-Gm-Message-State: AFuF++mJaf0g/ncFaRVJzM2l/gg37b1Cozcfm7al+6GK7Qo7PWWO9XOv
	2z7XjGeAKhA/C2ZtJ1AdLzGSBdTqd4YY3TSf0JAVnMsJvEAsnQL6nVI0E7+rP+GVObq0BJJKTIn
	lwZZvT61oihlg5yX7NETfTDmPAXBjSWpPDUPVWsdaodPGWl1GnkMM5gfzzQhZ1HZ6teJY
X-Gm-Gg: AYBFou3ErnsSW6A4scnA4GVHgfLn9dhvkJ8GfmXrf7yQe/mrYrV3PQV8QJm+uQwzgWM
	kdBIvh0W+tmAZWJoP+z0ITJPR7naHn9PibMmt2kaZNLggg1mYUaa3+aR+9ne5LOi41b2rbvpu6b
	oBq+Izt0VKthv2AACR5u+5kqTdzkz5HVEKXYnoyC9gKnybL909CVhMET3W83vuIaEsRdGbAW6SZ
	E1yj5EWXvuvtPjQlShWsNe5ob2GSmMGW24/SfuspAkadZsNkwmY04ojnyIuRkn2g931rqyl3IrU
	0W+4+kQjazGuKSyLk0NZdJvGE81wTqmx7Ub3k7osqOpivLhBluwE4bU51Xc1Vd17KvptCvWE
X-Received: by 2002:a05:600c:8484:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-49fe66d8135mr202359745e9.20.1790576697551;
        Sun, 27 Sep 2026 23:24:57 -0700 (PDT)
X-Received: by 2002:a05:600c:8484:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-49fe66d8135mr202359635e9.20.1790576697232;
        Sun, 27 Sep 2026 23:24:57 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178174dsm108202995e9.10.2026.09.27.23.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 23:24:55 -0700 (PDT)
Message-ID: <b2142da1-31e4-4d53-9ae3-c00c8301b0f0@redhat.com>
Date: Mon, 28 Sep 2026 08:24:54 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hwrng: virtio - use snprintf() in probe_common()
To: Thorsten Blum <blum@kernel.org>, Laurent Vivier <lvivier@redhat.com>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: virtualization@lists.linux.dev, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260926055853.4868-3-blum@kernel.org>
 <20260926055853.4868-4-blum@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260926055853.4868-4-blum@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fcVwUxip_aeS7pWOiRAEe-yVJDt6qi805Xubh0Kviu0_1790576699
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2026 07.58, Thorsten Blum wrote:
> While the current code works correctly, replace the unbounded sprintf()
> with the safer snprintf() to follow secure coding best practices.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>   drivers/char/hw_random/virtio-rng.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> index 5b1b23b5596a..f9982217247d 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
> @@ -162,7 +162,7 @@ static int probe_common(struct virtio_device *vdev)
>   		err = index;
>   		goto err_ida;
>   	}
> -	sprintf(vi->name, "virtio_rng.%d", index);
> +	snprintf(vi->name, sizeof(vi->name), "virtio_rng.%d", vi->index);
>   	init_completion(&vi->have_data);
>   
>   	vi->hwrng = (struct hwrng) {

Reviewed-by: Thomas Huth <thuth@redhat.com>

