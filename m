Return-Path: <SRS0=07LM=LI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FAAC2B9F4
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 11:44:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA65861185
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 11:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA65861185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8741B83AF5;
	Mon, 14 Jun 2021 11:44:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FfJF8c_URgkQ; Mon, 14 Jun 2021 11:44:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 43AEC83AEE;
	Mon, 14 Jun 2021 11:44:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6A91C000D;
	Mon, 14 Jun 2021 11:44:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32BB1C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 11:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 105DE83AEE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 11:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MUSk1GD34Kr6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 11:44:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BE6983AEA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tER/9yntskfsYogplE2UHT4/vwtYhzr4VR/dY/qdVM8=; b=B4dNlMd7n3ZdsQUA7uiwxajkWN
 RVQzR1mW9siJ4BN91NHDdVQpiyw763JpbznjXtkj34vQLwTId3IF1HFPgzX2Q8thstZtuTNbdUabg
 povYqKd8eHLH1np7mG+s76KQDLk8fp7Z/W5afpMQlwD4+Ll1hHLT7crV6IbFpVZZNtq1c62Mi1cNg
 nh0lLdCRQ16L8wTC+yKKpZYbCUyfbXt51ERWGC6nJNnqJzyr+atsfgnv3SfcdpLBryAeDp2ewJoMY
 0CwpWNFkg1FwrZqITsGv9yQJuc/amquo8TEIQOaqGrhm1HJqe/jUG/JpOIxDa1P7uMYeuSWppMhBH
 q7dLiYGA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lsl0S-005N7K-G0; Mon, 14 Jun 2021 11:43:55 +0000
Date: Mon, 14 Jun 2021 12:43:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v4 00/16] Introduce SCMI VirtIO transport
Message-ID: <YMdA+GkgJ+GONuJr@infradead.org>
References: <20210611165937.701-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210611165937.701-1-cristian.marussi@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: virtio-dev@lists.oasis-open.org, mikhail.golubev@opensynergy.com,
 f.fainelli@gmail.com, vincent.guittot@linaro.org, igor.skalkin@opensynergy.com,
 jean-philippe@linaro.org, Jonathan.Cameron@huawei.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Vasyl.Vavrychuk@opensynergy.com, peter.hilber@opensynergy.com,
 james.quinlan@broadcom.com, sudeep.holla@arm.com, souvik.chakravarty@arm.com,
 etienne.carriere@linaro.org, linux-arm-kernel@lists.infradead.org,
 Andriy.Tryshnivskyy@opensynergy.com
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

On Fri, Jun 11, 2021 at 05:59:21PM +0100, Cristian Marussi wrote:
> Hi all,
> 
> I'm posting this V4 series starting from the work done up to V3 by
> OpenSynergy.

Who is 'OpenSynergy'?

> The main aim of this rework is to simplify where possible the SCMI VirtIO
> support added in V3 by adding upfront and then using some new mechanisms in
> the SCMI Core Transport layer.

And what is 'SCMI', and why would anyone want a new virtio transport?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
