Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493885;
	b=FeKpuqmR/49e9HPu0QrdG05h1rYvgZl0jvmxlGdjuz0ucrS2c2EPLcWjyMKY8Pmg/xiN
	 fapSH/5n93lC3m70jauCZQQ5waXjUCHi9o1PHO12DOdTvIqAxyCI16ahIqC5tDPRcKUG5
	 rAj5qfZiuFj8BVs2xzJfgtvriSxd140Nm/8VNf/Ma2of+QOI/lqwWWV7nwNwUJqztj+GS
	 YukSnBTUiz7DzFftOt9ZwLxMIHqXuVMI+gJ404XPvQ9vyeVAe0RWIXHJnxr/duS1BKoVY
	 1exJ/ChTnMraRnWC4yk1cImitx79fWxZQqnvB1fPk4Q5/PTRAA5lM7VZlM0i8pb3/xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493885;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Vth6PCbpSm/10fRmDbxR+C2gNDjvG6s3yrcjNyPLdBg=;
	b=cLpCj+CPY+33miGm+nFqVeumu+kvMbvOSKBJSKAjTCx7kMT+9dPvIhMFCTd+NYrEK2qY
	 1auxsms9dn4OSDYtHAJ8MDCEZeD2B/TPV7pvuol0rlzWea9PZllvKXKDzIMFKkNjyUQ/G
	 v17MG2i9f+EEC3veA6UscCVRu7P8h21/N6NGuA61yX2Akb5nz55+5c5nJXrjQgk7n30m6
	 glhhxM5Qlu6u4GVM2AWidD3pIHxm3Q8OHnuvbh/6wMKK5ir0NK6BFvJ+NaGYOPOnbjHFk
	 AmvNqqpYO2M8ty3HuQiNxX+maP1UJ7k+uk4WpbGqNXvaPpoOnDrtUekRulbFKqXJVow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GfDpsjoh;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6E60A2624
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 14:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89C6E60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GfDpsjoh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794493883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vth6PCbpSm/10fRmDbxR+C2gNDjvG6s3yrcjNyPLdBg=;
	b=GfDpsjohMPy/fHW3ZQWvyevD6BHEc3PljBzKoRIocD82p0n5VLdBVf/3XFJ7DRWYP/JEPZ
	t10URoFBbwvfPhDcInIqLcQa24Lp8vUBlpfENyvNBBZ/CZ76OBE3JPOORuXhZ5q2lCf8ln
	2jlyRjhkpJ3WA0iKLFaQ3O2M+J++7Ls=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-gv43ZtcsOUK0d9xebUzGoA-1; Thu, 12 Nov 2026 09:31:19 -0500
X-MC-Unique: gv43ZtcsOUK0d9xebUzGoA-1
X-Mimecast-MFC-AGG-ID: gv43ZtcsOUK0d9xebUzGoA_1794493878
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-84fe2593525so5608606a34.3
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:31:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493878; x=1795098678;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vth6PCbpSm/10fRmDbxR+C2gNDjvG6s3yrcjNyPLdBg=;
        b=mqHly1Ex4casXlHoPHcdjAP/ZtXKdns+CnmkHb86RjZaPF+AsUT1M4o18P3GpQvjg1
         4nzQpL5unWATu89RICith2gWvoSoYFJxsmPDpYlXtLTdf9QFgabhMyGYo1aIMQkRc7zc
         0q6fW+/DGPM+NO4GVRPU9fjztwJuFV9/kZh91GQtUMajKYrNK38eEU0/Qxtpr8RJwtaf
         6GF0Moe5fAnYLz5r/VRLw7FeyvxsapjJ83DJt9sujHAsfGjYn9D/wYxeGO7IiIo6mBJn
         YEeWWOM+5o91HJ2KqQrUFghD0UHuAUywTy+/y+UjIvyE3IcdiyRsaIRtMj+FriRvBb0y
         BFXQ==
X-Forwarded-Encrypted: i=1; AL+hErGjxRqg0y/dbVNtwZkRmrVHL8soF/WtOvqOUWFKVDjdM/DQPJMQznvs5e9Y8oapiMpnvgRFwrGqXqj7sfuRgA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/xL0fhSvMn8LjFgHJAATI8rBHCcDCBzEfTW48425IwyPL8WSGL
	QfR+To09Nc6cHe5+/kfyU8tNaI5T3qynLf3luqxVNqlzOoAm8LUDV0RiRYynKeIOt8GBtc2SmNf
	jJpt8UVqo8koDJjulZ5f6d9GL8kOMSUe+1xGxfZLkufYvqHHLQYNZswlNIblK5t2unhu1
X-Gm-Gg: AYBFou2Vo7/LViEvn+XA6Q1QgPTXKvu5Ez7gbp9caUs2Tngq+sJuevJRvtUaaelrOe7
	DP2BbGF5H2EF02eES14MDP1Q/fkJbHhS5jSumU0xh7KtcYpaId3uqBhw/61iTjdpzOL005D9LeE
	5l/prGXO3H3cCYHZzNhz78WWErhC9iyJaP8iiT/+z5MbP0HHeep+WFh1C+QZhzVz9k9A8rjfdOq
	MXzssfSYad5+kZPro6WfMzNguhqzL3JOa4FKSixdbTbIxv1BWrZCRZHcMCFz5FAcs9Xk5Io+CzF
	/QiDzzs5vHohjc0FGgF8ts0ldq0xJJAOzCpVrOvKnWVArYwhzTRNiziiO0IYrsPfCf50C9TfTsc
	QovaeUSJ7S1kraLtCwXRZLtXKmobJrLnVhxIP5lxzEWJGMLkZqdIl
X-Received: by 2002:a05:6808:30a4:b0:4e5:c2b4:33a4 with SMTP id 5614622812f47-56b980309bdmr5402622b6e.50.1794493878289;
        Thu, 12 Nov 2026 06:31:18 -0800 (PST)
X-Received: by 2002:a05:6808:30a4:b0:4e5:c2b4:33a4 with SMTP id 5614622812f47-56b980309bdmr5402575b6e.50.1794493877673;
        Thu, 12 Nov 2026 06:31:17 -0800 (PST)
Received: from sgarzare-redhat ([69.196.88.181])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e24b33665sm42678b6e.13.2026.11.12.06.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:31:16 -0800 (PST)
Date: Thu, 12 Nov 2026 15:31:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: stefanha@redhat.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, bobbyeshleman@meta.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] vsock/virtio: bound the send credit by bytes
 not yet consumed by the transport
Message-ID: <avXMHPSHc2jtVESG@sgarzare-redhat>
References: <20261106050244.602625-1-green@linuxhacker.ru>
 <20261106050244.602625-3-green@linuxhacker.ru>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261106050244.602625-3-green@linuxhacker.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3uxruyi-eJaY_y2eX_qro6lEFQmgD7vI5jzPjVvg3gI_1794493878
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Nov 06, 2026 at 12:02:43AM -0500, Oleg Drokin wrote:
>The send credit is
>
>    min(peer_buf_alloc, buf_alloc) - (tx_cnt - peer_fwd_cnt)
>
>where peer_fwd_cnt is taken unchecked from every header the peer sends.
>A peer that never consumes what it is sent but keeps reporting
>fwd_cnt == tx_cnt gets unlimited credit: every send() is accepted and
>the skbs pile up in the transport's queue (on a host, vhost's
>send_pkt_queue, for a guest that posts no rx buffers). The skbs are
>GFP_KERNEL allocations charged to no memory cgroup. The peer learns
>tx_cnt easily when the host side relays a stream it also controls.
>
>Commit 8ee784fdf006 ("vsock/virtio: cap TX credit to local buffer size")
>bounded peer_buf_alloc, but not peer_fwd_cnt.
>
>bytes_unsent (maintained for SIOCOUTQ) counts what was handed to the
>transport and not yet consumed by the device. It is local knowledge, so
>bounding it by the same window limits a lying peer to one window of
>queued data per socket.
>
>For an honest peer, bytes_unsent can exceed tx_cnt - peer_fwd_cnt only
>by data the peer already has but the transport has not yet released:
>
> - on a host, the delivered part of an skb that vhost splits across rx
>   buffers smaller than the skb: the peer acknowledges the pieces, but
>   bytes_unsent drops only once the whole skb is delivered, so at most
>   one skb (64 KiB);
> - in a guest, tx buffers the host has consumed but
>   virtio_transport_tx_work() has not reaped yet: vhost passes the
>   packet to the host socket before it marks the buffer used, so the
>   host's credit update can arrive first.
>
>Either way the window shrinks only until the transport catches up;
>nothing stalls and nothing changes on the wire. The writer is woken by
>sock_wfree() once enough of the queued skbs are freed, as it already is
>when credit comes back.
>
>With a user-space vhost-vsock "guest" that posts no rx buffers and
>acknowledges everything, one host socket queued 256 MiB in under 2 s
>(SIOCOUTQ 268304384, where the test stops); with this patch it stays at
>one window (SIOCOUTQ 262144).
>
>Found by an LLM-assisted security review of vhost-vsock, done while
>porting a project from Xen to KVM, and reproduced as above.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Signed-off-by: Oleg Drokin <green@linuxhacker.ru>
>---
> net/vmw_vsock/virtio_transport_common.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1e762a480df4..74a8fdf825d5 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1031,14 +1031,17 @@ EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_has_data);
>
> static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
> {
>+	s64 tx_buf_size = virtio_transport_tx_buf_size(vvs);
> 	s64 bytes;
>
> 	/* Use s64 arithmetic so if the peer shrinks peer_buf_alloc while
> 	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
> 	 * does not underflow.
> 	 */
>-	bytes = (s64)virtio_transport_tx_buf_size(vvs) -
>-		(vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = tx_buf_size - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+
>+	/* peer_fwd_cnt is peer-controlled, bytes_unsent is not. */

Would be nice to explain a bit better what we are preventing here.
Not a long description, just few words.

>+	bytes = min_t(s64, bytes, tx_buf_size - (s64)vvs->bytes_unsent);

TBH I found this code a bit unreadable, what about this:

         in_flight = max_t(s64, vvs->tx_cnt - vvs->peer_fwd_cnt,
                           vvs->bytes_unsent);
	bytes = (s64)virtio_transport_tx_buf_size(vvs) - in_flight;


Thanks,
Stefano


> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.56.0
>

