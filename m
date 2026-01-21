Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EBB428498
	for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997442; cv=none; b=AQI5q9GLmatIX2eUXXMPIUVKstIHd84jlXn3VvL3zTdLKC89x6d8CDG0ug7RZqTwXg9Hcw/fRNmsj89YEAIHilEKl7yh8r1fyz6LIA1fijweTiIq77dwCNpyvN3HEUzFsxI0GyM8Qwuspg4Xwx8TSn3GtFeTf6nnusQKI5jOfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997442; c=relaxed/simple;
	bh=GZ3GsuG+E3Qr6/RqofEs4s8euNMw69P/GSTuShgkEDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TLOFdGP4VQiFMPfF+qbMCFegyoj2oDL53ZJhFi1hQzIokZBTA7cgR9mH/svS+LN3aoyNKbDwerGXYxBGHK6nc5A7Qsx3entNzH1beMYhil7I3ZqH5pvGS7pUz26kVKZG4+me1gHfZWYM1FxXkvJ8FZ9DIN0L3SXlWc5Rgh6A5Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EK5BH9Af; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EK5BH9Af"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768997435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vvEBWBLr1X14L0avrzDsdXo8a3nnKtSJtim3XAg072w=;
	b=EK5BH9AfesT81r3KNnmItq0/9SMjhuZ1nUMQAW/xnQt1qeAOnvI4/0CILced4je1T91qgx
	ejYaGCbIJ2KhYMM08gkhDWS9ixGO7Pc1u+ZfiiiDYZib4sixyWPcLv4/A/ZvZwB28E7M7c
	OGG7T7kku6PpgA60PMVJ2OHGdMtcdrE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-beQJ_V5xMbipkl_XQdIEWg-1; Wed, 21 Jan 2026 07:10:32 -0500
X-MC-Unique: beQJ_V5xMbipkl_XQdIEWg-1
X-Mimecast-MFC-AGG-ID: beQJ_V5xMbipkl_XQdIEWg_1768997431
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4803e8b6007so11876295e9.0
        for <virtualization@lists.linux.dev>; Wed, 21 Jan 2026 04:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768997431; x=1769602231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvEBWBLr1X14L0avrzDsdXo8a3nnKtSJtim3XAg072w=;
        b=II+ENbRb4KORTaLkQngaQMIB5FGUlE6FNe10T4LDoXZgfTt3x9NqcyGsTfAIo65+Uw
         iQ14gy4Hmnsw4vUY6xVA27nEUjwXrT5S0hUs7gZZEQJ0XkoTLDF5SQr1nmkGefKMIdUp
         JX37ihnzB3bvO/fhO8KXJvj35ouT39WwaBky1CNvxWXC56QJD0xsUEyECOgGnDHfitl9
         NOLFcZSMglCJjB04/cWOcYrJGqxQOT+ILoATqznsW+6BEo9PvG2/xs+CbvnMHCOgoH1z
         2PvLTj8WTbvS9PIF7Ksrio0Hd16e3wI8Y+rKQn3pekzVIYVfPYC9h634pmITywyrCpe1
         IDfg==
X-Forwarded-Encrypted: i=1; AJvYcCVwjoKpN14N1DfdSkK5Hea45tqKzwY4GDwK9PSu/fYJXL3J/7HXkHp5Vw3RQdBDN+7Wv4+FEL20Z0LaPsMyDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1u/nHcrMNnaHN3mlWWCOrFfAVuTvQDsd8TErwVvn80E8p0jLV
	ofhr5KedBwp/LSbCY37c1mDOhUyFSbNQwQavvNcK0O2MvwOqxZxNpUqsGe+aGESyIWZ5TAUb4Ju
	2UdnMIWJHj7uSFPDiOJQ62zpHEtMh+OIn1I2/+UlqpyLzfwbzDzebf7PrplOdW2dzkeyG
X-Gm-Gg: AZuq6aIeFajGyYfUN8PGT35BVnQrORSzIa9M8+GmGSLEeULKiwPW8N+ciEVkuTNzaIi
	e1T3G4fktEVrVgg26q01PMkb/qFrpZLQZv2HVe4Ng6bzD631P+BtzzyPmn8JO6HpXzbR6WCUMEn
	GTFCqSn29qBv+R4CDgX8oO60+j47KZADdifWJn4WnbZg7k3UMxgu1xRIsjKWggVcHI2ApjgiB0N
	Han5XhXHemayqEiUkgcW/i6UCJbGuf2N5+r0xvMwIDe/fnBegzl3lOWZsVULyQ1tw5kyQT1l3DM
	98iMV+TUE2hQsTfi7b35TcUA3sYuFuMp/a3ssNbxPxn6N+oVgyrMy3IXCDz6GiWnj1eAMrV7FVY
	dOiBJWPe+gsoqXY0=
X-Received: by 2002:a05:600c:81c5:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-4803e7a529emr72395235e9.15.1768997431362;
        Wed, 21 Jan 2026 04:10:31 -0800 (PST)
X-Received: by 2002:a05:600c:81c5:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-4803e7a529emr72394825e9.15.1768997430942;
        Wed, 21 Jan 2026 04:10:30 -0800 (PST)
Received: from leonardi-redhat ([176.206.16.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48043617b81sm38961085e9.0.2026.01.21.04.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 04:10:30 -0800 (PST)
Date: Wed, 21 Jan 2026 13:10:28 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>, "David S. Miller" <davem@davemloft.net>, 
	virtualization@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Asias He <asias@redhat.com>, Melbin K Mathew <mlbnkm1@gmail.com>
Subject: Re: [PATCH net v6 3/4] vsock/virtio: cap TX credit to local buffer
 size
Message-ID: <aXDCKQ_yX9fT2W9o@leonardi-redhat>
References: <20260121093628.9941-1-sgarzare@redhat.com>
 <20260121093628.9941-4-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260121093628.9941-4-sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sB4GNJ-xJ9WYHsYU4f7re6rETzRHYZ690zBZrzoomiY_1768997431
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Jan 21, 2026 at 10:36:27AM +0100, Stefano Garzarella wrote:
>From: Melbin K Mathew <mlbnkm1@gmail.com>
>
>The virtio transports derives its TX credit directly from peer_buf_alloc,
>which is set from the remote endpoint's SO_VM_SOCKETS_BUFFER_SIZE value.
>
>On the host side this means that the amount of data we are willing to
>queue for a connection is scaled by a guest-chosen buffer size, rather
>than the host's own vsock configuration. A malicious guest can advertise
>a large buffer and read slowly, causing the host to allocate a
>correspondingly large amount of sk_buff memory.
>The same thing would happen in the guest with a malicious host, since
>virtio transports share the same code base.
>
>Introduce a small helper, virtio_transport_tx_buf_size(), that
>returns min(peer_buf_alloc, buf_alloc), and use it wherever we consume
>peer_buf_alloc.
>
>This ensures the effective TX window is bounded by both the peer's
>advertised buffer and our own buf_alloc (already clamped to
>buffer_max_size via SO_VM_SOCKETS_BUFFER_MAX_SIZE), so a remote peer
>cannot force the other to queue more data than allowed by its own
>vsock settings.
>
>On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
>32 guest vsock connections advertising 2 GiB each and reading slowly
>drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB; the system only
>recovered after killing the QEMU process. That said, if QEMU memory is
>limited with cgroups, the maximum memory used will be limited.
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
>virtio-vsock, vhost-vsock, and loopback, bringing them in line with the
>"remote window intersected with local policy" behaviour that VMCI and
>Hyper-V already effectively have.
>
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>[Stefano: small adjustments after changing the previous patch]
>[Stefano: tweak the commit message]
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 14 ++++++++++++--
> 1 file changed, 12 insertions(+), 2 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 6175124d63d3..d3e26025ef58 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -821,6 +821,15 @@ virtio_transport_seqpacket_dequeue(struct vsock_sock *vsk,
> }
> EXPORT_SYMBOL_GPL(virtio_transport_seqpacket_dequeue);
>
>+static u32 virtio_transport_tx_buf_size(struct virtio_vsock_sock *vvs)
>+{
>+	/* The peer advertises its receive buffer via peer_buf_alloc, but we
>+	 * cap it to our local buf_alloc so a remote peer cannot force us to
>+	 * queue more data than our own buffer configuration allows.
>+	 */
>+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
>+}
>+
> int
> virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
> 				   struct msghdr *msg,
>@@ -830,7 +839,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>
> 	spin_lock_bh(&vvs->tx_lock);
>
>-	if (len > vvs->peer_buf_alloc) {
>+	if (len > virtio_transport_tx_buf_size(vvs)) {
> 		spin_unlock_bh(&vvs->tx_lock);
> 		return -EMSGSIZE;
> 	}
>@@ -884,7 +893,8 @@ static s64 virtio_transport_has_space(struct virtio_vsock_sock *vvs)
> 	 * we have bytes in flight (tx_cnt - peer_fwd_cnt), the subtraction
> 	 * does not underflow.
> 	 */
>-	bytes = (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
>+	bytes = (s64)virtio_transport_tx_buf_size(vvs) -
>+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (bytes < 0)
> 		bytes = 0;
>
>-- 
>2.52.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

