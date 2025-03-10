Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B151B414A
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741579434; cv=none; b=a2UM9fXwR7xuCoFfX8dAtWxLilVT00VlAexaPfv7Yob28UXSlekOrSM/Y+wdJPAp+IEjbC/7S1KHmcGc2s/BOFgQHn2Rjeu4ZCPyJU5WKyz+uaTIY6W0Y8FZ/LEmo7e+tyFKRTJJdJrbev8bW6J9msFYd2wVtNpbuLooVQY3EkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741579434; c=relaxed/simple;
	bh=aHOy1ecN9jlAaMS2M7dcU9gCxoht3SCiGLgSPyDZ63k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OceDH23kavwl5YmgZxISCxmjf018/l0IILoIg3E4B0pOMX0gzZYS4t8ep8cUDgcpCjX/GQP97TlNERO2avunGLA3IN8sByITUj67A7wFf5ansv1FGP3VoKd1YUESnsaikY/ehkRtdvq2o1ucogkyZ//jA/mWjGNUHVNWutYnh+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DfTTKFVa; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfTTKFVa"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 971DD8145F
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 04:03:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 779bo7jLVrq6 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Mar 2025 04:03:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B40C580369
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B40C580369
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DfTTKFVa
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B40C580369
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741579430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KgUpYDCvfAICXWh2Ym5jayuE/HfSSdl1/NY4QdmfsrM=;
	b=DfTTKFVaMfNTYVEolhXdbmgRd0nuBNKM2JGmJ1imuxeflvIeF1VeEjL2heSYuZWo5Ym4k+
	ifOknskryfB6hA34Q4fo2tsy2yWfIOb34GcG72bwUwaCzg1dnhs1NV56C87OtA2dKX96DT
	KoAGp1ddatvrElDmTrM+M7sz3+TNIig=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-GtAbq0tnNwyyfIFvS8pgDA-1; Mon, 10 Mar 2025 00:03:48 -0400
X-MC-Unique: GtAbq0tnNwyyfIFvS8pgDA-1
X-Mimecast-MFC-AGG-ID: GtAbq0tnNwyyfIFvS8pgDA_1741579428
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-86d1944bd47so4873973241.2
        for <virtualization@lists.linux-foundation.org>; Sun, 09 Mar 2025 21:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741579428; x=1742184228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KgUpYDCvfAICXWh2Ym5jayuE/HfSSdl1/NY4QdmfsrM=;
        b=kfyvlcWR+/75SJ9fT3tlTJ17HKgx/w2VLmWfD6iw5nS8BrxFziFXWhaIU7ciwh6d8t
         8nRWG42a0EJTHLObvUzoqg33c5L0EsSPxeBLaAO23As1oL49egFJcsvfQs+IAHtharrD
         QqSIsI1JNHPs8Vqt0aKtPfw4s6OCtcqNTwvrpF9K7qOKf88gOucw0bJtfh4pHe/kP7/T
         Y/dO3q0hAvF3IT3qgxUmQHIGCtHHqPfZNzs2tNUI5E8sYSp5ea1WiD+kxokPIW6on3vR
         T8QoUSwMxnJVy/0Q7cEuVsiItcYA/i5LS4ywNFQ+mKn+oftbEMwDNvtD2iujCNHFPRsv
         efZA==
X-Forwarded-Encrypted: i=1; AJvYcCVxR+LsbSJRz7OD5Iz7b2Ep301CDDAhe+rgDHHkhpm+GQPzG1zO7ePKG46K3a1dxjnPBSLD8BENGyPHJSwFOw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwK66OWwL6ZNEdyz01tYhPltCkXe4EbNkHaJMC43HmG37fZFKDb
	8nYKd0y5G5YtQVBLWAUsNx1itrHCQx1bs7MtS01S55yLom8S3fh6jOqkLL8kNZviobr7TTJxoSf
	w4EK27+n+G2OeTJA/bnjKebAC+Je6snkpF/JHPeSyld+7XLiXh7Upt72dJyE5LpczRqR55HxBc4
	5Nna3KRP123bykaCmpNluIBi41kVH0AdETrQCnhWhWKH39D0Ebl2XY2Q==
X-Gm-Gg: ASbGncv56gLmDKop3QjJaPnb/k3rnML7K7XELpxfmQyni7NlEoZmCsOl9hqg3jJelbt
	8rjTK1LDUGWFDgT6GYNffJONPpEhHW8/WlIroD75zc6ATMreEHTe3utl7TLlkBMZE0Kh5wJKRKA
	==
X-Received: by 2002:a05:6102:1625:b0:4bb:c24b:b658 with SMTP id ada2fe7eead31-4c30a6ce291mr6889417137.18.1741579428332;
        Sun, 09 Mar 2025 21:03:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWEExs57zlYjvHiKjt0sJdXJFbwo2Zs0LPOPlolmp1grxhBOdO/jBTdI674OxaLt6FioYXJto0Ve0T2qHTIms=
X-Received: by 2002:a05:6102:1625:b0:4bb:c24b:b658 with SMTP id
 ada2fe7eead31-4c30a6ce291mr6889393137.18.1741579427853; Sun, 09 Mar 2025
 21:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250307-rss-v9-0-df76624025eb@daynix.com> <20250307-rss-v9-5-df76624025eb@daynix.com>
In-Reply-To: <20250307-rss-v9-5-df76624025eb@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Mar 2025 12:03:35 +0800
X-Gm-Features: AQ5f1JpUIYkO2z7JqKfhDMFz04EDw9VRlQFOeI99RHje5MrLTIGs-yAN3N8PypE
Message-ID: <CACGkMEuTwd4+DP1Cb+ZgJtxTiJj4N_NMPHiKusd8a4Tn3+B_3A@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/6] selftest: tun: Add tests for virtio-net hashing
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Rlhfekc6kwuJfbo6F9uJby0qyRigW1SJ4M9uN3eqhGU_1741579428
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:02=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> The added tests confirm tun can perform RSS and hash reporting, and
> reject invalid configurations for them.

Let's be more verbose here. E.g what's the network topology used here.

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---
>  tools/testing/selftests/net/Makefile |   2 +-
>  tools/testing/selftests/net/tun.c    | 584 +++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 576 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index 73ee88d6b043004be23b444de667a1d99a6045de..9772f691a9a011d99212df324=
63cdb930cf0a1a0 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -123,6 +123,6 @@ $(OUTPUT)/reuseport_bpf_numa: LDLIBS +=3D -lnuma
>  $(OUTPUT)/tcp_mmap: LDLIBS +=3D -lpthread -lcrypto
>  $(OUTPUT)/tcp_inq: LDLIBS +=3D -lpthread
>  $(OUTPUT)/bind_bhash: LDLIBS +=3D -lpthread
> -$(OUTPUT)/io_uring_zerocopy_tx: CFLAGS +=3D -I../../../include/
> +$(OUTPUT)/io_uring_zerocopy_tx $(OUTPUT)/tun: CFLAGS +=3D -I../../../inc=
lude/
>
>  include bpf.mk
> diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/=
net/tun.c
> index 463dd98f2b80b1bdcb398cee43c834e7dc5cf784..acadeea7194eaea9416a605b4=
7f99f7a5f1f80cd 100644
> --- a/tools/testing/selftests/net/tun.c
> +++ b/tools/testing/selftests/net/tun.c
> @@ -2,21 +2,38 @@
>
>  #define _GNU_SOURCE
>
> +#include <endian.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <sched.h>

Is this needed?

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
>
>  #include "../kselftest_harness.h"
>
> +#define TUN_HWADDR_SOURCE { 0x02, 0x00, 0x00, 0x00, 0x00, 0x00 }
> +#define TUN_HWADDR_DEST { 0x02, 0x00, 0x00, 0x00, 0x00, 0x01 }
> +#define TUN_IPADDR_SOURCE htonl((172 << 24) | (17 << 16) | 0)
> +#define TUN_IPADDR_DEST htonl((172 << 24) | (17 << 16) | 1)
> +
>  static int tun_attach(int fd, char *dev)
>  {
>         struct ifreq ifr;
> @@ -39,7 +56,7 @@ static int tun_detach(int fd, char *dev)
>         return ioctl(fd, TUNSETQUEUE, (void *) &ifr);
>  }
>
> -static int tun_alloc(char *dev)
> +static int tun_alloc(char *dev, short flags)
>  {
>         struct ifreq ifr;
>         int fd, err;
> @@ -52,7 +69,8 @@ static int tun_alloc(char *dev)
>
>         memset(&ifr, 0, sizeof(ifr));
>         strcpy(ifr.ifr_name, dev);
> -       ifr.ifr_flags =3D IFF_TAP | IFF_NAPI | IFF_MULTI_QUEUE;
> +       ifr.ifr_flags =3D flags | IFF_TAP | IFF_NAPI | IFF_NO_PI |
> +                       IFF_MULTI_QUEUE;
>
>         err =3D ioctl(fd, TUNSETIFF, (void *) &ifr);
>         if (err < 0) {
> @@ -64,6 +82,40 @@ static int tun_alloc(char *dev)
>         return fd;
>  }
>
> +static bool tun_add_to_bridge(int local_fd, const char *name)
> +{

I wonder if a packet socket is more convenient here.

Thanks

