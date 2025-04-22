Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444F225335A
	for <virtualization@lists.linux.dev>; Tue, 22 Apr 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745310198; cv=none; b=toY0NmcWUZpy7Rl8AV5f84RQ7lzkA6MbywtBVEr0HUCxubFi9T29X5nSYZP88eo/mej5m6urMQ4Y8k5+tsJb6OclcHASDHtios9eZk2frxY2yHMysWcLCwpRgYy/+/STkFm8EVDbRhEYgw0FRGuf8LPSca+prsqdK/wtEBEXMNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745310198; c=relaxed/simple;
	bh=Umn2nybDh+IGdK7RwOrwJ3nbRm48MiJ42+qU3IFtNQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s8aq67A6uZ3Yw4n1a4NQYvsWhhSC/gx3WybkydUwwVMqySQp8kLa6Xbj7pcbv4LAleWnFNKM3UQQz+rAkkaRzkMSU5npxcnwW+rDJZ4ZoZ2nKWxv5gPOmu4/jREdN77RPFz4l1HFkiOVzHJRbs1Ybi5Dw/4nCiGJH0exi54kUO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=KtH0j43n; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KtH0j43n"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53M8MG9R1954391
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 22 Apr 2025 01:22:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53M8MG9R1954391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1745310169;
	bh=hElDV5Vze4WAsf0tFZEf35YrdP6qWjxDv4JzPANXVNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KtH0j43nk+Duf810zw1CEZbj53zexfsA4TSV0B76pxE9B3Sj1oCxiID+KXn1gmORq
	 vu21eQ4c+tmMchOpXFtsfl+poNPSuVCMyQEoTucNuKqh68DeJWNwQYHG2wEEn23sg+
	 1dLcK1ohYsx8lYF42FO6EUtkBUGnHmF1DeuOngZIDHY1MY+76NmeADYp9e+nBhq8bn
	 Ehm+TadXMIp/OyRm+L7atsclg5gNJjCVXv+kLzElC+F0KilwKtEZ9UNRRrcN6CG/Lv
	 Xdp6B4Pk8wYadmONeIh3mea2pnQKdrfmQDXjlUn7TWOlTGJbb5C8vw+ahCl0mRZQEL
	 y0QzP7N4WO1Mw==
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
        haiyangz@microsoft.com, decui@microsoft.com
Subject: [RFC PATCH v2 13/34] x86/xen/msr: Remove the error pointer argument from set_reg()
Date: Tue, 22 Apr 2025 01:21:54 -0700
Message-ID: <20250422082216.1954310-14-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422082216.1954310-1-xin@zytor.com>
References: <20250422082216.1954310-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_reg() is used to write the following MSRs on Xen:

    MSR_FS_BASE
    MSR_KERNEL_GS_BASE
    MSR_GS_BASE

But none of these MSRs are written using any MSR write safe API.
Therefore there is no need to pass an error pointer argument to
set_reg() for returning an error code to be used in MSR safe APIs.

Remove the error pointer argument.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/xen/enlighten_pv.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index b5a8bceb5f56..9a89cb29fa35 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1111,17 +1111,11 @@ static u64 xen_do_read_msr(unsigned int msr, int *err)
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
 
@@ -1138,15 +1132,15 @@ static void xen_do_write_msr(unsigned int msr, unsigned int low,
 
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

