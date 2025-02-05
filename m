Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F625214A90
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789621; cv=none; b=endEGlE6qAS4lX0gobmH0DDJybuA+Laa08LJH96BN7ABboqFCURYKHtruNOp9n4Ul25SbEpyftibGQZGx/V4QBlwPH0tN4gA6OV8i66W5qGf35FelCP4X7Xu8KabWS5LxCKRBTcy2w1kecCPFtCcNByyfl4+hn29LOdSyNT7sNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789621; c=relaxed/simple;
	bh=ROIwAIDYmaJQqhLYCi+LKXx1tCg3tkrGe92qJKALfGY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bW2iCsiPj6t6qCKACmS+/G+8m5MNv5I+r7qy5MVWmivPBJ85tH0INX9ZBsEfrv8P+VLLj33APW1amAgo6u5Zubv7x8jFU63DveqKv9aBnmhD0a9dodiWCJY7et/d/6uCVQAgpoVzs3KdorOT3vKnYnL46f62oVWjfh5sOPFzae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp8HgIVP; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp8HgIVP"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9A7994268F
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eL-InZWEX_iC for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Feb 2025 21:06:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9E29542680
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9E29542680
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Bp8HgIVP
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9E29542680
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:06:58 +0000 (UTC)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4b2c0a7ef74so114438137.2
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Feb 2025 13:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738789617; x=1739394417; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=321Yzdb9C7R/V5A/ZTrGrsUuNiJo9jCyp/WhHvYvkN8=;
        b=Bp8HgIVP8UHJUQXebOv1c8OI3p9K7HwKGrRkJUkz5ByFQ4d6g8ZGTw/HmDIxbTB0SI
         HdrXhYRc9ytuQkWih8Uh5ISN3lp5uSyWalf1w5G/mMr6VtMcAZX1rZqKkz5XGET/M6uf
         7w+FQk3iR4TiBGt9kJDJHNREpk6iGptKpD6rvR6UEQ/4XhCe93H6H1Ipok+75SEzOXHP
         eOZ2Fsm57dxpRy1NWiolyLFgt4ka87cMmGVfPV5xcSRiytVWt9rCwKTDXf+cQy0eJa0b
         fg4DRtPiozsGFreOzzsbFRSNpGAhrlpmrQ3Pyx/m3R80NcWWPgJoZTw8XuKQ+DfZQzGC
         E4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738789617; x=1739394417;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=321Yzdb9C7R/V5A/ZTrGrsUuNiJo9jCyp/WhHvYvkN8=;
        b=eYx6SgSeTZq/kmHh9KpLXyr9OTyMY96bVPv3tDOUEabBp2mgyD3l5Xa0TsAePTQ7hV
         RbNT6rRy/yQBGx2Omj1Il74ZSpO3Fcfgn1xzwVm1j2QjdRD3zjp6L78MsfdLBk36lzlY
         l1C6p/Lz3xQoZLM4QBkD5VhcFA7UrqZGudd3vZq2MNx9801vZVInIZ5ljiLyyYKFtY+c
         xyd2Yx2oVO6xDgslBjHpvawHBgiU1iU2yE981SX/i9hbFOOy4n9GuoIAbQNK+tw02xG3
         r2cx6W1ddT7BqBYhqJtUu1S6Zga0fTpXCRF2fMDRp3CM+0MnUAOlQI8La3mRj2n35I2P
         ScEg==
X-Forwarded-Encrypted: i=1; AJvYcCXoDHjyUE2qFjX7ZMuDKmTKPlG1BFnmgukR05/VxzjicPg++PeSIvb9oudx4QXw7U9R5TLT+QQf4t2fg6dCWA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwUiZwfX9aIuuO9FwbL6quNV3fgwPReTWOzG/79xyU0d1C1lrxB
	vvRQh6UPUBf+kvKYg/r+KwrqoDwTWCpTqL84B5ocj0tnhKMSu28z
X-Gm-Gg: ASbGnctcq7XUb4NZmDgchTehzvcn/Qu3Pmp2cSpDoqZQstJ7d9qyfI77VkOmp3taJXO
	AKX+ooy4sCh2bqBW4Jz0tX4FrQ8ngjzRgbWnesV8h6AU36ZcscK8Qr372GRssERUfAPIeQpvkG8
	gCxucwa+uACk0qQ2F6lncTEuMib7UHkLvbGMJfxAWwKSsrrkQqnXLO3LCbUEJC0JWr736d8uZP4
	8aNs8OKnQIbgU8wkkgwh812hZBpGeQpq0Pxr06sOCkBoR4NyCurLxYeJRCEI3qvZMhVQiBsT9Yw
	dj71FHIaTcJ9eOoK8MyvfSrvf2l36qHEzFpwjkuvHfAeFoYVmAOUcgG/IgZGHNA=
X-Google-Smtp-Source: AGHT+IGjmsT1CX6GHvVc7jQLN8frmEsrqlIM1ufKny6kJV9XpmTxVc/Kie419ULGnj052Qaq3kcQhw==
X-Received: by 2002:a05:6102:5e86:b0:4b2:cc94:1d6a with SMTP id ada2fe7eead31-4ba47abaa0cmr3554439137.19.1738789617063;
        Wed, 05 Feb 2025 13:06:57 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b9baa8e4cfsm2451368137.11.2025.02.05.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:06:56 -0800 (PST)
Date: Wed, 05 Feb 2025 16:06:55 -0500
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
Cc: Willem de Bruijn <willemb@google.com>
Message-ID: <67a3d2efbba32_170d392944d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250205-tun-v5-1-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-1-15d0b32e87fa@daynix.com>
Subject: Re: [PATCH net-next v5 1/7] tun: Refactor CONFIG_TUN_VNET_CROSS_LE
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
> Check IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) to save some lines and make
> future changes easier.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/tun.c | 26 ++++++++------------------
>  1 file changed, 8 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index e816aaba8e5f2ed06f8832f79553b6c976e75bb8..452fc5104260fe7ff5fdd5cedc5d2647cbe35c79 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -298,10 +298,10 @@ static bool tun_napi_frags_enabled(const struct tun_file *tfile)
>  	return tfile->napi_frags_enabled;
>  }
>  
> -#ifdef CONFIG_TUN_VNET_CROSS_LE
>  static inline bool tun_legacy_is_little_endian(struct tun_struct *tun)
>  {
> -	return tun->flags & TUN_VNET_BE ? false :
> +	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> +		 (tun->flags & TUN_VNET_BE)) &&
>  		virtio_legacy_is_little_endian();

Since I have other comments to the series:

Can we make this a bit simpler to the reader, by splitting the test:

    if (IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) && tun->flags & TUN_VNET_BE)
            return false;

    return virtio_legacy_is_little_endian();

