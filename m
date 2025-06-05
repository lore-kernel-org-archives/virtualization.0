Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869B527B4F2
	for <virtualization@lists.linux.dev>; Thu,  5 Jun 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749133515; cv=none; b=F7/21B/od2XkoZS/OCvjn0JEcp6mFPMRugQ2yKzvfC1I4beEag2EGJAQLoPn0VKLhJhjNn2YyUFn5icvIg/1flqPlHtVp0iM3GCIwp6HxYeXAnU4djjL5kDvRIDVIqq6vl5ctsugjcNQgNgE1EM9gfEhqCVBnoQX19dzdvFrvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749133515; c=relaxed/simple;
	bh=X600dW54IagONIXRnn2TcBhMfRUF8CY7hzPPC9iyc/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZ4hPUNaNkDSWRPHv0a4Q77EOTEJHuwsGOsvyf0QmRiFoz8WDDcR8hhG/o5mSFrbi2t9jLc6zxGpEGpon6gRtoAs+3J5hf0BkdXY35UMYHJruiCCLJSI3TMgIf7dHkLeugRRGRJwVEeCh7KwMNspeiMbE0Jhlt6rYGufArLQQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyMRz6cb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyMRz6cb"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso911934b3a.2
        for <virtualization@lists.linux.dev>; Thu, 05 Jun 2025 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749133512; x=1749738312; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gqic3Vsyj4bzSmL05WQaZvcda3GIaM4YL+rFO5Ane1s=;
        b=CyMRz6cb5Dk1loSPZrTMcYdGT604IfF9plFCC5mBMdD0ZjYSoBdJXun7nIbOC/omuZ
         Vudr/bQnhQmL80fc94h99WCKh8Yfxaw68KABFibzziGDTU9cHHgTyyt2GpAegUfMg/uh
         T/qvVhHjrDGpXWOZqkloBdWgvUG/16sG9p3Hq6DJSBQtQAfOcqZ7w7PzlgRkJz+TOgNR
         4GZZzrakh7Y6BQTtu0+mExOMdKe6FXHQRc+zIKWQqGcFTu+M9XBhyrO8yfn8MvMiR8lv
         9bn6xBwvjdgbyGGn/4x6r+qurtS5lCjWMnYLJtfvBYycRq5U3OX+5Kdjajs+EpbSk8Yb
         GDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749133512; x=1749738312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqic3Vsyj4bzSmL05WQaZvcda3GIaM4YL+rFO5Ane1s=;
        b=D+elq39stSNqDFr2N1cyc183+JvN3I8/7hN4DEfk1zdzYOD1I9AVtObW0Wqa/GCyjM
         Nhbpp7bjfu0LiUsG/gQdMg+Lm6/WGGTGyyjsCm8PZi7KOgQ0IVa4+LDUjf5y6Wll5w6H
         W0w7YNlFQ7WdTFCrHcKGBszG0yljIoZr2CeaF0+SI75tgS7ZdCKAKLa1MfXftcWWjN95
         2GH9iigXRpNnfep/LINV2a1uH69ohIEYo2IXby7Bf7+UvYSkDYsezHPx/J39RTqr/0Gk
         7Oa6TL4ohVACzmPLm59soYKxTwhcSlFS+5mQS7wstvuyktgy6LVJY5po6Xctxee5xaXF
         G6nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLEKMX/afrJRzj9kanN7CnSdxQ22HtlEgAjxB7ThdaLXUasT1eGW0ApWMh8YC5Xf3X+6bcUbz1suFT5BVzmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAvA53HC9kgSSr1YirpUHgQ0uf+HLfQ+fHYyOxTIXRhakMkrXw
	SBzZbpasiK+A8TskhXQYBT8PPUu0b6RRm93MMouZSpVUP51WuFmBwLvw
X-Gm-Gg: ASbGncuiAASwXvncG+Tpj6E0uP20hGhvUNH52JNwwProoLlMh0tIYzhAaCtMHhYv0Br
	wwuILrLnS76wlu+IVNT33gwGAdf41lFocqXPi4BZMoxiDAAkyR9hs1Tw8FVYFvKMTujpvTdQuJa
	TmBiQS6jMmD+8I0qVH5ZSPiDHIClKqkkUwvyB80/G/iun0h/aZ7AahMZfmtBkHPE0tD/fUvqHVI
	6t8Jjk1anCslzWiYz3k7owDE1DWKTFgBFvwjV8sFwRVmqbvevGueLYQeJWoSW2XbY6u7IQHFz23
	kzjJXOjSTHQAmWLAp/3d/SDrj5wvt8O5MOd3lVndOHplEFCSkEzzeA1Ar7+NwMv28xdUsVX0sFn
	kTxCVAjxWUGDXEhUwz4ceZ+QRVEo=
X-Google-Smtp-Source: AGHT+IH4vL0ow3LtCX+mnTgMUIKUpP6tlNeWjyc30axYR85Pz7Znrto5PFXe7BtNog4L00G5ukEv0w==
X-Received: by 2002:a05:6a00:13a2:b0:736:5e28:cfba with SMTP id d2e1a72fcca58-7480d023dc6mr9016645b3a.18.1749133511687;
        Thu, 05 Jun 2025 07:25:11 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:fe1:cf75:ee2d:d934? ([2001:ee0:4f0e:fb30:fe1:cf75:ee2d:d934])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeabad9sm13367104b3a.51.2025.06.05.07.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 07:25:11 -0700 (PDT)
Message-ID: <099a66e1-c271-488c-8997-daf07602d16b@gmail.com>
Date: Thu, 5 Jun 2025 21:25:03 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Zvi Effron <zeffron@riotgames.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <CAC1LvL0xTSv9sBRYnD-ykDqQr+Reg7yB0uwAR158-+aAm1J1Ew@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CAC1LvL0xTSv9sBRYnD-ykDqQr+Reg7yB0uwAR158-+aAm1J1Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/4/25 23:55, Zvi Effron wrote:
> On Tue, Jun 3, 2025 at 8:09 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> In virtio-net, we have not yet supported multi-buffer XDP packet in
>> zerocopy mode when there is a binding XDP program. However, in that
>> case, when receiving multi-buffer XDP packet, we skip the XDP program
>> and return XDP_PASS. As a result, the packet is passed to normal network
>> stack which is an incorrect behavior. This commit instead returns
>> XDP_DROP in that case.
> Does it make more sense to return XDP_ABORTED? This seems like an unexpected
> exception case to me, but I'm not familiar enough with virtio-net's multibuffer
> support.

The following code after this treats XDP_DROP and XDP_ABORTED in the 
same way. I don't have strong opinion between these 2 values here. We 
may add a call to trace_xdp_exception in case we want XDP_ABORTED here.

Thanks,
Quang Minh.

>
>> Fixes: 99c861b44eb1 ("virtio_net: xsk: rx: support recv merge mode")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> drivers/net/virtio_net.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..4c35324d6e5b 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1309,9 +1309,14 @@ static struct sk_buff *virtnet_receive_xsk_merge(struct net_device *dev, struct
>> ret = XDP_PASS;
>> rcu_read_lock();
>> prog = rcu_dereference(rq->xdp_prog);
>> - /* TODO: support multi buffer. */
>> - if (prog && num_buf == 1)
>> - ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit, stats);
>> + if (prog) {
>> + /* TODO: support multi buffer. */
>> + if (num_buf == 1)
>> + ret = virtnet_xdp_handler(prog, xdp, dev, xdp_xmit,
>> + stats);
>> + else
>> + ret = XDP_DROP;
>> + }
>> rcu_read_unlock();
>>
>> switch (ret) {
>> --
>> 2.43.0
>>
>>

