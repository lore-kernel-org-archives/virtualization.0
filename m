Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D932D4B54
	for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775803; cv=none; b=EFEa/UesF6s9zXYwhqg+eNEeztaZ4nik0n+ArAAOTDDdDYz5x27z3KGTkDT31qIcDLdDsqozFVUUnT1QPSiDStPRxLd3FaxFbPexFvjmNdEu9BBXg+vTxCcTfkkv7NRPmlrwA5wBPOWpHq6UEKz/q4ZswhAS+xaxN914T4QzpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775803; c=relaxed/simple;
	bh=cGvID7iNjFw3hCX2Q3UbTMYpmXpoJ9L97AGMCmURFBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUyO20NSCzRya7/C9wlbrMz32GUpa2CAVfsFFAwOY+i4OFSsZitGUPsVjemlIFtaeMJAqjhxdEVKuO1VtIFi0SfYzxop8HrODsyRDm91/NDAo+4Kv+PtQv/0xGviYGC/mpwgXeOVeAur7uhLiCFhGm1JYJNM5wURYHgfdgD0ujg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAVWCa/1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAVWCa/1"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3121aed2435so634676a91.2
        for <virtualization@lists.linux.dev>; Tue, 24 Jun 2025 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750775801; x=1751380601; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTVh9NYfR7GuqBMwngWQvuBj18Bm8G+r3At4Sh1jKm4=;
        b=ZAVWCa/1Q8F6Vnx74OGAb7qNwUMdVpTPcPKCO5K312XFt52GVPEAxaRi6XYCEZe2uY
         nrRRIOmx12QhCABSbeCCSSffkrJvFHLcGu66QSQ/VrWYrPvDpsGHWZmUEithqRt9h1/y
         u7172yDw9U1xDCLkJixRvrAMJ+XFj4vDMGhZZtG7FLgm60n5eBj/OdKRJS91Z0BjuQnr
         SEpl3QYmS5I9ibWar+4+4ZObV7h9/sUPDkOUozHTU5ZkcPCGVAzm/MkKzMVm+Be0BylU
         Ylbn3yIrHHBbdbpG4zQH9NmlOrvi6EkhzkKg43uWUfsMWJGhM08W13c46vBweWETO7XG
         Xy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775801; x=1751380601;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTVh9NYfR7GuqBMwngWQvuBj18Bm8G+r3At4Sh1jKm4=;
        b=I8lWn5hEQV/0e94WfinvAFtWDg/iBcwsmWaO3RQNlpPieI0YIQ3feVwbxpystwnVQy
         dXTpHrhZM9LxXrlok40JTGrlFqgl4UEAtuCLqEwQU+GDlBhRqGnNVklntw+R3jYIAxki
         pDyARqjAoJ+4lxiUVuK0RuToIQc0bdEZvCVVeWZlUE46rJkHxLvle8J55J6daTo9iUUE
         cLy6/hTY9jugmjjsls5f28YzIfndc4bFscVjUCt4StsZ6t+3kQI2YCEeuZt5KG2yWp9p
         d2KcykK9ln7+V9QLY80njM4Tnrv7STw2dcM8E9U5OkKpSgTR3sV6tuHaXyQ7MWIYD+AF
         HLzw==
X-Forwarded-Encrypted: i=1; AJvYcCX0lHdVn3cI53a9F1GJnygsC2ys0p1eIG9C6SttKQOCheYGLr/IsI6m59KBMLzQtuSQaSw0+XOO6/U5MQdl2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YygquKlPZ1itJRmfT1qDZSP4DSbL7ziIJmcOfnTUR+swVjXagAS
	3mcFzq6/N1+Yyn4G2BfOJUiP5Zfeg0YHL9kr3nYIlgYoKE/wTSukLHv9
X-Gm-Gg: ASbGncuejSLNx7XFxs8QOypUnTK4xA9LcTEtwsn5OK5p6zrN/trv3j9HKmUl8OgpILN
	BiDl48DC/2nQl8RfX/MSTyF07lW3udEqo5PLTcZXqp43eDvQNpcKfDgsH2UxFzppJPkB286TN9G
	aMbSL8XciDZEBUGZYqrpyTtiCFDOzirqRuuzI2rqN8nxu+++HOmqL8GGKJ5tWyTqJ7gA+BUSqd7
	xoE/ZjeS2zv2M2s9VW3B/FlGiWrmt0aTRYkmiI6SDMMkBgNhkQ1/GJI9+DVfFxRKwu69JijVccO
	qaLxbnUng4lySCjpap5Jb/xNiZTHx3dCsaqYc1wA/jnF6o9oUMXSmo3zI1fZo0VkCUULWjLcKPm
	0KjH2sbEpVOXUiE9RxtAW/xjoveXZvZeKtj3VeiNr
X-Google-Smtp-Source: AGHT+IHS9vDnuU2WNVX8FwC7SNF+yJeYaFCaub11naFV+gQ6pgp9/gLGfgnq2n1F7kLFckIWmcXERw==
X-Received: by 2002:a17:90b:4a86:b0:313:1e60:584d with SMTP id 98e67ed59e1d1-3159d636181mr26151303a91.11.1750775801107;
        Tue, 24 Jun 2025 07:36:41 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:1f60:cc25:9268:94fb? ([2001:ee0:4f0e:fb30:1f60:cc25:9268:94fb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e07cedbsm11714380a91.42.2025.06.24.07.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 07:36:40 -0700 (PDT)
Message-ID: <88387a67-98a4-4179-b685-18c2098fcdda@gmail.com>
Date: Tue, 24 Jun 2025 21:36:32 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/2] virtio-net: xsk: rx: fix the frame's length
 check
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
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
 <5fb3c0e4-759c-4f56-8a78-e599c891f618@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <5fb3c0e4-759c-4f56-8a78-e599c891f618@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/24/25 17:02, Paolo Abeni wrote:
> On 6/21/25 4:49 PM, Bui Quang Minh wrote:
>> When calling buf_to_xdp, the len argument is the frame data's length
>> without virtio header's length (vi->hdr_len). We check that len with
>>
>> 	xsk_pool_get_rx_frame_size() + vi->hdr_len
>>
>> to ensure the provided len does not larger than the allocated chunk
>> size. The additional vi->hdr_len is because in virtnet_add_recvbuf_xsk,
>> we use part of XDP_PACKET_HEADROOM for virtio header and ask the vhost
>> to start placing data from
>>
>> 	hard_start + XDP_PACKET_HEADROOM - vi->hdr_len
>> not
>> 	hard_start + XDP_PACKET_HEADROOM
>>
>> But the first buffer has virtio_header, so the maximum frame's length in
>> the first buffer can only be
>>
>> 	xsk_pool_get_rx_frame_size()
>> not
>> 	xsk_pool_get_rx_frame_size() + vi->hdr_len
>>
>> like in the current check.
>>
>> This commit adds an additional argument to buf_to_xdp differentiate
>> between the first buffer and other ones to correctly calculate the maximum
>> frame's length.
>>
>> Fixes: a4e7ba702701 ("virtio_net: xsk: rx: support recv small mode")
> It looks like the checks in the blamed commit above are correct and the
> bug has been added with commit 99c861b44eb1f ("virtio_net: xsk: rx:
> support recv merge mode")???

AFAICS, the small mode has only 1 buffer per frame and that buffer is 
quite the same as first buffer in mergeable mode. That buffer still has 
virtio header (though it's smaller than in mergeable case), so the 
remaining space for data is only xsk_pool_get_rx_frame_size() not 
xsk_pool_get_rx_frame_size() + vi->hdr_len.

Thanks,
Quang Minh.
