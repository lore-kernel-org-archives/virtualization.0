Return-Path: <SRS0=qSBX=KB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F369BC433ED
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 17:42:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F0AE60698
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 17:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0AE60698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21F144063C;
	Thu,  6 May 2021 17:42:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IEQB6wM3l7m4; Thu,  6 May 2021 17:42:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDF77405AF;
	Thu,  6 May 2021 17:42:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2215C000D;
	Thu,  6 May 2021 17:42:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86A67C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 17:42:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79F6E406A2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 17:42:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v7wI1G8gTm4m
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 17:42:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CC7A6402AF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 17:42:20 +0000 (UTC)
Received: from in01.mta.xmission.com ([166.70.13.51])
 by out02.mta.xmission.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1lei0n-005md5-4q; Thu, 06 May 2021 11:42:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]
 helo=fess.xmission.com) by in01.mta.xmission.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.87)
 (envelope-from <ebiederm@xmission.com>)
 id 1lei0m-0003nZ-2F; Thu, 06 May 2021 11:42:08 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Joerg Roedel <joro@8bytes.org>
References: <20210506093122.28607-1-joro@8bytes.org>
 <20210506093122.28607-3-joro@8bytes.org>
Date: Thu, 06 May 2021 12:42:03 -0500
In-Reply-To: <20210506093122.28607-3-joro@8bytes.org> (Joerg Roedel's message
 of "Thu, 6 May 2021 11:31:22 +0200")
Message-ID: <m17dkb4v4k.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1lei0m-0003nZ-2F; ; ; mid=<m17dkb4v4k.fsf@fess.ebiederm.org>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.227.160.95; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX18K6SvQ88nM/nPpaU9bp8QcNl7ZXSm1Ea8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/2] x86/kexec/64: Forbid kexec when running as an SEV-ES
 guest
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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

Joerg Roedel <joro@8bytes.org> writes:

> From: Joerg Roedel <jroedel@suse.de>
>
> For now, kexec is not supported when running as an SEV-ES guest. Doing
> so requires additional hypervisor support and special code to hand
> over the CPUs to the new kernel in a safe way.
>
> Until this is implemented, do not support kexec in SEV-ES guests.

I don't understand this.

Fundamentally kexec is about doing things more or less inspite of
what the firmware is doing.

I don't have any idea what a SEV-ES is.  But the normal x86 boot doesn't
do anything special.  Is cross cpu IPI emulation buggy?

If this is a move in your face hypervisor like Xen is sometimes I can
see perhaps needing a little bit of different work during bootup.
Perhaps handing back a cpu on system shutdown and asking for more cpus
on system boot up.

What is the actual problem you are trying to avoid?

And yes for a temporary hack the suggestion of putting code into
machine_kexec_prepare seems much more reasonable so we don't have to
carry special case infrastructure for the forseeable future.

Eric


> Cc: stable@vger.kernel.org # v5.10+
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index c078b0d3ab0e..f902cc9cc634 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -620,3 +620,11 @@ void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages)
>  	 */
>  	set_memory_encrypted((unsigned long)vaddr, pages);
>  }
> +
> +/*
> + * Kexec is not supported in SEV-ES guests yet
> + */
> +bool arch_kexec_supported(void)
> +{
> +	return !sev_es_active();
> +}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
