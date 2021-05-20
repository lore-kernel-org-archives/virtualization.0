Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A7FC43460
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 05:43:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820A7610A8
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 05:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820A7610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DDC74061C;
	Thu, 20 May 2021 05:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qK-A8lUAdpgw; Thu, 20 May 2021 05:43:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8053640611;
	Thu, 20 May 2021 05:43:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53AB1C000E;
	Thu, 20 May 2021 05:43:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C4E9C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 05:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 10F6140187
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 05:43:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UAxFvkxRV0ek
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 05:43:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 442B540159
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 05:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621489413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GjW4Njna3bnKmMjSqk9By1QrG7BREpE+oMFazMCyiuc=;
 b=RRL8DDhaYPVgtloo0xdB9F+BwAiHuFpShr+4nTgLXyodQoMbecFPVCmHErHlgY8lGBpoFw
 lQ9X9zZGlghDbTj+k0q7TaoY+Z+A1PqdOhBsd8BCcXvRmTp6DBG7EIMICc8EbVTvEa5D9y
 RZb/Ra/NsF+RicdPJ23beF6Mlg0MuAQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-YqRPqWBYNVm2m3FtySSMAA-1; Thu, 20 May 2021 01:43:31 -0400
X-MC-Unique: YqRPqWBYNVm2m3FtySSMAA-1
Received: by mail-wr1-f72.google.com with SMTP id
 67-20020adf81490000b029010756d109e6so8126217wrm.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 May 2021 22:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GjW4Njna3bnKmMjSqk9By1QrG7BREpE+oMFazMCyiuc=;
 b=bjSj8PsZRkhLux9xlv0JSRi8VltU2cQ3wkMcvPdHJ8+Fx7zzWNdTJUqPJqherCJysX
 qNauRlrIllRPQAxyXXy0xUO74lqC1slmhlYTcg3Qx9CCiGsgp4TcNETnX5LcOkRKnNlB
 oKgl9Y+j8uhtqpuuCxkF3Vwkw4tJYJ8vjs4cNiulgnc1yDft0O8EeqWvF016UJZkJguj
 Kyfe81BbHu4d/Acog5PFSCQIzHsUv6QkywLp1utcpDWcqFAQurIPuKvG91SmiS/IuY5X
 MNQFQoXjXy45joiFZU9+xcdYx7mUPFhizzUdaDCZ66dwFH4j58h22XHdRxjTdeS5sF/8
 jikg==
X-Gm-Message-State: AOAM532ThfmflAQsRUQtotRhQesF16eFKTBW5KwRhhlIuRKTx21wvxy8
 gyqAjsSxrj2VrTjXQ5lphH1nMzKyoo6vWz9u53lJ58XUlvPPER/5aX/Es9lInh7DNW693A/8mYh
 h45FfMngOVD20FAlc1iI0EnRRwRFSIyLNlGukBjh3mw==
X-Received: by 2002:a5d:524b:: with SMTP id k11mr2308317wrc.292.1621489410103; 
 Wed, 19 May 2021 22:43:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPmuJaJcBIzoz51cJHFKBEGSMwRicV/EJnxc2pubykB7VVTdZU5S/RsC7BPoTegDy8gNdFLQ==
X-Received: by 2002:a5d:524b:: with SMTP id k11mr2308281wrc.292.1621489409886; 
 Wed, 19 May 2021 22:43:29 -0700 (PDT)
Received: from redhat.com (bzq-79-181-160-222.red.bezeqint.net.
 [79.181.160.222])
 by smtp.gmail.com with ESMTPSA id t16sm1717230wrb.66.2021.05.19.22.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 22:43:29 -0700 (PDT)
Date: Thu, 20 May 2021 01:43:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: Re: [PATCH v7 04/12] virtio-blk: Add validation for block size
 in config space
Message-ID: <20210520013921-mutt-send-email-mst@kernel.org>
References: <20210517095513.850-1-xieyongji@bytedance.com>
 <20210517095513.850-5-xieyongji@bytedance.com>
 <CACycT3s1rEvNnNkJKQsHGRsyLPADieFdVkb1Sp3GObR0Vox5Fg@mail.gmail.com>
 <20210519144206.GF32682@kadam>
 <CACycT3veubBFCg9omxLDJJFP7B7QH8++Q+tKmb_M_hmNS45cmw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3veubBFCg9omxLDJJFP7B7QH8++Q+tKmb_M_hmNS45cmw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel <linux-kernel@vger.kernel.org>,
 kvm <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 iommu@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, joro@8bytes.org,
 Dan Carpenter <dan.carpenter@oracle.com>
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

On Thu, May 20, 2021 at 01:25:16PM +0800, Yongji Xie wrote:
> On Wed, May 19, 2021 at 10:42 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Wed, May 19, 2021 at 09:39:20PM +0800, Yongji Xie wrote:
> > > On Mon, May 17, 2021 at 5:56 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> > > >
> > > > This ensures that we will not use an invalid block size
> > > > in config space (might come from an untrusted device).
> >
> > I looked at if I should add this as an untrusted function so that Smatch
> > could find these sorts of bugs but this is reading data from the host so
> > there has to be some level of trust...
> >
> 
> It would be great if Smatch could detect this case if possible. The
> data might be trusted in traditional VM cases. But now the data can be
> read from a userspace daemon when VDUSE is enabled.
> 
> > I should add some more untrusted data kvm functions to Smatch.  Right
> > now I only have kvm_register_read() and I've added kvm_read_guest_virt()
> > just now.
> >
> > > >
> > > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > > ---
> > > >  drivers/block/virtio_blk.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > > index ebb4d3fe803f..c848aa36d49b 100644
> > > > --- a/drivers/block/virtio_blk.c
> > > > +++ b/drivers/block/virtio_blk.c
> > > > @@ -826,7 +826,7 @@ static int virtblk_probe(struct virtio_device *vdev)
> > > >         err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> > > >                                    struct virtio_blk_config, blk_size,
> > > >                                    &blk_size);
> > > > -       if (!err)
> > > > +       if (!err && blk_size > 0 && blk_size <= max_size)
> > >
> > > The check here is incorrect. I will use PAGE_SIZE as the maximum
> > > boundary in the new version.
> >
> > What does this bug look like to the user?
> 
> The kernel will panic if the block size is larger than PAGE_SIZE.

Kernel panic at this point is par for the course IMHO.
Let's focus on eliminating data corruption for starters.

> > A minimum block size of 1 seems pretty crazy.  Surely the minimum should be > higher?
> >
> 
> Yes, 512 is better here.
> 
> Thanks,
> Yongji

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
