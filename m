Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A3DC77B73
	for <virtualization@archiver.kernel.org>; Tue,  6 Jun 2023 02:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5B264063C;
	Tue,  6 Jun 2023 02:14:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5B264063C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id etgC_c3YHoCC; Tue,  6 Jun 2023 02:14:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B59E40227;
	Tue,  6 Jun 2023 02:14:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B59E40227
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DAC0C0037;
	Tue,  6 Jun 2023 02:14:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27CDFC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 025A360F9A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:14:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 025A360F9A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h_VEYgo5_oet
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:14:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B5E460E61
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B5E460E61
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Jun 2023 02:14:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VkUHd8d_1686017647; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VkUHd8d_1686017647) by smtp.aliyun-inc.com;
 Tue, 06 Jun 2023 10:14:08 +0800
Message-ID: <1686017511.351475-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 10/10] virtio_net: support dma premapped
Date: Tue, 6 Jun 2023 10:11:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-11-xuanzhuo@linux.alibaba.com>
 <20230602233152.4d9b9ba4@kernel.org>
 <1685931044.5893385-2-xuanzhuo@linux.alibaba.com>
 <20230605014154-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230605014154-mutt-send-email-mst@kernel.org>
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

On Mon, 5 Jun 2023 01:44:28 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Jun 05, 2023 at 10:10:44AM +0800, Xuan Zhuo wrote:
> > On Fri, 2 Jun 2023 23:31:52 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > > On Fri,  2 Jun 2023 17:22:06 +0800 Xuan Zhuo wrote:
> > > >  drivers/net/virtio_net.c | 163 +++++++++++++++++++++++++++++++++------
> > >
> > > ack for this going via the vhost tree, FWIW, but you'll potentially
> > > need to wait for the merge window to move forward with the actual
> > > af xdp patches, in this case.
> >
> >
> > My current plan is to let virtio support premapped dma first, and then implement
> > virtio-net to support af-xdp zerocopy.
> >
> > This will indeed involve two branches. But most of the implementations in this
> > patch are virtio code, so I think it would be more appropriate to commit to
> > vhost. Do you have any good ideas?
> >
> >
> > Thanks.
>
> Are you still making changes to net core? DMA core? If it's only
> virtio-net then I can probably merge all of it - just a couple of
> bugfixes there so far, it shouldn't cause complex conflicts.

Just one small change to net core. no dma core.

I will try to fix this problem.

Thanks.


>
> --
> MST
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
