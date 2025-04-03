Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94F24167F
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677017; cv=none; b=mGL4H04F79A/PWeB1aPadlr+X2a2kxHL+18KwjLmdi+q4jfnQ0HnZecY6vhuHVcXeYK42P+0+TXjCp34byOJe27eXGYDFCI3+3AozFWfHEbVwlKBBUM5O7ttwRvEXP7ZxMq6AVIQEtpEwafch7Pi+XCCMvLTbIc8D/Pn3nJE9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677017; c=relaxed/simple;
	bh=BnDJa1NQQgaQiyi+V0Ba6o9o2I6eOeRoTuZjMFY/ckE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RS6NUS2M2IagMH2xzCKnpu/GnG631oAwHcfP/hnNUji0dBQ/hg4tSDmtINb9GbMEw7Lr6t0yX+N7Hquzjjrv+4KcDsc2zPzps3kDNdHugK2X1lggFPI/QbRcGcBxZ8LDBeXcmfzX7thK/1rX+Z6aG6QW8bOZpaNTmlhMfRi6JjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScIizamd; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScIizamd"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso696281b3a.2
        for <virtualization@lists.linux.dev>; Thu, 03 Apr 2025 03:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743677014; x=1744281814; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKfPpP5X7BAGuDFo2uD9oJkA83aeZkArrNDesmfrThk=;
        b=ScIizamd3WNLlDMiPhupL6ucfntCpVtFFtfojBToc7IQofsCpk7DUAJA46gF/NyG+M
         0AZKFffesb/7JPwjluyT624t7H7tru13la9I1EwwXzGoMLOJqpiD7wgiflU9JqnRYVFJ
         ij9GV+khsNhtyl/gAuBjbfkf6WZL65eLnQW98xJr1vK18kF9NBomLax++jvWA1y+2wUs
         bTy88tUk5X9b2Uvhnh8X+9cQ7Zf34liVvjO1+ly/0/vpFx12pUQ3DUG0CSBsaf86X6cE
         Z4oRbP4tXLWo3PkATeHqH8U+UTXbt+Lpu/gan8VVDMw2/894DHJoN19aGrokf4uncvBM
         2F2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743677014; x=1744281814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKfPpP5X7BAGuDFo2uD9oJkA83aeZkArrNDesmfrThk=;
        b=SXhXIUWxH9bIPCLRrS/UyB351xV2nnNqNFGik78kgLC5A9MiZLmzvwcoeBqT9nDa1R
         31VJKgRHVeQ/wG9Ez+RqkYFmvvywc0ds0/apkXmce6mGviSWWtuCLTAlac6EtEj3vdpd
         pTGOKafw//iKaYPhkOQKL3bAVj6MuOaQKh5PYLc1RxPfUqsNkuqnCn3FVzSs0tee+aRw
         W1ZZZUoNKtPrzulAGIPaA0of/moENDg1a7LfnjYoMjPVGCuMKoPR7J4zrG+D4X9owk3i
         76aIHL49jg7dRcDvZXdeyBL8XMzgF2dx3DNuhBmebXdurg9XHiwiPrqzV0kTWFO3F0Fc
         RLTA==
X-Gm-Message-State: AOJu0YzBabzd2B2C0DB5QSp1vbt3si8gNYBtXuMnkNOwJ261sXk5tvAW
	d4bM9WL6pCJeYa+0QJqr8g97dzNDCjplzu17Zwj3MtIGlG/fgpeq5YwQYMyF
X-Gm-Gg: ASbGncuwjxXkIoykypy0n3BZamhullvGngWsQZ0zbrf2DAMdmd5PUu5mvUOcHxgeKyf
	tDYZE3mjYIEFny4QI0UJn5fPgQmEpX1zPsd9HmZojdivmlEla2Q5w4RT8LjX64cJlFv/yBdYAXl
	MFlfzvCMFmJpDdwd3TyfQNs43V7TNyGsP8aYmB0MjKykQ23xgWOAX3Y1gfDSreVcQuk8eeHitzu
	9JOTI672F5pRRlkilDQ8v9c/1ep4G3OHDAJYHiBMWDww3VL0td+jGvgIQu5SPR/S0pmcxHLyAat
	sBDp+WUCKRyVmIIhlMtshx8uCcnATLCFlGViQiBnIG6YjbZyY4VDRRpCC3k7WiBmkS580nEvCGY
	M+OWiLxC3mZh5MLZ4hoFWwGI=
X-Google-Smtp-Source: AGHT+IHkcCi0YR0D+hOGCuMNoTiX/WY5jnF7Ek8IM7ApPidPGWeW9JEmR3voupoks8wnoR3rCxGzhw==
X-Received: by 2002:a05:6a00:399d:b0:736:53bc:f1ab with SMTP id d2e1a72fcca58-739d9e96e15mr2649550b3a.12.1743677014350;
        Thu, 03 Apr 2025 03:43:34 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4e:bd30:2142:e08e:e207:d31c? ([2001:ee0:4f4e:bd30:2142:e08e:e207:d31c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9805a00sm1144603b3a.81.2025.04.03.03.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 03:43:33 -0700 (PDT)
Message-ID: <8aad5ff9-6eab-411d-9569-9a2303561ac0@gmail.com>
Date: Thu, 3 Apr 2025 17:43:26 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when setting up xdp
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250402054210.67623-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250402054210.67623-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/25 12:42, Bui Quang Minh wrote:
> When setting up XDP for a running interface, we call napi_disable() on
> the receive queue's napi. In delayed refill_work, it also calls
> napi_disable() on the receive queue's napi. This can leads to deadlock
> when napi_disable() is called on an already disabled napi. This commit
> fixes this by disabling future and cancelling all inflight delayed
> refill works before calling napi_disabled() in virtnet_xdp_set.
>
> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>   drivers/net/virtio_net.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..33406d59efe2 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>   	if (!prog && !old_prog)
>   		return 0;
>   
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	if (netif_running(dev)) {
> +		disable_delayed_refill(vi);
> +		cancel_delayed_work_sync(&vi->refill);
> +	}
> +
>   	if (prog)
>   		bpf_prog_add(prog, vi->max_queue_pairs - 1);
>   
> @@ -6004,6 +6013,8 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>   			virtnet_napi_tx_enable(&vi->sq[i]);
>   		}
>   	}
> +	if (netif_running(dev))
> +		enable_delayed_refill(vi);
While doing some testing, it look likes that we must call try_fill_recv 
to resume the rx path. I'll do more testing and send a new v2 patch.
>   
>   	return 0;
>   
> @@ -6019,6 +6030,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>   			virtnet_napi_enable(&vi->rq[i]);
>   			virtnet_napi_tx_enable(&vi->sq[i]);
>   		}
> +		enable_delayed_refill(vi);
>   	}
>   	if (prog)
>   		bpf_prog_sub(prog, vi->max_queue_pairs - 1);


