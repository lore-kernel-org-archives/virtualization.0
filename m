Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D982342C98
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777989122; cv=none; b=JalEuOVG8Kw2wCCjg+D6m33t6giv448ZYE9tpuGcyIb3+BhWrDMm6YrkKWaMlXmiBdErCSabetygiDmUI1woU8Uxv+CenTuMd7zMJDVt2ZV2qKCLOuipvf5bmD4seqCw09tYYhDTjEBH7R19mpQ36KDSWwA0oX1QxJhLLLjC4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777989122; c=relaxed/simple;
	bh=FYwyJcUh1yGE5As2Q/7Ku6QHLAJWBWFMlQ45xYvu8B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jXeKiSp8rqWMMZXD36ErVy8BhQFNkwiY1P4+gKh/moMNn9twsxtPmHw6nZHoApTrd1de0wyKRoT3pti5X12Bs5sp7nAXj+eA7P45ElqDgsGZgkeD/wFzpN24uyhEO10w6feGg1fmu57d7fLgoRTAtCAuFySrYmQUJ8q5vl/3GQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ce+Jvckf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ce+Jvckf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777989119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fB7sNER4g4DilTXabFUlJ4D1a4B/9taTrBXoE4PehVQ=;
	b=ce+JvckfeVDypvea8PrEAdlSCop5kAu1KFxR0PacpX3nCjjys1wLNRs7sc2IJFIzN5Pm6D
	MSEx5ae2TdCpdPlffDdI+7CiZEdCuKjZYUARjEK5Zyu1m6TS6nx2HcDgveZl/U4xSP8WK0
	ipTdGh1qrusUkIWflterRhniPejKLdg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-Nq5ABu_INoeUG1gbmcca4Q-1; Tue, 05 May 2026 09:51:58 -0400
X-MC-Unique: Nq5ABu_INoeUG1gbmcca4Q-1
X-Mimecast-MFC-AGG-ID: Nq5ABu_INoeUG1gbmcca4Q_1777989117
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-449dcfe8005so4365538f8f.3
        for <virtualization@lists.linux.dev>; Tue, 05 May 2026 06:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777989117; x=1778593917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fB7sNER4g4DilTXabFUlJ4D1a4B/9taTrBXoE4PehVQ=;
        b=UxDNxKnF1SlqY5SOh4jEht5mKkYfr8sW9DQrBKe16KvrKuc8M6eJVBzSIeTbqYVJA+
         ygm8ylWcLSCmmzRKqeBn6zgDgWwoNAhUJtrbhLiGPVUtr8PjUPkCE/AFsiBVbHtVm3MP
         TnZtmTeKyzlyBWxyxrOCIh7fYslQ6fWcvMLgJuKLAI+Iz5ToONgdZVCyMTBiP2TvcNFv
         7my/9FeuinA+LMzc0zh6prkG84ciN04MhkqPEB0qN5k5byw2dgmZFROxX46xypX0BsHW
         VXHS5SHVaT2y5shAvIfZqQ641vnKwm4Lw0HPfdkWrWSDQ+AK0rUwfeFPdbFdT4hgucCr
         k2rA==
X-Forwarded-Encrypted: i=1; AFNElJ/Jm7kdpHf+ZyePsSAN7eY4KELAdfdWjf0m4V+bBX5Iog6/LMwMiUq7QgtTMOS0n3LRSbNq1Ywka0ZT9Y7blg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMGHWt8C50DdD1mC0b8v8tx3/+kCnLtvd50oFtTJBKik5PyKwW
	ibyO0hPXAYHKRzRgTvsqQivm6dmugQcmAEhrtDGBAPH99dk2aLepJ+5zRiAIEDy7cGRoryTMhAm
	f/zKWMbfBLPdsEN/APEgwwBjACLb9WAfjrgMsUuPEou8BdWKGJrHkidzpg81wTa20vWDV
X-Gm-Gg: AeBDieunzAOrktLVPFVY9nbkCDASrfZO9H3yCtXM/UWltHZiQEvOdlIoF3Wjm7w3QsU
	Qjv5Jbjr7UdMQq5Pq4x7DaCPO/DwEFzfSJR6KaFko1GLuXykBoh5s+p8cwoPTIOAnv8ScBpC5df
	qy3JNk1I+zPReDecRX5KN4/dx536CRxsOnVDOcyDBWWZvaV6xWqm6k2KAktVhgTwd2WtRaTw6aA
	Ji7QNpaeyf2Gw36nSqBviCDtdZ/2FvT9FR68HfQ4hANcuHlls2Dn8xldHIg02sxoQ9w1EMvUUp6
	1ZrX8Mm6HB00V5cCP9/I2VWfmBjkLEb9emeF5Tc3XozBGWt5rrMu2qGDp8sWNXBtS9fd8wLgQlD
	HEgUG6yBwYX+Z33E086kewoujtBk74qJzjhbPkEFODJNKH345LOntSH6+SEsz4AMnmS5yAF/xkQ
	==
X-Received: by 2002:a05:6000:1841:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-44bb5b4d3cdmr23938881f8f.24.1777989117070;
        Tue, 05 May 2026 06:51:57 -0700 (PDT)
X-Received: by 2002:a05:6000:1841:b0:43d:714:34e5 with SMTP id ffacd0b85a97d-44bb5b4d3cdmr23938787f8f.24.1777989116454;
        Tue, 05 May 2026 06:51:56 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055f2487dsm4641869f8f.35.2026.05.05.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:51:55 -0700 (PDT)
Date: Tue, 5 May 2026 15:51:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH net] vsock/virtio: fix potential unbounded skb queue
Message-ID: <afn0ZdvZWswBuDMm@sgarzare-redhat>
References: <20260430122653.554058-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260430122653.554058-1-edumazet@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L7Jjj_XW_bVpiF9Y4dbAFTD_az6tR5m8xtuxfSsRmPc_1777989117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 30, 2026 at 12:26:52PM +0000, Eric Dumazet wrote:
>virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>
>virtio_transport_recv_enqueue() skips coalescing for packets
>with VIRTIO_VSOCK_SEQ_EOM.
>
>If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>a very large number of packets can be queued
>because vvs->rx_bytes stays at 0.
>
>Fix this by estimating the skb metadata size:
>
>	(Number of skbs in the queue) * SKB_TRUESIZE(0)
>
>Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>Cc: "Eugenio Pérez" <eperezma@redhat.com>
>Cc: kvm@vger.kernel.org
>Cc: virtualization@lists.linux.dev
>---
> net/vmw_vsock/virtio_transport_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 416d533f493d7b07e9c77c43f741d28cfcd0953e..9b8014516f4fb1130ae184635fbba4dfee58bd64 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -447,7 +447,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 					u32 len)
> {
>-	if (vvs->buf_used + len > vvs->buf_alloc)
>+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>+
>+	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> 		return false;

I'm not sure about this fix, I mean that maybe this is incomplete.
In virtio-vsock, there is a credit mechanism between the two peers:
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-4850003

This takes only the payload into account, so it’s true that this problem 
exists; however, perhaps we should also inform the other peer of a lower 
credit balance, otherwise the other peer will believe it has much more 
credit than it actually does, send a large payload, and then the packet 
will be discarded and the data lost (there are no retransmissions, 
etc.).

Thanks,
Stefano

