Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4B3C433DB
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 08:35:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F04864E45
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 08:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F04864E45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD700866FC;
	Wed, 10 Feb 2021 08:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jrCPC4VxXgi5; Wed, 10 Feb 2021 08:35:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF913866FB;
	Wed, 10 Feb 2021 08:35:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC617C0174;
	Wed, 10 Feb 2021 08:35:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8DA8AC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:35:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 80B0E845D6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:35:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S3CYknoSWXVT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:35:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0B3EB84F61
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IZKqDIwBA9Z7X8ejRUmkcmCCTw1KCnYEp9Ve7/mBumQ=; b=ujR89gDJ65rxUd4tUItIFlgXof
 OOsJnuLYZHOTWs03vysbW8ZkYO5pwAF7CW64oHiZpkCACb/R2A1ZkAOziDAKembK+tSGDOtkvfNg7
 MbwezwIqA4QQjlydlqyyS8fkXAsdM3UV5PSLV4qaQIc/W1RGS69iFshPsdkkp4f6B5VH8gauTA1A9
 mdA0c0X7X2l2n/SdrNumUYWCVyi4ygRrsithpki4zzH/UTvTWKOl2sZGwtXCWYV8CnnAH9yG/51zZ
 6eAHY0cV2BT2XuVxMzmJjvfomy7ZLoMkNEjYNHRHp7co75W47OJfsPSYJVzAqQ0L05eJq6RGV7L2h
 zyNr0lww==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1l9kxu-008aOj-9I; Wed, 10 Feb 2021 08:35:16 +0000
Date: Wed, 10 Feb 2021 08:35:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 01/13] target: move t_task_cdb initialization
Message-ID: <20210210083514.GA2045726@infradead.org>
References: <20210209123845.4856-1-michael.christie@oracle.com>
 <20210209123845.4856-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210209123845.4856-2-michael.christie@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: loberman@redhat.com, Chaitanya.Kulkarni@wdc.com, martin.petersen@oracle.com,
 mst@redhat.com, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com, linux-scsi@vger.kernel.org
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

On Tue, Feb 09, 2021 at 06:38:33AM -0600, Mike Christie wrote:
> The next patch splits target_submit_cmd_map_sgls so the initialization
> and submission part can be called at different times. If the init part
> fails we can reference the t_task_cdb early in some of the logging
> and tracing code. This moves it to transport_init_se_cmd so we don't
> hit NULL pointer crashes.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
