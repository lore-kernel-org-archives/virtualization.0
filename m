Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A021C160
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433384; cv=none; b=AgTTvequKYN5jULF42+07A9G8o7BAupV6KR7PSGUFj9BpFWosv4YsF0k7bJzIaxI+LFIrZkFpz+5jDSw8Iq5hh4ExU3euXgpHenlZeNxfjn6NfPi22gypHXxcMJhBDm8W31+a35rYmUAJR9R7BHTSDauJboT65QPim0FJs/RkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433384; c=relaxed/simple;
	bh=msjFFpRNIoIz+b905oDvoFmaWYdAZMtswIZ6602H/P0=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BSYT4Br6AOBl38hRB0VRq0vQ0BZH2JE9q/exjOI8JEdZ8V0mvLltLRGajj4tPOEQDrcR60W+JE4KUGLjATpTATyT9vi+j6ncpc/tsO/HgaNI/k+6lJSjgBJ59AAW8RF7R1kdb4SlR4jwAh4/5g1lALNvl3VeUd7ZmKBMF2HDfiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8UkLV/S; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8UkLV/S"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C4F4F405CA
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VRtu6tdjD06r for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Jan 2025 14:36:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72d; helo=mail-qk1-x72d.google.com; envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 73E7140119
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73E7140119
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=b8UkLV/S
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 73E7140119
	for <virtualization@lists.linux-foundation.org>; Thu,  9 Jan 2025 14:36:20 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-7b6ff72ba5aso85697985a.1
        for <virtualization@lists.linux-foundation.org>; Thu, 09 Jan 2025 06:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736433379; x=1737038179; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNunDNoIF2mrY2oVc9mlVfBWrl6u/4dyH5yl1p2uXyM=;
        b=b8UkLV/SfQFWLgRYwT1V2AVJ0k02vnHw6rab7b9tjJj8rxerYCAR2NTs39UdSSaj2S
         /uJ4C61Jn+XmuvAg05Oj+T59Q63WqdWR6Zq1APsE4q7D0vAtWrcfUGTvTJxIuLa+QMDr
         8KM2aHvVLPZM1nJpXVleysKt2wU8rCyJKAdO+eU6QhZbOYkdFQTSo3AOL/5Teqf/nYfB
         AbFUcytvPopODI7JLb+BxBPs1flHc+eJN8Vqg2iDGaah+/AxtYPRf/RCX54Eo8ahrq79
         dOs/YmoaY2hsNChx8gXxmY2rtArPlISifsfdP2tS0QKLYlRQv9Nkidv9GCkMUQE3VyoR
         QVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736433379; x=1737038179;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNunDNoIF2mrY2oVc9mlVfBWrl6u/4dyH5yl1p2uXyM=;
        b=HJYfc/AwMgTurPUSv2KlOAknR4Gr1vB9Pk718+b5bLbsOZS83MX1KuUGw2DnypNHiL
         kMOErkdwda9EHS2WYFYGXDKMo36YOHmcnxfP73sLgYYDsdA82DZXVeGDUc7i/urcl9J2
         wZwFwpLvZeTWW9T51MiFxXPHIJ7hoVGsfWgkF777tZATlWFEvjcgVv9JLvzvXzCsBfOH
         cE9vR2v+5BB/M1toPVwtmVyaTQ9QGE+8nx7EEZ80Man6crdePWgUUx6CkkBL0vmIzzd3
         UkqCBExNFmsECbpsZNKHeHbJGefelEdeMFkANOUji7a2dV+snR1NuyV0njNQlL3wHnRm
         qBSg==
X-Forwarded-Encrypted: i=1; AJvYcCXq7ExKoEhKN+wANvX/AO1JEDYKqWzHJXuS/dlmJ+Tl9HIuNu6wMP7LgUTpPLnzfRxNOtKtwIffJlRcJUSsHg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwV6J24fEKUaJ3YYKPQBaUFdKjDlqFAEbIvLSug5uT9hGKZkEjP
	K8IUsHHeYlTZL2gb2p4yt90tzKZ4da57iqN7SgzyezJ5KgvgD10N
X-Gm-Gg: ASbGncvuiekZDbcXdCFv8fKKKoEBWHevCTv+re7z+3QShp3uM6fgQiEOofJ0ditmCiC
	Hnf9Jr0Qd4uTINBYEcBNSfAoM0WPkCgtCAxkHtSIf/M1jcCGGpxqryockA5XrP4bcGw3Rt9yZ0l
	+6ZL/jxxWhpc5rRN8Yr4vYlZZP2bXFWtoGT6skE1MekF8ROCL6Ep/I929VUZuyGt6RgqC1990LX
	pzJ4qgPOJB6u4f8hRDblLxWPdXxZ0glLcWykbF0BlBx9wcW59EW2OV2NqkgR7ara5BmhrQQuXMR
	TslnRcXlh+tknHtmBMhlhv2a3AuC
X-Google-Smtp-Source: AGHT+IFryBKl+CgzeHnlshqOHgd4HEgss/hRNR6TRDEv+l/RB0gB9QwsktP04rpoXg5ryVYIaPfcmg==
X-Received: by 2002:a05:620a:4142:b0:7b7:106a:19b7 with SMTP id af79cd13be357-7bcd970d4b8mr1005540485a.18.1736433378983;
        Thu, 09 Jan 2025 06:36:18 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3516068sm71749885a.100.2025.01.09.06.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:36:18 -0800 (PST)
Date: Thu, 09 Jan 2025 09:36:18 -0500
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
Message-ID: <677fdee2b56d_362bc129446@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250109-rss-v6-5-b1c90ad708f6@daynix.com>
References: <20250109-rss-v6-0-b1c90ad708f6@daynix.com>
 <20250109-rss-v6-5-b1c90ad708f6@daynix.com>
Subject: Re: [PATCH v6 5/6] selftest: tun: Add tests for virtio-net hashing
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
> The added tests confirm tun can perform RSS and hash reporting, and
> reject invalid configurations for them.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  tools/testing/selftests/net/Makefile |   2 +-
>  tools/testing/selftests/net/tun.c    | 558 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 551 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index cb2fc601de66..92762ce3ebd4 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -121,6 +121,6 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
>  $(OUTPUT)/tcp_mmap: LDLIBS += -lpthread -lcrypto
>  $(OUTPUT)/tcp_inq: LDLIBS += -lpthread
>  $(OUTPUT)/bind_bhash: LDLIBS += -lpthread
> -$(OUTPUT)/io_uring_zerocopy_tx: CFLAGS += -I../../../include/
> +$(OUTPUT)/io_uring_zerocopy_tx $(OUTPUT)/tun: CFLAGS += -I../../../include/
>  
>  include bpf.mk
> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
> index 463dd98f2b80..9424d897e341 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -2,21 +2,37 @@
>  
>  #define _GNU_SOURCE
>  
> +#include <endian.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <stddef.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <unistd.h>
> -#include <linux/if.h>
> +#include <net/if.h>
> +#include <netinet/ip.h>
> +#include <sys/ioctl.h>
> +#include <sys/socket.h>
> +#include <linux/compiler.h>
> +#include <linux/icmp.h>
> +#include <linux/if_arp.h>
>  #include <linux/if_tun.h>
> +#include <linux/ipv6.h>
>  #include <linux/netlink.h>
>  #include <linux/rtnetlink.h>
> -#include <sys/ioctl.h>
> -#include <sys/socket.h>
> +#include <linux/sockios.h>
> +#include <linux/tcp.h>
> +#include <linux/udp.h>
> +#include <linux/virtio_net.h>

Are all these include changes strictly needed? Iff so, might as well
fix ordering to be alphabetical (lexicographic).
  
