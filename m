Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA81FCFF2
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110553; cv=none; b=AUWF+CRrvSMQ3MsrlWiddg6VuyjNoKFJ+tJqKHCJzOQ7UhwzvbD6XFgMFkLkv2ynPVlEyz2GXykFcUQRxCKsC0kf/FbmAIR0RzCiR7uxtlwleHdq9Ely05ked2soxS6+QcGxCRUL5eSxg4nsbPds9vLkFEZM217YhNhnb8HwKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110553; c=relaxed/simple;
	bh=tkG3TzeNvEiwvG1Qxi/YPhrVwe6v7iJWNqSDUwELPzA=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=X0eoeecUyl2ssqcEO48CwTqBRnwFJzL7NIAYYqRT/hG9PMxC1vSCjtK0DCZi2rccpePfDVQLNglMtc1QEk89mz/0/vnTu64Y9ZzTvugPcy6CvS+L9Dp5zlMfoEEtH+fSziF9nRLJFeNMpKCYPgTGBL2bJ8WInWznV/19RLM3pDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1ehe84v; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1ehe84v"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51BE44246C
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:42:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uRdt12LpqisK for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Jan 2025 10:42:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::736; helo=mail-qk1-x736.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2FA314243F
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FA314243F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=K1ehe84v
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FA314243F
	for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 10:42:30 +0000 (UTC)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7be3d681e74so158834985a.0
        for <virtualization@lists.linux-foundation.org>; Fri, 17 Jan 2025 02:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737110550; x=1737715350; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNtqSoB8h2OW6duTMoHIjm4z9+1zxo9SGQm2VEevlOk=;
        b=K1ehe84vs5kNsOJD9FCcl2FCH8oOjoHRkkS5jxlzyYURlwYf8EI736D0slwqLaefJg
         WKT/TzxG+9di3RYJi9UoCXFeGs2xxWlqr1C3P7ONIjb7I5irRPCCp5Cy5Ab1foutOuem
         kLIERiNwgC8kcxfFhsgWquYPpFYLc5nXCnq/evDoDY649WrQ6TU2LuYW51W96tqPY2dC
         AygcSo3gbuaK2QpgLdRyzyMbS24+0OawW3dPaXSIZBkK09LC6ead4213M+AwiwRlhh9k
         8CWZoc4SO03bFbFSMDgaAKo0eRGXN64KXiEBNhSg0gQHL4jjo8mWOirKSqmyZI0XwuH8
         DXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110550; x=1737715350;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNtqSoB8h2OW6duTMoHIjm4z9+1zxo9SGQm2VEevlOk=;
        b=JTe6M6DMTb+rQxyu+LKMHUXJMJJykgsZD/3KB6s07gJx4LiQUX69vrVFYvpYgYB2/T
         Q14dpcQ4Wi7xD4MEoIbAqNPPMHKPWQvuuO4EWfz2kdhWvGCFuxwDDhQHsyar1kqKTPwt
         wcS7wC4Et6Xzdoikg/DdGr9SQULj3HSJPSvHr7N3H7Dt2lbuE7Vadv4T4MMrYBxcoyh4
         glWbwMX8JqFcAkFHWaYF9ruAsoJ3lXffM34N2ddORtcUw4Vb2SllxKBVSoycquPM2+9V
         U7LBvE3tvKv1o+R14Z+M2kSgExsOIoH2uwdp65/eqpEkXuEm60dcYhsjlYwiWjZNyKKc
         /tQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqVMPvc4bUKyVUQs3Y8UvN8Jgh/vzBNtJmVJrVAxUL82XEKUnrvawmGikW0+yy6z2eecoVxyY7vFPwM7b1pA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YycDsjjeCUHzuBuIfy08mcIgYMgf7Q0HXvfukae8zkU+3V8l7a4
	SOyE9p/HFx+a6axZ8agwa35wlv1OJJdEk3J7ogz9rFYE6kP8YoUY
X-Gm-Gg: ASbGncvZm/4g4XWM/wiV7bpUdUNGMh6cwDKPP0ChuRgFW+BEnCGuJ8Au9HQt7oApVh0
	PSwXQxJ8m66NXZwNNR73WLScoi/rWeyg/d34VDT0rrLQ8dyHblADlBn1zvF6PpEwLiHsWakGGtq
	TO7WqN+2BCimDw6ryuqozz2GNTn5O73rC+7NVWahqsg10dHM0+L2cBiizwOwheHLxGRRFpL5YPU
	iDBeknry5x1suZ+wu1jftaoXlu/uhh1cUqKhGO94o8wZYNksmmh2j8dFonvOAuaXJjBCE4nzJZx
	WyaBPbGi/xjS1jwGZIjxrXB/QgKv
X-Google-Smtp-Source: AGHT+IHIHo9RSSlJFu6DZuboLZLGVZP/USi97MhEgGDpeR8uuBTSfyde4cbm+4veKsIrh4zh48jzgg==
X-Received: by 2002:a05:620a:4151:b0:7b6:d050:720f with SMTP id af79cd13be357-7be6321c277mr221512885a.22.1737110549817;
        Fri, 17 Jan 2025 02:42:29 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614897d6sm101707685a.62.2025.01.17.02.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:42:29 -0800 (PST)
Date: Fri, 17 Jan 2025 05:42:28 -0500
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
Message-ID: <678a3414c9b49_3ef8eb29431@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250116-tun-v3-6-c6b2871e97f7@daynix.com>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116-tun-v3-6-c6b2871e97f7@daynix.com>
Subject: Re: [PATCH net v3 6/9] tun: Extract the vnet handling code
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
>  drivers/net/Makefile   |   3 +-
>  drivers/net/tun.c      | 174 +-----------------------------------------------
>  drivers/net/tun_vnet.c | 175 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  25 +++++++
>  5 files changed, 205 insertions(+), 174 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 910305c11e8a..bc32b7e23c79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23902,7 +23902,7 @@ W:	http://vtun.sourceforge.net/tun
>  F:	Documentation/networking/tuntap.rst
>  F:	arch/um/os-Linux/drivers/
>  F:	drivers/net/tap.c
> -F:	drivers/net/tun.c
> +F:	drivers/net/tun*
>  
>  TURBOCHANNEL SUBSYSTEM
>  M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 13743d0e83b5..bb8eb3053772 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -29,7 +29,8 @@ obj-y += mdio/
>  obj-y += pcs/
>  obj-$(CONFIG_RIONET) += rionet.o
>  obj-$(CONFIG_NET_TEAM) += team/
> -obj-$(CONFIG_TUN) += tun.o
> +obj-$(CONFIG_TUN) += tun-drv.o
> +tun-drv-y := tun.o tun_vnet.o
>  obj-$(CONFIG_TAP) += tap.o
>  obj-$(CONFIG_VETH) += veth.o
>  obj-$(CONFIG_VIRTIO_NET) += virtio_net.o

Let's figure out how to do this. See also comment in 9/9.

Otherwise the rest of the patch looks fine.
