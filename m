Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF895C433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Oct 2022 20:06:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 488E960A99;
	Fri,  7 Oct 2022 20:06:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 488E960A99
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=y3TnHRe5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XrM71kJC2P9U; Fri,  7 Oct 2022 20:06:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6B7F460803;
	Fri,  7 Oct 2022 20:06:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B7F460803
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49EE1C0033;
	Fri,  7 Oct 2022 20:06:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE5B0C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 20:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7638860A69
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 20:06:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7638860A69
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q3x0EN6V80sR
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 20:06:13 +0000 (UTC)
X-Greylist: delayed 01:38:48 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 655A360803
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 655A360803
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Oct 2022 20:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IudIrA3q3WpPWuZzZUKujefONUnAfceTWjlveYaPvio=; b=y3TnHRe5LU2pfTWpYrKhFoSYbh
 jboFN1RMi5CjIniehZGNTOJpkF2sr617jJ4vb6Ib6lSQpyC0ek2+SlWngTW1ubM41ZOvqG9t87RGe
 LZXDSjCQvYJpbTl+VRQpi8LkTLFVyXqr+kFALUeMkSNjyvXp3VTfiu6Hin9S6c12kBhwJdLbNbYn4
 4szHif4ftpjkLWks7RWt2NtkOf4pQQWV+FmMEugetSNijqYdLE8QwTu09Ycl6RznABM1+qPym5ADr
 Od764RzqJQFgxId6v9nZqSWYrZBx/EX1oe/ZXXPNJJb8O2jtIyGdk61SSE07/zRW76XLArhkeRZ+1
 ZC4+w/vg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1ogs33-00A41Z-Ot; Fri, 07 Oct 2022 18:26:13 +0000
Date: Fri, 7 Oct 2022 11:26:13 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC PATCH 00/21] block: add and use init tagset helper
Message-ID: <Y0BvRaVO0iUVmHgB@bombadil.infradead.org>
References: <20221005032257.80681-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221005032257.80681-1-kch@nvidia.com>
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

On Tue, Oct 04, 2022 at 08:22:36PM -0700, Chaitanya Kulkarni wrote:
> Hi,
> 
> Add and use the helper to initialize the common fields of the tag_set
> such as blk_mq_ops, number of h/w queues, queue depth, command size,
> numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
> is spread all over the block drivers. This avoids repetation of
> inialization code of the tag set in current block drivers and any future
> ones.
> 
> P.S. I'm aware of the EXPORT_SYMBOL_GPL() checkpatch warn just to make
> get some feedback to so I can remove the RFC tag.
> 

*If* there were commonalities at init and these could be broken up into
common groups, each having their own set of calls, then we simplify and
can abstract these. I say this without doing a complete review of the
removals, but if there really isn't much of commonalities I tend to
agree with Bart that open coding this is better.

  Luis
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
