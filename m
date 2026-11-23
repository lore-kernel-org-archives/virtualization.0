Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435127;
	b=uWEYEaoQmjfpQFnhLM1wSxEXjGa3258/x2lLVcoqCSOQOmo/2RvQ/A4jVq2Bh1QK8oGo
	 B22aizZGfAdSTSAweARfcUaSxEyJQpdlfjjk7sl72NDl2q8uzWxZJsShC/3oztM37V02V
	 3iPt3R1u0NJ3sQs1EUJQMzN8RmzeXMhQnYQTUWFhLGsX/pKP9kDhd2ZxXC/3ii84WAhy8
	 4h5oziEItPnbU8EmjQZM7zM7cEffeyEr/viuFSclXlVydDPE0qSJt+X0LGkwsWvqtkGRV
	 4zE6fIwiEi5h+sbOl5q18oQSeZXKsoKwYN27/Vforj1nor4eXHH4YtHgQzpb2SzVduw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435127;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=CQFmq1pcPFYCkE6jKPYZE7YR7p9AbOoikjbaytK0pAI=;
	b=qcuGV2+6K7g4hEu+Y67pkWA6zhrfB0wwBbsuI82aOxcaGJp4wfLYd9+QXHp3UG3W/5U+
	 s9F+5mIBu8ZAah8IG8TAau6TQ4U70ERJNPt9Ode2q4xErPxysS+Zwei3h4UTNfJyTXzDQ
	 I79oKMQ34ImWa7ORnqMBW4JYPfEP1eWt3ete1wPrpEKikplRoVsoTpOg9v7vwFr6BR+Rj
	 OJH4T7OzUNvU0MQwBpTkybb1Hw16CAfPUDiMJ5TtuTG+X0uJJpOFoPu9R3ga6CVSI6pfc
	 q+C/qLFyWcPnwtCjzTvqS/FEOyhm+58NmLorqsp4rd9o0bNnmnj/po+mrxgXVp7RJdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bT4u0Tv3;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417DC606A33D
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 11:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 417DC606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bT4u0Tv3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795435126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQFmq1pcPFYCkE6jKPYZE7YR7p9AbOoikjbaytK0pAI=;
	b=bT4u0Tv3CPi6x2xeOnlmhmnf7E+HrQXHrGm6taiSFbmnDMA12Tf8Asgnoo10EtxFDUf0u3
	YNWZFDA5OlPJkILZjN97W96bYccFR7PMS5qLkSbA2fXnsg0pvNde6of9J2p+WJnRViVaMe
	PbcLWKPYg8J2ZLnycV9yY/BrakXpIJY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-eraksgwePIqFkfozNIwOZw-1; Mon, 23 Nov 2026 11:58:42 +0000
X-MC-Unique: eraksgwePIqFkfozNIwOZw-1
X-Mimecast-MFC-AGG-ID: eraksgwePIqFkfozNIwOZw_1795435121
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4aa0500c979so1984748f8f.2
        for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 03:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435121; x=1796039921;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CQFmq1pcPFYCkE6jKPYZE7YR7p9AbOoikjbaytK0pAI=;
        b=cK2rbbVw/TKn05oODoKjF13+ivQQdFNj+BTllmGpqNJBcqUxMM+5CSJscNgj3Os0/b
         KwNRHSsmgCY510o9EUQHXDRLugCXOOB4zyxxxWEfbYTRwYY+xx9LsJP0xPP5uhxM7CgE
         vJQwzxV1+EjQCUQ2LvZwpDGbfGfqeeVDPLQeTqExPiP6vUSDadblztnoIZDzH/xymIpo
         6JV0dqXX9POm23YjLHaPkAT6kBwG3F/6W757fnsAlO9dEoHNvjw9BUa10h/dyf6VvVAH
         c7ne6XbFO2o0Nf8SaDR5h7Kvn+tZt2sOBJDH3VvznyHVrpVTSK84Ezo/Cu6ZC9HHZ3tV
         qUBA==
X-Forwarded-Encrypted: i=1; AL+hErGV4wYY/4Y8iysDGIS1WwqcPlgnaURhNQ2u62ekrPQrEfyGElSOYGTK41VN1mwMSOwi3QNd3L9CivOFPjOhfg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+RhZ0d4D4QdLTlQ8QJmwutA3g3P7USIQDAZv+5SqsGqzk8Qyg2
	TYIEYRmkcWRpum+mDO1jNAj0/haBcA73ME2U3VIkxrVIxfDxtvd1seedhU3OPH5acKv393IdEnW
	jt15mOjsvVdlnRRiGE671GBCQUocJ9Bkhd+EUYOekmNA7ydWp76RU8wJA+BglcuqzP2fg
X-Gm-Gg: AZFdTZddrC9GUvYNKmEsLsX6ZJi0Wx7DhyRYB+vlX1pw8P3aGxRfAHRQuZmbYzu4X2y
	1oClVHbScly67n8TQE6tZJMq3llh9oHBiHTZVaE2yDska97OciEGx+5WOka9yGGT4FCgiXhH69K
	A120/DATndZxrsEe9O3xaAyMzVyp1ESkvdFz1oed1jopi+7yJaYnXHIjhRPEzNy+yJ0EZ5/y8UY
	KrZXXyoudo1gz6J6VZWdbKiBJy4cTUo7IfyHYQGqDQANu/LZyvoXkFxXNIALWpbZXDuzjLcLhXb
	pY+t60uxeW5eXsYECuXHU1AnEHhxYSs71J6+yPhCnC9r8vjTzCkwNC/CgzeC0oeGOSy9mJkLW3h
	IlXBKeAT7S9ISl2o+bnFnKxVxaYtajLywePElG6fL1ZnnIMrAB/GGCbZZcCTJbLFdSXzOgTf8rb
	9IyVlhzXbHm6EXJ5g8UsAYgOfhkxuIEiJCcD7zITYaxfKT
X-Received: by 2002:a5d:5f85:0:b0:4a7:1613:7206 with SMTP id ffacd0b85a97d-4abb57f7b6fmr21999004f8f.47.1795435121081;
        Mon, 23 Nov 2026 03:58:41 -0800 (PST)
X-Received: by 2002:a5d:5f85:0:b0:4a7:1613:7206 with SMTP id ffacd0b85a97d-4abb57f7b6fmr21998958f8f.47.1795435120674;
        Mon, 23 Nov 2026 03:58:40 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b2c9sm22672307f8f.31.2026.11.23.03.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 03:58:40 -0800 (PST)
Message-ID: <12a2b44d-3d24-4b77-9dd5-24361d5fe910@redhat.com>
Date: Mon, 23 Nov 2026 12:58:38 +0100
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: only deliver taps to namespaces that can reach
 the device
To: Stefano Garzarella <sgarzare@redhat.com>,
 Bobby Eshleman <bobbyeshleman@meta.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261116-vsock-tap-net-v1-1-7e24f45adad3@meta.com>
 <awQJo8WE5Gn4nYHp@sgarzare-redhat>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <awQJo8WE5Gn4nYHp@sgarzare-redhat>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c01pVJhMgqL1VeeDv9n4XfPWr6VEyyGcwV5qkaMF9aw_1795435121
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/26 10:43, Stefano Garzarella wrote:
> On Mon, Nov 16, 2026 at 03:46:49PM -0800, Bobby Eshleman wrote:
>> vsock_deliver_tap() clones every packet to every vsockmon device on the
>> system. Creating one needs only CAP_NET_ADMIN in the owning user
>> namespace, so an unprivileged user can capture the traffic of local mode
>> namespaces.
>>
>> Pass the packet's netns to vsock_deliver_tap() and only deliver to
>> devices that pass vsock_net_check_mode(), the same rule socket lookups
>> use. vhost passes the vhost_vsock netns, loopback the sending socket's
>> netns, and virtio-vsock NULL (global mode).
> 
> For local namespaces I think we are fine, but what about global?
> 
> Is it okay that a namespace with global can capture all the packets of other global namespaces?
> 
> Asking because at this point the CAP_NET_ADMIN is useless, since an user on a global namespace, without CAP_NET_ADMIN, can just create a namespace to have CAP_NET_ADMIN and access all the traffic. Should we fix also that?
My take is that the above question is quite orthogonal to the current patch
and may impact old applications relying on the legacy behavior.

/P

