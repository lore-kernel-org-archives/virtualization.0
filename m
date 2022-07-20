Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E23C43334
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 09:58:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BBFB7400AB;
	Wed, 20 Jul 2022 09:58:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BBFB7400AB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Oyc4syWC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vHjhXJF1t1oY; Wed, 20 Jul 2022 09:58:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 30011405D4;
	Wed, 20 Jul 2022 09:58:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30011405D4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA0EAC0035;
	Wed, 20 Jul 2022 09:58:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 077DAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D332A405D4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:58:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D332A405D4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uPC7sGhoGUh5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:58:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4707400AB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4707400AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 09:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658311120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YmCCESdad99/+y0cHmD+1TOj7rDSnAAqAqJlZPlUJxI=;
 b=Oyc4syWCSl7cARFLk7Mo6NzyH1x7nDqp6VW5ZFOieSKjRnEsn+jG2FWuornZbQmejA7FPp
 dl8ZMeZwCzH2U11lOfeSSW5RgJnrYLXh3y9TGHacD40tCDF20lVf5hM+u6RSDZeRBBji9a
 Vh4/Ay4QygoNSiiCBcaBTjDifNdxEAM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-KwW6dx0pPBeGP9oK4-CbgQ-1; Wed, 20 Jul 2022 05:58:33 -0400
X-MC-Unique: KwW6dx0pPBeGP9oK4-CbgQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 r82-20020a1c4455000000b003a300020352so7550761wma.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 02:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YmCCESdad99/+y0cHmD+1TOj7rDSnAAqAqJlZPlUJxI=;
 b=UjRGtSx22rKziXbtIdQk4NNwC4tQ6vqZevpIxbyY5Lz87ksAGzqX2jwmHRX7j6IbBj
 4yT5AIE0YrPjWGPdKL8SM2H4JpFR6f9wBjwJsebeM6Oj+tl9rzqjeOg407PqwVoYqp2Y
 WMuK5ozcHCKuwPprDlUhBUTqJnR3XJ3WWW+6ZD8cDOYHl2Js57sbcGmVuArYDtEwa7Vn
 BHFnxliGzdxdDRpXhrgRiKZoibcP0SUZtQ0C348xI0GmFadt2crOc/q4uuJfqn0g2IiH
 MCyUdZmDig+RG+NZzGiBp9PpaQRktF66RkOIw++/CkNjCPVckPmZC82wm/sPstK/kQ1h
 jbYA==
X-Gm-Message-State: AJIora+jlKpDv7zKFkUFXD3/v0gDDAWqFoNvtunfzZX6cLpeSIT+Z2Wo
 lriYDgza23WR6EE/mBqqqoIIz/niLDAVAlRhJzgF7MLFv6CQBwvnlBsvyQTJ3gNzSMbwUxnTO32
 QaZuxEFhlwg35VyFwULueJoJd5jxhPmhjfVmc3RLx/Q==
X-Received: by 2002:a05:6000:15ce:b0:21d:b177:a8f0 with SMTP id
 y14-20020a05600015ce00b0021db177a8f0mr30432544wry.370.1658311112292; 
 Wed, 20 Jul 2022 02:58:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ti/BUqcp+kLfup+ElF6yhzCdwtC3kW8c5fi1qMgoV6FNkQmQ/O1A1ozfiQp9mHTFELrJu6EQ==
X-Received: by 2002:a05:6000:15ce:b0:21d:b177:a8f0 with SMTP id
 y14-20020a05600015ce00b0021db177a8f0mr30432527wry.370.1658311112035; 
 Wed, 20 Jul 2022 02:58:32 -0700 (PDT)
Received: from redhat.com ([2.55.25.63]) by smtp.gmail.com with ESMTPSA id
 w5-20020a05600c038500b003a31b00c216sm1893727wmd.0.2022.07.20.02.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Jul 2022 02:58:31 -0700 (PDT)
Date: Wed, 20 Jul 2022 05:58:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keir Fraser <keirf@google.com>
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <20220720051351-mutt-send-email-mst@kernel.org>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org> <YtbRwO40CmIRWOUR@google.com>
 <YtbTGjRw65QEKkQA@infradead.org> <YtbXxl8STUtQkacb@google.com>
 <20220720024756-mutt-send-email-mst@kernel.org>
 <Yte8h0wtBZqiBky8@google.com>
MIME-Version: 1.0
In-Reply-To: <Yte8h0wtBZqiBky8@google.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Christoph Hellwig <hch@infradead.org>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Wed, Jul 20, 2022 at 08:27:51AM +0000, Keir Fraser wrote:
> On Wed, Jul 20, 2022 at 02:59:53AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 19, 2022 at 04:11:50PM +0000, Keir Fraser wrote:
> > > On Tue, Jul 19, 2022 at 08:51:54AM -0700, Christoph Hellwig wrote:
> > > > On Tue, Jul 19, 2022 at 03:46:08PM +0000, Keir Fraser wrote:
> > > > > However, if the general idea at least is acceptable, would the
> > > > > implementation be acceptable if I add an explicit API for this to the
> > > > > DMA subsystem, and hide the detail there?
> > > > 
> > > > I don't think so.  The right thing to key off is
> > > > VIRTIO_F_ACCESS_PLATFORM, which really should be set in any modern
> > > > virtio device after all the problems we had with the lack of it.
> > > 
> > > Ok. Certainly the flag description in virtio spec fits the bill.
> > 
> > Maybe. But balloon really isn't a normal device. Yes the rings kind of
> > operate more or less normally. However consider for example free page
> > hinting. We stick a page address in ring for purposes of telling host it
> > can blow it away at any later time unless we write something into the
> > page.  Free page reporting is similar.
> > Sending gigabytes of memory through swiotlb is at minimum not
> > a good idea.
> 
> I don't think any balloon use case needs the page's guest data to be
> made available to the host device. What the device side does with
> reported guest-physical page addresses is somewhat VMM/Hyp specific,
> but I think it's fair to say it will know how to reclaim or track
> pages by guest PA, and bouncing reported/hinted page addresses through
> a SWIOTLB or IOMMU would not be of any use to any use case I can think
> of.
> 
> As far as I can see, the only translation that makes sense at all for
> virtio balloon is in ring management.
> 
> > Conversely, is it even okay security wise that host can blow away any
> > guest page?  Because with balloon GFNs do not go through bounce
> > buffering.
> 
> Ok, I think this is fair and I can address that by describing the use
> case more broadly.
> 
> The short answer is that there will be more patches forthcoming,
> because the balloon driver will need to tell the hypervisor (EL2 Hyp
> in the ARM PKVM case) that is is willingly relinquishing memory
> pages. So, there will be a patch to add a new HVC to PKVM Hyp, and a
> patch to detect and use the new HVC via a new API that hooks into
> Linux's balloon infrastructure.
> 
> So the use case is that virtio_balloon needs to set up its rings and
> descriptors in a shared memory region, as requested via
> dma-restricted-pool and the VIRTIO_F_PALTFORM_ACCESS flag. This is
> required because the host device has no access to regular guest
> memory.
> 
> However, in PKVM, page notifications will notify both the (trusted)
> Hypervisor, via hypercall, and the (untrusted) VMM, via virtio. Guest
> physical addresses are fine here. The VMM understands guest PAs
> perfectly well, it's just not normally allowed to access their
> contents or otherwise map or use those pages itself.

OK ... and I wonder whether this extends the balloon device
in some way? Is there or can there be a new feature bit for this
functionality?


> > 
> > > > > Or a completely different approach would be to revert the patch
> > > > > e41b1355508d which clears VIRTIO_F_ACCESS_PLATFORM in the balloon
> > > > > driver. MST: That's back in your court, as it's your patch!
> > > > 
> > > > Which also means this needs to be addresses, but I don't think a
> > > > simple revert is enough.
> > > 
> > > Well here are two possible approaches:
> > > 
> > > 1. Revert e41b1355508d outright. I'm not even sure what it would mean
> > > for reported pages to go through IOMMU. And VIRTIO_F_ACCESS_PLATFORM
> > > is no longer IOMMU-specific anyway.
> > > 
> > > 2. Continue to clear the flag during virtio_balloon negotiation, but
> > > remember that it was offered, and test for that in vring_use_dma_api()
> > > as well as, or instead of, virtio_has_dma_quirk().
> > > 
> > > Do either of those appeal?
> > 
> > I think the use case needs to be documented better.
> 
> I hope the above is helpful in giving some more context.
> 
> Perhaps it would make more sense to re-submit this patch as part of
> a larger series that includes the rest of the mechanism needed to
> support virtio_balloon on PKVM?
> 
> Thanks,
> Keir

I suspect so, yes.


> > 
> > -- 
> > MST
> > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
