Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98941C433FE
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 15:35:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409CE61B1E
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 15:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 409CE61B1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDCFA410BB;
	Fri, 19 Nov 2021 15:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YpsVGR97E5o1; Fri, 19 Nov 2021 15:35:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 782FA410AD;
	Fri, 19 Nov 2021 15:35:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1F83C002E;
	Fri, 19 Nov 2021 15:35:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20B11C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDE0F40116
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K-5cqfqXzx-o
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:35:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 120C6400F3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 15:35:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="258224766"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="258224766"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 07:35:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="506474100"
Received: from smile.fi.intel.com ([10.237.72.184])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 07:35:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1mo5uf-008a3l-IP; Fri, 19 Nov 2021 17:34:53 +0200
Date: Fri, 19 Nov 2021 17:34:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
Message-ID: <YZfEHZa3f5MXeqoH@smile.fi.intel.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <CAK8P3a0qT9tAxFkLN_vJYRcocDW2TcBq79WcYKZFyAG0udZx5Q@mail.gmail.com>
 <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <434296d3-8fe1-f1d2-ee9d-ea25d6c4e43e@gmail.com>
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

On Fri, Nov 19, 2021 at 04:06:27PM +0100, Alejandro Colomar (man-pages) wrote:
> Hi Arnd,
> 
> On 11/19/21 15:47, Arnd Bergmann wrote:
> > On Fri, Nov 19, 2021 at 12:36 PM Alejandro Colomar
> > <alx.manpages@gmail.com> wrote:
> >>
> >> Alejandro Colomar (17):
> >>   linux/container_of.h: Add memberof(T, m)
> >>   Use memberof(T, m) instead of explicit NULL dereference
> >>   Replace some uses of memberof() by its wrappers
> >>   linux/memberof.h: Move memberof() to separate header
> >>   linux/typeof_member.h: Move typeof_member() to a separate header
> >>   Simplify sizeof(typeof_member()) to sizeof_field()
> >>   linux/NULL.h: Move NULL to a separate header
> >>   linux/offsetof.h: Move offsetof(T, m) to a separate header
> >>   linux/offsetof.h: Implement offsetof() in terms of memberof()
> >>   linux/container_of.h: Implement container_of_safe() in terms of
> >>     container_of()
> >>   linux/container_of.h: Cosmetic
> >>   linux/container_of.h: Remove unnecessary cast to (void *)
> > 
> > My feeling is that this takes the separation too far: by having this many header
> > files that end up being included from practically every single .c file
> > in the kernel,
> > I think you end up making compile speed worse overall.
> > 
> > If your goal is to avoid having to recompile as much of the kernel
> > after touching
> > a header, I think a better approach is to help untangle the dependencies, e.g.
> > by splitting out type definitions from headers with inline functions (most
> > indirect header dependencies are on type definitions) and by focusing on
> > linux/fs.h, linux/sched.h, linux/mm.h and how they interact with the rest of the
> > headers. At the moment, these are included in most .c files and they in turn
> > include a ton of other headers.
> 
> Yes, I would like to untangle the dependencies.
> 
> The main reason I started doing this splitting
> is because I wouldn't be able to include
> <linux/stddef.h> in some headers,
> because it pulled too much stuff that broke unrelated things.
> 
> So that's why I started from there.
> 
> I for example would like to get NULL in memberof()
> without puling anything else,
> so <linux/NULL.h> makes sense for that.

I don't believe that the code that uses NULL won't include types.h.

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
