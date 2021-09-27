Return-Path: <SRS0=Jws+=OR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 12:01:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279FF60FD7
	for <virtualization@archiver.kernel.org>; Mon, 27 Sep 2021 12:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 279FF60FD7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBA88817BA;
	Mon, 27 Sep 2021 12:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lxAtLqVOmo7B; Mon, 27 Sep 2021 12:01:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5BFD2817EB;
	Mon, 27 Sep 2021 12:01:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25C55C0011;
	Mon, 27 Sep 2021 12:01:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A126C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 12:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BADF4061D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 12:01:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tJfUDtiBP6V9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 12:01:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D98F840568
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Sep 2021 12:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=ZGz56D9PDMH0Z9KBoJRxNY2ws2
 uVWo1Tb+nHx18sJhRIukJIc3iQcK9Wq7R/S3CySv3a02INLlb1huajuVkEF24S64o6ZY278l4ONa2
 HQrv0yZMzld8QDfhONwlXZgTm5TTqQ7Fik+veQ0TlPxViY0XWEmgtr2iXv0o/Co54MwG41vxpgUZN
 A+2vYVjVnm+GZ9qtMcDthxkSJ1QJSqyimFyAk+MP8fAexcfwmxpvOU1zoUZ8l37UHiD0Dj/28XlkT
 /p/s/usXaUf8qKamgnSKObW0qorVTPGgiQDpObevLviNeBs+6tZEuxpC8IuVh8AbwztReRuXb4wMt
 E5c10lNQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mUpIF-009idw-Rh; Mon, 27 Sep 2021 11:59:48 +0000
Date: Mon, 27 Sep 2021 12:59:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v3 1/1] virtio-blk: avoid preallocating big SGL for data
Message-ID: <YVGyJ7jkixtgPVSY@infradead.org>
References: <20210901131434.31158-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210901131434.31158-1-mgurtovoy@nvidia.com>
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
