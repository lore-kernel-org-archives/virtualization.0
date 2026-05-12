Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5C439D6DB
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778576091; cv=none; b=bzWBxE8bHBy1/XUatQdqTwJTI77XfxNX+KWAlhWhsZ+HO1j/FAg7V8LatmqQ8dBB+95ulvqkF8bY7WAB6G2s7OrIwjGCnwIouHV7Pgms7QKo4cctjXyWjGp4D+Rb/xt0CnXxadtpjchDEzVyy+GZtQHsHWG21G9U0lGfz/t4vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778576091; c=relaxed/simple;
	bh=0qkr1rENvV+pyeBAMi1jVWzvQVzUp0uGCFQaBamt9gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gQb/UGz/OL0+YfBZQCOH6m/m5NfiSbFN07ms3y2sZHSD38FgZZzTPTcMkHbhj+9dAtdTT6wz3BOnaN8LX8JeTYZ2cqd1M/73Zzy/sYVVhh/UEsp4pat8EsIei1j+DF3/WJZGi7lPXSbUayktcxTsE0LUJ7issozvVS7e+3MbMYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUtQVl7U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUtQVl7U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778576080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AIHT9Ne++vEWAmZTxjWDyan9tOz+k8p02hVxW6y8cts=;
	b=EUtQVl7UusRLPkp7WA3fl9LwLl9W/HxEQFZmJL7qnI6QN9aXxiA93/n6qFNPlA6eY0cWZR
	paIfrFK3mMP7q29DjZfrKWE+vBs6RzT2C5bbMXM7JbQyT5SJV3ymkybC+jpUYcEBxifMHg
	Ovpdj4KVX3e0FuGASs3qqngKkkq339M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-1IbyprqQP2ulsRlYqz8mHw-1; Tue, 12 May 2026 04:54:39 -0400
X-MC-Unique: 1IbyprqQP2ulsRlYqz8mHw-1
X-Mimecast-MFC-AGG-ID: 1IbyprqQP2ulsRlYqz8mHw_1778576079
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44bf1ac8893so4677034f8f.0
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 01:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576078; x=1779180878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIHT9Ne++vEWAmZTxjWDyan9tOz+k8p02hVxW6y8cts=;
        b=d1cMKIpZ6IkCrIjvStjTFAm5rKtiEagseQiaau9n2owkCLjSc5U1WLxwltjTvNmDKF
         9ON0vLCr+OBdzIUTXKZjVSWN/nfNZBpTOm/YlIA96IqLt4ff6RlvmuchLEG0nfyM3ZOM
         l4c8XUWw4FBHI4y4iIXQ8swRq6MGDlrCALcZ0oFkTZtPGNvN9ImE7z2k9zWh6GkkDKzn
         db1vtLjhPygesSSRMSOypfadkWuduapO6Q89CLNnza2X/XFf2XI3Q2fZ+HeJsZoc5sDd
         zusQIT2x8jQHOGwq9xSSZcBt+fJz3rNqOTqyExR8iQZZx76jhXilBm+HL3Y2gYz20Trl
         7BnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9MFL4bYWJVqwEbxqh4dqtpIIzkMv6g/qBTVoqXao8MWWzmCqHFijhqnzt5yO2cQi7y674mzjXLk2wzx9FObA==@lists.linux.dev
X-Gm-Message-State: AOJu0YybkUjd/5an/1mXstaOT9BUzbTwLLaGheaBXyh8GRqxeEEkzAb9
	mRRkg2MvedOVbZoHllm4TOSqTSm1DaJLmBxMpR8QbYr3rQCClG/P6TFfWDyXqk4s2f1SqwCbrHw
	r6UpJ0/oMAitqLERpgWfpCpaPLyDPj72bUsrNsvRjQ2MFF5bGosuqLDjCmsOJ092/rcRd
X-Gm-Gg: Acq92OGcQX8xoDYhNaqtEqurzwbG4+ViWRLKxgGtQ6MvbZ0USYsa8fs6aRqWpL/jIWF
	3cUe7iSeg+zP43HUotgKMTZh+ngq1NwK7G3BCorMXDDDeJm2VuItErCSKytpYXn+Q8nS6vuh8pf
	QWrK5n9ofZ/XlRh06XhQI4/ICfiJjUsiomCsR5qiuo5A+MJ2C3SI0D5YmSWVs5/DLS4ESuj7bKc
	kx17r36g95CKOTRl7Y7Ls3ewEzCrTv6eLvlMx9ocgb25YQ95wlVkW/ECqDgmOT6XzdDOwkHV6/h
	ngrK7fiQzSLFfUbKzimZwzcXKa8MsdvGjg3AiRivRk7Oqq/erxRB+7KYmthG5vN7iwRlc/zPWbC
	luFVEp3bShJqFszeGaSoUXi/c9ltxal/EWLC3bN/s
X-Received: by 2002:a05:600c:26c8:b0:48a:9562:7a30 with SMTP id 5b1f17b1804b1-48e51f4934cmr277143125e9.24.1778576078368;
        Tue, 12 May 2026 01:54:38 -0700 (PDT)
X-Received: by 2002:a05:600c:26c8:b0:48a:9562:7a30 with SMTP id 5b1f17b1804b1-48e51f4934cmr277142775e9.24.1778576077739;
        Tue, 12 May 2026 01:54:37 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f410d9fsm17755735e9.6.2026.05.12.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:54:37 -0700 (PDT)
Date: Tue, 12 May 2026 04:54:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH net v2] vsock/virtio: fix skb overhead accounting to
 preserve full buf_alloc
Message-ID: <20260512044008-mutt-send-email-mst@kernel.org>
References: <20260512080737.36787-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260512080737.36787-1-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DiiK_VlsP-9wuOJpu4HslgamTwe6kKYKlpK3jTmTfwU_1778576079
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2026 at 10:07:37AM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> After commit 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb
> queue"), virtio_transport_inc_rx_pkt() subtracts per-skb overhead from
> buf_alloc when checking whether a new packet fits. This reduces the
> effective receive buffer below what the user configured via
> SO_VM_SOCKETS_BUFFER_SIZE, causing legitimate data packets to be
> silently dropped and applications that rely on the full buffer size
> to deadlock.
> 
> Also, the reduced space is not communicated to the remote peer, so
> its credit calculation accounts more credit than the receiver will
> actually accept, causing data loss (there is no retransmission).
> 
> With this approach we currently have failures in
> tools/testing/vsock/vsock_test.c. Test 18 sometimes fails, while
> test 22 always fails in this way:
>     18 - SOCK_STREAM MSG_ZEROCOPY...hash mismatch
> 
>     22 - SOCK_STREAM virtio credit update + SO_RCVLOWAT...send failed:
>     Resource temporarily unavailable
> 
> Fix this by using `buf_alloc * 2` as the total budget for payload plus
> skb overhead in virtio_transport_inc_rx_pkt(), similar to how SO_RCVBUF
> is doubled to reserve space for sk_buff metadata. This preserves the
> full buf_alloc for payload under normal operation, while still bounding
> the skb queue growth.
> 
> When the total budget (buf_alloc * 2) is exceeded (e.g. under small-packet
> flooding where overhead dominates), the connection is reset and local
> socket error set to ENOBUFS, so both peers are explicitly notified of
> the failure rather than silently losing data.
> 
> With this patch, all tests in tools/testing/vsock/vsock_test.c are
> now passing again.
> 
> A solution to handle small-packet overhead efficiently also for
> SEQPACKET (we already do that for STREAM) is planned as follow-up work.
> This patch is needed in any case to prevent silent data loss, because
> even if we reduce the overhead, we can't eliminate it entirely.
> 
> Fixes: 059b7dbd20a6 ("vsock/virtio: fix potential unbounded skb queue")
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks for the patch!  I'd like to split this: 
1. buf alloc boost
2. reset when out of credits

this way we can revert 2 easier later.


> ---
> v2:
> - Close the connection when we can no longer queue new packets instead
>   of losing data.
> - No longer announce the reduced buf_alloc to avoid violating the
>   spec. [MST]
> 
> v1: https://lore.kernel.org/netdev/20260508092330.69690-1-sgarzare@redhat.com/
> ---
>  net/vmw_vsock/virtio_transport_common.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 9b8014516f4f..f23bf8a11319 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -449,7 +449,10 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
>  {
>  	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>  
> -	if (skb_overhead + vvs->buf_used + len > vvs->buf_alloc)
> +	/* Use buf_alloc * 2 as total budget (payload + overhead), similar to
> +	 * how SO_RCVBUF is doubled to reserve space for sk_buff metadata.
> +	 */
> +	if (skb_overhead + vvs->buf_used + len > (u64)vvs->buf_alloc * 2)
>  		return false;
>  
>  	vvs->rx_bytes += len;
> @@ -1365,7 +1368,7 @@ virtio_transport_recv_connecting(struct sock *sk,
>  	return err;
>  }
>  
> -static void
> +static bool
>  virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  			      struct sk_buff *skb)
>  {
> @@ -1380,10 +1383,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  	spin_lock_bh(&vvs->rx_lock);
>  
>  	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
> -	if (!can_enqueue) {
> -		free_pkt = true;
> +	if (!can_enqueue)
>  		goto out;
> -	}
>  
>  	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
>  		vvs->msg_count++;
> @@ -1423,6 +1424,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>  	spin_unlock_bh(&vvs->rx_lock);
>  	if (free_pkt)
>  		kfree_skb(skb);
> +
> +	return can_enqueue;
>  }
>  
>  static int
> @@ -1435,7 +1438,16 @@ virtio_transport_recv_connected(struct sock *sk,
>  
>  	switch (le16_to_cpu(hdr->op)) {
>  	case VIRTIO_VSOCK_OP_RW:
> -		virtio_transport_recv_enqueue(vsk, skb);
> +		if (!virtio_transport_recv_enqueue(vsk, skb)) {
> +			/* There is no more space to queue the packet, so let's
> +			 * close the connection; otherwise, we'll lose data.
> +			 */
> +			(void)virtio_transport_reset(vsk, skb);
> +			sk->sk_state = TCP_CLOSE;
> +			sk->sk_err = ENOBUFS;
> +			sk_error_report(sk);
> +			break;
> +		}
>  		vsock_data_ready(sk);
>  		return err;
>  	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
> -- 
> 2.54.0

