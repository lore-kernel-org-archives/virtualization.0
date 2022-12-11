Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1D6C4332F
	for <virtualization@archiver.kernel.org>; Sun, 11 Dec 2022 09:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DB9F40895;
	Sun, 11 Dec 2022 09:50:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9DB9F40895
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=PwZx72Ao
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wc3bqoRiBKCx; Sun, 11 Dec 2022 09:50:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D0CFC4087E;
	Sun, 11 Dec 2022 09:50:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0CFC4087E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B398C0032;
	Sun, 11 Dec 2022 09:50:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAA63C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Dec 2022 09:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 986AF81361
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Dec 2022 09:50:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 986AF81361
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=PwZx72Ao
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pNN2epVyenpM
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Dec 2022 09:50:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F05E781303
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F05E781303
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Dec 2022 09:50:21 +0000 (UTC)
Received: by mail-pf1-x430.google.com with SMTP id 65so6615925pfx.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 11 Dec 2022 01:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rh5QAklyd4AeYLHpArFINipp6iRCr8KKOQb7s6HGEMI=;
 b=PwZx72Aog3dMWak7X5RfDIKA0Stm9ImI03XPRB3S+OK2Lm094+5ABxaYH5mTN8ITc5
 0rkuCCeyg+P343biweU0dezATwKnk2bf1Z+2szM1asbufJO42JA5QLrD/7aW9moqEqh1
 J8psuIuFAqWpMvxZIs79Q5sQiBBP/MLRsufX+9mzb/85TVQSqLZs1m4jJbBw41PYdH63
 2sAISKQPJzZZyY6Vv26dVFhpDeoTf+OEEynL63DSXBk5gW0MhoguPc2C5t+d4r807v6d
 IZ8NDA6N6jz3XX613ndUDLeixIu12Z39o4LwE/lGUddlhukJ+k/leJpkPDBVdVgyvLVN
 LTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rh5QAklyd4AeYLHpArFINipp6iRCr8KKOQb7s6HGEMI=;
 b=hp77tUL4IO0tBo4lHtOt684il2cBMEeqLdbUJWkylnSMmcRXJwTspwjDKfu8INnjMp
 JXDzHgMiVyIN74GrEGlsfJdSjHFh+K4f2sQUJ2Lg5z3n/k9H7UWNyndrG+aOCsdWi1uc
 hVPea8gNFbMpjnAqcZZ60g8B13dSNNYfDDxIt6H3hJrVz0WvJThPXOyAR9D+67cpfEg+
 hcEWYTy67AOdwExcIYUWk04/xm2jaUIw9vuKp5GyB+09qLpyqlLnwQIAx3eyBNPRqBYO
 hA56IQYHp1Nd8OvpPW34/P7apz+7FpXZ4kURqoN14MLji8MXqvxB8IZcTW9I0ghs6uiu
 uJpA==
X-Gm-Message-State: ANoB5pnPbFmL2OvDf6OLw0Y6xuAj9mKO1LisS/IQzQE6SDTaNreOLfrZ
 RwYT4R5mqKnK003wONiJuLTjwLcCtrWdWaZ5hms4VA==
X-Google-Smtp-Source: AA0mqf6sTgZzExROP+3AcD990q4QofPnx+7w4Ve/p3V7twkuqcE/V+srS9ihCucVMYKxVIFQ4amS8gQqv9Gu8amMX4A=
X-Received: by 2002:a63:2226:0:b0:478:54e2:ecb1 with SMTP id
 i38-20020a632226000000b0047854e2ecb1mr37001807pgi.550.1670752221276; Sun, 11
 Dec 2022 01:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org>
 <20221207052001-mutt-send-email-mst@kernel.org>
 <Y5C/4H7Ettg/DcRz@infradead.org>
 <20221207152116-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221207152116-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 11 Dec 2022 11:49:44 +0200
Message-ID: <CAJs=3_Bu+tZqQk3JDzP0JfNbPZ8FG7mRNnPE9RrWUs8VOF=FzQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

> Alvaro could you pls explain the use-case? Christoph has doubts that
> it's useful. Do you have a device implementing this?

Our HW exposes virtio devices, virtio block included.
The block device backend can be a eMMC/uSD card.

The HW can report health values (power, temp, current, voltage) and I
thought that it would be nice to be able to report lifetime values as
well.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
