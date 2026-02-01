Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF32D94A0
	for <virtualization@lists.linux.dev>; Sun,  1 Feb 2026 21:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769979653; cv=none; b=FhN+XFjLV7kYZnpiJYt3BRlJsEo8BR31pI9LRtTj2AK5GvzXLiVuDiEFrdlzal4y8v+wnWXX18gK/bX11ahZtrUhJopngcgs69ZPpABe4k+ckmfBxIWXSCcpSWaEyz/Z5Bcpb5RBOcsqdeVAy4wc7A+H5bRohzdwIEA43wZVYno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769979653; c=relaxed/simple;
	bh=/KLKo4Flumlbcv8+m36qKmRqvJ7JsFyT0spsicfILaI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sHGB1IGvakMowFHG155H3Zr5I+2G2Z5rKzPcRAHW447YEwowuU4y8uG8hg6RJLPEWC7VGc7H+ZuT/JVwvMmLuRWV8jv9YHxGvEC8Ky76s+33fA16RpbVTkM2TE+y8esIpkFcMosnPvtK4jmupOZdN8d7r+3N/VMhdAu0E/KGIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAl01GwM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAl01GwM"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-794cbd4bb51so4426737b3.3
        for <virtualization@lists.linux.dev>; Sun, 01 Feb 2026 13:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769979651; x=1770584451; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfxpBhG8NkbxSh3fbCVpxo3CZMgN0PUTK9yRw7CZ4dc=;
        b=QAl01GwMs17COfcZ01vp7/LXM2AM0bnLUMd/+9i7tZRE8iaPSI+7eCgl7okvHoe8iO
         a6tDl4MK+QMjOEERA+Nuo3g4e3+G1vGdJzU115t2lkJE7z69lHmhECtXK0gS2f6FRg0+
         HuVOUIcYhzJhhmO7uQ3n2n1l50rCAbLAAfkz8XwbwuQWg7Hn2cdGdYeeYYn0MQOc0Er0
         q6bZMbNYK0tot7tXmOHGsmYUM7DSJjbYnR1kCiAOIM89CDxClHRX1BbLyFLoXKclkx6d
         kQTQwVNXE4dpQfRwRxNhNiqLovsowIJ867c2wXbIDBmhYkhuf+HjrlhbTEZYZErz2lSb
         WM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769979651; x=1770584451;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfxpBhG8NkbxSh3fbCVpxo3CZMgN0PUTK9yRw7CZ4dc=;
        b=QGpSDdIpZV3rOe7d18jTAPPdRTQHCHgujOq+veyzyOQBdQ1p4Cd4DN/SDhgAyp3Asm
         GWzWjeDa6Sw0Z53S0nWl/1HJmKthcOaG6uZhJkT345XQNqA/muftuVk5CPWv+nVp4+PV
         LLi6U75zq9+lKgvzzd3mc1K5BJQnwSm8M/oZlRJqXvZ8ckbBOV/jhjIOjAJ7uVgH54ft
         hJKKEEtbdL1d6NH/qEhkZ73G+ICaUvEZvWHSO/ZAYparU1y2AL0uKM+jbnwXiSjjMNfP
         9EHf6gaRoUAgXKR8w1zskEnjHoG8ULhX41UpwSkUWifRIp278Ysrs+/KTT04j2XQbzmo
         U0rA==
X-Gm-Message-State: AOJu0Yyt3lEcXnezwNPLvaya85QuU/7AU7xHAW2sAYUp08bRPNZHUtQ0
	FwVk5zwQSml5HjWzgP6FpaSQTd3i8ZuQNMwLoxCgLmlCqGN4y4y2BRLM
X-Gm-Gg: AZuq6aJRcvsZwad0J6STG+AwMcEQgpXYk1luQ0EtHCafBBEFB81UX2vG/iK2ryyrmSY
	urfxTt+5Uj3f+D9rQIlBn6AiSCveu6vpZXt2Ctwrxch67s+IjobN5SsUp1VVEoCOb7J33H/Rk26
	+ES2OrFihvWQyD5NI8CUaglRvykpyCchjxTilM7p9/M2c6q8i+6+aIDMxcTQHXDqac41C3pzg4B
	f0QZUE4/AvikUEZvEejTfg/xwY/tyhRx4r9g8pg08QB42yFZXluXNr9DtXicA8IDaysEhiyYmlR
	8tH+4i9VLlyiFHYBb/HG4N27l1fTdRgLfqctixycRHOV1C74KkeNTLnexpj5xd6vn6h8EHKiA1w
	Ayt4OIGc7quP/XFkwVBftiWY5u8sQl4vXjaSD4Mb0KJo1pVjOP+m1iiBFnvgxkjTVYuATzWLUBb
	jdRoLJnaMQxpFW64XmLBEo2wcB9LxAJucDLhdu6vfxFeQ/84eal3i30K2ViXY=
X-Received: by 2002:a05:690c:10c:b0:794:d0b5:eb3f with SMTP id 00721157ae682-794d0b5f48fmr12637327b3.41.1769979650912;
        Sun, 01 Feb 2026 13:00:50 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794da35c55dsm2032817b3.53.2026.02.01.13.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 13:00:50 -0800 (PST)
Date: Sun, 01 Feb 2026 16:00:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Message-ID: <willemdebruijn.kernel.391644a186dc6@gmail.com>
In-Reply-To: <20260129-v6-7-topic-virtio-net-ptp-v2-1-30a27dc52760@pengutronix.de>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-1-30a27dc52760@pengutronix.de>
Subject: Re: [PATCH RFC v2 1/2] tun: support rx-tstamp
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> Demonstrate support for new virtio-net features
> 
> VIRTIO_NET_HDR_F_TSTAMP
> 
> This is not intended to be merged.
> 
> A full feature test also requires a patched qemu binary that knows
> these features and negotiates correct vnet_hdr_sz in
> virtio_net_set_mrg_rx_bufs. See
> https://github.com/strumtrar/qemu/tree/v10.2.0/virtio-rx-stamps
> 
> Not-yet-signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  drivers/net/tun.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 8192740357a09..aa988a9c4bc99 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -2065,23 +2065,29 @@ static ssize_t tun_put_user(struct tun_struct *tun,
>  	}
>  
>  	if (vnet_hdr_sz) {
> -		struct virtio_net_hdr_v1_hash_tunnel hdr;
> -		struct virtio_net_hdr *gso;
> +		struct virtio_net_hdr_v1_hash_tunnel_ts hdr;

This patch refers to a struct that does not exist yet, so this cannot
compile?

> +
> +		memset(&hdr, 0, sizeof(hdr));
>  
>  		ret = tun_vnet_hdr_tnl_from_skb(tun->flags, tun->dev, skb,
> -						&hdr);
> +						(struct virtio_net_hdr_v1_hash_tunnel *)&hdr);
>  		if (ret)
>  			return ret;
>  
> -		/*
> -		 * Drop the packet if the configured header size is too small
> -		 * WRT the enabled offloads.
> -		 */
> -		gso = (struct virtio_net_hdr *)&hdr;
> -		ret = __tun_vnet_hdr_put(vnet_hdr_sz, tun->dev->features,
> -					 iter, gso);
> -		if (ret)
> -			return ret;
> +		if (vnet_hdr_sz >= sizeof(struct virtio_net_hdr_v1_hash_tunnel_ts)) {
> +			__le64 tstamp = cpu_to_le64(ktime_get_ns());
> +
> +			hdr.tstamp_0 = (tstamp & 0x000000000000ffffULL) >> 0;
> +			hdr.tstamp_1 = (tstamp & 0x00000000ffff0000ULL) >> 16;
> +			hdr.tstamp_2 = (tstamp & 0x0000ffff00000000ULL) >> 32;
> +			hdr.tstamp_3 = (tstamp & 0xffff000000000000ULL) >> 48;
> +		}
> +
> +		if (unlikely(iov_iter_count(iter) < vnet_hdr_sz))
> +			return -EINVAL;
> +
> +		if (unlikely(copy_to_iter(&hdr, vnet_hdr_sz, iter) != vnet_hdr_sz))
> +			return -EFAULT;
>  	}
>  
>  	if (vlan_hlen) {
> 
> -- 
> 2.52.0
> 


