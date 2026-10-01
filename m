Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED83451A9
	for <virtualization@lists.linux.dev>; Thu,  1 Oct 2026 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849877; cv=none; b=n3plXCY2vYrGLQf/Tpl3X999J0liLiJpb2RVRiUSJ1OmjTvI0OsSRgp89+ZXErlPGNYpASuvi1TpDHTH+UrObUZ6P3eLorRN5YjF83QF7pcX9KbmGtQQj91iX42uLzxsgpfCN8fQT5CApmKKpPWnhFDY0SRM5fKro6OnFqChmbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849877; c=relaxed/simple;
	bh=dUdFDVqTzQDPNI8dPEkhLuVWoA942/H4IpUUxhUFDEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=MYXTWw9Oc0CM7JJ64tK5zegMdU5C6MiJB06aXvL8Rey/2i/DrVkDjp9cncAcL4VFqp0H5nXBcgnY31/m1UDN0a6nabXLTdHwT+ExPpf4sN5w5u+L3Pw6LWGxZFxZ8dUoKauGJ5ndJSRTaVWitZiimm1e3bw5FHyloNdhseJ/fpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aEMv44Rz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aEMv44Rz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790849874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cOthZx3yTwvPTr4Ura6Gt3ofRbmBrIyhkJxXxQE8kK4=;
	b=aEMv44RzZ3gJWt43MIhf9sQWi5964CWP6YxrCUPfCDeXhZZLUvuVlR3hl9geYBwc9LQ1yX
	nSdfWLehAk0+ycnzxWV3e0mEVs1hk3L3o9p4+HmsBUWmmpcuDa+xKDAClJpUev7kV9Avx5
	r92XOLJ+cNC+amRRMQwX05HYifBl0aU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-d3idf9c8OgO6XoonFQA1LA-1; Thu, 01 Oct 2026 06:17:53 -0400
X-MC-Unique: d3idf9c8OgO6XoonFQA1LA-1
X-Mimecast-MFC-AGG-ID: d3idf9c8OgO6XoonFQA1LA_1790849872
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a021b1b561so3615025e9.1
        for <virtualization@lists.linux.dev>; Thu, 01 Oct 2026 03:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790849872; x=1791454672;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cOthZx3yTwvPTr4Ura6Gt3ofRbmBrIyhkJxXxQE8kK4=;
        b=2a2vIt98kwGTSk08ifa5+GGuXMwkq5ESgSSfJpHksgX8o8VqXIDq4weCcC7swRabvT
         j3VtT/i85I4L1LPXTp2m9r4mQYUrMFQQap8dAnKGNYwt3Phf3Asz7L1mQYuQAiezYp0t
         WcIbQ9MTrpE1aEuW1unPOappMqi3n74atAe/SbRZb34kPdzl7zn+W++xhRV0g7Sy/Bpr
         9UuBKJ25hoQhbOvnvykKukB21jr4hd1frLn+UXPzLidpKxNgpMKuzj8QZ3ogeVDHRd5v
         lM+VllyZmNuiotDNprPUQgc2cmUHpnzxxtuzRHMiZu86hOexrOEGJdcX9KJ4uGUzL5cB
         YhaQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfQW15J7SBwD64V8/fDSbWIfUi0ewOBhBn5NEN+kjCfQWNtuUIBmo8bkAbPAjl1oa13YKoOiIY1E3YkUtbRg==@lists.linux.dev
X-Gm-Message-State: AFuF++lUvF1pk3eHb9vevkXiHyxgvlQkW00aRoPeGA1j+hCJWAKy5n8a
	h71r/GEAx8ipKrZCGcRGA6Denc9ckGHJgVBmfh/q9+QF2hGv0qaCNZfO919QDi4SMKW1GlhRh6M
	z7Y1F0mOKiZXTCva0IKkvcv8y3C5J3arkzDYxv+9jK+SInf3A4TpEITtU4GKtJxkGx3FK
X-Gm-Gg: AYBFou0KDZbkrXJI5H3+W2iWUEaapVvjdfzRps/UvJzvtDstFa55Jxz7G0WIetyizW4
	rm5S9nAPKTULCI51CXi8Pnre7v5v3CP2jxyAO1J65PLFRQCkR7w9h/KQg+ntVdmlmB3+T9cqEgi
	UKiSsOQCeT8hmX9Z3kj3Ww29htwEyQUer9Nlzfn28MrhojTLbRNEodA1LbCtcdPWNKopKM+PkuK
	cMt/KOVOVkEBtNaEpG5WTuP5PgeKeWBRkzpVNcz6rKtcN+nRIuOmUhK5ysq7/TddOQLVHaPNwHP
	j/ZNdVqOBSpTjDcSG0pr1h+1wXM/znlOoXVOWfEXoYNGYhD1I7gCi225/R3TRc5ioj0MUImEK9a
	h
X-Received: by 2002:a05:600c:a40a:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a01b12384emr64730945e9.27.1790849871498;
        Thu, 01 Oct 2026 03:17:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a40a:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a01b12384emr64730455e9.27.1790849870881;
        Thu, 01 Oct 2026 03:17:50 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.112.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b0690e721sm5651491f8f.20.2026.10.01.03.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:17:50 -0700 (PDT)
Date: Thu, 1 Oct 2026 12:17:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost/vsock: trim nonlinear SKBs to declared payload
 length
Message-ID: <ar4xDQliGcCQEfSA@sgarzare-redhat>
References: <20260930044147.3818241-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260930044147.3818241-1-4ncienth@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ksPS381ltNlY6UfzF3khAoYS18o7ZpUtBfT1Fw25z2M_1790849872
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

+Cc Will that touched this code recently

On Wed, Sep 30, 2026 at 01:41:45PM +0900, Daehyeon Ko wrote:
>vhost_vsock_alloc_skb() sizes its skb from the total guest descriptor
>length, while virtio_vsock_hdr.len independently declares the payload
>length.  Since commit ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs
>for handling large receive buffers"), large descriptors use skb fragments.
>
>virtio_vsock_skb_put() currently changes only skb->len for a nonlinear
>skb, leaving skb->data_len and all fragments attached.  The zero-payload
>fast path skips the helper entirely.  A guest can therefore retain the
>full descriptor allocation while receive credit accounts no payload.
>
>On Linux v7.2, 455 zero-payload skbs retained 30,255,680 bytes on a
>256 KiB receive buffer while rx_bytes and buf_used remained zero.  A
>full-payload control retained 265,984 bytes in four skbs.  The existing
>SKB_TRUESIZE(0) queue budget caps skb count but does not account for these
>descriptor-sized fragments.
>
>Set skb->len to the fragment length before calling pskb_trim(), then trim
>to the declared payload length.  This releases unused fragments and lets
>skb_condense() reduce truesize.  Move the zero-payload return after the
>helper so zero-length packets are trimmed too.
>
>These skbs are newly allocated, unique, and have no frag_list, so the trim
>does not enter an allocation-bearing path.  Keep a warning for a violated
>caller contract.
>
>The fixed v7.2 image left a one-byte skb with no fragments and reduced
>the zero-payload queue to one 960-byte skb.  The build had no compiler
>warnings, and the run had no sanitizer, WARN, oops, or panic findings.

I think this is a requirement for every patch sent, no?
Why putting in the commit message?

>
>Fixes: ab9aa2f3afc2 ("vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
>---
>Required configuration is CONFIG_VSOCKETS, CONFIG_VIRTIO_VSOCKETS_COMMON,
>and CONFIG_VHOST_VSOCK.
>
>The source reproducer is available privately to maintainers and is
>omitted from this public AI-assisted report. It exercises the real
>allocation helper and VSOCK receive queue from an in-kernel module, not
>a live guest virtqueue. Guest control is source-confirmed, but live guest
>end-to-end validation and deliberate host OOM were not performed. No KASAN
>splat is expected or claimed; the oracle is retained truesize and receive
>credit state above.
>
> drivers/vhost/vsock.c        | 6 ++----
> include/linux/virtio_vsock.h | 9 ++++++---
> 2 files changed, 8 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index abed1fbcf66c..fa59456abda9 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -400,10 +400,6 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
>
> 	payload_len = le32_to_cpu(hdr->len);
>
>-	/* No payload */
>-	if (!payload_len)
>-		return skb;
>-
> 	/* The pkt is too big or the length in the header is invalid */
> 	if (payload_len + sizeof(*hdr) > len) {
> 		kfree_skb(skb);
>@@ -411,6 +407,8 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
> 	}
>
> 	virtio_vsock_skb_put(skb, payload_len);
>+	if (!payload_len)
>+		return skb;
>
> 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
> 		vq_err(vq, "Failed to copy %zu byte payload\n", payload_len);
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index f91704731057..31358683e23e 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -51,10 +51,13 @@ static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
> {
> 	DEBUG_NET_WARN_ON_ONCE(skb->len);
>
>-	if (skb_is_nonlinear(skb))
>-		skb->len = len;
>-	else
>+	if (skb_is_nonlinear(skb)) {

Would be nice to have a comment here to explain better the reason we are 
doing this.

Thanks,
Stefano

>+		skb->len = skb->data_len;
>+		if (WARN_ON_ONCE(pskb_trim(skb, len)))
>+			return;
>+	} else {
> 		skb_put(skb, len);
>+	}
> }
>
> static inline struct sk_buff *
>
>base-commit: 54518e0e827f4ca9229ae657022c60bf60f5c1bf
>-- 
>2.55.0
>

