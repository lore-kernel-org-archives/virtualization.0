Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505065;
	b=tP+yQJOi8of7hpz8ap9qXvcj8fWoAdYp+F/4OxYbSG4axnkXYNRieGU2xnt1GL2E9mUv
	 7QZmSuDJp2iJYM3FYYHnU8CfEQgKle3tYId1tgrAJwL0gGuzd5VR3NqUqTJlCRFIvdXbP
	 36FrzFX9u7RGYOMgB9alJ0o065hxAqfUMOWZOr9tCsR9pa7rMusijwpGqtH45mzs661Iz
	 l3Kg2Qi9NONX8PeHWDpmS1SxZx6CN6/4e4KujleRhY79uGPaX9P7bCP5MQOAhTyaUEWsD
	 WvTGkytQsKrctNKkbeR6RE0JTL+kQc+kHaqU1K8flyx/1XOTmtb9YZ3tPbTrZ75tjHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505065;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=VTSXONY++MHAhLW+7kA48dz0Wy/1YW5a9nSo3Jvds/4=;
	b=oEMf7vZ+UDyKBhT4HUmx14O2T7RQ2depiuDU4JSQVRper2jP9OzTpaCFwR8HpcnOnO1n
	 t899XML+UvgcWUbPSBtKbgVWP5nMph5DwDFRU090YgSSY4eGfFISGwrxuOQgLNmn0xVFC
	 bsFRQGclQaQDkvTuwNxJ8hUqAnkTDZUnA4xC0KjVQfnPbk6D0DBaLrRAhpYxjG00mfVl2
	 KQThp7dmRJ0kcVaP3Wk9B90LVhTJG84KGoGxmyxSFEyrYO056V303YGt0n3oiWiUuMOhl
	 BGjwvAvrwiCEiPdBaGfP3U/JOzkK6wvHqsKF4beSrYZ61cuq5eR4XkbPuVOusv1EUtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d1YoMmCE;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBB3606A31B
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 14:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFBB3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d1YoMmCE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792505063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTSXONY++MHAhLW+7kA48dz0Wy/1YW5a9nSo3Jvds/4=;
	b=d1YoMmCEYMXsUc8UpRWc2vm4Z0difS/OnP6W+4mgxE4foxt66RTfx804iKsbRBehOluh3o
	su7REJEcUv+vpsmaP/Ew8AHLLxWOAx6DAEoeF/0hFIYsUyMG2sZs10tWz7LHUJHPDxTitu
	QNM1ogfuxx3Pd25+L992j922ixtcHKE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-b2xeSzEvO1-fe_3GxreuFg-1; Tue, 20 Oct 2026 10:04:22 -0400
X-MC-Unique: b2xeSzEvO1-fe_3GxreuFg-1
X-Mimecast-MFC-AGG-ID: b2xeSzEvO1-fe_3GxreuFg_1792505061
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c415561aaso2240240f8f.1
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 07:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505061; x=1793109861;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VTSXONY++MHAhLW+7kA48dz0Wy/1YW5a9nSo3Jvds/4=;
        b=zw7PvRt8Yq+a6VJCkO9OTA8LZCywIjrJEEJFRk0XIAWewVTf40BGnofbiLMnh6+ZaR
         LJibNAM2hxt6Cl14h0auMcgGsbl4FnCZuviM7Txlk6vYng+u1immyNVZqrJ8WBj+FEvT
         L2344efTO1TfbGqFz0mSOHdijPD+n8ECZ+ZxUXmQRjCwcT5F5RWbdoYmBaf716wraBE6
         mhpkjCNLuRKmwvKN2r2llVKs5TA4BsrBByjpAV4NsxfiQM/BUdOudcPgFWXTM3Oe1yyK
         BkmIbsIM7oynUJDUN5n5FN1hmk73F81i9pjVQPnRRrCnWi+N+amFfhbPfdq3mGIYYtPf
         mGsw==
X-Forwarded-Encrypted: i=1; AKwUvBycXpEiVcPo9DBprAVG9pcsf4pwGdIGXXDC4dIjS+WPRVrhn/js2SAp4JCrdIYcjkZC3lb1pp4rOcK0t0LXDg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKIOPM0FyUQXrgrGR7UZzbqBuvca3wq30LF55t1uhJLPO1SWuJG
	8kFUcKBEzTfw017UzsdY9S8znCBgTrGojzvYBNFPfunQkNTmlgiPTWEaGVf79d+rUJGZ+36hoZ3
	zafp62/oVTLD35k3U7ODIKGc8gZkvUSX8NeGYVb+vRafC9Gcirkfo8K4lMNjOyIRhevNX
X-Gm-Gg: AYBFou1Q6O2phCO+prW2F01NDyMZWiKpmKbnt8e66daQNwGxirZNzfDRt+vZrQPbqYt
	5VeAbSrSUENmlY3oVsV4kRTnxAEiQZEEFxPpepaYAamTkvR+GJoThpxGeVN8mlmCspJEW/IuytV
	Bkr4Jz8LLy6kywAbDaGopE89jLhVQ7IbC9mFlPvRK708UM++IhcliLrUHqL3PeFkpl076AC6/h7
	geTOd+La1CE859DBoRRW2eAvzgkyxUy4goaMCTsYFFsIZZHxPrJmbRGWYFudOO1JajANbYW8jf8
	MFUaSy9Cb4eF7sS9chpDDHvsik6JU0eC+A7yI5Ys3wRZLeB+lA3olL8z0ZBaLp0muw1QNg==
X-Received: by 2002:a05:600c:859a:b0:4a1:d8c5:b23f with SMTP id 5b1f17b1804b1-4a1d8c5bb82mr193418545e9.24.1792505060884;
        Tue, 20 Oct 2026 07:04:20 -0700 (PDT)
X-Received: by 2002:a05:600c:859a:b0:4a1:d8c5:b23f with SMTP id 5b1f17b1804b1-4a1d8c5bb82mr193417665e9.24.1792505060268;
        Tue, 20 Oct 2026 07:04:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cc0708sm68065075e9.7.2026.10.20.07.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:04:19 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:04:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Chris Arges <carges@cloudflare.com>, Phil Sutter <phil@nwl.cc>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Simon Horman <horms@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v3 6/8] net: add a sysctl to opt out of virtio net
 hdr checksum validation
Message-ID: <20261020100349-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <6f23c55c6eba3e3ec6b2c7e3a80728a326ed58af.1792411304.git.mst@redhat.com>
 <87fqy13h97.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <87fqy13h97.fsf@all.your.base.are.belong.to.us>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zM-cJrJBS7A03IMkkwuDFy6gixdnPleKd0okN7wtRAc_1792505061
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Oct 19, 2026 at 04:19:16PM +0200, Björn Töpel wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
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
> >  Documentation/admin-guide/sysctl/net.rst | 19 ++++++++
> >  include/linux/virtio_net.h               | 23 +++++++++
> >  include/net/netns/core.h                 |  1 +
> >  net/core/dev.c                           |  6 +++
> >  net/core/net_namespace.c                 |  1 +
> >  net/core/sysctl_net_core.c               | 60 ++++++++++++++++++++++++
> >  6 files changed, 110 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index e586e17fc7a5..b1a1c4714b22 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -246,6 +246,25 @@ processes are dropped unless socket option SOF_TIMESTAMPING_OPT_TSONLY is set.
> >  Default: 1 (on)
> >  
> >  
> > +virtio_net_hdr_csum_check
> > +-------------------------
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
> > +The setting is per network namespace, but only writable by the host
> > +root: root inside a network namespace created by an unprivileged user
> > +cannot disable the validation.
> > +
> > +Default: 1 (on)
> > +
> > +
> >  wmem_default
> >  ------------
> >  
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index 97b554ef7123..25aa95c11e31 100644
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
> > +DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
> > +
> > +/* Failsafe: a namespace can disable the check with
> > + * net.core.virtio_net_hdr_csum_check.
> > + */
> > +static inline bool virtio_net_hdr_csum_check_disabled(struct sk_buff *skb)
> > +{
> > +	return static_branch_unlikely(&virtio_net_hdr_csum_check_disabled_key) &&
> > +	       !READ_ONCE(dev_net(skb->dev)->core.sysctl_virtio_net_hdr_csum_check);
> > +}
> >  
> >  /* Where does the L3 header start, and what protocol is it?
> >   * Handles Ethernet and VLAN headers; other devices use the
> > @@ -179,6 +193,12 @@ virtio_net_csum_partial_ok_at_offset(struct sk_buff *skb, u8 hdr_gso_type,
> >  	unsigned int thoff;
> >  	int ip_proto;
> >  
> > +	/* Failsafe: a namespace opted out of the validation,
> > +	 * trust the checksum metadata as before.
> > +	 */
> > +	if (virtio_net_hdr_csum_check_disabled(skb))
> > +		return true;
> > +
> >  	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> >  		return false;
> >  
> > @@ -516,6 +536,9 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> >  	unsigned int thoff;
> >  	int ip_proto;
> >  
> > +	if (virtio_net_hdr_csum_check_disabled(skb))
> > +		return true;
> > +
> >  	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> >  		return false;
> >  	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> > diff --git a/include/net/netns/core.h b/include/net/netns/core.h
> > index 9ef3d70e5e9c..ae8110772c97 100644
> > --- a/include/net/netns/core.h
> > +++ b/include/net/netns/core.h
> > @@ -18,6 +18,7 @@ struct netns_core {
> >  	u8	sysctl_txrehash;
> >  	u8	sysctl_tstamp_allow_data;
> >  	u8	sysctl_bypass_prot_mem;
> > +	u8	sysctl_virtio_net_hdr_csum_check;
> >  
> >  #ifdef CONFIG_PROC_FS
> >  	struct prot_inuse __percpu *prot_inuse;
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index e76762e29360..d14950b1af3a 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -2389,6 +2389,12 @@ EXPORT_SYMBOL(tcf_sw_enabled_key);
> >  
> >  DEFINE_STATIC_KEY_FALSE(netstamp_needed_key);
> >  EXPORT_SYMBOL(netstamp_needed_key);
> > +
> > +/* Enabled while any network namespace has net.core.virtio_net_hdr_csum_check
> > + * set to 0.
> > + */
> > +DEFINE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
> > +EXPORT_SYMBOL(virtio_net_hdr_csum_check_disabled_key);
> >  #ifdef CONFIG_JUMP_LABEL
> >  static atomic_t netstamp_needed_deferred;
> >  static atomic_t netstamp_wanted;
> > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > index da5f881fbd3b..2d340fafba85 100644
> > --- a/net/core/net_namespace.c
> > +++ b/net/core/net_namespace.c
> > @@ -396,6 +396,7 @@ static __net_init void preinit_net_sysctl(struct net *net)
> >  	net->core.sysctl_optmem_max = 128 * 1024;
> >  	net->core.sysctl_txrehash = SOCK_TXREHASH_ENABLED;
> >  	net->core.sysctl_tstamp_allow_data = 1;
> > +	net->core.sysctl_virtio_net_hdr_csum_check = 1;
> >  	net->core.sysctl_txq_reselection = msecs_to_jiffies(1000);
> >  }
> >  
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index eb35da3556f4..c65ff86cc5f9 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/sched/isolation.h>
> >  #include <linux/hex.h>
> > +#include <linux/jump_label.h>
> >  
> >  #include <net/ip.h>
> >  #include <net/sock.h>
> > @@ -678,6 +679,54 @@ static struct ctl_table net_core_table[] = {
> >  	},
> >  };
> >  
> > +/* Defined in net/core/dev.c, declared for the gate in
> > + * include/linux/virtio_net.h.
> > + */
> > +DECLARE_STATIC_KEY_FALSE(virtio_net_hdr_csum_check_disabled_key);
> > +
> > +/*
> > + * Protects changes to virtio_net_hdr_csum_check_disabled_key and each
> > + * net->core.sysctl_virtio_net_hdr_csum_check. Readers don't use a lock.
> > + */
> 
> nit: OCD doesn't like mixing old netdev comments with vanilla style...
> one VVV as well.
> 
> > +static DEFINE_MUTEX(virtio_net_hdr_csum_check_mutex);
> > +
> > +static int virtio_net_hdr_csum_check_sysctl(const struct ctl_table *table,
> > +					    int write, void *buffer,
> > +					    size_t *lenp, loff_t *ppos)
> > +{
> > +	struct net *net = (struct net *)table->data;
> > +	/* checkpatch warns but this can't be const: tmp.data is set
> > below */
> 
> nit: Redundant comment...
> 
> > +	struct ctl_table tmp = *table;
> 
> ...and here, can't we instead get rid of tmp, and do something like:
>     | u8 *value = table->data;
>     | u8 old, new;
> 
> > +	u8 old;
> > +	int ret;
> > +
> > +	/* Root in a user namespace must not be able to weaken the
> > +	 * validation for the network namespace it controls.
> > +	 */
> > +	if (write && !capable(CAP_NET_ADMIN))
> > +		return -EPERM;
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
> 
> and then:
>     | old = READ_ONCE(*value);
>     | ret = proc_dou8vec_minmax(table, write, buffer, lenp, ppos);
>     | new = READ_ONCE(*value);
>     | 
>     | if (write && !ret && old != new) {
> 
> at least that's easier to read for me. (No blocker!)
> 
> 
> Reviewed-by: Björn Töpel <bjorn@kernel.org>


Thanks, I'm addressing sashiko review points, will address this
in v4.

