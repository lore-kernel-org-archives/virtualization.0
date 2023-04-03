Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DB6C76188
	for <virtualization@archiver.kernel.org>; Mon,  3 Apr 2023 15:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F59981E4B;
	Mon,  3 Apr 2023 15:15:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F59981E4B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YZdj4v0w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ikLQU4-eWwL; Mon,  3 Apr 2023 15:15:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4051681DF8;
	Mon,  3 Apr 2023 15:15:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4051681DF8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 186E9C0037;
	Mon,  3 Apr 2023 15:15:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D507C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 15:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5B27281E16
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 15:15:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B27281E16
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RkFzaowzXFe2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 15:15:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF95981DF8
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DF95981DF8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Apr 2023 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=QFVVqjusEIvNfI/jJIUeOuNQUDBhyrjRmT3zSp6yXXA=; b=YZdj4v0wZa10lmZa9OWvGpEdqI
 ktiJhoIXUpnSP5Zab7A0mCTyioZTbMAl+X1c+ry/ei8yv5egJjEuBbClwCkt4r9KxhnfT4UmJscCC
 avG4nd5wAFEwzCl7bWS0dMP0srk7FuRB0/Nom6crduX3XI5duU9TQQEosSRv3IAVEJLfkauDyQKt1
 Sdtb4sZeh4JCN9ZcyAiRff1NS03Rc4r9LTaojVVH0P1sYh2/UWujIoylejW1F0cRlfVKXdJJJf4rX
 BSfo2EitjzJk6HUWUfkl7objlX0Nrp6HiKGR3rI8tggvK5qphFR/RsU/oudxOFAgRx70k+JrPuYSQ
 mgLH6dWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pjLu2-00Fkfl-1G; Mon, 03 Apr 2023 15:15:26 +0000
Date: Mon, 3 Apr 2023 08:15:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Subject: Re: [PATCH v2 1/2] virtio-blk: migrate to the latest patchset version
Message-ID: <ZCrtjrYQHnppV8gN@infradead.org>
References: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
 <20230330214953.1088216-2-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230330214953.1088216-2-dmitry.fomichev@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jens Axboe <axboe@kernel.dk>, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Sam Li <faithilikerun@gmail.com>, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org
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

What is "migrate to the latest patchset version" even supposed to mean?

I don't think that belongs into a kernel commit description.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
