Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7C4C04FDE
	for <virtualization@archiver.kernel.org>; Mon, 12 Dec 2022 06:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0571260B3F;
	Mon, 12 Dec 2022 06:50:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0571260B3F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WFvwE5pr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4OH2DEMbxw2d; Mon, 12 Dec 2022 06:50:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6117F6002E;
	Mon, 12 Dec 2022 06:50:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6117F6002E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AA13C0032;
	Mon, 12 Dec 2022 06:50:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BACCC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 06:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E76A0813CD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 06:50:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E76A0813CD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WFvwE5pr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pLxQKKm17_tn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 06:50:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBEB680AB4
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EBEB680AB4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Dec 2022 06:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=jp5hbDSEuCBBxqq4FtmbnUPgBzjkN+ii+Vc35aDpJGY=; b=WFvwE5prADrPvSFSuGK2hKbfO8
 J+iv5hu2r3a/D/ON0ps4jGYvgUCy03PwQVE7tOHvIkCOoHVRH0voE38GdQS6VRzV/MbX/0M1Rsb4M
 9f6IjVrGNrhxYY1piQFv8kYaqiO63+WfAfIVRfiKtc8nJVYMNBjfWndFc3iCt5cZCL+XaerSKXCob
 KbNC+8ZgQ0FNai+DbKU5gMp1iA5LTw/pyBbyQAfGqrrMPiLDkPMNanpjQzgFr6b9CfON/PzZhuTBL
 yL/B51icQLs2SGlSe1tAdsnCdvgj+OQGcEwg/Vi8GpPrI6CjryYcmwPk1njPJCuUAyB9+mem/2YhI
 jZZ+5+IA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1p4cdX-0092UC-QX; Mon, 12 Dec 2022 06:50:04 +0000
Date: Sun, 11 Dec 2022 22:50:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/2] virtio-blk: set req->state to MQ_RQ_COMPLETE after
 polling I/O is finished
Message-ID: <Y5bPG9QGMd/cDTQG@infradead.org>
References: <20221206141125.93055-1-suwan.kim027@gmail.com>
 <Y5EJ+6qtsy8Twe/q@fedora>
 <4701aded-0464-791e-8b8c-a34c422e8e62@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4701aded-0464-791e-8b8c-a34c422e8e62@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-block@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 Suwan Kim <suwan.kim027@gmail.com>
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

On Thu, Dec 08, 2022 at 09:48:23AM -0700, Jens Axboe wrote:
> > The doc comment for blk_mq_set_request_complete() mentions this being
> > used in ->queue_rq(), but that's not the case here. Does the doc comment
> > need to be updated if we're using the function in a different way?
> 
> Looks like it's a bit outdated...

I think the comment is still entirely correct.

> 
> > I'm not familiar enough with the Linux block APIs, but this feels weird
> > to me. Shouldn't blk_mq_end_request_batch(iob) take care of this for us?
> > Why does it set the state to IDLE instead of COMPLETE?
> > 
> > I think Jens can confirm whether we really want all drivers that use
> > polling and io_comp_batch to manually call
> > blk_mq_set_request_complete().
> 
> Should not be a need to call blk_mq_set_request_complete() directly in
> the driver for this.

Exactly.  Polling or not, drivers should go through the normal completion
interface, that is blk_mq_complete_request or the lower-level options
blk_mq_complete_request_remote and blk_mq_complete_request_direct.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
