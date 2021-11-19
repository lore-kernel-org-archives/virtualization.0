Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B4FC433EF
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 14:55:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08ED1615E2
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 14:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08ED1615E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B93014092D;
	Fri, 19 Nov 2021 14:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8rQ4e4crZAqg; Fri, 19 Nov 2021 14:55:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1E551401E9;
	Fri, 19 Nov 2021 14:55:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E386AC001E;
	Fri, 19 Nov 2021 14:55:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAB4DC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 14:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3EE7401E9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 14:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZJlPzM7SiyxT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 14:55:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D49324015A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 14:54:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="295237405"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="295237405"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 06:54:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="568904791"
Received: from smile.fi.intel.com ([10.237.72.184])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 06:54:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1mo5Hl-008ZVj-Jj; Fri, 19 Nov 2021 16:54:41 +0200
Date: Fri, 19 Nov 2021 16:54:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
Message-ID: <YZe6seRR7SIzDrX/@smile.fi.intel.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <87mtm0jos3.fsf@intel.com>
 <a9522c0e-0762-c7cd-edb1-0376c435c4d9@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a9522c0e-0762-c7cd-edb1-0376c435c4d9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Corey Minyard <cminyard@mvista.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Chris Mason <clm@fb.com>,
 Christian Brauner <christian.brauner@ubuntu.com>,
 Ketan Mukadam <ketan.mukadam@broadcom.com>, linux-scsi@vger.kernel.org,
 Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Mike Rapoport <rppt@linux.ibm.com>, linux-acpi@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Borislav Petkov <bp@suse.de>,
 virtualization@lists.linux-foundation.org, Len Brown <lenb@kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org,
 Josef Bacik <josef@toxicpanda.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 David Sterba <dsterba@suse.com>, Somnath Kotur <somnath.kotur@broadcom.com>,
 linux-arm-kernel@lists.infradead.org,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 netdev@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
 LKML <linux-kernel@vger.kernel.org>, "John S . Gruber" <JohnSGruber@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-btrfs@vger.kernel.org
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

On Fri, Nov 19, 2021 at 02:16:03PM +0100, Alejandro Colomar (man-pages) wrote:
> On 11/19/21 13:47, Jani Nikula wrote:
> > On Fri, 19 Nov 2021, Alejandro Colomar <alx.manpages@gmail.com> wrote:

...

> Patch set 1:
> - Add <linux/memberof.h> with memberof()
> - Split offsetof() to <linux/offsetof.h>
> - Split offsetofend() to <linux/offsetofend.h>
> - Split typeof_member() to <linux/typeof_member.h>
> - Split sizeof_field() to <linux/sizeof_field.h>
> - Split NULL to <linux/NULL.h>
> - Split ARRAY_SIZE() to <linux/array_size.h>

Isn't it way too small granularity? I agree on having the separate header
for ARRAY_SIZE() and it was discussed, but the rest...

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
