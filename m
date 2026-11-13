Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533385;
	b=GUwqvhiWfKu5DGywtSEgkHEYUKsoVdino/uxrc9ZMr5LTpMdPcSFkEiSXDBSjBfE2SGD
	 XNdnXN+KgyOh+0uixPdPWi1lLRR9ymuMO6wkuAuGd56A+WH+IZLX2JOuYp33FCtAwDa7+
	 bYdn0zfPAebeAfj0YNIMbnCEHkCMA83EnC/vNuhNTib6JlTK9QDEewp1xswwVrak9/wHN
	 4TdkE/Y4hwa5735W91NvFQIMqO76WbRb2wjQrptzXNKIXeEFohsK4YqTzXjsWgfuJqDeS
	 yEBZQ9fGWRXtScMvzTSFloOfRHpnFutUIJifqERLEhl4NMRf/ABbn/49OqbvWsv/Tlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533385;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eEm4Qix6NtzscQvmZFr8J73RisDDpJq+6mqvimED2UE=;
	b=Xh9wPphWjPxtsLtM3yz71eWLk0b+OXIb0fO2SDEk6ewRHSPJrXktKCQClpSfP6cRoPxT
	 A103m1qblBjf36sba5I48or3AMMa2B+AthcFq4+CGq+IA6QFPaGhJJSWJmBWJJ6MUedZm
	 O99FUCGx50jIOcoHO9Ws/yIgfQnrgcuoOqxXWdSpCH+1QwTsPedAqS48y61VAchB1Gv0f
	 JXM6YgoZU7pXxrZ0eOMPoUPR7o/rLqyf2NizJg81yJqM4mO5JDHQmtyaL3gb4BwHymVkk
	 GDqyldfwnmxDhujwjzr9N/vPJayMATDT56oeKXkmoaVkMIut8esWaAlmiXLcISI8bVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2D606A32E
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 01:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFE2D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b20f2cacdf0111f19a56ed5b684f684d-20261113
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a1393f79-c721-4503-9941-82aec3f6bac4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:78c18e35f9b39b416e800ddba86a14e3,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|123|865|898,TC:nil,Content:0|15|50
	|99,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b20f2cacdf0111f19a56ed5b684f684d-20261113
X-User: zhaoguohan@kylinos.cn
Received: from ubuntu.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhaoguohan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 453346072; Fri, 13 Nov 2026 09:29:40 +0800
From: zhaoguohan@kylinos.cn
To: mst@redhat.com
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	eperezma@redhat.com,
	hpa@zytor.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	netdev@vger.kernel.org,
	tglx@kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	zhaoguohan@kylinos.cn
Subject: Re: [PATCH RFC] vhost: set dirty log bits without pinning pages on x86
Date: Fri, 13 Nov 2026 09:29:37 +0800
Message-ID: <20261113012937.40818-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
References: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
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

On Thu, Nov 12, 2026 at 05:53:47AM -0500, Michael S. Tsirkin wrote:
> vhost had a TODO to replace page pinning with a version
> of set_bit that works on userspace memory, since forever.
>
> It is really best to avoid GUP on fast path entirely.
> Implement set_user_bit and use it in vhost, to do just that.
[...]
> lightly tested. pls test and resubmit with your tool.

Thanks, this is much simpler than my version. Two comments on
set_bit_user() before I resubmit:

> +	int __err = 0;							\
> +	__uaccess_begin();						\
> +	asm volatile("\n"						\
> +		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
> +		     "2:\n"						\
> +		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
> +					   %[errout])			\
> +		     : [errout] "=r" (__err),				\
> +		       [ptr] "+m" (*(u8 __user *)(addr))		\

errout is only written on the fixup path, so it needs "+r", as in
__try_cmpxchg_user_asm(). With "=r" gcc drops the initialisation; here
(gcc 13.3, x86_64_defconfig) it even shares a register with mask:

     1a3:	lock or %dl,(%rax)
     1a9:	test   %edx,%edx
     1ab:	jne    1bd <log_write+0x5d>
     ...
     1bd:	mov    $0xfffffff2,%eax

so every call returns -EFAULT, and log_write() stops after the first
page.

> +	__uaccess_begin();						\

No access_ok() here. vhost checks the log range when it is set up and
I couldn't find a way around that, but GUP used to reject kernel
addresses by itself. user_access_begin() would keep the check (and the
nospec barrier) local. Something like this, build-tested on x86_64 and
i386 only:

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -597,19 +597,23 @@ _label:									\
 /* set_bit() on a byte of user memory; returns -EFAULT on fault. */
 #define set_bit_user(nr, addr)					\
 ({									\
-	int __err = 0;							\
-	__uaccess_begin();						\
-	asm volatile("\n"						\
-		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
-		     "2:\n"						\
-		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
-					   %[errout])			\
-		     : [errout] "=r" (__err),				\
-		       [ptr] "+m" (*(u8 __user *)(addr))		\
-		     : [mask] "q" ((unsigned char)BIT(nr))		\
-		     : "memory", "cc");				\
-	__uaccess_end();						\
-	__err ? -EFAULT : 0;						\
+	u8 __user *__p = (addr);					\
+	int __err = -EFAULT;						\
+	if (user_access_begin(__p, sizeof(*__p))) {			\
+		__err = 0;						\
+		asm volatile("\n"					\
+			     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"	\
+			     "2:\n"					\
+			     _ASM_EXTABLE_TYPE_REG(1b, 2b,		\
+						   EX_TYPE_EFAULT_REG,	\
+						   %[errout])		\
+			     : [errout] "+r" (__err),			\
+			       [ptr] "+m" (*__p)			\
+			     : [mask] "q" ((unsigned char)BIT(nr))	\
+			     : "memory", "cc");			\
+		user_access_end();					\
+	}								\
+	__err;								\
 })
 
 /*

If this looks right, I'll fold it in, run my test in a VM and resubmit
with the test as a second patch.

Thanks,
Khan
