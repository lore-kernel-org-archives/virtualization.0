Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA21C4332F
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 15:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1F2D84672;
	Fri, 20 May 2022 15:48:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4JpKCMRhxyRi; Fri, 20 May 2022 15:48:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 91F2884607;
	Fri, 20 May 2022 15:48:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56ABDC0039;
	Fri, 20 May 2022 15:48:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7762C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:48:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3E9A40A9B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:48:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v7XONKkbLqvU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:48:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 954BE40A8F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 15:48:22 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C8AF3246; Fri, 20 May 2022 17:48:18 +0200 (CEST)
Date: Fri, 20 May 2022 17:48:17 +0200
From: =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>
To: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-sgx@vger.kernel.org
Subject: [CFP LPC 2022] Confidential Computing Microconference
Message-ID: <Yoe4QZr8dqy1hrU1@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Andi Kleen <ak@linux.intel.com>,
 David Kaplan <David.Kaplan@amd.com>, Marc Orr <marcorr@google.com>,
 Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Sathya Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
 Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@alien8.de>,
 Mike Rapoport <rppt@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 David Rientjes <rientjes@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Gonda <pgonda@google.com>,
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

as already announced by the planning committee, there will be another

	Confidential Computing Microconference

at this years Linux Plumbers Conference (LPC) happening from 12th to
14th of September in Dublin, Ireland.

In this microconference we want to discuss ongoing developments around
Linux support for memory encryption and support for Confidential
Computing in general.

Suggested topics are:

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

	* Support for Confidential Containers

	* Or anything else related to Confidential Computing in Linux

Please submit your proposals on the LPC website at:

	https://lpc.events/event/16/abstracts/

Make sure to select "Confidential Computing MC" in the Track pulldown
menu.

Looking forwart to seeing you all there, either in Dublin or virtual :)

Thanks,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
