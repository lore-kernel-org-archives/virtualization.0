Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0088EB64D8
	for <virtualization@archiver.kernel.org>; Wed, 21 Jun 2023 12:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B95440BE6;
	Wed, 21 Jun 2023 12:13:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B95440BE6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1iKNaLtt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJD4WUYeclv0; Wed, 21 Jun 2023 12:13:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E39BB40144;
	Wed, 21 Jun 2023 12:13:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E39BB40144
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 962F0C0037;
	Wed, 21 Jun 2023 12:13:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8A91C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 12:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D54D813F7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 12:13:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D54D813F7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1iKNaLtt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GnxEQVaaSBbw
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 12:13:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C9D6813E8
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8C9D6813E8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jun 2023 12:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=HJ6aMao89kw04QUy0/JqLw3tiRnJ7tZ8x7GgW+IP8+0=; b=1iKNaLttZfW89my+DszE0wSaLz
 3iTgPmiJbY9ulm4tEmY9q+uzOBG9C0FAuJkIq3SeTTqymhPuuf3/8ZDxXwia2FzhYPjqr1/CYxb0F
 FZNrwGLxCCCSxsItwui2ZusZTblvBv8qbJxefK6wn24OlMe7ngHelTRF5UggmHfPeSP8s2M7rQ6Ce
 CtC4irb/lY4lFcaWJmLzDmrxCU2AnAh5n9IVZhgya/1Pq3Sjv8BPErClJKhF/OiNl2qLx3tkaGCx4
 YeRn57kBD6/hzbXUYohe8x9RwMZO0jj+RtYuOpQD4VTc8M+k3UjcquSQFbAVx/rqQxMDqFwhc6MeE
 q+vQdTFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qBwi8-00EV4i-1o; Wed, 21 Jun 2023 12:13:20 +0000
Date: Wed, 21 Jun 2023 05:13:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hou Tao <houtao@huaweicloud.com>
Subject: Re: [PATCH] virtio_pmem: do flush synchronously
Message-ID: <ZJLpYMC8FgtZ0k2k@infradead.org>
References: <20230620032838.1598793-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230620032838.1598793-1-houtao@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jens Axboe <axboe@kernel.dk>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 nvdimm@lists.linux.dev, houtao1@huawei.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>
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

I think the proper minimal fix is to pass in a REQ_WRITE in addition to
REQ_PREFLUSH.  We can than have a discussion on the merits of this
weird async pmem flush scheme separately.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
