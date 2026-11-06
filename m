Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.87.85
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793941356;
	b=zqpORgplvkNG6CWiSHCS0QTIScG/85CgJLK3p3Us2Mlg9rguc35Pmy3w8tvq66pAfd4O
	 ilxnRVgEFFGCr2jNab2xjlnTA04LuBJqrDn2jJN0v+SLIr3FZErlZ0oo75QeVmSsVFTqT
	 Z7Y49RcyhpxG1tCYgKSAovMNVryPMS/sYH9yARRvtkvV0iQ+BMoAJ8GmO+W0Y+7tRXLCX
	 K10rEew8p0BCBLgX/Gj6VgLFm9qFWIcG7ZifJFd0XPvnnVGSUG5Ll758mlsXygZ4zx34d
	 QQfMblfvZ9OrTylzNaVsEwoCHsc7t7XMJTnpwX3j20419RPZaAx8HlChrHxpTK0Oc6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941356;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=/E4P3dYGG3OLLZ/+JjGK4939CGV5ZJ679kg1UXIY3WI=;
	b=WwVNBbakvQpu0s/yHc+Kz9JsHtqAS8lBqZ3kChwnstSY036ts9Bnnnqbz5EvpAZhl+SZ
	 CbxFOCZf6fn9U3nwx/yYc1VqX88F5QNVNXy9ybWAL3WQStaP28HdATQjiBPiQaiz99VdB
	 Gu17Hj7XAgHyTcZWWEt8thcfDUc0lmli2o2korUHypkWeOTehtQJ2UZ7ybcqctTGXT/P7
	 FI0zMVpHSg8jTo4Xoj8GQZQEGkBgNO0PNDne5LgOQxlZyXjgvOhc3TZvr6E88hakzIUkN
	 XmxhDxDLAH27ue6DF0mzgv+sMJKXFsHTAEL48YganAtWzyZ+wQPsYBtk91xGu63QJCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxhacker.ru;
	spf=pass smtp.mailfrom=linuxhacker.ru;
	dkim=pass header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=snlGUrD0;
	arc=none smtp.remote-ip=159.69.87.85
Received: from eagle.linuxhacker.ru (linuxhacker.ru [159.69.87.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5995606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 05:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5995606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxhacker.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linuxhacker.ru header.i=@linuxhacker.ru header.a=rsa-sha256 header.s=mail header.b=snlGUrD0
Received: from [10.137.0.31] (unknown [162.81.204.199])
	by eagle.linuxhacker.ru (Postfix) with ESMTPSA id 7A2C7BEE42;
	Fri,  6 Nov 2026 05:02:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 eagle.linuxhacker.ru 7A2C7BEE42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxhacker.ru;
	s=mail; t=1793941347;
	bh=aqDdN5EbIY6jIgTAilZgeXe6s88P6n4MhtpN1ffc92k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=snlGUrD0Q3Yg+a0E085tRFo10AhVaxfpNBITl2MVPIqcC0Q1d8eMgKRWJd4V00lte
	 UluotoNGtZJONdFBGprmosOJH9ALqG55htsIedDzkSpSnJaXQP/BhfVmxzqN3O69RA
	 fje+5IDucsxsZ99Svs8v2+msNGlP2nEl8P+F36DmnOdi/y/spIcV4TlfHMDXiDd0CL
	 FGm+Pzli4O+YOLo2kg/teEqPm53N6V8clkHQ7EhXWp0F1P3KBARWDjY3iz02S3C8jM
	 RhYulnXClDSxvYLdXmnxKG0EbXa3Aah0pAAKksGbFOsmjZ2JreNzV5qG+9RbMxA5M3
	 pAlCMzizTYwzg==
Message-ID: <9615375a368c5d6c31cae9dbbfd51db037784193.camel@linuxhacker.ru>
Subject: Re: [PATCH net 3/3] vsock/virtio: queue at most one credit update
 per socket
From: Oleg Drokin <green@linuxhacker.ru>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: sgarzare@redhat.com, stefanha@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, bobbyeshleman@meta.com, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, 	horms@kernel.org, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, 	kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 06 Nov 2026 00:02:23 -0500
In-Reply-To: <20261105191917-mutt-send-email-mst@kernel.org>
References: <20261105000141.3617241-1-green@linuxhacker.ru>
	 <20261105000141.3617241-4-green@linuxhacker.ru>
	 <20261105191917-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-05 at 19:19 -0500, Michael S. Tsirkin wrote:
> On Wed, Nov 04, 2026 at 07:01:41PM -0500, Oleg Drokin wrote:
> >=20
> > =C2=A0
> > =C2=A0#define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb
> > *)((skb)->cb))
> > @@ -167,6 +168,9 @@ struct virtio_vsock_sock {
> > =C2=A0	u32 buf_used;
> > =C2=A0	struct sk_buff_head rx_queue;
> > =C2=A0	u32 msg_count;
> > +	struct sk_buff *credit_update;
> > +
> > +	refcount_t refcnt;
>=20
> why all this complexity? can you not just peek at the queue tail
> instead?

Thanks for the suggestion. The send queues are per device, not per
socket: vhost has one per guest, and the guest driver and loopback
have=C2=A0one each. A peer with two connections can alternate its credit
requests between them, so the tail is always the other connection's
update and nothing would ever be merged.

v2 reworks this third patch:
vsock_sock remembers its newest queued packet while that packet is a
credit update, together with the queue it is in.
The refcount, the skb destructor and the transmit hooks
are gone, and vhost and the guest driver are not touched.
