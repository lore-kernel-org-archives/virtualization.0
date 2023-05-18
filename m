Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800F8C77B73
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 21:57:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EA766408A7;
	Thu, 18 May 2023 21:57:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EA766408A7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ilTUs+At
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ocnkrlGZ168J; Thu, 18 May 2023 21:57:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 93EE54011D;
	Thu, 18 May 2023 21:57:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 93EE54011D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D90EC0035;
	Thu, 18 May 2023 21:57:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 278B6C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 21:56:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC8E1405BB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 21:56:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC8E1405BB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MLJQW-uPm4xe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 21:56:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A676F403AC
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A676F403AC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 21:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684447014; x=1715983014;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=TfncyPoLkgEVKt4cWoEjhnDcsRhR4hVCsiDKfdnguT0=;
 b=ilTUs+AtIeT5pna9Vt4ARWCoTY3z1q30bi1ndDsBKZNtZhDoy8KIdvnX
 PeTUtmSWu0tijJHhU3XmszAlr9H3oAr1NsYl5ShbcGolL6mQdtXR7yoIl
 V3B6IoRGw5FjLcsbMqPc/WSPdXRQZF0ba3QYkfwGrcStlGdSYAzGBzaaU
 3atKU/JCvdWNPg7Di6oxaZ1Li743mjYZnGk7V+69cUEiuPBpd4OE1/6iY
 AbCD+nGgvODVpmWNrL1GNADv7+32VRhJKK28YRWq8slCwW3Zc8ANSyRL5
 O2ZSpBEPSXqWdQMk1fwFSk6ltOo4ihP63pRM6M/UonYIgnoOjoheTJsUQ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="354550226"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="354550226"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 14:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="948852100"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; d="scan'208";a="948852100"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.209.81.123])
 ([10.209.81.123])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2023 14:56:52 -0700
Message-ID: <a78d9dcd-0bc1-7e98-a8f1-e5d6cd0c09a3@intel.com>
Date: Thu, 18 May 2023 14:56:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/20] x86: address -Wmissing-prototype warnings
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, x86@kernel.org
References: <20230516193549.544673-1-arnd@kernel.org>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230516193549.544673-1-arnd@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, linux-pci@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
 linux-trace-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 linux-pm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 platform-driver-x86@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Andy Shevchenko <andy@infradead.org>
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

On 5/16/23 12:35, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This addresses all x86 specific prototype warnings. The majority of the
> patches should be straightforward, either adding an #include statement
> to get the right header, or ensuring that an unused global function is
> left out of the build when the prototype is hidden.
> 
> The ones that are a bit awkward are those that just add a prototype to
> shut up the warning, but the prototypes are never used for calling the
> function because the only caller is in assembler code. I tried to come up
> with other ways to shut up the compiler using the asmlinkage annotation,
> but with no success.
> 
> All of the warnings have to be addressed in some form before the warning
> can be enabled by default.

I picked up the ones that were blatantly obvious, but left out 03, 04,
10, 12 and 19 for the moment.

BTW, I think the i386 allyesconfig is getting pretty lightly tested
these days.  I think you and I hit the same mlx4 __bad_copy_from()
compile issue.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
