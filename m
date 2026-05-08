Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDD53A0EAF
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278966; cv=none; b=YV7LI7TBdkckRp58imNdFKCzlP2PgIS8p+TOQ96nq6nh8iy3ZHnZ9/GmQkc8Us+X87xW7ksH+1nBdC3Yuxz/hPq5MjzzhVe6k75Bf9yHHi2KktPXuk3ZaB48fGXgIKcTU0ngoghka4sOAvuoVztJhzJbjN99EMtTr/61PoODiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278966; c=relaxed/simple;
	bh=ybo2HK/PI6PDF5GbqOTLQGuk0Dq2WjaK+tSFJS3Pp9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SF2kMNN/0yHDCMixZO2eUMg2haMNjwOfP+ZI8530pJqEheOcJVQ+F3qk3wuD/jumjS7k5SIigQHrUcEICq1wQqxO5xR0UHVFmSTHrNX2VEzO5RAUZ470N+rD+QwloRc3w/23Ef392UrgoUuxdWB7mYkieDQpXUhv16hRgV5DBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=olBkt+PA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olBkt+PA"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8aca4e14411so26215806d6.3
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 15:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778278962; x=1778883762; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MQa0UpWFwjb5S8kUnJztiH2lQyqJ0Jvx1ScOQZwHKA=;
        b=olBkt+PAdYGr7qN+w4zHTNfv012ECs89cAVIg7VptgCVTDHvSsfpHtTzv4afpCEYuD
         +8ct9QvmpPMiu7CdgsZnnhlNEQPLXocq6PJ9Z5eYogGiae+Pn7hp72RAZFToxbrfAy0o
         cFdaND95UJCWQGOlm+hpjCRwEiZrzf5xCJc8uRQs1d/FlZ6ZyOZf97kafFtzdpRuiFwf
         hu19oE1lYCxfTz0g2xff4GV0e8m/rfumJPSocC7RyDdwVdt8YqG31angxmbPe6wfQhn9
         RTrPFoiqyEwR9ftVwNzSIUpxaHN+MgcL3sb1dgUBVvghi99i9SSITTxu20dVTjC4G386
         +idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778278962; x=1778883762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MQa0UpWFwjb5S8kUnJztiH2lQyqJ0Jvx1ScOQZwHKA=;
        b=d58fQaxr/D4wXFW0TOxFiHYlFwx17S/kVDxao39YAAGaHEugY1sjps074+r7uNkKbH
         oc3lBVE97B0FhM3Z7AP7fxaUy3VdW6c6+7/aHojQa6WubVQT30UA1HzgxlrUbeZjRQ7w
         kgWk6p/VJ9DVEVmpcP8k/j3/nM3SY3tNbB6K0xVimAfhoEZkSjyNiLz/nqnIEB68XYm+
         DmYoFxn5HHo/Dc7eLsK+GxeNSOMevqxQ+K6C0mr1xISTJyAHe5BYuYSCJZmsahvIWev6
         +f2RTe/hsna69mTwtjG+9ttLQsaqtnYVQeddKpGlippmSW4kIYwc73BFazMjVdTGDAkq
         QHSg==
X-Forwarded-Encrypted: i=1; AFNElJ9PK2KAvC+eZbO7zohymnj1oJUGT0bteIgB/prHtCEBMkRkCnEQtO7Z4X5z8757wGMuKVtzV54pv32bqbX22Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlzPx0df7xXJNz2qCyGWZfDL5ZAy73omW3nLpc83q9i1OFRX18
	kGusJfMIbjteDByBOymd8fZsVxGLobn6coxHFrETE5rZo9zpv/YrfRQ2
X-Gm-Gg: Acq92OHP4ZVIKkONUcxC1XLlVhn6HUiV04mOsTKbdyNPKcuNbzRUp5lEMGnYctNrJHj
	I3pBBiPWiJ/qtaCB7mQLQy6zn5lxGGartnAfe4sf0TMC5fk4ddEswtQ25htr1IruHsqSKqqqkXh
	qUU85Zkgb0DP1g4y8BIOIRkPLbutk7al0YeN0kw/d0T9lvzNFaqGy7C6Ba4Cayknfmj7SrLhoDm
	/Rm3jtFBeI7vkmhkGf5X9XNGPYaccGEDxFY4S0hxz9KHvp2oHbN2PfnUePWydHzk+N0gFAq05HZ
	fR7V8FbZUScU/acDaJwTCUaEsvTbAI40LXY8p2XBc6t9bRWV2DX7vAFLaie1FQu5Jp/pwy7OzdL
	Y6yJsdIcwvMOSEGAyDXybrrvrixoRyDUWWmPnW/TQeVtc21PGAWcZfrNn+tRbyKAzSXEYe/fCwL
	wle1lkMMhV58wbyqcYNSEUemCP2Q9JwVHiaikFcX1obKyaU6O4kPYGIdY=
X-Received: by 2002:a05:6214:258c:b0:8b0:2ae4:da26 with SMTP id 6a1803df08f44-8bc422a66f5mr208086466d6.10.1778278962004;
        Fri, 08 May 2026 15:22:42 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:72::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf39c81b3fsm30363126d6.29.2026.05.08.15.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 15:22:41 -0700 (PDT)
Date: Fri, 8 May 2026 15:22:37 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Yiqi Sun <sunyiqixm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowang@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: fix length and offset in tap skb
 for split packets
Message-ID: <af5iLWLo4Kz+USum@devvm29614.prn0.facebook.com>
References: <20260508164411.261440-1-sgarzare@redhat.com>
 <20260508164411.261440-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508164411.261440-2-sgarzare@redhat.com>

On Fri, May 08, 2026 at 06:44:10PM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> virtio_transport_build_skb() builds a new skb to be delivered to the
> vsockmon tap device. To build the new skb, it uses the original skb
> data length as payload length, but as the comment notes, the original
> packet stored in the skb may have been split in multiple packets, so we
> need to use the length in the header, which is correctly updated before
> the packet is delivered to the tap, and the offset for the data.
> 
> This was also similar to what we did before commit 71dc9ec9ac7d
> ("virtio/vsock: replace virtio_vsock_pkt with sk_buff") where we probably
> missed something during the skb conversion.
> 
> Also update the comment above, which was left stale by the skb
> conversion and still mentioned a buffer pointer that no longer exists.
> 
> Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9b8014516f4f..a678d5d75704 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -166,12 +166,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  	struct sk_buff *skb;
>  	size_t payload_len;
>  
> -	/* A packet could be split to fit the RX buffer, so we can retrieve
> -	 * the payload length from the header and the buffer pointer taking
> -	 * care of the offset in the original packet.
> +	/* A packet could be split to fit the RX buffer, so we use
> +	 * the payload length from the header, which has been updated
> +	 * by the sender to reflect the fragment size.
>  	 */
>  	pkt_hdr = virtio_vsock_hdr(pkt);
> -	payload_len = pkt->len;
> +	payload_len = le32_to_cpu(pkt_hdr->len);
>  
>  	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
>  			GFP_ATOMIC);
> @@ -219,7 +219,8 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
>  
>  			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
>  		} else {
> -			skb_put_data(skb, pkt->data, payload_len);
> +			skb_put_data(skb, pkt->data + VIRTIO_VSOCK_SKB_CB(pkt)->offset,
> +				     payload_len);
>  		}
>  	}
>  
> -- 
> 2.54.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
