Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FEAC433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 07:00:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15C326101B;
	Wed, 20 Jul 2022 07:00:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15C326101B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uf3KHQVV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7heRLjE4aLbW; Wed, 20 Jul 2022 07:00:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8B55C60BC1;
	Wed, 20 Jul 2022 07:00:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B55C60BC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 646F2C0035;
	Wed, 20 Jul 2022 07:00:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F164FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 07:00:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFB5D415B8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 07:00:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AFB5D415B8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Uf3KHQVV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ghhZZ6HYausy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 07:00:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 257E1414C6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 257E1414C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 07:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658300400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HRLM3otrmE4GIymRIerp3u+bT993AETRwpgpngLar7s=;
 b=Uf3KHQVVBzXcKXca22JhbRWDvF1SLmXWRuQTBMh8JA+SHVNe8QioIyBMdNGq1AlmphqTFH
 5v3JwgXOtKq9w6Sh5aDAfLpJEtODyRdDnrqaljQoXf8JcuXm3herQhKu3nrQASZ/6SIrYX
 0QmObvQyPVZ3uobUlpTQbJeNx9p1550=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-2lbGVfOxMxmxpPMgNKr28g-1; Wed, 20 Jul 2022 02:59:59 -0400
X-MC-Unique: 2lbGVfOxMxmxpPMgNKr28g-1
Received: by mail-wr1-f72.google.com with SMTP id
 l17-20020adfc791000000b0021dc7dc268dso2580829wrg.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jul 2022 23:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HRLM3otrmE4GIymRIerp3u+bT993AETRwpgpngLar7s=;
 b=thQ0xGFYJAotEAy6U6ifenK1QLIN/kkMdiIfAYPxMlNvSPsV7txgVlP/CJCcUFBxqT
 m8j3ILHWG7FHIWZxxW5OO+Gad0gBZT7+8ASjWT7NNeuhgUw5adKzWj2XMg7x5TxkQ7tn
 A6rL7W9POO7zbRDqvBpgEC7SELmRFFmmNwpxSsE29yKjpx1KJZGmMkevwLk1zKGwemTw
 fmRUdpPBeypZ1uATrZdbzOuUO+tHTYh6WTmfXgRJLYXLEI0Q6K3UvI3RKB2hxKu5t22F
 dmZCtYXljTJgZhnAsAcWf8kdXkstdc6QsZOaxi6jsLKYC9x/SQoVkFNmlVrREWm2NugG
 rBgQ==
X-Gm-Message-State: AJIora8avgwksbGWJcOYofZXqFJTfU7Jj6HCBUmTnQ0LF6MaPirEJrwH
 HnVTFwoSuBw1WxugH1hm/BgSuUN0npcplNMMFfVFUpR2+F6gCVs14iHpZBwztwt0JirZ5oLkWE0
 U4twY7co571qVobPtB9aruQb2ANkRcMu2PAqWwnyRhw==
X-Received: by 2002:a5d:6d8b:0:b0:21d:a6ac:b34b with SMTP id
 l11-20020a5d6d8b000000b0021da6acb34bmr29835064wrs.35.1658300397991; 
 Tue, 19 Jul 2022 23:59:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t58h1XiqLZzpVmt8FSkHa/kkkDQfr5n1b3uEEv7XFX0KTmylaQzbuExz7aQ6ttvtdtJ0w0kg==
X-Received: by 2002:a5d:6d8b:0:b0:21d:a6ac:b34b with SMTP id
 l11-20020a5d6d8b000000b0021da6acb34bmr29835052wrs.35.1658300397740; 
 Tue, 19 Jul 2022 23:59:57 -0700 (PDT)
Received: from redhat.com ([2.55.47.4]) by smtp.gmail.com with ESMTPSA id
 bw3-20020a0560001f8300b0021d70a871cbsm14632970wrb.32.2022.07.19.23.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jul 2022 23:59:57 -0700 (PDT)
Date: Wed, 20 Jul 2022 02:59:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Keir Fraser <keirf@google.com>
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <20220720024756-mutt-send-email-mst@kernel.org>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org> <YtbRwO40CmIRWOUR@google.com>
 <YtbTGjRw65QEKkQA@infradead.org> <YtbXxl8STUtQkacb@google.com>
MIME-Version: 1.0
In-Reply-To: <YtbXxl8STUtQkacb@google.com>
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

On Tue, Jul 19, 2022 at 04:11:50PM +0000, Keir Fraser wrote:
> On Tue, Jul 19, 2022 at 08:51:54AM -0700, Christoph Hellwig wrote:
> > On Tue, Jul 19, 2022 at 03:46:08PM +0000, Keir Fraser wrote:
> > > However, if the general idea at least is acceptable, would the
> > > implementation be acceptable if I add an explicit API for this to the
> > > DMA subsystem, and hide the detail there?
> > 
> > I don't think so.  The right thing to key off is
> > VIRTIO_F_ACCESS_PLATFORM, which really should be set in any modern
> > virtio device after all the problems we had with the lack of it.
> 
> Ok. Certainly the flag description in virtio spec fits the bill.

Maybe. But balloon really isn't a normal device. Yes the rings kind of
operate more or less normally. However consider for example free page
hinting. We stick a page address in ring for purposes of telling host it
can blow it away at any later time unless we write something into the
page.  Free page reporting is similar.
Sending gigabytes of memory through swiotlb is at minimum not
a good idea.

Conversely, is it even okay security wise that host can blow away any
guest page?  Because with balloon GFNs do not go through bounce
buffering.



> > > Or a completely different approach would be to revert the patch
> > > e41b1355508d which clears VIRTIO_F_ACCESS_PLATFORM in the balloon
> > > driver. MST: That's back in your court, as it's your patch!
> > 
> > Which also means this needs to be addresses, but I don't think a
> > simple revert is enough.
> 
> Well here are two possible approaches:
> 
> 1. Revert e41b1355508d outright. I'm not even sure what it would mean
> for reported pages to go through IOMMU. And VIRTIO_F_ACCESS_PLATFORM
> is no longer IOMMU-specific anyway.
> 
> 2. Continue to clear the flag during virtio_balloon negotiation, but
> remember that it was offered, and test for that in vring_use_dma_api()
> as well as, or instead of, virtio_has_dma_quirk().
> 
> Do either of those appeal?

I think the use case needs to be documented better.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
