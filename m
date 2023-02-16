Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77AEC636D7
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 16:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 58B5041039;
	Thu, 16 Feb 2023 16:51:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 58B5041039
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Abvdt4oG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id stoZ77hZllPg; Thu, 16 Feb 2023 16:51:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 736A040441;
	Thu, 16 Feb 2023 16:51:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 736A040441
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FD2CC0032;
	Thu, 16 Feb 2023 16:51:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9737C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 16:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BEA3340FD1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 16:51:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BEA3340FD1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ppz4wavmnYUA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 16:51:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F00B40441
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F00B40441
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 16:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=z9L7OCl80jb/hsDN+Rhd6bi9ZPLuBsktXXs5P51q8gc=; b=Abvdt4oGV67A4jZOHInLWy0FHB
 +lVGU1eSMWLSsPafncfnzdZtCy7zn/NSyC8+XnXPmu3RWEeftbAZF0W9A81tUPT8trBF2YkNa2pPW
 hfA9w9PjdGhMNtbE6RmHrT0WXhXMlOoBqSF6ZzIK17dNTkF5iU+WRud5nb4PBOnzPgphu23PFU/Y1
 jmFzNyhgRe5nHsdSnh22iZTuNNAdfqJrsLyknTRAtITVV2zfvADUoJqjQs+G7TvUOmHHm0U1LMyaF
 UcyEfZKIzeyM3f7PZGuMn19GR89QpVpVpFFDD+PeZYi6IrYAfN5/Y7ntAkZtDpGrbeANM8xZc9mto
 h448PoFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1pShTw-00BGP8-5V; Thu, 16 Feb 2023 16:51:40 +0000
Date: Thu, 16 Feb 2023 08:51:40 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] scsi: virtio_scsi: Modify the kmalloc allocation flag
Message-ID: <Y+5fHPW/OXhfOqjv@infradead.org>
References: <20230218005356.3932-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230218005356.3932-1-zeming@nfschina.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, pbonzini@redhat.com, jejb@linux.ibm.com
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

On Sat, Feb 18, 2023 at 08:53:56AM +0800, Li zeming wrote:
> The inq_result pointer must be allocated successfully; otherwise,
> subsequent function execution may crash.

The error needs to be handled.  Or in fact this LLDD needs to stop
breaking layering and issuing it's own INQUIRY commands.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
