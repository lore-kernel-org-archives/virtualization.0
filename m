Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D477DC07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 14:57:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716CC61946
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 14:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716CC61946
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 368B260888;
	Mon,  5 Jul 2021 14:57:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DaqHFH1Y1ybm; Mon,  5 Jul 2021 14:57:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D520A60875;
	Mon,  5 Jul 2021 14:57:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98BAEC001A;
	Mon,  5 Jul 2021 14:57:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E642CC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 14:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D5B7E4045B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 14:57:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FTZXlLvkn2ZW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 14:57:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF71540164
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 14:57:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="230714513"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; d="scan'208";a="230714513"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2021 07:57:39 -0700
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; d="scan'208";a="644215013"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2021 07:57:35 -0700
Received: from andy by smile with local (Exim 4.94.2)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1m0Q2M-008hn9-8M; Mon, 05 Jul 2021 17:57:30 +0300
Date: Mon, 5 Jul 2021 17:57:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next 0/2] refactor the ringtest testing for ptr_ring
Message-ID: <YOMd2q8Mf08+QVQ2@smile.fi.intel.com>
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <YOLXTB6VxtLBmsuC@smile.fi.intel.com>
 <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: yury.norov@gmail.com, nickhu@andestech.com, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, joe@perches.com,
 ndesaulniers@gooogle.com, green.hu@gmail.com, ojeda@kernel.org,
 kuba@kernel.org, akpm@linux-foundation.org, deanbo422@gmail.com,
 davem@davemloft.net
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

On Mon, Jul 05, 2021 at 08:06:50PM +0800, Yunsheng Lin wrote:
> On 2021/7/5 17:56, Andy Shevchenko wrote:
> > On Mon, Jul 05, 2021 at 11:57:33AM +0800, Yunsheng Lin wrote:
> >> tools/include/* have a lot of abstract layer for building
> >> kernel code from userspace, so reuse or add the abstract
> >> layer in tools/include/ to build the ptr_ring for ringtest
> >> testing.
> > 
> > ...
> > 
> >>  create mode 100644 tools/include/asm/cache.h
> >>  create mode 100644 tools/include/asm/processor.h
> >>  create mode 100644 tools/include/generated/autoconf.h
> >>  create mode 100644 tools/include/linux/align.h
> >>  create mode 100644 tools/include/linux/cache.h
> >>  create mode 100644 tools/include/linux/slab.h
> > 
> > Maybe somebody can change this to be able to include in-tree headers directly?
> 
> If the above works, maybe the files in tools/include/* is not
> necessary any more, just use the in-tree headers to compile
> the user space app?
> 
> Or I missed something here?

I don't know if it works or not or why that decision had been made to
copy'n'paste headers (Yes, I know they have some modifications).

Somebody needs to check that and see what can be done in order to avoid copying
entire include into tools/include.

> > Besides above, had you tested this with `make O=...`?
> 
> You are right, the generated/autoconf.h is in another directory
> with `make O=...`.
> 
> Any nice idea to fix the above problem?

No idea. But I consider breakage of O= is a show stopper.

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
