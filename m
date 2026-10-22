Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655440;
	b=j+YSYsrC5RqKlZHmHWdUWx0os0utPajzBUKuuGcyw+luVrfgpLAegRn8DdvTKwAzMqsR
	 DLCUJxivdfBsloUjXn6J6EDVsHnpvTGkGUucHTorPL/9LyeQgEI7AxMf1ozNCkHQ8IGQu
	 UJnSk3y4iwWkSwtzuFDIlzT64xa9O0A+H9/VE3amkaPX28USGNuemYwrhF/Dh5BOAWlYz
	 EIwcCIOZ3bypaoivEsi/GT5P4CZUHVRyacPdMtsmyIwqeEM+7pjiCzY3NHKdMHHOf6Vpl
	 rTz/uAAj4HkEPfLs45ljNtw7MmkXjuE2eoO2DDHuBDikmwL14kISL3oDuZtpR96VDjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655440;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=29hCI2hFiGKU5Gw0Z81Jew8ydon365NqWbnTDnRUMgU=;
	b=dkYUf6azQUL2SDVOWl+Bcz8VZ1wVMGPmZCA/QVbBFivcxUBplmMTrBKGDSxDSaCT/Qwa
	 H+Q5XWWPHB5e3wx2f7HgrRaWRrYHzVT9OTofEsz2WuaASTXf0zYa7603AV3s9Xu6X9/HO
	 /eiFR3ghf9DefFReiq+9CB2lad2uSEJ2W1JCTK9td0NXTh5vmJ2zFA9tlJ63toST45awL
	 ow9x7iveZoxN/zSL3rgDRRLfG+yF7l1nyJkRhloSIadZyTsGr93Zs63y17VF8bt3vbpt4
	 42/L7SmQ6Y/KcKG9W0PS6wffvrju/WEy2I23gfLVD19PbYIAiSpgf3tJCtRFK/gJlGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckQxbgmH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE0606A320
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckQxbgmH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42E61F000C6;
	Thu, 22 Oct 2026 07:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655440;
	bh=29hCI2hFiGKU5Gw0Z81Jew8ydon365NqWbnTDnRUMgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ckQxbgmHMTv+gBQCFkIyME+EW/CkskZta3nRDUjHlidT5qNwbiQEmSJ1HmhKUDY/W
	 K9afRZ0YztTaDJFTtPH7cZtrGcC6w1tpOX+hQFCjvbIi0S5iIrv8bIQILNEpfkR3ej
	 3sMYXWT6mpcEgebFb92SjvMjRshRJq2C1/eDCtf0bWBOLgyUxEVyMm9iSqo9eCcm9/
	 yRvwkm/qOTI8JRElrmb1eP7Gbg4mw6vzlla/DQvIHaHlu9ZIVj1sGTP7ccOWcl7lNL
	 zDcgbPSQX4dgFLlRxooaoVz7WWRH4VxpY4UpxixlDjzm9MwWu/OLrxLIg785T3Y82K
	 W0RsWJTyno+WA==
Message-ID: <sashiko-outbox-181141@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 5/7] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <595385b672b5411849d1defc78b68b25a908a77a.1792565282.git.mst@redhat.com>
References: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
 <595385b672b5411849d1defc78b68b25a908a77a.1792565282.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 07:50:39 +0000
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
- [High] net: RCU violation reading dev_net() in virtio_net_hdr_validate_di=
sabled()
--

commit 69b1f5f4a234fc132ca5965bd53c81fd86975566
Author: Michael S. Tsirkin <mst@redhat.com>

net: add a sysctl to opt out of virtio net hdr checksum validation

This commit adds a per-netns sysctl, net.core.virtio_net_hdr_validate,
guarded by a static key to allow opting out of virtio_net_hdr checksum
offset validation.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index ec6f47ce1c974..b3bbecbd023cb 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
[ ... ]
> @@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struc=
t sk_buff *skb,
>  	*thoff =3D nhoff + iph->ihl * sizeof(u32);
>  	return iph;
>  }
> +/* Defined in net/core/dev.c, enabled while any network namespace
> + * has net.core.virtio_net_hdr_validate set to 0.
> + */
> +DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_validate_disabled_key);
> +
> +/* Failsafe: a namespace can disable the check with
> + * net.core.virtio_net_hdr_validate.
> + */
> +static inline bool virtio_net_hdr_validate_disabled(struct sk_buff *skb)
> +{
> +	return static_branch_unlikely(&virtio_net_hdr_validate_disabled_key) &&
> +	       !READ_ONCE(dev_net(skb->dev)->core.sysctl_virtio_net_hdr_validat=
e);
> +}

[Severity: High]
Does virtio_net_hdr_validate_disabled() need RCU read-side protection when
fetching dev_net(skb->dev) and reading core.sysctl_virtio_net_hdr_validate?

When net.core.virtio_net_hdr_validate is set to 0 in any network namespace
(enabling virtio_net_hdr_validate_disabled_key), several callers of
virtio_net_hdr_to_skb() and virtio_net_hdr_tnl_to_skb() invoke
virtio_net_hdr_validate_disabled(skb) from preemptible process context while
holding only dev_hold(skb->dev) and without holding rcu_read_lock().

Specifically, tun_get_user() calls tun_vnet_hdr_tnl_to_skb() ->
virtio_net_hdr_tnl_to_skb() before acquiring rcu_read_lock():

drivers/net/tun.c:tun_get_user() {
	...
	err =3D tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
	if (err < 0) {
		atomic_long_inc(&tun->rx_frame_errors);
		err =3D -EINVAL;
		goto free_skb;
	}
	...
	rcu_read_lock();
	if (unlikely(!(tun->dev->flags & IFF_UP))) {
	...
}

Similarly, tpacket_snd() and packet_snd() in net/packet/af_packet.c call
virtio_net_hdr_to_skb() in process context without rcu_read_lock():

net/packet/af_packet.c:tpacket_snd() {
	...
	if (has_vnet_hdr) {
		if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
			tp_len =3D -EINVAL;
			goto tpacket_error;
		}
	}
	...
}

net/packet/af_packet.c:packet_snd() {
	...
	if (vnet_hdr_sz) {
		err =3D virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
		if (err < 0)
			goto out_free;
		len +=3D vnet_hdr_sz;
	}
	...
}

Holding dev_hold(skb->dev) does not prevent __dev_change_net_namespace() fr=
om
moving skb->dev to another network namespace via dev_net_set(dev, net). If =
the
old network namespace then exits and is freed via cleanup_net(), a task
preempted after loading skb->dev->nd_net.net outside rcu_read_lock() could
dereference a freed struct net.

Should virtio_net_hdr_validate_disabled() use dev_net_rcu(skb->dev) inside
rcu_read_lock() and rcu_read_unlock(), similar to how commit afec62cd0a4191
("flow_dissector: use RCU protection to fetch dev_net()") fixed the same
pattern in __skb_flow_dissect()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v4.git.mst@re=
dhat.com?part=3D5
