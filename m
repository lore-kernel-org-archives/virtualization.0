Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E162C6FA82
	for <virtualization@archiver.kernel.org>; Fri, 23 Sep 2022 08:51:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B436460B03;
	Fri, 23 Sep 2022 08:51:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B436460B03
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tvJph7Rg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k-jnMJpQ3gRA; Fri, 23 Sep 2022 08:51:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2FACC6061B;
	Fri, 23 Sep 2022 08:51:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2FACC6061B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E61CCC0033;
	Fri, 23 Sep 2022 08:51:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3FBAC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 08:51:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C22860B03
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 08:51:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C22860B03
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IDuEd_L5ISQZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 08:51:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF1566061B
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF1566061B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Sep 2022 08:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Mwd96PDyTOevoURdRNm22AhUb71BkD8a02+bd0y+kQ4=; b=tvJph7RgQD7CLZKEaP7wd20+HA
 yzg1Rpk81YuhnLGg0IxkLW71EYP4wW4RxMvkX1baGgdCA+zsyv0wxDyVeWCGkfoxAJ7O7djHLJL5s
 9oyGI4jpbsPbsfAD/1s8vHAosC6rt8/vPRZu2pj25Fmrmqh51GANFZB4FeikHq9qZh6sMuW3RgTI4
 exZH9/upSkiDA3aEr3SXAM5NCGcRAgvOsRUHqBv2zAk5GnhfvqK/Wecjncu/UIVciVJhjnOmG9gGy
 zr79D+RgDhz/xCk1Amx7X6rjhAl+hOr6g3q+F+AJq0AHJkiqr7j9ytA+QPCRAVyI+5CA3uxYY9gIv
 71si1rdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1obePA-0033p5-F8; Fri, 23 Sep 2022 08:51:28 +0000
Date: Fri, 23 Sep 2022 01:51:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniil Lunev <dlunev@google.com>
Subject: Re: [PATCH RFC 0/8] Introduce provisioning primitives for thinly
 provisioned storage
Message-ID: <Yy1zkMH0f9ski4Sg@infradead.org>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <YyQTM5PRT2o/GDwy@fedora>
 <CAG9=OMPHZqdDhX=M+ovdg5fa3x4-Q_1r5SWPa8pMTQw0mr5fPg@mail.gmail.com>
 <Yylvvm3zVgqpqDrm@infradead.org>
 <CAAKderPF5Z5QLxyEb80Y+90+eR0sfRmL-WfgXLp=eL=HxWSZ9g@mail.gmail.com>
 <YymkSDsFVVg1nbDP@infradead.org>
 <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAKderNcHpbBqWqqd5-WuKLRCQQUt7a_4D4ti4gy15+fKGK0vQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Sarthak Kukreti <sarthakkukreti@chromium.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>,
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

On Wed, Sep 21, 2022 at 07:48:50AM +1000, Daniil Lunev wrote:
> > There is no such thing as WRITE UNAVAILABLE in NVMe.
> Apologize, that is WRITE UNCORRECTABLE. Chapter 3.2.7 of
> NVM Express NVM Command Set Specification 1.0b

Write uncorrectable is a very different thing, and the equivalent of the
horribly misnamed SCSI WRITE LONG COMMAND.  It injects an unrecoverable
error, and does not provision anything.

> * Each application is potentially allowed to consume the entirety
>   of the disk space - there is no strict size limit for application
> * Applications need to pre-allocate space sometime, for which
>   they use fallocate. Once the operation succeeded, the application
>   assumed the space is guaranteed to be there for it.
> * Since filesystems on the volumes are independent, filesystem
>   level enforcement of size constraints is impossible and the only
>   common level is the thin pool, thus, each fallocate has to find its
>   representation in thin pool one way or another - otherwise you
>   may end up in the situation, where FS thinks it has allocated space
>   but when it tries to actually write it, the thin pool is already
>   exhausted.
> * Hole-Punching fallocate will not reach the thin pool, so the only
>   solution presently is zero-writing pre-allocate.

To me it sounds like you want a non-thin pool in dm-thin and/or
guaranted space reservations for it.

> * Thus, a provisioning block operation allows an interface specific
>   operation that guarantees the presence of the block in the
>   mapped space. LVM Thin-pool itself is the primary target for our
>   use case but the argument is that this operation maps well to
>   other interfaces which allow thinly provisioned units.

I think where you are trying to go here is badly mistaken.  With flash
(or hard drive SMR) there is no such thing as provisioning LBAs.  Every
write is out of place, and a one time space allocation does not help
you at all.  So fundamentally what you try to here just goes against
the actual physics of modern storage media.  While there are some
layers that keep up a pretence, trying to that an an exposed API
level is a really bad idea.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
