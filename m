Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FB235E54F
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384679; cv=none; b=uuGBVZD7zp8izjWIkDm+iaxfEh/Jx+Q8dD7K7F1dvhfGSkbNI+KVSc/igAns0sILubi0XHyYX40ZOpz5Juawc3yiQAPydoxh5ZliHkhlaXVdVx4GXxK9XkH2cziYeg4KI5YgFQjSYqJjk6ErHHEnyfo7OKKZ35M/YVkH/nTSFqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384679; c=relaxed/simple;
	bh=36C4TLxXEoaix8+fMcGoCyyRChcqMGjtLcHigyw3xhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OHujJ2FjOBtLf+ogmigKXQD7BLn+dVtfD1Rm8tlKeQS8patXcQOd6FuZiPmIPo5NdAOieqd1IVCLVamdTyo6orgfQhC9Rsjq2WhwQH6EzL+hBu8syyVgILqasYXAHFGMoAMjNuzpWQVHi9LX1tV2o6e+55d9+dhTht30NxuqzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nq+u8htP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nq+u8htP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768384677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XuY/fex5vMBZkn75cmI85OoF3EbBEOIpBs2f4KCfT7Q=;
	b=Nq+u8htPhUTfkJoQJcSAbrdTjZ21PQLmHKIRvI6fcgHC0hqM/XohE6bnmnXhBpZ7KJDD80
	lUbiPRDsVifi1xSyf/g068JfoPwSQ8Z6t9BZIbEuoRBnGyJ0zaqToGSda0e5byGM8QNJpL
	+ej0sQtO4LqRcLZ/G2VNpnnwOBKUd5A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-2sA5zG1FP6atxKtjKMrYiw-1; Wed, 14 Jan 2026 04:57:55 -0500
X-MC-Unique: 2sA5zG1FP6atxKtjKMrYiw-1
X-Mimecast-MFC-AGG-ID: 2sA5zG1FP6atxKtjKMrYiw_1768384674
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so58172295e9.3
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 01:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384674; x=1768989474;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuY/fex5vMBZkn75cmI85OoF3EbBEOIpBs2f4KCfT7Q=;
        b=ef48u5aXTSDfrKb/c7zUUQPluQhS3iJtZxtr3MsDTkn0YkSYa8yg5ME3OuC9H26byB
         9sExslbUhwdtDm9Oeu65paeH9nmXDrR0WqRt6DAa33ugfqMuQrcX2TLAa4fGmT3X7ei2
         fEW1+vBEu6GeIah6kn4uGdgo9BgSR5q7uZsHmHqqanQw64ueBWvzarph1f+0TStwNXK9
         eFFWgw3lcG7IITORmR43WOnWAUuHR/ZiAHZJhIYb2vZqB8szWWC9E3YexKQsrsVKR7So
         NIM7yMe59ScKcXoIvoK2w1UCrD2K5uLmx8lVg9ekz4vZ94gwAtkIUsSpH6AP8JQ9bvFj
         HlHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+EM9HIBcINdKd4WX8Pa83HCYhvqNZ9NxGY+cHnMBjh3i628FiKrucKs6OZk9Em2N9nSt4M1BOLcysOgOMSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWtwbHSrRXPneIn1kFfrXd16b+yCShO7VEA/uhHuVAPX1Pth73
	RIeUbUhNWNmr5XSrmY7iV9cvoGDm2GNZKgw9bFyARGj2fzpLKqRfN3O8RDMAZkKYMdCilDIugpv
	732ffG0vT8BuWHHnL/NOX2tizhVgT5tjzHx9AYAGsQB4geXI1Yrale8ttFmpIprsvDWlU
X-Gm-Gg: AY/fxX4WJw3maNWUHRAZGoBx/oHszfs5okBtWYtzriknpv2eB9xIfdf1KvUdphub7d7
	5aWowTP1qfFeOeILFsv7WRFfJR9W2jauyMh78xEVNuJ/dOHfDhoGkFwkBVXJJxG4k35PuPjqzhC
	jyPE90WS4Oyn3Ivm4ujpDbkj94jP+USb0h64TcC8/9V9JGJagddsxUvT7VovSmZfPG1sHWi5DxY
	5ahNYb+NxaZniu+B0WsUNlbYWwxFPH2yugOiqhCj+jUdN5v3knHywaW/GElWNULxVoiTrfDh9JF
	X94CgFlFpfvuSempHMThWAlsfkDkgrUAOFVR/p57Lco08RCfhmh19yxDEj/tWDWz6JsQ8OxUSed
	wFPAnSBCczsPsdW1GmEwfNR1za/g4mzZjTcn3gTsW7W5MOgI56wNW1PhrzqDLKw==
X-Received: by 2002:a05:600c:8b76:b0:47e:e2ec:995b with SMTP id 5b1f17b1804b1-47ee32ff3fbmr19462325e9.9.1768384674480;
        Wed, 14 Jan 2026 01:57:54 -0800 (PST)
X-Received: by 2002:a05:600c:8b76:b0:47e:e2ec:995b with SMTP id 5b1f17b1804b1-47ee32ff3fbmr19461915e9.9.1768384673944;
        Wed, 14 Jan 2026 01:57:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee0b4559asm19833435e9.0.2026.01.14.01.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 01:57:53 -0800 (PST)
Date: Wed, 14 Jan 2026 10:57:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] vsock/virtio: Coalesce only linear skb
Message-ID: <aWdoY6JqlRiwfFfJ@sgarzare-redhat>
References: <20260113-vsock-recv-coalescence-v2-0-552b17837cf4@rbox.co>
 <20260113-vsock-recv-coalescence-v2-1-552b17837cf4@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260113-vsock-recv-coalescence-v2-1-552b17837cf4@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yRJa8UKSjwlUMcQcB6FBlyaQzYLdCEJ5r66Sp0EJmrg_1768384674
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jan 13, 2026 at 04:08:18PM +0100, Michal Luczaj wrote:
>vsock/virtio common tries to coalesce buffers in rx queue: if a linear skb
>(with a spare tail room) is followed by a small skb (length limited by
>GOOD_COPY_LEN = 128), an attempt is made to join them.
>
>Since the introduction of MSG_ZEROCOPY support, assumption that a small skb
>will always be linear is incorrect. In the zerocopy case, data is lost and
>the linear skb is appended with uninitialized kernel memory.
>
>Of all 3 supported virtio-based transports, only loopback-transport is
>affected. G2H virtio-transport rx queue operates on explicitly linear skbs;
>see virtio_vsock_alloc_linear_skb() in virtio_vsock_rx_fill(). H2G
>vhost-transport may allocate non-linear skbs, but only for sizes that are
>not considered for coalescence; see PAGE_ALLOC_COSTLY_ORDER in
>virtio_vsock_alloc_skb().
>
>Ensure only linear skbs are coalesced. Note that skb_tailroom(last_skb) > 0
>guarantees last_skb is linear.
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/virtio_transport_common.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)

Thank you for enriching the commit message!

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d5851e..26b979ad71f0 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1359,9 +1359,11 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>
> 	/* Try to copy small packets into the buffer of last packet queued,
> 	 * to avoid wasting memory queueing the entire buffer with a small
>-	 * payload.
>+	 * payload. Skip non-linear (e.g. zerocopy) skbs; these carry payload
>+	 * in skb_shinfo.
> 	 */
>-	if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue)) {
>+	if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue) &&
>+	    !skb_is_nonlinear(skb)) {
> 		struct virtio_vsock_hdr *last_hdr;
> 		struct sk_buff *last_skb;
>
>
>-- 
>2.52.0
>

