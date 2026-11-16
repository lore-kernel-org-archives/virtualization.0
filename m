Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837305;
	b=0e3Kn4//WAOCM7i/qHM1QnQNnCvDum1dAOQ60X/MrzDwG+I4Adlcx1En/JpiIhGJDrWn
	 LwD/rDn+k49FWQTxBJMIBAhSJnPxOo/2BzkQlf7UrLB1Es+KAGDKTvZCD/5fM/P1G8bgx
	 GTsHfPjhm4549SQoYgeaCoHnMPxnrsvhLNib8czvbkeqxMfYbP2OsUraoNPWuEmjXsKDg
	 NFD6k5AwaR7ctoeKVIqrgt/ajQ5Fa864mNRgwmDplBg4ZGFA2FwFAn6ihWQ6YoyIotyFK
	 mjx6qtaqbQqT7y6lb6sLoDzO+Bd/+j7r6thhaPDQz47F9LQjjCYV34+LC5GoIaK345g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837305;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZSJToYozTYxAoX2DSMhPYtF3x2Zug3BZ5Yp5Zwq1bHs=;
	b=DlubN8mhM/0C42zKBSQ6JdGF4j6tmYvntcFGrQd7IHJu9Zzuv9V+PTBVs3E41m1msFdv
	 UJOkN1EKBMxtE8esN3gIS+qwLxJiZJHyOmVD3VOn1JhluD/EDnuVHAhOY3FgHf9GThqaO
	 rDWJY9h73vZGld5OcKYZqHyjsUBOneNuzDP8yPFWX9FWIsQg+DueVH7DXPHvD7QbQTSJd
	 088coX39qHx+gNsF8QrGjyAx/AxAzyHCccOb/l6E2cRuOgl4eH7Xgvslq+jy70Y82RnCD
	 suluvirLwlO05pzq/EI18jEq+9KLY4WbLmVXuHFjPRKXf6uzkmDDEcjNfdb25OwRjpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojnttcYQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9560A2624;
	Mon, 16 Nov 2026 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ojnttcYQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2771F000C6;
	Mon, 16 Nov 2026 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794837304;
	bh=ZSJToYozTYxAoX2DSMhPYtF3x2Zug3BZ5Yp5Zwq1bHs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ojnttcYQczskVLAWIQCzK/VB4k1GAQix19HvlONXnJ1thQ+Oo1tgiEZPyxnaPU8lg
	 Q7NCrq7A8gYKz/TawlMkFKSmeazTobmJxK2a+2woscXmIFT+YZrdPP86tTBfY3OrNI
	 SGbUmoLHnaaRTN0jd4jE7s8c1SiTZXBw/oJB07mRG62Wx7UrX2OpVndsbVyTGYdKwF
	 An/GRp2qUrX/9g+qMRjwod8qwSCFfECjz8K1bN8IzhvRoYP/BZ3wDgcE/Cw6N87dSs
	 /pYiQaney9BkzjPMfy5pcY7p6A8wFg+tR7rjMxsaOa5st+O5OlON36SoduDLERZdbc
	 LY72u30mt6new==
Subject: Re: [PATCH net-next v5 2/9] virtio-net: zero the whole tx header
From: netdev-bot+sashiko@kernel.org
To: s.trumtrar@pengutronix.de
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, eperezma@redhat.com,
 jasowangio@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, edumazet@kernel.org,
 andrew@lunn.ch, horms@kernel.org, kory.maincent@bootlin.com,
 liangchen.linux@gmail.com, hengqi@linux.alibaba.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kvm@vger.kernel.org,
 kernel@pengutronix.de
Date: Mon, 16 Nov 2026 13:55:02 +0000
Message-ID: <179483730268.3136.457734979427680662@kernel.org>
In-Reply-To: <20261112-v6-7-topic-virtio-net-ptp-v5-2-7ab67b572f4f@pengutronix.de>
References: <20261112-v6-7-topic-virtio-net-ptp-v5-2-7ab67b572f4f@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit fixes a real bug: virtio-net TX headers reach the
  device with stale or uninitialised bytes.
- [Low] The commit message says the bytes the helper does not set "go to
  the device as they were in skb->cb or the headroom", but it never says…

--

virtio-net: zero the whole tx header

This commit clears the whole negotiated virtio-net header in xmit_skb()
before virtio_net_hdr_tnl_from_skb() fills it in. Bytes past struct
virtio_net_hdr no longer carry stale skb->cb or headroom contents to the
device. The separate num_buffers assignment for mergeable rx buffers is
dropped because the memset covers it.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe7..4c740b403ad1e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3326,14 +3326,16 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  	else
>  		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
>  
> +	/* Fields the helper below does not fill in must not carry stale
> +	 * skb->cb or headroom bytes to the device.
> +	 */
> +	memset(hdr, 0, hdr_len);
> +

[Severity: Medium]
This fixes uninitialized bytes reaching the device. Should it carry a Fixes:
tag and go to net on its own, rather than as part of a net-next series?

Before this change, non-tunnel skbs only went through
virtio_net_hdr_from_skb(). That clears sizeof(struct virtio_net_hdr), which
is 10 bytes.

virtnet_probe() sets vi->hdr_len to 12 (VIRTIO_F_VERSION_1 or MRG_RXBUF), 20
(hash report) or 24 (UDP tunnel GSO). So bytes 10 through hdr_len - 1 went to
the device unchanged from skb->cb or the headroom.

The 24-byte layout and the current form of the num_buffers assignment come
from this commit, which is in currently maintained stable kernels:

Fixes: 56a06bd40fab ("virtio_net: enable gso over UDP tunnel support.")

The 12-byte and 20-byte cases are older, so their origin commits could be
named as well.

Without the tag, the fix only lives in a net-next feature series (RX
timestamp support). Would stable and distro kernels then keep sending up to
14 stale bytes per packet?

>  	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
>  					virtio_is_little_endian(vi->vdev), 0,
>  					false, feature_hdrlen))
>  		return -EPROTO;
>  
> -	if (vi->mergeable_rx_bufs)
> -		hdr->hash_hdr.hdr.num_buffers = 0;
> -

[Severity: Low]
The commit message says the remaining bytes "go to the device as they were
in skb->cb or the headroom". It does not say that this exposes kernel memory
to the device. Could the message state that?

In the can_push case of xmit_skb(), hdr points into the skb headroom:

	if (can_push)
		hdr = (struct virtio_net_hdr_v1_hash_tunnel *)(skb->data -
							       hdr_len);

The skb allocators don't zero the headroom, and nothing writes the bytes in
front of the Ethernet header. So up to 14 bytes of uninitialized slab
content per packet ended up in buffers the device can read. This matters
when the host or backend is not trusted, for example SEV-SNP/TDX guests or
VDUSE and vhost-user backends.

Also, the virtio spec requires the driver to set num_buffers to zero on
transmit, so a non-zero value there breaks the spec.

The XDP TX path in the same driver already zeroes the whole header in
__virtnet_xdp_xmit_one():

	memset(hdr, 0, vi->hdr_len);

Without words like "info leak" or "uninitialized memory", might maintainers
and stable reviewers treat this patch as a cleanup?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261112-v6-7-topic-virtio-net-ptp-v5-0-7ab67b572f4f%40pengutronix.de
