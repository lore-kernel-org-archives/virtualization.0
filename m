Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618DAC4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 10:46:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D75B8416B5;
	Wed, 21 Dec 2022 10:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D75B8416B5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UjLea5Mb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5pIuLjxLkiOy; Wed, 21 Dec 2022 10:46:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 40F7B416FA;
	Wed, 21 Dec 2022 10:46:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40F7B416FA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B906DC0071;
	Wed, 21 Dec 2022 10:46:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D063EC0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 10:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A005781E25
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 10:46:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A005781E25
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UjLea5Mb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3-2SnPb_qpW2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 10:46:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA03B81E17
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA03B81E17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NVvTHYKeGOdR2VjTX4ZINnL+ls5shgZj5qyaSyTHOso=; b=UjLea5MbYfKKu+BxOeWIyiUJOw
 y9PWEd7zrR35TmWg3MjBXnWhTlx6jvUlS6zpKKCqY+dxBMM4h0iqEuprKh5xoNJtxxAVkTiYySt6e
 LJcBlicIObQF8sZz/HLOy6xRfeQn5bsUXKA0s4ObcldaOp+Nxcwp+NbTntiarKkJArC5Wiy9kjl10
 kDWBqpLwhVbXAOtbeC92N03/syW8vIXNPsaJpZCYMPqUs2W5L97Xam62wLSHmeYa/Y9Rs3QIUglQd
 vACdyfk5f61E5w/8jNndzyqvnRmib1IqfWss/R5YGH9ehX7EEGcrVllLcQZ0bznb2wNYwsg+3quuC
 WerSqOzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1p7wbl-00DefD-Vm; Wed, 21 Dec 2022 10:45:58 +0000
Date: Wed, 21 Dec 2022 02:45:57 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v2 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE
 after polling I/O is finished
Message-ID: <Y6Lj5QcLFP87a4d9@infradead.org>
References: <20221220153613.21675-1-suwan.kim027@gmail.com>
 <20221220153613.21675-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221220153613.21675-2-suwan.kim027@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
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

On Wed, Dec 21, 2022 at 12:36:12AM +0900, Suwan Kim wrote:
> Driver should set req->state to MQ_RQ_COMPLETE after it finishes to process
> req. But virtio-blk doesn't set MQ_RQ_COMPLETE after virtblk_poll() handles
> req and req->state still remains MQ_RQ_IN_FLIGHT. Fortunately so far there
> is no issue about it because blk_mq_end_request_batch() sets req->state to
> MQ_RQ_IDLE.
> 
> In this patch, virblk_poll() calls blk_mq_complete_request_remote() to set
> req->state to MQ_RQ_COMPLETE before it adds req to a batch completion list.
> So it properly sets req->state after polling I/O is finished.
> 
> Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
> Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
