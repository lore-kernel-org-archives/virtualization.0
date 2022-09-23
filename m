Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C34C6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 14:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7F06400A7;
	Fri, 23 Sep 2022 14:08:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A7F06400A7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F7um3hZN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eggy__SZDqhA; Fri, 23 Sep 2022 14:08:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F46340070;
	Fri, 23 Sep 2022 14:08:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F46340070
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68A82C0033;
	Fri, 23 Sep 2022 14:08:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E784C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 14:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1074260FE4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 14:08:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1074260FE4
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=F7um3hZN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ds9zLMsYou4P
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 14:08:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F76A60FBB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F76A60FBB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 14:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663942094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBYIB5Hr/s79C5MbXbGY0mfsUxmhEdiC6zxTkuGSCwk=;
 b=F7um3hZNu1Z/lZB5XM8C8kVxBB01ZDalTE6cB+kZIVc1d63TJyrrZjmaQJg+IUIQenkxv3
 7zqywYqFeZF6hTvGItB8+jweRDBrUgLXG2oUDAd65eEghbpLhzJLg4w39xcA9BtnLu0N3T
 ZS+6x8ERGi21zT+visWGtJjWiCDSZ+Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-216-eWW3oCDBPtK5RD-1DibcOw-1; Fri, 23 Sep 2022 10:08:13 -0400
X-MC-Unique: eWW3oCDBPtK5RD-1DibcOw-1
Received: by mail-qt1-f200.google.com with SMTP id
 fv21-20020a05622a4a1500b0035cc9b4fc20so30883qtb.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 07:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=LBYIB5Hr/s79C5MbXbGY0mfsUxmhEdiC6zxTkuGSCwk=;
 b=w4IrA/Afz/2sXdu0TLrP1YlVPqPQzxza5bYe8bvYT4BHY9BXGuuj/0BwMYdGhzsxow
 AfGX8338CwRDa6Egfj1KpPofEH6QCN1LKhnbkuwIF+LZkRjPB6MR4PYDk2uD14DYf7/h
 pOE+TNQkdtrxCyShxoxiCpPHpoCbYULhCpRIeKcj5UISpDzMIqprGFcyjiJBMR8geIif
 /GsKX6H4hmg5+p7VQlEpB2h6cbdUGsly5YNDUQcSC8DE7ouITbyM0o0xpBQ4/q55X2p0
 U+/D2DY3ThV+Y1uY3laqtkoSMUxgcGo6UrlFqvJhZAtDFCdXDXW/yIiISIzTcYfMa0Lv
 kTqg==
X-Gm-Message-State: ACrzQf3sYxv6R1gvoLxJ0mixJ5gPsf71+FKKixgQQ+5mgIDi9lKfRJdr
 dYEVTGqfvHV2uV0sUy/E9huGackZrOdFKM6wTfLi4psBz/uvqnANV5NCa4G/Rw1lFS8yMEMW4ym
 AdprcE2DmFXT7l6skdNhuAqYfzJx81FZdTZxyEZOx
X-Received: by 2002:ac8:5dc9:0:b0:35c:dac8:a141 with SMTP id
 e9-20020ac85dc9000000b0035cdac8a141mr7271317qtx.229.1663942093309; 
 Fri, 23 Sep 2022 07:08:13 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4hP35ZcbFzjjav7W2Ml66N3dqlsgPCpf9kKzESU216uoZsCAsOatn0mJ4gZX5U/fSihe9dkw==
X-Received: by 2002:ac8:5dc9:0:b0:35c:dac8:a141 with SMTP id
 e9-20020ac85dc9000000b0035cdac8a141mr7271263qtx.229.1663942092916; 
 Fri, 23 Sep 2022 07:08:12 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net.
 [68.160.173.162]) by smtp.gmail.com with ESMTPSA id
 cq3-20020a05622a424300b0035ced0a8382sm5566028qtb.54.2022.09.23.07.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Sep 2022 07:08:12 -0700 (PDT)
Date: Fri, 23 Sep 2022 10:08:11 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Message-ID: <Yy29y/jUvWM6GRZ5@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora>
 <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
 <Yylvvm3zVgqpqDrm@infradead.org>
 <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
 <YymkSDsFVVg1nbDP@infradead.org>
 <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
 <Yy1zkMH0f9ski4Sg@infradead.org>
MIME-Version: 1.0
In-Reply-To: <Yy1zkMH0f9ski4Sg@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Gwendal Grignou <gwendal@google.com>,
 Theodore Ts'o <tytso@mit.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>, Daniil Lunev <dlunev@google.com>,
 Sarthak Kukreti <sarthakkukreti@chromium.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-ext4@vger.kernel.org,
 Evan Green <evgreen@google.com>, Alasdair Kergon <agk@redhat.com>
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

On Fri, Sep 23 2022 at  4:51P -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Sep 21, 2022 at 07:48:50AM +1000, Daniil Lunev wrote:
> > > There is no such thing as WRITE UNAVAILABLE in NVMe.
> > Apologize, that is WRITE UNCORRECTABLE. Chapter 3.2.7 of
> > NVM Express NVM Command Set Specification 1.0b
> 
> Write uncorrectable is a very different thing, and the equivalent of the
> horribly misnamed SCSI WRITE LONG COMMAND.  It injects an unrecoverable
> error, and does not provision anything.
> 
> > * Each application is potentially allowed to consume the entirety
> >   of the disk space - there is no strict size limit for application
> > * Applications need to pre-allocate space sometime, for which
> >   they use fallocate. Once the operation succeeded, the application
> >   assumed the space is guaranteed to be there for it.
> > * Since filesystems on the volumes are independent, filesystem
> >   level enforcement of size constraints is impossible and the only
> >   common level is the thin pool, thus, each fallocate has to find its
> >   representation in thin pool one way or another - otherwise you
> >   may end up in the situation, where FS thinks it has allocated space
> >   but when it tries to actually write it, the thin pool is already
> >   exhausted.
> > * Hole-Punching fallocate will not reach the thin pool, so the only
> >   solution presently is zero-writing pre-allocate.
> 
> To me it sounds like you want a non-thin pool in dm-thin and/or
> guaranted space reservations for it.

What is implemented in this patchset: enablement for dm-thinp to
actually provide guarantees which fallocate requires.

Seems you're getting hung up on the finishing details in HW (details
which are _not_ the point of this patchset).

The proposed changes are in service to _Linux_ code. The patchset
implements the primitive from top (ext4) to bottom (dm-thinp, loop).
It stops short of implementing handling everywhere that'd need it
(e.g. in XFS, etc). But those changes can come as follow-on work once
the primitive is established top to bottom.

But you know all this ;)

> > * Thus, a provisioning block operation allows an interface specific
> >   operation that guarantees the presence of the block in the
> >   mapped space. LVM Thin-pool itself is the primary target for our
> >   use case but the argument is that this operation maps well to
> >   other interfaces which allow thinly provisioned units.
> 
> I think where you are trying to go here is badly mistaken.  With flash
> (or hard drive SMR) there is no such thing as provisioning LBAs.  Every
> write is out of place, and a one time space allocation does not help
> you at all.  So fundamentally what you try to here just goes against
> the actual physics of modern storage media.  While there are some
> layers that keep up a pretence, trying to that an an exposed API
> level is a really bad idea.

This doesn't need to be so feudal.  Reserving an LBA in physical HW
really isn't the point.

Fact remains: an operation that ensures space is actually reserved via
fallocate is long overdue (just because an FS did its job doesn't mean
underlying layers reflect that). And certainly useful, even if "only"
benefiting dm-thinp and the loop driver. Like other block primitives,
REQ_OP_PROVISION is filtered out by block core if the device doesn't
support it.

That said, I agree with Brian Foster that we need really solid
documentation and justification for why fallocate mode=0 cannot be
used (but the case has been made in this thread).

Also, I do see an issue with the implementation (relative to stacked
devices): dm_table_supports_provision() is too myopic about DM. It
needs to go a step further and verify that some layer in the stack
actually services REQ_OP_PROVISION. Will respond to DM patch too.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
