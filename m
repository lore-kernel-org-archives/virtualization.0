Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ABF18A6A8
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 12:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663622; cv=none; b=ekZaHGehdQN3PyWpZNfQUIsYuaUdruK8Tg5Gd5nvD0W0Bkq/3kuTpLpfKqi2swDPlrgmjv/LU/3Zt+FJysZbPxfubQB3oIhtCSrvA2F6AdLOm6O6NdSD8XeKgowQPRBSL3mzTUE6JEBTuUyzqELm4WAN1nk/MFvdr2mCyzBODFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663622; c=relaxed/simple;
	bh=FfCTcp0ZVpfsylfuxeYRb0/Fe0NXrZIXNkhO2rk/C3c=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=snUWj/M2LPDhQXYRvohSZTA/fyLIykEOWNYoKHEobK75hrtwkINNSwzgnMCtd18pOJacQtTuI/cqExGqnq9fsHtvLACj3jimxM5QqfJa5girvPUjaxcRysUDXrjitPYQzTOuoU132NYB+cV8KSov+c1DhNO88lVv2lE/Vxuke0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tcqdh2sl; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcqdh2sl"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E62F140207
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 12:47:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NHfUVBQSfX4i for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Sep 2024 12:47:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e33; helo=mail-vs1-xe33.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BEFBA40193
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BEFBA40193
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tcqdh2sl
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BEFBA40193
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 12:46:59 +0000 (UTC)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-49bcaee2754so2017662137.2
        for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726663618; x=1727268418; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEiE54XLGCyNeFLyuQe7PaxspDTPjoL4Q+YGo4YshIM=;
        b=Tcqdh2sln99Noze1CHZoI9r8BVzz7J8jjXuj4boF0xjDEiIWgbrJYlr+NpP2vRpPrK
         ZggbEWuByAil1fQJ3LAEZ9ROPsqzgBA0hzogvNtrqU4rhx/DoT+Q2jhP/lfTQ8rIoOeU
         01Uj8GZWRc5ynV1XbndavNdjSkWCEtewHzBf0k4mza2knP3H2hMthZ36lJrSCwjj9kKo
         SJcs1ySndbfIPquVXp0PeycxMxQbey5YyWGa4iV36BBSU89/sZYUpzeNPc6jwHE+vXX3
         6QuZaWJGMSlCTa7kLeZEgCUcTS6d3Iw7onKYTLsDtp3OW4rV/OZeP/GOOwwCll4iYm6X
         0bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663618; x=1727268418;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEiE54XLGCyNeFLyuQe7PaxspDTPjoL4Q+YGo4YshIM=;
        b=sTWfJXvlg5gAe//5Y9S0Keubs/GipKpQnBFjZdYRahfjJe+c9iy12X/es1SSg05iM+
         bV2r8pDRShUqH6O+AnCdHcHWn8cBRceCi+FUwY61+/u5ydA7aFSzV0VqYBU6FKuH2Sx6
         88KhDwRd7OowlycGfnHaI+jpNTwFxi4H6l15o3MJ2oYxBv7nQy0oj/O7wZhyK90mmDzy
         FrPrshECqafU3xPo4U2j+Q1l/Gmulj6+ligJonSzzOjn+tN1jKxXoVPUCYR8x92XFg/l
         e0+2v+IjGuIAbWLhm19Mu66iA+Or0L4v8jHM861G3a3yInJy9U4yDLAjQVCMLomrlYek
         5Pjw==
X-Forwarded-Encrypted: i=1; AJvYcCXi6xBuo18rQdbhQFE6hWolSz9efxkRX6tlZg91gJpd8Y9KPolGcjB/9suYius4jZiTOvkGSVZ3iLb8JSy+bw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxR74xKhfM9DAwQ+ULoKJgtUxpvtAlepMZ1PufgjTQOCWjQA8vI
	kvp19jIg6NN9C5e2GwFBYy0UAxeSYqZ1pRjtyOVKjhibkETD6vJ5
X-Google-Smtp-Source: AGHT+IFrKCQScpPxemEjNo4inlsJUJ4zUHIc/PvEWxO3LcIB17Qy4vN/uLMJEYjH72+/k8IlZqRh8A==
X-Received: by 2002:a05:6102:e07:b0:48f:dfb8:77aa with SMTP id ada2fe7eead31-49d414bab43mr15069675137.17.1726663617491;
        Wed, 18 Sep 2024 05:46:57 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c645ce3sm43438606d6.67.2024.09.18.05.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:46:56 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:46:56 -0400
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <66eacbc0b16e7_29b986294cd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240915-rss-v3-1-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915-rss-v3-1-c630015db082@daynix.com>
Subject: Re: [PATCH RFC v3 1/9] skbuff: Introduce SKB_EXT_TUN_VNET_HASH
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
> This new extension will be used by tun to carry the hash values and
> types to report with virtio-net headers.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  include/linux/skbuff.h | 10 ++++++++++
>  net/core/skbuff.c      |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 29c3ea5b6e93..17cee21c9999 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -334,6 +334,13 @@ struct tc_skb_ext {
>  };
>  #endif
>  
> +#if IS_ENABLED(CONFIG_TUN)
> +struct tun_vnet_hash_ext {
> +	u32 value;
> +	u16 report;
> +};
> +#endif

This is unlikely to belong in skbuff.h

> +
>  struct sk_buff_head {
>  	/* These two members must be first to match sk_buff. */
>  	struct_group_tagged(sk_buff_list, list,
> @@ -4718,6 +4725,9 @@ enum skb_ext_id {
>  #endif
>  #if IS_ENABLED(CONFIG_MCTP_FLOWS)
>  	SKB_EXT_MCTP,
> +#endif
> +#if IS_ENABLED(CONFIG_TUN)
> +	SKB_EXT_TUN_VNET_HASH,
>  #endif
>  	SKB_EXT_NUM, /* must be last */
>  };
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 83f8cd8aa2d1..ce34523fd8de 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4979,6 +4979,9 @@ static const u8 skb_ext_type_len[] = {
>  #if IS_ENABLED(CONFIG_MCTP_FLOWS)
>  	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
>  #endif
> +#if IS_ENABLED(CONFIG_TUN)
> +	[SKB_EXT_TUN_VNET_HASH] = SKB_EXT_CHUNKSIZEOF(struct tun_vnet_hash_ext),
> +#endif
>  };
>  
>  static __always_inline unsigned int skb_ext_total_length(void)
> 
> -- 
> 2.46.0
> 


