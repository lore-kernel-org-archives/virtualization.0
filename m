Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3942DC32771
	for <virtualization@archiver.kernel.org>; Sun, 18 Sep 2022 14:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 439E884084;
	Sun, 18 Sep 2022 14:02:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 439E884084
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=1yb1iBC9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dZhtbgBMvJ-L; Sun, 18 Sep 2022 14:02:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1F50B83F85;
	Sun, 18 Sep 2022 14:02:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F50B83F85
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC0F6C0032;
	Sun, 18 Sep 2022 14:02:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5DC1C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 14:02:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BA5841C03
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 14:02:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BA5841C03
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=solid-run-com.20210112.gappssmtp.com
 header.i=@solid-run-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=1yb1iBC9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-llCHMnsxGv
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 14:02:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1AF6D41BF8
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1AF6D41BF8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 14:02:30 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id f193so373051pgc.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Sep 2022 07:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20210112.gappssmtp.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=M0crenpp8oPv/KIBI6lgLCDPnNtEjIs+dxpt0EDc3Qo=;
 b=1yb1iBC9AJgIrFyamCxM1w+SDaBVd/xtN+R4zxzbd4rMlQR/7uPQ0NYkkghU/ClZjB
 3jJQDVC4gaWIlS6EaAfMP3aFUcd0BzzLBjAeXXtRBWQLyZbs2hRhbjGDwsSdxgsy6rMX
 jqmSKbvqFlpG5Jtrn2o2sKzriWV5hT1X1yvj/VVnv71B/xMgxp5XE2nvQETYhqLa7OXo
 q+z3+nuiTNmasDu4xvRHWNbZ0p+80IOZtih0munLMF2iXjP959SDjX1M8C0OUvDIiaPP
 lYe7Rx3XlWbiktF+z0/W6pjfdcReuEaQ9FOTy2Z/zp7wDqGdq6mdqlt2saTFRNlaiwkf
 Eysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=M0crenpp8oPv/KIBI6lgLCDPnNtEjIs+dxpt0EDc3Qo=;
 b=bdwFM/zPQNrWYMD94e5mvOQJTM4fSDpPQrbOapjDdd/yZ3Siyy6lnMxekUDvmTl+i9
 nVWLwYUeFqU94kmUT+fn5vLGHuiiiV7pQja07j9KzYHyliTFtvTDUXYLgZ1UfdgxCSh7
 m+WSo+C0pD6yCgJMC15oaE6ek1In61iFvfatW3o2q80kJvqp4RntkafxSMJRlqbC9fr6
 Hm1zCEbbhLUlx56YppFAXeQ8xfL/b936+qWpj9RA85iyKAYCIilQpzQOYUFkNz3u0gJu
 YaeZ2FrOXKyvsstjmk/ggJpXO6CCR4guiKNIo2Cy8c5Sxt5ox+Gn7wMJ+W08FSCCtBZI
 xnIg==
X-Gm-Message-State: ACrzQf0wykJ/T4eb2iqk8kvTipHyOzxnV5KF9E7JcWVhj82B2ILI55Wp
 3AQYPPhJOkbcAqastNhT/5/QoIkki5jA58QGzjfmVQ==
X-Google-Smtp-Source: AMsMyM4I6Puy+0jgtRpt/gcTudFQOqS6k22cVmFXBTGA2W0r/nr1RRHRscWkJGlGSHnER0jtgHrVip8hRptfTismyYA=
X-Received: by 2002:a65:620c:0:b0:431:25fe:277 with SMTP id
 d12-20020a65620c000000b0043125fe0277mr11939463pgv.413.1663509749442; Sun, 18
 Sep 2022 07:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220829082313.419220-1-alvaro.karsz@solid-run.com>
 <20220918091848-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220918091848-mutt-send-email-mst@kernel.org>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun, 18 Sep 2022 17:01:53 +0300
Message-ID: <CAJs=3_B4sTo-X9ZkqAZjzLi0EGRNW_jwUtgUBj17p907qVkNoQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_blk: add SECURE ERASE command support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

Thanks for the reply.

> why minimum?

>  why is that?

This was discussed in the previous version
(https://www.spinics.net/lists/linux-virtualization/msg58232.html).
As far as I know, the Linux kernel uses the same "max segments" value
for a discard and a secure erase command.
In the first version, I ignored the max_secure_erase_seg and
secure_erase_sector_alignment config fields (just like
max_write_zeroes_seg and write_zeroes_may_unmap are ignored in the
write zeros command implementation).

It was suggested to use the minimum "max segments" value if both
VIRTIO_BLK_F_SECURE_ERASE and VIRTIO_BLK_F_DISCARD are negotiated.
The same is true for the sector alignment values.

> is this logic repeating code from below?

I'm not sure what you mean.
The idea is:
At this point, the VIRTIO_BLK_F_DISCARD fields were read from the
virtio config (if VIRTIO_BLK_F_DISCARD is negotiated).
If max_discard_segs is 0, VIRTIO_BLK_F_DISCARD is not negotiated (or
set to 0), so we should use the max_secure_erase_seg value as
max_discard_segs.


> Always? What's going on here?
> which versions handled max_secure_erase_seg == 0?

This comment is from the VIRTIO_BLK_F_DISCARD implementation.
I added the max_secure_erase_seg part since I could not find how to
handle the case when max_secure_erase_seg is 0 in the spec.
So, like with the VIRTIO_BLK_F_DISCARD implementation, I'm setting the
value to sg_elems.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
