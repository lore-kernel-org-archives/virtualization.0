Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B379CC00140
	for <virtualization@archiver.kernel.org>; Wed, 24 Aug 2022 06:46:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2C34E409FE;
	Wed, 24 Aug 2022 06:46:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C34E409FE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=eXen0nnT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nAQM6QWOFHCU; Wed, 24 Aug 2022 06:46:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 52EFB409B1;
	Wed, 24 Aug 2022 06:46:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52EFB409B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B496C0032;
	Wed, 24 Aug 2022 06:46:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D46FDC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 06:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F74F60B0C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 06:46:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F74F60B0C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=eXen0nnT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tktwp-qk_wAy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 06:46:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1CF060B6E
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1CF060B6E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Aug 2022 06:46:33 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 r14-20020a17090a4dce00b001faa76931beso619712pjl.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Aug 2022 23:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=N8S6PC84p9oZ6WkG+W7KEFfrY/x47oE/rRsUD8XU/Ic=;
 b=eXen0nnTse8Us5DYEAmJ6EVx8ciT2tlvxswD4Jvl4rxwhmqeDCLEWgptPdZQiTt7no
 YxBk67bHTHJuL86Ro6ueWHOrd9f1olGNgjV7GJZpANnC8/vqINtMHCIe0WgeHePyWHrg
 E+6tpZrS/hUfophWShLfweOJQsfQ5cre06w1tFz9tRCimXDGLZd2g16gd2xMy74cezf0
 /06kbYkmBj8o1DLuI2N/yErN451RKV/uZjNIgsHaM68wpKDSGGQbAqKO7kz2kTASWVeX
 NJun/dARL8aDwcOwqL0jrf6GwH7PXidC8Rb7AhmA3lkn/mJmzSvtniuie0wVzkNfD9n9
 nKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=N8S6PC84p9oZ6WkG+W7KEFfrY/x47oE/rRsUD8XU/Ic=;
 b=J4wF15YPUw7Yk9ZK0JRSvq0UBR/dJhva5qBv479nu4j9qx3MXx3WOt2bHZ+8sw6Vfa
 ai6sb13/Hb0jDtHBTgOjT2Rj/b6kAP/dR6DkvdTR05pWuaphEC++i5b66lK7ib3HKxl5
 B0F4gz0ywYoE1QChjRYwh0A0hJApTzleZkijI4zpA0MpQ4ptgLYcbgoh7L3T69BWy5Yg
 MDge02YVBM4/POjuaHGljJSMPbj4AWi223+JFBetNIL4CMnn6FdZltOVR4ZXHWiuzi1f
 pplyPCxt7SjNZZT04ibOw+q1e4VY6OhBpSV818IdCFhabhNCWJb0HwpLOg4/Sj2LW48k
 bHrA==
X-Gm-Message-State: ACgBeo1G/PFsgSIBvoyl1geX2D3Qrr6rxvkqoAYvrJ+ua2x2QnZ0FH+x
 GNbB4wCDlTIhY4lYTC5LrhAdLB0BEswWJ9qbQrLzLA==
X-Google-Smtp-Source: AA6agR40mySEYvaWcxfvG5cCsNTvF+1IxUB2hPZXUghnF7RvI/e6XeQfwDbg/fdPbqvNPxaUu/0VWKu1lpIcNACryLk=
X-Received: by 2002:a17:90a:4e07:b0:1fb:1253:475b with SMTP id
 n7-20020a17090a4e0700b001fb1253475bmr6913362pjh.0.1661323593291; Tue, 23 Aug
 2022 23:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220822162055.634854-1-alvaro.karsz@solid-run.com>
 <YwUueWHKi5YmQeGP@fedora>
In-Reply-To: <YwUueWHKi5YmQeGP@fedora>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 24 Aug 2022 09:45:57 +0300
Message-ID: <CAJs=3_C9Bm=zsDUXuGXnDmZEKmSYfj-44UvuuyT1_SgbSXJoYQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: add SECURE ERASE command support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

> What about max_secure_erase_seg and secure_erase_sector_alignment?

Hi Stefan,
If I understand correctly, the Linux kernel uses the same "max
segments" value for a discard and a secure erase command.

> unsigned int blk_recalc_rq_segments(struct request *rq)
> {
>     unsigned int nr_phys_segs = 0;
>     unsigned int bytes = 0;
>     struct req_iterator iter;
>     struct bio_vec bv;
>
>
>     if (!rq->bio)
>         return 0;
>
>
>     switch (bio_op(rq->bio)) {
>     case REQ_OP_DISCARD:
>     case REQ_OP_SECURE_ERASE:
>         if (queue_max_discard_segments(rq->q) > 1) {
>             struct bio *bio = rq->bio;
>
>
>             for_each_bio(bio)
>                 nr_phys_segs++;
>             return nr_phys_segs;
>         }
>
> ....


> struct bio *__bio_split_to_limits(struct bio *bio, struct queue_limits *lim,
>       unsigned int *nr_segs)
> {
>     struct bio_set *bs = &bio->bi_bdev->bd_disk->bio_split;
>     struct bio *split;
>
>
>     switch (bio_op(bio)) {
>     case REQ_OP_DISCARD:
>     case REQ_OP_SECURE_ERASE:
>         split = bio_split_discard(bio, lim, nr_segs, bs);
>
>         break;
>
> ...

What do you suggest?

BTW, the same happens for the write zeros command implementation.
max_write_zeroes_seg and write_zeroes_may_unmap are ignored in the Linux kernel.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
