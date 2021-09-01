Return-Path: <SRS0=XZyc=NX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A94C432BE
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 05:22:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036AB60462
	for <virtualization@archiver.kernel.org>; Wed,  1 Sep 2021 05:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 036AB60462
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC0946068C;
	Wed,  1 Sep 2021 05:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KSKVjSx6elDV; Wed,  1 Sep 2021 05:21:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F6B160607;
	Wed,  1 Sep 2021 05:21:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 530D5C001A;
	Wed,  1 Sep 2021 05:21:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D394C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 05:21:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5CBC560607
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 05:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NOLLu-tAoZ_7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 05:21:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 85FA6605D8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 05:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Sm8cG8stcqpgFKiVBKuUxhVdzU
 l9LuxUIXxe5uaSLQw2HR5QYlPcFDTQNZ9e3rdJX0kxY0H4iSXs+4I7z6Fxmkgj8BtbMnRLZlvW6T3
 1rCg8wrshgo4lVc9tWjurZ5z0M5+2AGVXAzq1fiSCaVlhWXxlV+yB9i1+IZkMcRU6cAYpuLuD1Z0V
 1KjzGTssbQgGjH+jJD5zHQ9kJCb3PzvYprU3JyFZy13Z8rBQjVjguetMDihYW8h6RYoB/gySrljQ3
 co2kdSCrb0i+/tZ8qT3gzcsHvhYRDdxJfGEcZkkzfnP8xvHJdcIH3Hdlr/n94ZfYQBsWC/4aHVXSF
 jikXeuBA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mLIgG-001tZC-44; Wed, 01 Sep 2021 05:21:10 +0000
Date: Wed, 1 Sep 2021 06:21:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v2 1/1] virtio-blk: add num_io_queues module parameter
Message-ID: <YS8NvPbGODs5ZVmB@infradead.org>
References: <20210831135035.6443-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210831135035.6443-1-mgurtovoy@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, kvm@vger.kernel.org,
 mst@redhat.com, israelr@nvidia.com, virtualization@lists.linux-foundation.org,
 hch@infradead.org, nitzanc@nvidia.com, stefanha@redhat.com, oren@nvidia.com
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
