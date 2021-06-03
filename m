Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DCCC47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:51:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565596121D
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 14:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565596121D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C74FD83FC8;
	Thu,  3 Jun 2021 14:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hl8pTeMq8unY; Thu,  3 Jun 2021 14:51:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC26C83F8D;
	Thu,  3 Jun 2021 14:51:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92D0DC000D;
	Thu,  3 Jun 2021 14:51:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 924FFC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B95283F8D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ddfnXsUq4buM
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:51:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 69A3583F7B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 14:51:43 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 1FDDA48E; Thu,  3 Jun 2021 16:51:38 +0200 (CEST)
Date: Thu, 3 Jun 2021 16:51:35 +0200
From: Joerg Roedel <joro@8bytes.org>
To: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: [CFP LPC 2021] Confidential Computing Microconference
Message-ID: <YLjsd7zskBPaN9C6@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Andi Kleen <ak@linux.intel.com>,
 Brijesh Singh <brijesh.singh@amd.com>, David Kaplan <David.Kaplan@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Sean Christopherson <seanjc@google.com>,
 Sathya Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
 Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, David Rientjes <rientjes@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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

I am pleased to announce that the

	Confidential Computing Microconference[1]
	
has been accepted at this years Linux Plumbers Conference.

In this microconference we will discuss how Linux can support encryption
technologies which protect data during processing on the CPU. Examples
are AMD SEV, Intel TDX, IBM Secure Execution for s390x and ARM Secure
Virtualization.

Suggested Topics are:

	- Live Migration of Confidential VMs
	- Lazy Memory Validation
	- APIC emulation/interrupt management
	- Debug Support for Confidential VMs
	- Required Memory Management changes for memory validation
	- Safe Kernel entry for TDX and SEV exceptions
	- Requirements for Confidential Containers
	- Trusted Device Drivers Framework and driver fuzzing
	- Remote Attestation

Please submit your proposals on the LPC website at:

	https://www.linuxplumbersconf.org/event/11/abstracts/#submit-abstract

Make sure to select "Confidential Computing MC" in the Track pulldown
menu.

Looking forward to seeing you all there! :)

Thanks,

	Joerg Roedel
	
[1] https://www.linuxplumbersconf.org/blog/2021/index.php/2021/05/14/confidential-computing-microconference-accepted-into-2021-linux-plumbers-conference/
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
