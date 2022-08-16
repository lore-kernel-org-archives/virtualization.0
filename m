Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D6EC00140
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 03:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B83064057A;
	Tue, 16 Aug 2022 03:09:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B83064057A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OgiJk48SsWp1; Tue, 16 Aug 2022 03:09:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 42671400E7;
	Tue, 16 Aug 2022 03:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42671400E7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D85DCC0032;
	Tue, 16 Aug 2022 03:09:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77D42C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4747240151
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4747240151
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9fpRMIJatxgG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:09:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E3BB7400E7
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E3BB7400E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:09:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R361e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VMOG.Le_1660619347; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VMOG.Le_1660619347) by smtp.aliyun-inc.com;
 Tue, 16 Aug 2022 11:09:08 +0800
Message-ID: <1660619231.7656944-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 0/5] virtio: drop sizing vqs during init
Date: Tue, 16 Aug 2022 11:07:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220815215938.154999-1-mst@redhat.com>
In-Reply-To: <20220815215938.154999-1-mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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


Series:
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

There is also a commit, I just submitted, about the problem you pointed
out about using container_of(). Can we submit together?


On Mon, 15 Aug 2022 18:00:21 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> Reporting after I botched up v2 posting. Sorry about the noise.
>
> Supplying size during init does not work for all transports.
> In fact for legacy pci doing that causes a memory
> corruption which was reported on Google Cloud.
>
> We might get away with changing size to size_hint so it's
> safe to ignore and then fixing legacy to ignore the hint.
>
> But the benefit is unclear in any case, so let's revert for now.
> Any new version will have to come with
> - documentation of performance gains
> - performance testing showing existing workflows
>   are not harmed materially. especially ones with
>   bursty traffic
> - report of testing on legacy devices
>
>
> Huge shout out to Andres Freund for the effort spent reproducing and
> debugging!  Thanks to Guenter Roeck for help with testing!
>
>
> changes from v2
> 	drop unrelated patches
> changes from v1
> 	revert the ring size api, it's unused now
>
> Michael S. Tsirkin (5):
>   virtio_net: Revert "virtio_net: set the default max ring size by
>     find_vqs()"
>   virtio: Revert "virtio: add helper virtio_find_vqs_ctx_size()"
>   virtio-mmio: Revert "virtio_mmio: support the arg sizes of find_vqs()"
>   virtio_pci: Revert "virtio_pci: support the arg sizes of find_vqs()"
>   virtio: Revert "virtio: find_vqs() add arg sizes"
>
>  arch/um/drivers/virtio_uml.c             |  2 +-
>  drivers/net/virtio_net.c                 | 42 +++---------------------
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  1 -
>  drivers/remoteproc/remoteproc_virtio.c   |  1 -
>  drivers/s390/virtio/virtio_ccw.c         |  1 -
>  drivers/virtio/virtio_mmio.c             |  9 ++---
>  drivers/virtio/virtio_pci_common.c       | 20 +++++------
>  drivers/virtio/virtio_pci_common.h       |  3 +-
>  drivers/virtio/virtio_pci_legacy.c       |  6 +---
>  drivers/virtio/virtio_pci_modern.c       | 17 +++-------
>  drivers/virtio/virtio_vdpa.c             |  1 -
>  include/linux/virtio_config.h            | 26 +++------------
>  12 files changed, 28 insertions(+), 101 deletions(-)
>
> --
> MST
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
