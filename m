Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527005;
	b=rTeAXPTxg/OIyXXcNKYyZP8Uxb1Dw9YsG3xJWI+BrsPD5xYGDZAc3JB1mZhTfHTzUe0D
	 hZlv4DAeWK4b7ZPXGNbwd9AIerjzOiMaHlO/1wKA6YcXYhnAAC1ck2N3Pxq6NwWuckMzp
	 o9dFbF2S+Hm29Cs64NirSRdO+Hp3OQzvualKT+MwZ9wUUpQJEHWHCtitxDcEMVjCauTsr
	 PpRSCiq9tWEy9dIzNFdimpXw47+/kBsDm6URsWfS3miQSBUptJXnYPJuQGH/RQbCByIuC
	 wXhyXKNJUPGtX9I7Rm5YGbLX339OXZy1r7cCS+VVHcjR5PMSl+Z3nkF5C5wkMPifz5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527005;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=biyZRTLtYoa9JccTtADP7XVfeHu0cGOgCGXxzzSk5nY=;
	b=agfbiswoUshmklB8vBiHgbWXS+QuEcBpfm++/iCPU6xkQjoGKC3ndrkCuniRO1iscQch
	 7UbaQbQ7YlnsimtA8rkOYxSx2/r+1cKEmJjs/2zFVRxJ2r1LFNBm4UJXql0E6fYWwJYq8
	 RxxRe4fFE7bJolE9I14eizHvLXG2thebXrr/8mLyeH1YdkF2ydMy9lvGqXEluB6x5OZ7j
	 iFMyF5UnTIi1YGTqavHDPG4fZAfXLHoGXseZ4RJ9UGN/hv0sf9qp3jZCTQUNNkdFRjf9m
	 4HaZpFXB9OvHtM9TY0tfkUHWQcH8QjP7kAKMla2hhrQ4jq5QTO1YTW9/EtfiBac212w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZUHlkudy;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D2606A31F
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 20:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 074D2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZUHlkudy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792527004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=biyZRTLtYoa9JccTtADP7XVfeHu0cGOgCGXxzzSk5nY=;
	b=ZUHlkudyzyiKHSdwgfsL6/mRONAwiENVBzCn+FGVD3R9qttD0VjQHOFx/6YbD8389lIql2
	YZELH+QRTyCHSl1mKOUyGKWZsIT0QisHamVXQqi0NO8fZ4X9wIi+N0FxqTSX4J7qr8pxI6
	T3hbObXaB7bwwqZ3JgCtZzJBgvegaco=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-5X0zdv-_P9G_CrGWnS-6hg-1; Tue, 20 Oct 2026 16:09:56 -0400
X-MC-Unique: 5X0zdv-_P9G_CrGWnS-6hg-1
X-Mimecast-MFC-AGG-ID: 5X0zdv-_P9G_CrGWnS-6hg_1792526995
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1d1f26a63so126515e9.1
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 13:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792526995; x=1793131795;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=biyZRTLtYoa9JccTtADP7XVfeHu0cGOgCGXxzzSk5nY=;
        b=kS5YNiMhSRN3vVBNeHqmwrKCV8RCxX5nFEYd13Q++XwenuiQDq49khTeImo3k4Vzf2
         sP9PrH5PuSDwGvh/fgkly6Uswq10pRRS/eQZEnxjtHivm1ddJj4NLX+ZWmxTVmQ2rr9v
         KcmQqh/EvoD9xrkuVpjrMwWsOozX7Y5428mELXuqQzfMpFlbhdgUHWNu4CgC2b1rwhz1
         l/2GYruxY27H6jYmVuFYxP+2+mnBO2dZVFrwdd4Ypc1ktAytRvHgPvkocU2CvJWhMoU7
         bXVba5ZUIMDsp46hIPWnnYue9GNN+sNaNWBPgTmYhd/kxPbq9WGJI6sTXD1sfNR53aAh
         7F4Q==
X-Forwarded-Encrypted: i=1; AKwUvBz55SUgH6EjN1KXa6HH4KMLkXYIuaS9IOt8PdDG3WTo5HRswBXQAzeYNqYKrCtjk+Rt8UlbJDEOFfrR/WJkNg==@lists.linux.dev
X-Gm-Message-State: AFq9FYInT13zpZmtgallNpWSqWTgo8VHQ+YjByrYKjudJFfPV0z0OiUc
	gQY3pAD76RsRIzTNsoD/ohfKB1JucghgQNE8cKUwkXEkKCb+ig3UCA1jwg/UkKPLPLKPcUXaLVf
	EbBHMPQGCP0xwgwwVVihQanewYgTBeJN5RfiQD0pIRpLlPIuDVN2yk8bwO39rfnVeL4D+
X-Gm-Gg: AYBFou0Fu0ynGwhgYEmIzPPAUmhGjI94nllkdVFsm7sCVASLcX/wQi3sQR9WKQZ5Bir
	1GX0LNnyg/dVzy0kJ/4AulQklpWAqhpHa4T2zESFejBL/Vlz/kn6t2x/yVAQvzW+hbHbP/JQPYQ
	fV2cFFlRBISOCy8VQ3dHgz+LActOGVWqgIVjhon0pEGsbj9LyJYgSB1Y5EwD3u/HR39SGCVF6Q9
	CF/VG33wcEsqAHfKh6foEJv1VN8IPPpJXbnjWSzXQBt1aP2H0gmLPgGcQrqeoZQ72gYx7Kks5pS
	6h53TwgEM7fCcQkAJW1QNx79Z9MzdXzHGJEZisRJltGwFrLXtFhjNoEQM4dQQrFz4Mf/Pw==
X-Received: by 2002:a05:600c:3b1c:b0:4a1:d248:25c4 with SMTP id 5b1f17b1804b1-4a1d76046dbmr262528875e9.13.1792526995048;
        Tue, 20 Oct 2026 13:09:55 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1c:b0:4a1:d248:25c4 with SMTP id 5b1f17b1804b1-4a1d76046dbmr262528445e9.13.1792526994567;
        Tue, 20 Oct 2026 13:09:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc10de99sm10206805e9.1.2026.10.20.13.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 13:09:53 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:09:50 -0400
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
Message-ID: <20261020160829-mutt-send-email-mst@kernel.org>
References: <cover.1792411304.git.mst@redhat.com>
 <b1dce3e055b973bd87bdbdc9e9729971fa383326.1792411304.git.mst@redhat.com>
 <willemdebruijn.kernel.26f697d5a674b@gmail.com>
 <20261020153650-mutt-send-email-mst@kernel.org>
 <willemdebruijn.kernel.57aa9aa58b62@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <willemdebruijn.kernel.57aa9aa58b62@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mAjr-5u9dDP8m3rpJ8aVxdFlhcyP__cZpWSwt2L9RiQ_1792526995
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2026 at 04:02:26PM -0400, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
> > On Tue, Oct 20, 2026 at 03:27:46PM -0400, Willem de Bruijn wrote:
> > > Michael S. Tsirkin wrote:
> > > > The following patch will add ingress resolution of uncommon virtio net
> > > > hdr checksum metadata (software checksum completion at ingress) which
> > > > adds performance overhead to the packet processing.
> > > > 
> > > > We should make it visible, so a hypothetical workload relying on
> > > > uncommon metadata can be distinguished from none at all. This way issues
> > > > in the parsing will be reported and not quietly pay the host-CPU
> > > > checksum overhead instead of offload.
> > > > 
> > > > Flip every call to virtio_net_hdr_to_skb to test for negative errno
> > > > only, and have tun count these events per device as rx_csum_sw, exposed
> > > > via ethtool -S.
> > > > 
> > > > Assisted-by: LLM
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > >  drivers/net/tap.c        |  4 ++--
> > > >  drivers/net/tun.c        | 41 ++++++++++++++++++++++++++++++++++++++--
> > > >  drivers/net/virtio_net.c |  2 +-
> > > >  net/packet/af_packet.c   |  4 ++--
> > > >  4 files changed, 44 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> > > > index ff67d99deb39..73e883394446 100644
> > > > --- a/drivers/net/tap.c
> > > > +++ b/drivers/net/tap.c
> > > > @@ -649,7 +649,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
> > > >  
> > > >  	if (vnet_hdr_len) {
> > > >  		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
> > > > -		if (err) {
> > > > +		if (err < 0) {
> > > >  			rcu_read_unlock();
> > > >  			drop_reason = SKB_DROP_REASON_DEV_HDR;
> > > >  			goto err_kfree;
> > > > @@ -1084,7 +1084,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
> > > >  
> > > >  	if (vnet_hdr_len) {
> > > >  		err = tun_vnet_hdr_to_skb(q->flags, skb, gso);
> > > > -		if (err) {
> > > > +		if (err < 0) {
> > > >  			rcu_read_unlock();
> > > >  			goto err_kfree;
> > > >  		}
> > > 
> > > similar to tun, should tap count this event?
> > > 
> > > > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > > > index 242899f7fd07..19cb443c89b0 100644
> > > > --- a/drivers/net/tun.c
> > > > +++ b/drivers/net/tun.c
> > > > @@ -210,6 +210,7 @@ struct tun_struct {
> > > >  	u32 flow_count;
> > > >  	u32 rx_batched;
> > > >  	atomic_long_t rx_frame_errors;
> > > > +	atomic64_t rx_csum_sw;
> > > 
> > > is a normal (and cheaper on 32b platforms) atomic_t or atomic_long_t sufficient?
> > 
> > well it can overflow easily. i don't know that we care that a slow
> > path will be even a bit slower on these ancient platforms. correct
> > reporting seems more important.
> 
> Ok. I would hope that monitoring catches this before it hits 4B, but
> agreed that as slow path it doesn't matter.
> 
> > 
> > > >  	struct bpf_prog __rcu *xdp_prog;
> > > >  	struct tun_prog __rcu *steering_prog;
> > > >  	struct tun_prog __rcu *filter_prog;
> > > > @@ -1935,11 +1936,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
> > > >  		break;
> > > >  	}
> > > >  
> > > > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> > > > +	err = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr);
> > > > +	if (err < 0) {
> > > >  		atomic_long_inc(&tun->rx_frame_errors);
> > > >  		err = -EINVAL;
> > > >  		goto free_skb;
> > > >  	}
> > > > +	if (err > 0) {
> > > 
> > > } else if (err > 0) {
> > > 
> > > > +		atomic64_inc(&tun->rx_csum_sw);
> > > > +		err = 0;
> > > > +	}
> > > >  
> > > >  	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
> > > >  		skb->protocol = eth_type_trans(skb, tun->dev);
> > > > @@ -2605,12 +2611,15 @@ static int tun_xdp_one(struct tun_struct *tun,
> > > >  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
> > > >  	skb->dev = tun->dev;
> > > >  	skb_set_network_header(skb, ETH_HLEN);
> > > > -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> > > > +	ret = tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr);
> > > > +	if (ret < 0) {
> > > >  		atomic_long_inc(&tun->rx_frame_errors);
> > > >  		kfree_skb(skb);
> > > >  		ret = -EINVAL;
> > > >  		goto out;
> > > >  	}
> > > > +	if (ret > 0)
> > > 
> > > same
> > > 
> > > > +		atomic64_inc(&tun->rx_csum_sw);
> > > 
> > > maybe reset ret = 0 in all these branches
> > > 
> > > >  
> > > >  	skb->protocol = eth_type_trans(skb, tun->dev);
> > > >  	skb_reset_network_header(skb);
> > > > @@ -3739,7 +3748,35 @@ static void tun_get_channels(struct net_device *dev,
> > > >  	channels->max_combined = tun->flags & IFF_MULTI_QUEUE ? MAX_TAP_QUEUES : 1;
> > > >  }
> > > >  
> > > > +#define TUN_STATS_LEN	1
> > > > +static const char tun_ethtool_strings[TUN_STATS_LEN][ETH_GSTRING_LEN] = {
> > > > +	"rx_csum_sw",
> > > > +};
> > > > +
> > > > +static int tun_get_sset_count(struct net_device *dev, int sset)
> > > > +{
> > > > +	return sset == ETH_SS_STATS ? TUN_STATS_LEN : -EOPNOTSUPP;
> > > > +}
> > > > +
> > > > +static void tun_get_strings(struct net_device *dev, u32 stringset, u8 *data)
> > > > +{
> > > > +	if (stringset == ETH_SS_STATS)
> > > > +		memcpy(data, tun_ethtool_strings,
> > > > +		       sizeof(tun_ethtool_strings));
> > > > +}
> > > > +
> > > > +static void tun_get_ethtool_stats(struct net_device *dev,
> > > > +				  struct ethtool_stats *stats, u64 *data)
> > > > +{
> > > > +	struct tun_struct *tun = netdev_priv(dev);
> > > > +
> > > > +	data[0] = atomic64_read(&tun->rx_csum_sw);
> > > > +}
> > > > +
> > > >  static const struct ethtool_ops tun_ethtool_ops = {
> > > > +	.get_sset_count		= tun_get_sset_count,
> > > > +	.get_strings		= tun_get_strings,
> > > > +	.get_ethtool_stats	= tun_get_ethtool_stats,
> > > >  	.supported_coalesce_params = ETHTOOL_COALESCE_RX_MAX_FRAMES,
> > > >  	.get_drvinfo	= tun_get_drvinfo,
> > > >  	.get_msglevel	= tun_get_msglevel,
> > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > index daab43ac92ce..2e6fd81df9c4 100644
> > > > --- a/drivers/net/virtio_net.c
> > > > +++ b/drivers/net/virtio_net.c
> > > > @@ -2519,7 +2519,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
> > > >  	skb_set_network_header(skb, ETH_HLEN);
> > > >  	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> > > >  				      vi->rx_tnl_csum,
> > > > -				      virtio_is_little_endian(vi->vdev))) {
> > > > +				      virtio_is_little_endian(vi->vdev)) < 0) {
> > > >  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
> > > >  				     dev->name, hdr->hdr.gso_type,
> > > >  				     hdr->hdr.gso_size, hdr->hdr.flags,
> > > 
> > > should virtio_net count these too? Or do we assume that devices are
> > > more trustworthy, so unlikely to cause this issue?
> > 
> > With memory encryption, from an untrusted host?
> > i can add that.
> 
> I honestly don't know if it's worth the effort. Just curious whether
> you had purposely skipped this and tap.

more like it slipped my mind.

> > 
> > > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > > index 52ae3d875e97..e6aec9ecfa99 100644
> > > > --- a/net/packet/af_packet.c
> > > > +++ b/net/packet/af_packet.c
> > > > @@ -2913,7 +2913,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
> > > >  		}
> > > >  
> > > >  		if (has_vnet_hdr) {
> > > > -			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le())) {
> > > > +			if (virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le()) < 0) {
> > > >  				tp_len = -EINVAL;
> > > >  				goto tpacket_error;
> > > >  			}
> > > > @@ -3136,7 +3136,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
> > > >  
> > > >  	if (vnet_hdr_sz) {
> > > >  		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
> > > > -		if (err)
> > > > +		if (err < 0)
> > > >  			goto out_free;
> > > >  		len += vnet_hdr_sz;
> > > >  	}
> > > > -- 
> > > > MST
> > > > 
> > > 
> > 
> 

