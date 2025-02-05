Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8582288C8
	for <virtualization@lists.linux.dev>; Wed,  5 Feb 2025 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738741978; cv=none; b=F+pT8aHhe1bAM36r/FUAWFbStKgfZ8xSc9QA4XCq7TRJXrsY6PjCkejl+/HQ5IZLjaE9/DkOE5NpogqOD9ikHKUOauMcU0bNhEEkqpx41y8tL0sj2yCNNDAS2UiDcww2K0l3/BXGbeQIW4lS2ZkC+e6hJNKrWkrKPzHXdLulgxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738741978; c=relaxed/simple;
	bh=0e2bbcIV07l4znqBAb8xKQvuFFeBDz3yhc/3jwI/0n8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uO8/6oJuwwhC6ykrTuY4GCMQty72JW8/+5yCWpXC8/ItlTjBEICc1cF5SQ2wljbfuMm29/iOjw8Z0NQyPUSUeSG4kMSYenTAENeD6Akfk5s/FSS+yLHYKQq2DtRd7ttu8fM2RCgNR6+cOiyIANf5ZhJvCkHlu2h5DcyHpZcegXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XQNv/KI1; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XQNv/KI1"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21669fd5c7cso118174615ad.3
        for <virtualization@lists.linux.dev>; Tue, 04 Feb 2025 23:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738741975; x=1739346775; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/wQcY2ueB6zeUgpe4VvN4MloDax+g7ADJ74CXff3n8=;
        b=XQNv/KI1db13Js7ANa2V/cDY7mw3MUXq1q5+Plgk2AAaKT/O79KdZ5iExB0gv4s3JW
         VyLEgSiAaTZz/t68rQxXMXEFrfdU66HOaUry81qf+OPvedLTZ+uL+d9SZouiqki2cqK8
         GXW3DzMyhkCVrbqnG4Z4bjiJtBRKX5dS916awZt4IFH9IzcukxXMe0OLsCCf61DMwVRS
         eXIHgU7BryUNrXk1DA+to/J7o8vTcyeYRPpZKhnlC+uU4oCruRZDRzOkrttIR5XR2/YO
         fWEPrYhFJ3LV/iwzGWBKkfEOZBWpKqrQKu960h2dK3HON0eV4ShcTUD/yEtcI5LKwqfM
         6KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738741975; x=1739346775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/wQcY2ueB6zeUgpe4VvN4MloDax+g7ADJ74CXff3n8=;
        b=LY16H6MWqgBOdClFWnbW80jMTrHVW0WsBfiE+zo/FoncY9QU1SIsFIMe44vF6xcXaY
         0zw3ASvCvTvfsQZQ/CROMsi+DR5XiWeNalYVFVNKoMjjvuYXPIkAA7KelSZw9FnuHGOy
         nQAj3cc9cHJ13Ar2Sdu09y0fo10ITo1TlmS+bqbT7c59dzMTvMVd4KLR1zol1nHMce23
         V5nfUpBryQ0xm7mGW5wFc/U92VpH3Ke/zQ8BOkZCz8FuupOfBr3F6dJnB3xQUGn4k0Pn
         264zIDrA2wQYFaLb2MkLOOYW1wJxFaE7kBpILzOoY1SMnaNJM9RRY2j4NWxzzaTzQo4e
         qWwg==
X-Forwarded-Encrypted: i=1; AJvYcCVtXntMWQdM1T+3fJoLX5znB9vtYLpAuzGSoyh8oeih8sZ8+f7SbLCgeNcgGqm5+ZuU0PuQwitMDPyg/KuNDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcxPaVrJ+ycqzKR6wh2TZGVPCvM3+jmrn3qU55vZrNkBdvSh7A
	JHp1YZ3BPlk+OnJTt1cbAV4L8o5ZRqx/UR2fM4IrKP3ecdQzYVMeO954XCP6nCs=
X-Gm-Gg: ASbGncsY9sqbdhMBLMYwd9uSxRPFnQHsl/x5IBZgOriG/LXza1bhunEZD46pye4VQrh
	1Pv5LKeRnKVvj2hfzmneAK8qIxiN6Iqo4MBEUSs2QxYB04NLFYIgJRLo3hr6XjkvHExpgjW+9mn
	p4i0bjHq6NwFlndEuIqgLRGeudrUIm7/7UpoZkyMJin+KFR1/cE0Xq5+HBwFPf8h/2wVFwo6qhQ
	i2I8dvuXlaqdrhNjCAeECh9txgoQbvhNnW4zuDJ9/kzFhLpEmyfr1ulwjKjB7nLuvRAa/6jz2m9
	/fmuqh0xcl5hKF7iIsP8
X-Google-Smtp-Source: AGHT+IFjxfOyKmAjTjWKO6lMMhws+mfNPNxKXwNP4SKWYtWC/+s05Dilt2DPZDOfbAZqHgbVDjLICQ==
X-Received: by 2002:a17:902:ec8f:b0:216:7926:8d69 with SMTP id d9443c01a7336-21f17f2f955mr29410245ad.47.1738741975055;
        Tue, 04 Feb 2025 23:52:55 -0800 (PST)
Received: from [10.3.43.196] ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f09f5799esm23149735ad.55.2025.02.04.23.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 23:52:54 -0800 (PST)
Message-ID: <da5cbcee-a8db-4bd7-a09d-f262ff052a79@bytedance.com>
Date: Wed, 5 Feb 2025 15:52:49 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] crypto virtio cleanups
To: Lukas Wunner <lukas@wunner.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Gonglei <arei.gonglei@huawei.com>
Cc: lei he <helei.sig11@bytedance.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio Perez <eperezma@redhat.com>,
 linux-crypto@vger.kernel.org, virtualization@lists.linux.dev
References: <cover.1738562694.git.lukas@wunner.de>
Content-Language: en-US
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <cover.1738562694.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This series looks good to me, thanks!

Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>

On 2/3/25 21:37, Lukas Wunner wrote:
> Here's an assortment of trivial crypto virtio cleanups
> which I accumulated while working on commit 5b553e06b321
> ("crypto: virtio - Drop sign/verify operations").
> 
> I've used qemu + libgcrypt backend to ascertain that all
> boot-time crypto selftests still pass after these changes.
> I've also verified that a KEYCTL_PKEY_ENCRYPT operation
> using virtio-pkcs1-rsa produces correct output.
> 
> Thanks!
> 
> Lukas Wunner (5):
>    crypto: virtio - Fix kernel-doc of virtcrypto_dev_stop()
>    crypto: virtio - Simplify RSA key size caching
>    crypto: virtio - Drop superfluous ctx->tfm backpointer
>    crypto: virtio - Drop superfluous [as]kcipher_ctx pointer
>    crypto: virtio - Drop superfluous [as]kcipher_req pointer
> 
>   .../virtio/virtio_crypto_akcipher_algs.c      | 41 ++++++++-----------
>   drivers/crypto/virtio/virtio_crypto_mgr.c     |  2 +-
>   .../virtio/virtio_crypto_skcipher_algs.c      | 17 ++------
>   3 files changed, 21 insertions(+), 39 deletions(-)
> 

