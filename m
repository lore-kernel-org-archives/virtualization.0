Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50EFC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 16:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B55D84D9F;
	Mon, 13 Dec 2021 16:43:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gM2GHBdAMGRc; Mon, 13 Dec 2021 16:43:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2036E84D61;
	Mon, 13 Dec 2021 16:43:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8324C001E;
	Mon, 13 Dec 2021 16:43:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4285C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 16:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9198460A99
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 16:43:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel-com.20210112.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OZpDwIE3zkcp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 16:43:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F107F607DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 16:43:41 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id i12so15426431pfd.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 08:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vyYw8u6XfcAGXDXzJlsX3xmu/UHpiQrY1MTgK5iKFVw=;
 b=XiFSVO0CJWFC7lIKOLyuO0nHL/iPwSF4yirvRxBS9+af4O56S0PGNlreHbXCXAaP84
 x2MkNIYnCkZJt6nRR1y/F1eTxY8BTD2UTKonNUg1K9JCTv5/HxLzy4/3O4lDerPuxb55
 wNtDkDmWlrkFMyWmBiAeQkwSnBjf/wORUGNGO8dSmKbze+5/JaWYPD9N08wNZ0JG4NX5
 V5TENSR5i/EgX/lga+UxQPOKVhl3og9dvfA8/wemUHLC0j89nVhG5b5aGetkDZb95bLg
 03KLqIXXPUyeJvGWehZAJvknBTiZVAVi0MM6Ds9ewRhMTodjq4P/YqW0RLoUsUcR6kHt
 RQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vyYw8u6XfcAGXDXzJlsX3xmu/UHpiQrY1MTgK5iKFVw=;
 b=LyLAGsBupHIoE9pZdCOaLG7jIA/587AzpUGB9Ue0KnjnZNTbsSvq//Mre48wbnLoe0
 OrWYiTraXodbN5NBG+XaC+4+/gzsHfB6+lYqdPY+bcInKeEQd7bFtbhwmLXNWOTuEiwJ
 +7GxFCejZWKGMevxfWfT7TZ1rFYmojJtMhd1F2TwCKi52qHYCisJyqtkDIAXfDEYBSDH
 eJSW1xdOEuCbnkk6VTiX7m5+Xai2uTIZpg68IQIbhvkQL/MqRlZfC12Cv7VRhMZIKwhE
 4jsZZG9IApbDxCozEacYrcWvD0dXJp9At9kc1A/DSUiLXNymrTHavcsk/8L1eHJ47oX8
 gaeA==
X-Gm-Message-State: AOAM531FqczcpPAuESxEG2GEJq+h6ndmULhQ4PNDAKPwLgOUMxoKKNrl
 adQiWmqfJBxRZiHPbd3z4e8bulIOI/UhentxMsqP8g==
X-Google-Smtp-Source: ABdhPJx2n8q1onN4jQzvRQyQbTXEvg1DJxhgaWZFSAWB2OQ1hhJNCq2enXcdrfYzpDge5Iz394R2nbo3Ocn0tDkMu6w=
X-Received: by 2002:aa7:8d0a:0:b0:4a2:82d7:1695 with SMTP id
 j10-20020aa78d0a000000b004a282d71695mr34765307pfe.86.1639413821384; Mon, 13
 Dec 2021 08:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20211209063828.18944-1-hch@lst.de>
 <20211209063828.18944-6-hch@lst.de> <YbNejVRF5NQB0r83@redhat.com>
 <CAPcyv4i_HdnMcq6MmDMt-a5p=ojh_vsoAiES0vUYEh7HvC1O-A@mail.gmail.com>
 <20211213082020.GA21462@lst.de>
In-Reply-To: <20211213082020.GA21462@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 13 Dec 2021 08:43:32 -0800
Message-ID: <CAPcyv4g-_hth2LMUS=k3FwMCfVsSkgFOJ53-uE1wzsDVuEs_eg@mail.gmail.com>
Subject: Re: [PATCH 5/5] dax: always use _copy_mc_to_iter in dax_copy_to_iter
To: Christoph Hellwig <hch@lst.de>
Cc: Linux NVDIMM <nvdimm@lists.linux.dev>,
 linux-s390 <linux-s390@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Mike Snitzer <snitzer@redhat.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Vishal Verma <vishal.l.verma@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 device-mapper development <dm-devel@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
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

On Mon, Dec 13, 2021 at 12:20 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Dec 12, 2021 at 06:48:05AM -0800, Dan Williams wrote:
> > On Fri, Dec 10, 2021 at 6:05 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Thu, Dec 09, 2021 at 07:38:28AM +0100, Christoph Hellwig wrote:
> > > > While using the MC-safe copy routines is rather pointless on a virtual device
> > > > like virtiofs,
> > >
> > > I was wondering about that. Is it completely pointless.
> > >
> > > Typically we are just mapping host page cache into qemu address space.
> > > That shows as virtiofs device pfn in guest and that pfn is mapped into
> > > guest application address space in mmap() call.
> > >
> > > Given on host its DRAM, so I would not expect machine check on load side
> > > so there was no need to use machine check safe variant.
> >
> > That's a broken assumption, DRAM experiences multi-bit ECC errors.
> > Machine checks, data aborts, etc existed before PMEM.
>
> So the conclusion here is that we should always use the mc safe variant?

The proposal is one of the following:

1/ any paths not currently using the mc safe variant should continue
not using it to avoid the performance regression on older platforms,
i.e. drop this patch.

2/ add plumbing to switch to mcsafe variant, but only on newer
platforms, incremental new patch

3/ always use the mc safe variant, keep this patch

We could go with 3/ and see who screams, because 3/ is smallest
ongoing maintenance burden. However, I feel like 1/ is the path of
least resistance until the platforms with the need to do 'careful'
copying age out of use.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
