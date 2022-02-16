Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317C1C433EF
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 16:23:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A77E380D1B;
	Wed, 16 Feb 2022 16:23:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MzAmthx2de4i; Wed, 16 Feb 2022 16:23:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 50DF180C93;
	Wed, 16 Feb 2022 16:23:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21621C0011;
	Wed, 16 Feb 2022 16:23:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6771C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6BE1415EE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Slk0YHliXzwG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:23:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E797C4099A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 16:23:31 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id om7so2863315pjb.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 08:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=L0HINq0/oRgYesXUSAlumWGA0q6P8NqHQhhmtUR68N4=;
 b=J9YwKXa69Vx93oiJ1A6rlmnGuFdnsxujdFBTp7p5n2AVfGclIZJedCzdp3JuNllZ5p
 /4DwwtInokF0YaJpFjG8OP4VoaXb54xKiINkKTUf3s8lKp/It+QnvmSoKoX6hk37yxbP
 20FWPOBPewVz6VIBvoDV0nV1jdNJYCrl1VTskEJko/ycBtHwRMwS3ssIUlbbPEKnd+fU
 n8ksrm06t4LoVbQUj+bwgem0q8NM+siAqj7OIJx6NGoi37N1LcGxVogf7FK448AFAjpW
 GV9NydPog9US56VH9Z092ZEsZuPf4nAxDvCl2YzJuNt+IDG9OCIl0WUf4o8rLdgOW/Qm
 t6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=L0HINq0/oRgYesXUSAlumWGA0q6P8NqHQhhmtUR68N4=;
 b=r4GHxwEkZ6EG5Mcmxs/DeTMYkHe1698ljpURdwqW2YhUF0Y3Y6FbWda6pZsM1Q7Bl9
 U9XUvn9SiXvv3aVgbWQG757Tvy8tepxTHyx1UQY9joJPgwICDdFtIObpHG2SoJGOG3OO
 4ju4fKarWdKNnTf8T2N0Em/p0vq2KyMyVSRCebgkdSTx7ArZE9ep0zzPLSmp8Ul67wrM
 yO08ZQRpmjZT8wzYdJ89TfO8Y5kN5BaWjIkTQwf6gCOB+Qkw2rOwdID6GGVpTiPlF3Sm
 GkiF95AGvXDu1lIkiFXydteW9V4DnyfGPxTRxUbvw5hq97lBAeN9vSzqWEC1QL+HcZji
 wpPg==
X-Gm-Message-State: AOAM532kEzMWZl3RrOeM+XKx5rXw05WbZv/9cpastzi38luJsk2EX7ma
 5TapIA76mHJrHE18tCosgUXBib2BVRZ+JODqtcKTRQ==
X-Google-Smtp-Source: ABdhPJxe/5E4aU9afUfIgArHENgQctMJhdSdorYTvJU7ovSC4TrhiVgmB6dk+evKsAK0xdx0h9QkI7DI7MpfI+ufsbE=
X-Received: by 2002:a17:90a:d901:b0:1b8:a92c:34fe with SMTP id
 c1-20020a17090ad90100b001b8a92c34femr2642696pjv.8.1645028611229; Wed, 16 Feb
 2022 08:23:31 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
 <20220111161937.56272-2-pankaj.gupta.linux@gmail.com>
 <CAPcyv4jrVJ_B0N_-vtqgXaOMovUgnSLCNj228nWMRhGAC5PDhA@mail.gmail.com>
 <CAM9Jb+i0B2jZ0uCEDyiz8ujuMkioFgOA0r7Lz9wDK026Vq1Hxg@mail.gmail.com>
In-Reply-To: <CAM9Jb+i0B2jZ0uCEDyiz8ujuMkioFgOA0r7Lz9wDK026Vq1Hxg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 16 Feb 2022 08:23:19 -0800
Message-ID: <CAPcyv4gJGB8+acXKXbpEpMck_y=XBMR0B0c255MaSyLsH4+eZA@mail.gmail.com>
Subject: Re: [RFC v3 1/2] virtio-pmem: Async virtio-pmem flush
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

On Wed, Feb 16, 2022 at 12:47 AM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> > >
> > > Enable asynchronous flush for virtio pmem using work queue. Also,
> > > coalesce the flush requests when a flush is already in process.
> > > This functionality is copied from md/RAID code.
> > >
> > > When a flush is already in process, new flush requests wait till
> > > previous flush completes in another context (work queue). For all
> > > the requests come between ongoing flush and new flush start time, only
> > > single flush executes, thus adhers to flush coalscing logic. This is
> >
> > s/adhers/adheres/
> >
> > s/coalscing/coalescing/
> >
> > > important for maintaining the flush request order with request coalscing.
> >
> > s/coalscing/coalescing/
>
> o.k. Sorry for the spelling mistakes.
>
> >
> > >
> > > Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > > ---
> > >  drivers/nvdimm/nd_virtio.c   | 74 +++++++++++++++++++++++++++---------
> > >  drivers/nvdimm/virtio_pmem.c | 10 +++++
> > >  drivers/nvdimm/virtio_pmem.h | 16 ++++++++
> > >  3 files changed, 83 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > > index 10351d5b49fa..179ea7a73338 100644
> > > --- a/drivers/nvdimm/nd_virtio.c
> > > +++ b/drivers/nvdimm/nd_virtio.c
> > > @@ -100,26 +100,66 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
> > >  /* The asynchronous flush callback function */
> > >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> > >  {
> > > -       /*
> > > -        * Create child bio for asynchronous flush and chain with
> > > -        * parent bio. Otherwise directly call nd_region flush.
> > > +       /* queue asynchronous flush and coalesce the flush requests */
> > > +       struct virtio_device *vdev = nd_region->provider_data;
> > > +       struct virtio_pmem *vpmem  = vdev->priv;
> > > +       ktime_t req_start = ktime_get_boottime();
> > > +       int ret = -EINPROGRESS;
> > > +
> > > +       spin_lock_irq(&vpmem->lock);
> >
> > Why a new lock and not continue to use ->pmem_lock?
>
> This spinlock is to protect entry in 'wait_event_lock_irq'
> and the Other spinlock is to protect virtio queue data.

Understood, but md shares the mddev->lock for both purposes, so I
would ask that you either document what motivates the locking split,
or just reuse the lock until a strong reason to split them arises.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
