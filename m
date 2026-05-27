Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301845106F
	for <virtualization@lists.linux.dev>; Wed, 27 May 2026 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905372; cv=none; b=IWW87T/FPUj1ZKEpTgHjYnKvSMcqjmz1Pb/vwOgGLEb+NpRb9giLoG+7/NXy4uZ5w43ySMN1QW4AQTBUEPrKuTRqjV90II6G4K33cKEov1yELc73CiVnF6Ja6ueqb6rB8YP5yTvsYGg9sRDZtzypBGccN9mx9hKv/A1kWySKwX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905372; c=relaxed/simple;
	bh=htlmsUpxEnizeUP3B6xI1XKO3j5rovXUVkrwa4G5o5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/YeydqHmJxhudOD6RHM0jHxnLcn4hqBA7uOQBUfYBS1KucG+6AP+ai8OQJUzGf5VEmHZOwdgaYrMLg98SwftX1fn0socZWEC6GlIiXZAauPp6xgzLF82SDEhw9ehfjq0/PkJ+cVsNIGarBGOyVQ0VYjGUY1+NsCc4GcQfUqGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R13iU/lZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R13iU/lZ"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44a74032ff8so8927018f8f.1
        for <virtualization@lists.linux.dev>; Wed, 27 May 2026 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779905369; x=1780510169; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pkyf7riAoZs+kZFhuxOcxmnZXgTl46iuUo4KIhOjOqA=;
        b=R13iU/lZF8tngVuhJe75bSTajMyKseRsFMaOl/eGoGPLyBItm2ZP+nYkKNdkqgQXmU
         VgvCKuclnLnWpJDB3AwbPIA89NirHpvk+j6drmttCsL35U/AzXRfEwzZ0onoPfLWtJ4F
         GwFGkkGrQ8JgV0pWzkWCHGtdELKKkQz/i7xayZ46iWKwHUKdI143faU0CYbd9nLM0rVa
         DtQbzEwCv3htfzfbCLEHFU4zFxgC/Zdv2vWiTTtvfOftV1Z2MSbGipLFPigqB4Ekh5Xh
         lP1c53sNrpMtCHzLf9X9hRvQOBAOI1XZl/TN59sF5MtUwo7S9cTknVUQhfEW1r8U9zsy
         Xnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905369; x=1780510169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pkyf7riAoZs+kZFhuxOcxmnZXgTl46iuUo4KIhOjOqA=;
        b=XpUoKq5GlU6l2s4CWOnm20GU8TCQ+sd+isiA1DZrdb4F10CRZbiOtJnvWxfnTrwZjO
         WZcnim5W58tkRcdhCVOydvw6ShgPMGd5Q+1twkPAlIWykRkNQPaecWyTb94Zsx2U7n4s
         gpepYBQyMO3AuH5bcNgG+Rs0IHRbPWYECOhelUR8wfIIGxTrBLlOAnewyw2/q3sbOTzi
         Sk8LTIvs43j7INUcno2AcnatZ1t6RQo/V+FY5ew5PYnYXLPcuSw4Wyg7MHMO151iHvI5
         Vahn7XrAabiXd+1HvUrh8f8Lj19ImMvl6EJYasGl8+NX/iQUEsj7mEToDRo09m5v9oeI
         48VQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dcW2CQ7tPl6BXDKlX/ej4UeB3G2DrcXJRhgaJ+vqPboHYb948g7kgCQrqfPN56n6r8e6Nf0UmveuC9NidSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxk1Osyrark1w8z/TT2O7v3ZwFUpZ9XwSzW819+oCj0/BmvpWSv
	1uqqH+or8WeSAVTiyT6IDrBeX7GVTKZdwHh3ORI5T6te2nSNvKTapMrO
X-Gm-Gg: Acq92OGtp1e/yYjuunH5MMwe1tfuV8CZrise6sJb6XQNrqlm8gvE2o7rD8DnVj6MTRB
	vVChH381tTbulkbKUOB1beOOycqg2IYnw3LOeSnfZU07o2bvqMQAPjZ8cu/Z5Rp4dftwTJZ9L6X
	8bzQvICzE7kpd/1fQtDczgVCGZlie8yAvT4Cyr3+fda/yy8Aj6o8CcfK+UWuKKIzoqLNxt8gVzD
	3LTVwAql3QdnADfCfq6CRlxll68QXLhXaY3h1+bx6DbCBpujTpvvEtJDF1pE+vgDQexGvCzP1aT
	sx9+n6lxx3Z1LjWJCfoTeHcWaKR46x1JibQ+/XSi6j5LcHEXYVCowbYbSY2lDUa7ieZIrj0fniK
	RendwXzT7bTTBPyDz05iu0yfaH6JkYOV7zRMClOIRhU7bOw16vNXfbIz58kp9GaA4+eaNLclfhd
	Y13PD+fnO4QhRGhLB8vUbRcGFiz/5etu8l/p1hjLkGvaj9LU9+2kjpqt7hxJJ0wKpe
X-Received: by 2002:a05:6000:461a:b0:441:1c06:17e4 with SMTP id ffacd0b85a97d-45eb38a8032mr33753535f8f.39.1779905368393;
        Wed, 27 May 2026 11:09:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb558449sm7086121f8f.13.2026.05.27.11.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 11:09:28 -0700 (PDT)
Date: Wed, 27 May 2026 19:09:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH RESEND net] Revert "vsock/virtio: fix skb overhead
 overflow on 32-bit builds"
Message-ID: <20260527190926.1a2d6095@pumpkin>
In-Reply-To: <20260527171046.130211-1-sgarzare@redhat.com>
References: <20260527171046.130211-1-sgarzare@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 19:10:46 +0200
Stefano Garzarella <sgarzare@redhat.com> wrote:

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

FWIW:

Reviewed-by: David Laight <david.laight.linux@gmail.com>

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

