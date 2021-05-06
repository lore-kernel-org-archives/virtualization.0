Return-Path: <SRS0=qSBX=KB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01157C43470
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 19:00:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB34613D9
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 19:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB34613D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20E41400C5;
	Thu,  6 May 2021 19:00:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yWc3aQmzLT1b; Thu,  6 May 2021 19:00:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94D33402B3;
	Thu,  6 May 2021 19:00:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F668C000E;
	Thu,  6 May 2021 19:00:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 289AAC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 18:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13CE8615D8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 18:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i60T0jQK70-2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 18:59:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 33D01615D0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 18:59:57 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52])
 by out01.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1lejDx-006IlB-FL; Thu, 06 May 2021 12:59:49 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]
 helo=fess.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1lejDv-007wor-20; Thu, 06 May 2021 12:59:48 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Joerg Roedel <jroedel@suse.de>
References: <20210506093122.28607-1-joro@8bytes.org>
 <20210506093122.28607-3-joro@8bytes.org>
 <m17dkb4v4k.fsf@fess.ebiederm.org> <YJQ4QTtvG76WpcNf@suse.de>
Date: Thu, 06 May 2021 13:59:42 -0500
In-Reply-To: <YJQ4QTtvG76WpcNf@suse.de> (Joerg Roedel's message of "Thu, 6 May
 2021 20:41:05 +0200")
Message-ID: <m1o8dn1ye9.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1lejDv-007wor-20; ; ; mid=<m1o8dn1ye9.fsf@fess.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.227.160.95; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX1+QSetsVGHHRPIqFsnfIS69iprRKQZBDtk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 2/2] x86/kexec/64: Forbid kexec when running as an SEV-ES
 guest
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>,
 Cfir Cohen <cfir@google.com>, linux-coco@lists.linux.dev,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 Sean Christopherson <seanjc@google.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Erdem Aktas <erdemaktas@google.com>
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

Joerg Roedel <jroedel@suse.de> writes:

> On Thu, May 06, 2021 at 12:42:03PM -0500, Eric W. Biederman wrote:
>> I don't understand this.
>> 
>> Fundamentally kexec is about doing things more or less inspite of
>> what the firmware is doing.
>> 
>> I don't have any idea what a SEV-ES is.  But the normal x86 boot doesn't
>> do anything special.  Is cross cpu IPI emulation buggy?
>
> Under SEV-ES the normal SIPI-based sequence to re-initialize a CPU does
> not work anymore. An SEV-ES guest is a special virtual machine where the
> hardware encrypts the guest memory and the guest register state. The
> hypervisor can't make any modifications to the guests registers at
> runtime. Therefore it also can't emulate a SIPI sequence and reset the
> vCPU.
>
> The guest kernel has to reset the vCPU itself and hand it over from the
> old kernel to the kexec'ed kernel. This isn't currently implemented and
> therefore kexec needs to be disabled when running as an SEV-ES guest.
>
> Implementing this also requires an extension to the guest-hypervisor
> protocol (the GHCB Spec[1]) which is only available in version 2. So a
> guest running on a hypervisor supporting only version 1 will never
> properly support kexec.

Why does it need that?

Would it not make sense to instead teach kexec how to pass a cpu from
one kernel to another.  We could use that everywhere.

Even the kexec-on-panic case should work as even in that case we have
to touch the cpus as they go down.

The hardware simply worked well enough that it hasn't mattered enough
for us to do something like that, but given that we need to do something
anyway.  It seems like it would make most sense do something that
will work everywhere, and does not introduce unnecessary dependencies
on hypervisors.

>> What is the actual problem you are trying to avoid?
>
> Currently, if someone tries kexec in an SEV-ES guest, the kexec'ed
> kernel will only be able to bring up the boot CPU, not the others. The
> others will wake up with the old kernels CPU state in the new kernels
> memory and do undefined things, most likely triple-fault because their
> page-table is not existent anymore.
>
> So since kexec currently does not work as expected under SEV-ES, it is
> better to hide it until everything is implemented so it can do what the
> user expects.

I can understand temporarily disabling the functionality.

>> And yes for a temporary hack the suggestion of putting code into
>> machine_kexec_prepare seems much more reasonable so we don't have to
>> carry special case infrastructure for the forseeable future.
>
> As I said above, for protocol version 1 it will stay disabled, so it is
> not only a temporary hack.

Why does bringing up a cpu need hypervisor support?

I understand why we can't do what we do currently, but that doesn't seem
to preclude doing something without hypervisor support.

Eric
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
