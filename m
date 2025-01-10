Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596DC1E0E0D
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479505; cv=none; b=fDi/gbP/QIlzGg3ATfie+5Sca0pIxIJNtXW+MJDKD8oskvAojymJ3ERxivNWBC7pNaxApo5SRV6Qb+ke9w83dJOY/x4oEyc8oELfQ+4xCi2XwhpFhOhK82wloeuWO8daJSI6+AdkHdVpZKGe6XzTBikVDyTUXIBBu0VkT6UaGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479505; c=relaxed/simple;
	bh=xiIZOksV9gK8x5lTS+rlahAEFaL/qj64KXL6RVencw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joP4QOr0anAdBtlgiOHmiqchmbwvDq6bKypKx5uC0cu0bBzPVP/ROgwOL/UK8NNBgvnMNcDAsZzno7pcm5Psu3c8/jKOjUDIsMg5Fa8FgUCeTjVz2efPMAR8fwVRCoIwhBO5DrOrZ2oTFqUS+l8/aHlxILpa7OtvfGrWAsgIo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGoWxuua; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGoWxuua"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F267D407B6
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:25:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v7lwMzjrc9AU for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Jan 2025 03:25:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1732E405C9
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1732E405C9
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGoWxuua
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1732E405C9
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Jan 2025 03:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736479500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ux/EFJGUhHtGiPWKsNCatUDg5uRU42FVCWFIHQvV8s8=;
	b=FGoWxuua4vh9ZGE34vxHBfMXrmAA0IqaqUQSOfBG14Fh7uMn7akli2l2u5ChCY5ZzuQiai
	o3YzTmCAGJczKmJVWDj/QvsEw8WVVAySuMG3y+UmmTVj+YEtpATcoctzDK/WfsG1GDdbiF
	EMBAkw/0kZAYfn+UfNrFcYCF29oT4Qs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-iedGLLHrN5KgvZ1e_c9_Qw-1; Thu, 09 Jan 2025 22:24:58 -0500
X-MC-Unique: iedGLLHrN5KgvZ1e_c9_Qw-1
X-Mimecast-MFC-AGG-ID: iedGLLHrN5KgvZ1e_c9_Qw
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef79d9c692so4250598a91.0
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 19:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736479498; x=1737084298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux/EFJGUhHtGiPWKsNCatUDg5uRU42FVCWFIHQvV8s8=;
        b=EIWvwGuE13Eq3o6zShqEhllEUXGGP0uWZe2yKqM+UWLOVIpdf8R9WXqSu5SkoiImYI
         nHSWxWEVHDW0QYqU4chaqxALWrvq9ok/9p+cLxvd64vYnGe3BuRNAVifN/6/cuAuSu4/
         HCwQSwZd5eLrXgzsITYPK1+C6Ul4rg6O7BF02hhqpbdaUSv8ikFaWU1BdXjb3gJZ4aHb
         QHpbLgOMD6a+CRhnZK2g98b3L1jCXEXTpjk7AUbMxQMnKStIBIQhJJsxsfObbK30vXnL
         Ynz69xbIaVWZrGx4DjyEbAABtuUzFBRcO+3fiCw5ObEy89zLJLqN+9whWFp4Ub01xDyo
         Oo+w==
X-Forwarded-Encrypted: i=1; AJvYcCXr/l6BpSnLtTudgFnKXv+lCcvlF6+fhhhAC1g7t5Ps1Kq/2s96vaM0BtzRRn/TLVt02f/oSCMHkG+/PPBMpw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yzo0MgYS/whETCk5l14OruHj1vveO7n6PBNWDp9mBfdzIKztgYb
	imS548UmA2JpMKbEH8vaxGi9/5mDt8fHea26FInGPYM2pD6cFhlFFDvS8mORHvzyRzVv54ul6OY
	hKTdJkrMToDU0cJf/1Bco8BxNmjDbOCk3bgFzLnt8L0rbxH5CZ8uUEEVOhHLE3wjOn1r0Ixjjun
	jiQXE2gk3Awy5YFiskyI7LVSNBJg5whWa/YRL7CJcaG7zwGEIgFFQj7g==
X-Gm-Gg: ASbGncv+Q5O15zquSNt9tyoeR7cFoGpm5KaWni4krtvWiQxoFWZh5YOxcydBYKbelzB
	RtxvBPCd0ZUbU0fq9lUf9qxGE9V2VLTGB/TgO1Ro=
X-Received: by 2002:a17:90b:2f45:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2f548ece7afmr14119981a91.18.1736479497873;
        Thu, 09 Jan 2025 19:24:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl4su9kuwxLueN6s9pabolA/u0yv9vnPxFtYkK0ZVCk201Nafu3Va6ZCJu8GUQ/vQJh85IIDkmsOql8mxd8mA=
X-Received: by 2002:a17:90b:2f45:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2f548ece7afmr14119944a91.18.1736479497484; Thu, 09 Jan 2025
 19:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com> <20250109-tun-v2-1-388d7d5a287a@daynix.com>
In-Reply-To: <20250109-tun-v2-1-388d7d5a287a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Jan 2025 11:24:45 +0800
X-Gm-Features: AbW1kvayDbWMw6YuULfNbkLhEoUv0nyH0UVx2PFd5rLWnQcrUga4t_8H0CMLDNk
Message-ID: <CACGkMEs2S=G-Y077hCeFE57ar0h1A5EaySOOTcvFZUVC0oGdXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tun: Unify vnet implementation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bjl7RwILYoXtPzj6k6kZpixNWHav7jKclIcKXctZax8_1736479498
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 2:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> Both tun and tap exposes the same set of virtio-net-related features.
> Unify their implementations to ease future changes.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  MAINTAINERS            |   1 +
>  drivers/net/Kconfig    |   5 ++
>  drivers/net/Makefile   |   1 +
>  drivers/net/tap.c      | 172 ++++++----------------------------------
>  drivers/net/tun.c      | 208 ++++++++-----------------------------------=
------
>  drivers/net/tun_vnet.c | 186 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  24 ++++++
>  7 files changed, 273 insertions(+), 324 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 910305c11e8a..1be8a452d11f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23903,6 +23903,7 @@ F:      Documentation/networking/tuntap.rst
>  F:     arch/um/os-Linux/drivers/
>  F:     drivers/net/tap.c
>  F:     drivers/net/tun.c
> +F:     drivers/net/tun_vnet.h
>
>  TURBOCHANNEL SUBSYSTEM
>  M:     "Maciej W. Rozycki" <macro@orcam.me.uk>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 1fd5acdc73c6..255c8f9f1d7c 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>         tristate "Universal TUN/TAP device driver support"
>         depends on INET
>         select CRC32
> +       select TUN_VNET

I don't think we need a dedicated Kconfig option here.

Btw, fixes should come first as it simplifies the backporting.

Thanks

