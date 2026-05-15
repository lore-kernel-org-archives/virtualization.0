Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9B3FBB62
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859388; cv=none; b=g4/qH56F0IoKoGGdjis1+e7pzbv9X8A/EyuGDLfYaBd/UI1mLSVzX71AJ3yPKoWXbe78HCqirrt/1Kzbd/W5fv+2iGzq91Uvg/WQxIqzAbTKW+QmY29V+0i4ea2mJ6/RVC0Na2i5B+k5G6pu2mcwtFDH29fgsMIb9TY1LTMhYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859388; c=relaxed/simple;
	bh=KxLABsT4GW6xy83byG9jRVMNzNmX8FC8tAkv3Z+4gY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=D/9sSZyjB1xM4/+qCuqb9KM0/xsBmbwyfm6cxa2f7ZIXyt05QB5oeIgT7sjcRwP+YnIjyC004+DlL4HGpt72/oZUiEDrCwed7h0cJ131jipV3ZcZIvDV08u9stASSniEtcTLG6ESr4FucG58BBqAVr4YxeF26tksnOtF1hQAGTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJSM0K5h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJSM0K5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778859383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSUwP/nePskW3SE3+3GAjWBn5fs5Ffp9tDDPc7lUU/I=;
	b=IJSM0K5hk/IlGk6IxCAsbS0PBBgbt6nV88iGInDPCupUPsjdfcssq6AAQYLhTCbp/w/ebm
	D6iG/eR70b70UigVSIYF3GoUNyZiUpzFfKEbD12hmhmE8jLfLP5J1s/Juf0fWqqY2pIGsl
	ODCioWWjmzTuMTot4zmXqiiyc89ZoUI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-ZdsXc6gPOcOEYpuRFxvDjg-1; Fri, 15 May 2026 11:36:18 -0400
X-MC-Unique: ZdsXc6gPOcOEYpuRFxvDjg-1
X-Mimecast-MFC-AGG-ID: ZdsXc6gPOcOEYpuRFxvDjg_1778859377
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48feb0298d7so7128335e9.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 08:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778859377; x=1779464177;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSUwP/nePskW3SE3+3GAjWBn5fs5Ffp9tDDPc7lUU/I=;
        b=N6zsHqhyO13YQeu9h6PVmcaRBvN6vZ1Qyf+d1OsCuF9J2rsVrUw6Dq7kJ20QSZDHYh
         ExiOOBNkkoOAUOLubfbP6XIKnDe2QHmc8/W7sVgvAa5LBCZ/e/WoV4z7IBp7bhI1RTo7
         WMxvZgX5ALTlDQaBNGAoWTNUpy5At3Z0Iyf/c+pNpIbzUdjSOqmgokTzUpbPv2ACPACS
         K8H7qfWw1IBX9E5JgqOZ0PHuXe6Uo4Hog0jIR8CjSjt1njhhMEPqqGGCLcAm1bPZ5Ors
         XerZV8W+OSnarFhvUDZUBLTizq/wHl2CKmosT95+OLoDJ1VDhobu97l6s8UqpHJU9N9k
         4zzA==
X-Forwarded-Encrypted: i=1; AFNElJ8TzN3oSRVqXc4x/FVzcSgYxggd5hAziinhBOo6/qBDOJ2LC+VhUkF7KnJhZxnH5oWKqL6rysQFDnzpZN4V3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1l0bJ5Jn84+Qv1Kj2LhYlpRgj6TwiainExBXOTZpWinZTncsX
	+ouOcrYNj8Z4aK2WH0P/8ayC0KvcSmg88dvZsqx5hjRilS7GN9BWZFvmVbhpYXQTk/UBUUDbJxy
	0+OAMJXZ8gGb3rEpXYh2V2tn17qwgdO4VB3dD7viIwPI2l8NNu0g8NbyWV+EZpTum5IPq
X-Gm-Gg: Acq92OFndDPJDuAmiV4YH9KjvNChsctBZuZeoednRSm3SsbBvTOWH//GXPA5xn159h9
	Jv6yiXwuQwEm2zPQh+vKsJKBSLfumor6S7mvyzgGj6CphrUolZMnbdhUCgVlJbdSl57cbtdnDAQ
	iUDECnybG6xKiidu4RAcRJ3ZZGFpwXUtKkg8rROtHIcZdotO0w5B4A00NWMvSc/lydLCKkrkc87
	55XAZEVd9qTgmcRsUVuf5fWh0leCXatJU003OgopWu9zbTDX7wDvBYK2TstTwcCosZIpntL/CzE
	sDCKWgg+4+86wE0y55xEDoz/V01XMqGR6aNaBFY0fpQB24DLe1rqRtyJ2I0IDgySmsWN4/TMhPE
	SXdBD6zWHR5q1ee9ja2NJLtUg7SOXOqlsP8xermQx
X-Received: by 2002:a05:600c:c10b:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-48fe60eb0f6mr44773455e9.9.1778859376435;
        Fri, 15 May 2026 08:36:16 -0700 (PDT)
X-Received: by 2002:a05:600c:c10b:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-48fe60eb0f6mr44772895e9.9.1778859375931;
        Fri, 15 May 2026 08:36:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe78aadsm15492085e9.29.2026.05.15.08.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:36:15 -0700 (PDT)
Date: Fri, 15 May 2026 11:36:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: gregkh@linuxfoundation.org
Cc: AVKrasnov@sberdevices.ru, edumazet@google.com, eperezma@redhat.com,
	jasowang@redhat.com, kuba@kernel.org, leonardi@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "vsock/virtio: fix potential unbounded skb queue" has been
 added to the 6.6-stable tree
Message-ID: <20260515113503-mutt-send-email-mst@kernel.org>
References: <2026051553-santa-unretired-a417@gregkh>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2026051553-santa-unretired-a417@gregkh>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CApZrJSgPRS8moxe_DJT6k9BhKY4u13j8MmEBmzV6Bc_1778859377
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 15, 2026 at 05:21:53PM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     vsock/virtio: fix potential unbounded skb queue
> 
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      vsock-virtio-fix-potential-unbounded-skb-queue.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 

Yea I have some doubts. It fixes the DoS at the cost of losing
messages. We are trying to fix that upstream now, maybe wait
for that?


> >From 059b7dbd20a6f0c539a45ddff1573cb8946685b5 Mon Sep 17 00:00:00 2001
> From: Eric Dumazet <edumazet@google.com>
> Date: Thu, 30 Apr 2026 12:26:52 +0000
> Subject: vsock/virtio: fix potential unbounded skb queue
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> From: Eric Dumazet <edumazet@google.com>
> 
> commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5 upstream.
> 
> virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
> 
> virtio_transport_recv_enqueue() skips coalescing for packets
> with VIRTIO_VSOCK_SEQ_EOM.
> 
> If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
> a very large number of packets can be queued
> because vvs->rx_bytes stays at 0.
> 
> Fix this by estimating the skb metadata size:
> 
> 	(Number of skbs in the queue) * SKB_TRUESIZE(0)
> 
> Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: virtualization@lists.linux.dev
> Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [LL: Fixed conflict since this tree does not use buf_used added by commit
>  45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/vmw_vsock/virtio_transport_common.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_inf
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	if (vvs->rx_bytes + len > vvs->buf_alloc)
> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +
> +	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
>  		return false;
>  
>  	vvs->rx_bytes += len;
> 
> 
> Patches currently in stable-queue which might be from edumazet@google.com are
> 
> queue-6.6/net-fix-icmp-host-relookup-triggering-ip_rt_bug.patch
> queue-6.6/tcp-call-sk_data_ready-after-listener-migration.patch
> queue-6.6/net-sched-sch_red-replace-direct-dequeue-call-with-peek-and-qdisc_dequeue_peeked.patch
> queue-6.6/ip6_gre-use-cached-t-net-in-ip6erspan_changelink.patch
> queue-6.6/vsock-virtio-fix-potential-unbounded-skb-queue.patch

