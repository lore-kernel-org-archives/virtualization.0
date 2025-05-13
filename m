Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A14213236
	for <virtualization@lists.linux.dev>; Tue, 13 May 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747127534; cv=none; b=KkJbaM9XJCD3EoXVJdJWtbJ3WkN06UWcekPPLbF2wVD6ddew2psV2k4Z97HdOqVzQvYJVcVzHLpq0cIomJW/xNG59pgqKeZEAm4Ab8CU8au/5rzMRVuNXLTy3WtHMHGZQLSpBdbUJkxyJgya1rKzK4xeXwjjld8Mz1Q9zsKjOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747127534; c=relaxed/simple;
	bh=WDlpFsWbDcfzZLGnp/d3QNExJHb0unwOgNVXbvwod6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ptJHkUlBt6A4nPb8lXHwCx/orH0eQu2WRlsgqQS8R5KT7e6XBsCSzZL1s8LSp23T1iyMTlLNk1hOb/45Np4iL+XFsP4JM/EXhDNrANSPcZTd4uU+AbWwiAspNbFiEqDYgaGXb4cC0wVNVHwEgi2l33Z2hkQ897005uOSXyj0+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ekbry/jO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ekbry/jO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747127532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lSKXGvXgaIuXifWFUaLvMDff9Ik6twAKIvR+Y496sQE=;
	b=Ekbry/jObUSQRX8xW4GM1rna301AS0U6fb+sbtH7CggGxS86Y6uc0aTznIoURt0rmsRlrK
	NvAWbD+h/0gNYcGwoAnC2bRi9kSBCBZpsNcMWScFLsvF4rmpmjp4238kiKVEWkKxD/faHo
	BcNHUZNdsKpig1CM2x6GCZQos5hH6Uc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-SLcCT5LSMLmKtRyJGlHxoQ-1; Tue, 13 May 2025 05:12:09 -0400
X-MC-Unique: SLcCT5LSMLmKtRyJGlHxoQ-1
X-Mimecast-MFC-AGG-ID: SLcCT5LSMLmKtRyJGlHxoQ_1747127528
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cec217977so26716645e9.0
        for <virtualization@lists.linux.dev>; Tue, 13 May 2025 02:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747127528; x=1747732328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lSKXGvXgaIuXifWFUaLvMDff9Ik6twAKIvR+Y496sQE=;
        b=M9YJZlHmgg5gjsIWRFlOxx4tA7ohAmBUvu9vLKRRM/Akv9QZ8JQGSU1RmSHSIIwOd8
         jVwaX5v8Qd+9BV2nDyPAxRveSW1jItmx0Mkhhr6tBcLZGsxVv5U2lADHO2Kh1FJIxBjH
         wQ5U4VfaTY325Qcj+3OAmO8kFuHrNWYYfsvnGBg4gR/ZnBzz2w0H/fCBMlEwvXAB5rki
         pIw9ZXHwWqGMTeLuqgGbiJQAOhGD9qKpmkWjG8S2RwvUKuoeY20J1ZAjnxsgKC4Q51wT
         oFMLofe8gIOb8fj3B37Vicp2zVk+HaeAGbl2HdexMtJ1X4UKPKpFuU76VXQYA7LkiSan
         G0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSiwJoi/JVBV1kQ3trnbUzRdZDJek81cWmp+rh6lHB811JBMZpwHHDOji3pPlbS7FkVEFIVS19FeQZ42mKAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YynfoHLTsn6Sc2QmBWmnWf3QMm4ebfSuMMBXSAHuXbmCO9p0GRa
	W5NLKfZ1swuQVuHRe7sEvoWRJh0gPTfwlkyuYdHJZHxK9HQ/40t1gmqtEZ7ZHqapsgsx0zXbK79
	m2TzMuq/5LR+11jbqYDSuph5l9MgmfBxcz9Yf84I0O3J5f05nRbA8OZI3Az/G3nKj
X-Gm-Gg: ASbGnct6h6q3PGSQR0+ErnvuqwzRk2c/ScpviFx+wx6TEPw8wmlwOz/SoaDDEsVfl77
	0yXgnLBcK1H7h1GIxH+5fklzJAepiuiB0pb2oEaZAs8IDirgqhObD3KOZ1RAlGoJ3rit1JxcHwJ
	ZbqVFKCjLnEGvxXfSR2O6/TfECoyWGllmp65K+Dd9W5Q/6fiz2xThLOqzk1U1rEKPZlBBisqlk4
	DmCeN1fBIHHrzrowrmQx7wGCD7zCz5LJxTomkt10DpSL7dkMSgJEAAtUU0nIzPyDJ0psXK8lWQh
	ogPjvzS4pI71oSBXRgI=
X-Received: by 2002:a05:600c:4454:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-442d6d44aa7mr175599955e9.10.1747127527683;
        Tue, 13 May 2025 02:12:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7UByCIdv1fV6GeTCbxFUgA3MTskc+HSiE9ez+aliKyTiJ4Fv/7gBQk/cE3vpwwsDlBoiWaw==
X-Received: by 2002:a05:600c:4454:b0:440:9b1a:cd78 with SMTP id 5b1f17b1804b1-442d6d44aa7mr175599485e9.10.1747127527311;
        Tue, 13 May 2025 02:12:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc59:6510::f39? ([2a0d:3341:cc59:6510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442ea367102sm36670345e9.3.2025.05.13.02.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 02:12:06 -0700 (PDT)
Message-ID: <085a78fc-acfc-4a86-9dbf-18795ad68b4c@redhat.com>
Date: Tue, 13 May 2025 11:12:04 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v14 4/9] net: devmem: Implement TX path
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 io-uring@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jeroen de Borst <jeroendb@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn
 <willemb@google.com>, Jens Axboe <axboe@kernel.dk>,
 Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>,
 sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>,
 Victor Nogueira <victor@mojatatu.com>, Pedro Tammela
 <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>
References: <20250508004830.4100853-1-almasrymina@google.com>
 <20250508004830.4100853-5-almasrymina@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250508004830.4100853-5-almasrymina@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PszeYXljGkYccptHTEecGEicTNA-BHK-vSXK9QMvZ2M_1747127528
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/25 2:48 AM, Mina Almasry wrote:
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 86c427f166367..0ae265d39184e 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1059,6 +1059,7 @@ int tcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg, int *copied,
>  
>  int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  {
> +	struct net_devmem_dmabuf_binding *binding = NULL;
>  	struct tcp_sock *tp = tcp_sk(sk);
>  	struct ubuf_info *uarg = NULL;
>  	struct sk_buff *skb;
> @@ -1066,11 +1067,23 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
>  	int flags, err, copied = 0;
>  	int mss_now = 0, size_goal, copied_syn = 0;
>  	int process_backlog = 0;
> +	bool sockc_valid = true;
>  	int zc = 0;
>  	long timeo;
>  
>  	flags = msg->msg_flags;
>  
> +	sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags) };
> +	if (msg->msg_controllen) {
> +		err = sock_cmsg_send(sk, msg, &sockc);
> +		if (unlikely(err))
> +			/* Don't return error until MSG_FASTOPEN has been
> +			 * processed; that may succeed even if the cmsg is
> +			 * invalid.
> +			 */
> +			sockc_valid = false;

It occurred to me a bit too late that this chunk of code could be
cleaned-up a bit using a 'sockc_err' variable to store the
sock_cmsg_send() return code instead of the 'sockc_valid' bool. It
should avoid a conditional here and in the later error check.

(just to mention a possible follow-up! no need to repost!)

Thanks,

Paolo

