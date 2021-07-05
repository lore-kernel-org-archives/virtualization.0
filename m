Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE13C07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 19:32:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA8561369
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 19:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA8561369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 891CD4045B;
	Mon,  5 Jul 2021 19:32:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gzwsYlly6F5U; Mon,  5 Jul 2021 19:32:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EE6B840408;
	Mon,  5 Jul 2021 19:32:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0F70C001A;
	Mon,  5 Jul 2021 19:32:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41CCEC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 19:32:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30CE183ABF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 19:32:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j7PnLJMf7LG1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 19:32:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D92C683A99
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 19:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625513522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1DGi1LYTetqRgGfrPBWbaHvRrr0YN5Yef/t3KqwiuQ=;
 b=eHJbahAdPZD1rubVh3NgPqDc/YSiBa5iSfP87ZpZcJScVGuembInLUHOQ/LJhI9k/OtCX1
 MS6fMGMi7QFEsP2Bka6HxkciSXTBkPfAT7DQa/za/te/ALRWykP9xwmDy9Hili2TQHgD7j
 1fvfalADJ+2Uif+v5HopIBQNL6mEpqA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-6HJ-jelANIiAbJuBK6lsoQ-1; Mon, 05 Jul 2021 15:32:01 -0400
X-MC-Unique: 6HJ-jelANIiAbJuBK6lsoQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 u7-20020a5d46870000b029012786ba1bc9so6532016wrq.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Jul 2021 12:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P1DGi1LYTetqRgGfrPBWbaHvRrr0YN5Yef/t3KqwiuQ=;
 b=CbXosrIFuC1pd9ysphJ8r1J+3JCtAmuSTTi3LMFTqo8C2B18Sz6+ur/rnmK071JlbR
 A9iHGrnXtP6oZhmi85F8A8kt+frlk1EBpccXIhiTNpyzkK7XEMWVn2tGbzzrUx0/j4Sb
 F3L/Lrgf8OCuAjbEnbI3hK7KgBhpg4KfuR1YBChL2K/2o5NdehUYLxLAkRuFSlyZXC/B
 jZxAGpKXUz5XVB3h/YUuqeTe5jIRMLXWfBHaRj2M5H8vTjYezntGwvwmllQIaznNZ6+e
 FIPhUqdkgzOcxV0nItkZ/sloGRH9jp0U7VsygO2Ufrw7W728MkhBk1q3xZNOX6l0mjBu
 TbBw==
X-Gm-Message-State: AOAM532GOzf+NGZiZ5eSXyj7K+1ZBcKzaQSfoA+9YAA2HvqWx1a/Drkq
 z0w/p0FechlD+Oh5d9cjVLXor2/m7HFRdqc/vIt+CM+DQNocj3zte2RNwWaWqqKIWRp9ModCUS8
 9VFmltTHRwGGXUl+joHjhCq9EUfvWMPPZrWIRVvN4OA==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr640110wmj.184.1625513519966; 
 Mon, 05 Jul 2021 12:31:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoXJHOhyGhZ5PgYHKytoExQiMUYlio0qV1cM880wrFo1XDIN/RZvxU08JaKEUvcuuxPrKiuA==
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr640099wmj.184.1625513519797; 
 Mon, 05 Jul 2021 12:31:59 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
 by smtp.gmail.com with ESMTPSA id x4sm403853wmi.22.2021.07.05.12.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 12:31:59 -0700 (PDT)
Date: Mon, 5 Jul 2021 15:31:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH net-next 0/2] refactor the ringtest testing for ptr_ring
Message-ID: <20210705153047-mutt-send-email-mst@kernel.org>
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <YOLXTB6VxtLBmsuC@smile.fi.intel.com>
 <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
 <20210705142555-mutt-send-email-mst@kernel.org>
 <YONRKnDzCzSAXptx@smile.fi.intel.com>
 <20210705143952-mutt-send-email-mst@kernel.org>
 <CAHp75VcsUxOqu48E1+RNqn=RhJqfd7XG8e3AKRHyMb3ywzSPrg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHp75VcsUxOqu48E1+RNqn=RhJqfd7XG8e3AKRHyMb3ywzSPrg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

On Mon, Jul 05, 2021 at 10:05:30PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 5, 2021 at 9:45 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 05, 2021 at 09:36:26PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 05, 2021 at 02:26:32PM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Jul 05, 2021 at 08:06:50PM +0800, Yunsheng Lin wrote:
> > > > > On 2021/7/5 17:56, Andy Shevchenko wrote:
> > > > > > On Mon, Jul 05, 2021 at 11:57:33AM +0800, Yunsheng Lin wrote:
> > > > > >> tools/include/* have a lot of abstract layer for building
> > > > > >> kernel code from userspace, so reuse or add the abstract
> > > > > >> layer in tools/include/ to build the ptr_ring for ringtest
> > > > > >> testing.
> > > > > >
> > > > > > ...
> > > > > >
> > > > > >>  create mode 100644 tools/include/asm/cache.h
> > > > > >>  create mode 100644 tools/include/asm/processor.h
> > > > > >>  create mode 100644 tools/include/generated/autoconf.h
> > > > > >>  create mode 100644 tools/include/linux/align.h
> > > > > >>  create mode 100644 tools/include/linux/cache.h
> > > > > >>  create mode 100644 tools/include/linux/slab.h
> > > > > >
> > > > > > Maybe somebody can change this to be able to include in-tree headers directly?
> > > > >
> > > > > If the above works, maybe the files in tools/include/* is not
> > > > > necessary any more, just use the in-tree headers to compile
> > > > > the user space app?
> > > > >
> > > > > Or I missed something here?
> > > >
> > > > why would it work? kernel headers outside of uapi are not
> > > > intended to be consumed by userspace.
> > >
> > > The problem here, that we are almost getting two copies of the headers, and
> > > tools are not in a good maintenance, so it's often desynchronized from the
> > > actual Linux headers. This will become more and more diverse if we keep same
> > > way of operation. So, I would rather NAK any new copies of the headers from
> > > include/ to tools/include.
> >
> > We already have the copies
> > yes they are not maintained well ... what's the plan then?
> > NAK won't help us improve the situation.
> 
> I understand and the proposal is to leave only the files which are not
> the same (can we do kinda wrappers or so in tools/include rather than
> copying everything?).

I have no idea how we'd do all this. When I did tools/virtio I already
tried to minimize copying. Want to try to do better?

> > I would say copies are kind of okay just make sure they are
> > built with kconfig. Then any breakage will be
> > detected.
> >
> > > > > > Besides above, had you tested this with `make O=...`?
> > > > >
> > > > > You are right, the generated/autoconf.h is in another directory
> > > > > with `make O=...`.
> > > > >
> > > > > Any nice idea to fix the above problem?
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
