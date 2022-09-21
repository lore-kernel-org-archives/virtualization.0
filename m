Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B589C6FA82
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 15:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A31E416E7;
	Wed, 21 Sep 2022 15:39:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A31E416E7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZkcvuyuK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uDPvZG56BX63; Wed, 21 Sep 2022 15:39:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED6E9402C3;
	Wed, 21 Sep 2022 15:39:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ED6E9402C3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8958C0033;
	Wed, 21 Sep 2022 15:39:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68A22C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41843402C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:39:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41843402C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oc8szqvUkXEz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:39:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1BF0416D2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1BF0416D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663774762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qdyn6X4um0jOmxbVbIVJ/ritfQu0YXAwmpkbuktXlco=;
 b=ZkcvuyuKtZceBatTwuQsg+6//1H7l8u2DReMGM9wx4E2Q+HXIRb6aNQ8TIVolZWBLBiDoK
 hXJp5/3LFfvHtxd68v1IOlHDx6vjsXPNNFVwRtj19BdYlny/p8WSUOilpTbhMEPXUYCHD2
 3NC/uZ7xCGZSLTI3FnJfASNPDyL7ArU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-75-AxvzVXQjO56nJ5LzXGl9dQ-1; Wed, 21 Sep 2022 11:39:19 -0400
X-MC-Unique: AxvzVXQjO56nJ5LzXGl9dQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 c1-20020a0cfb01000000b00495ad218c74so4575369qvp.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=qdyn6X4um0jOmxbVbIVJ/ritfQu0YXAwmpkbuktXlco=;
 b=Jqnt0IKFstPPOdUg/oB4B4k2B38bM+LjWf+TtVUOovvUwQa4BLPeHQo35FCpDEmEsv
 B21bgRWzvvU3VXxSup8N+Hdtt2bNxL9vVqfKL+xVisb6rHbd6wzQoEezE4zTIgkDwZyC
 IWQ9MvUZxgnWm3RFMxW7pmscgRLMnNQIXXB/1/dlm00oCjYw2lumwQgu8hZ8gDixbrzw
 z0mfs6hC1R4vqod1zki7RITghcfPiVEEFIOWpsT//H2g6yGi5whap7M/b/klpS9Wf2DC
 +Qg2RUdJlGvr1osnGAxAafHOFQ8NuwQJzxm+yTVz2KGoKhLAQm4t55XMZp0Smp7P6KvB
 c7Fw==
X-Gm-Message-State: ACrzQf2afrihbOLopjTtNTiX3WGjVcU3PcgKHlEGrQzhzborbC9NhuJ5
 wBwrHhPX8F1x6SviztIy5qk3GeIyFSuMWcQd5P2KRKTTdGAUWd+9VMeLm8EYyt8M3qvtilSp3JQ
 5agnwkxQNwmpvAqc9lii2WoJNZdLzZO64NPYhrAw+6A==
X-Received: by 2002:ac8:5a13:0:b0:35c:e9b0:430b with SMTP id
 n19-20020ac85a13000000b0035ce9b0430bmr13368708qta.472.1663774758897; 
 Wed, 21 Sep 2022 08:39:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM594zwhYYo497Gbf01p/qkC0k5EzOtGiVtB6LsJU02syDsCgiXnnQXhpz8ER02eO+Lp+Qd8CQ==
X-Received: by 2002:ac8:5a13:0:b0:35c:e9b0:430b with SMTP id
 n19-20020ac85a13000000b0035ce9b0430bmr13368681qta.472.1663774758598; 
 Wed, 21 Sep 2022 08:39:18 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
 by smtp.gmail.com with ESMTPSA id
 f25-20020ac84659000000b0035ccd148026sm1791612qto.69.2022.09.21.08.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Sep 2022 08:39:18 -0700 (PDT)
Date: Wed, 21 Sep 2022 11:39:15 -0400
From: Brian Foster <bfoster@redhat.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <YyswI57JH7gcs9+S@bfoster>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com>
 <YyRkd8YAH1lal8/N@bfoster>
 <CAG9=OMNL1Z3DiO-usdH0k90NDsDkDQ7A7CHc4Nu6MCXKNKjWdw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAG9=OMNL1Z3DiO-usdH0k90NDsDkDQ7A7CHc4Nu6MCXKNKjWdw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Gwendal Grignou <gwendal@google.com>,
 Theodore Ts'o <tytso@mit.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>, Daniil Lunev <dlunev@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-ext4@vger.kernel.org, Evan Green <evgreen@google.com>,
 Alasdair Kergon <agk@redhat.com>
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

On Fri, Sep 16, 2022 at 02:02:31PM -0700, Sarthak Kukreti wrote:
> On Fri, Sep 16, 2022 at 4:56 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> > > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > >
> > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > sends a hint to (supported) thinly provisioned block devices to
> > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> > >
> > > Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > > ---
> > >  block/fops.c                | 7 ++++++-
> > >  include/linux/falloc.h      | 3 ++-
> > >  include/uapi/linux/falloc.h | 8 ++++++++
> > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/block/fops.c b/block/fops.c
> > > index b90742595317..a436a7596508 100644
> > > --- a/block/fops.c
> > > +++ b/block/fops.c
> > ...
> > > @@ -661,6 +662,10 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
> > >               error = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> > >                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > >               break;
> > > +     case FALLOC_FL_PROVISION:
> > > +             error = blkdev_issue_provision(bdev, start >> SECTOR_SHIFT,
> > > +                                            len >> SECTOR_SHIFT, GFP_KERNEL);
> > > +             break;
> > >       default:
> > >               error = -EOPNOTSUPP;
> > >       }
> >
> > Hi Sarthak,
> >
> > Neat mechanism.. I played with something very similar in the past (that
> > was much more crudely hacked up to target dm-thin) to allow filesystems
> > to request a thinly provisioned device to allocate blocks and try to do
> > a better job of avoiding inactivation when overprovisioned.
> >
> > One thing I'm a little curious about here.. what's the need for a new
> > fallocate mode? On a cursory glance, the provision mode looks fairly
> > analogous to normal (mode == 0) allocation mode with the exception of
> > sending the request down to the bdev. blkdev_fallocate() already maps
> > some of the logical falloc modes (i.e. punch hole, zero range) to
> > sending write sames or discards, etc., and it doesn't currently look
> > like it supports allocation mode, so could it not map such requests to
> > the underlying REQ_OP_PROVISION op?
> >
> > I guess the difference would be at the filesystem level where we'd
> > probably need to rely on a mount option or some such to control whether
> > traditional fallocate issues provision ops (like you've implemented for
> > ext4) vs. the specific falloc command, but that seems fairly consistent
> > with historical punch hole/discard behavior too. Hm? You might want to
> > cc linux-fsdevel in future posts in any event to get some more feedback
> > on how other filesystems might want to interact with such a thing.
> >
> Thanks for the feedback!
> Argh, I completely forgot that I should add linux-fsdevel. Let me
> re-send this with linux-fsdevel cc'd
> 
> There's a slight distinction is that the current filesystem-level
> controls are usually for default handling, but userspace can still
> call the relevant functions manually if they need to. For example, for
> ext4, the 'discard' mount option dictates whether free blocks are
> discarded, but it doesn't set the policy to allow/disallow userspace
> from manually punching holes into files even if the mount opt is
> 'nodiscard'. FALLOC_FL_PROVISION is similar in that regard; it adds a
> manual mechanism for users to provision the files' extents, that is
> separate from the filesystems' default handling of provisioning files.
> 

What I'm trying to understand is why not let blkdev_fallocate() issue a
provision based on the default mode (i.e. mode == 0) of fallocate(),
which is already defined to mean "perform allocation?" It currently
issues discards or write zeroes based on variants of
FALLOC_FL_PUNCH_HOLE without the need for a separate FALLOC_FL_DISCARD
mode, for example.

Brian

> > BTW another thing that might be useful wrt to dm-thin is to support
> > FALLOC_FL_UNSHARE. I.e., it looks like the previous dm-thin patch only
> > checks that blocks are allocated, but not whether those blocks are
> > shared (re: lookup_result.shared). It might be useful to do the COW in
> > such cases if the caller passes down a REQ_UNSHARE or some such flag.
> >
> That's an interesting idea! There's a few more things on the TODO list
> for this patch series but I think we can follow up with a patch to
> handle that as well.
> 
> Sarthak
> 
> > Brian
> >
> > > diff --git a/include/linux/falloc.h b/include/linux/falloc.h
> > > index f3f0b97b1675..a0e506255b20 100644
> > > --- a/include/linux/falloc.h
> > > +++ b/include/linux/falloc.h
> > > @@ -30,7 +30,8 @@ struct space_resv {
> > >                                        FALLOC_FL_COLLAPSE_RANGE |     \
> > >                                        FALLOC_FL_ZERO_RANGE |         \
> > >                                        FALLOC_FL_INSERT_RANGE |       \
> > > -                                      FALLOC_FL_UNSHARE_RANGE)
> > > +                                      FALLOC_FL_UNSHARE_RANGE |                          \
> > > +                                      FALLOC_FL_PROVISION)
> > >
> > >  /* on ia32 l_start is on a 32-bit boundary */
> > >  #if defined(CONFIG_X86_64)
> > > diff --git a/include/uapi/linux/falloc.h b/include/uapi/linux/falloc.h
> > > index 51398fa57f6c..2d323d113eed 100644
> > > --- a/include/uapi/linux/falloc.h
> > > +++ b/include/uapi/linux/falloc.h
> > > @@ -77,4 +77,12 @@
> > >   */
> > >  #define FALLOC_FL_UNSHARE_RANGE              0x40
> > >
> > > +/*
> > > + * FALLOC_FL_PROVISION acts as a hint for thinly provisioned devices to allocate
> > > + * blocks for the range/EOF.
> > > + *
> > > + * FALLOC_FL_PROVISION can only be used with allocate-mode fallocate.
> > > + */
> > > +#define FALLOC_FL_PROVISION          0x80
> > > +
> > >  #endif /* _UAPI_FALLOC_H_ */
> > > --
> > > 2.31.0
> > >
> >
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
