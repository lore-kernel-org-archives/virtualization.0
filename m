Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BABF24EF6D
	for <virtualization@lists.linux.dev>; Sun, 27 Apr 2025 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745745683; cv=none; b=nniQ1B821akCnmscDYPBINrOMwpbWFYeANOtxGTgFP6wCekFI8yA5ZmrTkoElKO/TsaSwwfC7VSia6ItLl9NNZIK56nbiNAsGjlgco/gk7Vq23EWRddYb8FWPgvvqcnAjRbYsPuDLyfDyLDvlIGwobkJUhmzCy3Ug/rR4yljhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745745683; c=relaxed/simple;
	bh=FAdq6ToSrkZ1v9RbmfT0ZshNIWnj/wjai1A1DP2J6q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3lnexquLITKPvl0GVvgF5hmPNqQhUONeBfMw0W6QKvQS1cw9XfMg7gtDVQevg3rHNOc6Ee4nZ5lXijteYHWaKVhqQSc04SoMXh4ZNHNELfSQI7AVX+06AvOm1LzWT4EIyFEuWRBMD+JmgSPmFZHJY3UWZeQIP09qLI2h9537sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=D0Z3JphR; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="D0Z3JphR"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53R9KRS91598826
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 27 Apr 2025 02:20:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53R9KRS91598826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1745745658;
	bh=poLuCOtMFQCl7P/FC7Lp5EQw98+Q3dUwMneiYGrrVc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0Z3JphR30AQW+3j6oRkGj/eZF9EDJwfOTUKrT6busV8ib1cm4rRHxVn8xnMn2dRi
	 4msTB2mg+Fyb7ivuH2KqHR9+Aez0rjMOvFOjl6MRfPD0NDiTt/EhkXcR/cYdMH0yE/
	 UURFhqyp8deXUeSzTNivEFL4k0UdAZNWB+G/DCGjkD2GQTPTbuq1jFZtJngGbKZw5/
	 SZlagdAbjZpUIIWdZnVXImCueJbTNHF9Zi+nnVvnxWqc5Fa8+a+8ZErMzXTJPVOOy1
	 YiPnW9YklNd0V7B62LnCJdQ6XcjQuBniinamKhUatno7C/H8ptJTOtaShyOxVU3pf0
	 Y7M6wIaYIlQug==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-edac@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, jgross@suse.com, andrew.cooper3@citrix.com,
        peterz@infradead.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        wei.liu@kernel.org, ajay.kaher@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, tony.luck@intel.com,
        pbonzini@redhat.com, vkuznets@redhat.com, seanjc@google.com,
        luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com,
        dapeng1.mi@linux.intel.com, ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 12/15] x86/xen/msr: Remove the error pointer argument from set_seg()
Date: Sun, 27 Apr 2025 02:20:24 -0700
Message-ID: <20250427092027.1598740-13-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250427092027.1598740-1-xin@zytor.com>
References: <20250427092027.1598740-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_seg() is used to write the following MSRs on Xen:

    MSR_FS_BASE
    MSR_KERNEL_GS_BASE
    MSR_GS_BASE

But none of these MSRs are written using any MSR write safe API.
Therefore there is no need to pass an error pointer argument to
set_seg() for returning an error code to be used in MSR safe APIs.

Remove the error pointer argument.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

Change in v3:
*) Fix a typo: set_reg() => set_seg() (Juergen Gross).
---
 arch/x86/xen/enlighten_pv.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 528a2f4df050..c247e7689bc3 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1110,17 +1110,11 @@ static u64 xen_do_read_msr(unsigned int msr, int *err)
 	return val;
 }
 
-static void set_seg(unsigned int which, unsigned int low, unsigned int high,
-		    int *err)
+static void set_seg(u32 which, u32 low, u32 high)
 {
 	u64 base = ((u64)high << 32) | low;
 
-	if (HYPERVISOR_set_segment_base(which, base) == 0)
-		return;
-
-	if (err)
-		*err = -EIO;
-	else
+	if (HYPERVISOR_set_segment_base(which, base))
 		WARN(1, "Xen set_segment_base(%u, %llx) failed\n", which, base);
 }
 
@@ -1136,15 +1130,15 @@ static void xen_do_write_msr(unsigned int msr, unsigned int low,
 
 	switch (msr) {
 	case MSR_FS_BASE:
-		set_seg(SEGBASE_FS, low, high, err);
+		set_seg(SEGBASE_FS, low, high);
 		break;
 
 	case MSR_KERNEL_GS_BASE:
-		set_seg(SEGBASE_GS_USER, low, high, err);
+		set_seg(SEGBASE_GS_USER, low, high);
 		break;
 
 	case MSR_GS_BASE:
-		set_seg(SEGBASE_GS_KERNEL, low, high, err);
+		set_seg(SEGBASE_GS_KERNEL, low, high);
 		break;
 
 	case MSR_STAR:
-- 
2.49.0

