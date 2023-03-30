Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF728C74A5B
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 06:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 532E441DD6;
	Thu, 30 Mar 2023 06:05:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 532E441DD6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zBCe42U21JLG; Thu, 30 Mar 2023 06:04:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D090A4010D;
	Thu, 30 Mar 2023 06:04:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D090A4010D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B7D5C0037;
	Thu, 30 Mar 2023 06:04:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3A25C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:04:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6715404A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:04:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B6715404A1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4sCHLJ95xwEa
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:04:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F2034010D
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F2034010D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 06:04:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VezShXN_1680156287; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VezShXN_1680156287) by smtp.aliyun-inc.com;
 Thu, 30 Mar 2023 14:04:47 +0800
Message-ID: <1680156097.4586647-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 02/16] virtio_net: move struct to header file
Date: Thu, 30 Mar 2023 14:01:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
 <20230328092847.91643-3-xuanzhuo@linux.alibaba.com>
 <20230329211826.0657f947@kernel.org>
In-Reply-To: <20230329211826.0657f947@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S.  Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 29 Mar 2023 21:18:26 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 28 Mar 2023 17:28:33 +0800 Xuan Zhuo wrote:
> > diff --git a/drivers/net/virtio/virtnet.h b/drivers/net/virtio/virtnet.h
> > new file mode 100644
> > index 000000000000..778a0e6af869
> > --- /dev/null
> > +++ b/drivers/net/virtio/virtnet.h
> > @@ -0,0 +1,184 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __VIRTNET_H__
> > +#define __VIRTNET_H__
> > +
> > +#include <linux/ethtool.h>
> > +#include <linux/average.h>
>
> I don't want to nit pick too much but this header is missing a lot of
> includes / forward declarations. At the same time on a quick look I
> didn't spot anything that'd require linux/ethtool.h

Indeed, I only considered the compilation may pass before, and I didn't think
about it from the perspective of an independent header file.

Will fix.

>
> > diff --git a/drivers/net/virtio/virtnet.c b/drivers/net/virtio/virtnet.c
> > index e2560b6f7980..5ca354e29483 100644
> > --- a/drivers/net/virtio/virtnet.c
> > +++ b/drivers/net/virtio/virtnet.c
> > @@ -6,7 +6,6 @@
> >  //#define DEBUG
> >  #include <linux/netdevice.h>
> >  #include <linux/etherdevice.h>
> > -#include <linux/ethtool.h>
> >  #include <linux/module.h>
> >  #include <linux/virtio.h>
> >  #include <linux/virtio_net.h>
> > @@ -16,13 +15,14 @@
> >  #include <linux/if_vlan.h>
> >  #include <linux/slab.h>
> >  #include <linux/cpu.h>
> > -#include <linux/average.h>
> >  #include <linux/filter.h>
> >  #include <linux/kernel.h>
> >  #include <net/route.h>
> >  #include <net/xdp.h>
> >  #include <net/net_failover.h>
>
> And you shouldn't remove includes if the code needs them just because
> they get pulled in indirectly.


Will fix.

Thanks.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
