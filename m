Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B7C43470
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 08:50:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7D7B613CD
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 08:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D7B613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 653804019A;
	Wed, 12 May 2021 08:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K3_yGlzx2orm; Wed, 12 May 2021 08:50:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2695540015;
	Wed, 12 May 2021 08:50:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBDEDC000E;
	Wed, 12 May 2021 08:50:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1F5CC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 08:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4292402D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 08:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hDaaz0Jp2gbk
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 08:50:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0EDDE4019A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 08:50:45 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D8842F3; Wed, 12 May 2021 10:50:42 +0200 (CEST)
Date: Wed, 12 May 2021 10:50:41 +0200
From: 'Joerg Roedel' <joro@8bytes.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 3/6] x86/sev-es: Use __put_user()/__get_user
Message-ID: <YJuW4TtRJKZ+OIhj@8bytes.org>
References: <20210512075445.18935-1-joro@8bytes.org>
 <20210512075445.18935-4-joro@8bytes.org>
 <0496626f018d4d27a8034a4822170222@AcuMS.aculab.com>
 <fcb2c501-70ca-1a54-4a75-8ab05c21ee30@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fcb2c501-70ca-1a54-4a75-8ab05c21ee30@suse.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Arvind Sankar <nivedita@alum.mit.edu>, "hpa@zytor.com" <hpa@zytor.com>,
 Jiri Slaby <jslaby@suse.cz>, "x86@kernel.org" <x86@kernel.org>,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 Hyunwook Baek <baekhw@google.com>,
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

On Wed, May 12, 2021 at 10:16:12AM +0200, Juergen Gross wrote:
> You want something like xen_safe_[read|write]_ulong().

From a first glance I can't see it, what is the difference between the
xen_safe_*_ulong() functions and __get_user()/__put_user()? The only
difference I can see is that __get/__put_user() support different access
sizes, but neither of those disables page-faults by itself, for example.

Couldn't these xen-specific functions not also be replaces by
__get_user()/__put_user()?

Regards,

	Joerg

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
