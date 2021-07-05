Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92683C07E9C
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 19:06:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379CE61983
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 19:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379CE61983
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAF5140500;
	Mon,  5 Jul 2021 19:06:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1A2P75oKj5Do; Mon,  5 Jul 2021 19:06:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4634D40490;
	Mon,  5 Jul 2021 19:06:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BC62C0010;
	Mon,  5 Jul 2021 19:06:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9546FC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 19:06:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 840E040129
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 19:06:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l3GxTIV_aYsU
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 19:06:07 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EA683400D2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 19:06:07 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id 17so17174127pfz.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UuZh8eJmQ1lIEadR8z/9iR40GstH8GqfR3g6tCx7cRE=;
 b=WJQx9NA8BlzVRMafs+7EpMWi9x3rYpCEMMXMC1Ug33QN7MAfMRBh94GJhwCibzemus
 iJcwK/0iE9ddqwI6SQMjUMDFDVLHvu+HV55386PbGPr9F+dKnQkokj1QpnCWW9mtArHh
 jpILZUSOgLC+7ulmGkfLrB+3T9kd5fmujRIroAVpuNcbAjYEnRfhX3bAcLTHKlZckFQ3
 YREPXxjt7YglLinDmsMpMSOzEum9OZ7UGJkW6JC74oIkPreY58UJ1C3+2uYkV3TQZzeg
 5vPeL94bY3wV1z3QJj/yefgZQjEyJftH0s79OomsaPClPOk9T2fKQhKK8Hg8P/fHVTmW
 RIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UuZh8eJmQ1lIEadR8z/9iR40GstH8GqfR3g6tCx7cRE=;
 b=mxpPRXhrNrPMOekC6jO7h8wViLmbp5wXtPRwPsyS7Uorg3K6Q5c4qpwxRlMUW+wYTS
 XToytgW+DGh1pcJLpU5z+cQ5mJpzoV816l+ryKS+VrZ+Hf4DkgE9d5mFV8bHH+skmTgJ
 u2SpRz6fAKvFJgB+iRnupv5kQ91qtacYCKiUGDj+EM4Ef6TCVYaCTK/8zxi7y5cFifTg
 D4jI6F0LyNvIdXimswJ0L3vfnaN8OFdOQB+BCxPZbmPa1F9lm8CTv/8Pr8wG2e7uJZfw
 y/vwgtSV3oeRuf2elD0uG1glVjRumJ7JsAHQGzRxeuHS0Ei84bw8TufJ+40cSgrQVDOz
 862g==
X-Gm-Message-State: AOAM532GfgcrEooBp9zv3flsAGHgWDZiCEqNCTBKnqb3kjDpX7LHuDHR
 lhcnV9y/mnJVWZnGPP7AhOA8qem4KqimZm9HUyg=
X-Google-Smtp-Source: ABdhPJzBtBfYSQTDKaFdu9uHDDFSuLkh44ARNTnK7EYRd7Fh8DbqQD1vimLJIZZeQcUJ8XkToCJGZtqoXm1ttwjjbcE=
X-Received: by 2002:a63:d014:: with SMTP id z20mr17034219pgf.203.1625511967330; 
 Mon, 05 Jul 2021 12:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <YOLXTB6VxtLBmsuC@smile.fi.intel.com>
 <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
 <20210705142555-mutt-send-email-mst@kernel.org>
 <YONRKnDzCzSAXptx@smile.fi.intel.com>
 <20210705143952-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210705143952-mutt-send-email-mst@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 5 Jul 2021 22:05:30 +0300
Message-ID: <CAHp75VcsUxOqu48E1+RNqn=RhJqfd7XG8e3AKRHyMb3ywzSPrg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] refactor the ringtest testing for ptr_ring
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Vincent Chen <deanbo422@gmail.com>, Yury Norov <yury.norov@gmail.com>,
 Nick Hu <nickhu@andestech.com>, netdev <netdev@vger.kernel.org>,
 ndesaulniers@gooogle.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Joe Perches <joe@perches.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Greentime Hu <green.hu@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Jul 5, 2021 at 9:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jul 05, 2021 at 09:36:26PM +0300, Andy Shevchenko wrote:
> > On Mon, Jul 05, 2021 at 02:26:32PM -0400, Michael S. Tsirkin wrote:
> > > On Mon, Jul 05, 2021 at 08:06:50PM +0800, Yunsheng Lin wrote:
> > > > On 2021/7/5 17:56, Andy Shevchenko wrote:
> > > > > On Mon, Jul 05, 2021 at 11:57:33AM +0800, Yunsheng Lin wrote:
> > > > >> tools/include/* have a lot of abstract layer for building
> > > > >> kernel code from userspace, so reuse or add the abstract
> > > > >> layer in tools/include/ to build the ptr_ring for ringtest
> > > > >> testing.
> > > > >
> > > > > ...
> > > > >
> > > > >>  create mode 100644 tools/include/asm/cache.h
> > > > >>  create mode 100644 tools/include/asm/processor.h
> > > > >>  create mode 100644 tools/include/generated/autoconf.h
> > > > >>  create mode 100644 tools/include/linux/align.h
> > > > >>  create mode 100644 tools/include/linux/cache.h
> > > > >>  create mode 100644 tools/include/linux/slab.h
> > > > >
> > > > > Maybe somebody can change this to be able to include in-tree headers directly?
> > > >
> > > > If the above works, maybe the files in tools/include/* is not
> > > > necessary any more, just use the in-tree headers to compile
> > > > the user space app?
> > > >
> > > > Or I missed something here?
> > >
> > > why would it work? kernel headers outside of uapi are not
> > > intended to be consumed by userspace.
> >
> > The problem here, that we are almost getting two copies of the headers, and
> > tools are not in a good maintenance, so it's often desynchronized from the
> > actual Linux headers. This will become more and more diverse if we keep same
> > way of operation. So, I would rather NAK any new copies of the headers from
> > include/ to tools/include.
>
> We already have the copies
> yes they are not maintained well ... what's the plan then?
> NAK won't help us improve the situation.

I understand and the proposal is to leave only the files which are not
the same (can we do kinda wrappers or so in tools/include rather than
copying everything?).

> I would say copies are kind of okay just make sure they are
> built with kconfig. Then any breakage will be
> detected.
>
> > > > > Besides above, had you tested this with `make O=...`?
> > > >
> > > > You are right, the generated/autoconf.h is in another directory
> > > > with `make O=...`.
> > > >
> > > > Any nice idea to fix the above problem?


-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
