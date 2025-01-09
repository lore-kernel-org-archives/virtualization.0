Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F238218ADA
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431575; cv=none; b=Tz2CjUe4Dnio9EuIIYOCdr20m/G9jaMYmKig142ig+KHUeeEQcFdq9F/96Na8dq4+mXxgSwbQELIBzOt4AFuEDevi1WQ+gT0cUv3/v9/HPa4DgfjRz661P6+gWvTXuSdibR60O0QLjsuE/yKgl3RcvSVcsWec3NVKTo9rh/I/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431575; c=relaxed/simple;
	bh=5/nRrtGDhDuIG6R1/X/KmK0g0dRtyepfwy0EIHoopDE=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iM3/KarmESSCVZPepwefrfdiB9s3uhkoBot+5lY02EbEAS3UF9UjCZ3XWhARmIMFn0pSlpPvuZPQHVTIl7a3vEATXFWX9GqPycD0giAIkNDl/899OZ2xzPaMdrt2kME/aDaTjNEVSPf4BfVLuEqPeT+EDej9NJoFMbGjztJNZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eioNfn7A; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eioNfn7A"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14DA4831B0
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QJjf5LkTBTrr for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 14:06:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 232FA83227
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 232FA83227
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eioNfn7A
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 232FA83227
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:06:12 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7b9ad0e84e6so92408285a.0
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 06:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736431572; x=1737036372; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usIeIp/v3yeRjofXHQEYqOeb0gxg7kz9hdNbLvCou+k=;
        b=eioNfn7AnQu6TKTeMxdION+C9Zl3iA66hiTUgLBM3ytrxoBsTcC4mm6soxYfyxPRFd
         o29UynyvFiH9cVDRvtE6xbWCHW7vCYXCTXD5eEypY5/JzoF5YJ+ymrQH0dssZ5Wef5t/
         4kzIpX0+gT5aeqcvNKznPxKzcyKH1Jgie9kOz1LozIrdSdsLcW/xn+vIRyFbGOpN6K/g
         ENGq/PPTHY4USOuTEi9Re6sw8dzSspsw6zB3hMna8QqGIPP3aaFlL9UyWn4boYPK7pNA
         YjGgr3JOMAmUvuCBulx3vDDyGhbKFIaG9qxTsqL/OOmxsE0j8wTR3uJJIm/9lZDGl/tl
         PV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736431572; x=1737036372;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usIeIp/v3yeRjofXHQEYqOeb0gxg7kz9hdNbLvCou+k=;
        b=j6h3zB4GMd8ExdasgljkGKVtq5lIFG9e80sPAR2pYvA27Tfok3f38d+1cMcpP5LgGp
         b2bn5xX1fxMZZK9oV8O2C8m41+IlRg2t3WufxaGgDw77+Cbj9FKQTWslT8H0khAVtjM8
         94dglOe1AidsRu6q5k6gDpm8VoIlcmFdsnJV1tjuitKgddxKpBRL09pRjz+QnoWi9zdC
         HiFatSFzYr5DURZygVxh4Zsgd+gDJuw99ivt2/VFv2fLlc4Giz2PcU5A72520K6+ML+d
         Jul7wcBvR6rlFzXS0yv5o/MFPSe1CUco3rTZnDea77BRnNGzTPkLYe/fHWX0NnRIfUmq
         lQJg==
X-Forwarded-Encrypted: i=1; AJvYcCXXaPXGmdBXKeiDzAg/DTT77woGgKcY7oI/am/JtqnonkjZJPmLylDtwOp4ZDMT/3JIFlMq6QmHu+vTJ633Pw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yw7h30r2RONJCluEVUXKtPD9yDa5In/qgEq0cW1PDYrpId0yDU5
	16XZsvU4f0J8pN35IwLbz1vC8YZePtWpiJfCbb6VT005tAqOL1RW
X-Gm-Gg: ASbGnct/yI6mAMgDaP4htNt7O7ja7I7j/bf7QERpoq4ry7+oQWFc2rOSgZABRmphFei
	G7O6DQYXs3qu+RIW67n1Y17o6WN56t2pEheunMA6jh1ktcsZwr4Ymo3in6xTThE5EpV/8vuh9KD
	zzwYmOEKwxEwyVo0lPK6KV+P7IcjCiqAvxtPZwY4Nz5eQYq3QBU/Da/dOKdmi8g67745aYAcvSu
	R9NKfQ9+JGq9qm8VyPdVJspIARU7ugMnjSLo4gKStIB2BZG1mGe1Dv21WfwWQqs33N+BNVDV6tI
	eFD5RtUJg1nfIRMKkwA6+kfVarPj
X-Google-Smtp-Source: AGHT+IH2/BuDKPaZFtSdB6sACr2yO5Ou7ULQHhJjCfbu2HLVS1xlSoeEvSTuiJj7XPE+QAB5X5egxg==
X-Received: by 2002:a05:620a:1791:b0:7b6:cbc6:c87c with SMTP id af79cd13be357-7bcd975592dmr1065034085a.30.1736431571555;
        Thu, 09 Jan 2025 06:06:11 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3502abbsm69198985a.82.2025.01.09.06.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:06:10 -0800 (PST)
Date: Thu, 09 Jan 2025 09:06:10 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com, 
 devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <677fd7d26e090_362bc129432@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-tun-v2-1-388d7d5a287a@daynix.com>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-1-388d7d5a287a@daynix.com>
Subject: Re: [PATCH v2 1/3] tun: Unify vnet implementation
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> Both tun and tap exposes the same set of virtio-net-related features.
> Unify their implementations to ease future changes.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  MAINTAINERS            |   1 +
>  drivers/net/Kconfig    |   5 ++
>  drivers/net/Makefile   |   1 +
>  drivers/net/tap.c      | 172 ++++++----------------------------------
>  drivers/net/tun.c      | 208 ++++++++-----------------------------------------
>  drivers/net/tun_vnet.c | 186 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  24 ++++++
>  7 files changed, 273 insertions(+), 324 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 910305c11e8a..1be8a452d11f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23903,6 +23903,7 @@ F:	Documentation/networking/tuntap.rst
>  F:	arch/um/os-Linux/drivers/
>  F:	drivers/net/tap.c
>  F:	drivers/net/tun.c
> +F:	drivers/net/tun_vnet.h
>  
>  TURBOCHANNEL SUBSYSTEM
>  M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 1fd5acdc73c6..255c8f9f1d7c 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>  	tristate "Universal TUN/TAP device driver support"
>  	depends on INET
>  	select CRC32
> +	select TUN_VNET

No need for this new Kconfig

>  static struct proto tap_proto = {
>  	.name = "tap",
> @@ -641,10 +576,10 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	struct sk_buff *skb;
>  	struct tap_dev *tap;
>  	unsigned long total_len = iov_iter_count(from);
> -	unsigned long len = total_len;
> +	unsigned long len;
>  	int err;
>  	struct virtio_net_hdr vnet_hdr = { 0 };
> -	int vnet_hdr_len = 0;
> +	int hdr_len;
>  	int copylen = 0;
>  	int depth;
>  	bool zerocopy = false;
> @@ -652,38 +587,20 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	enum skb_drop_reason drop_reason;
>  
>  	if (q->flags & IFF_VNET_HDR) {
> -		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
> -
> -		err = -EINVAL;
> -		if (len < vnet_hdr_len)
> -			goto err;
> -		len -= vnet_hdr_len;
> -
> -		err = -EFAULT;
> -		if (!copy_from_iter_full(&vnet_hdr, sizeof(vnet_hdr), from))
> -			goto err;
> -		iov_iter_advance(from, vnet_hdr_len - sizeof(vnet_hdr));
> -		if ((vnet_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
> -		     tap16_to_cpu(q, vnet_hdr.csum_start) +
> -		     tap16_to_cpu(q, vnet_hdr.csum_offset) + 2 >
> -			     tap16_to_cpu(q, vnet_hdr.hdr_len))
> -			vnet_hdr.hdr_len = cpu_to_tap16(q,
> -				 tap16_to_cpu(q, vnet_hdr.csum_start) +
> -				 tap16_to_cpu(q, vnet_hdr.csum_offset) + 2);
> -		err = -EINVAL;
> -		if (tap16_to_cpu(q, vnet_hdr.hdr_len) > len)
> +		hdr_len = tun_vnet_hdr_get(READ_ONCE(q->vnet_hdr_sz), q->flags, from, &vnet_hdr);
> +		if (hdr_len < 0) {
> +			err = hdr_len;
>  			goto err;
> +		}
> +	} else {
> +		hdr_len = 0;
>  	}
>  
> -	err = -EINVAL;
> -	if (unlikely(len < ETH_HLEN))
> -		goto err;
> -

Is this check removal intentional?

> +	len = iov_iter_count(from);
>  	if (msg_control && sock_flag(&q->sk, SOCK_ZEROCOPY)) {
>  		struct iov_iter i;
>  
> -		copylen = vnet_hdr.hdr_len ?
> -			tap16_to_cpu(q, vnet_hdr.hdr_len) : GOODCOPY_LEN;
> +		copylen = hdr_len ? hdr_len : GOODCOPY_LEN;
>  		if (copylen > good_linear)
>  			copylen = good_linear;
>  		else if (copylen < ETH_HLEN)
> @@ -697,7 +614,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  
>  	if (!zerocopy) {
>  		copylen = len;
> -		linear = tap16_to_cpu(q, vnet_hdr.hdr_len);
> +		linear = hdr_len;
>  		if (linear > good_linear)
>  			linear = good_linear;
>  		else if (linear < ETH_HLEN)
> @@ -732,9 +649,8 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
>  	}
>  	skb->dev = tap->dev;
>  
> -	if (vnet_hdr_len) {
> -		err = virtio_net_hdr_to_skb(skb, &vnet_hdr,
> -					    tap_is_little_endian(q));
> +	if (q->flags & IFF_VNET_HDR) {
> +		err = tun_vnet_hdr_to_skb(q->flags, skb, &vnet_hdr);
>  		if (err) {
>  			rcu_read_unlock();
>  			drop_reason = SKB_DROP_REASON_DEV_HDR;
> @@ -797,23 +713,17 @@ static ssize_t tap_put_user(struct tap_queue *q,
>  	int total;
>  
>  	if (q->flags & IFF_VNET_HDR) {
> -		int vlan_hlen = skb_vlan_tag_present(skb) ? VLAN_HLEN : 0;
>  		struct virtio_net_hdr vnet_hdr;
>  
>  		vnet_hdr_len = READ_ONCE(q->vnet_hdr_sz);
> -		if (iov_iter_count(iter) < vnet_hdr_len)
> -			return -EINVAL;
> -
> -		if (virtio_net_hdr_from_skb(skb, &vnet_hdr,
> -					    tap_is_little_endian(q), true,
> -					    vlan_hlen))
> -			BUG();
>  
> -		if (copy_to_iter(&vnet_hdr, sizeof(vnet_hdr), iter) !=
> -		    sizeof(vnet_hdr))
> -			return -EFAULT;
> +		ret = tun_vnet_hdr_from_skb(q->flags, NULL, skb, &vnet_hdr);
> +		if (ret < 0)
> +			goto done;
>  
> -		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
> +		ret = tun_vnet_hdr_put(vnet_hdr_len, iter, &vnet_hdr);
> +		if (ret < 0)
> +			goto done;

Please split this patch in to a series of smaller patches.

If feasible:

1. one that move the head of tun.c into tun_vnet.[hc].
2. then one that uses that also in tap.c.
3. then a separate patch for the ioctl changes.
4. then introduce tun_vnet_hdr_from_skb, tun_vnet_hdr_put
and friends in (a) follow-up patch(es).

This is subtle code. Please report what tests you ran to ensure
that it does not introduce behavioral changes / regressions.
