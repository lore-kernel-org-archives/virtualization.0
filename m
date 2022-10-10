Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496FBC4321E
	for <virtualization@archiver.kernel.org>; Mon, 10 Oct 2022 07:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C95AC82AED;
	Mon, 10 Oct 2022 07:55:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C95AC82AED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EBXmGDaqjz6s; Mon, 10 Oct 2022 07:55:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3DB31828F8;
	Mon, 10 Oct 2022 07:55:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3DB31828F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FF5FC0033;
	Mon, 10 Oct 2022 07:55:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B497FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 07:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8799060BA6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 07:55:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8799060BA6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o0TR3qVMr14K
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 07:55:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 849CB60AEB
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 849CB60AEB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Oct 2022 07:55:13 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 21BA768AA6; Mon, 10 Oct 2022 09:55:05 +0200 (CEST)
Date: Mon, 10 Oct 2022 09:55:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC PATCH 00/21] block: add and use init tagset helper
Message-ID: <20221010075504.GA21272@lst.de>
References: <20221005032257.80681-1-kch@nvidia.com>
 <Y0BvRaVO0iUVmHgB@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y0BvRaVO0iUVmHgB@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: vincent.fu@samsung.com, vincent.whitchurch@axis.com,
 baolin.wang@linux.alibaba.com, mst@redhat.com,
 linux-remoteproc@vger.kernel.org, hoeppner@linux.ibm.com,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 bhelgaas@google.com, linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
 agordeev@linux.ibm.com, jinpu.wang@ionos.com, hch@lst.de, alyssa@rosenzweig.io,
 vigneshr@ti.com, linux-s390@vger.kernel.org, sagi@grimberg.me,
 linux-scsi@vger.kernel.org, richard@nod.at, damien.lemoal@opensource.wdc.com,
 vaibhavgupta40@gmail.com, joel@jms.id.au, shinichiro.kawasaki@wdc.com,
 idryomov@gmail.com, jejb@linux.ibm.com, asahi@lists.linux.dev, ohad@wizery.com,
 haris.iqbal@ionos.com, gor@linux.ibm.com, sven@svenpeter.dev,
 hca@linux.ibm.com, john.garry@huawei.com, josef@toxicpanda.com,
 efremov@linux.com, ming.lei@redhat.com, linux-block@vger.kernel.org,
 nbd@other.debian.org, christophe.jaillet@wanadoo.fr, sth@linux.ibm.com,
 stefanha@redhat.com, kbusch@kernel.org, ceph-devel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 bvanassche@acm.org, axboe@kernel.dk, martin.petersen@oracle.com,
 wsa+renesas@sang-engineering.com, johannes.thumshirn@wdc.com,
 andersson@kernel.org, marcan@marcan.st, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, dongsheng.yang@easystack.cn,
 christoph.boehmwalder@linbit.com, svens@linux.ibm.com, pbonzini@redhat.com
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

On Fri, Oct 07, 2022 at 11:26:13AM -0700, Luis Chamberlain wrote:
> *If* there were commonalities at init and these could be broken up into
> common groups, each having their own set of calls, then we simplify and
> can abstract these. I say this without doing a complete review of the
> removals, but if there really isn't much of commonalities I tend to
> agree with Bart that open coding this is better.

The commonality is that there are various required or optional
fields to fill out.  I actually have a WIP series to make the tag_set
dynamically allocated and refcounted to fix some long standing life time
issues.  That creates a new alloc helper that will take a few mandatory
arguments and would heavily clash with this series.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
