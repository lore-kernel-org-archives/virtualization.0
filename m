Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276CD2F49F6
	for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049892; cv=none; b=mY2jVTJBPk0ohZHPOE6fT5Nn29S37SLZ+TEXd5D8ZCmRkD7ONyeos1sdZL7gjzuQu3wlxdz+dZfdo/nNzOGoC/nNbCUnjGLSP1E9oougmN9fYZShnLs/E3XRuPqfSahSKr2XGqyEmRL+yWpwJtW72SQurkcW1ozoi6GneolmYpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049892; c=relaxed/simple;
	bh=8Jfg1L5A+9i31bArag6GfEHKUct4Y+XgPXMRDVY45/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZEAUpP3/lKPlnjkNMP56Vdlt51i5KdofcrhhbdTS0vL8i6urcxBuEgw7UGBQKsyqZcevr7zQIF8y5DCEdOeXNKlTxvIcYzOskxmurt1XPEPj8Ujt2Edk7ZktluMhW7D7/dQIgdNACNg3zpNIja56P1pdriSsvQU435Kja51QcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHqQyE+k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHqQyE+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766049890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s3Me7T/ecX/eWW08pmqEzTYycDuOzXsGOt1u24i6yLM=;
	b=VHqQyE+kMmXdNYzRPxxQW3KPOpxOk0RU7T7ZHQmJvUKNu0bRIB5TYXsufkdKjdz03T+R3S
	NdMwIfPUubUkcpYyhjxb1PIMHUxbBANbr9iLD3gyqy4lbzXBcujwyDHwhXncj2EqK7aPRa
	GHZt6Rih3Vkr7NQM3W974E9902b4ZjY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-SpcR_SNpMIin0-fM6XzYfA-1; Thu, 18 Dec 2025 04:24:46 -0500
X-MC-Unique: SpcR_SNpMIin0-fM6XzYfA-1
X-Mimecast-MFC-AGG-ID: SpcR_SNpMIin0-fM6XzYfA_1766049886
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7d282ac8aaso55127066b.2
        for <virtualization@lists.linux.dev>; Thu, 18 Dec 2025 01:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766049885; x=1766654685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3Me7T/ecX/eWW08pmqEzTYycDuOzXsGOt1u24i6yLM=;
        b=k+jWKlqy19qHI6Qh8rCue6gBh+yeYjGUM6sXTeVoOBTwBE7Faf5+3F9JwjprZpqd0m
         /SF9q22hHJ5MRcu2lRpFXhwWOFq8PPPl0DEDvVJGhoMq2h1Wbb2UuGQjEqLuj84zrVs7
         6Bgkj93JbX88kIyNqqKf6wwM/qlPRlO2+Mv6E33V4bsc40t3cfdUtDZwJ4ND+nvzGS/Y
         rGZxvUEr48ohLY3nP2iYMoB5svU0OCx5HeAwO7xEHCrFsRKyqdn6T2pfWrpgcBk/o5ih
         nSlpyOKLp33SPLG5VIA4cKMBl8ztk0PDFWQt8kcwmJgpB5EDRP2iePj1TrsiIqboVluf
         d9MA==
X-Forwarded-Encrypted: i=1; AJvYcCXB3sYK0coyhMthH0VGnWsA/xpl+Fp52I6dtp0MLzB7tH5v8IowfaRdhky3EPiIDZYRxyTDepv8cjr2VGlWFA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh2OrB6V9M8tp3BytLf6c6xKwTRoMRPVqmN26Bys7tFiyyLv81
	p9+lZATqN9w/0rrbukq4TO4P4apobp8ExX/OWmob/3Yx+ci5C0LVvr896yrYBtxiuk4GlouaNFQ
	OHLJeB+FvGiZ3nZr62lU3Bc1PBOBQRFEPJHFTRmCu8uS6Q4d3xBrczmJXOExqvbevNrwe
X-Gm-Gg: AY/fxX4jySbNrxVUhQZ0SbDBXTJVLWJwb/lr1ZNEvXWFr+lYRshKBSlb20PeMOeKr7r
	YqYwonTmUCseKmXitbS4/98rlTynJdZNhfEwC9xPuJ7nOlZHdFkChI/uu+XA3B0eGV8r2xGl9ND
	yhSEyCVKYqezBT4urRMOGsBPazpDjbxW5TNmgVhqTt8v99TesDapW97p8t/o43Xx9zc9MSYkXBM
	fAC76op3BZTv/IJDznP528Cyn3FwFbzVbZKFRCTMLLrUsPhf2/I2fD+AaRz/X8c2rxvxCcsHxih
	pp/rQFQE1Vi/WxviKhUbeCuE/pU5tmRsYssyQlWFwtm8tu+u0/xJIfW9rR996VSTfgiw7fXcN2z
	Obq3cNUd4fjgTjpY=
X-Received: by 2002:a17:906:c113:b0:b73:9be1:33ec with SMTP id a640c23a62f3a-b7d236193aamr1980318666b.9.1766049885551;
        Thu, 18 Dec 2025 01:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAD/qWKmkhpOLZrhnnlUGJ7m9SKv8TWSmzS9CTD64tDpvQQIIz9pomfLb46awD8PNlKE999Q==
X-Received: by 2002:a17:906:c113:b0:b73:9be1:33ec with SMTP id a640c23a62f3a-b7d236193aamr1980314666b.9.1766049885020;
        Thu, 18 Dec 2025 01:24:45 -0800 (PST)
Received: from sgarzare-redhat ([193.207.200.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8022f96096sm175047866b.10.2025.12.18.01.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 01:24:44 -0800 (PST)
Date: Thu, 18 Dec 2025 10:24:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v4 2/4] vsock/virtio: cap TX credit to local buffer
 size
Message-ID: <vekrofb2syrh35whi7tznmypvekvqmcbjjlv5bhyknrghhnxr7@b6v3yxubtu5y>
References: <20251217181206.3681159-1-mlbnkm1@gmail.com>
 <20251217181206.3681159-3-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251217181206.3681159-3-mlbnkm1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PwMImKMdkOYs6RJn_ldXZACMfprY-8Y8E8qeEJGplVk_1766049886
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 17, 2025 at 07:12:04PM +0100, Melbin K Mathew wrote:
>The virtio vsock transport derives its TX credit directly from
>peer_buf_alloc, which is set from the remote endpoint's
>SO_VM_SOCKETS_BUFFER_SIZE value.
>
>On the host side this means that the amount of data we are willing to
>queue for a connection is scaled by a guest-chosen buffer size, rather
>than the host's own vsock configuration. A malicious guest can advertise
>a large buffer and read slowly, causing the host to allocate a
>correspondingly large amount of sk_buff memory.
>
>Introduce a small helper, virtio_transport_tx_buf_alloc(), that
>returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
>peer_buf_alloc:
>
>  - virtio_transport_get_credit()
>  - virtio_transport_has_space()
>  - virtio_transport_seqpacket_enqueue()
>
>This ensures the effective TX window is bounded by both the peer's
>advertised buffer and our own buf_alloc (already clamped to
>buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote guest
>cannot force the host to queue more data than allowed by the host's own
>vsock settings.
>
>On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
>32 guest vsock connections advertising 2 GiB each and reading slowly
>drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
>recovered after killing the QEMU process.
>
>With this patch applied:
>
>  Before:
>    MemFree:        ~61.6 GiB
>    Slab:           ~142 MiB
>    SUnreclaim:     ~117 MiB
>
>  After 32 high-credit connections:
>    MemFree:        ~61.5 GiB
>    Slab:           ~178 MiB
>    SUnreclaim:     ~152 MiB
>
>Only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the guest
>remains responsive.
>
>Compatibility with non-virtio transports:
>
>  - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
>    socket based on the local vsk->buffer_* values; the remote side
>    cannot enlarge those queues beyond what the local endpoint
>    configured.
>
>  - Hyper-V's vsock transport uses fixed-size VMBus ring buffers and
>    an MTU bound; there is no peer-controlled credit field comparable
>    to peer_buf_alloc, and the remote endpoint cannot drive in-flight
>    kernel memory above those ring sizes.
>
>  - The loopback path reuses virtio_transport_common.c, so it
>    naturally follows the same semantics as the virtio transport.
>
>This change is limited to virtio_transport_common.c and thus affects
>virtio and loopback, bringing them in line with the "remote window
>intersected with local policy" behaviour that VMCI and Hyper-V already
>effectively have.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 18 +++++++++++++++---
> 1 file changed, 15 insertions(+), 3 deletions(-)

This LGTM, but I'd like to see the final version.

Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index d692b227912d..92575e9d02cd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -491,6 +491,18 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>
>+/*
>+ * Return the effective peer buffer size for TX credit.
>+ *
>+ * The peer advertises its receive buffer via peer_buf_alloc, but we cap
>+ * it to our local buf_alloc so a remote peer cannot force us to queue
>+ * more data than our own buffer configuration allows.
>+ */
>+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
>+{
>+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
>+}
>+
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
> 	u32 ret;
>@@ -508,7 +520,7 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> 	 * its advertised buffer while data is in flight).
> 	 */
> 	inflight = vvs->tx_cnt - vvs->peer_fwd_cnt;
>-	bytes = (s64)vvs->peer_buf_alloc - inflight;
>+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) - inflight;
> 	if (bytes < 0)
> 		bytes = 0;
>
>@@ -842,7 +854,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>
> 	spin_lock_bh(&vvs->tx_lock);
>
>-	if (len > vvs->peer_buf_alloc) {
>+	if (len > virtio_transport_tx_buf_alloc(vvs)) {
> 		spin_unlock_bh(&vvs->tx_lock);
> 		return -EMSGSIZE;
> 	}
>@@ -893,7 +905,7 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = (s64)virtio_transport_tx_buf_alloc(vvs) -
>+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.34.1
>

