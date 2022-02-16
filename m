Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F3AC433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 16:26:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6310760F86;
	Wed, 16 Feb 2022 16:26:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SLLK4ee_37C4; Wed, 16 Feb 2022 16:26:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F184A60F97;
	Wed, 16 Feb 2022 16:26:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A60EAC0011;
	Wed, 16 Feb 2022 16:26:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5DC8C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:26:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4F944167D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:26:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ROSG3sAKWYtI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:26:01 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 234DD41673
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:26:00 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 q11-20020a17090a304b00b001b94d25eaecso2820897pjl.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nhaYDK+1Xr6t09RUwH9LeVyAOy0Iet12ql37UN6Cqhc=;
 b=huC9bfgtZYgR0waRD90zBZ7prMLMTt7FD+a2+9d2+TIBXgL2AW3c8Y015ZUo7lcaXB
 TdSot7kLqIIuKZjQh+E13tmxNcXdqTYm6+1xOabpaFwjOoMi+SwtASpEIrhbbYvbbDVR
 yNbiB2oA1/1UW936CyPSH6+nfK4N90eCDArpC70C06QsB64ySwEGaIJlTtq0z5zG9d0v
 f2d6KdwQObESSeE6YyI+i9sfl9ThC0In8Nab6u7HeGkN60np51jogEsJAksc8ocI3XTT
 qGOcdd7kwIGhFU75ArDBjllyGIdC8A02ZUw3cYiEHL0iMXQYYLgjMlmhFM0s1AL/HZ87
 0sNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nhaYDK+1Xr6t09RUwH9LeVyAOy0Iet12ql37UN6Cqhc=;
 b=tx13P843YF+vEzigXLBy7UecCqOXOFqM1LlYGLfunoP4nyYEtLjvGChG2ji1u++vGX
 mtCSyOG8n6JWkcbm5tUDQCyubbX9hTJFCofCkfzPrbNzgNbZqweZJuwGxu/NAMogmjAU
 f6VQb+GK6+RXnHyNDwVPHN24M0+FCFRjzQcBzQT62wWwT/e4rmLm7nfhIIBjVfJlpenW
 8kIFiUYx2luibUVaRb70R/fFWZedOAcp3PFox6KTAlf5cOxXvSnk+9sC9eLquFcgtqRc
 DDiMSlWY4LFZNkLSwjSfrQrzGpAkrE0FXUBDy9VyVHFtTTzYs+5GNHDAxqjf9tHFVYpi
 e7Lg==
X-Gm-Message-State: AOAM532LbjRwQhEzGBq4sP3gS9gMu3zo71MtHSmuuXZPf1Pn+0H/X4av
 9EDoEgwXS61KmdkU4TLpNlv32+V4FIkWSXwKsHm6EA==
X-Google-Smtp-Source: ABdhPJyFUOkJTyrN8eu8zcICrEiE34OEQNOcRXQ+qA8yo+FR28x8Y4H92pXGSQhwBQsV7Fb99hRe47pP0GdnEaG91iQ=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr3589396pll.132.1645028760530; Wed, 16
 Feb 2022 08:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
 <20220111161937.56272-3-pankaj.gupta.linux@gmail.com>
 <CAPcyv4gM99M8Waw9uEZefvpK0BsTkjGznLxUOMcMkGpk6SuHyA@mail.gmail.com>
 <CAM9Jb+iYXn+Diq-vou+_hXdxXLR9rEXm6GOsd2tZpAg9zXn1Fw@mail.gmail.com>
In-Reply-To: <CAM9Jb+iYXn+Diq-vou+_hXdxXLR9rEXm6GOsd2tZpAg9zXn1Fw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Feb 2022 08:25:48 -0800
Message-ID: <CAPcyv4iPhtbhAfpjCtbt9RGFOXuGCj-q3Gm_y7zaNk44Z7uq9Q@mail.gmail.com>
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

On Wed, Feb 16, 2022 at 12:39 AM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> > >
> > > Return from "pmem_submit_bio" when asynchronous flush is
> > > still in progress in other context.
> > >
> > > Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > > ---
> > >  drivers/nvdimm/pmem.c        | 15 ++++++++++++---
> > >  drivers/nvdimm/region_devs.c |  4 +++-
> > >  2 files changed, 15 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> > > index fe7ece1534e1..f20e30277a68 100644
> > > --- a/drivers/nvdimm/pmem.c
> > > +++ b/drivers/nvdimm/pmem.c
> > > @@ -201,8 +201,12 @@ static void pmem_submit_bio(struct bio *bio)
> > >         struct pmem_device *pmem = bio->bi_bdev->bd_disk->private_data;
> > >         struct nd_region *nd_region = to_region(pmem);
> > >
> > > -       if (bio->bi_opf & REQ_PREFLUSH)
> > > +       if (bio->bi_opf & REQ_PREFLUSH) {
> > >                 ret = nvdimm_flush(nd_region, bio);
> > > +               /* asynchronous flush completes in other context */
> >
> > I think a negative error code is a confusing way to capture the case
> > of "bio successfully coalesced to previously pending flush request.
> > Perhaps reserve negative codes for failure, 0 for synchronously
> > completed, and > 0 for coalesced flush request.
>
> Yes. I implemented this way previously, will revert it to. Thanks!
>
> >
> > > +               if (ret == -EINPROGRESS)
> > > +                       return;
> > > +       }
> > >
> > >         do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
> > >         if (do_acct)
> > > @@ -222,13 +226,18 @@ static void pmem_submit_bio(struct bio *bio)
> > >         if (do_acct)
> > >                 bio_end_io_acct(bio, start);
> > >
> > > -       if (bio->bi_opf & REQ_FUA)
> > > +       if (bio->bi_opf & REQ_FUA) {
> > >                 ret = nvdimm_flush(nd_region, bio);
> > > +               /* asynchronous flush completes in other context */
> > > +               if (ret == -EINPROGRESS)
> > > +                       return;
> > > +       }
> > >
> > >         if (ret)
> > >                 bio->bi_status = errno_to_blk_status(ret);
> > >
> > > -       bio_endio(bio);
> > > +       if (bio)
> > > +               bio_endio(bio);
> > >  }
> > >
> > >  static int pmem_rw_page(struct block_device *bdev, sector_t sector,
> > > diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> > > index 9ccf3d608799..8512d2eaed4e 100644
> > > --- a/drivers/nvdimm/region_devs.c
> > > +++ b/drivers/nvdimm/region_devs.c
> > > @@ -1190,7 +1190,9 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
> > >         if (!nd_region->flush)
> > >                 rc = generic_nvdimm_flush(nd_region);
> > >         else {
> > > -               if (nd_region->flush(nd_region, bio))
> > > +               rc = nd_region->flush(nd_region, bio);
> > > +               /* ongoing flush in other context */
> > > +               if (rc && rc != -EINPROGRESS)
> > >                         rc = -EIO;
> >
> > Why change this to -EIO vs just let the error code through untranslated?
>
> The reason was to be generic error code instead of returning host side
> return codes to guest?

Ok, maybe a comment to indicate the need to avoid exposing these error
codes toa guest so someone does not ask the same question in the
future?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
