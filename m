Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A70BC433B4
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 09:32:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868FC61002
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 09:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868FC61002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C6FD83DB4;
	Wed, 12 May 2021 09:32:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e7Z46UqTsN4v; Wed, 12 May 2021 09:32:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id C378C83D53;
	Wed, 12 May 2021 09:32:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B4D2C000E;
	Wed, 12 May 2021 09:32:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 791C8C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 09:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 35A19404D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 09:32:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WFfeHdL8cZVW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 09:32:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D103404C5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 09:32:40 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 35D6CAF75;
 Wed, 12 May 2021 09:32:38 +0000 (UTC)
Date: Wed, 12 May 2021 11:32:35 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 3/6] x86/sev-es: Use __put_user()/__get_user
Message-ID: <YJugs0CdiNo0/Gbd@suse.de>
References: <20210512075445.18935-1-joro@8bytes.org>
 <20210512075445.18935-4-joro@8bytes.org>
 <0496626f018d4d27a8034a4822170222@AcuMS.aculab.com>
 <fcb2c501-70ca-1a54-4a75-8ab05c21ee30@suse.com>
 <YJuW4TtRJKZ+OIhj@8bytes.org>
 <92244e37-4443-98bd-24aa-bf59548aab47@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <92244e37-4443-98bd-24aa-bf59548aab47@suse.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Arvind Sankar <nivedita@alum.mit.edu>, "hpa@zytor.com" <hpa@zytor.com>,
 Jiri Slaby <jslaby@suse.cz>, 'Joerg Roedel' <joro@8bytes.org>,
 "x86@kernel.org" <x86@kernel.org>, David Rientjes <rientjes@google.com>,
 Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>,
 Cfir Cohen <cfir@google.com>, Hyunwook Baek <baekhw@google.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 David Laight <David.Laight@aculab.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Erdem Aktas <erdemaktas@google.com>
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

On Wed, May 12, 2021 at 10:58:20AM +0200, Juergen Gross wrote:
> No, those were used before, but commit 9da3f2b7405440 broke Xen's use
> case. That is why I did commit 1457d8cf7664f.

I see, thanks for the heads-up. So here this is not a big issue, because
when an access to kernel space faults under SEV-ES, its a kernel bug
anyway. The issue is that it is not reported correctly.

I think I need to re-work the helper and use probe_kernel_read/write()
when the address is in kernel space. This distinction is already made
when fetching instruction bytes in the #VC handler, but I thought I
could get around it for data accesses.

Having the distinction between user and kernel memory accesses
explicitly in the code seems to be the most robust solution.

Regards,

	Joerg

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
