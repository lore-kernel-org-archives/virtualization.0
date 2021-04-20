Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6970C433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 07:03:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C82F61073
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 07:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C82F61073
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 20BE283478;
	Tue, 20 Apr 2021 07:03:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DKBYhGyRSWPz; Tue, 20 Apr 2021 07:03:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F808833AE;
	Tue, 20 Apr 2021 07:03:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44B92C000F;
	Tue, 20 Apr 2021 07:03:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9237C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 07:03:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98AEE83478
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 07:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LgusHHPn2I7T
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 07:02:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8DB35833AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 07:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8Oihx25ixLmgK896s6BkBU4Zy4ZTSxg7BY07q9IT2hQ=; b=hFqirIfh+nlo9lCAUemEoOwmcU
 ZMdFNj8RgdzR2qM5APmrrVtR2OeTcERwNN38u6nFxezVx5GJo/xAtYA7HD2DxH0kqehLO52bXBwLe
 4/yxCWMoy1FXMYDGSBjvTS3E9tGAd58v9GOpMqgE+YHl2Vwv1VS5Gu+Zq+IQHvZlk/l2dqxTnG4FG
 MHw2JbqYRC17ffhqd08MnBFxZTB/JNwajHFljefrZWjdnheFvlycOhNYNrNFZHVPMf0UJTWMTKfYK
 P8u11hg1IsH0zaSL1KL7F3EnxipCucT9Xw4ZAr0PB8sF+LfvSOvdTbzuzkN4XE+OubYIRqGoz37Mw
 Jw7zA3AA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lYkO1-00Eplv-KX; Tue, 20 Apr 2021 07:01:54 +0000
Date: Tue, 20 Apr 2021 08:01:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Enrico Granata <egranata@google.com>
Subject: Re: [PATCH v2] virtio_blk: Add support for lifetime feature
Message-ID: <20210420070129.GA3534874@infradead.org>
References: <20210416194709.155497-1-egranata@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210416194709.155497-1-egranata@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: axboe@kernel.dk, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

Just to despit my 2 cents again:  I think the way this is specified
in the virtio spec is actively harmful and we should not suport it in
Linux.

If others override me we at least need to require a detailed
documentation of these fields as the virto spec does not provide it.

Please also do not add pointless over 80 character lines, and follow
the one value per sysfs file rule.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
