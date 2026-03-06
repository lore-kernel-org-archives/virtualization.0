Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93C34DCCC
	for <virtualization@lists.linux.dev>; Fri,  6 Mar 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791460; cv=none; b=iZ56Cb6ETJd/WPYLK466c7rSEp0zDaSW+G+jLd9VUw/8y3XEpgEeA0BKPnu0yWesvw4bnh8qxQdZEPFuBJyat2qMIFG3/0k1qsU3QTB7eNkTs4v5i7a0WuLe/WI3nRvfawtM1oOI39ET93k1D6ZxaTkk2HQ+nVMDraMgkhzdlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791460; c=relaxed/simple;
	bh=Z2cELXZ0KRYKz2mT4NSv1jQwLS/7qoq2PvDfsysy/cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DaTfzQkzFm9hhwVzX5uCSrN/M3H9dQ/geQR9ksyKSOyNGZpb2kuUQxUhDG3U7tHFrGI8IoFKvJfGMSr2F+oqJ8/QzY4JiS2K/rAQCD7gQTi6J5+2QiHJUEcMjDVDkzlekykqQ3QVXbFUoD9Qw3tKiyrO8NXizuAC+NG9hRaA9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fi501bi2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fi501bi2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772791457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c032nPn10qD1G7pLCAe9iG0f9gLXWqOecaOZ3iqQgO8=;
	b=Fi501bi29OtnduOcTPYiQ9YOnOx7gEyTfwRYjPtxn4CzDRtSnlFJIvEkkcxufvOcsbh/j7
	kl8BEogStzMcDmn5pvWiGPK09XOwYhkPraOIPuzgAsKK1O8dULFIv3HIJhaEIl2ibtfyUX
	hcVerqSxkfEdAfLlxPSSfFDG1ULuWHw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-r1zJIe7ANAy7RLbYfWFNXA-1; Fri, 06 Mar 2026 05:04:16 -0500
X-MC-Unique: r1zJIe7ANAy7RLbYfWFNXA-1
X-Mimecast-MFC-AGG-ID: r1zJIe7ANAy7RLbYfWFNXA_1772791455
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48378df3469so64809425e9.1
        for <virtualization@lists.linux.dev>; Fri, 06 Mar 2026 02:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772791455; x=1773396255;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c032nPn10qD1G7pLCAe9iG0f9gLXWqOecaOZ3iqQgO8=;
        b=iLPDQcVLcvvPtXAHd0dC8tCzLXv/1q8zVRU+ab7hnwd/fvonzcy0/vjw7ACYMf6/rC
         qNJBkrFLKnPZiAUJJxO6oD4/Dr+3L0KaAwNUhoQ9MHTwRxL36bkKbCSo2i94KIJsB4f6
         Qi001WmDQTvpntyIELJwkCBDSnEdzCdMErWOrXdhhOKdP5bx2yy5vdoH8R3NcF6ed30G
         eIYIEKmwx7ktrN5p5JSc5I7FaGKcU7gxIVL+ywBONVqzGOspQxPLdiI4b/zLWqpenQvb
         BGPDlp8CV/uhlP1RQpfjxtknKHofRC7aAF2UcQVOQGAWR//5tOi+5aeQHUzxK6k/BdLF
         zKgw==
X-Forwarded-Encrypted: i=1; AJvYcCUpOgE7YlP+6BOqtbeb8dAL4YJljNQTW6P5qkvR4w2eUFxRooXNtrYKvQRdssObVFOh8mKncbYIY+FUMjZuHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxhj/S4dJZWFC6KHxzqrs84aNPyxKCU1EDk0lZ79PKCYxFYkHKS
	lTZ+vRsc+NEEHY8MgXb1XhuIEdIQpBG0one0NuBoSL2SNDcLSO0Gr+I+aNGE2Psv/z1ufbxasab
	4LLBZQTrtJVwKioSxRGt8IwbjCZxRMvEV+pzh/pot1OsYnOP1LmJqpQsi4Pov5RrANEKr
X-Gm-Gg: ATEYQzxlg2S81VsaDOd9HV1hPz0Wa3jr4DBaHit0LT6/B3xrl9oezl8JuAHggH06u4M
	Tph7Y6jXJUxQ2h7+Y2OqrLpyOBWwHl/6MLQNjraTInL7xi7FlEB1YqmIVEX1Sn6rRKy5MCMgpOR
	PQJnaRT9B8LKWcdUWt2L8uXuQAbOZM5uFKAfIOVVdHtxC2fSphcjwocUxV1u/kv3ni+ss3NIFpS
	82mY3GSI7755vZNFAHB9IwzbqVwysjw8MclrI50Maxg7puCY9owzQ7+rfdfp2R8kY+ULXXzIQ/E
	ptaY2CxmLAqRSWK8vqarSrxaIvnVEhLDp1nWpUwWZaXQraQrMgTY54Yllru7TtZwJnQ0hiVvTFy
	5Z5Ws9iFkxJH2I5De/FDf4RijMkxS/rpJ/I8gI5j2hQkGbQ==
X-Received: by 2002:a05:600c:1d27:b0:47e:e2b8:66e6 with SMTP id 5b1f17b1804b1-48526759afbmr25829185e9.14.1772791455030;
        Fri, 06 Mar 2026 02:04:15 -0800 (PST)
X-Received: by 2002:a05:600c:1d27:b0:47e:e2b8:66e6 with SMTP id 5b1f17b1804b1-48526759afbmr25828645e9.14.1772791454536;
        Fri, 06 Mar 2026 02:04:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485245dbe50sm13870935e9.17.2026.03.06.02.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 02:04:13 -0800 (PST)
Date: Fri, 6 Mar 2026 05:04:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chaohai Chen <wdhh6@aliyun.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v2] virtio_ring: Fix data races in
 virtqueue_enable_cb_delayed_split()
Message-ID: <20260306045629-mutt-send-email-mst@kernel.org>
References: <20260306022448.216131-1-wdhh6@aliyun.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260306022448.216131-1-wdhh6@aliyun.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -yKDACRdlDcH2mMZYuQY8Eq2lESuotqEOS5vLhzkQ-E_1772791455
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

here's how I would put it:

KCSAN reports .....
this is because ....


This is not a real issue, because ....
To disable the KCSAN warning, use READ_ONCE to read vq->split.vring.used->idx.




On Fri, Mar 06, 2026 at 10:24:48AM +0800, Chaohai Chen wrote:
> Add READ_ONCE when fetching vq->split.vring.used->idx
> without synchronization.

it's with synchronization, of course

> KCSAN detected

detected -> incorrectly reported

> data races when accessing the split virtqueue's
> used ring, which is shared memory concurrently accessed by both the CPU
> and the virtio device (hypervisor).
> 
> Example KCSAN report:
> 
> [  109.277250] ==================================================================
> [  109.283600] BUG: KCSAN: data-race in virtqueue_enable_cb_delayed_split+0x10f/0x170
> 
> [  109.295263] race at unknown origin, with read to 0xffff8b2a92ef2042 of 2 bytes by interrupt on cpu 1:
> [  109.306934]  virtqueue_enable_cb_delayed_split+0x10f/0x170
> [  109.312880]  virtqueue_enable_cb_delayed+0x3b/0x70
> [  109.318852]  start_xmit+0x315/0x860 [virtio_net]
> [  109.324532]  dev_hard_start_xmit+0x85/0x380
> [  109.329993]  sch_direct_xmit+0xd3/0x680
> [  109.335360]  __dev_xmit_skb+0x4ee/0xcc0
> [  109.340568]  __dev_queue_xmit+0x560/0xe00
> [  109.345701]  ip_finish_output2+0x49a/0x9b0
> [  109.350743]  __ip_finish_output+0x131/0x250
> [  109.355789]  ip_finish_output+0x28/0x180
> [  109.360712]  ip_output+0xa0/0x1c0
> [  109.365479]  __ip_queue_xmit+0x68d/0x9e0
> [  109.370156]  ip_queue_xmit+0x33/0x40
> [  109.374783]  __tcp_transmit_skb+0x1703/0x1970
> [  109.379467]  __tcp_send_ack.part.0+0x1bb/0x320
> ...
> [  109.499585]  do_idle+0x7a/0xe0
> [  109.502979]  cpu_startup_entry+0x25/0x30
> [  109.506481]  start_secondary+0x116/0x150
> [  109.509930]  common_startup_64+0x13e/0x141
> 
> [  109.516626] value changed: 0x0029 -> 0x002a
> ================================================================================
> 
> Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>



I'd like to see code size before/after compared, and included in
the log. Does this make the compiler's work much harder?

> ---
>  drivers/virtio/virtio_ring.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 335692d41617..ceb026161639 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1112,8 +1112,9 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
>  			&vring_used_event(&vq->split.vring),
>  			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
>  
> -	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
> -					- vq->last_used_idx) > bufs)) {
> +	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev,
> +				READ_ONCE(vq->split.vring.used->idx))
> +				- vq->last_used_idx) > bufs)) {

leave "-" on the previous line and indent the continuation more please.
This way one can easily see there's a continuation by looking
at both the 1st and the second lines.

>  		END_USE(vq);
>  		return false;
>  	}
> -- 
> 2.43.7

