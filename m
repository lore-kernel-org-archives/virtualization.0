Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC71F942E
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737105838; cv=none; b=L4pBjaXlGc68ffDkych/l3//mydH9nEc7ZxNBvLVJFhpTzzOK+H6fvWzzad2u5z7zmrnDT+s2izvURQZGxqGkxSq2V5rwwqG9KMOqBqksU6WfXAEtF8hOutIxev8gmtc/SYa/a8Mt/Ta2EFRD+Ul7P8081MqU8253gxb6i7xoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737105838; c=relaxed/simple;
	bh=50hALf/6JHENCC8eS76LlBaB8m3rt1/ock6nsrhlS3M=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=K2W6MJI02wjDo1/WzUXUC/gcV4iwEfVbII78b3HypI94diqoNfcHKdHQIkzaWg4IaeZ0yHAll92jnhOo0v1qQOGMTYIJOmxOeI/2TFWWWyRVwCKYQmd1keVMTSrj/DVyD1l62X1vQXS21BRVQ3ubwEEFQQ41+Lw0ybDKOjHr9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMEQFqkk; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMEQFqkk"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F8B2417C2
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:23:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ueOsF4-SKzUa for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jan 2025 09:23:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 915834178E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 915834178E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fMEQFqkk
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 915834178E
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 09:23:55 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7be49f6b331so157071385a.1
        for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 01:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737105834; x=1737710634; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUHC+rmP5s8u9ue7y5NSHcW77KbmtVUiG9NQgfxlEs4=;
        b=fMEQFqkkhLahmi+uqGa+CwQICt2aKra8Xds9uGtKmbWmCrGyhPYXd6mi/V+7ABNg7a
         rZh5auKMGWcO/bxK8N5gagJY9YB5hZ6fUy0rSDOxPs8B6T0TQQlpcLbw00xTmp42gAUO
         jUBjPjYLLUejzHnV5U5zGt1EvGsQRwhnh6RcqGjwT8v4hi3M0hn80Nbtp7X5K/iviGsu
         dK/m0YU8OU7ma1JTRU8TuEfK68QEq7Qc7aCgDL0xARdkHSqk4ImCoh2JAEejgDjnRpIS
         4JfVOztO5Cbq1YQ6OCfMrgkz8iikK9bzWbFEvCoVjr4qm/3AC/QRPUEeo3YRSOHzPqOo
         lrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737105834; x=1737710634;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUHC+rmP5s8u9ue7y5NSHcW77KbmtVUiG9NQgfxlEs4=;
        b=Qic2LvdmEEnHseUpci1cnXde8WBQ9qSOxmrvazmDZLWmi07G0HSqfmE1V/jCqJLTDR
         p/Z6YfwgTrn5Ge9AKFivjuOf3F2GDnXzpBvvfQTTnKukS2duoSwlchyJLZZkloZH1gJr
         zqG2cGBX7HtranuuJ3Eo3adshhn26ai5zB1/Bh/v4JptO6W4uivJCm7mk3EpRmfxt2BL
         zuWFNfMYQFKWeYAeZu4A9mKa0HMvf0ZUCBhHe+7Z0TW/bVWHs3RrFAwnAifhNmWrZPxU
         HsnGs7JbsuIm1cuGIaxlAaXgRy/NswSk5FhbTjMdrGzeZ1MFW8KrRE/0URuvLBqEG/P0
         0kjg==
X-Forwarded-Encrypted: i=1; AJvYcCWcw1M+GRxGP8GwWSq9nNoHhuDfT4Wp5UanGOi09kYC/aPfd2K76aYz7fUGxt1LIBuBAv/s91X9RKkIN+fUng==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzjDYU+drUuwUASPmR2DM/aF8+Tp/BVtZ80WHmwtvxjVHqnoM0V
	RXybO0yViACE54VyJgj1EUGLxCARt542fiY9X44R/79dgS1L00n2
X-Gm-Gg: ASbGncvsayDRo1aPySVqh+0k9ZOW3f3wNzc91oQOCFKCYkAguQCm4Na/4RFHwtuqohu
	99FkZllXE86fjhAy4w8RFI7tOD08xZFbiDdSaSj+YLMAthgV/WCCdhhe/jyGc+vVEUybzTeeS+J
	qrnStZ4P21QtVNaK/zAJiWXeMp/oagZucRNjUeN60emVUpIjfjdWIYJ2uhlK+rolzCNLh6S+xUT
	Qw4ut15SSmVywX7/baiTNB/ZXq4u6Al+9LC+Ytey/BPZEGwNTp3qw3/2U1gvYOolPgRfDLYxzvB
	R5NVn4WjIik1pBw0odpJt6ZnRgcJ
X-Google-Smtp-Source: AGHT+IEMu06W4+1L5IGQzrWbh5FGKq2dzIxGEx4RdrkbuTSxndYZ95YVhigy3GzlsmK1SHrLp3dALg==
X-Received: by 2002:a05:620a:3942:b0:7b6:e9db:3b19 with SMTP id af79cd13be357-7be63287a2bmr335761385a.47.1737105834081;
        Fri, 17 Jan 2025 01:23:54 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc0f877sm9579176d6.31.2025.01.17.01.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 01:23:53 -0800 (PST)
Date: Fri, 17 Jan 2025 04:23:53 -0500
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
Message-ID: <678a21a9388ae_3e503c294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-9-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 9/9] tap: Use tun's vnet-related code
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
> tun and tap implements the same vnet-related features so reuse the code.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/Kconfig    |   1 +
>  drivers/net/Makefile   |   6 +-
>  drivers/net/tap.c      | 152 +++++--------------------------------------------
>  drivers/net/tun_vnet.c |   5 ++
>  4 files changed, 24 insertions(+), 140 deletions(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 1fd5acdc73c6..c420418473fc 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>  	tristate "Universal TUN/TAP device driver support"
>  	depends on INET
>  	select CRC32
> +	select TAP
>  	help
>  	  TUN/TAP provides packet reception and transmission for user space
>  	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index bb8eb3053772..2275309a97ee 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -29,9 +29,9 @@ obj-y += mdio/
>  obj-y += pcs/
>  obj-$(CONFIG_RIONET) += rionet.o
>  obj-$(CONFIG_NET_TEAM) += team/
> -obj-$(CONFIG_TUN) += tun-drv.o
> -tun-drv-y := tun.o tun_vnet.o
> -obj-$(CONFIG_TAP) += tap.o
> +obj-$(CONFIG_TUN) += tun.o

Is reversing the previous changes to tun.ko intentional?

Perhaps the previous approach with a new CONFIG_TUN_VNET is preferable
over this. In particular over making TUN select TAP, a new dependency.

> +obj-$(CONFIG_TAP) += tap-drv.o
> +tap-drv-y := tap.o tun_vnet.o
>  obj-$(CONFIG_VETH) += veth.o
>  obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
>  obj-$(CONFIG_VXLAN) += vxlan/
