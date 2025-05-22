Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A874A1A
	for <virtualization@lists.linux.dev>; Thu, 22 May 2025 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747880135; cv=none; b=tg7/+mtq5wnzOtReEpSaYI+m05Qqm6I7nIG7YeeWQOS0TJ7KWwnOk+XDS/73JTeMiy16sGfNDzMvQtQikZqmyfOIQKFdQYRFiJleeiM5Ek/weieq7ALkUfSif2omcJVQy9bCXQYApPu0u59hN/AnLIwfO8TtJxmOWRHRSl6YZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747880135; c=relaxed/simple;
	bh=oSahH06uVmwCsq+yHzJyH1D2BdQZvaZfL9Gd9mn8ALw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnJ/2ILygSEBpm38XmIibO6OYmsww8xh4uI50ijDfATVfHACndVZBcdOWDFN87JXPEkQe4rAXtdtQ9dW93u+I7/VIUd1ClSZvKA1vllZQ9P+nDcF2P3wcerH3Vkxey8FFzYyozZsh16ZxeIsdeooR5Q4a1rAuo6ghRdpBO3r4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK/GGIH+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK/GGIH+"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b26f5eb16a5so4866357a12.0
        for <virtualization@lists.linux.dev>; Wed, 21 May 2025 19:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747880132; x=1748484932; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smLItdwum/8I9JeK/ur2YCvKvfD6GUpMkvynImLJvVA=;
        b=nK/GGIH+/ujfrMJ/EoH6feud3HZRtgue6gM0f5V3yv7Ktuz4fWZQEyHB/DDRdhoozs
         tVRm9C8jmViEBDD/6uwWLYO5z09L0vL9sYCMYXoVL717iG5/rEo84kJQQUUGrvo9IcGa
         IHC4wALwHSFzWRXqysbP6Nd6ZIRgp4roChjQJpkNoZHAEShtE8CDIljOSHVkrir0NK2y
         bTi1IySMh50BqKyGAG4fSGEC+sXponlN6V9oGQIA4tFrZQhCTZHmNaLj3l4ytZd8y+4w
         q127bp9MnFyRjPCajWSCAUKlg13Q3VFUv2kfdv3sXbtLScA0TOtZ/NMol/ygiaOQQhvQ
         veyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747880132; x=1748484932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smLItdwum/8I9JeK/ur2YCvKvfD6GUpMkvynImLJvVA=;
        b=Xq51Evfe8i/9qIQY9+RjNQuR7aQo+F1A8oMWXDOZeDqzDqgDv9K6oXDnJ7EVO0CDHP
         YUCAmfIiMPCz/XIKhZEg15ogUwfgaO4JdtHujFxQD5RGQO71/sJ+Ms+Rp1VAoqq9FhR7
         CLkFXMJIWMgkD+4jXcrQilQ8tnC2OUy+CBuz/8RNBo0qNy2MBGrM8M7WI8HIAxxg3G3h
         gIIu14UBhCRqK656JvvUXTWTqwM2J0pdhhSOoj2w+Z1fACOU5zYyYbs59aJKQEx87G4z
         qZkU7yba1MlurFov7qiXn7v1tMFM/iLlWgu7npy4JDH/9+ZCranLmzSgSud1+qJDKlYr
         bTRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfR884Yc0x318Ydk4LVap3d5pAV0SbA16LEkI/dAvwLd6nkefg/kCD5qlYH+ZdA4rBU6PC19SWTPzybkC9Cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjH7AulN0aA732GMNTiuwmdtfl9iRQ0UVdYj/k3kwVRyerRd9L
	Ck8m87Vuo9pid+Mdmjt4ZgDnajgiIPTR7Z8YcWlCzmgXyd3MqOqx37KQ
X-Gm-Gg: ASbGncvxYxNTd0vxV8niMdVxsqsOIvygoTOj1UqDldjA4VeaRm++b9KKo0BEfzNEWBX
	ANthK1aqgcWR17uoTGQrUwd4jhihR18e65DF/+nYE1zS8zXyVOcngxCNzbtP7v/S6TDooL9FeQa
	s0h/9cPuL8eJy5cy39E8w/IPA3vAfMjMxkFKAyOr0fL8HyDUHVvdn435sxZObvjLMecE49JkfKh
	Njvnj+j1F4sZZEvh8/10lzkV4F06ybjrQY2o5ZvKQo+8IQ9NpCJ1tXM/sKHqe44ohCw387zSvP6
	3eSN5UU2Wh/UAGXSQ5K/mgA/5qNvMqFyGJAu1SGLHqMg8OZHKAujMzCHOJgbP9AX3N8d67nriQ=
	=
X-Google-Smtp-Source: AGHT+IG7zVAceghA234kavxhxXs1Ej2SW/BsPc7sDi/3WNlt3zuydIdWGwrVWK9FvQkB11RhnirMSg==
X-Received: by 2002:a17:902:d484:b0:231:e413:986c with SMTP id d9443c01a7336-231e4139adamr290367545ad.11.1747880131556;
        Wed, 21 May 2025 19:15:31 -0700 (PDT)
Received: from devant.antgroup-inc.local ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adbfecsm99377425ad.76.2025.05.21.19.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 19:15:31 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
To: sgarzare@redhat.com
Cc: davem@davemloft.net,
	fupan.lfp@antgroup.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mst@redhat.com,
	niuxuewei.nxw@antgroup.com,
	niuxuewei97@gmail.com,
	pabeni@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH 2/3] vsock/virtio: Add SIOCINQ support for all virtio based transports
Date: Thu, 22 May 2025 10:15:18 +0800
Message-Id: <20250522021519.3362114-1-niuxuewei.nxw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3>
References: <bbn4lvdwh42m2zvi3rdyws66y5ulew32rchtz3kxirqlllkr63@7toa4tcepax3>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Wed, May 21, 2025 at 10:06:13AM +0800, Xuewei Niu wrote:
> >> On Mon, May 19, 2025 at 03:06:48PM +0800, Xuewei Niu wrote:
> >> >The virtio_vsock_sock has a new field called bytes_unread as the return
> >> >value of the SIOCINQ ioctl.
> >> >
> >> >Though the rx_bytes exists, we introduce a bytes_unread field to the
> >> >virtio_vsock_sock struct. The reason is that it will not be updated
> >> >until the skbuff is fully consumed, which causes inconsistency.
> >> >
> >> >The byte_unread is increased by the length of the skbuff when skbuff is
> >> >enqueued, and it is decreased when dequeued.
> >> >
> >> >Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
> >> >---
> >> > drivers/vhost/vsock.c                   |  1 +
> >> > include/linux/virtio_vsock.h            |  2 ++
> >> > net/vmw_vsock/virtio_transport.c        |  1 +
> >> > net/vmw_vsock/virtio_transport_common.c | 17 +++++++++++++++++
> >> > net/vmw_vsock/vsock_loopback.c          |  1 +
> >> > 5 files changed, 22 insertions(+)
> >> >
> >> >diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> >> >index 802153e23073..0f20af6e5036 100644
> >> >--- a/drivers/vhost/vsock.c
> >> >+++ b/drivers/vhost/vsock.c
> >> >@@ -452,6 +452,7 @@ static struct virtio_transport vhost_transport = {
> >> > 		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
> >> >
> >> > 		.unsent_bytes             = virtio_transport_unsent_bytes,
> >> >+		.unread_bytes             = virtio_transport_unread_bytes,
> >> >
> >> > 		.read_skb = virtio_transport_read_skb,
> >> > 	},
> >> >diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> >> >index 0387d64e2c66..0a7bd240113a 100644
> >> >--- a/include/linux/virtio_vsock.h
> >> >+++ b/include/linux/virtio_vsock.h
> >> >@@ -142,6 +142,7 @@ struct virtio_vsock_sock {
> >> > 	u32 buf_alloc;
> >> > 	struct sk_buff_head rx_queue;
> >> > 	u32 msg_count;
> >> >+	size_t bytes_unread;
> >>
> >> Can we just use `rx_bytes` field we already have?
> >>
> >> Thanks,
> >> Stefano
> >
> >I perfer not. The `rx_bytes` won't be updated until the skbuff is fully
> >consumed, causing inconsistency issues. If it is acceptable to you, I'll
> >reuse the field instead.
> 
> I think here we found a little pre-existing issue that should be related
> also to what Arseniy (CCed) is trying to fix (low_rx_bytes).
> 
> We basically have 2 counters:
> - rx_bytes, which we use internally to see if there are bytes to read
>    and for sock_rcvlowat
> - fwd_cnt, which we use instead for the credit mechanism and informing
>    the other peer whether we have space or not
> 
> These are updated with virtio_transport_dec_rx_pkt() and 
> virtio_transport_inc_rx_pkt()
> 
> As far as I can see, from the beginning, we call 
> virtio_transport_dec_rx_pkt() only when we consume the entire packet.
> This makes sense for `fwd_cnt`, because we still have occupied space in 
> memory and we don't want to update the credit until we free all the 
> space, but I think it makes no sense for `rx_bytes`, which is only used 
> internally and should reflect the current situation of bytes to read.
> 
> So in my opinion we should fix it this way (untested):
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 11eae88c60fc..ee70cb114328 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -449,10 +449,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>   }
> 
>   static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
> -					u32 len)
> +					u32 bytes_read, u32 bytes_dequeued)
>   {
> -	vvs->rx_bytes -= len;
> -	vvs->fwd_cnt += len;
> +	vvs->rx_bytes -= bytes_read;
> +	vvs->fwd_cnt += bytes_dequeued;
>   }
> 
>   void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb)
> @@ -581,11 +581,11 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>   				   size_t len)
>   {
>   	struct virtio_vsock_sock *vvs = vsk->trans;
> -	size_t bytes, total = 0;
>   	struct sk_buff *skb;
>   	u32 fwd_cnt_delta;
>   	bool low_rx_bytes;
>   	int err = -EFAULT;
> +	size_t total = 0;
>   	u32 free_space;
> 
>   	spin_lock_bh(&vvs->rx_lock);
> @@ -597,6 +597,8 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>   	}
> 
>   	while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
> +		size_t bytes, dequeued = 0;
> +
>   		skb = skb_peek(&vvs->rx_queue);
> 
>   		bytes = min_t(size_t, len - total,
> @@ -620,12 +622,12 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>   		VIRTIO_VSOCK_SKB_CB(skb)->offset += bytes;
> 
>   		if (skb->len == VIRTIO_VSOCK_SKB_CB(skb)->offset) {
> -			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
> -
> -			virtio_transport_dec_rx_pkt(vvs, pkt_len);
> +			dequeued = le32_to_cpu(virtio_vsock_hdr(skb)->len);
>   			__skb_unlink(skb, &vvs->rx_queue);
>   			consume_skb(skb);
>   		}
> +
> +		virtio_transport_dec_rx_pkt(vvs, bytes, dequeued);
>   	}
> 
>   	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
> @@ -782,7 +784,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
>   				msg->msg_flags |= MSG_EOR;
>   		}
> 
> -		virtio_transport_dec_rx_pkt(vvs, pkt_len);
> +		virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
>   		vvs->bytes_unread -= pkt_len;
>   		kfree_skb(skb);
>   	}
> @@ -1752,6 +1754,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
>   	struct sock *sk = sk_vsock(vsk);
>   	struct virtio_vsock_hdr *hdr;
>   	struct sk_buff *skb;
> +	u32 pkt_len;
>   	int off = 0;
>   	int err;
> 
> @@ -1769,7 +1772,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
>   	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
>   		vvs->msg_count--;
> 
> -	virtio_transport_dec_rx_pkt(vvs, le32_to_cpu(hdr->len));
> +	pkt_len = le32_to_cpu(hdr->len);
> +	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);
>   	spin_unlock_bh(&vvs->rx_lock);
> 
>   	virtio_transport_send_credit_update(vsk);
> 
> @Arseniy WDYT?
> I will test it and send a proper patch.
> 
> @Xuewei with that fixed, I think you can use `rx_bytes`, right?

I've seen your patch, and looks good to me. This will greatly simplify the
SIOCINQ ioctl implementation. I'll rework after your patch gets merged.

Thanks,
Xuewei

> Also because you missed for example `virtio_transport_read_skb()` used 
> by ebpf (see commit 3543152f2d33 ("vsock: Update rx_bytes on 
> read_skb()")).
> 
> Thanks,
> Stefano
