Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802495;
	b=zU10vpJ6sm36oBVyAEnR3PpFwCLkSN1W2QUJGDKxjy6IQwYXMGjgKjCNnOPykwa7CpvR
	 4fRs3e9HqqR8n0FpcoPYSKvu0nOSKKZQ1tpWX8C/VMymWHX8cIdH5AYBVmGNGQuO898Ac
	 55sDAFdfJN9oorrZcQ0Y2OeSBHLx8KfMusi7WeCJzv5rPEGlpV69dvm7PHqbicC3X21M7
	 S+ntgQ1PzOfLxA0XNEnLQnhuR3eeWxAHfZ4WgopO2gB//WmPsp07LOvqrDR6Fr7t7RNo1
	 AApA2bwt5JzkaCzGcRXw+36h69NAbrWYWVDFoJHn7S0fYRtRoHAL90VYSvbxT8m72Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802495;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
	b=2zEC3fV7LnlxPR6wVu5zxPQXKVImJNF7bYZhy76l0T2JHv+N7X9WPRTUAiOYF4MkJ+Nb
	 H1VnblFkXt2yz4597c9Fm4CUDjI4O29JOkrk+QWAdCOZj0rafcjELnerOVuibolsNteNp
	 PLBfkgg/A7yqdCliuY8IieNII9svJ3wPNqz1DJkN5TgwrmQqmOBzKIl5XM/hPnP70gf3S
	 ANBS9yECjNjbE7i41Ne94bitDZV/u3LL0rKZ8CrZpKz2qR5kD9+MTKSqh0eWQh/QJSh0n
	 0sbaDVSXchMkSQa7PtgCXf+uCOprDFSYBHwP9rW44JPD/afZ8GN/cxlmquOAz2pWw7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UCCgpa0h;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1F606A32C
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 14:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85C1F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UCCgpa0h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793802493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
	b=UCCgpa0h1y5+YbuN7Y9mcWyeMbYvSsWTkRRsjbxugC5r8oPcixNo2j0t0+l0nJrPbeB9xo
	nwbUclSoDqXyo6cVKm4u0py2WzalOC+VGMxyhMM90ycDKgpIIsYFamqAVgtByNvLZlpMgU
	4SGvFc87JltRAOQicXyH75IoPEmwx5c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-0QNgGPgpNamOPRJJdcZ8Hw-1; Wed, 04 Nov 2026 09:28:12 -0500
X-MC-Unique: 0QNgGPgpNamOPRJJdcZ8Hw-1
X-Mimecast-MFC-AGG-ID: 0QNgGPgpNamOPRJJdcZ8Hw_1793802491
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b01a74792so680426f8f.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 06:28:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793802491; x=1794407291;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4/Evz9fjrrpCnCXycWC63zfKI3HUYi26oAG2Biknep0=;
        b=P2juzrXqnD0JhG+kaGdV7u4kpBNe/fsGCdqnWW+e3BsgMG0B9+Aqx/VaS+1vf/FMSn
         pD9JS4UpDUQPj2cPZyll1Zhc6FvjIWhYySmZk6ydACs0PQ710btsDscx16PZP/BxFIa4
         IoczsyY1n93oZuZpjccj5fh3bXA7vpxfc/2VsZgNCiV+OdDDH1ev8Y7QsidPObru8GFS
         5WGasTcLW47SxN2al0rc5klDl6C1Ovwhz4VMBs2tqgNYO3Pz09SQhoBx+PQKw7ZJh9VF
         ie+dRIUJ0GaDaVP+VQ0yfIdZ2vPfRTfTfCX8cUuPAPHtxMdK2OSiz6k4Qj5LtJRfxQBB
         FICg==
X-Forwarded-Encrypted: i=1; AKwUvBzv8bm5dXX4Twb3tde1NwGrYcaAHXgrzQ+Ww0/hz0gG9EE8V9uF719ZblZY8K9BASU4hOfYYgodsFrT2W3SVA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/N6oVL8saXHBvwKAlChdEmysm2NS4N34UwAJ0zhb7+cmLBPJXs
	st6jyAJj8BmNeBfehCyZXrvDuBfhAvDCX44WINEf7tvjQmE0d/l+4kuoTIqboP0RDZDOqt2U68d
	vvklGe8lOMtnay6RUlDgoKGKu96rQSEd8uzitPfC8lUmMYSLbXG9Rh+ZYyiBgkOj/iTXe
X-Gm-Gg: AYBFou3YHGbJMOFp8LnhBe8vizOUPwPWT6bkIqVY1gmnVD/ms0qPUgRU+Kq0XaPe/42
	0d0bvRDBhpG5XiCA5Yk8H+9dbA2k5JFuvBWHLwFo+qnOoVvv/kKHlWJvfKOtNsRzj4jh3rQx/5l
	ruGbisAZh4ea7pCkAiliiMpU4qmCJwvmqLmNAcVDyHV9qF18maoXqgpQKyIE4AzunLseAM2qk3r
	DE+iSE09EmmLP1voXkskOU+O+7MI9LR+tCkc4Pw84l+iDXYpriWaIudm4NX2AKffoFoLqa1YKND
	yaPUvs5ZMYCgp9QEavTBqCkzzQ856JdcKDEcAAe97ZoN5Sc84ypQtTbOdQ9+Aq3BjlsPz4+a8Bp
	xlQ5BezC903AEPWhgrN+oY3j08hzHRNVTR7FXZ0xIeO4jHGI4iZ0BDTKCJvsK45fTThQN3JZ9Ty
	qLXV83FYHXFcTVcemMHMIktrx/0LEVoPFZwmok1A0cuIE=
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4ac1719112emr360222105e9.9.1793802490758;
        Wed, 04 Nov 2026 06:28:10 -0800 (PST)
X-Received: by 2002:a05:600c:4e08:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4ac1719112emr360221625e9.9.1793802490212;
        Wed, 04 Nov 2026 06:28:10 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a9faff90sm162472315e9.5.2026.11.04.06.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 06:28:09 -0800 (PST)
Message-ID: <ae9abdea-6c34-4386-853a-862f5f16b031@redhat.com>
Date: Wed, 4 Nov 2026 15:28:08 +0100
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
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
To: "Michael S. Tsirkin" <mst@redhat.com>, Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 "David S . Miller" <davem@davemloft.net>, Will Deacon <will@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261004235101.1464007-1-4ncienth@gmail.com>
 <20261104065405-mutt-send-email-mst@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104065405-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oyyXAV7__8maivDdPoVmOJg2WdqGFFG4N14cTIGv9Xc_1793802491
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 12:55, Michael S. Tsirkin wrote:
> On Mon, Oct 05, 2026 at 08:51:01AM +0900, Daehyeon Ko wrote:
>> vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
>> descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
>> rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
>> guest controls the descriptor length and hdr->len independently.
>>
>> A guest can therefore provide a 64 KiB descriptor while declaring a zero
>> payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
>> remain unchanged, and only the fixed queue-entry budget limits retention.
>> This is not a lifetime leak: the skb is freed when dequeued or at socket
>> teardown.  Repeating this across connections can nevertheless exhaust host
>> memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
>> a 262,144-byte receive buffer; a full-payload control retained 265,984
>> bytes.
>>
>> Vhost previously read hdr->len and allocated pkt->buf from that value.  The
>> conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
>> from the descriptor length, introducing the allocation-accounting mismatch.
>>
>> Copy the header into a stack object and validate hdr->len before allocating
>> the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
>> capacity no longer determines queued memory.  Check payload_len against
>> len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.
>>
>> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>> Cc: stable@vger.kernel.org
>> Assisted-by: LLM
>> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> 
> 
> Weird that this wasn't applied in net yet.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> let me know if you want me to apply this.
Someone change the patch status to 'Not applicable' likely assuming it
was vhost stuff. The patch fell out our queue, but I just applied it.
I'm not sure if the bot will catch it up, given that the patch is so old.

/P

