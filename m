Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287326AAB2
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750759377; cv=none; b=BX9tzRLxJJhtrGwlGmPaOMaKDO0d8e9ttht0PPTF8imcgOYB2PBbOkhvvs4ch3ZeepGNVUuagDk9ttsJGzGpg8Phxht3oDlwhfxKgxQQu6MznbgxVhskGYGAuaqqInOgriGw4ITRy4wZv0Vn0rBRdH75kzFVRieye2iDWKUhEHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750759377; c=relaxed/simple;
	bh=iOw/L11BDQrjLHtuit0xpOKB235eAAjDVcmGUBFHfS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehxesehEPsOPdYaVhdO0ZljizUtTykagdtrMG8sFIxsy9Tirlld7yRX+7B2b8FHp4rzUojV3Ux/Y0NLMwz8gW8YM02gmTszPyW0jlL60YzGreaP8lhlsELd8/9ThBQV00P+gTQLTo8Uzii2AcyFrgUWxtE/t08KwDDO7/2LCphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDGXSErI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDGXSErI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750759374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRBtRqPAyg+QV0d52jJWOCZGpVdQ0NwXgV55dkzF008=;
	b=MDGXSErIRdeXkMn3oQSD8twgpjlNW+gPlgRzmLgByd6tVAiYdy+N0IIcQBJvHjNkbeiT2G
	GkJoi9OjlcJerlz5xTG7ra7NpGlPPNEMSByY16XDiDLKTv5yE9HuWZs/SXR2uLKClIxmtw
	YhZKLzAx55Wo1N981oVZN2A01KIinJ4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-Zph0_D8QNBWUfRfOKnvWAw-1; Tue, 24 Jun 2025 06:02:53 -0400
X-MC-Unique: Zph0_D8QNBWUfRfOKnvWAw-1
X-Mimecast-MFC-AGG-ID: Zph0_D8QNBWUfRfOKnvWAw_1750759372
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45311704d1fso32822075e9.1
        for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 03:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750759371; x=1751364171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRBtRqPAyg+QV0d52jJWOCZGpVdQ0NwXgV55dkzF008=;
        b=nEkjkouNPxqz5gU7nIW5uYpLb2BgJVY0w6o055y/dzfw+AtFpJTQFb3B2TwAVYvEC6
         f/wNMINY4jO/g9SuOYpTFtLiglRiMJbkKNz3KGAb6R5CmTNw9+m7wzKzISueCCb2qQVv
         l0qFe4tb5sCfTvr5lQFS9REUO8Q+5KpE57fprcVcogmzuVSmiSH6HamN3wOHHaBgrUt8
         QpgGa9l6kA5V023u/FbuUB6zTA1VVx9G5MQqDta6oUfFTaHW4P/po0NU89Mcphiy2Kqg
         cBKXoJKJo104YFiQ1IsnHld+mGXV7V7M/LHkSrkzr5iQxawwQjlV15w0iVanDYQR5+Js
         ASvw==
X-Forwarded-Encrypted: i=1; AJvYcCVWKpR8ZBRFLkxTF6/1R6xJk9WfmovH0NMj8nHkPYJApb4DNs4QPAOv0zMWWVKKItSyBcwW55x88dyQFKxmFQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh0NqYptZm/xFplcLEbk/TKFoRwrBo4j0QmynhVDFpx23xu4iO
	1DFaE+gF+FvfjKb9egKB7U5Uw6drst4Fgws9zTNombZH5ewu/wGpPlJs8hTte//yqQyrQudwuds
	2qGjPfOZFNqD3k0xrGx/1TxwoEjAel0nAMu4j385vX6y00z9o5mh3gWRfzsaHfcY21Yqovz7kTM
	EKAEA=
X-Gm-Gg: ASbGncvCP3mANqwF6OYGayLCc/nwmydYGs2dspQFPz+YFf5qLvmNC7YBnVoJgA+mk34
	K+69AHWnKCl9+jkyUy5TgdJA3zugjh6rg27K9QNmvLl9FQyOoqWD4glfbPDJfkR6rk3iy1dCmmn
	+I+nVMroEXvMb6ZOzM/v6PeTiqbF1Pgj0fJdePYNzJqNU4ZtylwlAWTGPFf7moKtep7v5asAXL6
	iQcJo8ptiBtL8Q/Ezm9AZaX4lyMscqtciYw8Lz+yIgwzaTiQGHxijH0jfzc4mewvsx5N8VtW4Yc
	qK0o9veZmJ55N4qDd25hgdkMZ7s/rg==
X-Received: by 2002:a05:600c:1d95:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-453659c9cd3mr127323015e9.11.1750759371554;
        Tue, 24 Jun 2025 03:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4nOxjPFsJ1eZqeyQQfzna9JUiKLhgP6SNKYrgYsBIKI61asj0UadPwdpCO34yq47DYpw21w==
X-Received: by 2002:a05:600c:1d95:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-453659c9cd3mr127322615e9.11.1750759371097;
        Tue, 24 Jun 2025 03:02:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2445:d510::f39? ([2a0d:3344:2445:d510::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead202asm170467905e9.27.2025.06.24.03.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 03:02:50 -0700 (PDT)
Message-ID: <5fb3c0e4-759c-4f56-8a78-e599c891f618@redhat.com>
Date: Tue, 24 Jun 2025 12:02:48 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] virtio-net: xsk: rx: fix the frame's length
 check
To: Bui Quang Minh <minhquangbui99@gmail.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250621144952.32469-1-minhquangbui99@gmail.com>
 <20250621144952.32469-2-minhquangbui99@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250621144952.32469-2-minhquangbui99@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RZMbAZKT4129AI3KtXOq2I4a4D7OGIyvfDWDezl13HI_1750759372
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/21/25 4:49 PM, Bui Quang Minh wrote:
> When calling buf_to_xdp, the len argument is the frame data's length
> without virtio header's length (vi->hdr_len). We check that len with
> 
> 	xsk_pool_get_rx_frame_size() + vi->hdr_len
> 
> to ensure the provided len does not larger than the allocated chunk
> size. The additional vi->hdr_len is because in virtnet_add_recvbuf_xsk,
> we use part of XDP_PACKET_HEADROOM for virtio header and ask the vhost
> to start placing data from
> 
> 	hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
> not
> 	hard_start + XDP_PACKET_HEADROOM
> 
> But the first buffer has virtio_header, so the maximum frame's length in
> the first buffer can only be
> 
> 	xsk_pool_get_rx_frame_size()
> not
> 	xsk_pool_get_rx_frame_size() + vi->hdr_len
> 
> like in the current check.
> 
> This commit adds an additional argument to buf_to_xdp differentiate
> between the first buffer and other ones to correctly calculate the maximum
> frame's length.
> 
> Fixes: a4e7ba702701 ("virtio_net: xsk: rx: support recv small mode")

It looks like the checks in the blamed commit above are correct and the
bug has been added with commit 99c861b44eb1f ("virtio_net: xsk: rx:
support recv merge mode")???

/P

