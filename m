Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BA56B173;
	Mon, 19 Oct 2026 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419562; cv=none; b=h2uIFjkWpHowyHCykkug8gFVVbfyn8Ch1fwb9JTNWiuH80UxJidf5cwWpjb6qofUKzV5Q73phKoUnVn9hlBZArfgd4xGf0ZjvWqXTVPM7ofT3TU/87pRJtA92raapovhRhCYK6BrNi/zu7LTeEXmya7QzMCd0WGAu/eK8p87ETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419562; c=relaxed/simple;
	bh=vNer47S+PeGA2Fvip2xaxnWdPMknDqU+FBXeCJHDInQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mQRjztU5fGJ0ElB6s21NmGKywu+IzPAcFGTJxIH/qrfqcjmu5qUhgt8LcQ3+gk/OU7ylaDCczqPkTRLdTLhb+FgWuWyD57nsUi22n48tHZChwiwgbIcUxUOg18CKe3yN27uhLShRtx0kIU2nFhiGM9nnnQFrE/UaMAuqMJx41P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ87Hkzt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ87Hkzt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C601F000C4;
	Mon, 19 Oct 2026 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419559;
	bh=IPq9Xe39/FVrOQSDMLIgWdTOrEK75lghbq9l8sOgve4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=KZ87HkztFOcYbN+OmVz9qsPSIPwKV8qcqYfaoakfB9xxOSOtB9H5aDxdLMi2dJFA1
	 bybDR5lTU1Kils6V81z027WaddmDXCBfWu4zox1l9Xg7kyH+xwccWjHE2Fp4jnXhmc
	 2WGkOQU1bTZOauQ1m6pLdIPwEFaKF3PETWkQYw7kK74ib1/b1ZSCh2vA1AFU9pEnwa
	 tIj3XNLDFKT7YEWPZ3gglFBQuoAl0bcjXA0Ra/kUnnXARqXdh1PMaWafPBNsilPf4z
	 GuqsgtoONIx17v0iROQOFkPfbk9Dgb3iLOewWfNU+XpuOiidnMQ57pNMQuW/D5c4le
	 xgc0fI3w4qZLQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Chris Arges
 <carges@cloudflare.com>, Phil Sutter <phil@nwl.cc>, Jason Wang
 <jasowangio@gmail.com>, Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, Max Krasnyansky
 <maxk@qualcomm.com>, Rusty Russell <rusty@rustcorp.com.au>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
In-Reply-To: <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
Date: Mon, 19 Oct 2026 16:19:16 +0200
Message-ID: <87fqy13h97.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Michael S. Tsirkin" <mst@redhat.com> writes:

> The ingress validation as implemented by the previous
> patch is stricter than what it replaced: GSO
> packets whose checksum metadata matches no transport header are
> dropped, and non-GSO ones get their checksum completed in place.
> Such packets used to pass with the metadata unvalidated,
> and with no overhead.
>
> I judge that this should not affect any deployments, but there is still
> some risk that it does.  In case a deployment depends on them anyway,
> provide a per-netns switch to get the old behavior back:
>
> echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
>
> The default is validating.
>
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
>  include/linux/virtio_net.h               | 23 +++++++++
>  include/net/netns/core.h                 |  1 +
>  net/core/dev.c                           |  6 +++
>  net/core/net_namespace.c                 |  1 +
>  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
>  6 files changed, 110 insertions(+)
>
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/adm=
in-guide/sysctl/net.rst
> index e586e17fc7a5..b1a1c4714b22 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMES=
TAMPING_OPT_TSONLY is set.
>  Default: 1 (on)
>=20=20
>=20=20
> +virtio_net_hdr_csum_check
> +-------------------------
> +
> +When processing packets with a virtio net header (through tun, tap, a
> +packet socket or a virtio network device) that request checksum offload
> +(VIRTIO_NET_HDR_F_NEEDS_CSUM), validate the packet: complete the checksum
> +in software, or drop the packet where the header does not match it.
> +
> +When disabled, the header is trusted not to corrupt the packet, and the
> +checksum is offloaded to hardware (or not verified if it never reaches
> +hardware). This is only safe if no protocol is processing the packets.
> +
> +The setting is per network namespace, but only writable by the host
> +root: root inside a network namespace created by an unprivileged user
> +cannot disable the validation.
> +
> +Default: 1 (on)
> +
> +
>  wmem_default
>  ------------
>=20=20
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 97b554ef7123..25aa95c11e31 100644
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
> @@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struc=
t sk_buff *skb,
>  	*thoff =3D nhoff + iph->ihl * sizeof(u32);
>  	return iph;
>  }
> +/* Defined in net/core/dev.c, enabled while any network namespace
> + * has net.core.virtio_net_hdr_csum_check set to 0.
> + */
> +DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
> +
> +/* Failsafe: a namespace can disable the check with
> + * net.core.virtio_net_hdr_csum_check.
> + */
> +static inline bool virtio_net_hdr_csum_check_disabled(struct sk_buff *sk=
b)
> +{
> +	return static_branch_unlikely(&virtio_net_hdr_csum_check_disabled_key) =
&&
> +	       !READ_ONCE(dev_net(skb->dev)->core.sysctl_virtio_net_hdr_csum_ch=
eck);
> +}
>=20=20
>  /* Where does the L3 header start, and what protocol is it?
>   * Handles Ethernet and VLAN headers; other devices use the
> @@ -179,6 +193,12 @@ virtio_net_csum_partial_ok_at_offset(struct sk_buff =
*skb, u8 hdr_gso_type,
>  	unsigned int thoff;
>  	int ip_proto;
>=20=20
> +	/* Failsafe: a namespace opted out of the validation,
> +	 * trust the checksum metadata as before.
> +	 */
> +	if (virtio_net_hdr_csum_check_disabled(skb))
> +		return true;
> +
>  	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
>  		return false;
>=20=20
> @@ -516,6 +536,9 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool o=
uter_isv6,
>  	unsigned int thoff;
>  	int ip_proto;
>=20=20
> +	if (virtio_net_hdr_csum_check_disabled(skb))
> +		return true;
> +
>  	if (!virtio_net_l3_start(skb, &nhoff, &proto))
>  		return false;
>  	if (outer_isv6 !=3D (proto =3D=3D htons(ETH_P_IPV6)))
> diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> index 9ef3d70e5e9c..ae8110772c97 100644
> --- a/include/net/netns/core.h
> +++ b/include/net/netns/core.h
> @@ -18,6 +18,7 @@ struct netns_core {
>  	u8	sysctl_txrehash;
>  	u8	sysctl_tstamp_allow_data;
>  	u8	sysctl_bypass_prot_mem;
> +	u8	sysctl_virtio_net_hdr_csum_check;
>=20=20
>  #ifdef CONFIG_PROC_FS
>  	struct prot_inuse __percpu *prot_inuse;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360..d14950b1af3a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2389,6 +2389,12 @@ EXPORT_SYMBOL(tcf_sw_enabled_key);
>=20=20
>  DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
>  EXPORT_SYMBOL(netstamp_needed_key);
> +
> +/* Enabled while any network namespace has net.core.virtio_net_hdr_csum_=
check
> + * set to 0.
> + */
> +DEFINE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
> +EXPORT_SYMBOL(virtio_net_hdr_csum_check_disabled_key);
>  #ifdef CONFIG_JUMP_LABEL
>  static atomic_t netstamp_needed_deferred;
>  static atomic_t netstamp_wanted;
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index da5f881fbd3b..2d340fafba85 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -396,6 +396,7 @@ static __net_init void preinit_net_sysctl(struct net =
*net)
>  	net->core.sysctl_optmem_max =3D 128 * 1024;
>  	net->core.sysctl_txrehash =3D SOCK_TXREHASH_ENABLED;
>  	net->core.sysctl_tstamp_allow_data =3D 1;
> +	net->core.sysctl_virtio_net_hdr_csum_check =3D 1;
>  	net->core.sysctl_txq_reselection =3D msecs_to_jiffies(1000);
>  }
>=20=20
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index eb35da3556f4..c65ff86cc5f9 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/hex.h>
> +#include <linux/jump_label.h>
>=20=20
>  #include <net/ip.h>
>  #include <net/sock.h>
> @@ -678,6 +679,54 @@ static struct ctl_table net_core_table[] =3D {
>  	},
>  };
>=20=20
> +/* Defined in net/core/dev.c, declared for the gate in
> + * include/linux/virtio_net.h.
> + */
> +DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
> +
> +/*
> + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
> + */

nit: OCD doesn't like mixing old netdev comments with vanilla style...
one VVV as well.

> +static DEFINE_MUTEX(virtio_net_hdr_csum_check_mutex);
> +
> +static int virtio_net_hdr_csum_check_sysctl(const struct ctl_table *tabl=
e,
> +					    int write, void *buffer,
> +					    size_t *lenp, loff_t *ppos)
> +{
> +	struct net *net =3D (struct net *)table->data;
> +	/* checkpatch warns but this can't be const: tmp.data is set
> below */

nit: Redundant comment...

> +	struct ctl_table tmp =3D *table;

...and here, can't we instead get rid of tmp, and do something like:
    | u8 *value =3D table->data;
    | u8 old, new;

> +	u8 old;
> +	int ret;
> +
> +	/* Root in a user namespace must not be able to weaken the
> +	 * validation for the network namespace it controls.
> +	 */
> +	if (write && !capable(CAP_NET_ADMIN))
> +		return -EPERM;
> +
> +	/*
> +	 * Make sure virtio_net_hdr_csum_check_disabled_key counts zero values =
of
> +	 * net->core.sysctl_virtio_net_hdr_csum_check.
> +	 */
> +	mutex_lock(&virtio_net_hdr_csum_check_mutex);
> +
> +	old =3D net->core.sysctl_virtio_net_hdr_csum_check;
> +	tmp.data =3D &net->core.sysctl_virtio_net_hdr_csum_check;
> +	ret =3D proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
> +	if (write && !ret && old !=3D net->core.sysctl_virtio_net_hdr_csum_chec=
k) {

and then:
    | old =3D READ_ONCE(*value);
    | ret =3D proc_dou8vec_minmax(table, write, buffer, lenp, ppos);
    | new =3D READ_ONCE(*value);
    |=20
    | if (write && !ret && old !=3D new) {

at least that's easier to read for me. (No blocker!)


Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
