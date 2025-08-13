Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67723D7D3
	for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074479; cv=none; b=eC0hL4gSp8LV0CmoB+8ddjqENTOVdltVCXQw33QSLG4OqADT+sQYBKilN4H12hPNHWT/BmlcVa7M/80Jmppo3G31aSdk+TrjnvwYpmtlazfXWpiYNMkAzorlQDJNxc0lBhfTm0K1Q/ZdOvOmnoJ8Q/Qa0eBGnAebXWwyOQ6XAUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074479; c=relaxed/simple;
	bh=tPuksD77buzY7YWi9EBculS4rVEQBAdYHafEc74xhBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hWl3Ide9u1eO+rl2PuCfbQ/rncidJmld2GDiGYhvJi5gFJgDSf9fiGr83UQuDyI1+cvYa/wLH3ydcxj2pnEpoISWMaRlBuxeXkX78a6Nv6HWpHaJEJXuQ86ESZ0FL1YOJjVO+LGMeCATewaCUTLriVhPEb7DQ/I4aGheK8nQej0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO5MVTDy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO5MVTDy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755074475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=76YJFkH9eIhBYjG5GaaJcP9B1ox/l/WKOLKsUlz9rUw=;
	b=CO5MVTDywykXSlKEZ2Iky8O+AqXz5iPwmq9xU15xRfjPrnelUvt1xHWBhv7aiG1qj+5ipu
	knxSrTtPpaKYgMZJ/LxhDep7LF3WHGLlUit6yChQREYDjG2Y+ePdILuyIbo0139C4ah81/
	O5FSFrdtISfTz4vC5R9RrgqsEB0ksfY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Nur-oF1POIGcEZCUEtvuyA-1; Wed, 13 Aug 2025 04:41:14 -0400
X-MC-Unique: Nur-oF1POIGcEZCUEtvuyA-1
X-Mimecast-MFC-AGG-ID: Nur-oF1POIGcEZCUEtvuyA_1755074473
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-459d7ae12b8so44833585e9.1
        for <virtualization@lists.linux.dev>; Wed, 13 Aug 2025 01:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074473; x=1755679273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76YJFkH9eIhBYjG5GaaJcP9B1ox/l/WKOLKsUlz9rUw=;
        b=kJsxF/UYOc4atnkSJLAuugi2vlIdqTK7hBIFaIXtCFFcFKERQgHw3Rtbz1TK8OtKlM
         9H+P1DmkeYtbeg24B2QDbrwaoSQ8bl8oC8/NEpMysYTdjVbKZePqnql42LuIxvxiT+C3
         +GfNc1KqsjAgMtuYPIUremJUIOqetNHo0SUANUpMGxMS7RYFdUxZASQ8+/xR6W1OtjAc
         eITrAxtINAjXk43zZMSVeHVsrUXwKg7NxX1ihYXmHE3ZxmE0CZhyfx7/3NokohCvSY03
         blFcGx66dCwd0WcirktjD2QVn1/2g1v1/eQjArLi0soBDqlqg4CTJ29GkahDpmH7WwJw
         KO3g==
X-Forwarded-Encrypted: i=1; AJvYcCWMODHySe4VxvBMrhritMDxapBEufS+uaNlsmRDlNqmxTisE6hd+GP1pi1DqGVaftO8ZYmThVcN3BQNBQIhzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgmK8KpVIiQn7nXliSUZKhJ5sOQNtOwErckvtD5lXJZYzx76aH
	kzVYdsbs7O7IKTtPpI1o/mp+UzDFm7hRn3Hch73jhVvsSPyfviCTdkRfhpyA+knuZj5JmR/5Qag
	PZvC7qURid2L5qCl63W/Pj5vbdwp0Go+W5n01pEI87niMW6Du7yhnWCTxiQSzJqmVy11+
X-Gm-Gg: ASbGnctYkHsTphwkzlsv7IfCIzjCTlRvN+p7SxK39mPnHI7To1EKy3LjMTrfEZ19RIK
	gJu/S6HOPfmyCdhp6hTVcOKyyIErvmfuqmReOkS8llL2o//yYzjvm5BsNaTii5SKDJnhGy3SvLw
	OUuXqXoipDZAISDDzPAmMRVWG+lvZw2YL8JaKQOxSZxpE642U/h0SKKnZIrBFCQcYQXOMd31thm
	wTu5b34ej7w8hWFj/70J69T4ajMd77Ib14Hwr6B4TNyewvnQzR24UdjPsaI/jVBzG3HmhVcksJZ
	iMsRUuT5jrgFqjIV8dy2s4ReE1tZf8JF
X-Received: by 2002:a05:600c:3106:b0:458:6733:fb5c with SMTP id 5b1f17b1804b1-45a1664bdb7mr15733005e9.28.1755074473359;
        Wed, 13 Aug 2025 01:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAoH7imNQ2C+/iwNJvGO5T7E2kVVUhVdyltcXD3iFW1FubZdXr/O++cAjLCc7t/dYIu5pcLQ==
X-Received: by 2002:a05:600c:3106:b0:458:6733:fb5c with SMTP id 5b1f17b1804b1-45a1664bdb7mr15732735e9.28.1755074472965;
        Wed, 13 Aug 2025 01:41:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a16ddb9fbsm19841985e9.9.2025.08.13.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:41:12 -0700 (PDT)
Date: Wed, 13 Aug 2025 04:41:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, Keir Fraser <keirf@google.com>,
	Steven Moreland <smoreland@google.com>,
	Frederick Mayle <fmayle@google.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 9/9] vsock/virtio: Allocate nonlinear SKBs for
 handling large transmit buffers
Message-ID: <20250812112226-mutt-send-email-mst@kernel.org>
References: <20250717090116.11987-1-will@kernel.org>
 <20250717090116.11987-10-will@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250717090116.11987-10-will@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZI_9LgWc8OPr7k1Gz4KMnuFhMvt2T_zQUqE8t48VtsM_1755074473
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2025 at 10:01:16AM +0100, Will Deacon wrote:
> When transmitting a vsock packet, virtio_transport_send_pkt_info() calls
> virtio_transport_alloc_linear_skb() to allocate and fill SKBs with the
> transmit data. Unfortunately, these are always linear allocations and
> can therefore result in significant pressure on kmalloc() considering
> that the maximum packet size (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE +
> VIRTIO_VSOCK_SKB_HEADROOM) is a little over 64KiB, resulting in a 128KiB
> allocation for each packet.
> 
> Rework the vsock SKB allocation so that, for sizes with page order
> greater than PAGE_ALLOC_COSTLY_ORDER, a nonlinear SKB is allocated
> instead with the packet header in the SKB and the transmit data in the
> fragments. Note that this affects both the vhost and virtio transports.
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Will Deacon <will@kernel.org>



So this caused a regression, see syzbot report:

https://lore.kernel.org/all/689a3d92.050a0220.7f033.00ff.GAE@google.com


I'm inclined to revert unless we have a fix quickly.


> ---
>  net/vmw_vsock/virtio_transport_common.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index c9eb7f7ac00d..fe92e5fa95b4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -109,7 +109,8 @@ static int virtio_transport_fill_skb(struct sk_buff *skb,
>  		return __zerocopy_sg_from_iter(info->msg, NULL, skb,
>  					       &info->msg->msg_iter, len, NULL);
>  
> -	return memcpy_from_msg(skb_put(skb, len), info->msg, len);
> +	virtio_vsock_skb_put(skb, len);
> +	return skb_copy_datagram_from_iter(skb, 0, &info->msg->msg_iter, len);
>  }
>  
>  static void virtio_transport_init_hdr(struct sk_buff *skb,
> @@ -261,7 +262,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  	if (!zcopy)
>  		skb_len += payload_len;
>  
> -	skb = virtio_vsock_alloc_linear_skb(skb_len, GFP_KERNEL);
> +	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
>  	if (!skb)
>  		return NULL;
>  
> -- 
> 2.50.0.727.gbf7dc18ff4-goog

