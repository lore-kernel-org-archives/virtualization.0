Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10F42B753
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195094; cv=none; b=CtctSxsPSk07XaFwTtFKNgvfT+iGd9iNTlZSZLkv1YvkLskuII51jUCZtZnadOuR7t6DqrIthVSbIFvgJbX7X9uERxwrN1e4x7aCaaftjhuY3mrq4/AuXYBlhJPRSmbksLveCyP8Z1EgtkfE9cLIt5OyisU1ONDh7FNYpJ4cUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195094; c=relaxed/simple;
	bh=6y9b/y+mwIlmIt3T9GWYo/xRhdsQvmmJFA2Lw1sy2T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spvs408S/MqVoZy5JdsMXQ1MFHQaah9WW1vCKtEO2KfYvODAq8s7gw8R1Yh5JL86uzuOa9mX5nJPudwcKaLri76CARlBaq4iDQhJKoAtbVXFsLoRHX3gGrW6CZ+moXbm82QUyHDkbd1SnYd6FQXrASJ92bzb1BMhuAMQyaY6bl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJSYTdjc; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJSYTdjc"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423f420455so60870b3a.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781195092; x=1781799892; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GIVt44QUH/d+IWxlXuw18ksP9yT6I/Eko++PuSKJGA=;
        b=JJSYTdjc1VjuMZYDcle6dAwnfUSiQ0MuyRHDpmV4n0ubNkjdObpwonbXHxmTsYxrvd
         AFjS/HoI8McEnecY+bwCqVkPoEUiXa7KJIyMu0KRMZY8Xd8AjPTI4sVWQN25A46LmCHb
         MbDedI78d63uIyvjXv5TeHAMaaC4/0I3sopTPh4jbaFam4suhLG7VVzH+gQbpPWr5SJG
         oees1smomBAr4RLuVRegt1prmFcYRCECWR48Z9GhuakEeoXI0PnuFSCE3owXzQ3wiP7H
         38aetmVfzrM1YyS1rHWl58rMAWEKt96yak4zjPXcacjgH5TWKgX1C4zCzSUdr+w3AVKe
         fAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781195092; x=1781799892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GIVt44QUH/d+IWxlXuw18ksP9yT6I/Eko++PuSKJGA=;
        b=CiI668JSaf4eGBdNcj01/hqHZ4Z7ka0BuLCDhKQu50y1xUqSbZqimiLjEQOg/x9T82
         5zsdCiFwkzChUU6MXWfSxWrLmUxp3wTU3VrMJf0IvBJZuH7cbj/bgNJk/XTAi8hWuSC7
         Ta1YBNxe391AFjQay89YEUv2u5Xzb2Jnj22XnhjN6J+bYCOs81TAB04RZH/SGdSBNt5p
         et8cjunZin0xQOCvO22Li4KZ6XlVl/tFdmfn5gu2gYc1vNh8p3u7/8Zy0o97jv30y7W5
         cBT8ySyw4NzTDc/iRQ9kny3dlWuKjxVJ8NgPOeDlYDeBdrF0e+mDxs9ali1MBqYVmEs4
         in+A==
X-Forwarded-Encrypted: i=1; AFNElJ/i+daGDX2Jk18PqM2DOu2rPoS8O31jIQgIpIwzKv0wZxWDVgt1sCSF0OP8PqflD4DU5qga9hQDrmCeQKpP7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyihgxVwTaL6VA08p1YoynNfoc0bLaBimbHFjMJnkRXb/1k+zme
	2dyRuExV69rbP8HC7YKtVBxv3pbrYoJ94k65maLkkcbye/gzL1/At2bi
X-Gm-Gg: Acq92OHmy6KnfWPFZB1d5CBeIvuNE0Q59JUzk2jRJOqjv3hht8ju1KKXkXVU56O9eqe
	X9cssLsMnp3lIOjTy3/aPZ0Dj07PQJ0Z3cbgyLvw05Ue4nNlBnRiDb8LC4udSUdiNjiLR3+cmHC
	Gqraneucu8zegjDy54n0pfR3eCU8a0bm4VyfUhqiZIQg5krsR81/Fkp9xBBnJUNXiGvJWj2HBjX
	HtB3CEip+g5g/2Z/G0K8gApSFZa7zd681TXAhw/CCs3G9KZYdzXI+YaIJZd857vM5MjAqzD7MJj
	jAtb0EBUu7BOIknbbJvMqrxghcCB22gxdgej0TmcxImLu0XyGWG9fynPe2lxJZE66jIkG/9Dlxm
	2+PU5WCpf8PFyfG1O69obuTlPd02zmr22wtTUuUQeCz51nCeXnHZVtV5ohOssHbIRGrPU+YI6Sd
	rC1Gr3NJTW6lp846/0Bc9R6Own/hXI8EgOENndYyrSBUWplqp8yDwzrfAuTFrBtz/14Rsy5Qlhm
	fZlc1N7YdvD0pKY
X-Received: by 2002:a05:6a00:3991:b0:841:d0a9:76e with SMTP id d2e1a72fcca58-843367db2ccmr4131774b3a.5.1781195092027;
        Thu, 11 Jun 2026 09:24:52 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0c:3090:eba9:46c1:1423:bd93? ([2001:ee0:4f0c:3090:eba9:46c1:1423:bd93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bce087sm2520701b3a.22.2026.06.11.09.24.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 09:24:51 -0700 (PDT)
Message-ID: <41eefa1d-99bf-450d-988e-7dec67c6b61e@gmail.com>
Date: Thu, 11 Jun 2026 23:24:44 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] virtio_net: xsk: fix race in rx wake up
To: menglong8.dong@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Cc: mst@redhat.com, jasowang@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kerneljasonxing@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260611025644.2431148-1-dongml2@chinatelecom.cn>
 <20260611025644.2431148-2-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260611025644.2431148-2-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/11/26 09:56, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dongml2@chinatelecom.cn>
>
> During packet receiving in virtio-net, the rq can be empty, which means
> "rq->vq->num_free == virtqueue_get_vring_size(rq->vq)", in
> virtnet_add_recvbuf_xsk(), if we are using xsk. Meanwhile, the fill ring
> can be empty too, which means we can't allocate anything from
> xsk_buff_alloc_batch(). Then, we will set the XDP_RING_NEED_WAKEUP flag.
>
> However, if the user clean all the data in rx ring and fill the
> "fill ring" and check the XDP_RING_NEED_WAKEUP flag after
> xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(), then the rx
> napi will never be scheduled: the rx ring is empty, which means we will
> never receive a packet to trigger the further recv fill. The rx ring is
> empty now, so the user will not check the flag too.
>
> Fix this by set the XDP_RING_NEED_WAKEUP flag before
> xsk_buff_alloc_batch() if both rq->vq and fill ring are empty.
>
> Meanwhile, set the XDP_RING_NEED_WAKEUP flag if we have any free entry in
> rq->vq.
>
> Fixes: e3f8800aa243 ("virtio-net: xsk: Support wakeup on RX side")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>   drivers/net/virtio_net.c | 25 ++++++++++++++++++++++---
>   1 file changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..4b5b3fa62008 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1323,16 +1323,27 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>   				   struct xsk_buff_pool *pool, gfp_t gfp)
>   {
>   	struct xdp_buff **xsk_buffs;
> +	bool need_wakeup;
>   	dma_addr_t addr;
>   	int err = 0;
>   	u32 len, i;
>   	int num;
>   
> +	need_wakeup = xsk_uses_need_wakeup(pool);
>   	xsk_buffs = rq->xsk_buffs;
>   
> +	/* If both rq->vq and fill ring are empty, and then the user submit
> +	 * all the chunks to the fill ring and check the wake up flag
> +	 * after xsk_buff_alloc_batch() and before xsk_set_rx_need_wakeup(),
> +	 * we will lose the chance to wake up the rx napi, so we have to
> +	 * set the need_wakeup flag here.
> +	 */
> +	if (need_wakeup && virtqueue_get_vring_size(rq->vq) == rq->vq->num_free)
> +		xsk_set_rx_need_wakeup(pool);

I think when polling the receive queue, the userspace program needs to 
check the XDP_RING_NEED_WAKEUP flag if it does not see any packets. The 
flag check is quite lightweight in my opinion. Here are some examples I find

- 
https://github.com/xdp-project/xdp-tools/blob/e9469501622aa22a7e452a671000bec8685edcde/lib/util/xdpsock.c#L1206
- 
https://github.com/xdp-project/bpf-examples/blob/43e565901c4287efa863edca7f0e6cd6e35ed896/AF_XDP-forwarding/xsk_fwd.c#L540

Furthermore, the XDP_RING_NEED_WAKEUP flag related functions does not 
provide any memory orderings. So even with your patch, I'm worried that 
this case is possible

kernel userspace

xsk_buff_alloc_batch -> failed
                                                             submit fill 
ring
                                                             flag != 
XDP_RING_NEED_WAKEUP
// reordering due to lack of memory orderings
xsk_set_rx_need_wakeup

I'm not expert here, so correct me if I'm wrong. I think the wake up 
flag is designed with no orderings so we cannot rely on it to reason and 
skip further checks.

> +
>   	num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>   	if (!num) {
> -		if (xsk_uses_need_wakeup(pool)) {
> +		if (need_wakeup) {
>   			xsk_set_rx_need_wakeup(pool);
>   			/* Return 0 instead of -ENOMEM so that NAPI is
>   			 * descheduled.
> @@ -1341,8 +1352,6 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>   		}
>   
>   		return -ENOMEM;
> -	} else {
> -		xsk_clear_rx_need_wakeup(pool);
>   	}
>   
>   	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> @@ -1363,6 +1372,16 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>   			goto err;
>   	}
>   
> +	if (need_wakeup) {
> +		if (rq->vq->num_free)
> +			/* We have free buffers, so we'd better wake up the
> +			 * rx napi as soon as possible.
> +			 */
> +			xsk_set_rx_need_wakeup(pool);
> +		else
> +			xsk_clear_rx_need_wakeup(pool);
> +	}
> +

Why do we need to set XDP_RING_NEED_WAKEUP even when 
xsk_buff_alloc_batch succeeds?

>   	return num;
>   
>   err:

Thanks,
Quang Minh.


