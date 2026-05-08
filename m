Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7743CF67F
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234528; cv=none; b=t1h5iCdtb4eciPWjsxedvoV+mOjGLo71tdG1R/awI2pMR0V5b60ahqPLl3519Ei/24jErOXO5KwR01aW2R7DwzID4y+MOHoERDKn446QhD7RVKl3sbJs1GCBWcdmyKk7vHKgH37GZju2IV7D75pP839OWrxb+4Poe3L6xkPjhb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234528; c=relaxed/simple;
	bh=fmD3Ke/CvF5HQCYW6erHAKf4D6r4v6UWQtiVU6LwrNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dvKdBcDGPJmtUiQgXBGr7K2GMOIGdsDx1PBjwwC04czLOIkwCRvCDJ6bukp8/cCel1f7AlBV2dF4Bcr2gFn+X6C6zShjrZnZ3RGFXbDNNCHKwKAtU1Y0AYmhAonFXFN6j9emTOgHQ0k/R9CHc8KqyCYLL1kqwYWjggxuduGdYw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZR1lDTc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZR1lDTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778234521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=crvssa469klhyca6q9oUB28wHxBWNy751Rl0wTACG7Q=;
	b=BZR1lDTczsgDTYI3mXdms7CuKQ0hecZjoJAkJZN18KdSrHyAW+v0bdyh8Qp+YWQx9xhxho
	OSCYd3yQFh3UHYqD/VkAkLRr8VvBSvy/bfgO6fORkFNyF/c6PaCe8MjqkW0wvGba/GPOgU
	bPfK6vaXbl1XCbkrz8H3Av3VlUsMdNo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-M-UCS2NrPhuJIdzWQzpv1Q-1; Fri, 08 May 2026 06:02:00 -0400
X-MC-Unique: M-UCS2NrPhuJIdzWQzpv1Q-1
X-Mimecast-MFC-AGG-ID: M-UCS2NrPhuJIdzWQzpv1Q_1778234519
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488c0120047so11114595e9.0
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 03:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234519; x=1778839319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crvssa469klhyca6q9oUB28wHxBWNy751Rl0wTACG7Q=;
        b=dBe9bYJ6ldWu49ZAcSam0d23rMFcRpOBa7RStNH7kA5Yy+IUCt5CcFfvBq6vJfWZ2Q
         CTDhVw2cszuLEjKpv8o8DuZpX0YJ+4uhxSVkbZHU0lxPjxAF+GQ3bUiw4xSvbojYk3wT
         OH6UJrd3VSYgIzMaGG43A2vQQ+xp77DeB3AfIqVhWlHBf3KLUYL7PellejmXF1Hs7lHb
         3obJ6j2kVNk3lhY/ohYk/K6qc/jFPs4FbkCSRycJN07AbKPwVxcnuCgNoFeD4/ec12/7
         w8LPgoBhk3PNe1HfNRZYAj6FI3Yd2SBMziZe2Zx2VfpPO8tn6dI+julvwVuNN7wgiCzg
         HPbg==
X-Forwarded-Encrypted: i=1; AFNElJ8UewTchgQ0QLAXiU+7DtV+UjJjeFiLMuqDP2wFgNCV25/KEaKISfciglCb24AYZ+fpxXR5nz7lwGy8EWdfVA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxv3hnrDEb2WZtVXeLEpwOuPWluv0bop7hFB/5jfhwH6BGjYHiy
	DJFkSlGed35182v/1B44xc+PXmU7hrN9AyGXpyZkoKIQlqQ3inoxml5WBES5vdNuzxNVqp+Wr4S
	t3CY946y/a7oZ5Z8qsPfaE0d8z+e31WnHFIihbeKOURSZXJ/s9eu8qB8o7UDjwChFA1Ee
X-Gm-Gg: AeBDievHexFgXIozc/FR0XdAPOw+fJEzDc683h82b1rjaJQY6Cf8KR7JLC9EzvIBhsj
	vk2QNC+sHG5enJMW576BU+GpNpmozF8rglmuJPGfxbw7fWHUpumIcD5Pcx7H84uPB0XJzSnNtdQ
	c9kMMFOPmhrx2OYpqlwbJR/LblMWiPxvx+7QMZ5TiYPq1NtK1SbaJ0P/+YceoGdc3OvUow+3cCU
	HrUncznybWWqI0J2MFaYI/6YAq9B/GnMmbYfPaOtQwKiHZazwwwYKiV1sZwd2aukipDsEKWdgxB
	T7T8+CR4xwsHpua6nYxK2CoEDdPcShQdc3vj/sOt9DBrrIbp+9rxy41Y4F6gNONAqq5fZll+yim
	1nSUXVnS6N657jxznAl9bWg4m9B8xXXOAzO9uzCtzJzhh/s2uhLxAy25y7j1WCNSoZR95vHHz4A
	==
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48e51e0a6a2mr175787925e9.4.1778234518375;
        Fri, 08 May 2026 03:01:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48e51e0a6a2mr175787265e9.4.1778234517709;
        Fri, 08 May 2026 03:01:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-2.retail.telecomitalia.it. [87.11.6.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6428d72asm16331785e9.0.2026.05.08.03.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 03:01:56 -0700 (PDT)
Date: Fri, 8 May 2026 12:01:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Jason Wang <jasowang@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH net] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <af2y2Fyp7H-om-ur@sgarzare-redhat>
References: <20260508092330.69690-1-sgarzare@redhat.com>
 <20260508055125-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260508055125-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4hMQpzBzjpJGzuDZf2F78OCeUxclo8gY7sRQHM-Yhlg_1778234519
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, May 08, 2026 at 05:53:07AM -0400, Michael S. Tsirkin wrote:
>On Fri, May 08, 2026 at 11:23:30AM +0200, Stefano Garzarella wrote:
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
>> queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
>> buf_alloc when checking whether a new packet fits. This reduces the
>> effective receive buffer below what the user configured via
>> SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
>> silently dropped and applications that rely on the full buffer size
>> to deadlock.
>>
>> Also, the reduced space is not communicated to the remote peer, so
>> its credit calculation accounts more credit than the receiver will
>> actually accept, causing data loss (there is no retransmission).
>>
>> This also causes failures in tools/testing/vsock/vsock_test.c.
>> Test 18 sometimes fails, while test 22 always fails in this way:
>>     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
>>
>>     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>>     Resource temporarily unavailable
>>
>> Fix this by introducing virtio_transport_rx_buf_size() to calculate the
>> size of the RX buffer based on the overhead. Using it in the acceptance
>> check, the advertised buf_alloc, and the credit update decision.
>> Use buf_alloc * 2 as total budget (payload + overhead), similar to how
>> SO_RCVBUF is doubled to reserve space for sk_buff metadata.
>> The function returns buf_alloc as long as overhead fits within the
>> reservation, then gradually reduces toward 0 as overhead exceeds
>> buf_alloc (e.g. under small-packet flooding), informing the peer to
>> slow down.
>>
>> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
>unfortunately, this is a bit of a spec violation and there is no guarantee
>it helps.

Loosing data like we are doing in 059b7dbd20a6 is even worse IMHO.

>
>a spec violation because the spec says:
>Only payload bytes are counted and header bytes are not
>included
>
>and the implication is that a side can not reduce its own buf_alloc.
>
>no guarantee because the other side is not required to process your
>packets, so it might not see your buf alloc reduction.
>
>as designed in the current spec, you can only increase your buf alloc,
>not decrease it.

We never enforced this, currently an user can reduce it by 
SO_VM_SOCKETS_BUFFER_SIZE and we haven't blocked it since virtio-vsock 
was introduced, should we update the spec?

>
>what can be done:
>- more efficient storage for small packets (poc i posted)
>- reduce buf alloc ahead of the time

That's basically what I'm doing here: I'm using twice the size of 
`buf_alloc` (just like `SO_RCVBUF` does for other socket types) and 
telling the other peer just `buf_alloc`.

But then, somehow, we have to let the other person know that we're 
running out of space. With this patch that only happens when the other 
peer isn't behaving properly, sending so many small packets that the 
overhead exceeds `buf_alloc`.

Stefano

>
>> ---
>>  net/vmw_vsock/virtio_transport_common.c | 31 +++++++++++++++++++++----
>>  1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>> index 9b8014516f4f..94a4beb8fd61 100644
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -444,12 +444,32 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>>  	return ret;
>>  }
>>
>> +/* vvs->rx_lock held by the caller */
>> +static u32 virtio_transport_rx_buf_size(struct virtio_vsock_sock *vvs)
>> +{
>> +	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> +	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
>> +	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
>> +	 */
>> +	u64 total_budget = (u64)vvs->buf_alloc * 2;
>> +
>> +	/* Overhead within buf_alloc: full buf_alloc available for payload */
>> +	if (skb_overhead < vvs->buf_alloc)
>> +		return vvs->buf_alloc;
>> +
>> +	/* Overhead exceeded buf_alloc: gradually reduce to bound skb queue */
>> +	if (skb_overhead < total_budget)
>> +		return total_budget - skb_overhead;
>> +
>> +	return 0;
>> +}
>> +
>>  static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>>  					u32 len)
>>  {
>> -	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>> +	u32 rx_buf_size = virtio_transport_rx_buf_size(vvs);
>>
>> -	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
>> +	if (!rx_buf_size || vvs->buf_used + len > rx_buf_size)
>>  		return false;
>>
>>  	vvs->rx_bytes += len;
>> @@ -472,7 +492,7 @@ void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *
>>  	spin_lock_bh(&vvs->rx_lock);
>>  	vvs->last_fwd_cnt = vvs->fwd_cnt;
>>  	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
>> -	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
>> +	hdr->buf_alloc = cpu_to_le32(virtio_transport_rx_buf_size(vvs));
>>  	spin_unlock_bh(&vvs->rx_lock);
>>  }
>>  EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
>> @@ -594,6 +614,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>  	bool low_rx_bytes;
>>  	int err = -EFAULT;
>>  	size_t total = 0;
>> +	u32 rx_buf_size;
>>  	u32 free_space;
>>
>>  	spin_lock_bh(&vvs->rx_lock);
>> @@ -639,7 +660,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
>>  	}
>>
>>  	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
>> -	free_space = vvs->buf_alloc - fwd_cnt_delta;
>> +	rx_buf_size = virtio_transport_rx_buf_size(vvs);
>> +	free_space = rx_buf_size > fwd_cnt_delta ?
>> +		     rx_buf_size - fwd_cnt_delta : 0;
>>  	low_rx_bytes = (vvs->rx_bytes <
>>  			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>>
>> --
>> 2.54.0
>

