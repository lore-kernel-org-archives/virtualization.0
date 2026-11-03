Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690162;
	b=2QaCjtmQqyusAvvivf6g1cN319thA0GR3krPZ04tnzCy3S6v+0Cmma7gysgDVoLE6SIV
	 Nc+xoRsjR0ix3sjQnKP20j5LQajCYZWn3/N/G96onWyxILcdld0OEtxNn85fsLT7de5rs
	 2iR4F5RXYa3Kr1yYI3SdO5TqeIxaY6d9AxKxGICAHEAoy+DdeOqq6GVgdeP1MnwFVO6y6
	 cx3aDDyU/G3t2wgD+GWgMMZwIhE8K5a2iKjAdiKHUP5WporMUypxh+XgedpgGr/rUrhni
	 uFCu9jjeCXvBlDfn/z9s9NmpwDzttuUakHnGkddmP7KmaEgew6j8E5umulaAYyB4IWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690162;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=q4y6B1icyNzjJObRP5v2+iWtsvF0W+PG7Ux6Z6hjgbY=;
	b=nAGEPtTKN2qfkd1XmzKNqORR4IwbQixJ4uXeaQNcTh1/ilLP7s7XE3k2PyYxCrUbWOK3
	 z0u9HTGF7OzczeJNMmgxm+JKDCt6SlbHnnABDVPpORqtc8J636ybjssUEVy3Tz9Xjtp9q
	 5MHOAJmZrhANFP8TxLrMztYlKs22IEX4ChliQVhEdWo9EmPeocfrMnKkpCDcv4KIKfLAa
	 AMvUGQ/4ssMh6mKhU9jO8RK37ldxPSNlOC0R7wt1+hxQ0Qo5CJ4uQs1lTIkjGpWFDMBmu
	 esLuQ6fILywtadUw7WQBPunv7+SSsuWxDiDwAHCIjzj26fp3TGFH3m3Llk+MADSNbug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GhECud09;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E1606A334
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 07:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 965E1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GhECud09
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2eb0f1b592bso12694605ad.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 23:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690161; x=1794294961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4y6B1icyNzjJObRP5v2+iWtsvF0W+PG7Ux6Z6hjgbY=;
        b=eQJDHDsEaPiItBOhcGb4szOrpxTxCWngPRi42VmMQ4cUxHOJL4iVlB4tYteqKKrf7w
         zo/JFO1XuVpJTpx8kmpzWriNYQiqjDIEWXGqTPNRkynQS9UNZnTlsxk6CBbDMIjPk6yE
         I33O5pVnN0hZNULzWhjsJLgfEYDNzlvB2nzw5KDDLOU2MBIPJ4HeyKsFP4WDeiqeUtAy
         x7If7Ym7Cu/uoq8Ubzqj1l+83S3+Yf1WzE3B0rwTXjLf353isGZAOmjnGfPzMfZYap3r
         4CiYNbkl1rTCPJRcsqpe+9fEkFFOA0MlMJpN0eTXnWb4XFtGYlVBHgubWIrO9LUJ45j+
         r6Zw==
X-Forwarded-Encrypted: i=1; AKwUvBxfMK8VaOexYAtLjlupqBVgcjaVk1xnfGi76cszYJ966vCbTAocHZfLicKUqtccIrp6fDYtGyeZsXffklKaUg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+hsiKWX8gamGwQPgNX5SJHbSCK0jTgvtVE/270I+jw22InrqBw
	PfoVAzfr1Awdu8pQknC3k+Y7JPBZpahof1ntcT3tt4koGg9upppbH5Qo3gaYOFccACMV3GB+TPr
	/WdUm7pKPoRWMXbbLGZJhCarrIK7RcjUCVmzP5OUq/GiitijCmwCZblYBeBqVgjHEFZ9cdmW6GO
	45u04Pdyg8eWJ9HupbDhvJFHFvmwzJHw94ahir06PFL3V/PjWj/oLa1w/lC6tVJrYqFJu9aFX1a
	iNVRsBDWwYsKlsdpAk=
X-Gm-Gg: AYBFou0hA/4f4+R+q/vnqftP8pbU+tB/tZAf2Z3kDuLhf586uig2d3ogfBAgWcNrCd/
	f1IJ+Zu0QqrNoeemLocJgUtHWqaWEBvLgigFNrE68G+q7QVde6YjScWQqKss6new3CvOxjPwF7x
	bltF+KuiEv65ZWEuCSNRP2jI2UfrElIX/98kD3yAocT95cBNqKP6DvcxcgU/N9QZ8pYmyCVjV7i
	eCqVPgVf/mo70VcCmFYj3GRwzUCqIDCN4XtEjxedxt1oFy30JFSRkFhhA7uSoew3dZpA6uPqbz0
	b36xP79pXAg8mVlcuJm0hy7HZoBABgci6gGgye9yUjaac0m92DDZFS7TZtp0c/sMa5uifNsne9F
	ksJTZfSHRTfrOkVzMWlYV7fGecXUlwTHqoMziBGctggoaUr6w8uIwzA+ylToBM+YTmenIE+pq+0
	m2x/203XkV4QZgcPTE5mxVifC9iItoRNmM
X-Received: by 2002:a17:903:285:b0:2d8:d4cd:dc8f with SMTP id d9443c01a7336-2eb36426f25mr118120485ad.18.1793690160783;
        Mon, 02 Nov 2026 23:16:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eb3922cbb8sm1675955ad.12.2026.11.02.23.16.00
        for <virtualization@lists.linux.dev>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:16:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1e62510cso846446685a.1
        for <virtualization@lists.linux.dev>; Mon, 02 Nov 2026 23:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793690159; x=1794294959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4y6B1icyNzjJObRP5v2+iWtsvF0W+PG7Ux6Z6hjgbY=;
        b=GhECud09CCG2xDSX3qdfb2dUa25DXE0ZtWCEIeulEoqEBZN+lYO3gK5CPPU/nBi9pY
         QjdnUj/9Efa8smtWYtZjwRG3/nTXc0OFLPU+LHhHqH66+L3xWrbbTjIsRJxFqUkyx/Lu
         qocYx55XFx1NmaMNjrEprxWh4ry1qAql+cy20=
X-Forwarded-Encrypted: i=1; AKwUvBzW3JzalOH4z8IpN/TH7cWTp4nUCpTdiFcW7AwjfU4Znrkb2JhOpDPjcL0D9Ue1ek4XutdXhQvBnU4qhnY2Tw==@lists.linux.dev
X-Received: by 2002:a05:620a:2687:b0:943:b019:f011 with SMTP id af79cd13be357-94421719dd1mr1970190485a.28.1793690159388;
        Mon, 02 Nov 2026 23:15:59 -0800 (PST)
X-Received: by 2002:a05:620a:2687:b0:943:b019:f011 with SMTP id af79cd13be357-94421719dd1mr1970188385a.28.1793690158920;
        Mon, 02 Nov 2026 23:15:58 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2d2sm1018334585a.15.2026.11.02.23.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:15:52 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v3 3/3] x86/cpufeatures: Remove unused VMware hypercall feature bits
Date: Tue,  3 Nov 2026 02:14:58 -0500
Message-ID: <c8e57b19d95fd8ffbfd13e7ab1c1ade551b1bd7b.1793685318.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793685318.git.zack.rusin@broadcom.com>
References: <cover.1793685318.git.zack.rusin@broadcom.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The static-call conversion removed the alternative instruction templates
that used X86_FEATURE_VMCALL and X86_FEATURE_VMW_VMMCALL. Their remaining
users only force the bits during VMware setup; no code tests either bit.

Remove the forced capabilities and mark both positions free in the kernel
header. Neither feature has a cpuinfo name, so this changes no
userspace-visible flag.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/cpufeatures.h | 4 ++--
 arch/x86/kernel/cpu/vmware.c       | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61930f0d4578..b7633930020f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -233,8 +233,8 @@
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* "vmmcall" Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* Xen paravirtual guest */
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page Table access-dirty bit */
-#define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL instruction */
-#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
+// free: was #define X86_FEATURE_VMCALL ( 8*32+18) /* Hypervisor supports VMCALL */
+// free: was #define X86_FEATURE_VMW_VMMCALL ( 8*32+19) /* VMware prefers VMMCALL */
 // free: was #define X86_FEATURE_PVUNLOCK               ( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 6719c009f237..b5c1610ff408 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -492,10 +492,6 @@ static void __init vmware_set_capabilities(void)
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	if (vmware_tsc_khz)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMCALL);
-	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMW_VMMCALL);
 }
 
 static unsigned long
