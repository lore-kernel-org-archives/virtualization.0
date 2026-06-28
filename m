Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0402BEC2E
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jun 2026 18:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782671742; cv=none; b=bH3+DAup9X9W/cJ4TERaxYDWkORUc/kgh6W5S77R1cFFpvsPST038SC6JiiBwae/NYMwRRtnByKX6GZCcAZaI6plb0wDUHdaM6KYgDtqV37tMRdPzyOY/x4uqTxSs7EukG+zsGCzQD72PrxsFoFNhX4B06p7UpYanVH0LUsOjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782671742; c=relaxed/simple;
	bh=NpueuavD31w+JK7qclqaceH12pxs8f2Li/NN2onxLz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=jPT4IToPp+ZF2mslJyAEKusxhzyk8S15uo200mXNfOnFQg/8d+QmxwXwCDkLIUTH1Mjt0wkHMH6gp0YdYEkyf+QjKIa2rQYKvZYnqWsuRNEY7jhIUsb6dev6/DdG02Yx/znTtOmPx8XXuP2kiW8l3/ZCv5XpBCDuerDEXjbOTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZFGP1kv; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZFGP1kv"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E5E1740063
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jun 2026 18:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s7_1zFxUcVt8 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Jun 2026 18:35:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B672F40051
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B672F40051
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TZFGP1kv
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B672F40051
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Jun 2026 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782671737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RVj3UQKFe+bbSeb5ta8T6W1dIgFOrixbGRGcLh+YeGQ=;
	b=TZFGP1kv/hwSGOwJS8GLC71uc0epPnIae7EaDdJUBHw5YxLALtq/nY1NT3QpCduFADHUme
	aMe7cCoKf6R+1OfaEpq2DHt2NU5VxoPyfQ3tS0u7+7xz0HQnnkXiqqcAhfg6Vgrt/EGjyX
	XyUJ7PFpNkQW4UJZhkV7XusfjytKUnY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Uc8q1h_oNOK1vSWl7vQ97Q-1; Sun, 28 Jun 2026 14:35:35 -0400
X-MC-Unique: Uc8q1h_oNOK1vSWl7vQ97Q-1
X-Mimecast-MFC-AGG-ID: Uc8q1h_oNOK1vSWl7vQ97Q_1782671734
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926fa2cb17so13549505e9.1
        for <virtualization@lists.linux-foundation.org>; Sun, 28 Jun 2026 11:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782671734; x=1783276534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVj3UQKFe+bbSeb5ta8T6W1dIgFOrixbGRGcLh+YeGQ=;
        b=JSgDP190AvnlXilf8sd5HXClKheWGjVkqJL60zjE1ftzqZolYhvtG/e8yuChU/BZiw
         jB+Z3vltJNZrdzsFzK/+hLXvKZI/E7uM9dsfXyNCFXqckRr4HDgtqTq+c691UYbojESU
         USkfNv6XIOI0Wdp6CZT+Q0NaXD4KY52ndrLjEDCfxZ6SmybGwLo8gRxQHfYvxHoIoKOB
         Sp+ejiVHNIam056zWA+VaWKVi1x8IzYT1j7DLOZys+lZHKkQqj8GQ2R/Yid9c09zOjBO
         /YS2TnJXjHTb2NAx6sTJiIrsqsGaSuxzB6zFyFsGeSDi3qAzG7G+Dze8fnn45ISgvKEw
         Gz9w==
X-Forwarded-Encrypted: i=1; AFNElJ/7/NkaBzyvhDcXiENgmgFp/vdvaeNghvQ/CssUtq5niAIylOTjErTK/BxChqzDlWB+SSwsehXmM0dd1ERW3w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyDV33tkVJQI3otSanVzMjXUqozIQnSWArVp/zWPZE5NKnUgFfE
	ZLkyaTY/zu1idjr5Powia5iltEXROlQPx9dc76+itRP9D97kfpjiZ9tLpZL5n1Gxrem+D5Qm3KJ
	77SWJnp99TyMVbDe8/vlF5oVPnK44PS6lr5k6D02O8ND/IWs/I6UbK8RVamx2lc3J3WnNYNHx1O
	TATTEcJtY=
X-Gm-Gg: AfdE7ckpsCUVouZAn49owaCh5dUzfmTDc5ajJzbtwB9QHvhe1MEQZs1RQJG0fRfT2P9
	Xr1s0kCftjRxaIA31YUB8dnCXqwHA/zUUezRKLnE1OM8DaKI/N/h+17AlJJH+qJerKPh8uojVGd
	WPsvFqu5Mp+w6jvmX+j+MH0dr0xOCv8j6DTTfr+iAqC2o4zJGpz8r4cfi4soq0ajaT+9WV+hmKW
	OvBKgBsnIF/yJsaiKpjXGAD4oc7o8Ot4j9xE63GG6OHG4iBVJsgPt19m/LF6yn6WdOM9LOjBNJ6
	W9N1u0odhjSrw+uIqfsr55btctsbmTqiw2BnOAovQO4xeV3nSI3XGHYml//puNaDCzvEqUlDGWf
	+GBh6PPBVTe9yYne2isyBaZrm/9Kl1dtJ
X-Received: by 2002:a05:600c:4794:b0:490:d37c:78c7 with SMTP id 5b1f17b1804b1-4925a0fae98mr243218705e9.14.1782671734327;
        Sun, 28 Jun 2026 11:35:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4794:b0:490:d37c:78c7 with SMTP id 5b1f17b1804b1-4925a0fae98mr243218565e9.14.1782671733893;
        Sun, 28 Jun 2026 11:35:33 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47290ed4377sm9226894f8f.37.2026.06.28.11.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 11:35:33 -0700 (PDT)
Date: Sun, 28 Jun 2026 14:35:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Simon Horman <horms@kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
	rulkc@linuxtesting.org
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
Message-ID: <20260628143523-mutt-send-email-mst@kernel.org>
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0SNX5wn8yHOWF9r5q9Yhi-PqVf7h_5EOzK0rUHfk3RU_1782671734
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 28, 2026 at 09:20:52PM +0300, Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
> this way, patch also adds handling case when 'msg_ubuf' is already set.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  Changelog v1->v2:
>  * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>    already added.
>  Changelog v2->v3:
>  * Update commit message.
>  * Remove one empty line.
>  Changelog v3->v4:
>  * Update commit message.
> 
>  net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 09475007165b..41c2a0b82a8e 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>  		return pkt_len;
>  
> -	if (info->msg) {
> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> -		 * there is no MSG_ZEROCOPY flag set.
> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> +		 * handling from 'tcp_sendmsg_locked()'.
>  		 */
> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> -			info->msg->msg_flags &= ~MSG_ZEROCOPY;
> +		if (info->msg->msg_ubuf) {
> +			uarg = info->msg->msg_ubuf;
> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> +			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> +						    NULL, false);
> +			if (!uarg) {
> +				virtio_transport_put_credit(vvs, pkt_len);
> +				return -ENOMEM;
> +			}
>  
> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
>  			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +			if (!can_zcopy)
> +				uarg_to_msgzc(uarg)->zerocopy = 0;
>  
> +			have_uref = true;
> +		}
> +
> +		/* 'can_zcopy' means that this transmission will be
> +		 * in zerocopy way (e.g. using 'frags' array).
> +		 */
>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> -
> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    info->op == VIRTIO_VSOCK_OP_RW) {
> -			uarg = info->msg->msg_ubuf;
> -
> -			if (!uarg) {
> -				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -							    pkt_len, NULL, false);
> -				if (!uarg) {
> -					virtio_transport_put_credit(vvs, pkt_len);
> -					return -ENOMEM;
> -				}
> -
> -				if (!can_zcopy)
> -					uarg_to_msgzc(uarg)->zerocopy = 0;
> -
> -				have_uref = true;
> -			}
> -		}
>  	}
>  
>  	rest_len = pkt_len;
> -- 
> 2.25.1

