Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CA18A6C6
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726663928; cv=none; b=cedyTDMLOjTMohLgJMJ5OXchtJlQk7aoEhfKZ6Ivsf1hLIskV+vdoLu9U3H1ZbDbAhm/1zlqpF79v1i9Nedb0egNpwzUCcEVOlJDl00Zb41CcMyNnOlsrazC85G41P806GwAHvnxb5NTCUn5+1hqXP3L9YLhzuiY8GsSFV5pf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726663928; c=relaxed/simple;
	bh=5u1zOtKAM5FNnstlmq5xaC2tZPa+di5tlrGcuD7I04c=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dZEUgbHCd6EiNNOo7Ax/T5N2dn5mmt+oJos1oeoe48IJmjyGQrz1SlLBi/Tq7tLzNRAzPwBWiEdVLldIbo3j1/7Z13GFFReQ6gMwHpKzu7AMT9jRreKs0nE2ZRUvizX6KH2PLmVK8N1X57lPD+fNlMUJ35J3vTUSBWJDhNFtqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxNF1KO3; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxNF1KO3"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 751BB841BA
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 12:52:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRHtZaeikxWY for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Sep 2024 12:52:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::732; helo=mail-qk1-x732.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2429A841B0
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2429A841B0
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GxNF1KO3
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2429A841B0
	for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 12:52:04 +0000 (UTC)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-7a9c3a4e809so496659485a.2
        for <virtualization@lists.linux-foundation.org>; Wed, 18 Sep 2024 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726663923; x=1727268723; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OEoAasUTTYgmGLu2/+6ETqePrAGADXX0fzkTrJ1tjQ=;
        b=GxNF1KO3T1JisdB8Gi6rjQLXKwXwz+0xkQ2KGEWm79+Lfa1k9z8xgrPh2x1lbeGTVm
         Kx1tbxDDUT9eRiT9GmgT5/hzAOG9cNN7V69WFOt7tMiBNAPbdgQfjv2OBH2nTPJumyCv
         BI4UaYeu92meJVtZ78q5NkBChAxG9Z5w50uZsPCE3t7QIrYq5csbmGRtsiV5Cjnycy1p
         gTm+4e+hsw8FDwCKdnwR4XRKsjAM+X9NZwr2twatffxEHztA+bRCmiCockUUnbMxMYb5
         tKR8kDzJCqlx5J8JHKqMwsPnYXeeLwz6hl3GuLrjVzk14irlzBW4CutmRi1ndVgMKSVT
         5D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726663923; x=1727268723;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OEoAasUTTYgmGLu2/+6ETqePrAGADXX0fzkTrJ1tjQ=;
        b=qvlctJt2EISGLZHbqCXKz61WErdbadV5jCnU1jZTkP2KtIgXSvouKa9o8ApR6r2Z/1
         UAc5iWSvAFQNZ5moOnA6M5Mef+C0K14U+1IMIRwqAuJGU9qtP2Po4eoaYWdljfYfS/y3
         tNwziNjcdsTA+LgaUr4tCRnJpLN+BpxwDCwKsMRLbrWNQhdl32T7R+QuXo/4io8Yc90z
         t8PYNFyNo2HczjeQRS156p5lHyQLokSZmBlxg/pLg1enZB3uviKCR4iP3VlloZDBPsyD
         Rs7RXCemqa8ALSX52tE6Fbd7IsoQq5wuCu2EPFdAY3S+7FxDnEdFbPzWEMRkzi0/AhVm
         b50Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHkoqR/v9IGT4j6k32rwDX9JNY/3gvY9KPOXQRlryQaESqq2RZD3fJ6LgTVAJBN0tkqz+A8fNNcdenUmEdGw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxPzsRage1dLemgVN8B9iYXjuoef4nc7wj2LvW5XIM/DgLAqpLo
	L75kFhg+6DUZffsnhcRc3gcxwdEzZIhpYB0SVxgWUBheFOdMWn47
X-Google-Smtp-Source: AGHT+IF5yR4TSO8Lu46eN/XdtU9LOZKv1dJO+CJkJkzm4gfBDjBFjafucf890TMmBj2PAFVeO31T9A==
X-Received: by 2002:a05:620a:4088:b0:7a9:a0a2:1455 with SMTP id af79cd13be357-7ab30d2528amr3669192085a.24.1726663923153;
        Wed, 18 Sep 2024 05:52:03 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e964080sm453959485a.4.2024.09.18.05.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 05:52:02 -0700 (PDT)
Date: Wed, 18 Sep 2024 08:52:02 -0400
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
Message-ID: <66eaccf25bc47_29b986294eb@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240915-rss-v3-4-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
 <20240915-rss-v3-4-c630015db082@daynix.com>
Subject: Re: [PATCH RFC v3 4/9] tap: Pad virtio header with zero
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
> tap used to simply advance iov_iter when it needs to pad virtio header.
> This leaves the garbage in the buffer as is and prevents telling if the
> header is padded or contains some real data.
> 
> In theory, a user of tap can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tap.

This description does not describe the need for this operation.

The new extension seemingly requires these bytes to be cleared?
Please make that explicit.
 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 77574f7a3bd4..ba044302ccc6 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -813,7 +813,7 @@ static ssize_t tap_put_user(struct tap_queue *q,
>  		    sizeof(vnet_hdr))
>  			return -EFAULT;
>  
> -		iov_iter_advance(iter, vnet_hdr_len - sizeof(vnet_hdr));
> +		iov_iter_zero(vnet_hdr_len - sizeof(vnet_hdr), iter);
>  	}
>  	total = vnet_hdr_len;
>  	total += skb->len;
> 
> -- 
> 2.46.0
> 


