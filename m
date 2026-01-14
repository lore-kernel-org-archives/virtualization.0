Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800F38734C
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380833; cv=none; b=Ug44rtRsLp/xApOubeZlH/WOqJRY3vIoxWIO51OZ78j3gur8lBNYgYZQ/Gq1AJdr+lnfkYZx7ZuEmoZMBoHc9r0pTIh8EzRGknKDpRwr/OLr1ICnbiWqxQgU+0oZlhD9XcuZG/YYJ6zZokFWAAh3oztVd0OQLILI1qn+QqmLf9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380833; c=relaxed/simple;
	bh=eZ/xPxHf7fjSZecBeCp895uuqc9lBzIafLMnDn+UmVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Sdupoqb0Shad8jbXEk/UMPbE1WlCPw0Ah0LnaJhfBT6XzQF6h1iCYFF034hHvi6wOwcp8hLTn9vDjb4TUX07ivLfIQfzHstbtL5rRmML17mD44aujn6/n6kYnHL5JWP896Knj6HIDhPa3fw67JTZF6YBKpmSETvkeDSgqLfF7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHHllh1J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHHllh1J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768380827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIBj+gi/FdScoTtSUNm5kkkcHpY61usILCwaxo9FKtg=;
	b=hHHllh1JPhlcMW72txQbhn4AN7e0hjq5E/+KPk9Q/4xkrB/u1p/YSwKxAcGQgucAy2QSgP
	k1BdZ3eikcA86dKG14kWamI9v65DqGHuS6FM8jRWURyFBBmy/FaZRz4l3jHHSTzb4X2oEz
	wyIjCOQYB+HwikXQRM8IqEvUmWR4P+c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-MZkTMLhbPOusD6xMGCEQXQ-1; Wed, 14 Jan 2026 03:53:46 -0500
X-MC-Unique: MZkTMLhbPOusD6xMGCEQXQ-1
X-Mimecast-MFC-AGG-ID: MZkTMLhbPOusD6xMGCEQXQ_1768380826
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so68671805e9.0
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 00:53:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380825; x=1768985625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIBj+gi/FdScoTtSUNm5kkkcHpY61usILCwaxo9FKtg=;
        b=Yedn81ykaeiXo3N5AOH1Hpwjb6h1ltRqRhbMDscTXoBvNEDKZ7lN+hiqC7UYYJiuE8
         NKuRmhSi0gx6I/fW0k9rnFIQaafCRUaTRR1vsKaj7WhjKkLCweVoMEd4lR7a7BfWKMYv
         8k01CegRY/PkmW8mbQW7Tj+ia10JVOhZ6eh0ztwdPvUAhk1OKrpfWp+J5JKf/0bZ4o/N
         I57lUaHC1bGyQy9PoRy3kJmJUf+SMayhDG7oSv90QkDLwPoMyJFX2YyVGDyRqIU3rsBI
         ihi1NS7/C0g0ZEpoE2B/21pTf0BtN2ZiDRB8qM4p6SDuWkSTsrSORZ/FfpRzV0tFhy/A
         068g==
X-Forwarded-Encrypted: i=1; AJvYcCWsX+mtLjWpcNv3RlARI6p4kdUxYk6Kf7HWa0LMupO9KjJoV6ftpMsOIFWjIHSOH6phWfKwM+K4LL7zAxgXaA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtGCKxejvlwZ3TCtEhxKqYmcAwAgcTyZCr+63huGQO2qhO+K/2
	hETcuHIEM0DlyHuk1Ynb+b6g3qNltnmQifLLFodqaX8PRF+KkVq7evIMseGmbT+nbSFNnol2LQC
	F/S293VGpNQTAb4A5t8Sa3bjAygFnGJxEJ6mt8vm6n/u2dacZHYtEZiu5S6qz4E8Slljf
X-Gm-Gg: AY/fxX6QgLX8QV2XKuEf7sdUcoF0AoMgvQ/+bwwPKn9GbjueUiiOLu8Lv8DujnXwe7k
	Z8brYf6DfCa48h7dIbUht2bFHtt2psHF86dcM+GAAM3Oq/7hw1Bcg/UfkNtmBgcqC73z/JlUT51
	LNlsw1AluDgg1+Y2VIKNbh77JVK3QNfCHEXZ5hT5epqf/9KHEzSiFq+RlrqAPd8MkXr8SOve2lj
	1f5IK+HUi5ky1128ILBwQ7kkyaQHeZSRQeuU8R2JBed+78sJuk0P7Gb31beD4YkgnOjDcoKPRjO
	qpqAA7hnN4K+HW2qOAZrQuKcahsCbbmJGsWEg2fN/xkzaVcmuMTVsgESYh6dXnVRGuQcMl5SRfe
	HZ/wa/37V//hMEYSoerHqRkpa3btB7iY=
X-Received: by 2002:a05:600c:a088:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47ee47d3988mr16789245e9.16.1768380825321;
        Wed, 14 Jan 2026 00:53:45 -0800 (PST)
X-Received: by 2002:a05:600c:a088:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47ee47d3988mr16788915e9.16.1768380824817;
        Wed, 14 Jan 2026 00:53:44 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee54b90d5sm17411505e9.2.2026.01.14.00.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:53:44 -0800 (PST)
Date: Wed, 14 Jan 2026 03:53:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] virtio_net: Fix misalignment bug in struct
 virtnet_info
Message-ID: <20260114035310-mutt-send-email-mst@kernel.org>
References: <aWIItWq5dV9XTTCJ@kspp>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aWIItWq5dV9XTTCJ@kspp>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dII_K-89Gu42lYBaGZOsNIlZ7TGlFe1zpSzp8xJksuA_1768380826
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 10, 2026 at 05:07:17PM +0900, Gustavo A. R. Silva wrote:
> Use the new TRAILING_OVERLAP() helper to fix a misalignment bug
> along with the following warning:
> 
> drivers/net/virtio_net.c:429:46: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it (in this case
> `u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];`). This
> overlays the trailing members (rss_hash_key_data) onto the FAM
> (hash_key_data) while keeping the FAM and the start of MEMBERS aligned.
> The static_assert() ensures this alignment remains.
> 
> Notice that due to tail padding in flexible `struct
> virtio_net_rss_config_trailer`, `rss_trailer.hash_key_data`
> (at offset 83 in struct virtnet_info) and `rss_hash_key_data` (at
> offset 84 in struct virtnet_info) are misaligned by one byte. See
> below:
> 
> struct virtio_net_rss_config_trailer {
>         __le16                     max_tx_vq;            /*     0     2 */
>         __u8                       hash_key_length;      /*     2     1 */
>         __u8                       hash_key_data[];      /*     3     0 */
> 
>         /* size: 4, cachelines: 1, members: 3 */
>         /* padding: 1 */
>         /* last cacheline: 4 bytes */
> };
> 
> struct virtnet_info {
> ...
>         struct virtio_net_rss_config_trailer rss_trailer; /*    80     4 */
> 
>         /* XXX last struct has 1 byte of padding */
> 
>         u8                         rss_hash_key_data[40]; /*    84    40 */
> ...
>         /* size: 832, cachelines: 13, members: 48 */
>         /* sum members: 801, holes: 8, sum holes: 31 */
>         /* paddings: 2, sum paddings: 5 */
> };
> 
> After changes, those members are correctly aligned at offset 795:
> 
> struct virtnet_info {
> ...
>         union {
>                 struct virtio_net_rss_config_trailer rss_trailer; /*   792     4 */
>                 struct {
>                         unsigned char __offset_to_hash_key_data[3]; /*   792     3 */
>                         u8         rss_hash_key_data[40]; /*   795    40 */
>                 };                                       /*   792    43 */
>         };                                               /*   792    44 */
> ...
>         /* size: 840, cachelines: 14, members: 47 */
>         /* sum members: 801, holes: 8, sum holes: 35 */
>         /* padding: 4 */
>         /* paddings: 1, sum paddings: 4 */
>         /* last cacheline: 8 bytes */
> };
> 
> As a result, the RSS key passed to the device is shifted by 1
> byte: the last byte is cut off, and instead a (possibly
> uninitialized) byte is added at the beginning.
> 
> As a last note `struct virtio_net_rss_config_hdr *rss_hdr;` is also
> moved to the end, since it seems those three members should stick
> around together. :)
> 
> Cc: stable@vger.kernel.org
> Fixes: ed3100e90d0d ("virtio_net: Use new RSS config structs")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---

Seems to belong in net, not next.

Besides that:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Changes in v2:
>  - Update subject and changelog text (include feedback from Simon and
>    Michael --thanks folks)
>  - Add Fixes tag and CC -stable.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aLiYrQGdGmaDTtLF@kspp/
> 
>  drivers/net/virtio_net.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 22d894101c01..5cbcc9926a23 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -425,9 +425,6 @@ struct virtnet_info {
>  	u16 rss_indir_table_size;
>  	u32 rss_hash_types_supported;
>  	u32 rss_hash_types_saved;
> -	struct virtio_net_rss_config_hdr *rss_hdr;
> -	struct virtio_net_rss_config_trailer rss_trailer;
> -	u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
>  
>  	/* Has control virtqueue */
>  	bool has_cvq;
> @@ -493,7 +490,16 @@ struct virtnet_info {
>  	struct failover *failover;
>  
>  	u64 device_stats_cap;
> +
> +	struct virtio_net_rss_config_hdr *rss_hdr;
> +
> +	/* Must be last as it ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct virtio_net_rss_config_trailer, rss_trailer, hash_key_data,
> +		u8 rss_hash_key_data[VIRTIO_NET_RSS_MAX_KEY_SIZE];
> +	);
>  };
> +static_assert(offsetof(struct virtnet_info, rss_trailer.hash_key_data) ==
> +	      offsetof(struct virtnet_info, rss_hash_key_data));
>  
>  struct padded_vnet_hdr {
>  	struct virtio_net_hdr_v1_hash hdr;
> -- 
> 2.43.0

