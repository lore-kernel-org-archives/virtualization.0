Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F8749C
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287386; cv=none; b=tuTCvTMdkopRxMByhQMYz9NdLfL4YdLxKUVzLfIOU5/AOBnoXolen9V4V92iOiSgSTViWjtad1LYWlz0IBYe66raFO2+1fc5sS+jPo428e9y+9wfjGQ7SxCwbNRT93+iFfevO/EvaNHjcijWy0ibDVX1MzXcceybl6pDYXuIuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287386; c=relaxed/simple;
	bh=aVuqaNznx/5mZdLJC0vjrOwYEAxdll74BF6plXLxd1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukwVzzDlZ1T6+rG5gIv/pqgHVUO4Sa13CS4Zf7qvGVuuN1A/nAaI1d81xGtjqqlyJFkwvhfKtnl54AG0Qa+HIGVQKHhQWOVlRxRpn/3YGvyfO2H5AIjqJZq7Y88lURofCOXLiOshi4PvboRDsy/09E+WOV03TdZp74Z4wR/fD/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNAoOac+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNAoOac+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742287380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+9EOSMwZ0yperbosZq+EsQ8tvp7eSF9vKmD44NR3ec=;
	b=ZNAoOac+ui15git0iI76lBEcpnJE0gLehfb1wWXOnKt2YSqc2lbkcsDkZnIalOyF49SFJb
	NjcfA0SWQKKlpcpibjcP8+CaLXfL2+pC1o/7rL8+oud7n7nAZX0l/fE762uc+Yq0XvLrEG
	vR30CKGN1oS3MRU2jyPvGOIS+rn/W0k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-pzMVAUjCP8GxcS5GarmHtg-1; Tue, 18 Mar 2025 04:42:58 -0400
X-MC-Unique: pzMVAUjCP8GxcS5GarmHtg-1
X-Mimecast-MFC-AGG-ID: pzMVAUjCP8GxcS5GarmHtg_1742287377
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d08915f61so16251545e9.2
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 01:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287377; x=1742892177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+9EOSMwZ0yperbosZq+EsQ8tvp7eSF9vKmD44NR3ec=;
        b=GiE9i4joUGnRd8hJf9+xeIlfUIWtgZ0VcnJyqO1ib82SyKd/9qeQTmMIt1CLzkHDsj
         wGYEABWImOELmj8Pa81UCyUF/6AOMKFRnK7Pp+WX1elmLF8pAHe7jUaGrLt/2R41VKAV
         pITk/Yf0n0m2d+ow7QXPKpUl/Pkv+yAIfhELwMA5GnQM4Rd8LKdbdOVEXk4NdhToML/p
         qbnhq5suJmYl6COkEVg9o3mlITTlr8KUp6kXFE/ehWxCS79uPImPuMA/hE+x0VfCg0E+
         y6BK0K1kMs8Q89X/pWfjRkxoeISKFVafmMl5YEumdEHcVtIei48YOUyFzW4NvzuwRDgx
         wejw==
X-Forwarded-Encrypted: i=1; AJvYcCXKOANaQwtD9gBxpZWJraYVajWgix2v2wzOJfFI2JaaLLVZYSB5T3Ig64q5gIihHG8374g1PP2MQkXRcmlTzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyUkyBLpXLng6s94RZ9VxnUOG65IuCjt4ttXK0xR+pN0WJBjpvs
	no1ddFyZ5pX1FWjz2loM5cYnFXdSUdJJVr4AM/QbmcGX7oKjaHFnG4bhlzINTNe5WbIdTp6AxgU
	/WDvRx3HhxH55OkmtbZfPQ6b3wj8KilcVtYxoi8oVQQYIlIJQb36I4AVhTlLCRMWH
X-Gm-Gg: ASbGncs3P1JaIPVAM+jjomc8L2NmioESqDHxTpItwun3RUYiViQUwHs5AOg2iPphRbI
	IoFkhzSZZITkk9X0fq7CrzV/p143ELDN2ZtzMwoSLQL0RuMj/Ox4RzqleBrmwk1IBRssIkSamSo
	QttFeZ6jmPBU8Vq7oZxv60QJ4RTY4ud0wZ9mgoLsMwxUxshGtwD6Yvxpt/Js1MrVm8G9OfFNTsl
	aNYNJkD0y2knWY9rcvWemszEnkBrpLWcUJHyO4I7FAfc0yP2/yl00gvbiYOAFgN+34N9DlK0Bcw
	s4ZbYGQje9ad9VKKQSyZpc6JF6u1v5NUZfSEsK7hylvgVw==
X-Received: by 2002:a05:600c:1d84:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-43d3b9d2769mr10024395e9.23.1742287376850;
        Tue, 18 Mar 2025 01:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHILQIoNqyHItwOTFUtVNmBDSJea3jYt34PUTdt08Ok/vxBredo4KmYrx3e6SVCEbItbB4gdw==
X-Received: by 2002:a05:600c:1d84:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-43d3b9d2769mr10023915e9.23.1742287376480;
        Tue, 18 Mar 2025 01:42:56 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffb62ccsm128436605e9.7.2025.03.18.01.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 01:42:55 -0700 (PDT)
Message-ID: <cb9294c1-1d3c-4fe0-bf84-63a2fed1e96e@redhat.com>
Date: Tue, 18 Mar 2025 09:42:53 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 6/9] net: enable driver support for netmem TX
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me,
 asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-7-almasrymina@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250308214045.1160445-7-almasrymina@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d43OkBndG14kS2y2MmjbheZU-flJHtuuoY-tHSlwRpQ_1742287377
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 10:40 PM, Mina Almasry wrote:
> diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> index 6327e689e8a8..8c0334851b45 100644
> --- a/Documentation/networking/net_cachelines/net_device.rst
> +++ b/Documentation/networking/net_cachelines/net_device.rst
> @@ -10,6 +10,7 @@ Type                                Name                        fastpath_tx_acce
>  =================================== =========================== =================== =================== ===================================================================================
>  unsigned_long:32                    priv_flags                  read_mostly                             __dev_queue_xmit(tx)
>  unsigned_long:1                     lltx                        read_mostly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
> +unsigned long:1			    netmem_tx:1;	        read_mostly

Minor nit, but since a rebase is needed... pleas use only spaces to
indent/align the above fields.

Thanks!

Paolo

