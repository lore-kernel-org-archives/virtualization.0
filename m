Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685489;
	b=vLAW+IEGsCCEnLwgySkwj0YQY5FSWUArCh3vaOUj+0IKOUpDPaTy6yYdRYpxTB/mlCnZ
	 7iI1vaFKV8oWawO1ADbhJbtFITI932hm8L5pge8wyM5SAsbzAzsblkZvDln2mwdJvhsjD
	 tkN18epLuJlk84V/q0YYTFLpNPc5tLVAHIFXioTqFYu0OeIQVsaLcp1lEwLA+tVIe+OW8
	 2HX/M6LuEUtrT+S+XoMbXWw6NGAlwX2rxYQ8Wf6irqBokzJkj1TZ7FrAGJuUQ/KJOSCK/
	 oCjllSX6schOblRPqeBFNKVfVkcKfAaw/3nODPhcZbHhFadMQq7Q5YoJwLOCfJFnt1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685489;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=ZolVYJhL5yPQgM/2Gp/lmOIhd5O8wGaOXv+Tfsjy2X0=;
	b=QHCXtKJtQwG1V92jE8gBPA+M2L3PcNkcBLzuqv6YXqlpSwC8yMh2Ye2h57mWEEZ3r2lM
	 o1Xq4b15gt4wN5U1rM0R5D/KMFrvjtxSDiW/7UvyzghaBui11qaoEz4rWdl0YCkX7O7iz
	 d2XmFJ0ARH2lZfxGg849XFrDUMfoyCiBRUTiHjzrdDAstjzsErz+gPOrTJjFn+RDFA6Bw
	 ASX1DFSXBQJQNG4rv+HQhC7RFuZQRVsnIXlUuMvVbGOlID/se7kH6EVr+osXUUo8fHDeZ
	 xNuZHo0ki8FPa8rFOD6CJSKEqcVFYRlmoh+d6vEBaqY15Jzff16Pu8mMVv6LV3uhXeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cSSObIE7;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D05606A31A
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 16:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06D05606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cSSObIE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792685488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZolVYJhL5yPQgM/2Gp/lmOIhd5O8wGaOXv+Tfsjy2X0=;
	b=cSSObIE72kYP7W3whM9h7EYnm8n2hLV97yQF3zeVSg6HPbR+vFZtCPfFnUKbIygGZabwqQ
	ACfvQHYtbDsuSl2nPPghr5hNnFZkTqt2NbxDm5Xdi9Lef4bWT3ptG9lSzs4ENe28CuRsl/
	hl54Aydg+CPuO03l4jFbd9E3u23OY8c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-rvJKx_rGOcWW-GI1z1I7-Q-1; Thu, 22 Oct 2026 12:11:20 -0400
X-MC-Unique: rvJKx_rGOcWW-GI1z1I7-Q-1
X-Mimecast-MFC-AGG-ID: rvJKx_rGOcWW-GI1z1I7-Q_1792685479
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c46582442so1243024f8f.0
        for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 09:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685479; x=1793290279;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZolVYJhL5yPQgM/2Gp/lmOIhd5O8wGaOXv+Tfsjy2X0=;
        b=Wppy0upN3mlgnqZlgO+rP5nolxUcuO+Bzz1MqD/grfbL7LiRv6DCTXqU7As6UQi5Q2
         v968kGR/LOiyYHcyItUYbLl+LoLBbBJGarE41IdQHsYZpoVUg2xf7gciJlp7hIPbjAu7
         CB2genXl3db9SbmK3gjuCHDY+1QB+CBgalFzI1/VMVsf/W5HNnaaDgjKRHnh0vfKCuOe
         sskDifeqQjtyZIkB3Z3iDHNkQvduH4NKFj7LRo5C/1alvk313BITk3kE8eL4+TcxgpyT
         Z8I2qMhsDe9mv1pxbRhDwY5NE1DwOPgilOHvIGN97hbyuOlPGcfYSd6unxtc9vYMB7Op
         QQoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXfW2frrGS+/gDmvt/zQJ7laeS9cNptXY0kAqbAdGfE/SJOtoiWPDkmuFk72fwR6815dLCZDL4RQvziepawg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKL/LHpgutJ2pj1wYzL+Xz1uIOtTQw7CsT6PPk71Q678zrTtd3M
	UgO6WfH+mHnTQcfYvUfXMAYBoB+4q5iGcn5BzrjPUYeD5ouve6L4lUgr6fywmaNfjIdkw2KUW4o
	HrmD7ysn6X/PkuWh56MjwCcrLkcsJ/2WTUVKiibycNoRl+vRLjNtLZ7D3OJCChb4eI6me
X-Gm-Gg: AYBFou2v8Ql+it1sk0//PGa+Akd5oWVz4f/VeIkH5oXDenGBS8yFllXwGlKdylr+L3q
	HN39kcPlmRQvt7HA+LhIRetd/r9TwVpG6rm4EoV/0mHmJOk1S9lWinRB7o5Y2tT1x3fChk7nUW7
	EML8MSI9smo1IGtlXldtrSK87Az1NCd4AnEv8n6IrrBZD17Mp5NSLSWgVfAYocOfBAnGh15pU2T
	nlnccsEk5VPCLu445Mxo3AtOZkk6Nx0Vj/LdAtvZaDQuivH0aGb5tHioElmu6UN9Idzoq62ddsf
	mFNkubb8V5LMf3ULy4uuvOaYqEtCtQ8gCBmrHXtlUYCXLquJPxK9BuRI1DqDns+gjIA=
X-Received: by 2002:a05:6000:200c:b0:48a:f8fb:cd49 with SMTP id ffacd0b85a97d-48e264d53efmr12352951f8f.22.1792685478914;
        Thu, 22 Oct 2026 09:11:18 -0700 (PDT)
X-Received: by 2002:a05:6000:200c:b0:48a:f8fb:cd49 with SMTP id ffacd0b85a97d-48e264d53efmr12352904f8f.22.1792685478333;
        Thu, 22 Oct 2026 09:11:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm14376089f8f.40.2026.10.22.09.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:11:17 -0700 (PDT)
Date: Thu, 22 Oct 2026 12:11:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cheng Yongkang <teel4res@gmail.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] net: virtio_net: decode tunnel csum_start as
 little-endian
Message-ID: <20261022121057-mutt-send-email-mst@kernel.org>
References: <179268538303.70821.1734486381476363942@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <179268538303.70821.1734486381476363942@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8uL4DoAwjzkcQfyJucQV3xCP5345mM1bwr3Yw2c7lEU_1792685479
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 22, 2026 at 08:26:48AM -0700, Cheng Yongkang wrote:
> virtio_net_hdr_tnl_to_skb() decodes hdr->csum_start with the caller's
> little_endian argument when it validates the inner header offsets, but
> then calls __virtio_net_hdr_to_skb() with little_endian hard-coded to
> true.  The other tunnel offsets are always decoded as little-endian as
> well.
> 
> tun passes tun_vnet_is_little_endian(), which is false when the device
> uses big-endian legacy headers: by default on big-endian hosts, and
> after TUNSETVNETBE on little-endian hosts with CONFIG_TUN_VNET_CROSS_LE.
> The validation and the parser then disagree on csum_start.  For
> example, the bytes 14 00 decode as 5120 for the validation and as 20
> for the parser, so an inner_nh_offset beyond the data pulled into the
> linear area passes the check, and the USO branch reads iphdr->version
> out of bounds:
> 
>   BUG: KASAN: slab-out-of-bounds in tun_vnet_hdr_tnl_to_skb+0x74b/0x830
>   Read of size 1 at addr ffff88807999d044 by task kvd-program/9399
>   Call Trace:
>    tun_vnet_hdr_tnl_to_skb+0x74b/0x830
>    tun_get_user+0x1827/0x3d00
>    tun_chr_write_iter+0x113/0x200
>    vfs_write+0x5c9/0xb30
> 
> Decode csum_start as little-endian, matching the parser.  Callers that
> pass little_endian == true are unaffected.
> 
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Assisted-by: LLM
> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>


duplicate of
dfcede18b8d54519bf586b8e5099e89ec63bf014.1792668082.git.mst@redhat.com ?

> ---
>  include/linux/virtio_net.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd0..ddc6341747e5 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -324,7 +324,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	inner_l3min = virtio_l3min(inner_isv6);
>  	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
>  
> -	inner_th = __virtio16_to_cpu(little_endian, hdr->csum_start);
> +	inner_th = le16_to_cpu(hdr->csum_start);
>  	inner_nh = le16_to_cpu(vhdr->inner_nh_offset);
>  	outer_th = le16_to_cpu(vhdr->outer_th_offset);
>  	if (outer_th < outer_l3min ||
> 
> base-commit: f4377bf85887f57b59abb5479f7660a81ffe4449
> -- 
> 2.34.1

