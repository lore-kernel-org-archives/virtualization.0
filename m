Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE2CC61DA2
	for <virtualization@archiver.kernel.org>; Thu, 26 Jan 2023 15:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1602181CE7;
	Thu, 26 Jan 2023 15:15:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1602181CE7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=j6AtqAY3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1RRjntCCiJBM; Thu, 26 Jan 2023 15:15:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A610B81B25;
	Thu, 26 Jan 2023 15:15:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A610B81B25
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6797C002D;
	Thu, 26 Jan 2023 15:15:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ADACC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7698941700
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7698941700
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=desiato.20200630 header.b=j6AtqAY3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 47LI_wJAsXwr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2BECF416E0
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BECF416E0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=svQEe0ECCGCg8wgaTJSn7Vk6+ZlADTvcOCMWRjGVrA4=; b=j6AtqAY3qshb8rFaiRpU53+4Fs
 d1J02gGQk0PHmOdIPPOlItYWC5gMKlVfMkNsvOKixr/gcdoRrOyoJIMmURBLFUMjjZxbH9RT+doob
 sWAjknqD0TQTUUqw5WeqAFD55KQsjxLuN3VkSTHmsOJZ27RI89v7gkCfAStu/mucawQ6N7OOReCI6
 eW2CAbQn8KA5quGx7LzF9m3lpgkZOhvOqTTlyh0DjOQGkMZEZAqRA2Rpqfg1X00lhxZaSM53Xwxsj
 ClmO4ylSPEm29DLDWKgKHaKX7Gd0eoQfQKTxnc1k+VQ1wqqiNWA6sWglXic+xTBfzRP1LWPVf5DET
 J0E7VO2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pL3xH-002U1d-2R; Thu, 26 Jan 2023 15:14:23 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3633E3010ED;
 Thu, 26 Jan 2023 16:14:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 10C412084C4A8; Thu, 26 Jan 2023 16:14:53 +0100 (CET)
Message-ID: <20230126151323.466670589@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 26 Jan 2023 16:08:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Subject: [PATCH v2 3/9] tracing: Warn about !rcu_is_watching()
References: <20230126150829.087606759@infradead.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 peterz@infradead.org, lpieralisi@kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, tglx@linutronix.de, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, pv-drivers@vmware.com, mingo@redhat.com,
 mgorman@suse.de, longman@redhat.com, frederic@kernel.org,
 linux-trace-kernel@vger.kernel.org, paulmck@kernel.org,
 linux-pm@vger.kernel.org, boqun.feng@gmail.com, rostedt@goodmis.org,
 bp@alien8.de, vincent.guittot@linaro.org, boris.ostrovsky@oracle.com,
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

When using noinstr, WARN when tracing hits when RCU is disabled.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/trace_recursion.h |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -135,6 +135,21 @@ extern void ftrace_record_recursion(unsi
 # define do_ftrace_record_recursion(ip, pip)	do { } while (0)
 #endif
 
+#ifdef CONFIG_ARCH_WANTS_NO_INSTR
+# define trace_warn_on_no_rcu(ip)					\
+	({								\
+		bool __ret = !rcu_is_watching();			\
+		if (__ret && !trace_recursion_test(TRACE_RECORD_RECURSION_BIT)) { \
+			trace_recursion_set(TRACE_RECORD_RECURSION_BIT); \
+			WARN_ONCE(true, "RCU not on for: %pS\n", (void *)ip); \
+			trace_recursion_clear(TRACE_RECORD_RECURSION_BIT); \
+		}							\
+		__ret;							\
+	})
+#else
+# define trace_warn_on_no_rcu(ip)	false
+#endif
+
 /*
  * Preemption is promised to be disabled when return bit >= 0.
  */
@@ -144,6 +159,9 @@ static __always_inline int trace_test_an
 	unsigned int val = READ_ONCE(current->trace_recursion);
 	int bit;
 
+	if (trace_warn_on_no_rcu(ip))
+		return -1;
+
 	bit = trace_get_context_bit() + start;
 	if (unlikely(val & (1 << bit))) {
 		/*


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
