Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923339;
	b=pqLBMbKGGDtj21KPVGboD5ZsHRh9Cq5nqLIA3eADpyraRPTHwElMrMxdzHwFamVrOFoE
	 cWpQ6XnDKZjltjPEtNZqDFFlWbJu23yfUMOZOkoTKwBf0zqycyG/JEMMMwhPMfUlE9XP2
	 4xdeR0IppQzc6FmELI40Ilv7enpqFPP5LozJbYBEL/CPKjm578ZxapAxZdNiHDm1QBJ6w
	 J/94KjdSgm8baMMp1gSPDHRpzR8X5oA3u7p12MMAMmId8IVLTj0r0CrIfkKk59tqNfyGs
	 CpTLSDqBCk3rKXuoSMAv6CsG/GzvJ/Ra9I+UGhbqlfV0vA3GzHvtnl0QyKOUE9DLV8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923339;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I+AKrKdXrTGF3YhHydrji5oIlm8/d8kpGckl/JGzOyc=;
	b=K/5OpOC75xNvsjeMOUdfhMsojbqdlWLeI213gyOAD301c5AIsib6zDp7/DjJ8ORMM8Mq
	 0AueVwz2fnyFZqmoRkX7rXWey0G4iM7bo4Y/jsmaB8p/8hvND29o/50q3YwbynJ1bBpJw
	 K5fclkANHLg1vJCj2vIAPmKbP+5FIfJSCc8KenCU6StEw22NZ8RyOErKzNS7uTVbGFBpr
	 S+JTeMUXeOjg0a6Alh+uO5b5bCbRT3UWM5ZKY4oOH11EnY8GLOUt6NnWofhI+eZ5k6NJW
	 T0uxJ3Khwaa+eWEaO01hnEWQkksyUukg5Bqyh3ayMVMwTLlxlAas0zEFNrkMJJkVmhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nK2hn9LD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC9606A328;
	Fri,  6 Nov 2026 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nK2hn9LD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8161F0089F;
	Fri,  6 Nov 2026 00:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793923339;
	bh=I+AKrKdXrTGF3YhHydrji5oIlm8/d8kpGckl/JGzOyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nK2hn9LDrrajrZEXf5Hj/6MFANn3WSgT2Ksihbp5WbmkddYTlGN5SCLBlC321KJeI
	 G6UQOpo+tEJw1Hmde+kxM5K7+blKYo2jBdIRxQpMeRwjsB5mTeUWEzffbEkLV1fZvI
	 Oyodb0Vb4t1hWkQPlKvA6wAvr86tGNlT8ccHgblZhepGqUYhv/TvP9rxdlygtcT3/q
	 XDDakEho7iruSTJGk++snUvP0cFxOOMap3ZqqF+TEzAaLgzY/O8RyrIJkxzLpiGxry
	 +zkkR/0r7OC+ZCdlgYcrqLQWc9E2wJaf6FBLGaiROnQ417sEpXXbd8ihdLz1rVLcvK
	 GFdPeZ6nQEehw==
Message-ID: <sashiko-outbox-200421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 3/3] vsock/virtio: queue at most one credit update
 per socket
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleg Drokin" <green@linuxhacker.ru>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000141.3617241-4-green@linuxhacker.ru>
References: <20261105000141.3617241-1-green@linuxhacker.ru>
 <20261105000141.3617241-4-green@linuxhacker.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:02:18 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vsock/virtio: premature credit_update clear in virtio_transport_se=
nd_skb()
--

commit 2cdb1a5b77890d0e5001ce1a907ca3477d945d5d
Author: Oleg Drokin <green@linuxhacker.ru>

vsock/virtio: queue at most one credit update per socket

This commit limits each vsock socket to at most one queued credit update
packet when its last queued packet is already an OP_CREDIT_UPDATE. When the
transport transmits the queued credit update and no newer packet has been
queued after it, virtio_transport_credit_update_xmit() refreshes its
fwd_cnt and buf_alloc and clears vvs->credit_update.

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index 4f9aa9c4c3aa5..82cd52249de3c 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -104,6 +104,8 @@ static int virtio_transport_send_skb(struct sk_buff *=
skb, struct virtqueue *vq,
>  	int ret, in_sg =3D 0, out_sg =3D 0;
>  	struct scatterlist **sgs;
> =20
> +	virtio_transport_credit_update_xmit(skb);
> +
>  	sgs =3D vsock->out_sgs;
>  	sg_init_one(sgs[out_sg], virtio_vsock_hdr(skb),
>  		    sizeof(*virtio_vsock_hdr(skb)));

[Severity: High]
Does calling virtio_transport_credit_update_xmit(skb) before
virtqueue_add_sgs() clear vvs->credit_update and advance vvs->last_fwd_cnt
even when adding the packet to the tx virtqueue fails?

In virtio_transport_send_skb(), virtqueue_add_sgs() can fail (for example
with -ENOSPC when VSOCK_VQ_TX is full, or -ENOMEM under GFP_ATOMIC on the
fast path):

net/vmw_vsock/virtio_transport.c:virtio_transport_send_skb() {
	virtio_transport_credit_update_xmit(skb);
	...
	ret =3D virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, gfp);
	if (ret < 0)
		return ret;
}

When that happens, virtio_transport_credit_update_xmit(skb) has already set
vvs->credit_update =3D NULL and vvs->last_fwd_cnt =3D vvs->fwd_cnt, and the
caller then queues or requeues skb in vsock->send_pkt_queue:

- via virtio_transport_send_pkt() -> virtio_transport_send_skb_fast_path(),
  which falls back to virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, s=
kb)
  when vsock->send_pkt_queue was initially empty, or
- via virtio_transport_send_pkt_work(), which puts skb back with
  virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb).

While skb sits in vsock->send_pkt_queue with vvs->credit_update cleared to
NULL, subsequent calls to virtio_transport_send_credit_update() (from
OP_CREDIT_REQUEST or local reads) will queue additional OP_CREDIT_UPDATE
skbs behind it. In addition, when skb is later sent by
virtio_transport_send_pkt_work(), virtio_transport_credit_update_xmit(skb)
sees vvs->credit_update !=3D skb and will not refresh hdr->fwd_cnt or
hdr->buf_alloc with credits freed while it was queued.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000141.3617=
241-1-green@linuxhacker.ru?part=3D3
