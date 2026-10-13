Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCC5237A0;
	Tue, 13 Oct 2026 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913522; cv=none; b=Zjzj5XP/Bi+MexVJAzHKp9NBOlNzxbrP1WxKDKjZsN27+fbNEVLBClNU9/JDuYoVZW8ZNs10lB/wXJPPYJRaNg7Gtt2WVNFL+xLb4S+H+0RQmlUFDrnaMYtgnXzKqKqYaT1lZeuSERBjok3q2U0wIHygQsifzSrWsU8iaUOqtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913522; c=relaxed/simple;
	bh=p5DPt1tyZLtZ+t/bdYrpAcewBNHXKLNzU6oJURXvvf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jcC4JzSkRZi5Xjfpk6bYos+3zeNKZjn/FtrWffTWBC9U9gsxsBvxLUFFxBvWrSVjIv9eBFALbV8ehzgH6DMxbAWswLsQfRT1VAKRmlNKhkRhYBlZmKiLs+gHGKXU72kv0tteUU1t7ca6ywtKHUDMhsUPuABr8NfOVC3swOMA4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0ERxBgQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0ERxBgQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4056F1F000FF;
	Tue, 13 Oct 2026 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791913520;
	bh=EZ8pT6DerGQH6d0mit/8gGehpxCI2EzGbWaj8hrpSXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=P0ERxBgQpi+sNTIBymfyOhDh6LcRg4tetfLGo1VDiSiMcyQ/roI+RgAk0iZgw9Y3g
	 lRl+7mGEXamNtgNnmWr2jW/xnKTgixgUq7GEnHyKS/Eq+7VATzzNuecZXojC3cOWmO
	 LBVywKmTIunCuM/Yn/+DQC1lFOE+94K23y+dBnjSIunwg6ij2E9R3N0Rt0hlnD7+os
	 L7Xp1Wgze9l9Zt2lAMCWb9O/QjVpG7sfwdTe8IXVtLZacAoy/at/cXKIxBEfFiIY9Z
	 5iHc+f7nsSa12Xrpjl3PKrzAuOmNGVYX75q1bkMot+ZQMwnv3O6gqFutNkOD27EuW4
	 R8f45TBRjZOQw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang
 <jasowangio@gmail.com>, Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, Max Krasnyansky
 <maxk@qualcomm.com>, Rusty Russell <rusty@rustcorp.com.au>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next 4/4] net: account for ingress-resolved virtio
 net hdr state
In-Reply-To: <d82518764906d3b552fd3ade65b96ac741197d4e.1791887415.git.mst@redhat.com>
References: <cover.1791887415.git.mst@redhat.com>
 <d82518764906d3b552fd3ade65b96ac741197d4e.1791887415.git.mst@redhat.com>
Date: Tue, 13 Oct 2026 19:45:17 +0200
Message-ID: <87ld81a40i.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Ingress resolution of uncommon virtio net hdr checksum metadata
> (software checksum completion at ingress) adds performance overhead but
> is currently invisible: no counter tracks it, so a hypothetical workload
> relying on uncommon metadata cannot be distinguished from none at all,
> and packets quietly pay the host-CPU checksum overhead instead of offload.
>
> Have virtio_net_hdr_to_skb() return 1 when it completes an uncommon
> checksum in software, and flip every converter call site to test for
> negative errno.  Have tun count these events per device as
> rx_csum_sw and expose the counter via ethtool -S.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Assisted-by: LLM
> Fixes: f43798c27684 ("tun: Allow GSO using virtio_net_hdr")
>
> ---
>  drivers/net/tap.c          |  4 ++--
>  drivers/net/tun.c          | 44 ++++++++++++++++++++++++++++++++++++--
>  drivers/net/virtio_net.c   |  2 +-
>  include/linux/virtio_net.h | 12 +++++++++--
>  net/packet/af_packet.c     |  4 ++--
>  5 files changed, 57 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index ff67d99deb39e..73e8833944463 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void=
 *msg_control,
>=20=20
>  	if (vnet_hdr_len) {
>  		err =3D tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
> -		if (err) {
> +		if (err < 0) {
>  			rcu_read_unlock();
>  			drop_reason =3D SKB_DROP_REASON_DEV_HDR;
>  			goto err_kfree;
> @@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, st=
ruct xdp_buff *xdp)
>=20=20
>  	if (vnet_hdr_len) {
>  		err =3D tun_vnet_hdr_to_skb(q->flags, skb, gso);
> -		if (err) {
> +		if (err < 0) {
>  			rcu_read_unlock();
>  			goto err_kfree;
>  		}
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 242899f7fd071..138ca8987dfc6 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -210,6 +210,7 @@ struct tun_struct {
>  	u32 flow_count;
>  	u32 rx_batched;
>  	atomic_long_t rx_frame_errors;
> +	atomic_long_t rx_csum_sw;
>  	struct bpf_prog __rcu *xdp_prog;
>  	struct tun_prog __rcu *steering_prog;
>  	struct tun_prog __rcu *filter_prog;
> @@ -1935,11 +1936,19 @@ static ssize_t tun_get_user(struct tun_struct *tu=
n, struct tun_file *tfile,
>  		break;
>  	}
>=20=20
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> +	err =3D tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
> +	if (err < 0) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err =3D -EINVAL;
>  		goto free_skb;
>  	}
> +	if (err > 0)
> +		atomic_long_inc(&tun->rx_csum_sw);
> +	/* The status is consumed: keep err clear so later exit paths
> +	 * (XDP drop via unlock_frags) do not return it to write() as
> +	 * a short count.
> +	 */
> +	err =3D 0;
>=20=20
>  	if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
>  		skb->protocol =3D eth_type_trans(skb, tun->dev);
> @@ -2605,12 +2614,15 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	tnl_hdr =3D (struct virtio_net_hdr_v1_hash_tunnel *)gso;
>  	skb->dev =3D tun->dev;
>  	skb_set_network_header(skb, ETH_HLEN);
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> +	ret =3D tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
> +	if (ret < 0) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> +	if (ret > 0)
> +		atomic_long_inc(&tun->rx_csum_sw);
>=20=20
>  	skb->protocol =3D eth_type_trans(skb, tun->dev);
>  	skb_reset_network_header(skb);
> @@ -3739,7 +3751,35 @@ static void tun_get_channels(struct net_device *de=
v,
>  	channels->max_combined =3D tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUE=
S : 1;
>  }
>=20=20
> +#define TUN_STATS_LEN	1
> +static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] =
=3D {
> +	"rx_csum_sw",
> +};
> +
> +static int tun_get_sset_count(struct net_device *dev, int sset)
> +{
> +	return sset =3D=3D ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
> +}
> +
> +static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *d=
ata)
> +{
> +	if (stringset =3D=3D ETH_SS_STATS)
> +		memcpy(data, tun_ethtool_strings,
> +		       sizeof(tun_ethtool_strings));
> +}
> +
> +static void tun_get_ethtool_stats(struct net_device *dev,
> +				  struct ethtool_stats *stats, u64 *data)
> +{
> +	struct tun_struct *tun =3D netdev_priv(dev);
> +
> +	data[0] =3D atomic_long_read(&tun->rx_csum_sw);
> +}
> +
>  static const struct ethtool_ops tun_ethtool_ops =3D {
> +	.get_sset_count		=3D tun_get_sset_count,
> +	.get_strings		=3D tun_get_strings,
> +	.get_ethtool_stats	=3D tun_get_ethtool_stats,
>  	.supported_coalesce_params =3D ETHTOOL_COALESCE_RX_MAX_FRAMES,
>  	.get_drvinfo	=3D tun_get_drvinfo,
>  	.get_msglevel	=3D tun_get_msglevel,
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index daab43ac92ce4..2e6fd81df9c41 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_inf=
o *vi, struct receive_queue *
>  	skb_set_network_header(skb, ETH_HLEN);
>  	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
>  				      vi->rx_tnl_csum,
> -				      virtio_is_little_endian(vi->vdev))) {
> +				      virtio_is_little_endian(vi->vdev)) < 0) {
>  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel=
 %d tnl csum %d\n",
>  				     dev->name, hdr->hdr.gso_type,
>  				     hdr->hdr.gso_size, hdr->hdr.flags,
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index b181183118b3a..d8447db58ac83 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -14,6 +14,14 @@
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
>=20=20
> +/*
> + * virtio_net_hdr_to_skb() and virtio_net_hdr_tnl_to_skb() return 0 on
> + * success and a negative errno on failure.  On success they may also
> + * return 1, indicating that an uncommon checksum was completed in
> + * software at ingress rather than deferred to the egress path;
> + * drivers can use this to account for such packets.
> + */
> +
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_=
type)
>  {
>  	switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
> @@ -292,7 +300,7 @@ static inline int __virtio_net_hdr_to_skb(struct sk_b=
uff *skb,
>=20=20
>  		err =3D skb_checksum_help(skb);
>  		skb->transport_header =3D old_transport;
> -		return err;
> +		return err ?: 1;
>  	}
>=20=20
>  	return 0;
> @@ -441,7 +449,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	/* Let the basic parsing deal with plain GSO features. */
>  	ret =3D __virtio_net_hdr_to_skb(skb, hdr, true,
>  				      hdr->gso_type & ~gso_tunnel_type, false);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>=20=20
>  	/* In case of USO, the inner protocol is still unknown and
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 52ae3d875e971..e6aec9ecfa994 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, stru=
ct msghdr *msg)
>  		}
>=20=20
>  		if (has_vnet_hdr) {
> -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
> +			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {

nit: I don't know if we care, but this sort of breaks bisectability.
Previous patch does return ret ?: 1, but it's this patch that does the
if-statement fixup. (Same for tun/tap... ^^^)


Bj=C3=B6rn
