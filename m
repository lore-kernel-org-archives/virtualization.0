Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D321C19F
	for <virtualization@lists.linux.dev>; Wed,  5 Feb 2025 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738758031; cv=none; b=rpnv42bZq+sSmaIS35MBBd2BslwoVEdW2zhOCjnE9UWxKlf+BN6iTwIF7WxhRUPZcJKjteFqf9uy3CNvwD/Hd/RF5Xc18gvm6qhjK5+escGbZBbK1AIFKtcpcNeUxNrW8ENrtYSCz2UoYOLaVBI/7uSr2yU94id/tj6xY6flews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738758031; c=relaxed/simple;
	bh=mliisTJtC4/x2He8n/YtxnJipD2aoHXMhReWhBlgrO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ob8meXJ60l2i5EGERqoajiPWFoS1huaMzAF3SNi532zbgOVN376gwyR0lKPHHEnPIN317itr/D/WKxiXLkqnF20jMuBVnOTJ3cnDQ7uGEJLVj/0aWfTkLGitaj//vm1tnaKjE97XMdpLqflgXEc6vWyfHd1IsT3gyc9zbd4oa4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEOnHMLn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEOnHMLn"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436345cc17bso49802165e9.0
        for <virtualization@lists.linux.dev>; Wed, 05 Feb 2025 04:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738758028; x=1739362828; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6UxSbzx0mqyS4ecv7b06nR9TIVmkjaPNaX7UQ2Szu4=;
        b=WEOnHMLnXIDhIxgvwbmYqoSfRIzfls4tvlhYbLZDU4Vydrtif8IUFpYvzQteOaq5i4
         8KxTOblNYTOAxCCLKfo6zvo8gTn+tRayH/sFD1FzqubIqP7tplb2k5zZcaWo3kQ4cl5H
         okplN4Vg1jm7Y3UH1Zp5j2GX/H01HAlNZzGfPqi+rsTGV9Zvh9JLUmMVrIO9ZdzTOG+X
         QoZL7gV6sDULD56RzMVT0es0oSUXpg1FOoOGTXObgW3w0FecmYSZqNR4FbFWpO8ej1Yj
         sonMeLnJ2c5OExOUxvLI5jYWBQ7CurclUGOfmxSb2xLvvLYM8NKpxKTwkmYeTZmXLz/j
         IuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738758028; x=1739362828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6UxSbzx0mqyS4ecv7b06nR9TIVmkjaPNaX7UQ2Szu4=;
        b=qXHpkoRA1eMiFaKQsPLDJj7vWWSfevhlabImqBuKc5U1631KhAfU/krNF9alkoP0BZ
         oe+1GkbEA+qdQmY1z3SQg/xAtImQXkV44SzjsyAIEvuc4dfmZo5HkH5myAChHwvfcP0Q
         ifGTHlCSyLyCU82mY1egAnsB6XBDRwoGzbeh7HkkaJLHuzL499Nj1ioji0cT/wLHyMyQ
         kOYkU6g2lFQ60mEF/g+TSwzrBmgBHc5/JKZqYWriENUlCHIw9XGn9v50FQ4czk7/uRAB
         quYqSkiIMEG/VDzzYrgKG4uI9RIbnhCiiBkj3JkTLAmk/EPcXQW5Muiz5T/3v/roGD+P
         JraQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqGHIKKvByIAkxgAQQdZcKK5D1jdq9BSE9DIZUA6lSnuS9sdy/cNpOjfPr5LqhiXSWTsk9PKn3uj6E+LktnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxiLsg1STXqa8QyuzKDl6lYP8g8Hwn7rbQO/LXnsZsNZ+FYU/U6
	94QNVg2u/0od2fJAnwforXFk8VhCA/YNhwR53CeZCJ4rBjRNYoOD
X-Gm-Gg: ASbGncvC2uFEQni6H4QdJhrjCa9QJk6LVUcJd5nw9phZrAzUsjQZkm6uh1rqgsl7Ey+
	xv8LeRV4X/Bsufy0sPZBKzoeLBb9PxKAoPtqkbi32N1YzJSgVz+Un/YWCKdgmpgez+EZrJsWWBY
	bsItmN44MgSFFm7iliqImgNvdtSxOkkVTu/o/VYiLh8aTCTZF0JR3eFvByHLSwmBl5B+mU3tn5y
	zLn1VM2/ZYrsJZG1W0Op0pXjJik3wyiaa1qiisivH+O8kSDd5LpoOSznYqzdpYejvYXuYYjGE4l
	mLNdWTqDWUwqo46FDKMYX3U=
X-Google-Smtp-Source: AGHT+IGJDXvIG/7Qnnn/pmmyUc/PCQsFzD0zmP7oGwtUvw9dR3YQPaYZ7+KNbPMVMRYa9yN06wEAdQ==
X-Received: by 2002:a5d:6c6a:0:b0:38c:5bfa:a93b with SMTP id ffacd0b85a97d-38db48a987emr1829547f8f.2.1738758028045;
        Wed, 05 Feb 2025 04:20:28 -0800 (PST)
Received: from [192.168.8.100] ([148.252.128.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c1016easm18630336f8f.24.2025.02.05.04.20.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 04:20:27 -0800 (PST)
Message-ID: <abc22620-d509-4b12-80ac-0c36b08b36d9@gmail.com>
Date: Wed, 5 Feb 2025 12:20:34 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-6-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250203223916.1064540-6-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/25 22:39, Mina Almasry wrote:
...
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index bb2b751d274a..3ff8f568c382 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struct sock *sk, size_t size,
...
>   int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>   				struct iov_iter *from, size_t length);
> @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
>   static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
>   					  struct msghdr *msg, int len)
>   {
> -	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len);
> +	return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_iter, len,
> +				       NULL);

Instead of propagating it all the way down and carving a new path, why
not reuse the existing infra? You already hook into where ubuf is
allocated, you can stash the binding in there. And
zerocopy_fill_skb_from_devmem can implement ->sg_from_iter,
see __zerocopy_sg_from_iter().

...
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index f0693707aece..c989606ff58d 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -63,6 +63,8 @@
> +static int
> +zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
> +			      int length,
> +			      struct net_devmem_dmabuf_binding *binding)
> +{
> +	int i = skb_shinfo(skb)->nr_frags;
> +	size_t virt_addr, size, off;
> +	struct net_iov *niov;
> +
> +	while (length && iov_iter_count(from)) {
> +		if (i == MAX_SKB_FRAGS)
> +			return -EMSGSIZE;
> +
> +		virt_addr = (size_t)iter_iov_addr(from);

Unless I missed it somewhere it needs to check that the iter
is iovec based.

> +		niov = net_devmem_get_niov_at(binding, virt_addr, &off, &size);
> +		if (!niov)
> +			return -EFAULT;
> +
> +		size = min_t(size_t, size, length);
> +		size = min_t(size_t, size, iter_iov_len(from));
> +
> +		get_netmem(net_iov_to_netmem(niov));
> +		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
> +				       size, PAGE_SIZE);
> +		iov_iter_advance(from, size);
> +		length -= size;
> +		i++;
> +	}
> +
> +	return 0;
> +}
> +
>   int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>   			    struct sk_buff *skb, struct iov_iter *from,
> -			    size_t length)
> +			    size_t length,
> +			    struct net_devmem_dmabuf_binding *binding)
>   {
>   	unsigned long orig_size = skb->truesize;
>   	unsigned long truesize;
> @@ -702,6 +737,8 @@ int __zerocopy_sg_from_iter(struct msghdr *msg, struct sock *sk,
>   
>   	if (msg && msg->msg_ubuf && msg->sg_from_iter)
>   		ret = msg->sg_from_iter(skb, from, length);

As mentioned above, you can implement this callback. The callback can
also be moved into ubuf_info ops if that's more convenient, I had
patches stashed for that.

> +	else if (unlikely(binding))
> +		ret = zerocopy_fill_skb_from_devmem(skb, from, length, binding);
>   	else
>   		ret = zerocopy_fill_skb_from_iter(skb, from, length);
>   
> @@ -735,7 +772,7 @@ int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *from)
>   	if (skb_copy_datagram_from_iter(skb, 0, from, copy))
>   		return -EFAULT;

...

> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0d704bda6c41..44198ae7e44c 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1051,6 +1051,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
>   
>   int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   {
> +	struct net_devmem_dmabuf_binding *binding = NULL;
>   	struct tcp_sock *tp = tcp_sk(sk);
>   	struct ubuf_info *uarg = NULL;
>   	struct sk_buff *skb;
> @@ -1063,6 +1064,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   
>   	flags = msg->msg_flags;
>   
> +	sockcm_init(&sockc, sk);
> +	if (msg->msg_controllen) {
> +		err = sock_cmsg_send(sk, msg, &sockc);
> +		if (unlikely(err)) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}
> +	}
> +
>   	if ((flags & MSG_ZEROCOPY) && size) {
>   		if (msg->msg_ubuf) {
>   			uarg = msg->msg_ubuf;
> @@ -1080,6 +1090,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>   			else
>   				uarg_to_msgzc(uarg)->zerocopy = 0;
>   		}
> +
> +		if (sockc.dmabuf_id != 0) {

It's better to be mutually exclusive with msg->msg_ubuf, the callers
have expectations about the buffers used. And you likely don't want
to mix it with normal MSG_ZEROCOPY in a single skb and/or ubuf_info,
you can force reallocation of ubuf_info here.

> +			binding = net_devmem_get_binding(sk, sockc.dmabuf_id);
> +			if (IS_ERR(binding)) {
> +				err = PTR_ERR(binding);
> +				binding = NULL;
> +				goto out_err;
> +			}
> +		}

-- 
Pavel Begunkov

