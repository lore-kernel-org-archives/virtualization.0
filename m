Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8928A410
	for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745165; cv=none; b=JaSxl4H6ItLjMjhodQM+QH6388mmKDoJbwCz9xhddpVw1w29rND3ue4dLJnthb0FIIPm7w509LGtsYNsoUos1MsFhjhRBgwFJUIBT/uFOhAwBnWMKTn/udCbNRPy9JFsSWdH4N/XLwK/qeelnBup/ynnNyeh07zSSEwLsmUTN84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745165; c=relaxed/simple;
	bh=dXeJz3vwBSLIWWCWuP+elspZU7SI9LsUKQsf9/I2RiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SrP35ej1Vh2aY/xM5BlnWy/Y87SFnBWubNm1wnhZGqiFGkJ+nfyI8BRJJ/w2LwZJDWPf2u4N9nRqUFa2dkQLsEIohRXvX7UchQkBA2L9kaO6ZPGLJ8l34vQPvjuu3RxuYJfWFlxEK+I8BLOBp2t2EFwuZGgwhcFZ4K2zGAhS55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z8VaZxfN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8VaZxfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752745162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKvVQQJMq+hy7WZue3QcEAM5iltBaD3HiRA66HLusuo=;
	b=Z8VaZxfNFkV1AGl5or+bB5GffslxDGGKuUH7zV2GdKS9KvDecs0b5BQYxGLvaCSu8ET5Ch
	xOS6udZjE+wuSCEyoXPC/Its47UYN2mZf8EsAnc2eF//+Dh1+qN/yIIQtrQWv/E3DEgjnz
	oDfFCjly88HDmxTNazUwcDorGIUmavA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-kYv1PpEQMuGVP74Qr2L7Hg-1; Thu, 17 Jul 2025 05:39:21 -0400
X-MC-Unique: kYv1PpEQMuGVP74Qr2L7Hg-1
X-Mimecast-MFC-AGG-ID: kYv1PpEQMuGVP74Qr2L7Hg_1752745161
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7ceb5b5140eso118679785a.2
        for <virtualization@lists.linux.dev>; Thu, 17 Jul 2025 02:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745160; x=1753349960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKvVQQJMq+hy7WZue3QcEAM5iltBaD3HiRA66HLusuo=;
        b=WpdRjGocmwwKvdNQnancHYxcsLLMgO4m6hnKjC6ZIABNRfGeYfNAMVFIj3yWoFTnSY
         wvN6VDKpkaxzl6BUPzkBBflULaTLSbKJgTu4INqQmHMPhhSxs7DzqD+IaD8eIVA4O8V+
         nXbh6xfRLjdZ5ROodqalEmSqTJM0ax0gJ547T9zwrahYZc3pLeLuj9CS/wYcx1dGyZFw
         eQO9fZzM1dmEY2c0edBquNA6wGBycLRj8PYDGpb+9p/qSlBUYBYR/tXwsBMVLMaA/imc
         4scXQM8MhujclwMTrUEB2Plqo6ZqT1YkbuadOof/82j2Oi0o4R95sb2klfyb1oWKnlGK
         F0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6/eP5+gQaEyv8bqYfb/qTA6StB1PABiUqrqwiHOCb8Vgw0w4qN9waMvI+Kpf0N2legecm61RZCzL7fWUz3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2P12z3Ao5jWFymZrwDOL9YHZu3yh78AEyZK2L2Eo50n6S6gny
	xz62GXbcEL48D+DgJ0J2cZm7UGrlTNkiG+lQSsdLcmHuF0+G96oCQWaiyRVaYsirHavSO6lgLPQ
	qkXOCNg7IAckc/Nu2wl38JtjMOU1JUig1AQxcF28Tp48I/LNg4BtuIj2sRiQC3x7Df2ZTNsO7XL
	VV
X-Gm-Gg: ASbGncuLnBd7YxjfVdj6G8cix7ljaA1dYH9/vAPmudtzj+X9okhSP9EXzyO1U5H/t4D
	Rf6w8jGkQw7RdCDc+KDya2MeinT076BWKV5Bfv3plsDLpc3R24FJqstYvNb91U8zvj86NN8eLx8
	gWSBSU7KxuLSbHjynsuPL/hMsX8M4CWpM4gCyd9+jh13auPrD8LAT6slWB+XhDjTqSTvm9LCoQW
	Iv5ctKUK6lH1LzAQ79IwU6mK5+AO2ve98YkcY480CgeI3buppRS0z/C1U3UeG4vYqVAU99OHfq4
	vEgAYRdIuRdm5kzgThqsBEqO7+OoimT3/1NHMdt1HGtsnaex3dm5KGNH6oL2gef4oBcEIfX3B3Z
	zMsLfrtOIPM8jjr0=
X-Received: by 2002:a05:620a:6542:b0:7e3:4413:e494 with SMTP id af79cd13be357-7e34413e88dmr561235385a.60.1752745160467;
        Thu, 17 Jul 2025 02:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLjVGLBAruZTnyYcI3XjIk2LiSOrCmNEhnAfiMWz9ibsQjoRXzWcmxwJLI++dPE/3qhXbt3A==
X-Received: by 2002:a05:620a:6542:b0:7e3:4413:e494 with SMTP id af79cd13be357-7e34413e88dmr561231885a.60.1752745159997;
        Thu, 17 Jul 2025 02:39:19 -0700 (PDT)
Received: from sgarzare-redhat (host-79-45-205-118.retail.telecomitalia.it. [79.45.205.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e2635b0b2fsm519799085a.0.2025.07.17.02.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:39:19 -0700 (PDT)
Date: Thu, 17 Jul 2025 11:39:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>, 
	Steven Moreland <smoreland@google.com>, Frederick Mayle <fmayle@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/9] vsock/virtio: Validate length in packet header
 before skb_put()
Message-ID: <y6taqbyskzr4k7tetixgkhdo2z2dgrionsor3jriuo4bxlqdfc@fjnq7tig4bik>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-3-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250717090116.11987-3-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LJDOB78VMa71DnAj53v-NJ8u5gmMNZUSxrinOoZJ3NY_1752745161
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Jul 17, 2025 at 10:01:09AM +0100, Will Deacon wrote:
>When receiving a vsock packet in the guest, only the virtqueue buffer
>size is validated prior to virtio_vsock_skb_rx_put(). Unfortunately,
>virtio_vsock_skb_rx_put() uses the length from the packet header as the
>length argument to skb_put(), potentially resulting in SKB overflow if
>the host has gone wonky.
>
>Validate the length as advertised by the packet header before calling
>virtio_vsock_skb_rx_put().
>
>Cc: <stable@vger.kernel.org>
>Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
>Signed-off-by: Will Deacon <will@kernel.org>
>---
> net/vmw_vsock/virtio_transport.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index f0e48e6911fc..eb08a393413d 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -624,8 +624,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 	do {
> 		virtqueue_disable_cb(vq);
> 		for (;;) {
>+			unsigned int len, payload_len;
>+			struct virtio_vsock_hdr *hdr;
> 			struct sk_buff *skb;
>-			unsigned int len;
>
> 			if (!virtio_transport_more_replies(vsock)) {
> 				/* Stop rx until the device processes already
>@@ -642,12 +643,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 			vsock->rx_buf_nr--;
>
> 			/* Drop short/long packets */
>-			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
>+			if (unlikely(len < sizeof(*hdr) ||
> 				     len > virtio_vsock_skb_len(skb))) {
> 				kfree_skb(skb);
> 				continue;
> 			}
>
>+			hdr = virtio_vsock_hdr(skb);
>+			payload_len = le32_to_cpu(hdr->len);
>+			if (unlikely(payload_len > len - sizeof(*hdr))) {
>+				kfree_skb(skb);
>+				continue;
>+			}
>+
> 			virtio_vsock_skb_rx_put(skb);
> 			virtio_transport_deliver_tap_pkt(skb);
> 			virtio_transport_recv_pkt(&virtio_transport, skb);
>-- 
>2.50.0.727.gbf7dc18ff4-goog
>

