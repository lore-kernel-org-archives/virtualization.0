Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD576C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:21:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B31610F8
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 12:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86B31610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4FF78407C6;
	Wed, 13 Oct 2021 12:21:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DLnlYGtwbDoz; Wed, 13 Oct 2021 12:21:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EDD21407B9;
	Wed, 13 Oct 2021 12:21:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4F3DC000F;
	Wed, 13 Oct 2021 12:21:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A80AAC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:21:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 958E5404D1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:21:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H5LYl2p1vDWY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:21:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AB09A40151
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 12:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634127693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aI/a1CuIplLBzfM7K3SKE+P3jJtMmkhDmL35+rhqKP0=;
 b=C4LauQ+o9aqPqS48sQDqIGOFb3fS8HOAbMFB29oMK8POZgiuOaYWLRuebzXGiGK8AmR/XG
 AuWoBsNVLkljQaCkEAVHvBG4Gm0snKVtKB7fKY6RKopb4UC3dqsYCW47oNIg++IY9rYAzC
 ybbeuJnS8h8TdT7821V4Iz7rA8q863M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-8K-3-r7VPqeJp4X7K2pArA-1; Wed, 13 Oct 2021 08:21:32 -0400
X-MC-Unique: 8K-3-r7VPqeJp4X7K2pArA-1
Received: by mail-wr1-f71.google.com with SMTP id
 75-20020adf82d1000000b00160cbb0f800so1798593wrc.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 05:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aI/a1CuIplLBzfM7K3SKE+P3jJtMmkhDmL35+rhqKP0=;
 b=JqK/ufWS4sPd7/CeKiVwwkRmWQL+p0iVYyueRQL7P6M4uMthS0GexfRTxTlVr1s+80
 pcZudQpXo8V3THnXd3wkfjmxEeyD//ZpO4gCmjOh6Ay4gGbcjcf+u/JrgQIbbxv7nJXr
 YRMZC/8/TAlGjqgJmjyZh+rliuMUzW681A6CeAbGxzxHwOPbEJrH08f3qKkjrsN2xFnA
 8WYIwZykNn0oBCXauuEg1X8KH+wP5WvvPBqiLt/TqRmg6osG7b1L2Yquo2PA65EZznbf
 Z6LIstCUrek7ZXOygb5rG23EKt3sHGklTgtXzYxHM0D391tX72bj7bmQdN8VEM/rfsqx
 ezGA==
X-Gm-Message-State: AOAM531GRivCT+kf5kkQqb7iqDhDUyouNeqLhNIVk6GPe8jR6dIPOzkj
 VFCFopHuNC76ubL2Y+CWQpqa4LoUjJVTIkwOr913rABgEMxKUBFeMKlRISRuhD2lyc3u3Dcvnpa
 mxuuPv6kqCPs+HUcz+LF+4u33+zj9QQQK2kWu5VLrIg==
X-Received: by 2002:adf:a390:: with SMTP id l16mr39148255wrb.291.1634127691192; 
 Wed, 13 Oct 2021 05:21:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTkyD1UVKzRrFV61FHdBE4Y7buV45IeIqTmyybPN8AIOWvYr+YRHziMwJhfqqGLO65loliiQ==
X-Received: by 2002:adf:a390:: with SMTP id l16mr39148230wrb.291.1634127690995; 
 Wed, 13 Oct 2021 05:21:30 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id q14sm5174087wmq.4.2021.10.13.05.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 05:21:30 -0700 (PDT)
Date: Wed, 13 Oct 2021 08:21:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20211013082025-mutt-send-email-mst@kernel.org>
References: <20210809101609.148-1-xieyongji@bytedance.com>
 <20211004112623-mutt-send-email-mst@kernel.org>
 <20211005062359-mutt-send-email-mst@kernel.org>
 <20211011114041.GB16138@lst.de>
MIME-Version: 1.0
In-Reply-To: <20211011114041.GB16138@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com
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

On Mon, Oct 11, 2021 at 01:40:41PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 05, 2021 at 06:42:43AM -0400, Michael S. Tsirkin wrote:
> > Stefan also pointed out this duplicates the logic from 
> > 
> >         if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
> >                 return -EINVAL;
> > 
> > 
> > and a bunch of other places.
> > 
> > 
> > Would it be acceptable for blk layer to validate the input
> > instead of having each driver do it's own thing?
> > Maybe inside blk_queue_logical_block_size?
> 
> I'm pretty sure we want down that before.  Let's just add a helper
> just for that check for now as part of this series.  Actually validating
> in in blk_queue_logical_block_size seems like a good idea, but returning
> errors from that has a long tail.

Xie Yongji, I think I will revert this patch for now - can you
please work out adding that helper and using it in virtio?

Thanks,

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
