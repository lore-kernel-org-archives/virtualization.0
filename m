Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC147D468
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143196; cv=none; b=jS/bnxqSAH5fkIOngjvuGy9YZ57Te/cWBzuRPoKwxjMarRoga0bvf7ojMFLaWwLsXlp/fKMqmfXqEw/zaB8D5TC5boiMo3UbQYytxe6Rej6wg58GF1HyLz9bwKDR3hMqS+nmnvLUjfNlx3f4nu21yt1T1iiSYYg/gfknhk2gGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143196; c=relaxed/simple;
	bh=O/OiA4BQPUKLUXonJsE5pdtPrknSunNzaSfCvLDOogo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IMm//LsVhVD9z2BSDLFX0WkUkjfOFutZ5zbhna5FuvMugb8YYJuWLfBKYp6W+0IvWvQVNxMEj1Oh9N473SEbznIh/jp2mxMV9LxNkzjV9gUdNvuSSUFGuGeBW8kyNrdy+48D/unTH1QPQqnjoqmgN2R/F6SDodWTJOUVHw530Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AM3nYNW6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AM3nYNW6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792143191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F1WIlfJD+ulbctbVceU+ouilxpQA89DiQidLIlC9D0g=;
	b=AM3nYNW6DdV4sLxY3CPMCibgsaUUcnEaJr838VbRYWooywOAc9W2riMWm0uYP/QNUdsiS9
	UROl6aHd0q36spBJY7jDeL7QhfAI7+Tkwf+nYH+kpt1rp9sTlmvJrfyBMb58I7AxG9IbaT
	2ghXsttvD2VRv0XqZYJQIp9NpUnkrug=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-WLwzH9phMoq4s5PuUF83-g-1; Fri, 16 Oct 2026 09:33:09 +0000
X-MC-Unique: WLwzH9phMoq4s5PuUF83-g-1
X-Mimecast-MFC-AGG-ID: WLwzH9phMoq4s5PuUF83-g_1792143188
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a01ba12198so5698295e9.1
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 02:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143188; x=1792747988;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F1WIlfJD+ulbctbVceU+ouilxpQA89DiQidLIlC9D0g=;
        b=zEA3s6P4AuStdyxaUMxWkc/q1NgsWiu6P/i41KwgihLnikfrV7qdZVoDVATif4LEYV
         KfZqW3SZf7ud5Zpkfbrd24RQPnWH7fJMkaW1KgTvSPHKfOdRipOXNGzRv7HDwYrSuOxP
         hCgHWNpWtpC1H5Y/V92pkjsNHboYjQyo9TgDjdsPhOhSKjMWGzXTqivP/menDrMbyoQv
         CwJjkIqOYGOC3cBVjWzJ11aQs7cr9AjV3BD+pEEJ6UWqHx9n/lM/rVtwTk9hzvcuZsES
         PudCZiCpgv1vWz9GTiUl3raaMhY1QAn3K/oxFjGyGQ/CJo/HQ99BUttMAITvBYVD0O3b
         IfMg==
X-Forwarded-Encrypted: i=1; AKwUvBzo+eLnp8aoLcfzwjC11/8ZXIdYB/l1LbF6+QJxUqB4eUlDslosN7B1i9PHeWiV0DrfO4Sz2pFqnwKg6Dkbtg==@lists.linux.dev
X-Gm-Message-State: AFq9FYL7Vx+fmqcKk7QqbHVlTd0gPsocE1TkgGBZa6NZ3FxaCfOxT7TU
	PukWh+rTG48OGlnHzUewsNMX0KuZg/KvXVDEnd8O0TZlZvNy/V6GRtQGCFPyRqDHb7m1vWfTEhf
	HF1sHHT8hks+F+cJ9GP/RZOCuAczHYPvTPKX1zktoC8VhrL7fyvj6fK7azKnRqXo7CSTP
X-Gm-Gg: AYBFou1BmhbysLfntcVJaPCwlD6O6YEwUl+/Qyre7CfFdJZZRuJeHje597QhZZVbpt+
	S7yO4VmctcEy53LSuof2E7C+QtmzbLQPUn1m7VKL8eNbJgDwJORvDMGXpkwrOnaNmWV1JML8x4S
	40TM5nadMhh8SIeffC9C7EGTa4+qUewCL+hr+pfwA6Qz3TCUISkBcoAzghggHmBoyPA0h7a/eSu
	xwvJnp0qp4Ccfrj039kef1RgF3bVTZSGhztuhwnfJsEjyluJQ+gOIoeo56Qi1OXAwWp4BNHc1af
	L8aM87ITVdALk53OM2rInlCAmoibs2SxoN47YTr5A7ZNbxVNstTKbnzhkEWBOVWMVX3T1g==
X-Received: by 2002:a05:600c:c0d4:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a1c664db70mr51292235e9.6.1792143188156;
        Fri, 16 Oct 2026 02:33:08 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d4:b0:49e:63cc:6324 with SMTP id 5b1f17b1804b1-4a1c664db70mr51291755e9.6.1792143187537;
        Fri, 16 Oct 2026 02:33:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ae6d2esm44682945e9.6.2026.10.16.02.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:33:06 -0700 (PDT)
Date: Fri, 16 Oct 2026 05:33:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Rusty Russell <rusty@rustcorp.com.au>,
	Max Krasnyansky <maxk@qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/7] net: add a sysctl to opt out of virtio
 net hdr checksum validation
Message-ID: <20261016051827-mutt-send-email-mst@kernel.org>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
 <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.3a7d04e1c306e@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QD5D5vPU4u817WTzTNw2aZj5qyI-zRTfzr2nWpouCfE_1792143188
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 15, 2026 at 01:50:54PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > The ingress validation as implemented by the previous
> > patch is stricter than what it replaced: GSO
> > packets whose checksum metadata matches no transport header are
> > dropped, and non-GSO ones get their checksum completed in place.
> > Such packets used to pass with the metadata unvalidated,
> > and with no overhead.
> > 
> > I judge that this should not affect any deployments, but there is still
> > some risk that it does.  In case a deployment depends on them anyway,
> > provide a per-netns switch to get the old behavior back:
> > 
> > echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
> > 
> > The default is validating.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  Documentation/admin-guide/sysctl/net.rst | 15 +++++++
> >  include/linux/virtio_net.h               | 23 ++++++++++
> >  include/net/netns/core.h                 |  1 +
> >  net/core/dev.c                           |  6 +++
> >  net/core/net_namespace.c                 |  1 +
> >  net/core/sysctl_net_core.c               | 54 ++++++++++++++++++++++++
> >  6 files changed, 100 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index e586e17fc7a5..7f230929c37e 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -246,6 +246,21 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> >  Default: 1 (on)
> >  
> >  
> > +virtio_net_hdr_csum_check
> > +-------------------------
> 
> Make more generic, virtio_net_hdr_validate?
> 
> In case we add more validation in the future (as we have in the past),
> without having to introduce multiple such knobs.

But it's uapi, are you sure we'll be able to change the meaning
of an existing knob, even if we keep the name vague?

> > +
> > +When processing packets with a virtio net header (through tun, tap, a
> > +packet socket or a virtio network device) that request checksum offload
> > +(VIRTIO_NET_HDR_F_NEEDS_CSUM), validate the packet: complete the checksum
> > +in software, or drop the packet where the header does not match it.
> > +
> > +When disabled, the header is trusted not to corrupt the packet, and the
> > +checksum is offloaded to hardware (or not verified if it never reaches
> > +hardware). This is only safe if no protocol is processing the packets.
> > +
> > +Default: 1 (on)
> > +
> > +
> >  wmem_default
> >  ------------
> >  
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 357115ff0ec2..aa2f8ac4657c 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -5,6 +5,7 @@
> >  #include <linux/if_vlan.h>
> >  #include <linux/ip.h>
> >  #include <linux/ipv6.h>
> > +#include <linux/jump_label.h>
> >  #include <linux/netdevice.h>
> >  #include <linux/udp.h>
> >  #include <net/gso.h>
> > @@ -78,6 +79,19 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
> >  	*thoff = nhoff + iph->ihl * sizeof(u32);
> >  	return iph;
> >  }
> > +/* Defined in net/core/dev.c, enabled while any network namespace
> > + * has net.core.virtio_net_hdr_csum_check set to 0.
> > + */
> 
> Should this be a global sysctl, rather than per netns?


For customers I work with, it would be much less useful.


> Even if per-netns, most likely do not want it writable by netns root
> with user namespaces.
>
> That is the equivalent of ns_capable(CAP_NET_RAW), which is the cause
> of many crashes due to bad packets ingested by, e.g., a packet socket.

Hmm, yes i get that. Two knobs? a. verify b. the per netns value ro? Both
on by default?

> A global sysctl also allows using proc_do_static_key and avoids the
> custom logic in virtio_net_hdr_csum_check_sysctl.
> 
> >  /* Where does the L3 header start, and what protocol is it?
> >   * Handles Ethernet and VLAN headers; other devices use the
> > @@ -152,6 +166,12 @@ virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
> >  	unsigned int thoff;
> >  	int ip_proto;
> >  
> > +	/* Failsafe: a namespace opted out of the validation,
> > +	 * trust the checksum metadata as before.
> > +	 */
> 
> nit: as before, imho the code here is clear and comment unnecessary.


Ugh. One of these got through. Absolutely.

> > +	if (virtio_net_hdr_csum_check_disabled(skb))
> > +		return true;
> > +
> >  	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> >  		return false;
> >  
> > @@ -483,6 +503,9 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> >  	unsigned int thoff;
> >  	int ip_proto;
> >  
> > +	if (virtio_net_hdr_csum_check_disabled(skb))
> > +		return true;
> > +
> >  	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> >  		return false;
> >  	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> 
> > +/* Defined in net/core/dev.c, declared for the gate in
> > + * include/linux/virtio_net.h.
> > + */
> > +DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
> > +
> > +/*
> > + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> > + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
> > + */
> > +static DEFINE_MUTEX(virtio_net_hdr_csum_check_mutex);
> > +
> > +static int virtio_net_hdr_csum_check_sysctl(const struct ctl_table *table,
> > +					    int write, void *buffer,
> > +					    size_t *lenp, loff_t *ppos)
> > +{
> > +	struct net *net = (struct net *)table->data;
> > +	/* checkpatch warns but this can't be const: tmp.data is set below */
> > +	struct ctl_table tmp = *table;
> > +	u8 old;
> > +	int ret;
> > +
> > +	/*
> > +	 * Make sure virtio_net_hdr_csum_check_disabled_key counts zero values of
> > +	 * net->core.sysctl_virtio_net_hdr_csum_check.
> > +	 */
> > +	mutex_lock(&virtio_net_hdr_csum_check_mutex);
> > +
> > +	old = net->core.sysctl_virtio_net_hdr_csum_check;
> > +	tmp.data = &net->core.sysctl_virtio_net_hdr_csum_check;
> > +	ret = proc_dou8vec_minmax(&tmp, write, buffer, lenp, ppos);
> > +	if (write && !ret && old != net->core.sysctl_virtio_net_hdr_csum_check) {
> > +		if (net->core.sysctl_virtio_net_hdr_csum_check)
> > +			static_branch_dec(&virtio_net_hdr_csum_check_disabled_key);
> > +		else
> > +			static_branch_inc(&virtio_net_hdr_csum_check_disabled_key);
> > +	}
> > +
> > +	mutex_unlock(&virtio_net_hdr_csum_check_mutex);
> > +
> > +	return ret;
> > +}
> > +
> >  static const struct ctl_table netns_core_table[] = {
> >  #if IS_ENABLED(CONFIG_RPS)
> >  	{
> > @@ -737,6 +780,15 @@ static const struct ctl_table netns_core_table[] = {
> >  		.extra1		= SYSCTL_ZERO,
> >  		.extra2		= SYSCTL_ONE
> >  	},
> > +	{
> > +		.procname	= "virtio_net_hdr_csum_check",
> > +		.data		= &init_net,
> > +		.maxlen		= sizeof(u8),
> > +		.mode		= 0644,
> > +		.proc_handler	= virtio_net_hdr_csum_check_sysctl,
> > +		.extra1		= SYSCTL_ZERO,
> > +		.extra2		= SYSCTL_ONE
> > +	},
> >  	/* sysctl_core_net_init() will set the values after this
> >  	 * to readonly in network namespaces
> >  	 */
> > @@ -841,6 +893,8 @@ static __net_exit void sysctl_core_net_exit(struct net *net)
> >  	tbl = net->core.sysctl_hdr->ctl_table_arg;
> >  	unregister_net_sysctl_table(net->core.sysctl_hdr);
> >  	BUG_ON(tbl == netns_core_table);
> > +	if (!net->core.sysctl_virtio_net_hdr_csum_check)
> > +		static_branch_dec(&virtio_net_hdr_csum_check_disabled_key);
> >  #if IS_ENABLED(CONFIG_RPS)
> >  	kfree(net->core.rps_default_mask);
> >  #endif
> > -- 
> > MST
> > 
> 

