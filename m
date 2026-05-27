Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331243E9F5
	for <virtualization@lists.linux.dev>; Wed, 27 May 2026 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902528; cv=none; b=NiZ7QOtYixHZGUvsp6JVtDrQImPEI/SJyUP7JGn0M8T5RyQesNihg07bO1ORiFAi0uRDyc7LxW14j++m2fldpqvZFKAY1BbHegyDHzr0c0OckhG9fzKjtLo4gzhScnLA1RopO1r27Unc7c+PItnZnc5/yIl7K77SugjSaNvatFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902528; c=relaxed/simple;
	bh=CPbqDF454Z+Ji6GvjieOLoul6JPLkeDeLkJZd8vBXK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=u9Lg8t6V8392HJEC1BuJGy8UrD5+8gg3SsjFmoL2NEmdwAVkDuY8JKC+wUU2LKEsTlUK6ONvRIy3cr9KFTtmiJud78Lh9pJBMcKr4xDPzAcnhZzUcz3nPmHn61nXALJV5UZmPhV6mfgy7NrMWByuaWnJ2D/LsoPwAkrpql1whP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIW0v5z+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIW0v5z+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779902524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O0yXQEHNKQkMY2wBw+4QDVrKj1M+JOLPnqN2RUokaPw=;
	b=RIW0v5z+/A2bgnSZBypcBlJ4mL6YEVobKJHdPIddruUEvX92N6XNtaIXVoCwoCvyaKIRQC
	ksCM0v4O+HkxVSB6+HYgdHyRvjmlQWmpWNfZlegUyWMUGsTEgHQa0H8E0ULTiqDsm0iHP+
	0WWiZt2BBi/Va1YB2bvd0bd7Xtm7CKY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-WrXZlQ35P1qTURu00oyG6w-1; Wed, 27 May 2026 13:22:03 -0400
X-MC-Unique: WrXZlQ35P1qTURu00oyG6w-1
X-Mimecast-MFC-AGG-ID: WrXZlQ35P1qTURu00oyG6w_1779902522
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd3dbd16aso102221485e9.0
        for <virtualization@lists.linux.dev>; Wed, 27 May 2026 10:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779902522; x=1780507322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0yXQEHNKQkMY2wBw+4QDVrKj1M+JOLPnqN2RUokaPw=;
        b=EEhhishlxZJO2rMv/uXKTqzLJawnBAMYwj7bQkXeU4Cqbon4OpMUWoSm7jCgYAB/WL
         rKRYgXwyTj9NjfbJIez0koYzBdBDxYrXm6cJKHpBM1/Nsrkcc0B99mAhw0JHwhIEdQuR
         aW+3mQxzYkmqynevuwlHTufDGMRdN6bt17vHx3rErzyojzXR+LTcPhhG9p7CpiN8k57k
         LwGjf+d3EZ6xsk/+nyLeFbyRWNEIxsR9eDQJbrFDkv2s2xCsy7YO5/qBQ07EDRKf9KtH
         XL3ORqD1n0837TFz0Xq2pZ8JJMtVU7Qf41q1mHMGf0q5Vo2qZqIUc1msy7lxNFYRn8iP
         mOgw==
X-Forwarded-Encrypted: i=1; AFNElJ/coiMjJNhC9+E+wx3539M59c8gd2UTyRVbi3HIX/U5c7MdQR2O5/IC9bPoPegqJsZZUuuJfyGmc3sABI6Uog==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxyBGMfOQ5nIlJ7RSYD+D6q/mgUZpZlnpRtlS+0emEQxtmYXIW
	CXsfEcADG2IOppdteiZCozgMITuvcwTy+0bW2B/wU9tcjJbASe3BaOR++2ppCytE4ii5PWrH6yh
	oWgRK9xfMwuPnFlNh/MIkkcO8/NfmV15/cypa9WRYtteDMzbBolHea8xY7djiHGgnw6pq
X-Gm-Gg: Acq92OE5sxE2reJZqNBvkZbzHBJaydeuPWaJQPtNeVL+xChLzcSy3+T5E2Uh5CxTfDX
	go/wSV3aKPRLLXD8aW3aC39C7Dc/SH2Mkd94eWG7oG5uDYNU/RcuwFQWJlqglyWxNXWm20wqBkc
	xrmhvS5ZIN7cFPHhjwhRZ5LaYftSBrf0zDfkhMplnGEylvAcLYFV/tdEoe0KoXci0EoX0bf9813
	/dGQdY0kKbSTxELtIXZCggcUSX44uhg9ZLU8GanOrzrp14Fu/fi0sK9Iad/jpBo1UzZZ5WhItmO
	B05UiZcmuJUtmCLrxcGodXZoF9cZsEQmJPM+UHbn8K77603Wq86pG8Saj0CgogrgNTTCyI7WMuL
	b8PkG9DYQzHwR
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447993295e9.30.1779902522043;
        Wed, 27 May 2026 10:22:02 -0700 (PDT)
X-Received: by 2002:a05:600c:35c8:b0:48f:f7cc:f703 with SMTP id 5b1f17b1804b1-490428e2d58mr447992735e9.30.1779902521535;
        Wed, 27 May 2026 10:22:01 -0700 (PDT)
Received: from redhat.com ([31.187.78.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee2a12a69sm315565f8f.16.2026.05.27.10.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 10:22:00 -0700 (PDT)
Date: Wed, 27 May 2026 13:21:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH RESEND net] Revert "vsock/virtio: fix skb overhead
 overflow on 32-bit builds"
Message-ID: <20260527132150-mutt-send-email-mst@kernel.org>
References: <20260527171046.130211-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260527171046.130211-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vt8-13FSyiy4njsC9-1w4ul4-CnNZxeZ2Tko88rkZaU_1779902522
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2026 at 07:10:46PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
> overflow on 32-bit builds"). The fix was semantically correct (although
> it would have been better to use mul_u32_u32(), as David pointed out),
> but in practice we are estimating the memory used to allocate the SKBs,
> and this will never cause a 32-bit variable to overflow on a 32-bit
> system, since the memory would have run out long before that. On 64-bit,
> SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
> already in 64-bit arithmetic without the cast.
> 
> Let's revert this to avoid unnecessary 64-bit multiplies on the
> per-packet receive path on 32-bit systems.
> 
> Reported-by: David Laight <david.laight.linux@gmail.com>
> Closes: https://lore.kernel.org/netdev/20260523173557.5cc4f4f6@pumpkin
> Suggested-by: "Michael S. Tsirkin" <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index b143290a311d..d4d26fba9e37 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -417,7 +417,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  					u32 len)
>  {
> -	u64 skb_overhead = ((u64)skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
>  	/* Allow at most buf_alloc * 2 total budget (payload + overhead),
>  	 * similar to how SO_RCVBUF is doubled to reserve space for sk_buff
> -- 
> 2.54.0

