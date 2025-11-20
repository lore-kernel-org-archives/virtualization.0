Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2372F1FC9
	for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666249; cv=none; b=GHRQjp5YHJBPz0SZjvAH+5QyEBFPxh3iWWs5S+r0mijG3RDZIBO/8zdjCqsT+PMb0c0TG4KwdW+5gTenkskAhurY6DrEU4h4sGlVQTbuDhGcBv9XFy0fnr4ubcuJSpotjOJz7de8wiwY1WAn6JhocaGAonneptVYy5tn/G12jZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666249; c=relaxed/simple;
	bh=lSF5o0QHgr4nOMFjds/xaNSC9H1MDAf9Kuo3ZhgaGtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paLkjGAtKjpU9Ev95Pk5A/jWXRSDOADNu5jOiY44/qYDMQMoIqJ+HoawT8UhQPerzGDEO2ErgsCL/d5WlCDVpnXYz5tsUHXMHX0BowzOycZSAJgg2IDKZNrqmVJxzllilg/4HLQCBw506Tz6ivS7ghlsTJbkVAUW/qFLxq9Oaac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnAG2fY/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnAG2fY/"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so10917365e9.1
        for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 11:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763666244; x=1764271044; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBv4LnZykkOQ/TjccNpluaa1EqrXwtDl05wxHGmZf7c=;
        b=cnAG2fY/t/CzavKyxdlf9IdXsn/E0OsvVoxPNfGvKriypCRjFoVnWkvNlggmvSxEr7
         uATWheFodThZ247B1eNK58EoNuG+mvdcA8RUWE4BneuqnA99PPsyChWJzagZBKaPA3i5
         ARBvqpb5wmKzVgkaQEz24N0j6vz4H1wKwnaTdXnCPEMAiJg5jZBqqCYwbBUVTVEiXr9h
         G6M6ygsOjfC2CPJTyCy9E1K+FnRJ1YriGHW/rh2M0KEyjM16YYZRRyzcEyiVR0w+hEP4
         oOggctNGfM5/QZUyPnMkJyPvk5w+9WDTQAtSh6cF5sxWGltWsujVQmtecw3CfNFSDmBT
         MJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763666244; x=1764271044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBv4LnZykkOQ/TjccNpluaa1EqrXwtDl05wxHGmZf7c=;
        b=sVfixDqA3vXP0hoHU2dH0vxpqhKOmIJPGq+a4KjnQWTPA/GJisEYoncer3xT/UcL9t
         We9ldIhQRJ8kmqG9/p7HacWob1aqUWczMGDGULDlP3fizAddMTqXIKzVVhIh+yZjl4YX
         ab2jcjjAkil4A+b/O2BznfzB+RNzpxH2C1n+HzcrTWPIDBwuuCxlA5Ehn0z6W4falLQI
         74ywp658OhzZBBUB8FM4nHmsWPBrjXZDObqv0SHBs03MRSGtZqarnXEeOqq2YNDXRjw3
         Xu07sR2DWCWfVuIAHlM1XYVyoMYrBxmDLMoHDWxvb6xtg/Qgru/lgU8kmzg76+lgnDbQ
         Uryg==
X-Forwarded-Encrypted: i=1; AJvYcCUOE67kk/2dlr3Nbb2swf1YGD8rwDqAxg7CTAbSz9B0hVLqkSmQ/K3gBhz8rrdVv9X4br7dQBuHKCKtO1lIhA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNsoXztU05oreE280OcJHVxf7+lTM9FMno+bZgir8kTXxt/OCs
	XcegMF51WL+pYZAbL8zSVLF0gPFeIB5hVGDtoHLPW140r/bLD9CXix+W
X-Gm-Gg: ASbGnctnAbQZmJBMK0lPZa2OAevpqjsAOxs+WxFLiGiC1Uzt5fclLPJ3tfgKtlaDOxl
	Qg1vkDGwisbIoFPzABD9xACm2sn9K73VpAhuGz94SLg4DF6O2QsuV06ED/m+3yqdwNLvZ8I98zr
	KNoEde6ZmYtwWypuzevbHBGcgGpLWpDnid67lxp3zGcU2vO1uzjpJ3jMEAXL+fhpLQcISSvTYWX
	RfvNg8pqWPqC1Y1GHiILQ2falXYMJCW1cIFJLR+gYOmob6LgL3pr353uAft3SJ05elrcq08CPj6
	LCk8N1F+44T1jMe/zqBKDbF+LvhvgPTNoOrYaKSiH/7HVfJIAqRfRBsq7sCsKn4ejFuzMgAEKAh
	wulCWPtUwzU4fN80kIUsTbEWunJ2I1caSAE6hftc2cLdirGLfiP2JwP2IrJakXEybCQRRsu5okj
	cPa5j+mUchq2M6Z1ugTeI67g==
X-Google-Smtp-Source: AGHT+IGVY6pIz9XfoYqA36W2QChb0bpAxGKbTMb270edwXr3H1jsEhq8NuJH02oh2L+7Qe8LHs8RGA==
X-Received: by 2002:a05:600c:4685:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-477b8578e58mr41364515e9.1.1763666243780;
        Thu, 20 Nov 2025 11:17:23 -0800 (PST)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363b0sm7117884f8f.13.2025.11.20.11.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:17:23 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86/paravirt: Use XOR r32,r32 to clear register in pv_vcpu_is_preempted()
Date: Thu, 20 Nov 2025 20:15:57 +0100
Message-ID: <20251120191716.124642-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120191716.124642-1-ubizjak@gmail.com>
References: <20251120191716.124642-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86_64 zero extends 32bit operations, so for 64bit operands,
XOR r32,r32 is functionally equal to XOR r64,r64, but avoids
a REX prefix byte when legacy registers are used.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/paravirt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4f6ec60b4cb3..59aec695ae5f 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -577,7 +577,7 @@ static __always_inline void pv_kick(int cpu)
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
 	return PVOP_ALT_CALLEE1(bool, lock.vcpu_is_preempted, cpu,
-				"xor %%" _ASM_AX ", %%" _ASM_AX,
+				"xor %%eax, %%eax",
 				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
 }
 
-- 
2.51.1

