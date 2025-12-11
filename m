Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65B1DB13A
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765458961; cv=none; b=SZauUwNK1ntpeh110uVGI/jKO7qGGgddUyfW/St5RfXCChQu075v20fPuC2TavUDnmOjF31JWFdpk0vrIos65NfOd0RDupWoClqxiDNbHV85rov95fHLoVzkYllUizGV4/QglQK4i+nBWXfVb3zXyp9n2d8tzJDk5bdGQlW7zhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765458961; c=relaxed/simple;
	bh=D4DGGb+z62y89qoodZRwxBqyQ2W24OvlNfUQo6Mp9cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hDOqwytDsKbIzbOxl+qLChw1Tg4HUef/gZv7HV428TW2R2B6s4uSASXJ2RI/6suc4c+gR3yHqjxrWNExCcr8FQ7WGFbhW0HTpHpgO7ZqvLYUxB8S8TyLujJ7auj9UJRo+ltSlrbepn8u9qRora4acsOJ6PAV85blcRc9JWahMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zu8CHSIS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zu8CHSIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765458958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcxS9gtwtWQRG7jJr9nwORwV625I1nRnmvMTOs/IWiM=;
	b=Zu8CHSIS7vJtNxYpQJu4Aen/6QT97ML8uw5Kk1vO0SyUwCan182rOckXVXM1sfdzJP61sS
	/EQOCINgHLoDCmMUgxOl34DJVILuVRxGs/Fa7oa1YBOkwo7cabOBzwhD6507OLMqgKiVEY
	TdLRcigqJNO9HItMRhviRxtb32l4ptw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-hVtPZOrxMui7f2QieEgQZw-1; Thu, 11 Dec 2025 08:15:58 -0500
X-MC-Unique: hVtPZOrxMui7f2QieEgQZw-1
X-Mimecast-MFC-AGG-ID: hVtPZOrxMui7f2QieEgQZw_1765458957
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so656225e9.1
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 05:15:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765458957; x=1766063757;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcxS9gtwtWQRG7jJr9nwORwV625I1nRnmvMTOs/IWiM=;
        b=U6SPtQR6q+Fd+8+GUKn1uDoUjjaofyUUXyHwCNz4HKJRMQUEHCKy1MxyhRm2HNAoN9
         4/+YR9RUT2R+vGRNGhnQJn8OhhNlPpfaRWrH18jHJUpjqm1Iry/yYSdkApCDBmoP248L
         PvRkF5sTSMjeCenOiJQ+up8mvPiKzGRQdpk3mnOCAF2EtVmxYeMKePJtB+B8tEcTObtQ
         tUHUreUxqTgqY/N+u0U735r9SmTFWOd0xddo/ZnH7DTVkEYR5AeE/KwWq2qrp8sks6LG
         +cmCLw9aOH09C/NFD/OrnjUgfxT9uunQ+zgq0xs/UeHZUjCkKoiHp2oQgwd8h+WcDQyp
         rqNw==
X-Forwarded-Encrypted: i=1; AJvYcCXGDoExbE8/VcZAHah4Hr/DVCc8jXWV9c0EYGOwiAha0X7enzW8ssMUVTW3p3bex3m0mgb7FzhMY6mQ3xSDmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHI8GzD5l1Pvtl/TAuWqpZCIFFTGlT6KdNjiNrmk+J8eBp9IiH
	ur4X4p3Qj4BR/w5fr1UPLo6eUwe5xVXd479GyTFSDaYIMJBc5NUJioVlHxF8su/2fcncsvN3Uoe
	3itfPlQn9+Osq3A4UcEuDSFW2i45i/AvswZO8BQPXiFix5AndPV/yCoig4w7RvwItw9JT
X-Gm-Gg: AY/fxX7UcaUqH26NbhPA8am0oAbUmGrySYNtGUvWUZcuDGwOeKoFTD47BOuhJv4GuNj
	fq7k62iKwX1n4g6nLdduSPLtBNnDXRwrAcYSN5m5cWK0jzBQ5NIRNHpdTJHPhijYY7bHFEU7PZ3
	Wpwixo9wVFlZoLX5SxSQeXHCG3II13IStoD6UU7gAAhvy8YTHCVqeeidXCKa7SVlR2KiDrgKsk9
	+NqTrZANeUkb9DJ2ncs9QPAfh+MSPnSQ7Myp+Ii9piGOai055lwmOHuG8S0NHrIgP+HDv1Lb1Ld
	rfFps0XZgJtQDmddfeRY+rzHTSFeFxIl8Vw0rWSrILpWhEKzTez7XXCsAhZIQevyaAEpj2fCnWr
	KloOZa4wGHl/WgR+qBt9kem2+wDMVSyZZw/PtJmxGwVpboDDF1VwvAMtkTImMyw==
X-Received: by 2002:a05:600c:811a:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-47a8380695emr46249005e9.22.1765458956447;
        Thu, 11 Dec 2025 05:15:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPy0Hrynl/SKJgf0tueBAFzbll9ERYzFk6T5Mif9KPff/zyeo06XmGrpdpM7whHIa5OMi70Q==
X-Received: by 2002:a05:600c:811a:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-47a8380695emr46248335e9.22.1765458954662;
        Thu, 11 Dec 2025 05:15:54 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a89d8405dsm14222975e9.2.2025.12.11.05.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 05:15:54 -0800 (PST)
Date: Thu, 11 Dec 2025 14:15:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: stefanha@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
Message-ID: <uo63g2tsmgcqqg3tpzm7tdtfn2pr73kymfyl4woulpwcobevuw@vr3d4i4konge>
References: <20251211125104.375020-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251211125104.375020-1-mlbnkm1@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3ZtWH2KqqXgClZ7aEK3dKxXdAgxoFigXQCgc_qVPgaU_1765458957
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Dec 11, 2025 at 01:51:04PM +0100, Melbin K Mathew wrote:
>The virtio vsock transport currently derives its TX credit directly from
>peer_buf_alloc, which is populated from the remote endpoint's
>SO_VM_SOCKETS_BUFFER_SIZE value.
>
>On the host side, this means the amount of data we are willing to queue
>for a given connection is scaled purely by a peer-chosen value, rather
>than by the host's own vsock buffer configuration. A guest that
>advertises a very large buffer and reads slowly can cause the host to
>allocate a correspondingly large amount of sk_buff memory for that
>connection.
>
>In practice, a malicious guest can:
>
>  - set a large AF_VSOCK buffer size (e.g. 2 GiB) with
>    SO_VM_SOCKETS_BUFFER_MAX_SIZE / SO_VM_SOCKETS_BUFFER_SIZE, and
>
>  - open multiple connections to a host vsock service that sends data
>    while the guest drains slowly.
>
>On an unconstrained host this can drive Slab/SUnreclaim into the tens of
>GiB range, causing allocation failures and OOM kills in unrelated host
>processes while the offending VM remains running.
>
>On non-virtio transports and compatibility:
>
>  - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
>    socket based on the local vsk->buffer_* values; the remote side
>    can’t enlarge those queues beyond what the local endpoint
>    configured.
>
>  - Hyper-V’s vsock transport uses fixed-size VMBus ring buffers and
>    an MTU bound; there is no peer-controlled credit field comparable
>    to peer_buf_alloc, and the remote endpoint can’t drive in-flight
>    kernel memory above those ring sizes.
>
>  - The loopback path reuses virtio_transport_common.c, so it
>    naturally follows the same semantics as the virtio transport.
>
>Make virtio-vsock consistent with that model by intersecting the peer’s
>advertised receive window with the local vsock buffer size when
>computing TX credit. We introduce a small helper and use it in
>virtio_transport_get_credit(), virtio_transport_has_space() and
>virtio_transport_seqpacket_enqueue(), so that:
>
>    effective_tx_window = min(peer_buf_alloc, buf_alloc)
>
>This prevents a remote endpoint from forcing us to queue more data than
>our own configuration allows, while preserving the existing credit
>semantics and keeping virtio-vsock compatible with the other transports.
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
>Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
>Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++---
> 1 file changed, 24 insertions(+), 3 deletions(-)

Changes LGTM, but the patch seems corrupted.

$ git am ./v3_20251211_mlbnkm1_vsock_virtio_cap_tx_credit_to_local_buffer_size.mbx
Applying: vsock/virtio: cap TX credit to local buffer size
error: corrupt patch at line 29
Patch failed at 0001 vsock/virtio: cap TX credit to local buffer size

See also 
https://patchwork.kernel.org/project/netdevbpf/patch/20251211125104.375020-1-mlbnkm1@gmail.com/

Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index dcc8a1d58..02eeb96dd 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_buff *skb, bool consume)
> }
> EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
>
>+/* Return the effective peer buffer size for TX credit computation.
>+ *
>+ * The peer advertises its receive buffer via peer_buf_alloc, but we
>+ * cap that to our local buf_alloc (derived from
>+ * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
>+ * so that a remote endpoint cannot force us to queue more data than
>+ * our own configuration allows.
>+ */
>+static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vvs)
>+{
>+	return min(vvs->peer_buf_alloc, vvs->buf_alloc);
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
>+	ret = virtio_transport_tx_buf_alloc(vvs) -
>+		(vvs->tx_cnt - vvs->peer_fwd_cnt);
> 	if (ret > credit)
> 		ret = credit;
> 	vvs->tx_cnt += ret;
>@@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_sock *vsk,
>
> 	spin_lock_bh(&vvs->tx_lock);
>
>-	if (len > vvs->peer_buf_alloc) {
>+	if (len > virtio_transport_tx_buf_alloc(vvs)) {
> 		spin_unlock_bh(&vvs->tx_lock);
> 		return -EMSGSIZE;
> 	}
>@@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock_sock *vsk)
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

