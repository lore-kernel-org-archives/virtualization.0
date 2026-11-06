Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957287;
	b=pVhDVLKrSHvPtTcttzlgoBlhnhC9wpV2uzLv/UfiSKWJAxggPeI2/nhedd+GG0yUuNtu
	 auWC9i2H7dYXUyeXyxbNYSYcoGRPCGjk2e/A1+jeZozbsYWX01KnzXWdgUdk+UHlOzRh4
	 WTHOABfa4EcneXwMkXNYoYHgYpyhCK4OTzRlaTvl627kXLgHKkLciMJbycl7u1vvLjMXf
	 RF10ogEK0nCfLuWKgThqk8WovItlA0lYjPpXLk8Mo0zGAVOxhno3fkLmD/c+bz9wByg3I
	 dy9YYIO0y8XVLlStX0ZVNxxdPu7ZwKLpQ7HJ1xvp/09iYVp82sJyYdk2VxKmeYZ3Xog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957287;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=fszTkOxXJjM0EYFwIAQ+ySQBrU3sfgT5b3oAiln/BOM=;
	b=lYPUTb39ioLQIGlwYdtFjDG8lNQbN1o17SFb+ktQUFZK+J/fvMiGVZE+i741JP28i5bk
	 36EP7wE7sHfngsIdH3kE4gCW3e11lJsWiKROTgUP6EeJvcmFqEoxNs60ORMC0y7dX0r2j
	 D9h0wzm25qW8g3XK/bsUscCDIlzJwbOs+B+iXZ39VDrPNweg41ZbmeWuKLu7lKE9abHu4
	 w77Bm6cU2i2SFoNjpaL7apsbbOlY7qukihWNQu1vXLJ5A8Ldh7DVfaEcagWQAcBcF0Fe5
	 6dHFyC8H7STxUbvs1VBGMkKbTEkco9Wp8z4xTBeFBqHbeSf/oMm+RaVatyXBJeMbmbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="S/aLais3";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C4A606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 09:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C4A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=S/aLais3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793957285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fszTkOxXJjM0EYFwIAQ+ySQBrU3sfgT5b3oAiln/BOM=;
	b=S/aLais3UyujT3jL9RjhcI2p1nw1+uLNEUpmOoCGAMCvLEmSebCwtncpEbHJ4fyHy/mRiE
	A1kXgzg51BYHzv5JsHCQjRCS2ZiJX703t9H6OIn/o6Ycpufpp4Y9Hg4j0lFTnBs3Hv/U0m
	4PkoztCZF5wag5cpKtwUr3EbXw66uGc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-szK1MnoGN1itshJUrma8lw-1; Fri, 06 Nov 2026 04:28:04 -0500
X-MC-Unique: szK1MnoGN1itshJUrma8lw-1
X-Mimecast-MFC-AGG-ID: szK1MnoGN1itshJUrma8lw_1793957283
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a9d51dc486so10370465e9.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 01:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957283; x=1794562083;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fszTkOxXJjM0EYFwIAQ+ySQBrU3sfgT5b3oAiln/BOM=;
        b=YbrehhseuuqhYcHIw0yJNTEuaKjlG0l4AibsupgLyWUhV+ngyNg0SZ+eBvDQE2ciTe
         WKtdBJWLbiCAqa3Z6MgOoVfjFrj9gpPmWtF0d2YRop/sfR8WMWAwh22JuRaku0P031B2
         Ukwe0mO4fRM8BGIsDLROU82qw/njszWOUVt3Z+90RtqvRZeyYbQSRRHYjT8ntnKXr32Y
         g2uekq902iBJue4yp9qNWnijRDNiV2X9NoDceArVcT42/PYlqhLX/cRwTvfu3ZyWdMob
         3TYT7CpDVO7ODe60fDbIQirqWa+PZUmSEFvwXnlTBQ9d5Rg7q6IPyl+GxF9Q+8P0MBLT
         UUeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWYHZnUU9vcpeIT0gonJC4CjzT8YiTQXuPbPQYgo+uJ1zRXjDi0khZ94h49TQ1cqsvBd8uXAyqg6HlZnp4Lw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+L2qJ+W5Y1NEvdk5qmPxaGoN5Fjf3A8oTZxTLSd57fcy+zmvhM
	DEo087/n612uduem53eVNk3ieteBjPPxF95P8PdeR76l+BY5NY71fXBm9vlke3lkSgnHPjRt0G6
	MAeqTk71f5sMWHDykGzpK2sG//KUxeBs4XD2KMe3T1TtbaU/3wQJlc2/KU5YsRGb3AE6N
X-Gm-Gg: AYBFou3u1RlKgom1PxDbnhW7el7cDLnniuvSV0qwtCkZlKp113kK28negH2z5DJFBPo
	7L/OOZD/gqAN0aRHM/13lyjDdnjApvgfVp4IhJ3yCX38B/ZBaTt60S63jsNMSukxKukKY9qvRz1
	oR947J8/1n3zTjUZlpIm6aFqA3p4o1c1TMhBInQydvO9TEg92PyHUbeE1TH0NjD2pFHHrdqc8pB
	hjkS73AMxHWjaIT2opzo1dgUtf/ZUFaz0qrMjgKtm9DmVc3jLrrmogAnicNupRCMsWLsuJnpZUM
	UietlWpR/gR1ViG1KbmKq3oaTtMwqVwBrQQpZv3xabaYlu1LDIdsh8YEa3pMj3kgv+ZGAR5W11H
	VIyoO97d2OD3PkDnCMWhTpSjffa6+I+AWhlo2zebH/Q==
X-Received: by 2002:a05:600c:c87:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4b6dff855c7mr27874445e9.13.1793957282602;
        Fri, 06 Nov 2026 01:28:02 -0800 (PST)
X-Received: by 2002:a05:600c:c87:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4b6dff855c7mr27874045e9.13.1793957282051;
        Fri, 06 Nov 2026 01:28:02 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1401:db00:7367:7b9e:e66f:2b7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba0f3sm120602055e9.9.2026.11.06.01.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:28:01 -0800 (PST)
Date: Fri, 6 Nov 2026 04:27:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Hassan Sultan <hassansultan@google.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v3 2/8] net: virtio: do not use dev->type to find the
 outer L3 header
Message-ID: <20261106042744-mutt-send-email-mst@kernel.org>
References: <20261105115715.1466924-1-edumazet@kernel.org>
 <20261105115715.1466924-3-edumazet@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261105115715.1466924-3-edumazet@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WXBqApXHe9NeeyIjh91I1R05abyBonKiEX0d9J3lygs_1793957283
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2026 at 12:57:09PM +0100, Eric Dumazet wrote:
> virtio_net_l3_start() decides from skb->dev->type whether the frame
> starts with an Ethernet header. tun decides it from the IFF_TAP and
> IFF_TUN flags, and TUNSETLINK can set the type of a down tun device
> to any value, without changing the flags.
> 
> On an IFF_TAP device set to ARPHRD_NONE, the outer protocol checks
> look at the IP header at the network header (ETH_HLEN), and never read
> the Ethernet header. eth_type_trans() then sets skb->protocol from an
> unchecked h_proto, for instance ETH_P_NSH, and the packet can reach
> the skb_under_panic() addressed by the previous patch.
> 
> On an IFF_TUN device set to ARPHRD_ETHER, the checks validate an
> Ethernet header that tun then treats as the start of the L3 header.
> 
> Checking in tun that the device type matches the framing is not
> enough: the type is read again later, and a concurrent TUNSETLINK can
> change it in between, since tun_get_user() only drops packets of a
> down device after these checks.
> 
> Add a has_eth argument to virtio_net_hdr_tnl_to_skb(), passed down to
> virtio_net_l3_start(), so the device type is no longer used:
> 
> - virtio_net always receives Ethernet frames.
> - tun_get_user() passes whether the device is IFF_TAP.
> - tun_xdp_one() always calls eth_type_trans() on its frames.
> 
> Fixes: 288f30435132 ("tun: enable gso over UDP tunnel support.")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/sashiko-outbox-198573@kernel.org/
> Link: https://lore.kernel.org/netdev/179387332014.488856.9111956413610107951@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/tun.c          |  9 +++++++--
>  drivers/net/tun_vnet.h     |  5 +++--
>  drivers/net/virtio_net.c   |  2 +-
>  include/linux/virtio_net.h | 27 +++++++++++++--------------
>  4 files changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index dcec7311e601..3920b3dff1e8 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1944,7 +1944,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		break;
>  	}
>  
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr,
> +				    (tun->flags & TUN_TYPE_MASK) == IFF_TAP)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		err = -EINVAL;
>  		goto free_skb;
> @@ -2621,7 +2622,11 @@ static int tun_xdp_one(struct tun_struct *tun,
>  	tnl_hdr = (struct virtio_net_hdr_v1_hash_tunnel *)gso;
>  	skb->dev = tun->dev;
>  	skb_set_network_header(skb, ETH_HLEN);
> -	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr)) {
> +	/* Frames always start with an Ethernet header here, as the
> +	 * eth_type_trans() call below expects.
> +	 */
> +	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, tnl_hdr,
> +				    true)) {
>  		atomic_long_inc(&tun->rx_frame_errors);
>  		kfree_skb(skb);
>  		ret = -EINVAL;
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index f4c652b1fa44..3364e08dd6e0 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -197,9 +197,10 @@ static inline netdev_features_t tun_vnet_hdr_guest_features(int vnet_hdr_sz)
>  static inline int
>  tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
>  			struct sk_buff *skb,
> -			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
> +			const struct virtio_net_hdr_v1_hash_tunnel *hdr,
> +			bool has_eth)
>  {
> -	return virtio_net_hdr_tnl_to_skb(skb, hdr,
> +	return virtio_net_hdr_tnl_to_skb(skb, hdr, has_eth,
>  				features & NETIF_F_GSO_UDP_TUNNEL,
>  				features & NETIF_F_GSO_UDP_TUNNEL_CSUM,
>  				tun_vnet_is_little_endian(flags));
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe..ed20e76fbc4c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2533,7 +2533,7 @@ static void virtnet_receive_done(struct virtnet_info *vi, struct receive_queue *
>  
>  	skb->dev = dev;
>  	skb_set_network_header(skb, ETH_HLEN);
> -	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
> +	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, true, vi->rx_tnl,
>  				      vi->rx_tnl_csum,
>  				      virtio_is_little_endian(vi->vdev))) {
>  		net_warn_ratelimited("%s: bad gso: type: %x, size: %u, flags %x tunnel %d tnl csum %d\n",
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 357116c2a148..b7b6b542f476 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -87,20 +87,18 @@ static inline struct iphdr *virtio_net_ip4_parse(struct sk_buff *skb,
>  }
>  
>  /* Where does the L3 header start, and what protocol is it?
> - * Handles Ethernet and VLAN headers; other devices use the
> - * network header offset the caller set up.
> + * With @has_eth, the frame starts with an Ethernet header, possibly
> + * followed by VLAN tags. Otherwise the L3 header starts at the network
> + * header offset the caller set up.
> + *
> + * The caller knows how the frame will be parsed later: the device
> + * type does not tell, as tun can change it with TUNSETLINK.
>   */
>  static inline bool
> -virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +virtio_net_l3_start(struct sk_buff *skb, bool has_eth, int *nhoff,
> +		    __be16 *proto)
>  {
> -	/* skb->dev should always be set here already,
> -	 * but let's not crash when it is not.
> -	 */
> -	if (WARN_ON_ONCE(!skb->dev))
> -		return false;
> -
> -	if (skb->dev->type == ARPHRD_ETHER ||
> -	    skb->dev->type == ARPHRD_LOOPBACK) {
> +	if (has_eth) {
>  		__be16 h_proto;
>  
>  		if (!pskb_may_pull(skb, ETH_HLEN))
> @@ -431,7 +429,7 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>   * carries, with UDP following it at @outer_th.
>   */
>  static inline bool
> -virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool outer_isv6,
>  			  unsigned int outer_th)
>  {
>  	int nhoff;
> @@ -439,7 +437,7 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
>  	unsigned int thoff;
>  	int ip_proto;
>  
> -	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> +	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
>  		return false;
>  	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
>  		return false;
> @@ -452,6 +450,7 @@ virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> +			  bool has_eth,
>  			  bool tnl_hdr_negotiated,
>  			  bool tnl_csum_negotiated,
>  			  bool little_endian)
> @@ -505,7 +504,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	if (ret)
>  		return ret;
>  
> -	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +	if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th))
>  		return -EINVAL;
>  
>  	/* In case of USO, the inner protocol is still unknown and
> -- 
> 2.53.0

