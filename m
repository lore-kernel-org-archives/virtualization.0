Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CF8C19F2A
	for <virtualization@archiver.kernel.org>; Sun,  7 Aug 2022 06:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5D29417CD;
	Sun,  7 Aug 2022 06:52:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5D29417CD
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dCJLYoEW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g0Fz6Jaxyt87; Sun,  7 Aug 2022 06:52:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ABC4441796;
	Sun,  7 Aug 2022 06:52:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABC4441796
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AFCEC0032;
	Sun,  7 Aug 2022 06:52:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 232A2C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 06:52:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE895417B2
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 06:52:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE895417B2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z5aaQmdBoqpN
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 06:52:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F32F41796
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1F32F41796
 for <virtualization@lists.linux-foundation.org>;
 Sun,  7 Aug 2022 06:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=T5G3kNwYRK7zLNUCU3R4YTUeZT4VSRInrZ5Z/Pp3Lkw=; b=dCJLYoEWdMdq7/FPcLfiG3jJ3W
 wv4d+6ODFzDjRx+CPUhu0szsBENo+10WjIWSfgFDu2Ee0AWGv+cDPHlYrZuy6lXjevoWiSI071j0l
 CUUKF2QWwn4hZjEzNAiW9mL3Tvl/7cLETJ6yvSC/ZWFZ+Zzm+IU1c8VfwKR5wJX4+3FUzubPbehxK
 R/DdhY1UjhTq1kFAj+grLPDvto3F2m5EE/IC4lrC/a+LQEoeGVoLvsqqnuWm+59a9mXfwcGlicWsD
 NZRhuAHRJshRVzaEFOsu5cfFZLH8U9Qxab1KuBhwvdgDtlwJxsG9XC3ZBMgn9dmpramTuL7rqo7nb
 AghKr/vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oKa8z-007LfM-Rq; Sun, 07 Aug 2022 06:52:13 +0000
Date: Sat, 6 Aug 2022 23:52:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <Yu9hHef3VawCbJT9@infradead.org>
References: <20220805181105.GA29848@willie-the-truck>
 <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHk-=wip-Lju3ZdNwknS6ouyw+nKXeRSnhqVyNo8WSEdk-BfGw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: jiyong@google.com, kvm@vger.kernel.org, mst@redhat.com, maz@kernel.org,
 keirf@google.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, ascull@google.com,
 stefanha@redhat.com, kernel-team@android.com, Will Deacon <will@kernel.org>
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

On Fri, Aug 05, 2022 at 03:57:08PM -0700, Linus Torvalds wrote:
> Why is "IOMMU support" called "VIRTIO_F_ACCESS_PLATFORM"?

Because, as far as the virtio spec and virtio "guest" implementation is
concerned it is not about IOMMU support at all.  It is about treating
virtio DMA as real DMA by the platform, which lets the platform let
whatever method of DMA mapping it needs to the virtio device.  This
is needed to make sure harware virtio device are treated like actual
hardware and not like a magic thing bypassing the normal PCIe rules.

Using an IOMMU if one is present for bus is just one thing, others
are using offets of DMAs that are very common on non-x86 platforms,
or doing the horrible cache flushing needed on devices where PCIe
is not cache coherent.

It really is vhost that seems to abuse it so that if the guest
claims it can handle VIRTIO_F_ACCESS_PLATFORM (which every modern
guest should) it enables magic behavior, which I don't think is what
the virtio spec intended.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
