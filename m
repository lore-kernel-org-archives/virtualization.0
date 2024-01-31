Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3685E39AF6
	for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706740623; cv=none; b=eYQN1Hq5lDi8ph/wz93jtd55IREhhe43HKrXvsdMoOVq23XtZC8yZKbC5/MxhWEYSWBrwGA5z+Xod6ppLb5Fd5sZ9Ie4Mx/KmQr1qMgvImulaZw6oHMGIR1BBq8hKXVi00YH32G58ClYidDJBDKThTv8kzajNMCNc6NUAgYeSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706740623; c=relaxed/simple;
	bh=Iu+8D8k16qGF05cFe22hv0MQBwz9+bj5LdTjBKDOWeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XOceOWYnEv3klO76Uo0jgAdhfTgY6kgmkZ88UQJ61SrGiFlT89y9WAUtcMMhNDzviQDDi6/V/PlVMSkr4dqTtZ8YqQ9YOkh1bN12B7FHPTKPiZX5jFQbmC5FKC6V6/dLJcog01SGLEXnODU65BNCIeig82rMuP0OqALKH6H6RgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uj5vFBI/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uj5vFBI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706740620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCoZH7HUiSU0yflw5IfG5DX6qgN8kXKIe4+R5MH+S1U=;
	b=Uj5vFBI/Fh1jzsdMhm0nBKLjDh2wNxLPvgQSW4rfV3+TJscq5O990i6jg+4Kf4A3MNg0++
	TuFrAZICK5zJjXIcnKexNXyQ4MsOwSZFGqY3udjfAx43Q93iOfLVOYssGQJbB/gXEd1fNt
	ZWZEAmczrgP/3gZS5uNQyrECcPbLUrA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-ED4cLUfVNUyNN5X0vceCRA-1; Wed, 31 Jan 2024 17:36:56 -0500
X-MC-Unique: ED4cLUfVNUyNN5X0vceCRA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e9e5c8f49so231956e87.3
        for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 14:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706740615; x=1707345415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCoZH7HUiSU0yflw5IfG5DX6qgN8kXKIe4+R5MH+S1U=;
        b=NaM1KzgcB/cavZmruLzw4WwFmD2GLXOLsFejm83CvNgPeUAZLRmpBIEy6bbYmsFey7
         8c0ilwKwyvFPKjAAW0po+ndDS0+kgblPALvKRXpOnlZGR899F3SwwI9HpOsFzQ3HcQsB
         X8bfMRJ0y6g6qUzeUe07rZO4ri7P4P/Ta14Fe6AuAGDO8Y++XWQ1T3AKi2O3vNx2rsKg
         a0APrFcDFgEi2qPerfLCmAaJ+JxzdD4LwBOsEt+JUCqa5u5Ql8pJ5mkcFjGCphyymMoT
         nNNMJaGuGef0eNdhgrx5FjLPJtG6k2tQPUE/Ijpd5fFc4vC5j10p9KjT16GVO/+lLyON
         668A==
X-Gm-Message-State: AOJu0Yz2oEp8afTbrPZI7x4bijhX++M6HV4ARKOuBjjDjEEDzkPoqmwp
	gKt1culiOB19J/V3MFoW0mQAFvQb6OtNrD7O14QAh04g8sDjBPFFyld93FI3DEJr3iugCNPcS4b
	FUDYMsG6+pCrAuIHts45Jpai1/pl7/i7J4WtxMYsyemHk360IHGXU42AN5osHunRM
X-Received: by 2002:a19:4f42:0:b0:510:11f4:6741 with SMTP id a2-20020a194f42000000b0051011f46741mr368289lfk.17.1706740615145;
        Wed, 31 Jan 2024 14:36:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdYe2Nb5HfdKCFeTwFRTgm6BrtfqRQRuKBw02G2lHJDzsRV/wKxyLsFBX60j2fd+FOCZ/FZQ==
X-Received: by 2002:a19:4f42:0:b0:510:11f4:6741 with SMTP id a2-20020a194f42000000b0051011f46741mr368273lfk.17.1706740614525;
        Wed, 31 Jan 2024 14:36:54 -0800 (PST)
Received: from redhat.com ([2a02:14f:177:15f2:27d8:8291:1cb6:8df6])
        by smtp.gmail.com with ESMTPSA id fx20-20020a170906b75400b00a34b15c5cedsm6703708ejb.170.2024.01.31.14.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 14:36:53 -0800 (PST)
Date: Wed, 31 Jan 2024 17:36:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Cc: arei.gonglei@huawei.com, jasowang@redhat.com,
	herbert@gondor.apana.org.au, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, nathan@kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [PATCH] crypto: virtio/akcipher - Fix stack overflow on memcpy
Message-ID: <20240131173615-mutt-send-email-mst@kernel.org>
References: <20240130112740.882183-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240130112740.882183-1-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 30, 2024 at 07:27:40PM +0800, zhenwei pi wrote:
> sizeof(struct virtio_crypto_akcipher_session_para) is less than
> sizeof(struct virtio_crypto_op_ctrl_req::u), copying more bytes from
> stack variable leads stack overflow. Clang reports this issue by
> commands:
> make -j CC=clang-14 mrproper >/dev/null 2>&1
> make -j O=/tmp/crypto-build CC=clang-14 allmodconfig >/dev/null 2>&1
> make -j O=/tmp/crypto-build W=1 CC=clang-14 drivers/crypto/virtio/
>   virtio_crypto_akcipher_algs.o
> 
> Fixes: 59ca6c93387d ("virtio-crypto: implement RSA algorithm")
> Link: https://lore.kernel.org/all/0a194a79-e3a3-45e7-be98-83abd3e1cb7e@roeck-us.net/
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Cc: stable@vger.kernel.org
Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 2621ff8a9376..de53eddf6796 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -104,7 +104,8 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
>  }
>  
>  static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher_ctx *ctx,
> -		struct virtio_crypto_ctrl_header *header, void *para,
> +		struct virtio_crypto_ctrl_header *header,
> +		struct virtio_crypto_akcipher_session_para *para,
>  		const uint8_t *key, unsigned int keylen)
>  {
>  	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
> @@ -128,7 +129,7 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>  
>  	ctrl = &vc_ctrl_req->ctrl;
>  	memcpy(&ctrl->header, header, sizeof(ctrl->header));
> -	memcpy(&ctrl->u, para, sizeof(ctrl->u));
> +	memcpy(&ctrl->u.akcipher_create_session.para, para, sizeof(*para));
>  	input = &vc_ctrl_req->input;
>  	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>  
> -- 
> 2.34.1

