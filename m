Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0EE2036E4
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287989; cv=none; b=dQKiS1jmXMAlcVhiUIsIYOiAstioMV5AmYtEgAQeUkIvwAvcp1JsRx9+UbmzEBdyQcjHdwlj1lLhHEgO0ghQuONN5HcZHRgrRiGrmGGAtUa1IuyFV+jZYOv1snQun4yQMKxQZR3x1opjAaQv33mpgCp6A/S/oX0PVSDB20O8Qsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287989; c=relaxed/simple;
	bh=nBqnAgBHS2l95Pjj/TfnmDtdp5MvYiOaOhdplM2mhmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeTt93CFxp9gHzZCYSqnSyFNDgXZJknqezd6w3qIYMKjY9aQT2v0doZsn4cZeqt5k4MQCb0ykQ1pQXvulYVhKBVZY2G6MgUtjrTfc5bDdR7gObfG0y8nCNYHHuclq4ILcg6VF7j22rJAHKYQYM3koSx8ZayOvaKWUXDSvnFax/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQUxXxi1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQUxXxi1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742287984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tObLTe69QFxvzolejx3T+2gunDSqNceNELAPgsdaeHE=;
	b=SQUxXxi1LvHvGtYA1AOZV/fmy6+ksZWbKLHTVSj7aR/awDDE9bC8JJhWSkQIMCHOWN+mco
	q4XRiXdlbYXe41eQkGA5BFepuj9qvwMUlVxpTsiCEOFY5vvkloi7EXeLq+Kr5dmU7Lc+IB
	JSFmKN6Jtts6Z3QNMbuQdhEiGr93Of4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-QXm-y8qvNtKuYkMddgl_cQ-1; Tue, 18 Mar 2025 04:53:03 -0400
X-MC-Unique: QXm-y8qvNtKuYkMddgl_cQ-1
X-Mimecast-MFC-AGG-ID: QXm-y8qvNtKuYkMddgl_cQ_1742287982
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf172ff63so18552075e9.3
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 01:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287982; x=1742892782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tObLTe69QFxvzolejx3T+2gunDSqNceNELAPgsdaeHE=;
        b=qmIXeOOvStorNGfBBV81r+NrUk1/rhxPvD08PfDeGNTxzc/KybOJiZshMQ4xrDqBJg
         w5PULnf0uAISfCFcHqTxOZ06Tja+g0QqhO8N+oUQpbLEsYoOZwpc7U81qDJ0Xt0YQod7
         hwM1Rpw4jbYy6o5Lo/V7HUVEs6xIlChPgPTD9fHShBYxXUrMsJ8uki099m/v+N+xcKqF
         TZSS+5Wk33jwZW8fP4CNZLMV5P7Y4BwnXi3rJmzWzoEa2ssSq9wgg9a5AvqRcdAqtfzo
         1YRRUmKnJXR3fyhlQSiBc1E8jfbB/yjyDzGFd9HFBN9rQzA4R83kCagX8qkDLPl5KCTW
         bjRA==
X-Forwarded-Encrypted: i=1; AJvYcCUrXaoMAxI4gK0jv+DfWgNXBLVggVZ+FblThi4bBTlQZsAUe7DVbsivQQnmqDTv5P+sI/CpVqWZdo7MZwKr7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUuLVKq5hj+GAwOa8v/NBRAMCVAdmigGJtHgRxi5/t7ThxHt0Z
	CZyugIWvgwSh4JqKmk9AGMw/q48dkc9G7tzDNkoIQ+UCmzkSkvzD7fJDLWRiXDbSZMlnfQqPUw6
	gQBKn9lQRqPanjqyCn/GIsOKRLcT/M1y3cqUjQDExrPINe+Bf47fMxUUdI4Gn5c6X
X-Gm-Gg: ASbGncsHNtqnAUi/lXgcqnBMhs6y3EzyRelNq13mrmw+E4M0N2CJSNUwst/zznQ6D2W
	RgAmdYIcxnbJX1IvNTnsEOpcr0KnjoJ7ZmgiEn01vejpEqCOxYfZ123jiGDaF+r34fpp6Akl5Ka
	PQyZbuV3RR3L+oRw2jvm49hPJzG0hYpi03Gl6nVKlyrPzUbYxzsF7e1ZbKxCN2d7ZuV0/pt6/1O
	oKTFJyRjRbUW7xI5kg0/xiRIg+tZK7Xx/BAywMgzY2hkCH1+7Lq63Kibx/sE9Dw+L/WZQynMeQI
	LVfgOSFUM1wYlL2rBbrYvnwvZCaB7NNNT+4LSmB+Bn7mGg==
X-Received: by 2002:a05:600c:1910:b0:43b:cc3c:60bc with SMTP id 5b1f17b1804b1-43d3b98e784mr10214005e9.15.1742287982439;
        Tue, 18 Mar 2025 01:53:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLxkKyNtE11z59H06IZJtl8h4j7bAu1UH3i6QG52S1C4EP04HZjwsPQi3k1NceSqvEw/VDKQ==
X-Received: by 2002:a05:600c:1910:b0:43b:cc3c:60bc with SMTP id 5b1f17b1804b1-43d3b98e784mr10213835e9.15.1742287982025;
        Tue, 18 Mar 2025 01:53:02 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975d65sm17738818f8f.56.2025.03.18.01.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 01:53:01 -0700 (PDT)
Message-ID: <5de5943b-5527-49f6-a454-b3c7358cff56@redhat.com>
Date: Tue, 18 Mar 2025 09:52:59 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
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
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250308214045.1160445-1-almasrymina@google.com>
 <20250308214045.1160445-5-almasrymina@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250308214045.1160445-5-almasrymina@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T_drG7vMoN8gmuLjTyQrOErEZklVMjJ3B6O-f-4xuwY_1742287982
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding Kuniyuki.

On 3/8/25 10:40 PM, Mina Almasry wrote:
> @@ -931,10 +932,67 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
>  	return err;
>  }
>  
> -/* stub */
>  int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -	return 0;
> +	struct net_devmem_dmabuf_binding *binding;
> +	struct list_head *sock_binding_list;
> +	struct net_device *netdev;
> +	u32 ifindex, dmabuf_fd;
> +	struct sk_buff *rsp;
> +	int err = 0;
> +	void *hdr;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
> +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_DMABUF_FD))
> +		return -EINVAL;
> +
> +	ifindex = nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
> +	dmabuf_fd = nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
> +
> +	sock_binding_list = genl_sk_priv_get(&netdev_nl_family,
> +					     NETLINK_CB(skb).sk);
> +	if (IS_ERR(sock_binding_list))
> +		return PTR_ERR(sock_binding_list);
> +
> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	hdr = genlmsg_iput(rsp, info);
> +	if (!hdr) {
> +		err = -EMSGSIZE;
> +		goto err_genlmsg_free;
> +	}
> +
> +	rtnl_lock();

The above could possibly be a rtnl_net_lock(), right?

(not strictily related to this series) The same for the existing
rtnl_lock() call in netdev-genl.c, right?

/P

