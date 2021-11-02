Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF8CC433EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 18:17:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD4B60EB9
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 18:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AD4B60EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D856A400A9;
	Tue,  2 Nov 2021 18:17:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OFaTrpz52OL2; Tue,  2 Nov 2021 18:17:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7C896400A4;
	Tue,  2 Nov 2021 18:17:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55727C0012;
	Tue,  2 Nov 2021 18:17:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8254BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 18:17:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 631E840124
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 18:17:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M_UOef6Az25j
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 18:17:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE4B0400D8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 18:17:52 +0000 (UTC)
Received: from in01.mta.xmission.com ([166.70.13.51]:49648)
 by out02.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mhyLz-00AIEV-OE; Tue, 02 Nov 2021 12:17:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:37066
 helo=email.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mhyLo-006iWW-Cc; Tue, 02 Nov 2021 12:17:42 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Joerg Roedel <jroedel@suse.de>
References: <20210913155603.28383-1-joro@8bytes.org>
 <20210913155603.28383-2-joro@8bytes.org> <YYARccITlowHABg1@zn.tnic>
 <87pmrjbmy9.fsf@disp2133> <YYFupTJjUljpuZgL@suse.de>
Date: Tue, 02 Nov 2021 13:17:26 -0500
In-Reply-To: <YYFupTJjUljpuZgL@suse.de> (Joerg Roedel's message of "Tue, 2 Nov
 2021 18:00:21 +0100")
Message-ID: <87k0hq777t.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1mhyLo-006iWW-Cc; ; ; mid=<87k0hq777t.fsf@disp2133>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.227.160.95; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX19ZFP83sW/GDuonSMarVsicvRtUXK4AeQY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 01/12] kexec: Allow architecture code to opt-out at
 runtime
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>,
 Cfir Cohen <cfir@google.com>, Borislav Petkov <bp@alien8.de>,
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

Joerg Roedel <jroedel@suse.de> writes:

> Hi again,
>
> On Mon, Nov 01, 2021 at 04:11:42PM -0500, Eric W. Biederman wrote:
>> I seem to remember the consensus when this was reviewed that it was
>> unnecessary and there is already support for doing something like
>> this at a more fine grained level so we don't need a new kexec hook.
>
> Forgot to state to problem again which these patches solve:
>
> Currently a Linux kernel running as an SEV-ES guest has no way to
> successfully kexec into a new kernel. The normal SIPI sequence to reset
> the non-boot VCPUs does not work in SEV-ES guests and special code is
> needed in Linux to safely hand over the VCPUs from one kernel to the
> next. What happens currently is that the kexec'ed kernel will just hang.
>
> The code which implements the VCPU hand-over is also included in this
> patch-set, but it requires a certain level of Hypervisor support which
> is not available everywhere.
>
> To make it clear to the user that kexec will not work in their
> environment, it is best to disable the respected syscalls. This is what
> the hook is needed for.

Note this is environmental.  This is the equivalent of a driver for a
device without some feature.

The kernel already has machine_kexec_prepare, which is perfectly capable
of detecting this is a problem and causing kexec_load to fail.  Which
is all that is required.

We don't need a new hook and a new code path to test for one
architecture.

So when we can reliably cause the system call to fail with a specific
error code I don't think it makes sense to make clutter up generic code
because of one architecture's design mistakes.


My honest preference would be to go farther and have a
firmware/hypervisor/platform independent rendezvous for the cpus so we
don't have to worry about what bugs the code under has implemented for
this special case.  Because frankly there when there are layers of
software if a bug can slip through it always seems to and causes
problems.


But definitely there is no reason to add another generic hook when the
existing hook is quite good enough.

Eric

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
