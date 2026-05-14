Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B60426EA3
	for <virtualization@lists.linux.dev>; Thu, 14 May 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770648; cv=none; b=k1e5cEoXEw8Zf2oe5/JZ3ueQ7vmpdLXJt1FZ4kAoFb4pLJIwr2YfX7M3i0wSbZ0yq1XigA2aS5hJrZiZ+T0MMoMYUqU50IuKJcpVzgc3u9ZD8PHnA6vvZWqC/GYtX869wtr9k0n9Z3AfvjTFXtm9o47U6MozXU/1rqDeA13Xxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770648; c=relaxed/simple;
	bh=nLXZoA7D/cDYw43SD85/ZPvjSgooaZlgPDLded852xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=svln5m1yxF8vDZChRpNln6+Pz2XbDywRx3KiE1tHflSWTDgCQKia+lhB1gmLgpUVjdMGOFxCIiL3ymFb9M/INvqKsWYA+Otx2gS05PH6CVDwGOGzeU6NzjQR1yanaYDsDpEAn/hAOTLBAw91GUWaE4r0BbyzmcTKJALd73nHoKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ue+LD1pr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ue+LD1pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778770646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bmItK0Q0jR1/wvpM4sGWwy0Jc78483wKM/DFC7tKXoQ=;
	b=Ue+LD1prfakbb0GM7cNpYLuQ+oKauHnFavm27Miiw8l3qGnpWOUrTSi0bGf9t/M+PhqecJ
	yXJ30ljPZvXWpjswEiz5pUw0cz3S3fGwZylzJiNPG2gjDelFrbN5lt52V7uBO06dbzDB45
	Tl7iYDc6m9ZSYuBCvCJUQCfpuJFyWM8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-NQthfZrVM7aqShxnczv3EA-1; Thu, 14 May 2026 10:57:25 -0400
X-MC-Unique: NQthfZrVM7aqShxnczv3EA-1
X-Mimecast-MFC-AGG-ID: NQthfZrVM7aqShxnczv3EA_1778770644
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so7288363f8f.2
        for <virtualization@lists.linux.dev>; Thu, 14 May 2026 07:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778770644; x=1779375444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmItK0Q0jR1/wvpM4sGWwy0Jc78483wKM/DFC7tKXoQ=;
        b=E+RcHKQgu5bpq8A5H5/c7ePb03+jbhKcAGfOk017qvo7TAjpxKz3uHyd3pij8AgldP
         g6U5ejclHBmjpzKHIzr72AGYR+Tqrnr9LbnOgaRRMv+yhRIT/38/ZoLw+sYcZ4Pu9UaV
         GywTIB8WFA1dxc4Gl2qWOOYhjaHxGgVbkj2QW9rro5gnd7Gl9X5ymQAJchMHdYtxW4/I
         ZBe1L7OHOG8qrTY3zLf6DF+0qwD8+1D9P8nOg2AlqPW84Crz7yRnfxkvbD+rsQx0no8e
         O9RzJlke7FT3TM/rMTxFOJnrqWqEploBCMi3Jv8+3zP5+Ly73WXZp/9GLqIGOjgBLSL6
         E3qA==
X-Forwarded-Encrypted: i=1; AFNElJ+pF4kt8XN61uSWOOVZcEVYcNjDarnRSrc87A2S74Toknsjmr95881UFhU+2MKBOdTuMDVIEuF9+k6+/3TfhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGqp7Yw/0c/Dtke2z7M4eNyjtWWu5DqH2JIiXA0aEKZbXo6CWa
	sUolSuEtBFPX/bQnbw7fpvamqUdOtfg53yvgwdN8oA44ET5aI5rYpeJk2omLh02W7gvC2Z3rSX6
	Kkbt9J9ejEPIGhI/89osBJ7uYRxeqdIn9M/hEXTc84BcKvznDg4MzgwM/4h+rEKprIFt1
X-Gm-Gg: Acq92OHpCqWcWYFymss/WXm0Ny+/Twa3MlKctKq5aH9Gt/I0qDBJm6qmKA5KbgKWaea
	Q/twggy/U9N0aQeAFo7u5A3Kb1pYbGdVe6mlDTWa+pBpOwbcxjs/bRbEjaoOrvwiHKUOd4MPTPn
	DJXB0v+Ht/w5iztSdHq4gcaqXSB9vVtj4w6hsOlPFtR0WyxJJOLBvRT6NkokrZ2MM9ULZvCKKfs
	S7r7ZnWotZxUxqIRVFBb9z/HfvtvbzsNg1MB9AXM40sOyvDh+2XLSCxUC7DZ8Z4xmSfiiKvssdm
	fJcvEatCLHoGm2Sq3ktzTv9yvEf4ahVr2+0utPmm13J0MBsrkdeDk8eLs81sCVfI24yKkrU8PI2
	YOF2598P+cffUPPrS5EP6Nqz4EYq+96zZYlijh+uCZdiHiuX8jZCCetjtLtxYn6yKEhJnDuxXUg
	==
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-48fc9a3abb0mr125552835e9.19.1778770643883;
        Thu, 14 May 2026 07:57:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0d:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-48fc9a3abb0mr125552375e9.19.1778770643409;
        Thu, 14 May 2026 07:57:23 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4657f3fsm3313895e9.6.2026.05.14.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:57:22 -0700 (PDT)
Date: Thu, 14 May 2026 16:57:16 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux.dev, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net v3 1/2] vsock/virtio: reset connection on receiving
 queue overflow
Message-ID: <agXh36gUe1K6__Bk@sgarzare-redhat>
References: <20260513105417.56761-1-sgarzare@redhat.com>
 <20260513105417.56761-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260513105417.56761-2-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qsJzr3i4WwefJzvw3s-h6C4j8yEEv5ZSz5yUpb2wAcs_1778770644
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, May 13, 2026 at 12:54:16PM +0200, Stefano Garzarella wrote:
>From: Stefano Garzarella <sgarzare@redhat.com>
>
>When there is no more space to queue an incoming packet, the packet is
>silently dropped. This causes data loss without any notification to
>either peer, since there is no retransmission.
>
>Under normal circumstances, this should never happen. However, it could
>happen if the other peer doesn't respect the credit, or if the skb
>overhead, which we recently began to take into account with commit
>059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue"),
>is too high.
>
>Fix this by resetting the connection and setting the local socket error
>to ENOBUFS when virtio_transport_recv_enqueue() can no longer queue a
>packet, so both peers are explicitly notified of the failure rather than
>silently losing data.
>
>Fixes: ae6fcfbf5f03 ("vsock/virtio: discard packets if credit is not respected")
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 19 ++++++++++++++-----
> 1 file changed, 14 insertions(+), 5 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 989cc252d3d3..4a4ac69d1ad1 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1350,7 +1350,7 @@ virtio_transport_recv_connecting(struct sock *sk,
> 	return err;
> }
>
>-static void
>+static bool
> virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 			      struct sk_buff *skb)
> {
>@@ -1365,10 +1365,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 	spin_lock_bh(&vvs->rx_lock);
>
> 	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
>-	if (!can_enqueue) {
>-		free_pkt = true;
>+	if (!can_enqueue)
> 		goto out;
>-	}
>
> 	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
> 		vvs->msg_count++;
>@@ -1408,6 +1406,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
> 	spin_unlock_bh(&vvs->rx_lock);
> 	if (free_pkt)
> 		kfree_skb(skb);
>+
>+	return can_enqueue;
> }
>
> static int
>@@ -1420,7 +1420,16 @@ virtio_transport_recv_connected(struct sock *sk,
>
> 	switch (le16_to_cpu(hdr->op)) {
> 	case VIRTIO_VSOCK_OP_RW:
>-		virtio_transport_recv_enqueue(vsk, skb);
>+		if (!virtio_transport_recv_enqueue(vsk, skb)) {
>+			/* There is no more space to queue the packet, so let's
>+			 * close the connection; otherwise, we'll lose data.
>+			 */
>+			(void)virtio_transport_reset(vsk, skb);
>+			sk->sk_state = TCP_CLOSE;
>+			sk->sk_err = ENOBUFS;
>+			sk_error_report(sk);

sashiko reported some issues related to setting TCP_CLOSE state and not 
removing the socket from the connect table:
https://sashiko.dev/#/patchset/20260513105417.56761-1-sgarzare%40redhat.com

I'll change this by calling virtio_transport_do_close() and 
vsock_remove_sock() in the next version.

Stefano

>+			break;
>+		}
> 		vsock_data_ready(sk);
> 		return err;
> 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
>-- 
>2.54.0
>

