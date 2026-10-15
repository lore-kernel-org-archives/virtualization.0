Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFC568FB7
	for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 17:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086667; cv=none; b=uwKAVRtBESGrmRZMTDyoZfoFisxMd3wjFerSlkVd/faOrnxW5g4Z1dXJKFBzaLM4rc8fgXWj4TTZ2lOX/SopJ7PpFfnuvmEjLtiDbbmyv8dmL5a98GeqkaY1V4Mfom4YT+rRSFkm+PAtZCuL/oJBXYHr5B6a05ckBFYbz/Pse6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086667; c=relaxed/simple;
	bh=fMqpqs1u8LBcIFnBHT9B79hdJta82WzO1YoJAMI+N7M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GMZdV7i8YDjSR1oO4xK4YbhqT+GIf32JFBgMFpQpsfLlHcdqjWaojnSsCxLZ+ZEKp6DWI4xRfK04g+BHsvrrQNdNmjRCGbSKcSedzW7JwkvbIKlZ/5a4BUxD1pdopC7tD8YfgYCnlI7rd+Bb6zsLzcAtrqC9TA1o6uHFLg2u5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5qLjNN8; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5qLjNN8"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ea9a2c3936so6098e0c.2
        for <virtualization@lists.linux.dev>; Thu, 15 Oct 2026 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792086656; x=1792691456; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=i8+0UTRzQqbINpMv2vf6iArLkPondg+9Xp/w3H+DSS4=;
        b=X5qLjNN8mhodSY88gti7fEuCG0aFyHkgoN3UKpnmWy0GFuNh8SHaNd18/oxJhp15yw
         IcBQXq75JRnAkPfIgdBGrDG6krATZgGFbGYy8rS0wGuBw88Al/WR6nOlCyhSnBJpwjdw
         rk7iQGIA56qzxszwaZI0+dkUFSVWu5DW4Hl2FIF0yJTJ9bxmaMsi9C5RYG2uSk6Y6cGt
         0z6wcv9quk/oqeMfnlDjVsPy5ww2hEtXsRd4nykJdGWEQf42GlxC6UIIoRHrp8T35QvE
         /o/HYqzVpSnnFpsUsLLfeauVVCh+UXFqCLGBMLfM/LR4sRTMI8Mm+wW7kzHA39Npjtd0
         TXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792086656; x=1792691456;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8+0UTRzQqbINpMv2vf6iArLkPondg+9Xp/w3H+DSS4=;
        b=HlGq1gKq0L6YNUBxL44yFW/MnmOJE4geMPbgS+1PCfmoAWNSTzMeAawhsy1A4hkx9g
         A/+vRHF8D8D1+RRfofEC4HWOTvOOFXxnajX8w25gPVDtWWzOGMkufpOL9/tdBBlbmAiG
         JoYyLhNfNH1n7SL4DFha1t1JM9f2BwYQz7KYFGvWq6hABO0skh5rVRj7M3gl/FzNeJMI
         oFsPj/v++Fe3l+39BvwIIEHOYOwzqPaXXWxMlcNbkXN2o9iNfYrri8L9TZrpUfun/bIh
         U8HzhLD/iVKWLkZWNdb5hPWanVKwHSCnD0YLXlokU33y/TmiLkawXoMbMOe07NDqj6eS
         wNMA==
X-Forwarded-Encrypted: i=1; AKwUvBwMIV0Kl6KFX8by/irQDvQfJqg3lH2xOMgXwrpiNvPV55jitAwTXTed0MFyhQxzaLVL29ZIti/jXxFOefxPBQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIW3L+Wrul4SNtsGVYQCTXzvDRK/cconbIl5IVnya5p1L70ym/w
	9GD/hnDY+1aP9NaK1voD2JDCEYsXCgjE6Zogym5bUQlK7RpcngO1vp77HDHkDA==
X-Gm-Gg: AYBFou1SRjTDaVdBZ3a9is/op8W+pO7B+KFsI5vI4iXYcC8xAFVMSSpNimsQe8MFhtX
	SSzqjm5QCM1exVDMENr8DhJ/7Z03KXZtBTqF+/x2kH+emPuetOrI1X1VoUWFGwadl6OluiktbI5
	Uyo5lQyXXwqRdZ1wM1JsQHx59I9Vv1skD7bw5NQtel3ycVoDUtWkGi/Kx7j9usN/4ETLp/ZL2GK
	vh0HQdgCBhH0CRpUK8DxxYW1U8a4GYSbdHkQHrhlps9jrBtRvfg7Ty2Rdx5/eJyDWjNt0TgRrAN
	XbBx5/lis1E3O62Ss1br0x8uas9d3G7mXZrFJbq9P9SqzTvQ5iIlsWFgvF7tDyhJiTZOzKcXTC8
	Xmd7lBv79B2aIKdFx6ZheN1CNhyvwFAKoIH2gRin+vdjLzBTdneut3lG9CaMaoEBGTN0BigS7hD
	BcE6V3ltkVkId/yTBN8WVASa4Gszk00exxaEUu0qYIalnn4ulmhPhzy8GXoMwHu8eNhO5jFuxx1
	WUlpEhy/nfkZ2/g0Z0ubQUID2Py/jlv9TKE1RGQgyL61+vKxKAZfKO3A3cyGDEk5Dq6d4o4g6FR
	q+spVBMRwwwd/tyfMTrZv74UgvxRIvFkJvw/uwbpt40+SpOM
X-Received: by 2002:a05:6122:3d14:b0:5e7:fc09:890a with SMTP id 71dfb90a1353d-5e91f48135bmr6780539e0c.11.1792086656401;
        Thu, 15 Oct 2026 10:50:56 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea994fcf47sm222175e0c.15.2026.10.15.10.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:50:55 -0700 (PDT)
Date: Thu, 15 Oct 2026 13:50:54 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 linux-kernel@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
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
 Rusty Russell <rusty@rustcorp.com.au>, 
 Max Krasnyansky <maxk@qualcomm.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Simon Horman <horms@kernel.org>, 
 linux-doc@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
In-Reply-To: <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
Subject: Re: [PATCH net-next v2 5/7] net: add a sysctl to opt out of virtio
 net hdr checksum validation
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
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
>  Documentation/admin-guide/sysctl/net.rst | 15 +++++++
>  include/linux/virtio_net.h               | 23 ++++++++++
>  include/net/netns/core.h                 |  1 +
>  net/core/dev.c                           |  6 +++
>  net/core/net_namespace.c                 |  1 +
>  net/core/sysctl_net_core.c               | 54 ++++++++++++++++++++++++
>  6 files changed, 100 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> index e586e17fc7a5..7f230929c37e 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -246,6 +246,21 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
>  Default: 1 (on)
>  
>  
> +virtio_net_hdr_csum_check
> +-------------------------

Make more generic, virtio_net_hdr_validate?

In case we add more validation in the future (as we have in the past),
without having to introduce multiple such knobs.

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
> +Default: 1 (on)
> +
> +
>  wmem_default
>  ------------
>  
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 357115ff0ec2..aa2f8ac4657c 100644
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

Should this be a global sysctl, rather than per netns?

Even if per-netns, most likely do not want it writable by netns root
with user namespaces.

That is the equivalent of ns_capable(CAP_NET_RAW), which is the cause
of many crashes due to bad packets ingested by, e.g., a packet socket.

A global sysctl also allows using proc_do_static_key and avoids the
custom logic in virtio_net_hdr_csum_check_sysctl.

>  /* Where does the L3 header start, and what protocol is it?
>   * Handles Ethernet and VLAN headers; other devices use the
> @@ -152,6 +166,12 @@ virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
>  	unsigned int thoff;
>  	int ip_proto;
>  
> +	/* Failsafe: a namespace opted out of the validation,
> +	 * trust the checksum metadata as before.
> +	 */

nit: as before, imho the code here is clear and comment unnecessary.

> +	if (virtio_net_hdr_csum_check_disabled(skb))
> +		return true;
> +
>  	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
>  		return false;
>  
> @@ -483,6 +503,9 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
>  	unsigned int thoff;
>  	int ip_proto;
>  
> +	if (virtio_net_hdr_csum_check_disabled(skb))
> +		return true;
> +
>  	if (!virtio_net_l3_start(skb, &nhoff, &proto))
>  		return false;
>  	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))

> +/* Defined in net/core/dev.c, declared for the gate in
> + * include/linux/virtio_net.h.
> + */
> +DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
> +
> +/*
> + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
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
> @@ -737,6 +780,15 @@ static const struct ctl_table netns_core_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE
>  	},
> +	{
> +		.procname	= "virtio_net_hdr_csum_check",
> +		.data		= &init_net,
> +		.maxlen		= sizeof(u8),
> +		.mode		= 0644,
> +		.proc_handler	= virtio_net_hdr_csum_check_sysctl,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE
> +	},
>  	/* sysctl_core_net_init() will set the values after this
>  	 * to readonly in network namespaces
>  	 */
> @@ -841,6 +893,8 @@ static __net_exit void sysctl_core_net_exit(struct net *net)
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


