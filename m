Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB332D7F4
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 09:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606006; cv=none; b=LI5T30heg2tqR3XW1UKQsUnGpCaKNMBH8OjeGJayYVT/sWM04vHXzTukNPXUvkRZpOD53EaMfwifBVQcusGSRIwhPLqsdhmSGSVC0j8a6g8HxLwwZvCvw/cOcrbk6f2O5pIjc/ai+XKrucfPxqRb1QdxfS9zgTghaSQoHTGXP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606006; c=relaxed/simple;
	bh=yZbyxtcRFT/Lb1Diixn5oiGwtslPu8jEsyaY/8ZMxcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CU9jC7iDuO2+C9HdCDFxpfbFdpWnIy13huxFAvxfZOfZb1dtuBfbe/OREAOzZtKL8r2NTa2QdMKYzpGwcG2m+1vYm0Epb6QUcDcW4ZHTqy1lL6BXXHHPldERp9yPltpDAimkArFtdUftOr8kjOqm4SF4t5YFcCxs/SwoOR8dmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak/KFK3W; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak/KFK3W"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b7cee045187so297820166b.0
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 01:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767605997; x=1768210797; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4KkUUmpJaT8WXzE5q0SPDr10JBD3nieG+D1UpKxwe0=;
        b=ak/KFK3WQurUqcKc6AOJrL3AkeTUB1TMFCCqdX+5i5WED3GlhHm+ApVF6Eqpc2ujdn
         mnWk9pymvx9Zvbl0N4d7enBPSyOcy8TqRfGLOYrLKBw6k7qzCLmcmMvduGcAVDfkZzt0
         Ue7JGyLpBJUq/cPOAIkNy+5OfR8OF2Gt83zA9gfSxQWofWB7whQJG1fG6cfsmlBNGNCZ
         VZxdulhy2Ejwv7Ugo/1Oc4fAPm40Q7PF5hAm+CzVzaFK//B5rFi68Vb1QrdEZgIijjHN
         CddYKJeHPfKG7B4NWPgIuPztZNA5/JEdUir+Y5YGsSxVWBJWLO3/Hl/gSUuv7Hb0P2Uq
         jusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767605997; x=1768210797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4KkUUmpJaT8WXzE5q0SPDr10JBD3nieG+D1UpKxwe0=;
        b=bsRYftZGyh2m28dS1IXh5SCTpq+DeUA/aIgru3ne7MM4KlB32yzFaLfYjPvRxE3zcE
         IQyMie3kvGegLsSU2bYVZOS6p9wP/q+XjNokjaxmTQf5bpFUwxf6CMTEDI7Q8Gn3EXDN
         pw02aAvB3ggOPvS9rT1ivz+faB7boqdpR1vff27ZabeYBlJba0X08cXF31MQ/zJudy8N
         mms6xyHZmDkNreGqaJLUiT41JtWjuSzDxW6u/VGjAcn4vtNPbRwhnHWuwICa4iPrYq13
         +2ZH4K0R2nDOOg3mJucB9OiKZyP8rVco4mEimXKS6XnIewMJmTHA1pE11sVJCwaV/34Q
         EiMA==
X-Forwarded-Encrypted: i=1; AJvYcCWLnBGKRuw6FzASX/QXXMOdmGXTmQz6922FAbAZv/K4EC5KtDsSdGONSsTxKD7cPsXtZF3NaBKWXaazNl93zQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YymlfQW0hPON1WRmlfPQ/GXaZPWt0VV23W+6Qqpmy40bq4oI2tN
	7/dpM40Efxp5PCgosOE8NVcRSFpVyLi9iAuXynGNJ0o+ASM8UPYB+TXV
X-Gm-Gg: AY/fxX75xnjQHRmA3KI2loA7v9LbV1GukMzbVhwysOPeSON6m9AuKNyoN2FHDELd76w
	n6qFI7xS9WACTLO5pr2MN650gFz/ysh7mBmOj7bqr2vQ0qO5dItrC5+nfvJB9AnyjHBmSPyEtos
	GvSjnQ/XPIhwCN20Rg8QihuDcIAvxbGA1OTHhi7M4KvwnZC6XyrZvoNU4FNOE15nFOLAeRDRFjA
	72KLq7a8NNqBvvglaYVjoZSQdwaGgQpE8FcNBfI6y7jHKw8twVF1cAar8+2q4kY0RFrFyFuBcJ2
	zDiw+4zQE7T21pKhZV7vtgFXZw9ZJM1zVCTAYnkbJvsnGzr1slEIvQTJZay3qVK6xh/WWIPVR7d
	jAlswr0SavAUcu6a3OdCQa+/Xk5XEzdLMOobE/0uL3RdbbVvGZcBjH8v0aDcobrpL+DzYuqEpgD
	7BlU+Fq/CkWNM2nOWLciKY/iwSKfswuSBTGFh1xqa2TGSarqCNYlTvTg==
X-Google-Smtp-Source: AGHT+IEVbdrZFRNA0RtVYHuo04RS+pjSOxfJqfDpy5JW3TAzvl0mx38pCS1oMImDRXcIEwFroBCGHw==
X-Received: by 2002:a17:906:318b:b0:b7c:e6fe:bc53 with SMTP id a640c23a62f3a-b83e25b406emr478883266b.7.1767605996934;
        Mon, 05 Jan 2026 01:39:56 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11dasm5393543466b.35.2026.01.05.01.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:39:56 -0800 (PST)
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
Subject: [PATCH RESEND 2/2] x86/paravirt: Use XOR r32,r32 to clear register in pv_vcpu_is_preempted()
Date: Mon,  5 Jan 2026 10:39:07 +0100
Message-ID: <20260105093944.52387-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105093944.52387-1-ubizjak@gmail.com>
References: <20260105093944.52387-1-ubizjak@gmail.com>
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
2.52.0

