Return-Path: <SRS0=LFKT=KT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDDBC2B9F8
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 16:26:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D42261403
	for <virtualization@archiver.kernel.org>; Mon, 24 May 2021 16:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D42261403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5266440268;
	Mon, 24 May 2021 16:26:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YdRN3_qu57wT; Mon, 24 May 2021 16:26:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE9774023E;
	Mon, 24 May 2021 16:26:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C62BEC000D;
	Mon, 24 May 2021 16:26:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BBB0C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 16:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A88F60631
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 16:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2kshkpRlI67m
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 16:26:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 886B860622
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 16:26:03 +0000 (UTC)
Received: by mail-vk1-xa2b.google.com with SMTP id v7so307985vkf.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SP2BZdKlThSu6kHqkbL0f8O39z75p93t1CFSSb6kP6A=;
 b=AMwhxlfvIPT1+cn4mQwMmez18R53eNYMW3kdqz/2K5bTXja+CsDaiMHjH87B9vs63T
 vKcqORytD70hSj5y2ACajmqJVgY//3TpVjprFsek6Rl8xt+Qn5T63rZvuqH9j1UnEgZJ
 74TBP8KAQY3Km93Wi1us0ke7foZFeFkMY4skhhC+LOBI2T7NBg6ZP4UMR9k8AyhbvkhU
 YzjV50TNAJMHjPL/4PDR6iadZrMPBjQrkNNxwdJMDoW9tBXcgY0WvgA48SavEVckIlfE
 qAOaRvRfDBx9m0MQhdu4XfDwWZecalIlcHWHEdQr97WEOYPgSWN66mMU3bdT0y1nP46m
 hjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SP2BZdKlThSu6kHqkbL0f8O39z75p93t1CFSSb6kP6A=;
 b=sZcqJGUsRFxHvMKG5z48aflJHOZxhMu4V+Htc7YgVUaPScbpgovQjRJGIueBWwEohQ
 2eKufyL9Gxn4wtz5wUoCSbWsbocVQIOKnG81diKp88HSIg2r5OQlYDOAFVJt1Bpj3Jx4
 d6sHgsEA+0hcfEGdNJ0/I1HSCBm2QptjGiLzI2Zs1MITqm3HrrQuwfGmpFQZSQ6Ls2UZ
 0kMALmoIcVv7zcses+J1y+Mya/ew21oJkqreQ3QDCZcuAD/7rdQDzaZOG1fVj2k4bEun
 tC29Y6YNRyA97GeM8/LHx1A5YSC+TvhHC1DhKc2BNsDvSxDAKgL/ZA5RyYVnf6KhwtEb
 tnXA==
X-Gm-Message-State: AOAM532JV7cl2LCdSU6p0AgcIeo6R4WY9hMKTyXhkow0KBbMpCgZKfho
 D1GBrNJkJYgSxmcwmUIrNZRHVvoI2d2RJjM/Odo0IQ==
X-Google-Smtp-Source: ABdhPJwsNXBFGmRL6Qdv650SNJwagPUuG24dNMJGtpBJZ+17nxPEg4Pylgky7K5gV81D6DSkM24pcShGa9M1j9LcCzI=
X-Received: by 2002:a1f:9542:: with SMTP id x63mr22199896vkd.15.1621873562173; 
 Mon, 24 May 2021 09:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210520133908.98891-1-damtev@yandex-team.ru>
 <20210520133908.98891-2-damtev@yandex-team.ru>
 <YKu4Qovv1KMplifY@stefanha-x1.localdomain> <20210524145654.GA2632@lst.de>
In-Reply-To: <20210524145654.GA2632@lst.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 May 2021 18:25:24 +0200
Message-ID: <CAPDyKFpHeiyLxU1H_gZuxivkiZCKhZ_igsbx_TxSWzUhyaEufQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] virtio: disable partitions scanning for no partitions
 block
To: Christoph Hellwig <hch@lst.de>
Cc: Yury Kamenev <damtev@yandex-team.ru>, Jens Axboe <axboe@kernel.dk>,
 mst@redhat.com, linux-mmc <linux-mmc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 linux-block <linux-block@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 Lauri Kasanen <cand@gmx.com>
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

On Mon, 24 May 2021 at 16:57, Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, May 24, 2021 at 03:29:22PM +0100, Stefan Hajnoczi wrote:
> > GENHD_FL_NO_PART_SCAN is not used much in other drivers. This makes me
> > wonder if the same use case is addressed through other means with SCSI,
> > NVMe, etc devices. Maybe Christoph or Jens can weigh in on whether
> > adding a bit to disable partition scanning for a virtio-blk fits into
> > the big picture?
> >
> > Is your goal to avoid accidentally detecting partitions because it's
> > confusing when that happens?
>
> I'm really confused what the use case is here.  GENHD_FL_NO_PART_SCAN
> has four users:
>
>  - the block core setting it for hidden devices, for which the concept
>    of paritions doesn't make sense.  Looking back this should have never
>    used GENHD_FL_NO_PART_SCAN, and instead the partition scanning code
>    should just check GENHD_FL_HIDDEN as well.
>  - mmc uses it for boot partitions and rpmb.  I'm not even sure how
>    these can be exposed as block devices as they don't require block
>    granularity access IIRC, but if the allow block layer access there
>    is no reason to ever set these flags.

For RPMB, we have converted them into char devices, thus
GENHD_FL_NO_PART_SCAN is never set for them. The code needs a cleanup
to clarify this.

When it comes to eMMC boot partitions, those can be read/written to as
any other block device. Although, it's unlikely that they need
partitions as they are usually very small, 512Kb or 2MB in that
ballpark. At least, that was the thinking behind it when we added
GENHD_FL_NO_PART_SCAN for them.

If you want to drop GENHD_FL_NO_PART_SCAN for eMMC boot partitions, I
don't think it will be an issue.

>  - loop is a bit of a mess.  IIRC the story is that originally the
>    loop device did not support partitions, then in 2008 support for
>    partitions was added by partitioning the minor number space, and
>    then in 2011 support for partitions without that parameter was
>    added using a new flag in the loop device creation ioctl that uses
>    the extended dev_t space added since.  But even that might be
>    something we can handled without that flag without breaking the
>    userspace ABI
>  - m64card sets it for no good reason at all
>
> In other words: in a perfect would GENHD_FL_NO_PART_SCAN would not
> exist, and it certainly should not be added to a new driver, never
> mind a protocol.
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

Kind regards
Uffe
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
