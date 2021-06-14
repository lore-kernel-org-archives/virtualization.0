Return-Path: <SRS0=07LM=LI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D41CC2B9F4
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 12:33:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C336100A
	for <virtualization@archiver.kernel.org>; Mon, 14 Jun 2021 12:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C336100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3D8F83B4F;
	Mon, 14 Jun 2021 12:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MRUU-RpaphkR; Mon, 14 Jun 2021 12:33:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7847583A43;
	Mon, 14 Jun 2021 12:33:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53A52C000E;
	Mon, 14 Jun 2021 12:33:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FA93C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 12:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 29CF74049D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 12:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wUay2wMPcTBP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 12:33:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCF8B40485
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Jun 2021 12:33:09 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 05EE12DA; Mon, 14 Jun 2021 14:33:05 +0200 (CEST)
Date: Mon, 14 Jun 2021 14:33:04 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Eric Biederman <ebiederm@xmission.com>, x86@kernel.org
Subject: Re: [PATCH v2 0/2] x86: Disable kexec for SEV-ES guests
Message-ID: <YMdMgCAIYN4zOX4N@8bytes.org>
References: <20210603132233.10004-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210603132233.10004-1-joro@8bytes.org>
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, David Rientjes <rientjes@google.com>,
 Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 Kees Cook <keescook@chromium.org>, Cfir Cohen <cfir@google.com>,
 linux-coco@lists.linux.dev, Andy Lutomirski <luto@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Juergen Gross <jgross@suse.com>,
 Mike Stunes <mstunes@vmware.com>, Sean Christopherson <seanjc@google.com>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
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

Gentle ping.

On Thu, Jun 03, 2021 at 03:22:31PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Changes v1->v2:
> 
> 	- Rebased to v5.13-rc4
> 	- Add the check also to the kexec_file_load system call
> 
> Original cover letter:
> 
> Hi,
> 
> two small patches to disable kexec on x86 when running as an SEV-ES
> guest. Trying to kexec a new kernel would fail anyway because there is
> no mechanism yet to hand over the APs from the old to the new kernel.
> Supporting this needs changes in the Hypervisor and the guest kernel
> as well.
> 
> This code is currently being work on, but disable kexec in SEV-ES
> guests until it is ready.
> 
> Please review.
> 
> Regards,
> 
> 	Joerg
> 
> Joerg Roedel (2):
>   kexec: Allow architecture code to opt-out at runtime
>   x86/kexec/64: Forbid kexec when running as an SEV-ES guest
> 
>  arch/x86/kernel/machine_kexec_64.c |  8 ++++++++
>  include/linux/kexec.h              |  1 +
>  kernel/kexec.c                     | 14 ++++++++++++++
>  kernel/kexec_file.c                |  9 +++++++++
>  4 files changed, 32 insertions(+)
> 
> -- 
> 2.31.1
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
