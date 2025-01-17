Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4F1F91DA
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105499; cv=none; b=bllNJE2kZZz8I3d4yeFvd4SOT8a0+e/uvgnpHaT9pcPjxlQ6rC5bLWqJgU1rWWFZ6x0uP2eszGMjKr2Q+kh2D4V+fxnz/LrFKLiz25bA9E+lS84YxTg6xxL1zFO3cxgZfdfiX317MO+ivLte+poGQHr1W3rRD35fnGyahOr4U8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105499; c=relaxed/simple;
	bh=RV6RXs0gcTNOti1+8bEel3sM0z+UvSDpbVmTm3XMtFc=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lAagS1a64AgyalAS96C3IforhP9hROFFy3s02TvhYq46ALMlH5oyKMjEQDGSsyvcrluhFcGbLMmgQznghRly162a+tvwnl1kBsqOx+e2/MsgrQth1vYRq1G3EfwlxAPzHwPq090aQH21ObW/Cc6iyQJUog0APABIzcPZSS8VN0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZzzKh+a; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZzzKh+a"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6880D606E5
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:18:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gA2LOlig83iR for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jan 2025 09:18:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A548260706
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A548260706
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bZzzKh+a
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A548260706
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:18:16 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4679eacf25cso11877371cf.3
        for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105495; x=1737710295; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRc4pJ3jbfs9xw83YIL2zd+fqf9z+TDnT5AsKk692iE=;
        b=bZzzKh+aVIdBwpOf4lgHakFxgB3D5g9m6pW9jhetqxh56znRAeZr2ymvFFp6c+Whfk
         HxcFLu/Pbv5KsSp5qfmy56AixR8dE4SOGmwKKAIimAvNpjETkMkjlib9yb/Nd2gNw9NQ
         NezHZwL0tzxWJKvFO6zfGykN9+3jR0gUqnIjW5ss9jEXVM/dZDJQT51diuqsMha7Ldkr
         k1NbI8nfwjLTAYGBr3CiQLCUupnHX8TBeMTqnYz0VG+7/yatDyUjswmv79ZhypoOLTRE
         TjRvYVu5jt3pRhTXp50ZY3HPde+UjYhPeNMtlGO9Sw5O3AhPKncTOropNK+v5tlLs4dd
         gHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105495; x=1737710295;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRc4pJ3jbfs9xw83YIL2zd+fqf9z+TDnT5AsKk692iE=;
        b=u/Obqifmbk+TenPMwmG3ILcyLlhDc65wezWK9+t4odK8yN78XyXQRXc9RAFwOmUPwG
         0TuOJ5YxJ1M2hcXuZhURGdhhuJjheYabeLgnLGYcoHW9M+wDkPuQPg2FwRZcmci/bd7Q
         9Aif6+/tZJgxJQ+MFzwSaTmUstNu9QahI73hv3QCEN/kIKG7Kc51c2/rkIHkEFaHScHh
         8/4wS8If/KW5i0T9xwVD0ovPsu6BXNzxt+7UcVJknjZjQsruQ1Q9r1IFc+fgOjiuRlTI
         rVqjFfArzXm18V2sdxSXaVsLbtOVBCONZpxblIDssGiKiRaF3l6oYuEhjyP3AgKsjLCc
         773Q==
X-Forwarded-Encrypted: i=1; AJvYcCVM3rxpjp8z51v9r5Dv1kEW4tIbUAg3WKnGirTiJ399v/TG/88EDdfV2zEivQtND2WoU6ZTO3ITv07/QrRMMQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YywaH3QUfBhUtrDrwgHLU4lXg2zr2C4das7fTcXgQx9tiaRz5v2
	VomCvp3zje9NqCjEYFaILxqkJT6TALETk+EvXyiOWKt1R7fIQzFu
X-Gm-Gg: ASbGncuTUPe4su9bp3GJZ4oEeKnQwy4iDsyS/s+pa18I8X5QJJkaZQG95hYzrVK+cf/
	Xi6RYu7arGU5ASosta0p190mfdzCqyYoqVBpG2lVXiSJVWhsqK7DGiUMDkkky3Vr6uU2mEPrHA9
	2sLU0UKcLCZLyD0nPLrs5042hpiodlEO/n+9Y2nxG5grNEbr2lcjCoGRJ93tKUzf+t07H11u6oK
	di73nU+pTCOknlFY9jB17WsbgKo++ukMDRrMwo3FkeJjnvK50JfVm30XpwQp2BA+EERS7tvH7c8
	ns0issosiufqb1Y/TRXz+ylsZn4V
X-Google-Smtp-Source: AGHT+IFqniVuHfpG5nj5bXLQpzPI092VwpWQMjG3HMguT6Fe+qg5qdv/hCsmLd6zNBeyZ+CgpugYMA==
X-Received: by 2002:a05:622a:11cc:b0:467:456c:2957 with SMTP id d75a77b69052e-46e12a1e6efmr26486311cf.10.1737105495325;
        Fri, 17 Jan 2025 01:18:15 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102fbf2dsm9495561cf.24.2025.01.17.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:18:14 -0800 (PST)
Date: Fri, 17 Jan 2025 04:18:14 -0500
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
Message-ID: <678a205681078_3e503c2948c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-5-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-5-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 5/9] tun: Decouple vnet handling
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
> Decouple the vnet handling code so that we can reuse it for tap.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tun.c | 229 +++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 133 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index add09dfdada5..1f4a066ad2f0 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -351,6 +351,122 @@ static inline __virtio16 cpu_to_tun16(unsigned int flags, u16 val)
>  	return __cpu_to_virtio16(tun_is_little_endian(flags), val);
>  }
>  
> +static long tun_vnet_ioctl(int *sz, unsigned int *flags,
> +			   unsigned int cmd, int __user *sp)
> +{

please use vnet_hdr_len_sz instead of sz. It's a bit too cryptic for
a casual reader to understand the meaning.
