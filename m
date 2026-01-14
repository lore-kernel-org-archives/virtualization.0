Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D6E35E55E
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425606; cv=none; b=tfN6M1JAojig3PnvMXB0//v2JO7D9tpBdfmSLy1RFdQZ8CNy/pLMt7PPzqW3m2UJuFMGFzRpob3rJX35OSqXxvQO+fU1AwSsYl8hE0BfShuxoKIFtn2Zd1qQiW1tZT9AXeuaEcn9LOl73+Xsdn0N2Kndpkt2MK1EddjeFO3rF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425606; c=relaxed/simple;
	bh=us+M3YunWEm7OzaqGsFQXt9sdJff3j8+XzA5/AnpV6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hO/TnnHKSZ4xn98jUd9599/5VbQMhrh7/+5EssWKypnL59wlnLUYFTjuNDVwZghWy5qdtqb24LgI9CtDAjgX+863YmDK+xzUbK23eC+s3FS6fVJpAx8g618vQChDI1DcoCB9RBpn2eq4/kvEMNwNLDBjZb3dnvkenIH1sWrA6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBzdDdlB; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBzdDdlB"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-65063a95558so334805a12.0
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 13:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768425603; x=1769030403; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTevTYSawAWXq7YTs2Qt887aQOG5Hk0w8Sw4qR5SlaQ=;
        b=GBzdDdlBlJcVOAyBp7sQhZklXrG7tupwGVeCWrYPqEjIfrAPQYQ9RGP0hbDOAK2oCi
         aGZn5HZbrioGt1IHG8gLluA3PbzaqjAZggU/u/JNRloQouNw2h9e+tOKpAJKbDYXtewu
         S65QZWOFTgsoUWUC5vpeFF6nKNBwCTuebZABTEABwAy+EPYQLp+DziD4xObFzKjYciLx
         aS56xN0fQEvAF57Yxn3YkRhsbBsJSdJcCFx+NMXQ/8l8PMdzOZIpuYvI17rlqgcl2LNa
         8BKZz9KA4KD/WNN0lsJtgI/BMZ9KrHVXRWzW5QKrxrGqLNTBfBustPuHw1HAbSkP6gLz
         o4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768425603; x=1769030403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OTevTYSawAWXq7YTs2Qt887aQOG5Hk0w8Sw4qR5SlaQ=;
        b=vNP9y4tKW4AlB44eN83f/dXCrZ305zKuwwoWInxgeRP/H3yEkvasrViCDwpjFNlJlt
         Ko355Xu+O+VRZs18QPRGol7LcE/p7K8fsM8EfGheVkIz41QhCgAa4uLBmZYB7b3Q1AWM
         MMLlGJgVrNBYs+EATzwSW0C15giOPdmaKcV4oi3s3w5KUI8r1C0SuR9mrgBy3AU7jdTY
         /jAEcha+0+8l5mJq52vpDV2JjH3P1gJByYDzF6/lyT6CF039rbRKpinvBsQsWs8CwXzz
         gBjJ09UywD2h3j+T32eSZr3BSX1LJbU5kffdMO0qCemIRpSgcLkIQgHnsVeX+rUMXNR/
         +rHA==
X-Forwarded-Encrypted: i=1; AJvYcCXobvXYMRp94bfFHnCC/EKbGGAQVLKJZDMQSM5yiIRorR8vxuaAz1s+ihhq7I9YVJqQb8I+bTXkQG9Ybza+kA==@lists.linux.dev
X-Gm-Message-State: AOJu0YycNTzbVKq5NC6N/TrlHwKYyaiY5HakcTiHZTvmgRg41w6+lBrx
	0UMUS7/cQFaGOC1k1Vg5i0heBOE54TwcKfcoYNhPZuH0UGz4rm7HfZW1
X-Gm-Gg: AY/fxX5CXRzRIlesQ7HSThrsBfYu09gJo+S3VJZD1fplKIkEb6Tv6LO7wj/qfDT0t3K
	Byb5kSc6lpVcXwEIB5Dx6s+65zx1y5V5mjpQL0m0ru4zRZp6czB6V2BBfafTtXDgDbYiAzBUcMx
	HjQZj/hthgO8KuwvECTaLGx5PxvrmQb19oFW+2ApXsTYKsyM+OZ9Ouxu54C6M7nmf6S3x19ney9
	RiPIZfYY5IxQkpW+gt6KCcU2ppFteN/a2tOg6n7Q9qi8MPe2hp6p1Alafr38Qo9iIurDnUqmamF
	/ptmezSYd06Z9hD4vGDKDWz2H+7a6LCuFRoU3XKiB3CxSUW9/aZeyt+wpUcjUVOHdNa3hMOIEnz
	GGyPrP8ssQGJyRpkWwK/RoRXGq4ctqpKc6OzaC7oQEwGj8Igy27RkgEC+jUC0MJw97qfgm5SiMx
	2zbu4lPmSUcx4UPHWRs3gcstf3cv/c/B9jVQfULNMkMsA=
X-Received: by 2002:a17:906:794d:b0:b72:6728:5bb1 with SMTP id a640c23a62f3a-b876127fea5mr371517566b.56.1768425603282;
        Wed, 14 Jan 2026 13:20:03 -0800 (PST)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f071e4sm683374166b.66.2026.01.14.13.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:20:02 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH RESEND 2/2]  x86/paravirt: Use XOR r32,r32 to clear register in pv_vcpu_is_preempted()
Date: Wed, 14 Jan 2026 22:18:15 +0100
Message-ID: <20260114211948.74774-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114211948.74774-1-ubizjak@gmail.com>
References: <20260114211948.74774-1-ubizjak@gmail.com>
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
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: "H. Peter Anvin" <hpa@zytor.com>
Acked-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/paravirt-spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/paravirt-spinlock.h
index 458b888aba84..7beffcb08ed6 100644
--- a/arch/x86/include/asm/paravirt-spinlock.h
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -45,7 +45,7 @@ static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
 	return PVOP_ALT_CALLEE1(bool, pv_ops_lock, vcpu_is_preempted, cpu,
-				"xor %%" _ASM_AX ", %%" _ASM_AX,
+				"xor %%eax, %%eax",
 				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
 }
 
-- 
2.52.0

