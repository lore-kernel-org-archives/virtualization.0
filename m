Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70055410D1F
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769858; cv=none; b=Y88gGJyXOTdyVkwNYwkwrIrdHChWWJQ4aHaKNGplHCMNMoabMYlxHpOKWk7ZWTf8svUFwYI3Vre8FCpsJ2n8/FQ++/PqjVK1S72WUozmlXAf7POO7qmzwSIiikN8dU0uXuDMXi0BXJU+w7jX4YxucNt3Vp0lvufgi48VFy8c9vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769858; c=relaxed/simple;
	bh=0b3Gh85Tv7Tr08PJAhpkGIi508l+sNtqLAghxEDQf6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=FLixdYGbhitji+A/L9KKQ5YDy4DS/D+qT5f9941JE7hU1wj51mkdM5pBecKA6w4rRckupDfIVVlC9CrsPaXwBFO51UeqFWVuvqw/b6OQrOnqFd5iOhHH26S6yMNhnA7lZtWd7xHJ6u6Xu80lFPLTu9VLYsvFVhnNuk4epyQ4/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rkb7+eFV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rkb7+eFV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778769856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vX/jTGLllrKdYUXJiGA5tn0ddoDeDyU7N8CzDAqrr60=;
	b=Rkb7+eFVhY7L/M14gKHM8UORFZQnmVc4lxffclM98A49lswcCgOJBH/yoVH+1jl9FOWrMa
	T5WjI0NwlI1ZUX+vbK0DB/SXcUbWnHLUP1x0h0VTB429h8cRjb5a6cGOYlUO20PXeQz8fA
	tHcptowZDgVakTZVPPneuX1bgRCgBhk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-tnqZlAVEOUmLzqQ8rH8D4Q-1; Thu, 14 May 2026 10:44:15 -0400
X-MC-Unique: tnqZlAVEOUmLzqQ8rH8D4Q-1
X-Mimecast-MFC-AGG-ID: tnqZlAVEOUmLzqQ8rH8D4Q_1778769854
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fd33b4921so11119755e9.2
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 07:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778769854; x=1779374654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX/jTGLllrKdYUXJiGA5tn0ddoDeDyU7N8CzDAqrr60=;
        b=WfVEWYXl0tiBabVSkyJU44LkoiK4oikmOziiPk/scBjEe/qXGDTRgrofnELtXQUr87
         71aagkyRAM/aMQuEnKSs1IIUBRSlpE2J/am6jQNxsqb7Y5lO6V3OPHhwE9BmzuENzhkx
         q+PnIOZ6Jvy10OVZ3KWIXr5Qn5ZVfDjAj26m7WNVUaqHFl4NVxcuggTrOGCMKHtJQauw
         b7z3CVeVKnPWnXnfLPFf28anmwvIcn3kPu0Zgm4ssIdK0C9Xz6Vf/KSWQLtMexzcu7LJ
         Hy+2MUFGS+7oOxBs3GnwxvmccpHmZQ+rIt/iWgMPd1mkzUQ5cWMpsKtJ/k6SJqnCAXfu
         yBPg==
X-Forwarded-Encrypted: i=1; AFNElJ/gfwP48LdYvL/eSj1DenIH8AvR82urSXnJaE7MolW/JWdBXT6T1Q8eqORwIU4PAXljwpcpn5FLe0a27d4IAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWC7+KTBEJAFIVYdyuUZsUik+iqX8z4Y54C3/Ff7brkd8a44eU
	bvVwMryPQxSNtsMPxCz1Hos7Dt+flTM0ttz6ZGzZhYunlleJF2v3XilcTfTJ0/6O+DAH//8T3Cn
	hv9FaATXNIWO2h15NJv989WS2VFrGSPx21vBpGIDvemNoaFjQ6DNfoRrjAQ6AaoQbDat1
X-Gm-Gg: Acq92OHukNGJV8iQEXrVK/p+U5D6U2AaJ8+Aqfgc6r0fJuXu49CGjr4MXwL5GB+S3/V
	RjBuz3NUqli7eB9LowunCOuH1ZqFCwi7kZZqjhbqFqNyKr54uWHviFYDjR+l16YTPp63tNbLZqH
	OYq8M82Ns7IVGMA5IwFNkWhXuGZZIHVAFkzRHTkEOpICiyWa+1BlalgPbnT5VJVRmuXBIQ0G0OF
	NSVU59mgIWQw/ngaNNWpgmB3rY/9Jy+zOHtn/EvVxn0zLtmxIw2Bb3dsiZYTmdmH8UMnSIYOsa+
	q6A9GdLNiSyGoeAyMoPpVZediCQYqSNTBRBRgxOlmVZWBgCu1TwsxCsnI0xJ7y/xy6+lDad3UdB
	xcZM1Bgir8cxt39lwx5/oPyVQfSBWZG5ZVv7RjIqUMZcWBERSX3SJgi+PGG3BsVLSsShseBD2zl
	/9LnWRuYmg
X-Received: by 2002:a05:600c:8b0d:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48fce778dabmr120385205e9.0.1778769853904;
        Thu, 14 May 2026 07:44:13 -0700 (PDT)
X-Received: by 2002:a05:600c:8b0d:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48fce778dabmr120384805e9.0.1778769853516;
        Thu, 14 May 2026 07:44:13 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm7140850f8f.30.2026.05.14.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:44:12 -0700 (PDT)
Date: Thu, 14 May 2026 16:44:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 2/2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <agXe67XEf3O5YSko@sgarzare-redhat>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-3-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260513105417.56761-3-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v5A5HNG2QPvrI9hmWTTn3TU-fjkRH3qvV5Lm_6JqWjc_1778769854
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 13, 2026 at 12:54:17PM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
>buf_alloc when checking whether a new packet fits. This reduces the
>effective receive buffer below what the user configured via
>SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
>silently dropped and applications that rely on the full buffer size
>to deadlock.
>
>Also, the reduced space is not communicated to the remote peer, so
>its credit calculation accounts more credit than the receiver will
>actually accept, causing data loss (there is no retransmission).
>
>With this approach we currently have failures in
>tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
>test 22 always fails in this way:
>    18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>
>    22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>    Resource temporarily unavailable
>
>Fix this by using `buf_alloc * 2` as the total budget for payload plus
>skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
>is doubled to reserve space for sk_buff metadata. This preserves the
>full buf_alloc for payload under normal operation, while still bounding
>the skb queue growth.
>
>With this patch, all tests in tools/testing/vsock/vsock_test.c are
>now passing again.
>
>Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4a4ac69d1ad1..e22117bf5dcd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -434,7 +434,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> {
> 	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>
>-	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>+	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
>+	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
>+	 */
>+	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
> 		return false;

sashiko reported a potential overflow here:
https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com

I'll check the credit and overflow separately to ensure both are 
correct.

The portion relating to the user setting a buffer that is too small is a 
pre-existing issue and IMO an edge case that we can ignore.

Thanks,
Stefano

