Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DEAC07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:42:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1BA613AB
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1BA613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49F414026E;
	Mon,  5 Jul 2021 18:42:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lMYgF33GE-uV; Mon,  5 Jul 2021 18:42:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A558240282;
	Mon,  5 Jul 2021 18:42:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79DACC0010;
	Mon,  5 Jul 2021 18:42:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 904EDC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:42:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 721A160795
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5vW-Sq2Zm49D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:42:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A529C605E1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625510546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hxieeAsO+aYesQyPodozZxutTsNb3aB6Ym4RXVeMxF8=;
 b=Qc/Y976XLaN2XGyao14eqlGzITLS5A45gwE58S8bUhnWPgfFZIVx7eh/9B47/BYETMfMZg
 m6/YYm7NI943rlW1nIG+b0Y6y0H0zj8gtyGVf+OnTgyw4QbcmM5LJkGXD1iJ80CT2u6k/M
 NNozdGMJ5oF2mIRipO0CVqrEq6O4oCw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-ybTIuN9LNg2n9KcZrYowoQ-1; Mon, 05 Jul 2021 14:42:25 -0400
X-MC-Unique: ybTIuN9LNg2n9KcZrYowoQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 u13-20020a5d6dad0000b029012e76845945so4403056wrs.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 11:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hxieeAsO+aYesQyPodozZxutTsNb3aB6Ym4RXVeMxF8=;
 b=tMQhM11suV+L/fbaCIoVePoGfSzG9/UGlAWmxOSFn2w65zWzUQ3+NG19whQJ78tpBw
 R1tVlrT5tI1UKtrk8WM2Qf9+UdlOLLERsAyKmb2LA1Kne0N76+5LcJHiyShgHTx19Qk0
 2t6sfdFyG5D/vLjgfMaDlz8j9hIvgqAAyuTXg4UMG7Wblb1Gvall26yJPt/gQMwI1IsU
 GOFDWaNv/eg8gp3Q8kf+QCEVeiaE2RgyuqQYnMAr9Oy1RWJPDltoH9NadiXGwRSoiiDy
 OHSUnURLCcwB+lEGcYEPEJZGOvLtK/qA8E17FDwf52kMsAtXEjhjrdi3JWzGqIhaZL6K
 cxRA==
X-Gm-Message-State: AOAM531DB3mj5rP8oqyiBll/glPWe3sJcivl08YvZnM2MGq0Q6h2Kqtn
 9n0IF2s+QAZhYC/hsTnBKZyPrEHRZSbrRphKXkdNoYdL4eT6Dn/eVjiJh9knqHcLmAEIdBDAZPX
 rGyK66djVVlOZyRjDR91Xd/hchJRfiEIvV28Aiqpr/A==
X-Received: by 2002:a05:600c:4fc7:: with SMTP id
 o7mr15993594wmq.16.1625510544104; 
 Mon, 05 Jul 2021 11:42:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlJJFPAXlaTcZQswco9ajV7a/O8ZHwJcSxi3zqI4tlkfUQnVjdSqzPKdDB74yLS1uXV1+ndA==
X-Received: by 2002:a05:600c:4fc7:: with SMTP id
 o7mr15993574wmq.16.1625510543917; 
 Mon, 05 Jul 2021 11:42:23 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
 by smtp.gmail.com with ESMTPSA id o3sm14223510wrw.56.2021.07.05.11.42.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 11:42:23 -0700 (PDT)
Date: Mon, 5 Jul 2021 14:42:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH net-next 0/2] refactor the ringtest testing for ptr_ring
Message-ID: <20210705143952-mutt-send-email-mst@kernel.org>
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <YOLXTB6VxtLBmsuC@smile.fi.intel.com>
 <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
 <20210705142555-mutt-send-email-mst@kernel.org>
 <YONRKnDzCzSAXptx@smile.fi.intel.com>
MIME-Version: 1.0
In-Reply-To: <YONRKnDzCzSAXptx@smile.fi.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yury.norov@gmail.com, nickhu@andestech.com, netdev@vger.kernel.org,
 ndesaulniers@gooogle.com, linux-kernel@vger.kernel.org, joe@perches.com,
 Yunsheng Lin <linyunsheng@huawei.com>, green.hu@gmail.com, ojeda@kernel.org,
 kuba@kernel.org, akpm@linux-foundation.org, deanbo422@gmail.com,
 virtualization@lists.linux-foundation.org, davem@davemloft.net
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

On Mon, Jul 05, 2021 at 09:36:26PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 05, 2021 at 02:26:32PM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jul 05, 2021 at 08:06:50PM +0800, Yunsheng Lin wrote:
> > > On 2021/7/5 17:56, Andy Shevchenko wrote:
> > > > On Mon, Jul 05, 2021 at 11:57:33AM +0800, Yunsheng Lin wrote:
> > > >> tools/include/* have a lot of abstract layer for building
> > > >> kernel code from userspace, so reuse or add the abstract
> > > >> layer in tools/include/ to build the ptr_ring for ringtest
> > > >> testing.
> > > > 
> > > > ...
> > > > 
> > > >>  create mode 100644 tools/include/asm/cache.h
> > > >>  create mode 100644 tools/include/asm/processor.h
> > > >>  create mode 100644 tools/include/generated/autoconf.h
> > > >>  create mode 100644 tools/include/linux/align.h
> > > >>  create mode 100644 tools/include/linux/cache.h
> > > >>  create mode 100644 tools/include/linux/slab.h
> > > > 
> > > > Maybe somebody can change this to be able to include in-tree headers directly?
> > > 
> > > If the above works, maybe the files in tools/include/* is not
> > > necessary any more, just use the in-tree headers to compile
> > > the user space app?
> > > 
> > > Or I missed something here?
> > 
> > why would it work? kernel headers outside of uapi are not
> > intended to be consumed by userspace.
> 
> The problem here, that we are almost getting two copies of the headers, and
> tools are not in a good maintenance, so it's often desynchronized from the
> actual Linux headers. This will become more and more diverse if we keep same
> way of operation. So, I would rather NAK any new copies of the headers from
> include/ to tools/include.

We already have the copies
yes they are not maintained well ... what's the plan then?
NAK won't help us improve the situation.
I would say copies are kind of okay just make sure they are
built with kconfig. Then any breakage will be
detected.

> > > > Besides above, had you tested this with `make O=...`?
> > > 
> > > You are right, the generated/autoconf.h is in another directory
> > > with `make O=...`.
> > > 
> > > Any nice idea to fix the above problem?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
