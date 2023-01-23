Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6CAC38142
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 20:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00E6460E9D;
	Mon, 23 Jan 2023 20:58:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00E6460E9D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=NIXtWepA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AQxb-K8Ev-jx; Mon, 23 Jan 2023 20:58:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0FC5860FC0;
	Mon, 23 Jan 2023 20:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FC5860FC0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC39C007D;
	Mon, 23 Jan 2023 20:58:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A839C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 337CE40B60
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 337CE40B60
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=NIXtWepA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IaPD9FP6-MG7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4D1B4010F
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4D1B4010F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=8Hefq63R1A5T8+z/XoUnS+Yx/XIKnxRs3D+68vKhmj0=; b=NIXtWepAGesH8iiidjMkReQ/Z7
 h8yMsVMS+oh33vrOdD3UNCMhlSwRACdr0gR0Ip1CBPek+Ecrceo3df9FmzfBHde2OJYKs+E0+03uk
 VFu7GwkoPnB+Hkiu9FfZ/mpX6GRxynOT9WsnY/eYCA1KBQZKTI8Fji1sWJLDGkPwh1Ld+VyLpyyH4
 No7/ULD+P03PaRIdlcDJDkdKdRoA40L7Hy2D3k1CGJJ9lZdLCBVpmVqPvHH+BwU2wk9lSXKhOh2M3
 M+fqQBblf6raJvLZ7EuXUUBqH63riEv2tbLKVx4nMNx3p65CwWYCgwNgJMGfjcXQ4mO35+VTkt3Ui
 QDQ7VoOg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pK3se-004WTx-5Q; Mon, 23 Jan 2023 20:57:28 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66F7D3008ED;
 Mon, 23 Jan 2023 21:57:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id C262A2075A6D7; Mon, 23 Jan 2023 21:57:24 +0100 (CET)
Message-ID: <20230123205514.944053334@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 23 Jan 2023 21:50:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Subject: [PATCH 1/6] x86: Always inline arch_atomic64
References: <20230123205009.790550642@infradead.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 peterz@infradead.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, tglx@linutronix.de, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, pv-drivers@vmware.com, mgorman@suse.de,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 boqun.feng@gmail.com, rostedt@goodmis.org, bp@alien8.de,
 vincent.guittot@linaro.org, boris.ostrovsky@oracle.com,
 dietmar.eggemann@arm.com, jgross@suse.com, seanjc@google.com,
 linux-kernel@vger.kernel.org, mhiramat@kernel.org, pbonzini@redhat.com,
 bristot@redhat.com
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

As already done for regular arch_atomic, always inline arch_atomic64.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/atomic64_32.h |   44 ++++++++++++++++++-------------------
 arch/x86/include/asm/atomic64_64.h |   36 +++++++++++++++---------------
 2 files changed, 40 insertions(+), 40 deletions(-)

--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -71,7 +71,7 @@ ATOMIC64_DECL(add_unless);
  * the old value.
  */
 
-static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
+static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	return arch_cmpxchg64(&v->counter, o, n);
 }
@@ -85,7 +85,7 @@ static inline s64 arch_atomic64_cmpxchg(
  * Atomically xchgs the value of @v to @n and returns
  * the old value.
  */
-static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
+static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 {
 	s64 o;
 	unsigned high = (unsigned)(n >> 32);
@@ -104,7 +104,7 @@ static inline s64 arch_atomic64_xchg(ato
  *
  * Atomically sets the value of @v to @n.
  */
-static inline void arch_atomic64_set(atomic64_t *v, s64 i)
+static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned high = (unsigned)(i >> 32);
 	unsigned low = (unsigned)i;
@@ -119,7 +119,7 @@ static inline void arch_atomic64_set(ato
  *
  * Atomically reads the value of @v and returns it.
  */
-static inline s64 arch_atomic64_read(const atomic64_t *v)
+static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 r;
 	alternative_atomic64(read, "=&A" (r), "c" (v) : "memory");
@@ -133,7 +133,7 @@ static inline s64 arch_atomic64_read(con
  *
  * Atomically adds @i to @v and returns @i + *@v
  */
-static inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(add_return,
 			     ASM_OUTPUT2("+A" (i), "+c" (v)),
@@ -145,7 +145,7 @@ static inline s64 arch_atomic64_add_retu
 /*
  * Other variants with different arithmetic operators:
  */
-static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	alternative_atomic64(sub_return,
 			     ASM_OUTPUT2("+A" (i), "+c" (v)),
@@ -154,7 +154,7 @@ static inline s64 arch_atomic64_sub_retu
 }
 #define arch_atomic64_sub_return arch_atomic64_sub_return
 
-static inline s64 arch_atomic64_inc_return(atomic64_t *v)
+static __always_inline s64 arch_atomic64_inc_return(atomic64_t *v)
 {
 	s64 a;
 	alternative_atomic64(inc_return, "=&A" (a),
@@ -163,7 +163,7 @@ static inline s64 arch_atomic64_inc_retu
 }
 #define arch_atomic64_inc_return arch_atomic64_inc_return
 
-static inline s64 arch_atomic64_dec_return(atomic64_t *v)
+static __always_inline s64 arch_atomic64_dec_return(atomic64_t *v)
 {
 	s64 a;
 	alternative_atomic64(dec_return, "=&A" (a),
@@ -179,7 +179,7 @@ static inline s64 arch_atomic64_dec_retu
  *
  * Atomically adds @i to @v.
  */
-static inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_add(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(add, add_return,
 			       ASM_OUTPUT2("+A" (i), "+c" (v)),
@@ -194,7 +194,7 @@ static inline s64 arch_atomic64_add(s64
  *
  * Atomically subtracts @i from @v.
  */
-static inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	__alternative_atomic64(sub, sub_return,
 			       ASM_OUTPUT2("+A" (i), "+c" (v)),
@@ -208,7 +208,7 @@ static inline s64 arch_atomic64_sub(s64
  *
  * Atomically increments @v by 1.
  */
-static inline void arch_atomic64_inc(atomic64_t *v)
+static __always_inline void arch_atomic64_inc(atomic64_t *v)
 {
 	__alternative_atomic64(inc, inc_return, /* no output */,
 			       "S" (v) : "memory", "eax", "ecx", "edx");
@@ -221,7 +221,7 @@ static inline void arch_atomic64_inc(ato
  *
  * Atomically decrements @v by 1.
  */
-static inline void arch_atomic64_dec(atomic64_t *v)
+static __always_inline void arch_atomic64_dec(atomic64_t *v)
 {
 	__alternative_atomic64(dec, dec_return, /* no output */,
 			       "S" (v) : "memory", "eax", "ecx", "edx");
@@ -237,7 +237,7 @@ static inline void arch_atomic64_dec(ato
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns non-zero if the add was done, zero otherwise.
  */
-static inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+static __always_inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	unsigned low = (unsigned)u;
 	unsigned high = (unsigned)(u >> 32);
@@ -248,7 +248,7 @@ static inline int arch_atomic64_add_unle
 }
 #define arch_atomic64_add_unless arch_atomic64_add_unless
 
-static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
+static __always_inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
 	int r;
 	alternative_atomic64(inc_not_zero, "=&a" (r),
@@ -257,7 +257,7 @@ static inline int arch_atomic64_inc_not_
 }
 #define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
 
-static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
+static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 r;
 	alternative_atomic64(dec_if_positive, "=&A" (r),
@@ -269,7 +269,7 @@ static inline s64 arch_atomic64_dec_if_p
 #undef alternative_atomic64
 #undef __alternative_atomic64
 
-static inline void arch_atomic64_and(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -277,7 +277,7 @@ static inline void arch_atomic64_and(s64
 		c = old;
 }
 
-static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -288,7 +288,7 @@ static inline s64 arch_atomic64_fetch_an
 }
 #define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
-static inline void arch_atomic64_or(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -296,7 +296,7 @@ static inline void arch_atomic64_or(s64
 		c = old;
 }
 
-static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -307,7 +307,7 @@ static inline s64 arch_atomic64_fetch_or
 }
 #define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
-static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -315,7 +315,7 @@ static inline void arch_atomic64_xor(s64
 		c = old;
 }
 
-static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
@@ -326,7 +326,7 @@ static inline s64 arch_atomic64_fetch_xo
 }
 #define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
-static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	s64 old, c = 0;
 
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -17,7 +17,7 @@
  * Atomically reads the value of @v.
  * Doesn't imply a read memory barrier.
  */
-static inline s64 arch_atomic64_read(const atomic64_t *v)
+static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	return __READ_ONCE((v)->counter);
 }
@@ -29,7 +29,7 @@ static inline s64 arch_atomic64_read(con
  *
  * Atomically sets the value of @v to @i.
  */
-static inline void arch_atomic64_set(atomic64_t *v, s64 i)
+static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	__WRITE_ONCE(v->counter, i);
 }
@@ -55,7 +55,7 @@ static __always_inline void arch_atomic6
  *
  * Atomically subtracts @i from @v.
  */
-static inline void arch_atomic64_sub(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_sub(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "subq %1,%0"
 		     : "=m" (v->counter)
@@ -71,7 +71,7 @@ static inline void arch_atomic64_sub(s64
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
+static __always_inline bool arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, e, "er", i);
 }
@@ -113,7 +113,7 @@ static __always_inline void arch_atomic6
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool arch_atomic64_dec_and_test(atomic64_t *v)
+static __always_inline bool arch_atomic64_dec_and_test(atomic64_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, e);
 }
@@ -127,7 +127,7 @@ static inline bool arch_atomic64_dec_and
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool arch_atomic64_inc_and_test(atomic64_t *v)
+static __always_inline bool arch_atomic64_inc_and_test(atomic64_t *v)
 {
 	return GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, e);
 }
@@ -142,7 +142,7 @@ static inline bool arch_atomic64_inc_and
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool arch_atomic64_add_negative(s64 i, atomic64_t *v)
+static __always_inline bool arch_atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	return GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, s, "er", i);
 }
@@ -161,25 +161,25 @@ static __always_inline s64 arch_atomic64
 }
 #define arch_atomic64_add_return arch_atomic64_add_return
 
-static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	return arch_atomic64_add_return(-i, v);
 }
 #define arch_atomic64_sub_return arch_atomic64_sub_return
 
-static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	return xadd(&v->counter, i);
 }
 #define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
-static inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	return xadd(&v->counter, -i);
 }
 #define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
 
-static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	return arch_cmpxchg(&v->counter, old, new);
 }
@@ -191,13 +191,13 @@ static __always_inline bool arch_atomic6
 }
 #define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 
-static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 new)
+static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 new)
 {
 	return arch_xchg(&v->counter, new);
 }
 #define arch_atomic64_xchg arch_atomic64_xchg
 
-static inline void arch_atomic64_and(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "andq %1,%0"
 			: "+m" (v->counter)
@@ -205,7 +205,7 @@ static inline void arch_atomic64_and(s64
 			: "memory");
 }
 
-static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	s64 val = arch_atomic64_read(v);
 
@@ -215,7 +215,7 @@ static inline s64 arch_atomic64_fetch_an
 }
 #define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
-static inline void arch_atomic64_or(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "orq %1,%0"
 			: "+m" (v->counter)
@@ -223,7 +223,7 @@ static inline void arch_atomic64_or(s64
 			: "memory");
 }
 
-static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	s64 val = arch_atomic64_read(v);
 
@@ -233,7 +233,7 @@ static inline s64 arch_atomic64_fetch_or
 }
 #define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
-static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
+static __always_inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
 	asm volatile(LOCK_PREFIX "xorq %1,%0"
 			: "+m" (v->counter)
@@ -241,7 +241,7 @@ static inline void arch_atomic64_xor(s64
 			: "memory");
 }
 
-static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
+static __always_inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	s64 val = arch_atomic64_read(v);
 


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
