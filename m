Return-Path: <SRS0=2LZG=L5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4ABC07E99
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:36:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79D79613AE
	for <virtualization@archiver.kernel.org>; Mon,  5 Jul 2021 18:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D79613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 43FE5404BE;
	Mon,  5 Jul 2021 18:36:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pwuLhhsTUyrV; Mon,  5 Jul 2021 18:36:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CD27740609;
	Mon,  5 Jul 2021 18:36:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E74FC0010;
	Mon,  5 Jul 2021 18:36:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 776A8C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65A3940588
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5BxzNcr_esty
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:36:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 294D94052A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Jul 2021 18:36:36 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="208832552"
X-IronPort-AV: E=Sophos;i="5.83,326,1616482800"; d="scan'208";a="208832552"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2021 11:36:35 -0700
X-IronPort-AV: E=Sophos;i="5.83,326,1616482800"; d="scan'208";a="646910526"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2021 11:36:31 -0700
Received: from andy by smile with local (Exim 4.94.2)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1m0TSE-008o4r-BF; Mon, 05 Jul 2021 21:36:26 +0300
Date: Mon, 5 Jul 2021 21:36:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net-next 0/2] refactor the ringtest testing for ptr_ring
Message-ID: <YONRKnDzCzSAXptx@smile.fi.intel.com>
References: <1625457455-4667-1-git-send-email-linyunsheng@huawei.com>
 <YOLXTB6VxtLBmsuC@smile.fi.intel.com>
 <c6844e2b-530f-14b2-0ec3-d47574135571@huawei.com>
 <20210705142555-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210705142555-mutt-send-email-mst@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

On Mon, Jul 05, 2021 at 02:26:32PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 05, 2021 at 08:06:50PM +0800, Yunsheng Lin wrote:
> > On 2021/7/5 17:56, Andy Shevchenko wrote:
> > > On Mon, Jul 05, 2021 at 11:57:33AM +0800, Yunsheng Lin wrote:
> > >> tools/include/* have a lot of abstract layer for building
> > >> kernel code from userspace, so reuse or add the abstract
> > >> layer in tools/include/ to build the ptr_ring for ringtest
> > >> testing.
> > > 
> > > ...
> > > 
> > >>  create mode 100644 tools/include/asm/cache.h
> > >>  create mode 100644 tools/include/asm/processor.h
> > >>  create mode 100644 tools/include/generated/autoconf.h
> > >>  create mode 100644 tools/include/linux/align.h
> > >>  create mode 100644 tools/include/linux/cache.h
> > >>  create mode 100644 tools/include/linux/slab.h
> > > 
> > > Maybe somebody can change this to be able to include in-tree headers directly?
> > 
> > If the above works, maybe the files in tools/include/* is not
> > necessary any more, just use the in-tree headers to compile
> > the user space app?
> > 
> > Or I missed something here?
> 
> why would it work? kernel headers outside of uapi are not
> intended to be consumed by userspace.

The problem here, that we are almost getting two copies of the headers, and
tools are not in a good maintenance, so it's often desynchronized from the
actual Linux headers. This will become more and more diverse if we keep same
way of operation. So, I would rather NAK any new copies of the headers from
include/ to tools/include.

> > > Besides above, had you tested this with `make O=...`?
> > 
> > You are right, the generated/autoconf.h is in another directory
> > with `make O=...`.
> > 
> > Any nice idea to fix the above problem?

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
