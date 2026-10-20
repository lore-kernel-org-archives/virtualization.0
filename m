Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525147;
	b=ubbSyJ9YDjuupRWfhDx0M18cU/yCvuj21LAoWf6o76aY4gKYCNCsijw0v+l7Iv2JL5Cu
	 KlfO7YCGX0KFuuRpqJZIK3AnM+SRkHgtBDXspMJcdzxg6Tf/uWjeqYc4Ghghkw45jpXYD
	 52hiOlwFuV6AaRkYU+cSCtp1mITGVRB4yFrd0L4gFHY94tXKtjIYt0V34Hhp8hwKXeID3
	 E7FJ9faeXWg3pjX5ht69uvgmghMaKdOYHDBDTiqzDFAeDr51H6RWFkghonqhf9M4QpG5A
	 KweHB8ixycEQqfP3WPQW8L4BhLM8pdER85OHGlT5Zr1OiFHgkx2bL20qZpqX1m8LPvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525147;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=JkjH/Sgg5VxVUFVBkqKACHe5NY0hXmzsOqepQjU71sU=;
	b=TYoGR/7nXsAl19Vtl+WGqHJiAbWL1IPUGRlHam8IUI+BEOaJgiTSvyn8lryEMcb7SwpF
	 r1fZxONGt8WsLzHJud7yC457puSkc5lT8G/4tWGwTU9La6yfu3TXwFQXYcpI1yC2pDOOv
	 kEElTNfbps7r2xICgKph6pQ30pLKq19l/r24XgyDIKyKqL9e+TQu/OT8QtBwmsAN7OxsP
	 PjV6v3Ne7sfznZUhEP85sWV2oa+DV5sdNZa9yOaQEbAiqoTPgnWP3q5XY9SRDvzVu44vd
	 4U3UvFf0/ye4zDl+ztXfiYI5Uomd1bbMD9cQZxhhUsRfrOtt50bIMCRXjQA+FzdvubQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dIYizZlX;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A2F606A31A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 19:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90A2F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dIYizZlX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792525145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JkjH/Sgg5VxVUFVBkqKACHe5NY0hXmzsOqepQjU71sU=;
	b=dIYizZlXXBBOBO5oL4UV2RssAuji1OZ5PEslvz+25QZKtuJfbXCU2QyHzo27zuWdeBWReL
	6QD2nd0dfyw726LXqrgNHE85mbpLzUtmx/sIVadq/6WRxQ1as71jvBMkzr2tXI2onoaBU9
	9zfy90LQ96NFlBYAjZ2Hl1Ea2nKLMM8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-GE-JU1PINFSbK0IoWCQ9XA-1; Tue, 20 Oct 2026 15:38:59 -0400
X-MC-Unique: GE-JU1PINFSbK0IoWCQ9XA-1
X-Mimecast-MFC-AGG-ID: GE-JU1PINFSbK0IoWCQ9XA_1792525138
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e1d839ddaso984463f8f.3
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792525138; x=1793129938;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JkjH/Sgg5VxVUFVBkqKACHe5NY0hXmzsOqepQjU71sU=;
        b=IGELl090iXQvF5QEk/cny5DN5m+5rdOzHeagQAEPq0q4wXSbFdA/dVvGiaSiTO78+c
         W+BJBJpTwpQuuL63mp2gGLZ99aCq5NWR44N08/rH1csiaZOnS0uXv849tzppf01ErDUd
         CviQb/G+fHXCEiXDd9vYFftfagva80rBkbI5otsPpEshlK3lc7A1D9nf0Wopx6ZfwxXD
         7pv4zSBAsyuh5gl3RQW02YFJ9LB8XdAYeO+I4IL3mjp43uG3kASOp++jyhBvBK3ojpAG
         VIcR+yQdVngUqJAu1HnBz+0ppWWfBJbDJK4ctpTl7DryfLbYy7SV0AN/Kiq/Y68nNq3N
         4WkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoDPywitM/6LqF4g19FFf264BFx3eKQwxoPEyuMRvCCAq+Su4FT6O4h8KXWujwTjzGIBbLM95JAwLN6Ror8Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ56kNiyaTH3snN3AJPoZQOlKZqG/jPA1ddG+mLi0wCZZ8VGQex
	WsK0qWadtaHTUIGUpg6BJ8q7tLae5TIltLKI0It5Hi5ZmIF6zgamEOLaI1utLb5RK1ZC7aGOc5Q
	7pEKl1wL2pPBGwxkcflzDO7n1X6uSOffGQGXlIdCw0dP5uFyNH6B4tG4CfiXnSRPGuAGQ
X-Gm-Gg: AYBFou0b6ESskNcjdXDSoUmYfTpkngxX77ef+AG6x8rLFdGh8MHgEGjMuUe01mCK7Nh
	h8eOnF6EqoMUtHsdW0g739n9HfOFbaRyrHuHAv475rD1jrsPttyqr9DFYz9CQZKg4yw2nGdFE+o
	SUVKCJwy88TFcuasoD1b5nktTQDyre1Abx1tQDDc3UJvTBjNfW69zSIotp+ioSWCX3G/mh40MsX
	64wFPHHNnCrBeXhO+21Ew1yKjJnQhZCU6Ka13vmUkrkrfu1QxTxjHKRxZj/gsoj5XF507q1FQKP
	jWS0PYe0zyNfx8MAYJ1ZyKEvRXesHt0p08OWjxaE2mQnM7DaM+qu3o7wfHXSw/Mn2nl32A==
X-Received: by 2002:a05:6000:1b8f:b0:487:72f:fb41 with SMTP id ffacd0b85a97d-48e07fa0e82mr18492827f8f.39.1792525138249;
        Tue, 20 Oct 2026 12:38:58 -0700 (PDT)
X-Received: by 2002:a05:6000:1b8f:b0:487:72f:fb41 with SMTP id ffacd0b85a97d-48e07fa0e82mr18492786f8f.39.1792525137659;
        Tue, 20 Oct 2026 12:38:57 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828cbfsm425597f8f.23.2026.10.20.12.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:38:56 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:38:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, Chris Arges <carges@cloudflare.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Phil Sutter <phil@nwl.cc>, Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Max Krasnyansky <maxk@qualcomm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v3 1/8] net: account for ingress-resolved virtio net
 hdr state
Message-ID: <20261020153650-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.26f697d5a674b@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.26f697d5a674b@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: veOfQM9SNP3UXWv3j_k5lsLL9Fq9YnPVrldcudO6_h0_1792525138
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2026 at 03:27:46PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > The following patch will add ingress resolution of uncommon virtio net
> > hdr checksum metadata (software checksum completion at ingress) which
> > adds performance overhead to the packet processing.
> > 
> > We should make it visible, so a hypothetical workload relying on
> > uncommon metadata can be distinguished from none at all. This way issues
> > in the parsing will be reported and not quietly pay the host-CPU
> > checksum overhead instead of offload.
> > 
> > Flip every call to virtio_net_hdr_to_skb to test for negative errno
> > only, and have tun count these events per device as rx_csum_sw, exposed
> > via ethtool -S.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/net/tap.c        |  4 ++--
> >  drivers/net/tun.c        | 41 ++++++++++++++++++++++++++++++++++++++--
> >  drivers/net/virtio_net.c |  2 +-
> >  net/packet/af_packet.c   |  4 ++--
> >  4 files changed, 44 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > index ff67d99deb39..73e883394446 100644
> > --- a/drivers/net/tap.c
> > +++ b/drivers/net/tap.c
> > @@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> >  
> >  	if (vnet_hdr_len) {
> >  		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
> > -		if (err) {
> > +		if (err < 0) {
> >  			rcu_read_unlock();
> >  			drop_reason = SKB_DROP_REASON_DEV_HDR;
> >  			goto err_kfree;
> > @@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> >  
> >  	if (vnet_hdr_len) {
> >  		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
> > -		if (err) {
> > +		if (err < 0) {
> >  			rcu_read_unlock();
> >  			goto err_kfree;
> >  		}
> 
> similar to tun, should tap count this event?
> 
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 242899f7fd07..19cb443c89b0 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -210,6 +210,7 @@ struct tun_struct {
> >  	u32 flow_count;
> >  	u32 rx_batched;
> >  	atomic_long_t rx_frame_errors;
> > +	atomic64_t rx_csum_sw;
> 
> is a normal (and cheaper on 32b platforms) atomic_t or atomic_long_t sufficient?

well it can overflow easily. i don't know that we care that a slow
path will be even a bit slower on these ancient platforms. correct
reporting seems more important.

> >  	struct bpf_prog __rcu *xdp_prog;
> >  	struct tun_prog __rcu *steering_prog;
> >  	struct tun_prog __rcu *filter_prog;
> > @@ -1935,11 +1936,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> >  		break;
> >  	}
> >  
> > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> > +	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
> > +	if (err < 0) {
> >  		atomic_long_inc(&tun->rx_frame_errors);
> >  		err = -EINVAL;
> >  		goto free_skb;
> >  	}
> > +	if (err > 0) {
> 
> } else if (err > 0) {
> 
> > +		atomic64_inc(&tun->rx_csum_sw);
> > +		err = 0;
> > +	}
> >  
> >  	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
> >  		skb->protocol = eth_type_trans(skb, tun->dev);
> > @@ -2605,12 +2611,15 @@ static int tun_xdp_one(struct tun_struct *tun,
> >  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
> >  	skb->dev = tun->dev;
> >  	skb_set_network_header(skb, ETH_HLEN);
> > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> > +	ret = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
> > +	if (ret < 0) {
> >  		atomic_long_inc(&tun->rx_frame_errors);
> >  		kfree_skb(skb);
> >  		ret = -EINVAL;
> >  		goto out;
> >  	}
> > +	if (ret > 0)
> 
> same
> 
> > +		atomic64_inc(&tun->rx_csum_sw);
> 
> maybe reset ret = 0 in all these branches
> 
> >  
> >  	skb->protocol = eth_type_trans(skb, tun->dev);
> >  	skb_reset_network_header(skb);
> > @@ -3739,7 +3748,35 @@ static void tun_get_channels(struct net_device *dev,
> >  	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
> >  }
> >  
> > +#define TUN_STATS_LEN	1
> > +static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] = {
> > +	"rx_csum_sw",
> > +};
> > +
> > +static int tun_get_sset_count(struct net_device *dev, int sset)
> > +{
> > +	return sset == ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
> > +}
> > +
> > +static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> > +{
> > +	if (stringset == ETH_SS_STATS)
> > +		memcpy(data, tun_ethtool_strings,
> > +		       sizeof(tun_ethtool_strings));
> > +}
> > +
> > +static void tun_get_ethtool_stats(struct net_device *dev,
> > +				  struct ethtool_stats *stats, u64 *data)
> > +{
> > +	struct tun_struct *tun = netdev_priv(dev);
> > +
> > +	data[0] = atomic64_read(&tun->rx_csum_sw);
> > +}
> > +
> >  static const struct ethtool_ops tun_ethtool_ops = {
> > +	.get_sset_count		= tun_get_sset_count,
> > +	.get_strings		= tun_get_strings,
> > +	.get_ethtool_stats	= tun_get_ethtool_stats,
> >  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
> >  	.get_drvinfo	= tun_get_drvinfo,
> >  	.get_msglevel	= tun_get_msglevel,
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index daab43ac92ce..2e6fd81df9c4 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
> >  	skb_set_network_header(skb, ETH_HLEN);
> >  	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> >  				      vi->rx_tnl_csum,
> > -				      virtio_is_little_endian(vi->vdev))) {
> > +				      virtio_is_little_endian(vi->vdev)) < 0) {
> >  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
> >  				     dev->name, hdr->hdr.gso_type,
> >  				     hdr->hdr.gso_size, hdr->hdr.flags,
> 
> should virtio_net count these too? Or do we assume that devices are
> more trustworthy, so unlikely to cause this issue?

With memory encryption, from an untrusted host?
i can add that.

> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 52ae3d875e97..e6aec9ecfa99 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
> >  		}
> >  
> >  		if (has_vnet_hdr) {
> > -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
> > +			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
> >  				tp_len = -EINVAL;
> >  				goto tpacket_error;
> >  			}
> > @@ -3136,7 +3136,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
> >  
> >  	if (vnet_hdr_sz) {
> >  		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
> > -		if (err)
> > +		if (err < 0)
> >  			goto out_free;
> >  		len += vnet_hdr_sz;
> >  	}
> > -- 
> > MST
> > 
> 

