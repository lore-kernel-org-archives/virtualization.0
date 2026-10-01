Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E150AC16
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862160; cv=none; b=XZVWwv6jEj2xxNU+zQ44+w/mseyybKT0ZafIEIbne2p7sqExmS3Z5YJDqcRKO9YTVqfFVZJJ0bqeZ22Cw/yH0m5x8cF+Wi/Tx6SIhgWBFScRZZVSgURkcLAhVVdHYSJqrzg8PPrD9IC4ZaJp+V/wA6u9KZHwUIqFyhvnoG8F2hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862160; c=relaxed/simple;
	bh=9/+tCd94iL8kXeGB2Qg2OUOvm2WiWKuY0gLzpz03J7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=i+LVfCIQJswrlCO5N/WE9MsnrHOjVduu1ej6ecqfw15CV/m0BCrqF+MpUZTKVjFMDtQyxd7D7iuturUcZcpswpiuTa/2n/rn/2t17fEE7Tx3IzZ8jaPAz1LSUldIYUb1AosOfls5EF52WTfkN8F9nZlJieac1HeK+E4gIj/jzyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GKw7rqwJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKw7rqwJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790862148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu6OcuQYFoTCH5UaDqxha9ec8EBwkEwB9eRLNdJBaGY=;
	b=GKw7rqwJYFQZ6/KlBkANRzkWBykGIxB8aDNoOiPf9HkXTeMq/lw69fFZleXAUF2B7hmKKk
	Owr5t9bub1T9fAID07lNx98+2ipc19K8Qulj/EWK532jikSXBFuz3FE9muIfcUd6EqNT18
	yMyx/fvZKMCNgc6M+ihnMMiAvUCRY3M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38--Jnq7eaaNb-JIEfpwKlmbQ-1; Thu, 01 Oct 2026 09:42:26 -0400
X-MC-Unique: -Jnq7eaaNb-JIEfpwKlmbQ-1
X-Mimecast-MFC-AGG-ID: -Jnq7eaaNb-JIEfpwKlmbQ_1790862145
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0023f2b60so27496145e9.2
        for <virtualization@lists.linux.dev>; Thu, 01 Oct 2026 06:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790862145; x=1791466945;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cu6OcuQYFoTCH5UaDqxha9ec8EBwkEwB9eRLNdJBaGY=;
        b=jJ63fDK+T7+iwGKTMKtlkcRJYKUtzDG7lGNoXEHXE7SDKptwdPqpkfquc6GF2Yk3Ap
         OBmH0w0tOP0nIT+fehBiICTPZFuR9ncaNt4mUFt0OI+lcYghHBS1bMwnwtEbYdtqsbby
         LL8q3EWX9SSsiVPm+nkwKIpserNjcoha90IgDST3GKLsU4LqXs/X236nuMhdlbKptZZT
         viZuThEngurb6DHXIpVkRLFdkDZyPLPHKKkbe1/iDtYlGH4Ow0qfhkdq7DTk/6MObRq1
         pe4+EBvPrxfN2oFlZ0F2ofh2MNRz8iF731WTTSddDPfvEC70zBo84oJAJYUI/Lf1n6Mb
         ctag==
X-Forwarded-Encrypted: i=1; AKwUvBzaSWG02rcrVKK3XtY58gksk8gxCLr8hQf5gXTknMGYv4gLHQJagrtz5B60JUU/y621cv5YViWTsfw9GF1lzg==@lists.linux.dev
X-Gm-Message-State: AFuF++lEtsNr4FSPmL1IRC+QrP7S4Sin650Xk5uQhuQjkj+/QkremMy5
	yjRl+T6BjSQ5ku/kRAWTaNyB2wJ4JIlQpKmTbU/RbQPJkOq9owESOMKThYxTpvYsKHpDPpCGron
	eJLkGOIyCjx1Ge2nqUUfArQn4nvEwZsb6+QNwqAzEC6G0ACXWhZiBN+NhpZxH9SqinFss
X-Gm-Gg: AYBFou2Lt/vEXReSMBqpkqvCV94KRULDnhwSCQ3YR8jZvJ2EnYUAODxrMQogPRuWSvL
	c/stGtJzsNK5x0T70WByvYYlaAxyY/gBHs7nYXK5XSXYc3FBkMlVvtejJhpZCSzbLCl+zvxCiom
	2iEd14fygbp5kIJ816NRVlZAYQ+YBkzqYyyA9qlUIWSFJifTZ9Efpq0gEMqu1Xe+aXZq6mpJvvA
	aFK9NlJOncrjnpTP0eqaibkqqNDGf9ElzmnDP+IOhlWcYzmxb4ptRj03wiX5iXpCVQlBM8bNxaC
	ealp7j0LZZnoloI4l3cIuvhnHYwR/5FEa3JSAocdQ8CbcN2m9BJ9mlpTicj1DUAB/jGhMb8BFqk
	uE8Dj2eR0NMq+ycfiS2mh2KsoHHE5LtZYbdY=
X-Received: by 2002:a05:600d:8652:10b0:4a0:25fe:a4f with SMTP id 5b1f17b1804b1-4a025fe0b7cmr6753435e9.26.1790862145179;
        Thu, 01 Oct 2026 06:42:25 -0700 (PDT)
X-Received: by 2002:a05:600d:8652:10b0:4a0:25fe:a4f with SMTP id 5b1f17b1804b1-4a025fe0b7cmr6753205e9.26.1790862144781;
        Thu, 01 Oct 2026 06:42:24 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f984d89sm81821335e9.7.2026.10.01.06.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 06:42:24 -0700 (PDT)
Date: Thu, 1 Oct 2026 15:42:21 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: account only unread bytes in read_skb()
Message-ID: <ar5gU4DSSTUuGi8P@leonardi-redhat>
References: <20261001121541.2983379-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20261001121541.2983379-1-4ncienth@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qwlAqJPWtr8Z1UnwXujt355gFLBk9viRtvKyuxb89zc_1790862145
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi,

what about using `vsock/virtio` instead of `vsock`? We are changing
just the virtio parts of vsock.

On Thu, Oct 01, 2026 at 09:15:41PM +0900, Daehyeon Ko wrote:
>After a partial stream receive, rx_bytes tracks the unread suffix while
>buf_used and peer credit still cover the whole packet.
>virtio_transport_read_skb() dequeues that packet but passes pkt_len for
>both counters, underflowing rx_bytes.
>
>On a connected CID_LOCAL stream with an SK_SKB verdict, a 40-byte read
>from a 100-byte packet made SIOCINQ report -40, an empty recv return
>ELOOP, and poll report the empty socket readable.  After verdict detach,
>receiving 40 bytes wrapped the counter to zero and hid those queued bytes
>until one more byte arrived.  The fixed run kept the counter balanced
>and exposed all queued data immediately.
>
>Subtract only skb->len minus the VSOCK offset from rx_bytes.  Retain the
>full packet length for buf_used and peer credit.
>
>Fixes: 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index f225f53ed4bab..1e762a480df49 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1927,6 +1927,7 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> 	struct sock *sk = sk_vsock(vsk);
> 	struct virtio_vsock_hdr *hdr;
> 	struct sk_buff *skb;
>+	u32 bytes_read;
> 	u32 pkt_len;
> 	int off = 0;
> 	int err;
>@@ -1946,7 +1947,8 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
> 		vvs->msg_count--;
>
> 	pkt_len = le32_to_cpu(hdr->len);
>-	virtio_transport_dec_rx_pkt(vvs, pkt_len, pkt_len);

maybe it's worth adding a comment? not a strong opinion.

>+	bytes_read = skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset;
>+	virtio_transport_dec_rx_pkt(vvs, bytes_read, pkt_len);
> 	spin_unlock_bh(&vvs->rx_lock);
>
> 	virtio_transport_send_credit_update(vsk);
>
>base-commit: e23a64eb244356ee47c0620f0722d51bd88db522
>-- 
>2.55.0
>

code LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks,
Luigi

