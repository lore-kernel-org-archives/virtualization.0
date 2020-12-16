Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D5C4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 00:39:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F4C22D06
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 00:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F4C22D06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A2FF84CE6;
	Wed, 16 Dec 2020 00:39:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nPVcvgRdhUhl; Wed, 16 Dec 2020 00:39:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 09C4A84578;
	Wed, 16 Dec 2020 00:39:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C18BFC0893;
	Wed, 16 Dec 2020 00:39:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDF40C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 00:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B04BF86714
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 00:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8gFWWQXYAKhW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 00:39:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C1E4786A6B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 00:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608079147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCyr+zCzlSHQ1KjMAt3Zb/a+qisNyayFH7/e91jTxqk=;
 b=Snze6ynPda7VvaiqdJe7E9l3GeM58gKaIloPQs+ANvI1sEK34ZibQBIx+MxhhjuvUcDIDP
 EeD3idBJARoX/pc3LR7k5Wn75nvXJMwOIqNEM5KXsQ5nSvEudETMIJVoQF+/OSHxgDM98H
 84Aiayq3rfDJ8KNllsHRt/GplGB9CO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-wYBKR5ESPACLwIRJr6G_JA-1; Tue, 15 Dec 2020 19:39:03 -0500
X-MC-Unique: wYBKR5ESPACLwIRJr6G_JA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B14061054F8E;
 Wed, 16 Dec 2020 00:38:10 +0000 (UTC)
Received: from treble (ovpn-112-170.rdu2.redhat.com [10.10.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44CAF5DD87;
 Wed, 16 Dec 2020 00:38:04 +0000 (UTC)
Date: Tue, 15 Dec 2020 18:38:02 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/12] x86: major paravirt cleanup
Message-ID: <20201216003802.5fpklvx37yuiufrt@treble>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120125342.GC3040@hirez.programming.kicks-ass.net>
 <20201123134317.GE3092@hirez.programming.kicks-ass.net>
 <6771a12c-051d-1655-fb3a-cc45a3c82e29@suse.com>
 <20201215141834.GG3040@hirez.programming.kicks-ass.net>
 <20201215145408.GR3092@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201215145408.GR3092@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-hyperv@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Wanpeng Li <wanpengli@tencent.com>,
 kvm@vger.kernel.org, "VMware, Inc." <pv-drivers@vmware.com>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 xen-devel@lists.xenproject.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 luto@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Jim Mattson <jmattson@google.com>,
 =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>
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

On Tue, Dec 15, 2020 at 03:54:08PM +0100, Peter Zijlstra wrote:
> The problem is that a single instance of unwind information (ORC) must
> capture and correctly unwind all alternatives. Since the trivially
> correct mandate is out, implement the straight forward brute-force
> approach:
> 
>  1) generate CFI information for each alternative
> 
>  2) unwind every alternative with the merge-sort of the previously
>     generated CFI information -- O(n^2)
> 
>  3) for any possible conflict: yell.
> 
>  4) Generate ORC with merge-sort
> 
> Specifically for 3 there are two possible classes of conflicts:
> 
>  - the merge-sort itself could find conflicting CFI for the same
>    offset.
> 
>  - the unwind can fail with the merged CFI.

So much algorithm.  Could we make it easier by caching the shared
per-alt-group CFI state somewhere along the way?

For example:

struct alt_group_info {

	/* first original insn in the group */
	struct instruction *orig_insn;

	/* max # of bytes in the group (cfi array size) */
	unsigned long nbytes;

	/* byte-offset-addressed array of CFI pointers */
	struct cfi_state **cfi;
};

We could change 'insn->alt_group' to be a pointer to a shared instance
of the above struct, so that all original and replacement instructions
in a group have a pointer to it.

Starting out, 'cfi' array is all NULLs.  Then when updating CFI, check
'insn->alt_group.cfi[offset]'.

[ 'offset' is a byte offset from the beginning of the group.  It could
  be calculated based on 'orig_insn' or 'orig_insn->alts', depending on
  whether 'insn' is an original or a replacement. ]

If the array entry is NULL, just update it with a pointer to the CFI.
If it's not NULL, make sure it matches the existing CFI, and WARN if it
doesn't.

Also, with this data structure, the ORC generation should also be a lot
more straightforward, just ignore the NULL entries.

Thoughts?  This is all theoretical of course, I could try to do a patch
tomorrow.

-- 
Josh

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
