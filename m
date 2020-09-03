Return-Path: <SRS0=9O9Z=CM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F2FC43461
	for <virtualization@archiver.kernel.org>; Thu,  3 Sep 2020 20:27:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83D920709
	for <virtualization@archiver.kernel.org>; Thu,  3 Sep 2020 20:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="RCNqeDrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83D920709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 99D9A87462;
	Thu,  3 Sep 2020 20:27:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R2tWvFR5KRdF; Thu,  3 Sep 2020 20:27:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B90168746C;
	Thu,  3 Sep 2020 20:27:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F2B8C089E;
	Thu,  3 Sep 2020 20:27:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39711C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 20:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0CE5C2E137
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 20:27:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6NdXMMRqwjs6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 20:27:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 by silver.osuosl.org (Postfix) with ESMTPS id B2B3D2E132
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Sep 2020 20:27:09 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id g128so4768170iof.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Sep 2020 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XHoryAxbdooXqCdzEiDfBNHDRDqVJTRBeWqND7AhQWw=;
 b=RCNqeDrberJQa8iEXoKdFFmsXmVgm0OJW7eIchkOEab4PeUqCYPXFDpEN7VrPE2Q2r
 GUQQuiaAGbKydhEJAnnDCPiK90LXur6kCJr5L5sQ2r/ne46TMpiIdcTaCv2fHYoM6yNb
 n/CznyFIPF9GJUXXveE7AfWdl33o/8t6SBeJ8YB3I8NVC2PqmD4/iWDqPdEI5wN78LVf
 ncTI5ftXwXoF9V4Ax5mdMwpMg3xer78eQreGPZO8czXhtl772MKmX11X+ribr9UqcF1C
 urDp6n8FeZvPlJlmjz8S3oOgFUFG1EujxtEbZKlxpUccJF2SFlBjkXHX8U39zQ/QDpq6
 IUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XHoryAxbdooXqCdzEiDfBNHDRDqVJTRBeWqND7AhQWw=;
 b=j/sdReJWIbnKYFTYe+3eI7LAAEqvV2QOj6t5C7CplAImAx8jkKdfdmpY0qGI82T9gs
 N0k1zpbzbWuYmugGgtq1Fl1DVfEhIMMIg92V5ahmjweZAkt25t8HgrfJIqStZIBmb+PC
 0740LQrx19Kpv95IYYdqUKwLADjDx8oKZCtMPXTWUDOJBt9uNONBPFeblg8sh6O19vAn
 iNqFzYBhSvzIia0Sq4ov0ZMZeh8UMUOXoI6m9GN66M9cnFwL8+cTOw4BkPjIK/oUisC6
 WcgYQAF45ze8km/nAiuJyADpAGzmLFXyrhYaIeFMF+/jyWAFi0RwRkahttYPDoLzR1qL
 WAaw==
X-Gm-Message-State: AOAM532rqm80ntMWN8J+bf6/LLWDo3AYnmbn+ihyYj43EJPTWv3tiy+L
 2gqFgF8b3ak75fneq8uXdzSC8756Dk6l+TEDQQpoqQ==
X-Google-Smtp-Source: ABdhPJwmTrpk85LWcnftpfNTJtQ24c/2yXv/TkIoKUAohLkMn+MLB1sF1W3BqKfqx9SeVWLrNTgZBBPqyFF6pQr5QKA=
X-Received: by 2002:a02:834a:: with SMTP id w10mr5122585jag.63.1599164828964; 
 Thu, 03 Sep 2020 13:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
 <20200529124523.GA11817@infradead.org>
 <CGME20200529190523eucas1p2c086133e707257c0cdc002f502d4f51d@eucas1p2.samsung.com>
 <33137cfb-603c-86e8-1091-f36117ecfaf3@deltatee.com>
 <ef2150d5-7b6a-df25-c10d-e43316fe7812@samsung.com>
 <b9140772-0370-a858-578c-af503a06d8e9@deltatee.com>
 <CALQxJuutRaeX89k2o4ffTKYRMizmMu0XbRnzpFuSSrkQR02jKg@mail.gmail.com>
 <766525c3-4da9-6db7-cd90-fb4b82cd8083@deltatee.com>
 <CALQxJuuS8KKUX_eWWSE81gsq5ePAETB-FoqRUSWFfqgr+B13gg@mail.gmail.com>
In-Reply-To: <CALQxJuuS8KKUX_eWWSE81gsq5ePAETB-FoqRUSWFfqgr+B13gg@mail.gmail.com>
From: Tom Murphy <murphyt7@tcd.ie>
Date: Thu, 3 Sep 2020 21:26:57 +0100
Message-ID: <CALQxJuuk0YR9dZWkqSmLU-kUKoOuuNj-kSikvQGq0wekijycLA@mail.gmail.com>
Subject: Re: [PATCH 0/8] Convert the intel iommu driver to the dma-iommu api
To: Logan Gunthorpe <logang@deltatee.com>
Cc: kvm@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, linux-rockchip@lists.infradead.org,
 Andy Gross <agross@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 linux-mediatek@lists.infradead.org, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, Cornelia Huck <cohuck@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Fri, 28 Aug 2020 at 00:34, Tom Murphy <murphyt7@tcd.ie> wrote:
>
> On Thu, 27 Aug 2020 at 22:36, Logan Gunthorpe <logang@deltatee.com> wrote:
> >
> >
> >
> > On 2020-08-23 6:04 p.m., Tom Murphy wrote:
> > > I have added a check for the sg_dma_len == 0 :
> > > """
> > >  } __sgt_iter(struct scatterlist *sgl, bool dma) {
> > >         struct sgt_iter s = { .sgp = sgl };
> > >
> > > +       if (sgl && sg_dma_len(sgl) == 0)
> > > +           s.sgp = NULL;
> > >
> > >         if (s.sgp) {
> > >             .....
> > > """
> > > at location [1].
> > > but it doens't fix the problem.
> >
> > Based on my read of the code, it looks like we also need to change usage
> > of sgl->length... Something like the rough patch below, maybe?
> >
> > Also, Tom, do you have an updated version of the patchset to convert the
> > Intel IOMMU to dma-iommu available? The last one I've found doesn't
> > apply cleanly (I'm assuming parts of it have been merged in slightly
> > modified forms).
> >
>
> I'll try and post one in the next 24hours

I have just posted this now:
The subject of the cover letter is:
"[PATCH V2 0/5] Convert the intel iommu driver to the dma-iommu api"

>
> > Thanks,
> >
> > Logan
> >
> > --
> >
> > diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h
> > b/drivers/gpu/drm/i915/i915
> > index b7b59328cb76..9367ac801f0c 100644
> > --- a/drivers/gpu/drm/i915/i915_scatterlist.h
> > +++ b/drivers/gpu/drm/i915/i915_scatterlist.h
> > @@ -27,13 +27,19 @@ static __always_inline struct sgt_iter {
> >  } __sgt_iter(struct scatterlist *sgl, bool dma) {
> >         struct sgt_iter s = { .sgp = sgl };
> >
> > +       if (sgl && !sg_dma_len(s.sgp))
> > +               s.sgp = NULL;
> > +
> >         if (s.sgp) {
> >                 s.max = s.curr = s.sgp->offset;
> > -               s.max += s.sgp->length;
> > -               if (dma)
> > +
> > +               if (dma) {
> > +                       s.max += sg_dma_len(s.sgp);
> >                         s.dma = sg_dma_address(s.sgp);
> > -               else
> > +               } else {
> > +                       s.max += s.sgp->length;
> >                         s.pfn = page_to_pfn(sg_page(s.sgp));
> > +               }
> >         }
> >
> >         return s;
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
