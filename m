Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AF0C46467
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 06:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0FDA817ED;
	Mon, 16 Jan 2023 06:02:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0FDA817ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QlUZBmLzzlfe; Mon, 16 Jan 2023 06:02:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 71EB281773;
	Mon, 16 Jan 2023 06:02:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71EB281773
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D9FBC0033;
	Mon, 16 Jan 2023 06:02:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 019B6C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 06:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFAA5817C3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 06:02:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFAA5817C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KmrGYNaJae2f
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 06:02:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8B9381773
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu
 [128.30.2.78])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8B9381773
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 06:02:45 +0000 (UTC)
Received: from [128.177.82.146] (helo=srivatsa-dev.eng.vmware.com)
 by outgoing2021.csail.mit.edu with esmtpa (Exim 4.95)
 (envelope-from <srivatsa@csail.mit.edu>) id 1pHIZd-00EV5m-KZ;
 Mon, 16 Jan 2023 01:02:25 -0500
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/hotplug: Do not put offline vCPUs in mwait idle state
Date: Sun, 15 Jan 2023 22:01:34 -0800
Message-Id: <20230116060134.80259-1-srivatsa@csail.mit.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: x86@kernel.org, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, ganb@vmware.com, ankitja@vmware.com,
 namit@vmware.com, amakhalov@vmware.com, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, bordoloih@vmware.com,
 xen-devel@lists.xenproject.org, Wyes Karny <wyes.karny@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, keerthanak@vmware.com,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>, Lewis Caroll <lewis.carroll@amd.com>,
 blamoreaux@vmware.com
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

From: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>

Under hypervisors that support mwait passthrough, a vCPU in mwait
CPU-idle state remains in guest context (instead of yielding to the
hypervisor via VMEXIT), which helps speed up wakeups from idle.

However, this runs into problems with CPU hotplug, because the Linux
CPU offline path prefers to put the vCPU-to-be-offlined in mwait
state, whenever mwait is available. As a result, since a vCPU in mwait
remains in guest context and does not yield to the hypervisor, an
offline vCPU *appears* to be 100% busy as viewed from the host, which
prevents the hypervisor from running other vCPUs or workloads on the
corresponding pCPU. [ Note that such a vCPU is not actually busy
spinning though; it remains in mwait idle state in the guest ].

Fix this by preventing the use of mwait idle state in the vCPU offline
play_dead() path for any hypervisor, even if mwait support is
available.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Wyes Karny <wyes.karny@amd.com>
Cc: Lewis Caroll <lewis.carroll@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Alexey Makhalov <amakhalov@vmware.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: virtualization@lists.linux-foundation.org
Cc: kvm@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
---

v1: https://lore.kernel.org/lkml/165843627080.142207.12667479241667142176.stgit@csail.mit.edu/

 arch/x86/kernel/smpboot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 55cad72715d9..125a5d4bfded 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1763,6 +1763,15 @@ static inline void mwait_play_dead(void)
 		return;
 	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
 		return;
+
+	/*
+	 * Do not use mwait in CPU offline play_dead if running under
+	 * any hypervisor, to make sure that the offline vCPU actually
+	 * yields to the hypervisor (which may not happen otherwise if
+	 * the hypervisor supports mwait passthrough).
+	 */
+	if (this_cpu_has(X86_FEATURE_HYPERVISOR))
+		return;
 	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
 		return;
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
