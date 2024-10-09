Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD619995E
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482251; cv=none; b=Cd0l+hKS7A70cGamfQQVC4BaB4E/xvurKqU0kA/iL+UJsMKEtUix51M9+z/T1OnI9bBEfHh/g8TbcTzA3xCvtg/gwDPwaPwMXJSW1B95se+5187Mi00mqxIOFetlyTSgNUDUhpRMi0h2WSfyRzwPfz92Ayn6HLnWkQWFcD5Pve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482251; c=relaxed/simple;
	bh=X0LDCmpcnc1adz2fnYJm3D5QrEBMDrL3aPUwWCtc1TQ=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bsLY2e0UR/9kkwSHBhpRYYJYyVlUitkoqLRihZvT0ZZXvAibNy9icqRS7fD1PgwgtKtzrDZw9R9EDAtiHVfeBDDpyAajmkMHzNhA+/12iPfGmDB+xBVHBUP22nSpft/SElcfDO0sEntCab8cR2Wr1tsxrFVs6DJ6VOONLGXJTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWh/REQh; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWh/REQh"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A1FA81306
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 13:57:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJz5vpwROx68 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Oct 2024 13:57:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::f2b; helo=mail-qv1-xf2b.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B709981280
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B709981280
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iWh/REQh
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B709981280
	for <virtualization@lists.linux-foundation.org>; Wed,  9 Oct 2024 13:57:28 +0000 (UTC)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6cb82317809so52004936d6.0
        for <virtualization@lists.linux-foundation.org>; Wed, 09 Oct 2024 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728482247; x=1729087047; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n1Wq+38z4bNzMcF/qhs9zhsIpvH1Zsp4bf0q5tWWSY=;
        b=iWh/REQhzKIBuqONutOiSxr1ISX/vsFvVJRmu56ybHpyPHNdaG9raV+q9Jrqlx7ntx
         Ck+Of57qXg5cRiXDUYBCIgchtszKTfmDCH/Y+P71ROrfyJvvLNNQKNg9NjOoMoWB8Zmc
         Zu5dkIOsxmPXEQCcFkHNcAG4Bb8qLsf9fb7n1bT70F+kD1wBkjeapdijeY7OEmRi1JLO
         1OPQCh6DbSDwwjo4XwMtfTOj2QUrdRIU9dS1c5TJl2TqkzArRZ89/HjcC6JyY05AMubn
         chFv0rSIO0i0nHltNcgVmC567CmpAlN+C4pUlhCs0Ydivss7il///JBh2HZvQ5rqY0Y3
         aq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728482247; x=1729087047;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n1Wq+38z4bNzMcF/qhs9zhsIpvH1Zsp4bf0q5tWWSY=;
        b=gD0D2CHHELaSZVIVIU4aPnLuAD7eB/hYOiDTqZB1XNJDyD9nV5cO5YhInIqFbT6lER
         8ybyxB+xW68uo8U1t5gGXgmRrGEAdicU/v76UYlEPCbFWPlkhkzLQPqwle0DPt43RHhU
         7ehvDJFzGJNf/MkO4OWKK4MnEDa5afKC9HYAPK1T+l61BBLya6yW430k94nPkTbOc+Ww
         Ey6KAf/3p8SYFapCDrznX9Q7sAXCRhvwYlbNYyPgjrtKJcE/FndeGwSMxFQfgNxWbVR5
         /iOmqVgf+VAuU3Ek9MXvx+HfpL+JdagXPP5raQgc1du0ROpHTbFJPumPJvVkJdIMqANx
         5wYA==
X-Forwarded-Encrypted: i=1; AJvYcCWzQHA6wxgmi4U3Zx0LtDGiH6WFCdz+jmmHoxeOwyhIiUFTusQdUFhD505QpMw/iHTSMBJO8Q3hBe50QdTq3w==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yx18C2+DKVwpFkmWYa4N2nzKZCbBYRZ08tFOvVZlqqd1JaVCCVo
	CUf7MaDyBSEdDLAvyW8pvQPFjboa5nTR2YyesR5x4BqkolO9MR6e
X-Google-Smtp-Source: AGHT+IFUArp5gUmYDVIuWKhH6zF8j9clE1t5vMCXq60kkQC+UxDtHZpBVpw09F8q0h35bvO2uTTdrQ==
X-Received: by 2002:a05:6214:46a0:b0:6cb:bdf8:e736 with SMTP id 6a1803df08f44-6cbc95bafc2mr50228846d6.37.1728482247004;
        Wed, 09 Oct 2024 06:57:27 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba476159bsm46166076d6.123.2024.10.09.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 06:57:26 -0700 (PDT)
Date: Wed, 09 Oct 2024 09:57:25 -0400
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
 Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <67068bc5283a3_1cca3129482@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241008-rss-v5-6-f3cf68df005d@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-6-f3cf68df005d@daynix.com>
Subject: Re: [PATCH RFC v5 06/10] tun: Introduce virtio-net hash reporting
 feature
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
> Allow the guest to reuse the hash value to make receive steering
> consistent between the host and guest, and to save hash computation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  Documentation/networking/tuntap.rst |   7 +++
>  drivers/net/Kconfig                 |   1 +
>  drivers/net/tap.c                   |  45 ++++++++++++++--
>  drivers/net/tun.c                   |  46 ++++++++++++----
>  drivers/net/tun_vnet.h              | 102 +++++++++++++++++++++++++++++++-----
>  include/linux/if_tap.h              |   2 +
>  include/uapi/linux/if_tun.h         |  48 +++++++++++++++++
>  7 files changed, 223 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
> index 4d7087f727be..86b4ae8caa8a 100644
> --- a/Documentation/networking/tuntap.rst
> +++ b/Documentation/networking/tuntap.rst
> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
>        return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>    }
>  
> +3.4 Reference
> +-------------
> +
> +``linux/if_tun.h`` defines the interface described below:
> +
> +.. kernel-doc:: include/uapi/linux/if_tun.h
> +
>  Universal TUN/TAP device driver Frequently Asked Question
>  =========================================================
>  
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 9920b3a68ed1..e2a7bd703550 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>  	tristate "Universal TUN/TAP device driver support"
>  	depends on INET
>  	select CRC32
> +	select SKB_EXTENSIONS
>  	help
>  	  TUN/TAP provides packet reception and transmission for user space
>  	  programs.  It can be viewed as a simple Point-to-Point or Ethernet
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 9a34ceed0c2c..5e2fbe63ca47 100644

Merge the earlier tiny patch 2 into this one.
