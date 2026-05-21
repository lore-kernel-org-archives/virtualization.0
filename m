Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AA3C81B2
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368985; cv=none; b=pb6ej/hi4Rnux5qhHqqhTXOwpzWlOrkolUgDrPMHewNLqX0oIb1TdH0lzQQh/X01xDYnsrrdTT0bETlyaDVreFWrJLJmo6QQoV/IVsck7GBDIrBd072WjV88MWUc5aJvw2D9i5+OOzl3wJMhaVUmO5TRAKrC12hVzDGpKN9czgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368985; c=relaxed/simple;
	bh=Jdm389GpaXuX2GWxlZhF6BpB83Vj3ksApFOhdPl2pZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tCNv2CMBH11AqTP85xkARLhLwiMwZMGghucCx0oa+gvnr81eQ3zEk6PsRIeSrQilWD4k5GKnCnPHCAypiwt1M8R3KYzcx7XFKhqhnmiF9iCkNiqGjG/mBVgk3CFVpPgyO3fBHWAayNcuFLqo9wyOAmIB4ubY+ccMH4o2w08upjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9VLScIj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9VLScIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779368983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E1vW/XPFrOLYW0lggR7O8cskrXPHeM9SnYmkXYtZE2U=;
	b=V9VLScIjN+NhBKis4WUCTC2eyMjIRWjSwj2roLaAjHk8+GhLBsQy0RF1x7wi0vjDhb/apA
	78TIbboWCWPAs0V37GtcSQoagELJTvQbNi1bLCHuBQNUpUz1u8RZpASjjpP6AidYZL9Zku
	RN8P/o4o1OuzVIPg05g9S56TYHuUFvQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-ei6XkOxQOl-znBp8BCA_5w-1; Thu, 21 May 2026 09:09:40 -0400
X-MC-Unique: ei6XkOxQOl-znBp8BCA_5w-1
X-Mimecast-MFC-AGG-ID: ei6XkOxQOl-znBp8BCA_5w_1779368980
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ea38c03a1so816665f8f.1
        for <virtualization@lists.linux.dev>; Thu, 21 May 2026 06:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368980; x=1779973780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1vW/XPFrOLYW0lggR7O8cskrXPHeM9SnYmkXYtZE2U=;
        b=kyTYKSCMi26rjSvYkbANj+bcbPf4CTLJGtNtt9YtGbgs+yiSUNKDosmdMkJyeYYDBn
         M5gGTQBGKU6Igner6KrroCbA1PlcudDScGw3uI+y4cL9njVTvnjxknvCjtku4Jbpy7KY
         jlP6o+ftp/nnxs2hAGJZ+WLn6aF9Qr5o924GQlIV7jMPRE7qRQVdgYHJzFqVmfTeOGjx
         RgmY4eSkLWln92N+eXNYhaHrljoHyjZQigE13pKBZ2IoI2UwX4p/Jeqp1ROfqZfvF7uO
         JTuRiNRioUdvu4WkE5KHAmNZzni7XOnX6z/FRP2Jc2sO1g4EAF8/K8jKlWEggux3iT8f
         w7FQ==
X-Forwarded-Encrypted: i=1; AFNElJ++RDGnarvR3BTdn14ivfKolbZp4GENeQJVLQWno5oXiQ+YDomY/B3b0lXvsIodpumHfjFZavMRb7DpgQpBww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz++tvQnE6/g0OZRNK1ja5KvgwUXgfFbBUaAFonNiubeDU/BeeB
	+z83A/qtttJffeJbqtqagTXze17t51RhPWr/93pxnIRXdmIM5FXwt6v5RUkElTRosYrycoaStw7
	Sp/Slebayh3RFG7F5uuYNsVhbQp08YS6vfMHJmUaq39eT0sP02q5/NAR4JyTDXW7N0ajw
X-Gm-Gg: Acq92OH9ilLcmUCyc/zNG32c7bCo6to+tpotWNN84/H7ZD7C9P4CkhmpkyAp91wmHqE
	uAd6xaZM0BfuXm4FNP+Yd9UnMVsoPgOJlA7gqGfyWGQZwX/+1UOiiCK48qufoU+YnY+6P34cXGW
	+g6Wil1sedNEBUsopBiFtRzjjxdFFxDuEKh2KRaqXuQ+z5AjS5WdDKmHbhtFfQ0QUrSUt4bsnQ7
	o2nBg0m0+bH0ACvTIi0V08QTle91F0M/Ah0sX0fvP3t1L8Vbk1S5OJLL4LlBkFv94UIMXwByhji
	usC+WaNjXpcCrsmYZKgsG+OjjcRllJAEYgFQbiEVjZQciOZJnHbHvKroqr1f7u4xgpwrL7/9q1I
	u/Zr1z74tTESIaIV+vrxEZcgQ852au5gJjCaXg4CnyHQ=
X-Received: by 2002:a05:600c:a15:b0:490:3cef:bd90 with SMTP id 5b1f17b1804b1-4903cefbe6emr23446885e9.26.1779368979412;
        Thu, 21 May 2026 06:09:39 -0700 (PDT)
X-Received: by 2002:a05:600c:a15:b0:490:3cef:bd90 with SMTP id 5b1f17b1804b1-4903cefbe6emr23445975e9.26.1779368978717;
        Thu, 21 May 2026 06:09:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035edd7cfsm15236405e9.27.2026.05.21.06.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:09:38 -0700 (PDT)
Date: Thu, 21 May 2026 09:09:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jason Wang <jasowang@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead overflow on 32-bit
 builds
Message-ID: <20260521090927-mutt-send-email-mst@kernel.org>
References: <20260521124732.125771-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260521124732.125771-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -vPUkLyiGGTahwGNeFZwG2b3xSUP-yZTUV11_dN1uN8_1779368980
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2026 at 02:47:32PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> On 32-bit architectures, both skb_queue_len() and SKB_TRUESIZE(0) evaluate
> to 32-bit values. The multiplication can overflow before being assigned to
> the u64 skb_overhead variable, making the skb overhead check ineffective.
> 
> Cast skb_queue_len() to u64 so the multiplication is always performed in
> 64-bit arithmetic.
> 
> This issue was reported by Sashiko while reviewing another patch.
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Closes: https://sashiko.dev/#/patchset/20260518090656.134588-1-sgarzare%40redhat.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index df3b418e0392..71198bf23fc4 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> -- 
> 2.54.0

