Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7264C433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 03:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D69A82894;
	Wed, 16 Feb 2022 03:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4YRGIaLsIRzc; Wed, 16 Feb 2022 03:34:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CC3B8826EA;
	Wed, 16 Feb 2022 03:34:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FD4AC0011;
	Wed, 16 Feb 2022 03:34:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9DFDC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 03:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6311D40576
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 03:34:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eNIMTX_php1Z
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 03:34:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 99913400D7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 03:34:36 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id 132so986702pga.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 19:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lNEQbX7Cj1rLSUqainzZr7y+UqvteHBg1pncfSDBI3k=;
 b=caJo9iQpPyQndEH8t/TtZgVuvQs22W8ChZtpwz4wZ3RAkyQTwRiJJabOoIsohB6wiQ
 0DNIGiie+oouidsCrrJbAsT+gbJhOve1QLyxQ23wQ+1ehTetEFomDe8jrVh4lPsmPU1k
 zDSb1AWpLqGL5KRx42diDUkQZXncQytm8MdeXia6uPexwMxq22luAg60sMefZvz7WJxA
 1RGLQxxbJ0A11J9UPbqvTGB2/zu+yz7T04+ze4aGeyODubIGEri5xS4vhqdTrOZlwBZ1
 9FYdZI8vkBsVmLQLya4lm+l782oJOZZP5a5HoqeMXM74NYgbW/ZI5ssG5WxFcfWvj/Tc
 LBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lNEQbX7Cj1rLSUqainzZr7y+UqvteHBg1pncfSDBI3k=;
 b=x+KZf1GUQYB3HR4KMndnwwwHVgdB4D9jFKrCbtq9XjOwHfzufG1bX0fNMZR4pNWqOo
 4Mw39oDuj+TsPY+Ug1Hzf9pDaxiPAvPSiT5f1j4WX852ndtd/3irB8YTqcoWggPqXNP7
 JnaKUHG6BRvDvD5ZR684Wl2WpijjKTu+dx4DwyBE7RtUDMLdmUrnbQIwonCRVPBm59b3
 ck8k5W7gQRAwlroEgEXDCa9spYkprIg4JvYYnH85kfhjJhwYCyG0AaUViZiAD3rk3ltm
 8FLmMJNd1ERO24bEbuhpJaGYHmkJxNW2Np9kSg/fS+yvlqFiaOyDNdLQBRciFvzPaQfD
 UsmA==
X-Gm-Message-State: AOAM530/RUbq+oiQj3RXtPNx6WTHyxEJIEwiGEbNHOCAjwh5CNlMYBdw
 X/v/+pAFts9KGTgzPgKvvOP/L4MIwRFj4rNvS1wtQg==
X-Google-Smtp-Source: ABdhPJyW5VadiIqwRQ3iKfUXmEC5cECaeAdHWWepcPZds282RWLRRT48Qng+4A1cZK9GKSDl7THuSiMwL+NG5Ttwo/o=
X-Received: by 2002:a05:6a00:8ca:b0:4e0:2ed3:5630 with SMTP id
 s10-20020a056a0008ca00b004e02ed35630mr1067520pfu.3.1644982475928; Tue, 15 Feb
 2022 19:34:35 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
 <20220111161937.56272-3-pankaj.gupta.linux@gmail.com>
In-Reply-To: <20220111161937.56272-3-pankaj.gupta.linux@gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 Feb 2022 19:34:24 -0800
Message-ID: <CAPcyv4gM99M8Waw9uEZefvpK0BsTkjGznLxUOMcMkGpk6SuHyA@mail.gmail.com>
Subject: Re: [RFC v3 2/2] pmem: enable pmem_submit_bio for asynchronous flush
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>, Cornelia Huck <cohuck@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>, Pankaj Gupta <pankaj.gupta@ionos.com>,
 Vishal L Verma <vishal.l.verma@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, jmoyer <jmoyer@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Weiny, Ira" <ira.weiny@intel.com>
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

On Tue, Jan 11, 2022 at 8:21 AM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> Return from "pmem_submit_bio" when asynchronous flush is
> still in progress in other context.
>
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
>  drivers/nvdimm/pmem.c        | 15 ++++++++++++---
>  drivers/nvdimm/region_devs.c |  4 +++-
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index fe7ece1534e1..f20e30277a68 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -201,8 +201,12 @@ static void pmem_submit_bio(struct bio *bio)
>         struct pmem_device *pmem = bio->bi_bdev->bd_disk->private_data;
>         struct nd_region *nd_region = to_region(pmem);
>
> -       if (bio->bi_opf & REQ_PREFLUSH)
> +       if (bio->bi_opf & REQ_PREFLUSH) {
>                 ret = nvdimm_flush(nd_region, bio);
> +               /* asynchronous flush completes in other context */

I think a negative error code is a confusing way to capture the case
of "bio successfully coalesced to previously pending flush request.
Perhaps reserve negative codes for failure, 0 for synchronously
completed, and > 0 for coalesced flush request.

> +               if (ret == -EINPROGRESS)
> +                       return;
> +       }
>
>         do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
>         if (do_acct)
> @@ -222,13 +226,18 @@ static void pmem_submit_bio(struct bio *bio)
>         if (do_acct)
>                 bio_end_io_acct(bio, start);
>
> -       if (bio->bi_opf & REQ_FUA)
> +       if (bio->bi_opf & REQ_FUA) {
>                 ret = nvdimm_flush(nd_region, bio);
> +               /* asynchronous flush completes in other context */
> +               if (ret == -EINPROGRESS)
> +                       return;
> +       }
>
>         if (ret)
>                 bio->bi_status = errno_to_blk_status(ret);
>
> -       bio_endio(bio);
> +       if (bio)
> +               bio_endio(bio);
>  }
>
>  static int pmem_rw_page(struct block_device *bdev, sector_t sector,
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 9ccf3d608799..8512d2eaed4e 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1190,7 +1190,9 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
>         if (!nd_region->flush)
>                 rc = generic_nvdimm_flush(nd_region);
>         else {
> -               if (nd_region->flush(nd_region, bio))
> +               rc = nd_region->flush(nd_region, bio);
> +               /* ongoing flush in other context */
> +               if (rc && rc != -EINPROGRESS)
>                         rc = -EIO;

Why change this to -EIO vs just let the error code through untranslated?

>         }
>
> --
> 2.25.1
>
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
