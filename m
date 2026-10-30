Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793342845;
	b=0H31pROYywjn9NGPQfPstWzziY3+tzrTAOHS9I0mmn+OpxVzIpvnQoL/Hesg5IvY89Ml
	 NZGSvVW2JzVkeMkI14WOB9QhDi5ObxrBNTrwO+ugM8kLKNdcvQ8vNraxW1K68lj8++CWU
	 t61+y9JhsWYwgi0DvXE3cLs5SDPVJ3S5iAhqqwAQ3VGXyNSEiw7kinOa+/I9uytltVJui
	 rQsehtjPPMIKQNOM6oM1qQTGixJ4s4VXF7Yi1jl4JoV0CRwe9WxOIgdbt0G0N0bUc1FqK
	 klbFgZ5BBxTcjSVddS33I2sxg8Bbxk1DJqaoD1B7lGbXIDQqw3J9w9sP6zFheuPoJ8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342845;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JCA4Dw39EpYKvErdSLs70whxYqhuqitv81R2HouAmv0=;
	b=kGivhYF6qgaXooRuYv6mM/QIyt4vUuC+rXxHjsQ/92JiqjU/T4anYIZv0CNShxklLfJT
	 beJbBXY16Llmkx0h6CtdP1hPTGn7lgwzKwyQuiLIMjyhhnaykLQsX4H4Rbrs74A9pwRgN
	 Lq5eaW4/vbF/REPCJD/3p7iepCNStVo7mEz9fmv7wNoEo6XpJyW1xmRMOqvjc2gEY/MtZ
	 OLEBdI+d4tS+WoQ9T7yuigloMV/8Wmrkop0WMjN2fQ8+YMAy5wT61SFjpZnVN/GHQ8NyP
	 wbaCPJFVLj9jvu5fmHEYD+ehYGjeiMDV51upnxRDxGP0VDIoRYjjqBacSIUG+eVTmnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ikuyo.dev;
	spf=pass smtp.mailfrom=ikuyo.dev;
	dkim=pass header.d=ikuyo.dev header.i=@ikuyo.dev header.a=rsa-sha256 header.s=s1 header.b=jiAAjAkm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DE606A31D
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 06:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E7DE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ikuyo.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ikuyo.dev header.i=@ikuyo.dev header.a=rsa-sha256 header.s=s1 header.b=jiAAjAkm
ARC-Seal: i=1; a=rsa-sha256; t=1793342816; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GGRWgvbk4z6EgpbonyBt1ER1tnhKNlOHaQjKmWsvrY3xD/gmKDuZpLka5/2zCfNppwbAQXUzmnMbYEPiaqLXoEVBgwL7bw5krDw/PnJEw7FAnD8yYIFkERTrNS4yF9LpmQusa4VAoWxMqvJUotQ+V82Lha4+D2ktXuERbkekgB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793342816; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JCA4Dw39EpYKvErdSLs70whxYqhuqitv81R2HouAmv0=; 
	b=SKIwpPpLd5Exjnq5ovDW+gwCtas7UncLK37DRRFQqyyDv2py12HV2O2mJ2SS2tzzs15oLlqnU9er+QdNfRQ5hug5xYSbUKFFM8QclwVX8fwT2662QD5H8jjv6JbZbUpJ7001GvJ2fPVi2IrhLhe/Tk6qz2fneipK6XKRs9JDsI8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ikuyo.dev;
	spf=pass  smtp.mailfrom=eritque-arcus@ikuyo.dev;
	dmarc=pass header.from=<eritque-arcus@ikuyo.dev>
DKIM-Signature: a=rsa-sha256; b=jiAAjAkmj+Lox98skzB62m/AloFYWSK2UZrcygALrRE887pBIsSwKDQ/G7PHwdmMxHR3DJzlOiQFpbbuhWljnlf8L5UbajNkLinlYSbrOHX2uzNLEQIoVmaSloyTn6J7hkXrqjc541VeUUt78MwNa+sqCnV8M3+ylWetSJYUsIlWukCft8oKbh3jl6O6PoI59fhxWhsQa6r7gAWUNQiSsC9LZAMM9inXtny6m/urItNXtt876Z17A9KDPIF5Y2dFmFzcAN9Rf6kQzLCOC7LyFXd6FEmv4BYMkettSsg9MbekOaxih7knXkOzCMcYyz3to+wPCcHYKIblto4h9ncdVg==; c=relaxed/relaxed; s=s1; d=ikuyo.dev; v=1; bh=JCA4Dw39EpYKvErdSLs70whxYqhuqitv81R2HouAmv0=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793342812466154.35937773938758;
	Thu, 29 Oct 2026 23:46:52 -0700 (PDT)
From: Yiran Qiu <eritque-arcus@ikuyo.dev>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiran Qiu <eritque-arcus@ikuyo.dev>
Subject: [PATCH RFC net v2 2/3] vsock/virtio: send credit updates only while connecting or connected
Date: Fri, 30 Oct 2026 02:44:17 -0400
Message-ID: <20261030064418.133349-3-eritque-arcus@ikuyo.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030064418.133349-1-eritque-arcus@ikuyo.dev>
References: <20261030064418.133349-1-eritque-arcus@ikuyo.dev>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once a socket has a transport, changing its buffer size
(SO_VM_SOCKETS_BUFFER_*) sends a credit update in any state, from the
transport's CID to whatever remote address the last connect() left
behind.  So a socket bound to (guest CID, P) whose loopback connect()
failed or was refused still sends as (VMADDR_CID_LOCAL, P).  If another
process has a connection open from (VMADDR_CID_LOCAL, P) to the
listener that connect() targeted, the socket the listener accepted for
it takes the update's buf_alloc and fwd_cnt as its peer's, and can
stall.

On a host without a guest->host transport, a socket whose loopback
connect() failed can then connect() to VMADDR_CID_ANY with
VMADDR_FLAG_TO_HOST.  That fails with ENODEV but leaves VMADDR_CID_ANY
as the remote address, so the update reaches any loopback socket on
that port.

Only send the update while connecting or connected.  Now that connect()
refuses a CID the transport does not own and leaves a failed socket in
TCP_CLOSE, a socket in either state sends from its own address.

Found by an LLM review of an unposted draft of this series.  On
unmodified kernels, where the first connect() times out instead of
being refused, a non-blocking send() on the accepted socket returns
EAGAIN after the update; with this patch it succeeds, and vsock_test
passes.  Drafted with Claude.

Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
Signed-off-by: Yiran Qiu <eritque-arcus@ikuyo.dev>
---
 net/vmw_vsock/virtio_transport_common.c |  4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8f524d073ae1..4d0511629044 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1098,7 +1098,9 @@ void virtio_transport_notify_buffer_size(struct vsock_sock *vsk, u64 *val)
 
 	vvs->buf_alloc = *val;
 
-	virtio_transport_send_credit_update(vsk);
+	if (sk_vsock(vsk)->sk_state == TCP_ESTABLISHED ||
+	    sk_vsock(vsk)->sk_state == TCP_SYN_SENT)
+		virtio_transport_send_credit_update(vsk);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_notify_buffer_size);
 
-- 
2.56.0

