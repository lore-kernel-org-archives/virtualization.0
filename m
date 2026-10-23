Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760348;
	b=F+pmWAJbXjohhnpJsDHWzZ35saqGgrXXI0q3DrannvATsuaTut0LDbI8UV6Npzpi/d/j
	 daA1psCk4q4U/w6PWlMEvIl9pY11IU1/VKXaWk6XprEzZmQmk43h1RJDLCcjK4iNcsbbL
	 +7dgzcUUpJQdttGoCA7FiSvY9w9I0ilUDa3sx71FtZj2Rh8OlRCDw1hZ13bnTlz2TthyW
	 30A+UBsk2W4ih9zDiAtxzaYuVNoTL2i9g9gzamvS60afP3tRYzbCj1MOrwW1Wbv2bSOod
	 dncda+i6HzPKSSx6EhUi6GFZ5ZTiMBy6mu4F0iOIbeCl7JjSP44Bh1xpfJJwtotHxHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760348;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Oo84pqGcqMw+aG+kxw0xJKzmItLg4N4OFJC2ATBBuhI=;
	b=yfUOFwXmIPDI9ukCiTkd6YN4EXuKWm8odC/+sj2BH8S3iSa8T3AUpsoBh29i4J/a1SfZ
	 FT8MUqign6SuKYsNH2c1fIyzBjWnoA2xXCmbhAGFm/WN0sTq50nH3zrswZ5VOQsUaVFhn
	 rjvuIIGpZdwFpJZJyGJXf3AnlQwQIY+qHGko2zvNUNiz165WY/SiWlZ7LuP6HQbSAPnsg
	 01SNx9BZ1+7lL4KraVmjYz3jPiCEwQGkT95D+p/bsucN5GK/TcnLba/LE8LlRVFL0zyGP
	 WDjMQTslG04kobARL7ziImGKedb8fngpUz3IV540RMrGWIhP+bZ6cjRjx2mZldVBunw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6jaA9+j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291E606A31D
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6jaA9+j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97721F01828;
	Fri, 23 Oct 2026 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760348;
	bh=Oo84pqGcqMw+aG+kxw0xJKzmItLg4N4OFJC2ATBBuhI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y6jaA9+juS2vLbyi+JZnAxrLtOAlzyPwSPvzT1WcWXZI87rx2sWlYGGct00f3i5Ik
	 HxX5FStk19TZrDSiqnJpglVusZmCJz9vtNavHLHteorLLThkw0qRKz6bE+c2h2Lm4/
	 jcmxgpGorjgfwbGIxO2WIK+PkJzvFH4yhbTdd7DcyySMVLsogx2R12YpbC4vwUV9eB
	 jxWTQM6H5vQJNY+Ojq7DtT7knqYw34xNlu3MDwFlqvgwZ1ucAr8LFiXax+1f4A1VE0
	 56DfIkB1kYvCD+VxdjfFNjqC/p1ytsZdAN3CICE4cXE4QKOerG2j+ALXDiCYOUaoyD
	 A94Hw1T5Pb22Q==
Message-ID: <sashiko-outbox-182806@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 5/7] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <2beba4c8b84c811120b6100bcccd8b90e7458787.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <2beba4c8b84c811120b6100bcccd8b90e7458787.1792668082.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:59:07 +0000
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
- [High] net: use-after-free in virtio_net_hdr_validate_disabled() due to m=
issing RCU
--

commit 50d6e871df0af42e23190bbc8209691b9cfd76e4
Author: Michael S. Tsirkin <mst@redhat.com>

net: add a sysctl to opt out of virtio net hdr checksum validation

This commit adds a per-netns sysctl, net.core.virtio_net_hdr_validate,
guarded by a static key to allow network namespaces to opt out of virtio
net header checksum validation on ingress.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 52852a33a2db7..cea70ccf0ed4b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -5,6 +5,7 @@
>  #include <linux/if_vlan.h>
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
> +#include <linux/jump_label.h>
>  #include <linux/netdevice.h>
>  #include <linux/udp.h>
>  #include <net/gso.h>
> @@ -78,6 +79,20 @@ static inline struct iphdr *virtio_net_ip4_parse(struc=
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
> + * The caller must keep the netns of skb->dev alive.
> + */
> +static inline bool virtio_net_hdr_validate_disabled(struct sk_buff *skb)
> +{
> +	return static_branch_unlikely(&virtio_net_hdr_validate_disabled_key) &&
> +	       !READ_ONCE(dev_net(skb->dev)->core.sysctl_virtio_net_hdr_validat=
e);
> +}

[Severity: High]
Can dereferencing dev_net(skb->dev) here without rcu_read_lock() and
dev_net_rcu() cause a use-after-free on struct net when
virtio_net_hdr_validate_disabled_key is enabled?

Callers such as tun_get_user() in drivers/net/tun.c, as well as
tpacket_snd() and packet_snd() in net/packet/af_packet.c, invoke
virtio_net_hdr_tnl_to_skb() or virtio_net_hdr_to_skb() from preemptible
process context without holding rcu_read_lock() or rtnl_lock():

drivers/net/tun.c:tun_get_user() {
    ...
    err =3D tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
    ...
}

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

In these paths, the caller only holds dev_hold(skb->dev) and a reference
to the socket's netns via sock_net(sk). However, struct net_device does
not hold a reference to its struct net, and skb->dev may reside in a
different network namespace from sock_net(sk) (for instance, when a tun
device or target net_device has been moved to another namespace).

Because __dev_change_net_namespace() in net/core/dev.c switches
dev->nd_net via dev_net_set(dev, net) without waiting for existing
dev_hold(dev) references to drop (synchronizing only via
synchronize_net() and rcu_barrier()), a preempted task in tun_get_user(),
tpacket_snd(), or packet_snd() can load dev_net(skb->dev) just before the
device is moved out and that network namespace is destroyed via
cleanup_net() -> net_complete_free(), and then dereference the freed
struct net upon resuming.

For comparison, __skb_flow_dissect() in net/core/flow_dissector.c (which
is called from __virtio_net_hdr_to_skb() in the same paths) takes
rcu_read_lock() and uses dev_net_rcu(skb->dev) (since commit afec62cd0a41).

Should virtio_net_hdr_validate_disabled() likewise guard the lookup with
rcu_read_lock() / rcu_read_unlock() (or scoped_guard(rcu)) and use
dev_net_rcu(skb->dev)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v5.git.mst@re=
dhat.com?part=3D5
