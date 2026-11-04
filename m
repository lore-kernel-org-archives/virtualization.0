Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793787104;
	b=sYrnYoHG1cJM7eeqbPqKlej6uKKv0d4mVcfKK5oADHQbMaAN3imkE9fojQZGPUSIhA0E
	 oysJMOJUxi/YF2zrpAxDjxQUexjCuxYxlbx0+HyJYNtDTetSYLwKc9ZsIzH2Jw3X3Pg7M
	 Z/BhTF1RFkudHsMzyfGQpDr9SnzUNze/WhU1CX/2mHYwgeZgjW1A3Fw0fMBB6S55IYDiS
	 g3H79RClEMGuKRBN3M1sDs/zGS8p9PSZOKkUa3QIOB+oKuhwclvMRUjyG+q//Jut6k/pH
	 KJwYVtGyibhjbtfbktIlX2sQk1w9EI2kt/7qhR7dncPT39+67Mn0A3y49NmlQl0KzOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793787104;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
	b=j0EuI7NhmspFwxORFegT1rh0utxgXhQozjHIoHRNSCOpizvyUusGOmJL8aKQ4Jh+1M1u
	 YJv4/zjDDs0QV1sdVfZ1bxtLVQdahixIm46TjhyImYY4dem+jR2FzKJsOGWW3oqJf4HHm
	 uti5kHn+V4w4U1MUm9tUcSFKH8JZ2y1LF2lfk8Rl6E3V4LBJU9ty7Swvl+PoXSONhhA8N
	 O192bCp1vYa5lTlrZiWUslRRSMk7AzPeCgLojO+BF+u3qYlW8heJm+P5tqmaqvB1wcBUp
	 THwoSlUGa+u5Jxf7hrVkfztvq2pt8b4NvbGT1do9MFFHOIp+EGgfZhSZSVPRgMhuITA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B4CAEi0g;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F4606A329
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 10:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 760F4606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B4CAEi0g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793787102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
	b=B4CAEi0g+Eege96Aa7kftBIhI8zsH/XTibbeQdbfbtSXlAVyXRzaIoVY4Bpf9rb2u1tHvu
	NrkBXEhirRSFaLS+YZNgAOJsFNtmZI/KrfjIQP3hQg6lBg3Bc1GoXxQmgdeGgYXlK9/+M7
	72+Q8c90X8iAVbzTcdtpNY6qSXbR00k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-GJiTQSS5OGqPt9GXlLZW0w-1; Wed, 04 Nov 2026 05:11:40 -0500
X-MC-Unique: GJiTQSS5OGqPt9GXlLZW0w-1
X-Mimecast-MFC-AGG-ID: GJiTQSS5OGqPt9GXlLZW0w_1793787099
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0fc747a7so470254f8f.1
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 02:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793787099; x=1794391899;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3P3F07LgVW54j5QwwolaMPEk7ysthqt1GzeeUPtiwo=;
        b=e/D7V/UNTqNJkqw4zVZhJqirQGY//07/iQ1gBgca0JCAiB4iKLVsKU7498iQ085mgX
         NIzs0c8OdPKWsXNVZSWQtydBruuwAq2c3jrVZtmcmdAHYG9elXf1og7x2oNiEMmjODyY
         lcUp9J/VC0siUUahEvpsQi2C8Qyo1qNqwQ1kP2TPkmnNOLBygEZAaoNx8KLMAjIjMWyy
         Qai/0ztR+lqdJFzzWcb+hA5Q3OpGhR6ICSBXGK3IjdYk3PZ0Fw1IF5Y9JKEyq1OH+/5z
         Y4rJU7TNLhv92ANj6NLxuKR34XkAfXRUgJ4QkkK6CftzG7Ck1h0TqbpAr8Ajhsl24M3B
         4FAQ==
X-Forwarded-Encrypted: i=1; AKwUvBygxcCU9U2qoIqzlHnZ68dfj8ChEIeQNwxWP4C80EuWQXjoupv8H9hJbttbrnY1A7AexuZKvAHAmZFGWhaEPA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+3w7jPXUsr+pSYov6kzgj5QmfncVdqxegR3dl62pHK6gSl7Fc8
	cDt0a7Fx5Tt2Xcu/i/RfBFTijHV/T3ssVQ0AnODGnluBGMcHT2ehghztM7uV3uiJwDc2kwsDOY2
	Hg7zzXNlreAa9013cH7pYVfLppc5Dpe4pfejL30awWE6/CY+uKFXv7wsphI4VGQmfK9VF
X-Gm-Gg: AYBFou2nTTwr8ztH0WCcBCsj9OtOwFX+VfRK9VxjdGDLF1E4/ajgika4NJbc+oWxzzb
	6AhioIMPjjZfIAOUuXMBl06OeN5au2d4fgOLOCTuEmdlLtJ90oe2ZiqQGWXwJoVTX5AKIxPwjbk
	8tXM2E+6y/mjFifBd4XMbQfGRjmYlOu/bdfu9wsmkyZSX1gw/0NMvu+EQBuKDwjzqn+40N9agef
	btDf8KtSuGjuUB9rOTiWoAWLPOU3+iuTp2AkpVcS3vkTKdukuEToGR8S2dYyLtXODUI3PhAJ3o1
	5IRxNsHr4PsUL0co1k9vXb33NKp4rmvan6KFQ+z+5bOn9fY/CCcqCDe0IM1muBz4jlCNXPym+Cm
	6tXZe5NiEUeLPUXS2Ox68wcivvUPa9n4EMuaFiQYf2fQlEV2/nb+5
X-Received: by 2002:a05:6000:4b02:b0:48d:f99d:a0d2 with SMTP id ffacd0b85a97d-48e6e2e76famr33250712f8f.15.1793787099081;
        Wed, 04 Nov 2026 02:11:39 -0800 (PST)
X-Received: by 2002:a05:6000:4b02:b0:48d:f99d:a0d2 with SMTP id ffacd0b85a97d-48e6e2e76famr33250672f8f.15.1793787098615;
        Wed, 04 Nov 2026 02:11:38 -0800 (PST)
Received: from sgarzare-redhat ([80.116.143.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18104bsm3214680f8f.6.2026.11.04.02.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:11:37 -0800 (PST)
Date: Wed, 4 Nov 2026 11:11:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Simon Horman <horms@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "David S . Miller" <davem@davemloft.net>, 
	Will Deacon <will@kernel.org>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Daehyeon Ko <4ncienth@gmail.com>
Subject: Re: [PATCH net v3] vhost/vsock: size receive SKBs from declared
 payload
Message-ID: <ausD3NBfYVn-n5ra@sgarzare-redhat>
References: <20261004235101.1464007-1-4ncienth@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261004235101.1464007-1-4ncienth@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: An6LUSrsOO98wwEzsnKwwuA9hCckcagJ3NhYywtCAIQ_1793787099
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Oct 05, 2026 at 08:51:01AM +0900, Daehyeon Ko wrote:
>vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
>descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
>rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
>guest controls the descriptor length and hdr->len independently.
>
>A guest can therefore provide a 64 KiB descriptor while declaring a zero
>payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
>remain unchanged, and only the fixed queue-entry budget limits retention.
>This is not a lifetime leak: the skb is freed when dequeued or at socket
>teardown.  Repeating this across connections can nevertheless exhaust host
>memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
>a 262,144-byte receive buffer; a full-payload control retained 265,984
>bytes.
>
>Vhost previously read hdr->len and allocated pkt->buf from that value.  The
>conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
>from the descriptor length, introducing the allocation-accounting mismatch.
>
>Copy the header into a stack object and validate hdr->len before allocating
>the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
>capacity no longer determines queued memory.  Check payload_len against
>len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.
>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---

@net maintainers, please can you queue this?

I just reviewed since I missed this. I also had a quick chat with 
Michael and he didn't queue because this was marked as "net", so let us 
know if you want Michael to queue this.

Thanks,
Stefano

