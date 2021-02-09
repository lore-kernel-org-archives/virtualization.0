Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED0C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 22:21:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AC4764DDF
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 22:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AC4764DDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8624385B73;
	Tue,  9 Feb 2021 22:21:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b39Ellr8Pl-Y; Tue,  9 Feb 2021 22:21:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2FAAC85B25;
	Tue,  9 Feb 2021 22:21:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0489BC0174;
	Tue,  9 Feb 2021 22:21:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C5C9C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6C92786B49
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:21:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8u0JgMpmi31N
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:21:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 8AC79868E2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 22:21:15 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id 189so3793428pfy.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Feb 2021 14:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HjSiRe9FHCVaGCF52pKJiLElvBu049No/wtLMDAICXE=;
 b=ZPccq1cXTR6T3lt5wME8WuvLAa5mZge5Mw8wXRyQz0ElTK2dM1mAnAYXOysMgOvFTF
 M1Xw0/LEh9dW5Qkrenqg0x0Lv+vYZsYEyKugTwXm+DqKUU9BR7UzcXPZmO9XadLkecQv
 ApW9qLmbiPGG6qIUhUfOsDjkvmBBT3d1bIuWRorvesu1dHc8b0GYSrflEf1HFbYKj3Ps
 33QK4jBS3ZO5kHS9hN+Jy1KJAsWXHDkIkgvZxzA1ZM4RRCcfTprdS7m3wectpcSsxT5g
 gsp5xUecBmhB2lJcNcmkxhi49e7wSClMUrfkE5Gmy18NkLMWcoXbkUDEDX4QE6sQ9x5B
 IO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HjSiRe9FHCVaGCF52pKJiLElvBu049No/wtLMDAICXE=;
 b=Fl4wqGorVka2hMQolaZ83C3dqR1XQ3KhVQsc5Cozg5lR3shDLh6RTwUHL1sztTLCMd
 rUZNeowUJxSHziHFfJebfEoZ7h4sakt9JeQdoc1Ae8tQ2uX8RrnAEpkymZFZYGDkl4os
 TgK75UvGR7Us3QbdenlRFm2LFxi97Wd4jYzppKTRtBmP3Uund2zmlAT3lOtzOR+Tm0AV
 uSy8wPc5FGbnithjtUJi1sn1EBcwZcWxTxZzoNjneYVUXdvu7m2bP8Q3rZNFdZ+4FaEB
 vAzKaPV5+8Zmi1ApZ3q1NCqJw6TapsCY+eYiIsV0ZRgPLf9S9Y9xu0fh6+P79eoFbaJZ
 acIw==
X-Gm-Message-State: AOAM531zeHzGnLx0pLS7Y2ClmBY6ZYPpK9fdAOD0rM+W/TZVT4z0v+rq
 6ocgpbIT5X8J9HdaMeKVzuk=
X-Google-Smtp-Source: ABdhPJz3LfnWDYq7JINpREZUWfE+W5NwAF3qi+h7lRxojWAtxXFLj2+kpLvcsoQwwfGFKhWJBLAhPg==
X-Received: by 2002:a63:545f:: with SMTP id e31mr136017pgm.212.1612909274776; 
 Tue, 09 Feb 2021 14:21:14 -0800 (PST)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id v9sm58601pju.33.2021.02.09.14.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 14:21:13 -0800 (PST)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 0/8] x86/tlb: Concurrent TLB flushes
Date: Tue,  9 Feb 2021 14:16:45 -0800
Message-Id: <20210209221653.614098-1-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Sasha Levin <sashal@kernel.org>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Rik van Riel <riel@surriel.com>,
 Peter Zijlstra <peterz@infradead.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Nadav Amit <namit@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

From: Nadav Amit <namit@vmware.com>

This is a respin of a rebased version of an old series, which I did not
follow, as I was preoccupied with personal issues (sorry).

The series improve TLB shootdown by flushing the local TLB concurrently
with remote TLBs, overlapping the IPI delivery time with the local
flush. Performance numbers can be found in the previous version [1].

The patches are essentially the same, but rebasing on the last version
required some changes. I left the reviewed-by tags - if anyone considers
it inappropriate, please let me know (and you have my apology).

[1] https://lore.kernel.org/lkml/20190823224153.15223-1-namit@vmware.com/

v4 -> v5:
* Rebase on 5.11
* Move concurrent smp logic to smp_call_function_many_cond() 
* Remove SGI-UV patch which is not needed anymore

v3 -> v4:
* Merge flush_tlb_func_local and flush_tlb_func_remote() [Peter]
* Prevent preemption on_each_cpu(). It is not needed, but it prevents
  concerns. [Peter/tglx]
* Adding acked-, review-by tags

v2 -> v3:
* Open-code the remote/local-flush decision code [Andy]
* Fix hyper-v, Xen implementations [Andrew]
* Fix redundant TLB flushes.

v1 -> v2:
* Removing the patches that Thomas took [tglx]
* Adding hyper-v, Xen compile-tested implementations [Dave]
* Removing UV [Andy]
* Adding lazy optimization, removing inline keyword [Dave]
* Restructuring patch-set

RFCv2 -> v1:
* Fix comment on flush_tlb_multi [Juergen]
* Removing async invalidation optimizations [Andy]
* Adding KVM support [Paolo]

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org

Nadav Amit (8):
  smp: Run functions concurrently in smp_call_function_many_cond()
  x86/mm/tlb: Unify flush_tlb_func_local() and flush_tlb_func_remote()
  x86/mm/tlb: Open-code on_each_cpu_cond_mask() for tlb_is_not_lazy()
  x86/mm/tlb: Flush remote and local TLBs concurrently
  x86/mm/tlb: Privatize cpu_tlbstate
  x86/mm/tlb: Do not make is_lazy dirty for no reason
  cpumask: Mark functions as pure
  x86/mm/tlb: Remove unnecessary uses of the inline keyword

 arch/x86/hyperv/mmu.c                 |  10 +-
 arch/x86/include/asm/paravirt.h       |   6 +-
 arch/x86/include/asm/paravirt_types.h |   4 +-
 arch/x86/include/asm/tlbflush.h       |  48 +++----
 arch/x86/include/asm/trace/hyperv.h   |   2 +-
 arch/x86/kernel/alternative.c         |   2 +-
 arch/x86/kernel/kvm.c                 |  11 +-
 arch/x86/mm/init.c                    |   2 +-
 arch/x86/mm/tlb.c                     | 177 +++++++++++++++-----------
 arch/x86/xen/mmu_pv.c                 |  11 +-
 include/linux/cpumask.h               |   6 +-
 include/trace/events/xen.h            |   2 +-
 kernel/smp.c                          | 148 +++++++++++----------
 13 files changed, 242 insertions(+), 187 deletions(-)

-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
