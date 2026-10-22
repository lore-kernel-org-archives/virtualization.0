Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655437;
	b=LAixWIQWp0j6ZvrVBCNLrkzB7sFRMtze9mBk2bmaTqbi08q6Y26z2g51YkU6oC0m+3yh
	 ru2c/wwYWL4h8MjLXhDjXGrY8ZU0W2OkbHqCfPtDcm1UMlwGo60LZ0oCR+bcHeX0ssPzg
	 VHp1uj5lMIt7Ya8dX7+glqWvKC/c6QtMjgq7rV+hJsjxjTXUlK0LHLGDKcZLgFilgFpJF
	 tXpZh9btyrSfGCWf8vDV2D821XCSJF4dYDA4LiFB+D+QDuQj/sUfcDHfZfXRzIPcpla/1
	 R6r6P9WUMNa8b/zjoWKRkwL1jTAolPviSJkHzb5CjY3BmpxjhUQnGkbkFggFzgCZt5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655437;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IkxIf72StREkY4Lc7NlxFsZR6i9857ykS02oLwG8rlw=;
	b=gHgz0Tb5GORmhkdmIrClRt0oB+/Mo8NrIj+8RVTnTkDkY4uJ+x+ifzNHnruF0xbJFk8I
	 xO1ZJQ8n2iu4cJtL+e9i5JxuQFW8ldr38E8PDOF+fc4ZjKeMcTast5t7NMxW9QWu+4aCk
	 7b7kM5X3Zvb3YIKSXLDKl5MnlzHNr6VtsB3NGWjDCOT01tgkxcdpqkpcnscICfqLGZe9g
	 yQARJacCN/EHzSZiEdn4dPe7uEOkV0pO8ynG1khBqWgKY+1Yy8OdW/YygHK1Ch6zk20n9
	 a4i+dHODMPADv4DbSwCsDtWE4W2p3AV1je8U+B1elY/dHP7VIUCdRhqZaGfFHf/TEog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAKumvGv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFE4606A326
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cAKumvGv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FC01F000C5;
	Thu, 22 Oct 2026 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792655437;
	bh=IkxIf72StREkY4Lc7NlxFsZR6i9857ykS02oLwG8rlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cAKumvGvy0aPBKjn5aFNvQaVS/Sj634QaGe8WsEWxRALr1YCYO1YzM1lfRYrj7S9d
	 Eo7XIwN/beRddnouwauqK4RAUcSq3LL39JA80t8fT32i/bIgksffgJWrGSXNRGiidN
	 tXQV9/rdTsfp+AoazhPQChc6IlSJMS14LgZxy/dBiBDOkYfngq0MltT8t7dlVyAId7
	 etf7ZXn5JyuGmL29CiYzrIzKsx5Rijbk5ecpaVeJCEJi0ugeqzadacOXgKxhLXdKxN
	 16xRgb/1zX0XRZk4Uk6sXtfWR24HP2MwEc3KMKXLm1fNjdFH58BxZxC9MIdLSt/gL0
	 UOT2H45A9RBZw==
Message-ID: <sashiko-outbox-181137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 1/7] net: account for ingress-resolved virtio net
 hdr state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
References: <cover.v4.git.mst@redhat.com>
 <be251d104f881a309cfef150455efa128ebb101d.1792565282.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 07:50:36 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] virtio_net: duplicate rx_ prefix for rx_csum_sw in virtnet_rq_st=
ats_desc
- [Medium] net: live ethtool_ops overwritten in ipvtap_newlink() and macvta=
p_newlink()
--

commit aec871fb755137e08ae8b9205b5e122143828b6d
Author: Michael S. Tsirkin <mst@redhat.com>

net: account for ingress-resolved virtio net hdr state

This commit updates callers of virtio_net_hdr_to_skb() and
virtio_net_hdr_tnl_to_skb() to check only for negative return values as
errors, and adds an rx_csum_sw ethtool statistic to tun, tap (ipvtap and
macvtap), and virtio_net to count packets requiring software checksum
resolution at ingress.

> diff --git a/drivers/net/ipvlan/ipvtap.c b/drivers/net/ipvlan/ipvtap.c
> index 66c949d942610..9e2f1c7073d2a 100644
> --- a/drivers/net/ipvlan/ipvtap.c
> +++ b/drivers/net/ipvlan/ipvtap.c
[ ... ]
> +/* checkpatch warns but this can't be const: cloned from ipvlan's
> + * ops at newlink time, with the statistics above added.
> + */
> +static struct ethtool_ops ipvtap_ethtool_ops;
> +
>  static int ipvtap_newlink(struct net_device *dev,
>  			  struct rtnl_newlink_params *params,
>  			  struct netlink_ext_ack *extack)
> @@ -91,6 +118,15 @@ static int ipvtap_newlink(struct net_device *dev,
>  	vlantap->tap.update_features =3D	ipvtap_update_features;
>  	vlantap->tap.count_rx_dropped =3D ipvtap_count_rx_dropped;
> =20
> +	/* ipvlan's ethtool ops are already installed at this point;
> +	 * clone them and add the tap statistics on top.
> +	 */
> +	ipvtap_ethtool_ops =3D *dev->ethtool_ops;
> +	ipvtap_ethtool_ops.get_sset_count =3D ipvtap_get_sset_count;
> +	ipvtap_ethtool_ops.get_strings =3D ipvtap_get_strings;
> +	ipvtap_ethtool_ops.get_ethtool_stats =3D ipvtap_get_ethtool_stats;
> +	dev->ethtool_ops =3D &ipvtap_ethtool_ops;
[ ... ]
> diff --git a/drivers/net/macvtap.c b/drivers/net/macvtap.c
> index cc975dfb73805..3288cc6ae6c20 100644
> --- a/drivers/net/macvtap.c
> +++ b/drivers/net/macvtap.c
[ ... ]
> +/* checkpatch warns but this can't be const: cloned from macvlan's
> + * ops at newlink time, with the statistics above added.
> + */
> +static struct ethtool_ops macvtap_ethtool_ops;
> +
>  static int macvtap_newlink(struct net_device *dev,
>  			   struct rtnl_newlink_params *params,
>  			   struct netlink_ext_ack *extack)
> @@ -99,6 +126,15 @@ static int macvtap_newlink(struct net_device *dev,
>  	vlantap->tap.count_rx_dropped =3D macvtap_count_rx_dropped;
>  	vlantap->tap.update_features  =3D macvtap_update_features;
> =20
> +	/* macvlan's ethtool ops are already installed at this point;
> +	 * clone them and add the tap statistics on top.
> +	 */
> +	macvtap_ethtool_ops =3D *dev->ethtool_ops;
> +	macvtap_ethtool_ops.get_sset_count =3D macvtap_get_sset_count;
> +	macvtap_ethtool_ops.get_strings =3D macvtap_get_strings;
> +	macvtap_ethtool_ops.get_ethtool_stats =3D macvtap_get_ethtool_stats;
> +	dev->ethtool_ops =3D &macvtap_ethtool_ops;

[Severity: Medium]
Can overwriting the shared global ipvtap_ethtool_ops in
drivers/net/ipvlan/ipvtap.c:ipvtap_newlink() and macvtap_ethtool_ops in
drivers/net/macvtap.c:macvtap_newlink() race with concurrent readers on
already-registered devices?

When the first ipvtap or macvtap interface is created and registered, its
dev->ethtool_ops points to the shared static ipvtap_ethtool_ops or
macvtap_ethtool_ops structure.

When a second ipvtap or macvtap interface is created via
rtnl_newlink_create(), ipvtap_setup() or macvtap_setup() first sets the new
device's dev->ethtool_ops to &ipvlan_ethtool_ops or &macvlan_ethtool_ops
(where get_sset_count, get_strings, and get_ethtool_stats are null). Then
ipvtap_newlink() or macvtap_newlink() copies *dev->ethtool_ops over the
shared global ipvtap_ethtool_ops or macvtap_ethtool_ops structure in-place
before restoring the three statistics callbacks.

Meanwhile, several paths read dev->ethtool_ops on the first registered
interface without holding rtnl_lock():

net/ethtool/common.c:__ethtool_get_ts_info() {
    ...
    const struct ethtool_ops *ops =3D dev->ethtool_ops;
    struct phy_device *phydev =3D dev->phydev;
    ...
    } else if (ops->get_ts_info) {
        err =3D ops->get_ts_info(dev, info);
    ...
}

which is called under rcu_read_lock() from
sock_timestamping_bind_phc()->ethtool_get_phc_vclocks(), as well as
net/ethtool/netlink.c:ethnl_default_set_doit() calling ops->set_validate()
before acquiring rtnl_lock(), and net/core/net-sysfs.c:speed_show() and
duplex_show() reading netdev->ethtool_ops->get_link_ksettings before
sysfs_rtnl_lock().

Could ipvtap_ethtool_ops and macvtap_ethtool_ops be initialized once at
module init time (for example in ipvtap_init() and macvtap_init()) instead
of being mutated on each newlink call?

[ ... ]
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index daab43ac92ce4..b0441bf8e8750 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -125,6 +125,7 @@ struct virtnet_rq_stats {
>  	u64_stats_t packets;
>  	u64_stats_t bytes;
>  	u64_stats_t drops;
> +	u64_stats_t rx_csum_sw;
>  	u64_stats_t xdp_packets;
>  	u64_stats_t xdp_tx;
>  	u64_stats_t xdp_redirects;
> @@ -158,6 +159,7 @@ static const struct virtnet_stat_desc virtnet_sq_stat=
s_desc[] =3D {
> =20
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc[] =3D {
>  	VIRTNET_RQ_STAT("drops",         drops),
> +	VIRTNET_RQ_STAT("rx_csum_sw",    rx_csum_sw),
>  	VIRTNET_RQ_STAT("xdp_packets",   xdp_packets),
>  	VIRTNET_RQ_STAT("xdp_tx",        xdp_tx),
>  	VIRTNET_RQ_STAT("xdp_redirects", xdp_redirects),

[Severity: Medium]
Will defining the descriptor string as "rx_csum_sw" in
drivers/net/virtio_net.c:virtnet_rq_stats_desc cause ethtool -S to report a
duplicated "rx_" prefix?

When userspace queries ethtool -S strings via
virtnet_get_strings()->virtnet_get_stats_string()->virtnet_stats_sprintf(),
virtnet_get_stats_string() automatically prepends "rx_" and "rx%u_" to every
entry in virtnet_rq_stats_desc:

drivers/net/virtio_net.c:virtnet_get_stats_string() {
    ...
    if (type =3D=3D VIRTNET_Q_TYPE_RX) {
        fmt =3D "rx%u_%s";
        noq_fmt =3D "rx_%s";

        desc =3D &virtnet_rq_stats_desc[0];
        num =3D ARRAY_SIZE(virtnet_rq_stats_desc);

        virtnet_stats_sprintf(&p, fmt, noq_fmt, num, qid, desc);
    ...
}

Because of this formatting, "rx_csum_sw" becomes "rx_rx_csum_sw" for the
device total and "rx0_rx_csum_sw" for the per-queue counters. Should the
descriptor string in virtnet_rq_stats_desc be "csum_sw" to match the other
entries and produce "rx_csum_sw"?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v4.git.mst@re=
dhat.com?part=3D1
