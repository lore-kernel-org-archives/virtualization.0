Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2EE28A72B
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566557; cv=none; b=t5rmJoS7paxn2AZXPbj5Vw+9BPApKD8GScQinb+FirrA0UWhw8pJ0hk2b/GMgaQJ9g3GBOCrUxlvoZI4GolnThp/vT6wA3WYgyuauZqKQG8DPP6cvPNND3Ci3/2pESP5JujEEIKirQbtZQ4/mXm5E/Kdn3+Bq1MpuqyDsCXQazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566557; c=relaxed/simple;
	bh=8xQWC2OGmtfjHYhYxSYa01NZETYq9M+SyMw53U93t6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TUV+Trc7reH+Gl94p6F1+GeVuZfwIIHrW3RevcZTj16p1Pl42ZwjggsazBye+MKXK9JMain91O0tgRizpxaSFEQEbCAyUGDZpPROXKNwgfLppIL0zWHv0M227dC3uR8yDvrGjFO/uN1PWnFPCl0QTzNdyPf3HyyJh+To5yRNadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=emjC9/al; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emjC9/al"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763566554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B5rXBayezD4fGmnwc7W8pDkjBIEGyWaeCx/RLJ47OIA=;
	b=emjC9/alu/wdC4o49rLdIoeVBBPriZRJR2cEMMJPiljjpm9+ip9TdQpiy5286E52b7hrDY
	8Jq+L+LBdtlyNqz5eC1CQR/LBfd9GB4DHJaqyGkvK2jIZtc7XwjydLADejaxzp6+Vp9ZmZ
	9HCYrF33DBK7WYjs9Zf7/zHIjJlkFiI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-xi2SW1OLNaqOOkNV-mCBXQ-1; Wed, 19 Nov 2025 10:35:53 -0500
X-MC-Unique: xi2SW1OLNaqOOkNV-mCBXQ-1
X-Mimecast-MFC-AGG-ID: xi2SW1OLNaqOOkNV-mCBXQ_1763566552
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b56125e77so3504036f8f.3
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 07:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763566551; x=1764171351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5rXBayezD4fGmnwc7W8pDkjBIEGyWaeCx/RLJ47OIA=;
        b=YsmTCBYbTVvnhGOwbqXnIuEND3xemrJDYx1PzgkcPb6Qr01ydC6I73NBBaPO9ZWAii
         LyJ3uwLZ7rGB+ZOvwg2cejDOagZaLAiGUzgoAAxUNgn8eqFlP1H+/DEeEijLJpFc+1r2
         LGcbT/9lnbEl2U2Lorbwiy2kQDYuVx4gITcqiVu1BJpiAfNlU4nRhGtZk0oSne/Rns6y
         M8VH1Y+fxxEnR+O94/HXv9n9cT0VKuGuLN3JJCR9y8HsGJHxbyFRBjY9V5SSD/c8DQeq
         YjvZvI+NZdMPJVtVMdabJsbVlc5S+PHB8lP1QhWDX8zYOLBDnGuwOKuc4kfgYAOK/t1d
         P22Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnOKp7gmMexCREhr6mhpRfAg5mN2b1bJjGI53CmzzgysJMgEOdEYNt+9aETLSQtKHN38ivK0NP9E42w42yig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxdd6ACvtVKBYnRnHo0cDhQHyaFuCkTkNusstDuZ61cbjirglWp
	gWMtojwSU1745pCXO5E7aLGemUEgU2Wk0CaNWGvqMyL9QlW6k/NRj3yBpUru54ESojDESQaGUER
	107WRqei84r6uodDz4wO5T2M68gr0LJ2PKAHHEEtn47gsKsKafSRxPm0Arb+apSni09bs
X-Gm-Gg: ASbGnctdL3frdMvEX+HoIzUY9+Tf6deWGIc7ZuMS87xUOnkmiFF3ltulhr8eYI7piBD
	xKm1EYuLcQMWvLmMfyVa/I04hqYBppep5GjkGl9v8NYU1O2F9UvfJ0VH96YsXR9G1lK35EXA8Jm
	0DzV+sg8Uc0bj7gA/MIFjb0gjXJNSI8jWyO78b3X4g24HfiQj6lopaEsNjrdkYkyFBAlrFr/jIS
	pLpmqZykOB3VG7MyEm6RhBuX32SnR7pibwZ5KTTQa5cpXJ+5zxcBzw0kfmF57mhjZ2HZK1IOJSs
	hvmsce+eRoLIVw7Wos5Kowavo8WazuXeZ0cknkwRc8MaiOikxgG1XG//eH1YNB4Ib1pr/96UWQK
	LfxoQrO2LkKbbxyLgYj9WVASytZQLqg==
X-Received: by 2002:a05:6000:1a8e:b0:42b:3e0a:64b8 with SMTP id ffacd0b85a97d-42b593505bamr19333065f8f.24.1763566551401;
        Wed, 19 Nov 2025 07:35:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsu6XSFNDBciSWl2Js2B1sAVjUG1swL73vKYbAUIAe5E9Q/RDA00H3GxNi9yzFc+Jd1MBR4w==
X-Received: by 2002:a05:6000:1a8e:b0:42b:3e0a:64b8 with SMTP id ffacd0b85a97d-42b593505bamr19333019f8f.24.1763566550923;
        Wed, 19 Nov 2025 07:35:50 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38718586f8f.0.2025.11.19.07.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:35:50 -0800 (PST)
Date: Wed, 19 Nov 2025 10:35:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net v6 2/2] virtio-net: correct hdr_len handling for
 tunnel gso
Message-ID: <20251119102753-mutt-send-email-mst@kernel.org>
References: <20251119055522.617-1-xuanzhuo@linux.alibaba.com>
 <20251119055522.617-3-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251119055522.617-3-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 13oct5zElg_oStFLVf_pP8tAgUkOsALPRvod9smbmFw_1763566552
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 01:55:22PM +0800, Xuan Zhuo wrote:
> The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
> GSO tunneling.") introduces support for the UDP GSO tunnel feature in
> virtio-net.
> 
> The virtio spec says:
> 
>     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
>     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
>     all the headers up to and including the inner transport.
> 
> The commit did not update the hdr_len to include the inner transport.
> 
> I observed that the "hdr_len" is 116 for this packet:
>     17:36:18.241105 52:55:00:d1:27:0a > 2e:2c:df:46:a9:e1, ethertype IPv4 (0x0800), length 2912: (tos 0x0, ttl 64, id 45197, offset 0, flags [none], proto UDP (17), length 2898)
>         192.168.122.100.50613 > 192.168.122.1.4789: [bad udp cksum 0x8106 -> 0x26a0!] VXLAN, flags [I] (0x08), vni 1
>     fa:c3:ba:82:05:ee > ce:85:0c:31:77:e5, ethertype IPv4 (0x0800), length 2862: (tos 0x0, ttl 64, id 14678, offset 0, flags [DF], proto TCP (6), length 2848)
>         192.168.3.1.49880 > 192.168.3.2.9898: Flags [P.], cksum 0x9266 (incorrect -> 0xaa20), seq 515667:518463, ack 1, win 64, options [nop,nop,TS val 2990048824 ecr 2798801412], length 2796
> 
> 116 = 14(mac) + 20(ip) + 8(udp) + 8(vxlan) + 14(inner mac) + 20(inner ip) + 32(innner tcp)
> 
> Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  include/linux/virtio_net.h | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index ee960ec9a35e..ee8231eb759b 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -215,12 +215,22 @@ static inline void virtio_net_set_hdrlen(const struct sk_buff *skb,
>  	u16 hdr_len;
>  
>  	if (guest_hdrlen) {
> -		hdr_len = skb_transport_offset(skb);
> -
> -		if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> -			hdr_len += sizeof(struct udphdr);
> -		else
> -			hdr_len += tcp_hdrlen(skb);
> +		if (sinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +				       SKB_GSO_UDP_TUNNEL_CSUM)) {
> +			hdr_len = skb_inner_transport_offset(skb);
> +
> +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +				hdr_len += sizeof(struct udphdr);
> +			else
> +				hdr_len += inner_tcp_hdrlen(skb);
> +		} else {
> +			hdr_len = skb_transport_offset(skb);
> +
> +			if (hdr->gso_type == VIRTIO_NET_HDR_GSO_UDP_L4)
> +				hdr_len += sizeof(struct udphdr);
> +			else
> +				hdr_len += tcp_hdrlen(skb);
> +		}
>  	} else {
>  		/* This is a hint as to how much should be linear. */
>  		hdr_len = skb_headlen(skb);

BTW  I noticed that include/linux/virtio_net.h really should include
linux/tcp.h for tcp_hdrlen and uapi/linux/udp.h for struct udphdr


Not a new issue so you do not have to resolve it in this patchset,
though.



> @@ -441,11 +451,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>          vhdr->hash_hdr.hash_report = 0;
>          vhdr->hash_hdr.padding = 0;
>  
> -	/* Let the basic parsing deal with plain GSO features. */
> -	skb_shinfo(skb)->gso_type &= ~tnl_gso_type;
>  	ret = __virtio_net_hdr_from_skb(skb, hdr, true, false,
>  					guest_hdrlen, vlan_hlen);
> -	skb_shinfo(skb)->gso_type |= tnl_gso_type;
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.32.0.3.g01195cf9f

