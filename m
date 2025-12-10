Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A732571A
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765374461; cv=none; b=BGRqia1uLp0zxuogPGsDgYZV82txuSvNn2I7CHJnYaZNzlTvLDxNJq096FIqBD3p3J1HwpU9t8xSYK9xwN05JiDigN7wh3LaOCHXsVFywTMMitWQVHfN06F5aFz2/g2ckw5DdSsWxKmxec8Xxv/h/mU7Z8GRPsH/oaSNQ7/wOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765374461; c=relaxed/simple;
	bh=CeBJJK9qDZuXXuVvS2+T2iTGf8HWKyVfgoO1+dvvBfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=AQI0ChcHcFF4vVlvn1XwR2Lfw66bz0z3wMkOODxXBKG0JR3lVLcSCB56+n+HoMOk41PMN9HjGioJ5KjY7x6h9bjG1EpuDI2+zD0oDKj6q9TzjobXipjwbc0vcfQBbuq42zM4rRJryAX1+PLrh+UGRJ06MV0G5obFavaDCV4CsgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvSQTkqS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvSQTkqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765374458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8lpG6zjZ8rp4g1clQM1+Gw26UIeELt9eGQsZzCeUek=;
	b=OvSQTkqS7/E15Vy8bXWh5hDgcdSRlcjdaI8rviRc2q517timr8hcsGpDaEFOO/uJGPpHKx
	1+0PgT9OicWbnc3FcbJGrmFNNfOqGqw8zHRQYkK1vDF+tTNND7K8IAxJP9N7qVJmLrFvyG
	opZpN/GkoEE/YOe1ovwzRqBHk/P2SEM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-a4okcoQbNBmCcpuUAzCbOg-1; Wed, 10 Dec 2025 08:47:32 -0500
X-MC-Unique: a4okcoQbNBmCcpuUAzCbOg-1
X-Mimecast-MFC-AGG-ID: a4okcoQbNBmCcpuUAzCbOg_1765374451
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2ad2a58cso2825157f8f.0
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 05:47:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765374450; x=1765979250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8lpG6zjZ8rp4g1clQM1+Gw26UIeELt9eGQsZzCeUek=;
        b=wuxzzXJM1cWlkX+x4ECEsIZ6ppq/UgWWVAJGCeld0F2uRpda83jYONuWxBXFKHRpJV
         igB9mea0SdRBp3+Qa7S3WxcKKZJHoAH5Ok9v9YItNPPk194Fq4VJnTDAHsjcuiDwxDAi
         y9A1r9B9hQ6KZPOhXydb4wmK4gPFnWTu8ije9axTSdxC1r6Cr426qxHKr5qszVd9PjzU
         TN/HWb3JMKSEoB0v0GQIbKpcmPr9Nk4CVt3JT1ZQ10YndXtCysWOn9eWDMUHOE+8bwnc
         VSFvAxYhPXq4k6DivsKRpM8s5krtSvuFJbSzcTx00qa5lpVExDH3C4qz7IsLn2PO7//8
         +z9A==
X-Forwarded-Encrypted: i=1; AJvYcCWhmIZqHUO8yRcz90HZZdsvYeotp7d1dMr6LgLc51ybVncZWSoPZs3zL62rMav7fsBJEnaiF6Lp4EZI04WO+A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ5QLKqMqetbG26yPZtagzTmpsXkBZJPhj5HmVsZ7JzhEM05nc
	Ls9wSak9jW+MeDH8f85AD8dYyf9NqyF72fX9pCOusQpknQnRow8yu0cuF0xr8qBkH2FXtRgBH/z
	lnZuUX91AosRSh8UyPXrh9icBp+9qxLBEACjuhLX2/9uSPnK8EqaCOtDraUvrnjc6IAJ9/HN56j
	5e
X-Gm-Gg: AY/fxX4VtAzuhVhLp56o5n3nx2GDxaGaKancqHvOUrpDXQimG49NT+kxR7AQbyNVNLC
	G/Oo6xVg0ZCkZNzMEKStPsA1RAgagJt3XFjJKxFulG2rKoYZnriDkRrhCvr4UXsvGHK42aTZaCF
	veDuKqxFx7b/38M1uigM0NmmAEPRIHATfJojwChirjLnDZ8eqWPc8GFm8Om42Z100lH2H6xGNP8
	DYSfzEdzgIQSobrazy5vVB2y4OVsAVCs6O2FmGamsdUwH8tGLNpwUU8I/wFaLPbttYfEwE1zaRM
	U47qnE2aDsECFiy5qqmnbbVJwjlyA+pkeJkWkJsp5ecZBqwGda/ENBiUJj3xQuEl74UK8PjAieW
	v
X-Received: by 2002:a05:6000:22c1:b0:42b:3ee9:4775 with SMTP id ffacd0b85a97d-42fa39d93efmr2861945f8f.11.1765374449974;
        Wed, 10 Dec 2025 05:47:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiF31+YAxj1nTU+k9IKhu5KpZ7qCaRU00CbygNqArk3v8Ax9QOK6j54I8ZYvQxFU065UDJWg==
X-Received: by 2002:a05:6000:22c1:b0:42b:3ee9:4775 with SMTP id ffacd0b85a97d-42fa39d93efmr2861913f8f.11.1765374449390;
        Wed, 10 Dec 2025 05:47:29 -0800 (PST)
Received: from redhat.com ([31.187.78.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d2226c5sm38428743f8f.23.2025.12.10.05.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 05:47:28 -0800 (PST)
Date: Wed, 10 Dec 2025 08:47:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, sgarzare@redhat.com,
	stefanha@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH net] vsock/virtio: cap TX credit to local buffer size
Message-ID: <20251210084318-mutt-send-email-mst@kernel.org>
References: <20251210133259.16238-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251210133259.16238-1-mlbnkm1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xd38xgglwKTvlbIQs8fVyKwDWGRz-MB6bxHfJUpZJGo_1765374451
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

thanks for the patch! yet something to improve:

On Wed, Dec 10, 2025 at 02:32:59PM +0100, Melbin K Mathew wrote:
> The virtio vsock transport currently derives its TX credit directly
> from peer_buf_alloc, which is set from the remote endpoint's
> SO_VM_SOCKETS_BUFFER_SIZE value.
> 
> On the host side this means that the amount of data we are willing to
> queue for a connection is scaled by a guest-chosen buffer size,
> rather than the host's own vsock configuration. A malicious guest can
> advertise a large buffer and read slowly, causing the host to allocate
> a correspondingly large amount of sk_buff memory.
> 
> Introduce a small helper, virtio_transport_peer_buf_alloc(), that
> returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
> peer_buf_alloc:
> 
>   - virtio_transport_get_credit()
>   - virtio_transport_has_space()
>   - virtio_transport_seqpacket_enqueue()
> 
> This ensures the effective TX window is bounded by both the peer's
> advertised buffer and our own buf_alloc (already clamped to
> buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
> cannot force the host to queue more data than allowed by the host's
> own vsock settings.
> 
> On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> 32 guest vsock connections advertising 2 GiB each and reading slowly
> drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
> recovered after killing the QEMU process.
> 
> With this patch applied, rerunning the same PoC yields:
> 
>   Before:
>     MemFree:        ~61.6 GiB
>     MemAvailable:   ~62.3 GiB
>     Slab:           ~142 MiB
>     SUnreclaim:     ~117 MiB
> 
>   After 32 high-credit connections:
>     MemFree:        ~61.5 GiB
>     MemAvailable:   ~62.3 GiB
>     Slab:           ~178 MiB
>     SUnreclaim:     ~152 MiB
> 
> i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
> guest remains responsive.
> 

what is missing here, is how do non-virtio transports behave?
because I think we want transports to be compatible.

> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")

that commit does not even include the patched file.
how can it be the right commit to fix?

> Reported-by: Melbin K Mathew <mlbnkm1@gmail.com>
> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>


this is the fix suggested by Stefano, right?
maybe mention this.

> ---
>  net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
>  1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index dcc8a1d58..f5afedf01 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
>  }
>  EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>  
> +/*
> + * Return the effective peer buffer size for TX credit computation.
> + *
> + * The peer advertises its receive buffer via peer_buf_alloc, but we
> + * cap that to our local buf_alloc (derived from
> + * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
> + * so that a remote endpoint cannot force us to queue more data than
> + * our own configuration allows.
> + */
> +static u32 virtio_transport_peer_buf_alloc(struct virtio_vsock_sock *vvs)
> +{
> +	u32 peer  = vvs->peer_buf_alloc;
> +	u32 local = vvs->buf_alloc;
> +
> +	if (peer > local)
> +		return local;

> +	return peer;

is this just
 return min(vvs->peer_buf_alloc, vvs->buf_alloc)
?

> +}
> +
>  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
>  {
>  	u32 ret;
> @@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
>  		return 0;
>  
>  	spin_lock_bh(&vvs->tx_lock);
> -	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> +	ret = virtio_transport_peer_buf_alloc(vvs) -
> +             (vvs->tx_cnt - vvs->peer_fwd_cnt);
>  	if (ret > credit)
>  		ret = credit;
>  	vvs->tx_cnt += ret;
> @@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>  
>  	spin_lock_bh(&vvs->tx_lock);
>  
> -	if (len > vvs->peer_buf_alloc) {
> +	if (len > virtio_transport_peer_buf_alloc(vvs)) {
>  		spin_unlock_bh(&vvs->tx_lock);
>  		return -EMSGSIZE;
>  	}
> @@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
>  	struct virtio_vsock_sock *vvs = vsk->trans;
>  	s64 bytes;
>  
> -	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> +	bytes = (s64)virtio_transport_peer_buf_alloc(vvs) -
> +               (vvs->tx_cnt - vvs->peer_fwd_cnt);
>  	if (bytes < 0)
>  		bytes = 0;
>  
> -- 
> 2.34.1

