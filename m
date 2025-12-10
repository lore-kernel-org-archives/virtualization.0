Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24FD283FE5
	for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765376570; cv=none; b=tzZuIopC8ZoSJTAu96Jd0BwcPgwxeBDScANbVWXuioz0c69DP+I61ooLPUHdTfEy83afQB7OiJj5Tq4AiQboxfGVwmCkhn1mwhBEasZvk3lGF7128HdmLuGWkuwhNOFvMHC1iSIPdfb4nwCiyrQoD25p0s2HrFIgpzMwu//GteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765376570; c=relaxed/simple;
	bh=mR7FX3+KEfttN7RMnMM/NLVhqGV7g6DZNgB51VU9Uno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NmfFseiAaXsGXwdcwivFeSl8Ke3xy8nVt28ipDH0WPsbEj1r2ABzbkdntxEcpsh508NYxBAYhNR7aCqdVD37o1Vlx/U59040SsEJMRSamcuqV45HZwA88tZ7Nh6h00VeoJsW31JJ502pbJpqS9ebhLgoLftsL7ICJ+V+O8vAa6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CS5BI736; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CS5BI736"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765376567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kRJ72Nh2zwp7g0tNeZhrixaAdGzbaonGGzR4qDRLA7Q=;
	b=CS5BI736xTIfxN/Z+6wDjoFPW98+AtZ/T/euzhf69KKka8qrq2CYM7/kpvXG7xba0z88zw
	ZZWuvbqY46SZu80gmaP1y2OIYFBusTKO8iZE9RfnAdkGhGTrUPRI8idnqz/z6TMb8uxzxp
	9TnfhgGDZ3JgBR891mmTcZwzVohl5QQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-dbv0lfEOOXWi98edHGLq8Q-1; Wed, 10 Dec 2025 09:22:46 -0500
X-MC-Unique: dbv0lfEOOXWi98edHGLq8Q-1
X-Mimecast-MFC-AGG-ID: dbv0lfEOOXWi98edHGLq8Q_1765376565
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42e2d6d13d1so3321640f8f.2
        for <virtualization@lists.linux.dev>; Wed, 10 Dec 2025 06:22:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765376565; x=1765981365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRJ72Nh2zwp7g0tNeZhrixaAdGzbaonGGzR4qDRLA7Q=;
        b=sWPVADdZtWZI2O4PeZAfXXSItHhXFU8S4QnVJZcFYWTdW0/E53Ulvy8Y7r3OBgV5vs
         /Ta8nkK52eLbBsUX6dLMgkQo25VcjJehZytzB9f78wItaPm32i2jlMN+NscUHAIkoF9q
         mdy4Zc+e/cQI4l45ZeuqrdTECHw7bE9rzAMvOEInWOBIhibnsYmjTtN8Y31HBM0XpjfT
         sP45P9kG8hS1qMZ5oLHsbWP0vTdoYBl20nNGnB68vgjGEUC+363cluY5jABqlqE1fH2F
         0v+txofUE6cbzEbwM2aIvztP4Bvnrn9EfSNGTVr8jXDgE91JCkoeb01Uv4tDL/basGf9
         d0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBWZZjU6rIgZN5OOh5mHZ2j8L17kl2CSnWQXJ+OHQUtTECcbKYSazZ1w1/HRbdbCkIOgwl9Ks62pWTYl+JsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzluXKCgK0JXqNMVwX8Mmszb4Uu8w6mkUwkTJcF/w2p+xEzx939
	gsdVAeL4grvS89W6VUU9k4kOUP27dmeOIbBPCGHCMgQ8oNxVsdc90BJDPyD/S1NYhXmN1W8MeYg
	72MisxOEGZTIecpCHsx+aBStWzBdN0tonD7wiEyM5QyhrT5qvz8QXLTjdF4riQ78FPcHH
X-Gm-Gg: AY/fxX5fd3qeyzQeh6J7ARANkho8SBsip0dj0/t2jgASTXfPicIKO22RnF9tRg38k4c
	XHZoKObSe8e2BcUN8Y0a+GeZCiiBBn9VpivPsjBSdn0dkwgABOHlozxRN5cqNZkY8rOKZ4EUY7M
	Ew6G0mrCKNOrPQk1b0e1iyy+Lxxrc4eFwF4CenEtTkAbDeKh/+ZCcWz/impayoz1gShANmiz4Ze
	tNYqQex1M48OEHYhKVL1RDqFeiNdIro46dNTxKq0l3ZdBHOUljD2+yjTC7Uzafjsm7DFTcb5EpP
	tpVd2ELYPDUuciv2tHpYLwK/j9IhcaOyJyXNZPQ1YS+U44AG8Dz3WT+bkVMgfN3L8r454kKYZ3H
	oIzi4uhQDY63ss4S9dr9O6nhWpHjUvS+6Ufa37dmwN2EN8Urr75rzApd4G//aFw==
X-Received: by 2002:a05:6000:4282:b0:42b:47da:c318 with SMTP id ffacd0b85a97d-42fa3b18a0fmr2763513f8f.52.1765376565410;
        Wed, 10 Dec 2025 06:22:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGe23O8ZHiqMm5vorjeh11c7DTLLOPAuIGwE8wgGZY4Ncci77xO6QqQLWpsM6fjDqtIM/m9Pw==
X-Received: by 2002:a05:6000:4282:b0:42b:47da:c318 with SMTP id ffacd0b85a97d-42fa3b18a0fmr2763455f8f.52.1765376564834;
        Wed, 10 Dec 2025 06:22:44 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm37857142f8f.11.2025.12.10.06.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 06:22:44 -0800 (PST)
Date: Wed, 10 Dec 2025 15:22:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stefanha@redhat.com, mst@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH net] vsock/virtio: cap TX credit to local buffer size
Message-ID: <7m3k4fhwnyvocrpwyzkm2xpgssik7lph3f5kqagqifllijvhbq@5opsnu2vcgic>
References: <20251210133259.16238-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251210133259.16238-1-mlbnkm1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RgBZT433uMKdjcAo_jtuxW9Il2LvBT_lRZCOV7ZRTGY_1765376565
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Dec 10, 2025 at 02:32:59PM +0100, Melbin K Mathew wrote:
>The virtio vsock transport currently derives its TX credit directly
>from peer_buf_alloc, which is set from the remote endpoint's
>SO_VM_SOCKETS_BUFFER_SIZE value.
>
>On the host side this means that the amount of data we are willing to
>queue for a connection is scaled by a guest-chosen buffer size,
>rather than the host's own vsock configuration. A malicious guest can
>advertise a large buffer and read slowly, causing the host to allocate
>a correspondingly large amount of sk_buff memory.
>
>Introduce a small helper, virtio_transport_peer_buf_alloc(), that
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
>cannot force the host to queue more data than allowed by the host's
>own vsock settings.
>
>On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
>32 guest vsock connections advertising 2 GiB each and reading slowly
>drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
>recovered after killing the QEMU process.
>
>With this patch applied, rerunning the same PoC yields:
>
>  Before:
>    MemFree:        ~61.6 GiB
>    MemAvailable:   ~62.3 GiB
>    Slab:           ~142 MiB
>    SUnreclaim:     ~117 MiB
>
>  After 32 high-credit connections:
>    MemFree:        ~61.5 GiB
>    MemAvailable:   ~62.3 GiB
>    Slab:           ~178 MiB
>    SUnreclaim:     ~152 MiB
>
>i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
>guest remains responsive.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Reported-by: Melbin K Mathew <mlbnkm1@gmail.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
> 1 file changed, 24 insertions(+), 3 deletions(-)

Thanks, in addition to Michael comments:

Please run `./scripts/checkpatch.pl`, there are several warnings/errors 
mainly related to spaces/tabs.

Also please use `./scripts/get_maintainer.pl` since several maintainers 
are missing in CC.

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d58..f5afedf01 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>
>+/*
>+ * Return the effective peer buffer size for TX credit computation.
>+ *
>+ * The peer advertises its receive buffer via peer_buf_alloc, but we
>+ * cap that to our local buf_alloc (derived from
>+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
>+ * so that a remote endpoint cannot force us to queue more data than
>+ * our own configuration allows.
>+ */
>+static u32 virtio_transport_peer_buf_alloc(struct virtio_vsock_sock *vvs)

This maybe can be called virtio_transport_tx_buf_alloc or something like 
that, to make it clear that should be used in the TX path. (not a strong 
opinion)

Thanks,
Stefano

>+{
>+	u32 peer  = vvs->peer_buf_alloc;
>+	u32 local = vvs->buf_alloc;
>+
>+	if (peer > local)
>+		return local;
>+	return peer;
>+}
>+
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> {
> 	u32 ret;
>@@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 credit)
> 		return 0;
>
> 	spin_lock_bh(&vvs->tx_lock);
>-	ret = vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	ret = virtio_transport_peer_buf_alloc(vvs) -
>+             (vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (ret > credit)
> 		ret = credit;
> 	vvs->tx_cnt += ret;
>@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>
> 	spin_lock_bh(&vvs->tx_lock);
>
>-	if (len > vvs->peer_buf_alloc) {
>+	if (len > virtio_transport_peer_buf_alloc(vvs)) {
> 		spin_unlock_bh(&vvs->tx_lock);
> 		return -EMSGSIZE;
> 	}
>@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
> 	struct virtio_vsock_sock *vvs = vsk->trans;
> 	s64 bytes;
>
>-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = (s64)virtio_transport_peer_buf_alloc(vvs) -
>+               (vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.34.1
>

