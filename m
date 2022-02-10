Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601F6C433EF
	for <virtualization@archiver.kernel.org>; Thu, 10 Feb 2022 11:18:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7E9B408C8;
	Thu, 10 Feb 2022 11:18:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YvzSSR_Fl2Up; Thu, 10 Feb 2022 11:18:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8B03A408BE;
	Thu, 10 Feb 2022 11:18:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50D8BC001A;
	Thu, 10 Feb 2022 11:18:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4025AC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 11:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E0EA813A1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 11:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zaWmF_OCiaQJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 11:18:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC3FD81396
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 11:18:44 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id F169436B; Thu, 10 Feb 2022 12:18:40 +0100 (CET)
Date: Thu, 10 Feb 2022 12:18:36 +0100
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: linux-coco@lists.linux.dev
Subject: Confidential Computing microconference 2022 planning kick-off
Message-ID: <YgT0jKIMYWqkuOj6@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Brijesh Singh <brijesh.singh@amd.com>, Andy Lutomirski <luto@kernel.org>,
 David Kaplan <David.Kaplan@amd.com>, Marc Orr <marcorr@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, Andi Kleen <ak@linux.intel.com>,
 kvm@vger.kernel.org, Sathya Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
 Peter Gonda <pgonda@google.com>, David Rientjes <rientjes@google.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>
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

Hi,

the organizers of the Linux Plumbers Conference 2022 have recently
opened the CfP for microconferences and I thought it would be great to
have another Confidential Computing microconference to bring everyone
together and discuss open problems.

I drafted a proposal for review, feel free to make improvements and/or
add more topics. Please also forward this email to other people who
might be interested, but which I missed here.

If anyone is interested in co-organizing this microconference, please
contact me. I am open to any helping hand :)

I plan to submit the proposal to the LPC website end of next week to get
things going. 

Thanks,

	Joerg

Here is the current proposal text:

Confidential Computing Microconference
======================================

Last years inaugural Confidential Computing microconference brought
together plumbers enabling secure execution features in hypervisors,
firmware, Linux Kernel, over low-level user space up to container
runtimes.

Good progress was made on a couple of topics, most outstanding here is
the development of Linux guest support for Intel TDX[1] and AMD
SEV-SNP[2].  The patch-sets for both are under intensive review and come
close to be merged upstream.

The discussions in the microconference also helped to move other topics
forward, such as support for un-accepted memory[3] or deferred memory
pinning[4] for confidential guests.

But enabling Confidential Computing in the Linux ecosystem is an ongoing
process, and there are still many problems to solve. The most important
ones are:

	* Design and implementation of Intel TDX and AMD SEV-SNP host
	  support
	* Linux kernel memory management changes for secure execution
	  environments
	* Support of upcoming secure execution hardware extensions
	  from ARM and RISC-V
	* Pre-launch and runtime attestation workflows
	* Interrupt security for AMD SEV-SNP
	* Debuggability and live migration of encrypted virtual machines
	* Proper testing of confidential computing support code

The Confidential Computing Microconference wants to bring together
plumbers working on secure execution features to discuss these and other
open problems.

[1] https://lore.kernel.org/all/20220124150215.36893-1-kirill.shutemov@linux.intel.com/
[2] https://lore.kernel.org/all/20220209181039.1262882-1-brijesh.singh@amd.com/
[3] https://lore.kernel.org/all/20220128205906.27503-1-kirill.shutemov@linux.intel.com/
[4] https://lore.kernel.org/all/20220118110621.62462-1-nikunj@amd.com/

Key Attendees:

	* Andi Kleen <ak@linux.intel.com>
	* Andy Lutomirski <luto@kernel.org>
	* Borislav Petkov <bp@alien8.de>
	* Brijesh Singh <brijesh.singh@amd.com>
	* Dr. David Alan Gilbert <dgilbert@redhat.com>
	* Dave Hansen <dave.hansen@linux.intel.com>
	* David Hildenbrand <david@redhat.com>
	* David Kaplan <David.Kaplan@amd.com>
	* David Rientjes <rientjes@google.com>
	* Joerg Roedel <jroedel@suse.de>
	* Jun Nakajima <jun.nakajima@intel.com>
	* Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
	* Marc Orr <marcorr@google.com>
	* Mike Rapoport <rppt@kernel.org>
	* Paolo Bonzini <pbonzini@redhat.com>
	* Peter Gonda <pgonda@google.com>
	* Sathya Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
	* Sean Christopherson <seanjc@google.com>
	* Tom Lendacky <thomas.lendacky@amd.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
