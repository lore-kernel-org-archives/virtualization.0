Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8D1FFC4B
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738789970; cv=none; b=Y/zWu6m5HT5DcHpKAv18UUSJdk9kjfIoRFGuJXNjAoFui49db9QG7iTLUV3m9dzO8a94wulLzAsNxB4/aTC75Bqg0VUlNkGCHjMBhvME049JjTlDzWGRPcZswjIrOm6oCVrbATCxvwbSvcxV7TRPZLajgYDMyal8+AyjhmR4/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738789970; c=relaxed/simple;
	bh=J5XE7MnQtbhTshwOYeuFwneZoCl0STqhgZhQmIg9y3U=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fzhE53o2mOrkF/iKUTuz4QL7yJyAycw46/SbUpGSWIKfiJM98Spl/58j1Y9fwl/CSjJVXS19xJBk+YCI9PJeTegQUhHIOOvstOBuIMjxx1eq+56PGqakceNA4+G4kTRK9ekQUTwvrc/OblDO67fviBlUr+4G8wFu07U4Zujo0oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbzb7Cx8; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbzb7Cx8"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9EB760B57
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EXzxLtiaCHfe for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Feb 2025 21:12:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::e29; helo=mail-vs1-xe29.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D9555606F3
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9555606F3
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jbzb7Cx8
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D9555606F3
	for <virtualization@lists.linux-foundation.org>; Wed,  5 Feb 2025 21:12:47 +0000 (UTC)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4afed7b7d1bso59018137.2
        for <virtualization@lists.linux-foundation.org>; Wed, 05 Feb 2025 13:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738789966; x=1739394766; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xi9j7LZlV2SUJAQTXwi7YERrm0ctW3irKCQf/6lFSM=;
        b=jbzb7Cx8iM1K4wVbq+LFfHwl8grsG81wmriJvZFsgskRRDUdX+YSNddTfJGNDL6uSx
         aEXgxteUgErpzlzrCZDlSGajsD2TEeQmdU9+NsEXRuk4aSlL35poDts0dL1foMOKLAQw
         YbpyKyGU21oV6WZHzzHwzt3VlDb6J+jWH36zt0vgaLdg6r3bdEAkH6x2Y1MQg2T5aIoJ
         iBBI2Q+QAqFAhVTrIUJNJXBwfk+Jhoh96HED7okNGfdtscLTa4I477je8w9kCEii3ZjV
         +2DUwBQOA9k69FOBA3IiAuX4VU/sNC1ZKZupLr4vbyuuwo8ba9hOCCYP59tlerIBxCWi
         JgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738789966; x=1739394766;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xi9j7LZlV2SUJAQTXwi7YERrm0ctW3irKCQf/6lFSM=;
        b=YLCnLMsEz7IynuVQC/VyQkw6/75YpQm3KAFoViQCl8yo7y4IRzrPZGqpDxl7C4JxMG
         T8AS+wjlFbg56Se7nBPjjjrvxr0REsZgRALU2AqzkZydgpBQl/2rk/CHwC2gx+Pkmafh
         sMtV1PM/1jg937MnL1plnJouDyUth8bQrm0qlrVZKcBH8EZpUPgjVfr8SMQYJGk6YCPr
         nsrQP+GvW8w5llQtkfiV5/rwp8jRTRZ0YLX7+UID4ayCFy2D2l7/onpc9K4XWUde1PxN
         1sedE1PzwwzyC3wE5YzT/6oJ2CkNduMFtppfMgU0eyQ4JnSd1X58cwCIQCAWxhn7ggDL
         jLjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh+Say1QjMkwFDlhrg9zjJvGqKxw6ExLwM4nsnFLiWvIsimXvmGdW+7haEL0dzuEaV11noM3kLFZAo27mc3g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyNhyM2/X1bu+WyA9nFb0uO/2ZotpPnkEAnniZvzogXFx6aepGj
	eVxfRMeExQk3KiEH1gKv1znFGb/RSItPS98VSeXzF5Nkrl9/yugh
X-Gm-Gg: ASbGnctVJQyVvJKxnKdMZUQYQVGWqerJMQjpxciDFXhtrSipxMuu5SDlN6h6pbBa5zz
	3R845/Yz1Jh1YiPEIVk6Bhh9RgJ1EWxD1LmSUcvOmYHn/vR5+Dg9q8kKN5fHld6noJxvO4K2uVJ
	TgckAgFOLgRrw1E8TflVt8dEjjb3BKrAFQWlh3XbF5c398j0JeJXfeDcAoNJOHnubbJFBgXzt9C
	bnciFBysNcaMEONoTYajtf2OZGCq3ledCuNramzBT2k0v6ToYCMGSuM16Yt3UvpRIoKNV8Ke49e
	9RSrizqMXDkKaqzUCHTuoddwQHaN0OuT1kLhnZdq0RWXOoTO4itnOIj6ATNvFBI=
X-Google-Smtp-Source: AGHT+IHVJriiE4RgD/TB98OD7KhhWkj9HMgkHe3bJLqoRArq4OYT9AU5jj7A1Z5rXze4Tk/0637oNA==
X-Received: by 2002:a05:6102:1609:b0:4b6:697c:6b89 with SMTP id ada2fe7eead31-4ba46dab167mr2854007137.5.1738789966444;
        Wed, 05 Feb 2025 13:12:46 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-866941f13b0sm2547855241.30.2025.02.05.13.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:12:45 -0800 (PST)
Date: Wed, 05 Feb 2025 16:12:45 -0500
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
Message-ID: <67a3d44d44f12_170d392947c@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250205-tun-v5-5-15d0b32e87fa@daynix.com>
References: <20250205-tun-v5-0-15d0b32e87fa@daynix.com>
 <20250205-tun-v5-5-15d0b32e87fa@daynix.com>
Subject: Re: [PATCH net-next v5 5/7] tun: Extract the vnet handling code
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
> The vnet handling code will be reused by tap.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  MAINTAINERS            |   2 +-
>  drivers/net/tun.c      | 179 +----------------------------------------------
>  drivers/net/tun_vnet.h | 184 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+), 178 deletions(-)

> -static inline bool tun_legacy_is_little_endian(unsigned int flags)
> -{
> -	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> -		 (flags & TUN_VNET_BE)) &&
> -		virtio_legacy_is_little_endian();
> -}

> +static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
> +{
> +	return !(IS_ENABLED(CONFIG_TUN_VNET_CROSS_LE) &&
> +		 (flags & TUN_VNET_BE)) &&
> +		virtio_legacy_is_little_endian();
> +}

In general LGTM. But why did you rename functions while moving them?
Please add an explanation in the commit message for any non obvious
changes like that.
