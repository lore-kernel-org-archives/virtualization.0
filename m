Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792526549;
	b=Qqky4NRr4NlQ06G3P1zPnkbFBhDDLS1vwB53AixStaSRNkw5j2Amcch978CnPq0PO7Mz
	 Q7Zoti8f0jOGQKhv5LCo6E6YdkQoem1ErDcUgtoHwZLmT9uUqKIwtNPx+qkgTb01aa6+M
	 lbqmn1qTmg5foseTils17J8LdETnXdUFlRpy+zbLK66wqsmARpkMm9Dvmo7YRRaMjAwKE
	 qLEkSTGB6ia7KXh3Ice/zrW5IbeqIxosUcR2ddFgqmNYLADMP9HVTfyxQwCAWUBYiF7Xv
	 YSIO+ulzOiH+O/vtq9r79D7DjetMgUg8MM1wHdeMzH8vBAYiDqvsw2iFDzjiSg4eoyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792526549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8ZysMSfbg6fBNJbq7ExrYH4kJLqlOfTHrM/s3F+kdh8=;
	b=NReXJmhJ/ryrM2sUOXf1HXfuN3lT18fKkSXHppaCtJR9+KaGavxY3O2+HnBD0DoEAt8K
	 9Jgh25GUCzW0yfiEwllrH1HiHE5hbh8wkDfr97dKUwLTh+CKnJ8b1+fxbgIRDyOxGEajp
	 E95fHdvMJYVvA3BaaurQ54IytfD5Dt/6+ywhleMQKCpkWoK9N+xGWjxeZIAPjT9uKivmG
	 W7ovNs8MU5xJMgAm0OJuw6I0Dind/Ut328ywykh+rI3SKFIUKDMXm5j9AnHoWg0A7rdOr
	 k7BZcwZnzxzafEfQkwTtv2kV9M1SRBlQDs8+5TCptdM6G1KoXhDDBZXetBwBFhvkbmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="lMayXz/1";
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F17606A31A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 20:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15F17606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lMayXz/1
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7cc013095d4so17091137.2
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 13:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792526548; x=1793131348; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8ZysMSfbg6fBNJbq7ExrYH4kJLqlOfTHrM/s3F+kdh8=;
        b=lMayXz/1NrUFAW9W46jTkj3MrKMy34dohElpFAGFYFMvpr+8pi1qVNuIQ+SP7svyOK
         9SmCblThi3r3iptL5ylPMccjhPNz37784OszXe1+S19UB+T99nkSBJkexuBji6DE59nm
         OCqH/a9cKsTl+l6nyrwWiJzxMoQMVK7P8ImjmeRj6yCQuq2iZUDVY1NzHubdSU1VR8Ik
         /KCK9Y2J/TifuYZxJDUY7JVeU+VyOLQvb0JSdALN5DiD71VaDQ7Y/6HVx323bKioRm73
         JGw+gC/DIkugk7/0t0qSN8vsHZefVXud21ehTuCHCfC1JPQ3vnOsA+ceN8zk2VvNCoEZ
         KyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526548; x=1793131348;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ZysMSfbg6fBNJbq7ExrYH4kJLqlOfTHrM/s3F+kdh8=;
        b=L2MllfD84HVPzPYRe9vBZdgFI8M0jh2Jcq1ZaI6jeMpSKllduObVtvITpTcZRJ4dbT
         eAejreUM03q5T9cK+GOUvAr4vZ2+wtEtju03Ga+so39mKyjpOrKrvxx51TcYbafflwzP
         E3+tnHI7PUkGRs0rxxaejBHeesOYdOx4TDdYZsX4T/rKKTEGsuYHaCHoAufqyz7coqWV
         KXURDCBARdMac+Y2/GKqDyL36KqMS49Ioa2+qryhsF3VScNs2etvPMErmQZpnO+PoTC9
         Qm2PvYmQPev2y6I3O5QnCBU0KOhTtgWtviZTLz55xAZ2ALtG2DzteM41hZm9i5RjlS27
         h8fQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/rCc8Qy8Bp/0eExl28BPA7has7p9/2KDC/X7F3I+cQ9tIGzheTMz+qQk2T6+DDJeCgoI0JGxy079YODOPYQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLfGRNZ0fWapUoRe2UCOQ+dF+QMGk3qqhR/F+4EnpJAU9/r9m64
	jPa3exfqSYXYcH8a+XH1jYbiCPvO2uwSE7im/pzrbkSUvyeUD2TRgomZ
X-Gm-Gg: AYBFou2Qlh7b8swmx/2fx+6PHYUggKlkKWqUScr6mAZZGpXEejW1yI5ZVbPVRaRPcF7
	TIMXvfO30GVO6zs8452puX/JG7EgrMn/ncgRBWaL4YHjH0TIbL5oSE1EefSDi4a8PJ+0zaTnXdE
	iIqaTYN2bCetv03Vx12uERreg7OS0l2AvQXsLNN7fnZEdL7O7gnwQh28hzrtUl2FGDNAgqf/aZH
	w2NafAhWdvLOdT1bXYzYMYztdl8ksZ90UlVimAuikTgRI8JJtLEw4Yscs40Lx2YYU5+GkGLDCU2
	lD51JzKa1/TL9CV5F136UTU7ro991qkJENrXgir/pC68lDRaG/V/O4ChSohIjcXV8TCjASCCwDM
	lmvBcpNFUxe4RxJ98aUmQ9bqLw3CKts6icM1fgW3xLf62Px17YQLX08nmJv3EuQFmLsjHvylPQR
	lCIDcBv15Glc5nbMXT730yegb8IP+FqxPqYxZt0ipMek3K/hZQGumwBIkiLroDK+p44sdEygHvN
	exZTgPJP/zoH07vC7J/TqdlC0TZD6Osd/Do97JgtrfIvUCVXVcfNnVZZa5yKWMJROSP+wUmDpXt
	6BICNtVffNX//jnUjZc7X4VZ306McPl4FrVVsg==
X-Received: by 2002:a05:6102:38ca:b0:7b2:508e:3d57 with SMTP id ada2fe7eead31-7cc92469ef4mr87919137.4.1792526547926;
        Tue, 20 Oct 2026 13:02:27 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc9236f63csm306154137.5.2026.10.20.13.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:02:26 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:02:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
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
 Simon Horman <horms@kernel.org>
Message-ID: <willemdebruijn.kernel.57aa9aa58b62@gmail.com>
In-Reply-To: <20261020153650-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.26f697d5a674b@gmail.com>
 <20261020153650-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net v3 1/8] net: account for ingress-resolved virtio net
 hdr state
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
> On Tue, Oct 20, 2026 at 03:27:46PM -0400, Willem de Bruijn wrote:
> > Michael S. Tsirkin wrote:
> > > The following patch will add ingress resolution of uncommon virtio net
> > > hdr checksum metadata (software checksum completion at ingress) which
> > > adds performance overhead to the packet processing.
> > > 
> > > We should make it visible, so a hypothetical workload relying on
> > > uncommon metadata can be distinguished from none at all. This way issues
> > > in the parsing will be reported and not quietly pay the host-CPU
> > > checksum overhead instead of offload.
> > > 
> > > Flip every call to virtio_net_hdr_to_skb to test for negative errno
> > > only, and have tun count these events per device as rx_csum_sw, exposed
> > > via ethtool -S.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/net/tap.c        |  4 ++--
> > >  drivers/net/tun.c        | 41 ++++++++++++++++++++++++++++++++++++++--
> > >  drivers/net/virtio_net.c |  2 +-
> > >  net/packet/af_packet.c   |  4 ++--
> > >  4 files changed, 44 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > > index ff67d99deb39..73e883394446 100644
> > > --- a/drivers/net/tap.c
> > > +++ b/drivers/net/tap.c
> > > @@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> > >  
> > >  	if (vnet_hdr_len) {
> > >  		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
> > > -		if (err) {
> > > +		if (err < 0) {
> > >  			rcu_read_unlock();
> > >  			drop_reason = SKB_DROP_REASON_DEV_HDR;
> > >  			goto err_kfree;
> > > @@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> > >  
> > >  	if (vnet_hdr_len) {
> > >  		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
> > > -		if (err) {
> > > +		if (err < 0) {
> > >  			rcu_read_unlock();
> > >  			goto err_kfree;
> > >  		}
> > 
> > similar to tun, should tap count this event?
> > 
> > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > index 242899f7fd07..19cb443c89b0 100644
> > > --- a/drivers/net/tun.c
> > > +++ b/drivers/net/tun.c
> > > @@ -210,6 +210,7 @@ struct tun_struct {
> > >  	u32 flow_count;
> > >  	u32 rx_batched;
> > >  	atomic_long_t rx_frame_errors;
> > > +	atomic64_t rx_csum_sw;
> > 
> > is a normal (and cheaper on 32b platforms) atomic_t or atomic_long_t sufficient?
> 
> well it can overflow easily. i don't know that we care that a slow
> path will be even a bit slower on these ancient platforms. correct
> reporting seems more important.

Ok. I would hope that monitoring catches this before it hits 4B, but
agreed that as slow path it doesn't matter.

> 
> > >  	struct bpf_prog __rcu *xdp_prog;
> > >  	struct tun_prog __rcu *steering_prog;
> > >  	struct tun_prog __rcu *filter_prog;
> > > @@ -1935,11 +1936,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> > >  		break;
> > >  	}
> > >  
> > > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> > > +	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
> > > +	if (err < 0) {
> > >  		atomic_long_inc(&tun->rx_frame_errors);
> > >  		err = -EINVAL;
> > >  		goto free_skb;
> > >  	}
> > > +	if (err > 0) {
> > 
> > } else if (err > 0) {
> > 
> > > +		atomic64_inc(&tun->rx_csum_sw);
> > > +		err = 0;
> > > +	}
> > >  
> > >  	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
> > >  		skb->protocol = eth_type_trans(skb, tun->dev);
> > > @@ -2605,12 +2611,15 @@ static int tun_xdp_one(struct tun_struct *tun,
> > >  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
> > >  	skb->dev = tun->dev;
> > >  	skb_set_network_header(skb, ETH_HLEN);
> > > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> > > +	ret = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
> > > +	if (ret < 0) {
> > >  		atomic_long_inc(&tun->rx_frame_errors);
> > >  		kfree_skb(skb);
> > >  		ret = -EINVAL;
> > >  		goto out;
> > >  	}
> > > +	if (ret > 0)
> > 
> > same
> > 
> > > +		atomic64_inc(&tun->rx_csum_sw);
> > 
> > maybe reset ret = 0 in all these branches
> > 
> > >  
> > >  	skb->protocol = eth_type_trans(skb, tun->dev);
> > >  	skb_reset_network_header(skb);
> > > @@ -3739,7 +3748,35 @@ static void tun_get_channels(struct net_device *dev,
> > >  	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
> > >  }
> > >  
> > > +#define TUN_STATS_LEN	1
> > > +static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] = {
> > > +	"rx_csum_sw",
> > > +};
> > > +
> > > +static int tun_get_sset_count(struct net_device *dev, int sset)
> > > +{
> > > +	return sset == ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
> > > +}
> > > +
> > > +static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> > > +{
> > > +	if (stringset == ETH_SS_STATS)
> > > +		memcpy(data, tun_ethtool_strings,
> > > +		       sizeof(tun_ethtool_strings));
> > > +}
> > > +
> > > +static void tun_get_ethtool_stats(struct net_device *dev,
> > > +				  struct ethtool_stats *stats, u64 *data)
> > > +{
> > > +	struct tun_struct *tun = netdev_priv(dev);
> > > +
> > > +	data[0] = atomic64_read(&tun->rx_csum_sw);
> > > +}
> > > +
> > >  static const struct ethtool_ops tun_ethtool_ops = {
> > > +	.get_sset_count		= tun_get_sset_count,
> > > +	.get_strings		= tun_get_strings,
> > > +	.get_ethtool_stats	= tun_get_ethtool_stats,
> > >  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
> > >  	.get_drvinfo	= tun_get_drvinfo,
> > >  	.get_msglevel	= tun_get_msglevel,
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index daab43ac92ce..2e6fd81df9c4 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
> > >  	skb_set_network_header(skb, ETH_HLEN);
> > >  	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> > >  				      vi->rx_tnl_csum,
> > > -				      virtio_is_little_endian(vi->vdev))) {
> > > +				      virtio_is_little_endian(vi->vdev)) < 0) {
> > >  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
> > >  				     dev->name, hdr->hdr.gso_type,
> > >  				     hdr->hdr.gso_size, hdr->hdr.flags,
> > 
> > should virtio_net count these too? Or do we assume that devices are
> > more trustworthy, so unlikely to cause this issue?
> 
> With memory encryption, from an untrusted host?
> i can add that.

I honestly don't know if it's worth the effort. Just curious whether
you had purposely skipped this and tap.
> 
> > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > index 52ae3d875e97..e6aec9ecfa99 100644
> > > --- a/net/packet/af_packet.c
> > > +++ b/net/packet/af_packet.c
> > > @@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
> > >  		}
> > >  
> > >  		if (has_vnet_hdr) {
> > > -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
> > > +			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
> > >  				tp_len = -EINVAL;
> > >  				goto tpacket_error;
> > >  			}
> > > @@ -3136,7 +3136,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
> > >  
> > >  	if (vnet_hdr_sz) {
> > >  		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
> > > -		if (err)
> > > +		if (err < 0)
> > >  			goto out_free;
> > >  		len += vnet_hdr_sz;
> > >  	}
> > > -- 
> > > MST
> > > 
> > 
> 


