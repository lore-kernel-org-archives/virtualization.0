Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F204C77B7A
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 12:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D500441C62;
	Wed,  7 Jun 2023 12:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D500441C62
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AEALtnIH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0OB-R9h4Z3_y; Wed,  7 Jun 2023 12:49:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0348041BC3;
	Wed,  7 Jun 2023 12:49:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0348041BC3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4D1DC007A;
	Wed,  7 Jun 2023 12:49:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B780AC0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 12:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 857A281CEF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 12:49:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 857A281CEF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AEALtnIH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zTkMMA_unMJn
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 12:49:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1856781C81
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1856781C81
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 12:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686142158; x=1717678158;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=96j5LP+QrdvCGDRDBIDgXK+1HoouV0Xv0Dmwi4N0S9M=;
 b=AEALtnIHNJ2/KKwICK8st/ImAuTEdrnfS6rGtaxpSPLmyaXp7vTEaZwk
 2qBGoeVdTSsEtRbKSZZMck/IR76myVy5BU2BvlCrAIWPAml6zpTQrkI+T
 T3auQRzgn8aMLyh7MTTAvNlakAhmqnlQ/LayB5k+5lB0Y9hu81Sjcbgpr
 R8Y3r/Nma1tSbswuTECTZAGTSjtGOD3GxPg6CMOQHmJoHozz7XS5FZbsr
 Eo/3Fgi2jIPPH1NOZDfpekr4tbJ1BVZT1w3R/mYtTIAOhiPRWn48WqmcT
 wZ3DRwafxJbgXCeb7dpSRYUXnCJMzyTCE05Bceo8dmYiWB3LVXfuPn59n w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="355829407"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; d="scan'208";a="355829407"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 05:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="774592705"
X-IronPort-AV: E=Sophos;i="6.00,224,1681196400"; d="scan'208";a="774592705"
Received: from vsmyers-mobl2.amr.corp.intel.com (HELO [10.212.146.233])
 ([10.212.146.233])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 05:49:16 -0700
Message-ID: <1f633e99-d294-6932-31e9-0eb158d030ea@intel.com>
Date: Wed, 7 Jun 2023 05:49:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 0/4] x86/fixmap: Unify FIXADDR_TOP
Content-Language: en-US
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
References: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Usama Arif <usama.arif@bytedance.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Brian Gerst <brgerst@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Suren Baghdasaryan <surenb@google.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw@amazon.co.uk>,
 "Mike Rapoport \(IBM\)" <rppt@kernel.org>
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

On 5/15/23 01:19, Hou Wenlong wrote:
> This patchset unifies FIXADDR_TOP as a variable for x86, allowing the
> fixmap area to be movable and relocated with the kernel image in the
> x86/PIE patchset [0]. This enables the kernel image to be relocated in
> the top 512G of the address space.

What problems does this patch set solve?  How might that solution be
visible to end users?  Why is this problem important to you?

Also, while you're waiting for someone to review _your_ code, have you
considered reviewing anyone else's code?  I don't think I've seen any
review activity from you lately.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
