Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84224CD6E77
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 14:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BF7D82660;
	Wed, 11 Oct 2023 14:17:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BF7D82660
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e4N5pa9S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZFTEU2t5hktC; Wed, 11 Oct 2023 14:17:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 878438264C;
	Wed, 11 Oct 2023 14:17:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 878438264C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 636D3C0071;
	Wed, 11 Oct 2023 14:17:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 522D9C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 14:17:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C798405AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 14:17:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C798405AF
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e4N5pa9S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j6U4l-4_15QV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 14:17:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20E7040468
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 14:17:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20E7040468
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=17Hg6kGHCOgU0Ms0AduR83aFqotdoFUXv6TjFFYWHj0=; b=e4N5pa9Ss2bbnDPRcL2fhVrsX9
 MTyCngG3sagVj43C48O8opbBPCE9zBiwHi5/52PlVZyBHcj8tMG8H07ntEm3aq7IULjZbDYoL+B3x
 xH9nF4tYPWB1RJEpRDg1CQvPi/PdTARqpJl0zlAjcXjORDnXOh+r+WcLELiZa7XkypN6o2BVbm6ct
 sVM+WmfChkm2gssYQYNHYbERaPCuRCmSO2nkmb3a38eWWX19VBVyf80qTIgik1UWDTAfBPTzhxnJy
 awjWqNnOGP/t/FYvrQW2yt2tTH6Iuzhq6fso1qk0vVee0iDlLc2neGBGNq4AQV6djUakUre4v4Pvu
 2Ki25qyQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qqa1d-00G4WZ-0N; Wed, 11 Oct 2023 14:17:25 +0000
Date: Wed, 11 Oct 2023 07:17:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <ZSaudclSEHDEsyDP@infradead.org>
References: <c3724e2f-7938-abf7-6aea-02bfb3881151@nvidia.com>
 <20230926072538-mutt-send-email-mst@kernel.org>
 <ZRpjClKM5mwY2NI0@infradead.org>
 <20231002151320.GA650762@nvidia.com>
 <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <ZSZAIl06akEvdExM@infradead.org> <20231011135709.GW3952@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011135709.GW3952@nvidia.com>
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

On Wed, Oct 11, 2023 at 10:57:09AM -0300, Jason Gunthorpe wrote:
> > Independent of my above points on the doubts on VF-controlled live
> > migration for PCe device I absolutely agree with your that the Linux
> > abstraction and user interface should be VF based.  Which further
> > reinforeces my point that the VFIO driver for the controlled function
> > (PF or VF) and the Linux driver for the controlling function (better
> > be a PF in practice) must be very tightly integrated.  And the best
> > way to do that is to export the vfio nodes from the Linux driver
> > that knowns the hardware and not split out into a separate one.
> 
> I'm not sure how we get to "very tightly integrated". We have many
> examples of live migration vfio drivers now and they do not seem to
> require tight integration. The PF driver only has to provide a way to
> execute a small number of proxied operations.

Yes.  And for that I need to know what VF it actually is dealing
with.  Which is tight integration in my book.

> Regardless, I'm not too fussed about what directory the implementation
> lives in, though I do prefer the current arrangement where VFIO only
> stuff is in drivers/vfio. I like the process we have where subsystems
> are responsible for the code that implements the subsystem ops.

I really don't care about where the code lives (in the directory tree)
either.  But as you see with virtio trying to split it out into
an arbitrary module causes all kinds of pain.

> 
> E800 also made some significant security mistakes that VFIO side
> caught. I think would have been missed if it went into a netdev
> tree.
> 
> Even unrelated to mdev, Intel GPU is still not using the vfio side
> properly, and the way it hacked into KVM to try to get page tracking
> is totally logically wrong (but Works For Me (tm))
> 
> Aside from technical concerns, I do have a big process worry
> here. vfio is responsible for the security side of the review of
> things implementing its ops.

Yes, anytjing exposing a vfio node needs vfio review, period.  And
I don't think where the code lived was the i915 problem.  The problem
was they they were the first open user of the mdev API, which was
just a badly deisgned hook for never published code at that time, and
they then shoehorned it into a weird hypervisor abstraction.  There's
no good way to succeed with that.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
