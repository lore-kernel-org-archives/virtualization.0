Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208334;
	b=hFWv3vaRUkTyGfWfMAX5lAOHNlCtNk1p6WJ1khbmVVVDfbZO7sS2+HrphohgasJqIark
	 ZoRNrf3afkPuNJQygJrWLrA2i4+i60E3LzHNCwdqdt56PgJs0g1r5v7qMJtUF9wvYFoQd
	 uci7xnwfNSRToMCGHA0m+2NdBIaQVcLQAzmpxeOBgDLnVQwVhTO6peJVfSpiTJxumIw/4
	 MhKcOTdGE2E4ceFOPtT7SpK9BuwOQTi31BQpskUau20MpoAE1/nis7bQuylGo1lkrKukD
	 vKOnuQ45lLE/LA5AGd9UfJV3ZEmWb7UuJ/zAal8MQvXNqfjLmuHu926osnbfaMUYoeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Subject:From:To:Cc:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XLYiEepDtnyQ6wJ1rlYe5RaJc/i8ARvs/UjwaNMVQRE=;
	b=Qa6aTutfHS+oU15ktGmQyneXLzQnRirxYFwsdUKrP1TprxepCwJcXGXwWAJFFfgTUdfD
	 i9e7eYGk7HHpTsYou2kb9m7p+KyGzlyFzfMYCxzsfkGFj6rsY5gI5MQj1MJf+scQXeyyd
	 KKPxrBpfkbNESPfnaWoKPQpSHqCaqtgXSl0dgNkHyf2c9wRgccJm1UhieZUQhJ1t6jl2u
	 ZHrwsIPJknKzHjCUeNMltczpPclxDGTrvlW+ll1X26QZwPIuxhOcyIydI1r5hEcW7IBiw
	 pMu5nKMToyBRTcgpbLXKnDCldwINr4h9zr7OgRqyEwLt4x34kTDvlt6T/YTOcP15yrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zv2Q01mH;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CDB606A31F
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 17:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1CDB606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zv2Q01mH
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso623561a12.0
        for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793208333; x=1793813133; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XLYiEepDtnyQ6wJ1rlYe5RaJc/i8ARvs/UjwaNMVQRE=;
        b=zv2Q01mH32s4vXlb8aos4rsRKWBC4rHQ8JlxaJdDjONrODlR5X8VxMNW94UGbvmLV4
         KAidNUUUc9hYhjFUY7inGmol0qIN6lyAE2zclt7tmnt7vBTmIMVyO521TY2XgCuMXXwS
         3TyvKETz2N2f/QBojtabTDexLvu1ubKgwmRM2HXzmdL4MTYzX/23cxVjkbkg/PNGrwhl
         rlrJ8mmCa55+Gh3X/TCsJE1ZXi2IXFP4RRFr/gJdEXgYLfeCX8loBABR8p5YuX7WitTK
         ki5E18VMRTLkw40GwZNyJAdr/TuWfsc4aMcogiujNIHTRqq6n5ip6OHuP/84l2P84GJk
         H36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208333; x=1793813133;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLYiEepDtnyQ6wJ1rlYe5RaJc/i8ARvs/UjwaNMVQRE=;
        b=hWs583byj2RtvrmdYkFErZYfklKJp30Ln9qsX9ygbG24AhWObYqS+3Uz4FBpym8Ur5
         M/+URIWpqPrRV9LjOnPMd/ChrIIcIWrKC5eQYYMkZhaXAGyx9q7Z+SbkkKoD3frVvcny
         2o/bAm0Xak1YjTpb5Zm6h4BKZHZijTi523XVldHZY416+q4RQ2ssr0O6IqPeZxhvF9m7
         FqzJ258st8O0A3oGJ1OSxDg97JW0IEoP2QEMTLHoyKQWh8qeBhyTl5JC9N9B6+ZhuClw
         SO13xJFtAqxsetQQe4WuF8iSynKrdE7RuR+4DiPD7fUIKhAHWm64NtbSX4yPNQAJLGQl
         eA5w==
X-Gm-Message-State: AFq9FYJq7t5RPYPrw5xJhEqY/ho77HMHUpo40o3cXzEe5la8CKUKGhQE
	0h4bP0UGJeKBZWtyt2r+R8U1+dW2jZc/DuBtxOimvbu0ilQpnSmxuGrU
X-Gm-Gg: AYBFou2imm/zlNupLzJTEgNUXCP4W1ppLdCokn2mVuBQ2r1nfKepzz5RoYrCCwBjfxT
	do88bD5ZbQhKWAXNtBcnkjUKLq4nfRhh8lgxYYD/5aTGXft+TGOsGacdzsM38piwAvrLLp/wpX4
	hsIRv/A68JRDai/cxCHC0sXOmPMgtFlhbbQAxNRtOXZys1TPOOuGvyWRN9Ee6EvoCDlx6c9lH4G
	xWDSYBohikEZ56EQxsowN7H6ZPvnD5sQMqv+MFWm5LO4OKUY9QKZ48gEMmVIfrTjMWKKCywlinq
	uDqyBymuvs5X5zQYDpfF0I00IOX9KeiKgpVMgpc4mdZUwrYq1ZGnMBoRzW4cfDL8FpiK2YQ/yYw
	EXY0MUvMCSwD73m3f2ZtI4dWF6kU9hw08TuR4W4x1xH5RljRPT38dCUciDNVq1XyDfv38Y5iRxC
	QorG+QjMUuy9JeMbFkuqBG3+TgDtQXAXecxUFLni5NKqAsBL/Ufz/nwWCZk9MRFCN6rlFQjEO8r
	dZvmv7kx7vMQfVkTyRT1tSDwJ4y4to3gk9uwR4QMym01EcCZ7HW6rEmciYsWs8v+pg2QyRDAADf
	iAnkSYUmSjpi6GhLGpyjZmzjyjf5p/RXR7afIv0+66/YTMXcx+jwctqdxZYjwyxABQ548lqJ9dS
	7izhTGZStyv3YeYa9z/fRde0ZtPt6sZk8lg==
X-Received: by 2002:a17:90b:3a46:b0:3aa:fdad:7d6e with SMTP id 98e67ed59e1d1-3ae581b7b3fmr2290113a91.10.1793208333116;
        Wed, 28 Oct 2026 10:25:33 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm397200a91.10.2026.10.28.10.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 10:25:32 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 17:25:31 +0000
Message-Id: <DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com>
Subject: Re: [PATCH RFC 0/8] vsock: add datagram support to virtio and vhost
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Sergio Lopez" <slp@redhat.com>, "Stefano Garzarella"
 <sgarzare@redhat.com>, "Bobby Eshleman" <bobbyeshleman@meta.com>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Bryan Tan" <bryan-bt.tan@broadcom.com>,
 "Vishnu Dasa" <vishnu.dasa@broadcom.com>, "Broadcom internal kernel review
 list" <bcm-kernel-feedback-list@broadcom.com>, "Stefan Hajnoczi"
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason Wang"
 <jasowangio@gmail.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, "Haiyang
 Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>, "Dexuan
 Cui" <decui@microsoft.com>
Cc: <virtualization@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-hyperv@vger.kernel.org>
In-Reply-To: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 09:04 AM Sergio Lopez <slp@redhat.com> wrote:
> This series implements SOCK_DGRAM support for virtio-vsock and
> vhost-vsock, allowing applications to exchange connectionless messages
> through the existing AF_VSOCK datagram API.

The cover doesn't say who needs it.

Bobby and Amery took the same feature to v6:
https://lore.kernel.org/all/20240710212555.1617795-1-amery.hung@bytedance.com/
Stefano said there that it can work well and that the virtio spec change
is the next step. The last mails of the thread have Amery's v7 WIP and a
short list of what is left.
The cover doesn't mention it. The spec change is still missing.

Why not finish v7 instead ?

This RFC goes the other way in these places:

  what               v6                        this RFC
  -----------------  ------------------------  ----------------------------
  (cid, port) space  own bind table for dgram  shared with stream. The 2nd
                                               bind() gets EADDRINUSE
  vsk->transport     empty until connect(),    g2h or h2g, picked in
                     lookup per packet         socket(). -ENODEV with
                                               vsock_loopback only
  routing            one helper for stream     2nd copy of the chain in
                     and dgram                 vsock_assign_transport()
  recvmsg()          in af_vsock.c,            dgram_dequeue() stays,
                     no dgram_dequeue()        dgram_payload_len() is new
  VMCI               fallback                  first. No virtio dgram when
                                               its module is loaded
  dgram > RX buffer  drop, EHOSTUNREACH in     every RX buffer is 64K
                     the error queue

> Datagrams use destination-based routing across guest-to-host,
> host-to-guest and loopback transports while retaining the socket's
> transport state. VMCI keeps priority as the dedicated datagram

A dgram socket uses two members of struct virtio_vsock_sock: tx_lock and
bytes_unsent. They serve SIOCOUTQ only.
virtio_transport_alloc_skb() does skb_set_owner_w() already.
udp_ioctl() returns sk_wmem_alloc_get() for SIOCOUTQ.

Without them a dgram socket has no transport state, like in v6.
Then no need for the owner transport, dgram_transport_match(),
fallback_transport, tx_accounted, the skb destructor, etc.

> transport.  Guest RX buffers accommodate complete messages when
> datagrams are negotiated, preserving message boundaries.

That's 64K per RX buffer instead of 4K, for stream and seqpacket too.
It undoes commit 03a92f036a04 ("vsock/virtio: Resize receive buffers so
that each SKB fits in a 4K page").

pskb_trim_unique() doesn't reduce skb->truesize. So a datagram of 1 byte
charges more than 64K to sk_rmem_alloc of the guest socket.
The default sk_rcvbuf is about 208K on x86-64. The 5th datagram in the
queue is dropped.
