Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E54CD98F3
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 06:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44BC3823AB;
	Wed, 11 Oct 2023 06:13:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44BC3823AB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=F3lj47Md
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PBtx3JbkBb6p; Wed, 11 Oct 2023 06:13:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D7315823CB;
	Wed, 11 Oct 2023 06:13:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D7315823CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD6AAC0039;
	Wed, 11 Oct 2023 06:13:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17322C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 06:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8EE6823CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 06:13:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8EE6823CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FnxTfoF4-OE8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 06:13:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5370823AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 06:13:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5370823AB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IX27illEM0WweUTVOw4Uowp/Sqp2/Whl4YtFtbVzV5Y=; b=F3lj47MdMB0oq0H5JFTSNI6gvA
 ubLRNT8vNIjkn2kvTZF2/XsHJA9TqceLMoAS9qFiOLo0ke5bnaBWiHJFjne04eImAdr3jaLngXoxk
 S1dc7DWwwa82G3b1DT5OlaqYbd1YD2wuZ86EolXttP20uTpMsuZgCDQhK+BQ7oeWyirjWZEEOPlWV
 zk/7kPZ1qlWCxaXJB7El4b2g+e3KyLXUATTQD1IHCJga0OUL9x/KqyYuxylV4D6kgy7iLX1GMphQ6
 XKfRBYhIzZqw4Gz6tqn00fg/+GoVaUuT9Ciogc/n8zGeKdo8emRvHTgN5nF5XKKsAYBicKWyfhJ75
 NVMEzpyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qqSTK-00Euyf-2N; Wed, 11 Oct 2023 06:13:30 +0000
Date: Tue, 10 Oct 2023 23:13:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <ZSY9Cv5/e3nfA7ux@infradead.org>
References: <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231010155937.GN3952@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 maorg@nvidia.com, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, jiri@nvidia.com, leonro@nvidia.com
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

On Tue, Oct 10, 2023 at 12:59:37PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 10, 2023 at 11:14:56AM -0400, Michael S. Tsirkin wrote:
> 
> > I suggest 3 but call it on the VF. commands will switch to PF
> > internally as needed. For example, intel might be interested in exposing
> > admin commands through a memory BAR of VF itself.
> 
> FWIW, we have been pushing back on such things in VFIO, so it will
> have to be very carefully security justified.
> 
> Probably since that is not standard it should just live in under some
> intel-only vfio driver behavior, not in virtio land.

Btw, what is that intel thing everyone is talking about?  And why
would the virtio core support vendor specific behavior like that?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
