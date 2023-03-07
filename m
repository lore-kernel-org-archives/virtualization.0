Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1315BC61DA4
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 01:50:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 844A5415E2;
	Tue,  7 Mar 2023 01:50:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 844A5415E2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PGiMLi61bFhP; Tue,  7 Mar 2023 01:50:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DD4634155B;
	Tue,  7 Mar 2023 01:50:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DD4634155B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B85F1C0035;
	Tue,  7 Mar 2023 01:50:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 769EFC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 01:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E6F841570
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 01:50:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E6F841570
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bGU1J_r1INBN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 01:50:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B88DC4155B
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B88DC4155B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 01:50:38 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VdJ4RDN_1678153832; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdJ4RDN_1678153832) by smtp.aliyun-inc.com;
 Tue, 07 Mar 2023 09:50:32 +0800
Message-ID: <1678153770.8281553-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 0/2] add checking sq is full inside xdp xmit
Date: Tue, 7 Mar 2023 09:49:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230306041535.73319-1-xuanzhuo@linux.alibaba.com>
 <20230306125742-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230306125742-mutt-send-email-mst@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

On Mon, 6 Mar 2023 12:58:22 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Mar 06, 2023 at 12:15:33PM +0800, Xuan Zhuo wrote:
> > If the queue of xdp xmit is not an independent queue, then when the xdp
> > xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> > the following error.
> >
> > net ens4: Unexpected TXQ (0) queue failure: -28
> >
> > This patch adds a check whether sq is full in XDP Xmit.
> >
> > Thanks.
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> needed for stable?


Yes i think.

Thanks.


>
> > Xuan Zhuo (2):
> >   virtio_net: separate the logic of checking whether sq is full
> >   virtio_net: add checking sq is full inside xdp xmit
> >
> >  drivers/net/virtio_net.c | 78 ++++++++++++++++++++++++----------------
> >  1 file changed, 47 insertions(+), 31 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
