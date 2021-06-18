Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79297C49EA3
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 11:54:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5BD61351
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 11:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5BD61351
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 512CD83981;
	Fri, 18 Jun 2021 11:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1I9M8t4oozNa; Fri, 18 Jun 2021 11:54:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 071F0839BD;
	Fri, 18 Jun 2021 11:54:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54051C0027;
	Fri, 18 Jun 2021 11:54:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56C11C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 11:54:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3D1A7400F2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 11:54:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hct40u7Z_akq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 11:54:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E162400EA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 11:54:21 +0000 (UTC)
Received: from cap.home.8bytes.org (p4ff2ba7c.dip0.t-ipconnect.de
 [79.242.186.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id 59DD61E9;
 Fri, 18 Jun 2021 13:54:17 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 0/2] x86/sev: Fixes for SEV-ES Guest Support
Date: Fri, 18 Jun 2021 13:54:07 +0200
Message-Id: <20210618115409.22735-1-joro@8bytes.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
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

From: Joerg Roedel <jroedel@suse.de>

Hi,

please find here the next iteration of my pending fixes for SEV-ES
guest support in Linux. This version addresses the comments I received
from Peter on the previous version, in particular:

	- Removed IRQ disable/enable calls in the ap-hlt loop code
	- Made __sev_get/put_ghcb() noinstr instead of __always_inline
	  and put instrumentation_begin()/end() calls around panic()
	  to fix an objtool warning.
	- Split up #DB handling in the #VC handler into a from-user
	  and from-kernel part as well.

The patches are again tested with a kernel with various debugging
options enabled, running as an SEV-ES guest.

The previous version of these patches can be found here:

	https://lore.kernel.org/lkml/20210616184913.13064-1-joro@8bytes.org/

Please review.

Thanks,

	Joerg

Joerg Roedel (2):
  x86/sev: Make sure IRQs are disabled while GHCB is active
  x86/sev: Split up runtime #VC handler for correct state tracking

 arch/x86/entry/entry_64.S       |   4 +-
 arch/x86/include/asm/idtentry.h |  29 ++---
 arch/x86/kernel/sev.c           | 182 ++++++++++++++++++--------------
 3 files changed, 113 insertions(+), 102 deletions(-)


base-commit: 07570cef5e5c3fcec40f82a9075abb4c1da63319
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
