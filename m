Return-Path: <SRS0=qSBX=KB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF96C433B4
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 20:41:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F5F461107
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 20:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F5F461107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AEDD4184E;
	Thu,  6 May 2021 20:41:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X8_Hx-MZ-iAm; Thu,  6 May 2021 20:41:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78A3B4184C;
	Thu,  6 May 2021 20:41:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B11CC000E;
	Thu,  6 May 2021 20:41:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB0CDC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 20:41:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBA3A4184D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 20:41:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9lxGZK3qv_uv
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 20:41:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B460941844
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 20:41:11 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id E58A0312; Thu,  6 May 2021 22:41:07 +0200 (CEST)
Date: Thu, 6 May 2021 22:41:05 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/2] x86/kexec/64: Forbid kexec when running as an SEV-ES
 guest
Message-ID: <YJRUYWRItEziB2eP@8bytes.org>
References: <20210506093122.28607-1-joro@8bytes.org>
 <20210506093122.28607-3-joro@8bytes.org>
 <m17dkb4v4k.fsf@fess.ebiederm.org> <YJQ4QTtvG76WpcNf@suse.de>
 <m1o8dn1ye9.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1o8dn1ye9.fsf@fess.ebiederm.org>
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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

On Thu, May 06, 2021 at 01:59:42PM -0500, Eric W. Biederman wrote:
> Joerg Roedel <jroedel@suse.de> writes:

> Why does it need that?
> 
> Would it not make sense to instead teach kexec how to pass a cpu from
> one kernel to another.  We could use that everywhere.
> 
> Even the kexec-on-panic case should work as even in that case we have
> to touch the cpus as they go down.
> 
> The hardware simply worked well enough that it hasn't mattered enough
> for us to do something like that, but given that we need to do something
> anyway.  It seems like it would make most sense do something that
> will work everywhere, and does not introduce unnecessary dependencies
> on hypervisors.

Well, I guess we could implement something that even works for non
SEV-ES guests and bare-metal. The question is what benefit we get from
that. Is the SIPI sequence currently used not reliable enough?

The benefit of being able to rely on the SIPI sequence is that the
kexec'ed kernel can use the same method to bring up APs as the first
kernel did.

Btw, the same is true for SEV-ES guests, The goal is bring the APs of
an SEV-ES guest into a state where they will use the SEV-ES method of
AP-bringup when they wake up again. This method involves a
firmware-owned page called the AP-jump-table, which contains the reset
vector for the AP in its first 4 bytes.

> > As I said above, for protocol version 1 it will stay disabled, so it is
> > not only a temporary hack.
> 
> Why does bringing up a cpu need hypervisor support?

When a CPU is taken offline under SEV-ES it will do a special hypercall
named AP-reset-hold. The hypervisor will put the CPU into a halt state
until the next SIPI arrives. In protocol version 1 this hypercall
requires a GHCB shared page to be set up for the CPU doing the hypercall
and upon CPU wakeup the HV will write to that shared page. Problem with
that is that the page which contains the GHCB is already owned by the
new kernel then and is probably not shared anymore, which can cause data
corruption in the new kernel.

Version 2 of the protocol adds a purely MSR based version of the
AP-reset-hold hypercall. This one does not need a GHCB page and has to
be used to bring the APs offline before doing the kexec. That is the
reason I plan to only support kexec when the hypervisor provides version
2 of the protocol.

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
