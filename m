Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C13C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:51:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB20A61056
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AB20A61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A792608D4;
	Wed, 13 Oct 2021 12:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0X8VpJ_kU2zM; Wed, 13 Oct 2021 12:51:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 19BB5608E9;
	Wed, 13 Oct 2021 12:51:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBB79C000F;
	Wed, 13 Oct 2021 12:51:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 505F9C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:51:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3FF6A82A2E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:51:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wr7nRCER9twD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:51:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33543829BB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634129503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T/7FiCB1ISKOEoQmv0h0vU/4qoNS1mIBBsK6BA/38aI=;
 b=eQS7Da+meQrkDunshiehhtY1ofFpXtpZtF/twq99yQcJcmUJMxuoTZ2UJsa0BHsLHc8jj/
 ZHCTLf0Ko/8V4tFPq3QoU4wsxJ2TWm1Isj2B8XxVKp/xSLwGWxUy/RKoFQlTWKnwGYkTK7
 Xyfex4ajtKs1xhO/X87muA8CgVTcxv4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-LsQ7bb_SNnycqiOSjCSHUQ-1; Wed, 13 Oct 2021 08:51:41 -0400
X-MC-Unique: LsQ7bb_SNnycqiOSjCSHUQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 d13-20020adfa34d000000b00160aa1cc5f1so1877710wrb.14
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=T/7FiCB1ISKOEoQmv0h0vU/4qoNS1mIBBsK6BA/38aI=;
 b=X9Pn1FkhFcE/IFOcnQBJGg+xFDwn3jaGgGdW2BAXgkE6joAIhZJxxH0QPcIopeKyXk
 m5afjaebg7WRfB6RFHlV3htW97DubzzH5UDGOL5x8WkthDG7/5tGWpwx9gVK1KsOn3d3
 hM5w+kNu76L7EWQrYEavB1GDRX2b6cfJKmD9l9f934g7L2SG+JwxrL8XFSHLc88yEPdZ
 3YnExJkxBAqSQF2WgcEehOO5Un+oVZY0JSV9t2MXm3A7AXd3/wXwhOqt+PqWBNLS3tpy
 8H9uUs5v3OV0Du9xhyscZjFvyRjZw7fKSJc11xmsgNc3yKJ9FWyir2NJ6aVAFa856YBd
 jzzw==
X-Gm-Message-State: AOAM5335MfboPLTqIXtnrIODKUHeDdH1mgINBXdnS+CvCrReDd/QsLb8
 4rHpgWUbtx66tGVBDRcqRLPysVr8MR5ACqhXjWFzKwgrgTmN/HlAnG9lVZvGk0FPhB6C6sv/1aK
 eK4s1dZZbnr3R2T2+7+azR5FmbKDc7akAxHWEHIIP0g==
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr12443700wmp.65.1634129500757; 
 Wed, 13 Oct 2021 05:51:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxXShSsCgY6/PDbrJUPITVtStrZWvnffqdaNuTNNoDSChn1zbY5sZOccceeIhneM0FjogR/A==
X-Received: by 2002:a1c:29c7:: with SMTP id p190mr12443682wmp.65.1634129500615; 
 Wed, 13 Oct 2021 05:51:40 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id j1sm16548759wrb.56.2021.10.13.05.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:51:40 -0700 (PDT)
Date: Wed, 13 Oct 2021 08:51:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211013084711-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <20211004112623-mutt-send-email-mst@kernel.org>
 <20211005062359-mutt-send-email-mst@kernel.org>
 <20211011114041.GB16138@lst.de>
 <20211013082025-mutt-send-email-mst@kernel.org>
 <CACycT3skLJp1HfovKP8AvQmdxhyJNG6YFrb6kXjd48qaztHBNQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3skLJp1HfovKP8AvQmdxhyJNG6YFrb6kXjd48qaztHBNQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Christoph Hellwig <hch@lst.de>
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

On Wed, Oct 13, 2021 at 08:34:22PM +0800, Yongji Xie wrote:
> On Wed, Oct 13, 2021 at 8:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 01:40:41PM +0200, Christoph Hellwig wrote:
> > > On Tue, Oct 05, 2021 at 06:42:43AM -0400, Michael S. Tsirkin wrote:
> > > > Stefan also pointed out this duplicates the logic from
> > > >
> > > >         if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
> > > >                 return -EINVAL;
> > > >
> > > >
> > > > and a bunch of other places.
> > > >
> > > >
> > > > Would it be acceptable for blk layer to validate the input
> > > > instead of having each driver do it's own thing?
> > > > Maybe inside blk_queue_logical_block_size?
> > >
> > > I'm pretty sure we want down that before.  Let's just add a helper
> > > just for that check for now as part of this series.  Actually validating
> > > in in blk_queue_logical_block_size seems like a good idea, but returning
> > > errors from that has a long tail.
> >
> > Xie Yongji, I think I will revert this patch for now - can you
> > please work out adding that helper and using it in virtio?
> >
> 
> Fine, I will do it.
> 
> Thanks,
> Yongji

Great, thanks! And while at it, pls research a bit more and mention
in the commit log what is the result of an illegal blk size?
Is it memory corruption? A catastrophic failure?
If it's one of these cases, then it's ok to just fail probe.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
