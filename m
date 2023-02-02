Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA80DC61DA4
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 14:41:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3D41A408BA;
	Thu,  2 Feb 2023 14:41:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D41A408BA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FHg8cGRt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ij5pYRpCk47e; Thu,  2 Feb 2023 14:41:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9D85540120;
	Thu,  2 Feb 2023 14:41:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9D85540120
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75C2CC0032;
	Thu,  2 Feb 2023 14:41:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3503C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 14:41:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C09341BBE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 14:41:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C09341BBE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=FHg8cGRt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1TWCA9-hdKaF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 14:41:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1DE8141BB7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1DE8141BB7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 14:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675348912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7iy2bjBhE+5ASRMcjrIPiwnyT3pjhYq6egaUAaOhx4=;
 b=FHg8cGRtv6+t8RE7MVFlehIT4chp1pfTqQG2oUUcDAGEdFLbpQJAA0mj0vfunpWXlyOgN+
 zP7d4sDxbuYJyaEST11OxPVfOMAxt3Sw41UgD/nJYtwWM12etbKqLKTJFKgwGnyCfTeq9j
 Fo38iLZG4ILur0mN9AuyzmAuCJKXYq8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-41Rz2doTNmWrieZrFqKOxA-1; Thu, 02 Feb 2023 09:41:51 -0500
X-MC-Unique: 41Rz2doTNmWrieZrFqKOxA-1
Received: by mail-qk1-f200.google.com with SMTP id
 s7-20020a05620a0bc700b006e08208eb31so1432542qki.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 06:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z7iy2bjBhE+5ASRMcjrIPiwnyT3pjhYq6egaUAaOhx4=;
 b=pwvsujpRFFa0q4hKyPzUpyFgeu3l6IOoUSZT6ERG/9xf2jmhEsXmQQ7rOexiUEBYg6
 v0s4zk3yhnPmY+i9kKuzwEU39tmTR2xochXaIavEGG0J70APSt4OLk4+PHLuNZV3m4k9
 30ecaWD3PotAmmarm8ZaIzDh8XxQiiS8dBu6tSi58hB+2xRW0s3a8Pap2R91BIdrqWkP
 +u3B10uR90Bws5L9JY6WODrrvnitsBVMMuYHILySdCN2WVgLqtTm0ze9gKQHVKiMqhg5
 Vy4UjoPtV4L7w/tIjuOLEGQ7RFBlz4zSmENayUMRGA5s6JCN6NZkFVX6L+7utfKI9FAx
 BufA==
X-Gm-Message-State: AO0yUKWOC9paaSoVwQi4XrmvKy5mEhy9D1gD+ssUd6Lfk7YnbzGJ4Ddv
 a6vOpXB/R2/XRuO67CupUM8dIxKXAQTseObvR8qIFDLq65qYDnkJG/nw8XJQ3R6yUOT98AULhrP
 OpNp7wtmkGGOGSdGcvutYBjkMRLhdnDFh0WSVDELhGA==
X-Received: by 2002:a0c:f44f:0:b0:55b:949e:7721 with SMTP id
 h15-20020a0cf44f000000b0055b949e7721mr7804127qvm.2.1675348910980; 
 Thu, 02 Feb 2023 06:41:50 -0800 (PST)
X-Google-Smtp-Source: AK7set/LyDtDIGcLg99KcjgpY32JW6FBNIIMvyS9KSAsaRgmZ96/nawLigGoKHnlzKr41nnMPX5Dpw==
X-Received: by 2002:a0c:f44f:0:b0:55b:949e:7721 with SMTP id
 h15-20020a0cf44f000000b0055b949e7721mr7804080qvm.2.1675348910676; 
 Thu, 02 Feb 2023 06:41:50 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-113-28.dyn.eolo.it.
 [146.241.113.28]) by smtp.gmail.com with ESMTPSA id
 q187-20020a378ec4000000b006f7ee901674sm10546872qkd.2.2023.02.02.06.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 06:41:50 -0800 (PST)
Message-ID: <5fda6140fa51b4d2944f77b9e24446e4625641e2.camel@redhat.com>
Subject: Re: [PATCH 00/33] virtio-net: support AF_XDP zero copy
From: Paolo Abeni <pabeni@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Date: Thu, 02 Feb 2023 15:41:44 +0100
In-Reply-To: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S.
 Tsirkin" <mst@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, 2023-02-02 at 19:00 +0800, Xuan Zhuo wrote:
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already support
> this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> feature.
> 
> Virtio-net did not support per-queue reset, so it was impossible to support XDP
> Socket Zerocopy. At present, we have completed the work of Virtio Spec and
> Kernel in Per-Queue Reset. It is time for Virtio-Net to complete the support for
> the XDP Socket Zerocopy.
> 
> Virtio-net can not increase the queue at will, so xsk shares the queue with
> kernel.
> 
> On the other hand, Virtio-Net does not support generate interrupt manually, so
> when we wakeup tx xmit, we used some tips. If the CPU run by TX NAPI last time
> is other CPUs, use IPI to wake up NAPI on the remote CPU. If it is also the
> local CPU, then we wake up sofrirqd.

Thank you for the large effort.

Since this will likely need a few iterations, on next revision please
do split the work in multiple chunks to help the reviewer efforts -
from Documentation/process/maintainer-netdev.rst:

 - don't post large series (> 15 patches), break them up

In this case I guess you can split it in 1 (or even 2) pre-req series
and another one for the actual xsk zero copy support.

Thanks!

Paolo

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
