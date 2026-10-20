Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526066;
	b=lGt4/9npFRYbvw6u+BQYqjcrFINux0PETCa+55UUwMVs9HiBlS9V44dqDvYXuCSVqPXe
	 /oiQ0My/nUKYD8lUBG3gKjKs10CE6tJbiioNeHXJOO8ttmXjm1tR0i26lIYq64+6wj1Dy
	 HEAoouCBeYKsl4m4u6OEy+4iZYj6Gf60KjS0bJMRtvvI/GRHJqMGKbwJbXGAoADrqsEeJ
	 pnQcGWqTcMocqfVhUtsiGg+brhsZp5mgIngfp1NZYKiKnO8RYWJTDuAf+Ynh35PXmttmY
	 uTe3HXhZHLTnfkIQkZ8l//IVGLcTZ+SXJuymCeZ3N4aWWfOMG04VgdXgIKF0LdEbSVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526066;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ebglCY/ZB1YQw2ZhM9IbHrCYNuPN6uXDTRccYP7aKzc=;
	b=IfiMQHPetElIy3nfKzXv5dVBA2y/wfFuLyrF+qEau/32Y8Bp5zkpNJHBHDRAojq/2myy
	 R7k+MrFhePYJrdETKbIcdm2fBzI+5dnQgtkEE9PFDzpp//M28uxkjNk5sSryWPCSo+GTA
	 AFAdtg5POwqw4WGfb9L29NHmlwEvUS8egfWcL1ExbprVZ90YgTQ20mdr5bzdKD9n59XIA
	 wecHoCj6oUFVRKIkT0NNdSE9EukgkoqJyKS2f4gNBUSxjZatQxcw1fw3JoT4DrBL31Zd9
	 IbMZz+CXytYCkWaL0RQ/AjlMHky+/LlweEQHrjo5oyiWc3vzQeCh2lJgSEB/oZHQTxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="TlQ8q6/W";
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B70606A31C
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 19:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B70606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TlQ8q6/W
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7cbbb7b90efso15973137.2
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792526064; x=1793130864; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ebglCY/ZB1YQw2ZhM9IbHrCYNuPN6uXDTRccYP7aKzc=;
        b=TlQ8q6/WEF8SE6JLTc3wpwKw/NLCuJbvFVFlblw6RwuQXarwv/1Ul/H4u5eGXaycvx
         r+ms5gTN3UrYwujkBz+KAhwaZa6Wb0HWSLNhALdvIsN0WQ5pzcD7cGJRr0y/TE6pD3ON
         lAZ7NoR6AezYnAyo2yVvJtV7opBSUxZHYOpbaStml26C92zIr3C1pGIkVL8oQbkb/ZK0
         MOq5aj/lDiPZVYa3gk6ma0p/xznYhuxyPqHK9rWYiBQggPco6HeFaJsAWWHNtLUz2jED
         UOk78V6Pw1LqHoJw5ow1Ufpsdz5HT/eSxWJtLIoA4HmIaoqGRvQZme+6hL45+N2f0PHg
         bU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526064; x=1793130864;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ebglCY/ZB1YQw2ZhM9IbHrCYNuPN6uXDTRccYP7aKzc=;
        b=ZTgAAd7nIZiHhqjKMlw1uVr3Z1cXV0v/SzR2XSSzDHhCXkyhaT0oilznOPM0gmmri9
         DM/hnT7Hz/3xojjpnJtrsCDXk7KjFdO3eiyCg5nZp/WAGj/n9i1vneILOhkD5sEpWCe+
         VN58PGhNnIM4Noa9M5u3Yebxxj39R3G8jv2hXxxi+KWM5XVoRiTgRvQtOh9UjIKwU1em
         ygGMfPw7TLIwbCDY7MS5v/0iWSNCsESROjVDSZBVPl7RZdC8ENVdxRIAvLQyF7RFRiks
         0njA6KHQSoYfWANu6WSGWk8+CyY2lWzwZ5DLuQiAuQu1bbAt5ygARRg5tsz1jFKAHRtn
         m3Lg==
X-Forwarded-Encrypted: i=1; AKwUvBwjTmSoY38/URIBXosrSUDCUlIz2ctvrtp8kHYAJhHeQv8uyRvEXTiCwA3u3PInEnrl8Gi4u1JoyhTgZPJTuQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKF+bpuHzjumn3gt+yzzXccOK3//y/pl1VT/Xm5hu0z4QnXp3SY
	9nl7GZZtQnakO/oYMgdqP3FxCT+hG+T3DsIqrdOEwOxBZIZV8g5xKoEd
X-Gm-Gg: AYBFou1Gnp3VU7KbdkmI5yqpMNAeYOM4tmxNOUhu/wotlrUN9APzTv7QY8MgIfV7ydG
	IE5snmD9UzK4/iP9WMd392ZAue4V/5Xc+uTncWnXxu+oylodaEbti970YNyGcomJbOWjJsTWxVM
	WZOAZY1KUWUicQGr1R0fveD+5dV8RfZ+ghT271dYi/kg3SofZFTAqvF6/VmKQCSvtuyUSuggC9J
	R1CA8QWTJHVe57OFVZUZ/QYt1P+u1TsSSYw5UwkVnUVyMEV2kIxf/zGXIUfzddHzH7S6ZydhwdM
	xzXxVPLk6Aq+uWiiHb3sOD3aRwKprcCdo/ruLyxpeZjpdOBAqdofSkN6v1AsfALl0TzAwNQFlq7
	+f4Ldf5oYfnU0y5lONmMH0y/ZnM9PU6igAeI0mOcT++L6BTl+e/6p0NNOcim4jTsS2riEcSTOqU
	SoIH6T5hZujSuPwEc2uVWDAtm5mG/aC/dP3YFZ3pJCesLOb9ivdhu2oc2txK/sfVJ5gautVQ7g0
	7WQTeAmHemR6W//Mqt/4BbFdHGf7Ru3qFAUMLB41IpJ4lBSw1Q/mUg1jXORh71yJfQSMayLUM1X
	csOxS60OEC3ClLwO65sSrZE+8EPWem50/ANAmw==
X-Received: by 2002:a05:6102:2b85:b0:7cc:32da:56e with SMTP id ada2fe7eead31-7cc92682ea5mr63827137.19.1792526064321;
        Tue, 20 Oct 2026 12:54:24 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d104017bsm713027241.4.2026.10.20.12.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:54:23 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:54:23 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Chris Arges <carges@cloudflare.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Phil Sutter <phil@nwl.cc>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Rusty Russell <rusty@rustcorp.com.au>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Simon Horman <horms@kernel.org>, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.187d58ff2bce5@gmail.com>
In-Reply-To: <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net hdr
 checksum validation
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
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
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> index e586e17fc7a5..b1a1c4714b22 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
>  Default: 1 (on)
>  
>  
> +virtio_net_hdr_csum_check
> +-------------------------

virtio_net_hdr_validate? In case we do have to add more validation
later.

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
>  
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
> @@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
>  	*thoff = nhoff + iph->ihl * sizeof(u32);
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
> +static inline bool virtio_net_hdr_csum_check_disabled(struct sk_buff *skb)
> +{
> +	return static_branch_unlikely(&virtio_net_hdr_csum_check_disabled_key) &&
> +	       !READ_ONCE(dev_net(skb->dev)->core.sysctl_virtio_net_hdr_csum_check);
> +}
>  
>  /* Where does the L3 header start, and what protocol is it?
>   * Handles Ethernet and VLAN headers; other devices use the
> @@ -179,6 +193,12 @@ virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
>  	unsigned int thoff;
>  	int ip_proto;
>  
> +	/* Failsafe: a namespace opted out of the validation,
> +	 * trust the checksum metadata as before.
> +	 */
> +	if (virtio_net_hdr_csum_check_disabled(skb))
> +		return true;

virtio_net_csum_partial_ok can apparently be called before this check,
which would still drop packets.

> +
>  	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
>  		return false;
>  
> @@ -516,6 +536,9 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
>  	unsigned int thoff;
>  	int ip_proto;
>  
> +	if (virtio_net_hdr_csum_check_disabled(skb))
> +		return true;
> +
>  	if (!virtio_net_l3_start(skb, &nhoff, &proto))
>  		return false;
>  	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> index 9ef3d70e5e9c..ae8110772c97 100644
> --- a/include/net/netns/core.h
> +++ b/include/net/netns/core.h
> @@ -18,6 +18,7 @@ struct netns_core {
>  	u8	sysctl_txrehash;
>  	u8	sysctl_tstamp_allow_data;
>  	u8	sysctl_bypass_prot_mem;
> +	u8	sysctl_virtio_net_hdr_csum_check;
>  
>  #ifdef CONFIG_PROC_FS
>  	struct prot_inuse __percpu *prot_inuse;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360..d14950b1af3a 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2389,6 +2389,12 @@ EXPORT_SYMBOL(tcf_sw_enabled_key);
>  
>  DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
>  EXPORT_SYMBOL(netstamp_needed_key);
> +
> +/* Enabled while any network namespace has net.core.virtio_net_hdr_csum_check
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
> @@ -396,6 +396,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
>  	net->core.sysctl_optmem_max = 128 * 1024;
>  	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
>  	net->core.sysctl_tstamp_allow_data = 1;
> +	net->core.sysctl_virtio_net_hdr_csum_check = 1;
>  	net->core.sysctl_txq_reselection = msecs_to_jiffies(1000);
>  }
>  
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index eb35da3556f4..c65ff86cc5f9 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/sched/isolation.h>
>  #include <linux/hex.h>
> +#include <linux/jump_label.h>
>  
>  #include <net/ip.h>
>  #include <net/sock.h>
> @@ -678,6 +679,54 @@ static struct ctl_table net_core_table[] = {
>  	},
>  };
>  
> +/* Defined in net/core/dev.c, declared for the gate in
> + * include/linux/virtio_net.h.
> + */
> +DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
> +
> +/*
> + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.

it appears that they take the mutex_lock below

> + */
> +static DEFINE_MUTEX(virtio_net_hdr_csum_check_mutex);
> +
> +static int virtio_net_hdr_csum_check_sysctl(const struct ctl_table *table,
> +					    int write, void *buffer,
> +					    size_t *lenp, loff_t *ppos)
> +{
> +	struct net *net = (struct net *)table->data;
> +	/* checkpatch warns but this can't be const: tmp.data is set below */
> +	struct ctl_table tmp = *table;
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
> +	 * Make sure virtio_net_hdr_csum_check_disabled_key counts zero values of
> +	 * net->core.sysctl_virtio_net_hdr_csum_check.
> +	 */
> +	mutex_lock(&virtio_net_hdr_csum_check_mutex);
> +
> +	old = net->core.sysctl_virtio_net_hdr_csum_check;
> +	tmp.data = &net->core.sysctl_virtio_net_hdr_csum_check;
> +	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
> +	if (write && !ret && old != net->core.sysctl_virtio_net_hdr_csum_check) {
> +		if (net->core.sysctl_virtio_net_hdr_csum_check)
> +			static_branch_dec(&virtio_net_hdr_csum_check_disabled_key);
> +		else
> +			static_branch_inc(&virtio_net_hdr_csum_check_disabled_key);
> +	}
> +
> +	mutex_unlock(&virtio_net_hdr_csum_check_mutex);
> +
> +	return ret;
> +}
> +
>  static const struct ctl_table netns_core_table[] = {
>  #if IS_ENABLED(CONFIG_RPS)
>  	{
> @@ -737,6 +786,15 @@ static const struct ctl_table netns_core_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE
>  	},
> +	{
> +		.procname	= "virtio_net_hdr_csum_check",
> +		.data		= &init_net,

&init_net.core.sysctl_virtio_net_hdr_csum_check

> +		.maxlen		= sizeof(u8),
> +		.mode		= 0644,
> +		.proc_handler	= virtio_net_hdr_csum_check_sysctl,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE
> +	},
>  	/* sysctl_core_net_init() will set the values after this
>  	 * to readonly in network namespaces
>  	 */
> @@ -841,6 +899,8 @@ static __net_exit void sysctl_core_net_exit(struct net *net)
>  	tbl = net->core.sysctl_hdr->ctl_table_arg;
>  	unregister_net_sysctl_table(net->core.sysctl_hdr);
>  	BUG_ON(tbl == netns_core_table);
> +	if (!net->core.sysctl_virtio_net_hdr_csum_check)
> +		static_branch_dec(&virtio_net_hdr_csum_check_disabled_key);
>  #if IS_ENABLED(CONFIG_RPS)
>  	kfree(net->core.rps_default_mask);
>  #endif
> -- 
> MST
> 


