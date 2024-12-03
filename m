Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85429CEB
	for <virtualization@lists.linux.dev>; Tue,  3 Dec 2024 01:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187631; cv=none; b=VsspF+UDTix/Hb3NipjB7jNW9vscdk6HpC/nu8mU88/A4pRT1B1IwGSIXyXdsfNBC9ZRXmqwxuFRTnuU3XhTRvfEf2Rst8jYTWYWy2r+jW0Q0HrYZ+tEMt7sWfh7ZUriXiW3jUEb605qPUY53uf4bP3wwaXtJIZB+P5eMO2Dszc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187631; c=relaxed/simple;
	bh=xMS1uH7AFuF+2czM41v55mFLwPP1FGhTkUrAHqIpFLQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SFti2vd2KgkuOxpLWCL7h8f2Sjf6XujIeMcYjkFSrpYoxn/6ac574Yir34jlVx087386Xd52ksvSPanjE74EkwocFj9VRDPXo+Zf7VsIHLX4YsuIITxwB0nB0PhJol9kNA+MwpbFhnrasVUuEatlHw2hj/2QyD7a3REIp2vMX8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnuS7sLD; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnuS7sLD"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-8418307b4f9so501186039f.1
        for <virtualization@lists.linux.dev>; Mon, 02 Dec 2024 17:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733187629; x=1733792429; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HXZpw0j64Kx8pQRMw/cVhgPa64V3XlxKoRy53BFPQ2Y=;
        b=wnuS7sLDmbNiJKXo2/oMF1aClMdaum/OMV4VqJdBWgcbKwaGOGRypzOMJ9NDdyEsuS
         w3sBjZg1LURw1HZe3Div9UeOzqwZLHS3/+DTUQBfQg/ng15HwDacZkMbDXd21LKPKpGU
         mO8JqOkCt2UGGwm1fLGedPLlkdE6yMDqFwDiVrmmlovNjUhrY7uYMMlMi+sT5qFe69Gi
         aMZlIpdak5ZICCgW5E44k5fysVrDBVFmFBKPqMte4/IXTgzIvOpA1qr6NEy2U5LYoo+o
         fXtBhpUwNdPAD83mmC/AFyCpiT9mqkObYHFTabS8wcmf/WMwiiHbqM26kE+/x5xdhzEY
         aMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733187629; x=1733792429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXZpw0j64Kx8pQRMw/cVhgPa64V3XlxKoRy53BFPQ2Y=;
        b=s60nGwQYJ7oz7z1lkAztc2ksR3Yhl+H29k/TVFB8LENiCYRa2VfIm3k/5HG8VoXAtR
         yaBs5MK+j3aA43hswjNr6BwhPiWMPazzGhoOHqA/m4iTpIY9mfAHWsKko1tfsSP4AUEw
         zt1h6Ykx0p8rvJRqwrvTJvLpAhIXDcCtDgBeTU4mVCuScsgDQVmV/Ab/iUPkjhSZyRA+
         e25BsBuatRlOzW8B0SX8N1316WD+mLSOy9+yWGPoc7QRZTNK7o93d6J1v0AdEcrLlU6/
         JoNlLJPjHo+Diicou6drdFhi7BG9NvHxiidHfNOVGuHug3MiBneRNhXEAi1XCumUR2wZ
         3Zow==
X-Forwarded-Encrypted: i=1; AJvYcCVE4Upmn8WzhSCOL/ibSDw1OZ70iVSz1Mr0TnXDK39qp4ccOD9GeW6pG4bwhBOGdWwl7WrXUOvngUpPJOclvg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWzeqiXrc6zp5mFbPALxGYQD9flWv1pHHQNWVOz7GiOUuMzUVg
	xBqFt0Do4KtRqXGQonMX7Kc2wZ5j5Tbl7vI6EU6xv6gIb+au1HtLtc6nT88OJv2QmIUWI2SL4pW
	95aZctmdWc4P/1geB+fWBebwMefg9dA==
X-Google-Smtp-Source: AGHT+IEZmspYrC4umegddmCrbePNuN6PHswfr1n3f4QWHFbbvkBj0Jxf86Z77+97glx5zKlFrBkgAIn3Vka01mS0VDUG
X-Received: from iotr20.prod.google.com ([2002:a05:6602:2354:b0:841:8ee4:fc23])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6602:6422:b0:83a:db84:41a8 with SMTP id ca18e2360f4ac-8445b5ccdddmr90500239f.10.1733187629246;
 Mon, 02 Dec 2024 17:00:29 -0800 (PST)
Date: Tue,  3 Dec 2024 00:59:21 +0000
In-Reply-To: <20241203005921.1119116-1-kevinloughlin@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241203005921.1119116-1-kevinloughlin@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203005921.1119116-3-kevinloughlin@google.com>
Subject: [RFC PATCH 2/2] KVM: SEV: Prefer WBNOINVD over WBINVD for cache
 maintenance efficiency
From: Kevin Loughlin <kevinloughlin@google.com>
To: linux-kernel@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, thomas.lendacky@amd.com, 
	pgonda@google.com, sidtelang@google.com, mizhang@google.com, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	bcm-kernel-feedback-list@broadcom.com, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

AMD CPUs currently execute WBINVD in the host when unregistering SEV
guest memory or when deactivating SEV guests. Such cache maintenance is
performed to prevent data corruption, wherein the encrypted (C=1)
version of a dirty cache line might otherwise only be written back
after the memory is written in a different context (ex: C=0), yielding
corruption. However, WBINVD is performance-costly, especially because
it invalidates processor caches.

Strictly-speaking, unless the SEV ASID is being recycled (meaning all
existing cache lines with the recycled ASID must be flushed), the
cache invalidation triggered by WBINVD is unnecessary; only the
writeback is needed to prevent data corruption in remaining scenarios.

To improve performance in these scenarios, use WBNOINVD when available
instead of WBINVD. WBNOINVD still writes back all dirty lines
(preventing host data corruption by SEV guests) but does *not*
invalidate processor caches.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 arch/x86/kvm/svm/sev.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 943bd074a5d3..dbe40f728c4b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -116,6 +116,7 @@ static int sev_flush_asids(unsigned int min_asid, unsigned int max_asid)
 	 */
 	down_write(&sev_deactivate_lock);
 
+	/* SNP firmware expects WBINVD before SNP_DF_FLUSH, so do *not* use WBNOINVD */
 	wbinvd_on_all_cpus();
 
 	if (sev_snp_enabled)
@@ -710,6 +711,14 @@ static void sev_clflush_pages(struct page *pages[], unsigned long npages)
 	}
 }
 
+static void sev_wb_on_all_cpus(void)
+{
+	if (boot_cpu_has(X86_FEATURE_WBNOINVD))
+		wbnoinvd_on_all_cpus();
+	else
+		wbinvd_on_all_cpus();
+}
+
 static unsigned long get_num_contig_pages(unsigned long idx,
 				struct page **inpages, unsigned long npages)
 {
@@ -2774,11 +2783,11 @@ int sev_mem_enc_unregister_region(struct kvm *kvm,
 	}
 
 	/*
-	 * Ensure that all guest tagged cache entries are flushed before
-	 * releasing the pages back to the system for use. CLFLUSH will
-	 * not do this, so issue a WBINVD.
+	 * Ensure that all dirty guest tagged cache entries are written back
+	 * before releasing the pages back to the system for use. CLFLUSH will
+	 * not do this without SME_COHERENT, so issue a WB[NO]INVD.
 	 */
-	wbinvd_on_all_cpus();
+	sev_wb_on_all_cpus();
 
 	__unregister_enc_region_locked(kvm, region);
 
@@ -2900,11 +2909,11 @@ void sev_vm_destroy(struct kvm *kvm)
 	}
 
 	/*
-	 * Ensure that all guest tagged cache entries are flushed before
-	 * releasing the pages back to the system for use. CLFLUSH will
-	 * not do this, so issue a WBINVD.
+	 * Ensure that all dirty guest tagged cache entries are written back
+	 * before releasing the pages back to the system for use. CLFLUSH will
+	 * not do this without SME_COHERENT, so issue a WB[NO]INVD.
 	 */
-	wbinvd_on_all_cpus();
+	sev_wb_on_all_cpus();
 
 	/*
 	 * if userspace was terminated before unregistering the memory regions
@@ -3130,12 +3139,12 @@ static void sev_flush_encrypted_page(struct kvm_vcpu *vcpu, void *va)
 	 * by leaving stale encrypted data in the cache.
 	 */
 	if (WARN_ON_ONCE(wrmsrl_safe(MSR_AMD64_VM_PAGE_FLUSH, addr | asid)))
-		goto do_wbinvd;
+		goto do_wb_on_all_cpus;
 
 	return;
 
-do_wbinvd:
-	wbinvd_on_all_cpus();
+do_wb_on_all_cpus:
+	sev_wb_on_all_cpus();
 }
 
 void sev_guest_memory_reclaimed(struct kvm *kvm)
@@ -3149,7 +3158,7 @@ void sev_guest_memory_reclaimed(struct kvm *kvm)
 	if (!sev_guest(kvm) || sev_snp_guest(kvm))
 		return;
 
-	wbinvd_on_all_cpus();
+	sev_wb_on_all_cpus();
 }
 
 void sev_free_vcpu(struct kvm_vcpu *vcpu)
@@ -3858,7 +3867,7 @@ static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
 		 * guest-mapped page rather than the initial one allocated
 		 * by KVM in svm->sev_es.vmsa. In theory, svm->sev_es.vmsa
 		 * could be free'd and cleaned up here, but that involves
-		 * cleanups like wbinvd_on_all_cpus() which would ideally
+		 * cleanups like sev_wb_on_all_cpus() which would ideally
 		 * be handled during teardown rather than guest boot.
 		 * Deferring that also allows the existing logic for SEV-ES
 		 * VMSAs to be re-used with minimal SNP-specific changes.
-- 
2.47.0.338.g60cca15819-goog

