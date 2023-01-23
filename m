Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A10C54EED
	for <virtualization@archiver.kernel.org>; Mon, 23 Jan 2023 20:58:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54F1B8200A;
	Mon, 23 Jan 2023 20:58:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54F1B8200A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=gnYqMu4P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8ph4dnKcj2A9; Mon, 23 Jan 2023 20:58:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D82328201D;
	Mon, 23 Jan 2023 20:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D82328201D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A38EFC0082;
	Mon, 23 Jan 2023 20:58:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9B96C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8544260E9D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8544260E9D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=gnYqMu4P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pAvOyo5IL7rx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE2E360FBD
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE2E360FBD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 23 Jan 2023 20:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=bIfFAXl3Gv4EnKDtIDltBqYZ3txjVL6G+NhMkZyfGI4=; b=gnYqMu4PNJySVrCjnkQZIgqD33
 wQXB/rRboPQU3LRLINoxnUhxHyuyRecqTgiKPD7HJmGt1ujJzhYLpFgeknPGh83xjZgsPFTRxusSP
 6FrdKCC3GQlR3CMbnpwqtGVsjcmD/Ej0w7wbfIM3vLWi6cNVejzdRqOExLrFK1rAnGCpRPlxr5+Oc
 wDq1C+RIa8zZ3MBxAWZBdlLHGxcQGyE/awpvRp1BLNR+dLrA+45FqNKyNNuglm+LzlsIk4VYNAJ/q
 P97sHNR5ecVeHuLhJ2L/MEZt49xD/FKILOzWA0ABELctEl+d01ONaULWBfayuntvr+R+X1nyG1EMb
 5ooM8zaA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pK3se-004WTw-59; Mon, 23 Jan 2023 20:57:28 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64BDE300747;
 Mon, 23 Jan 2023 21:57:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id C96002075A6F7; Mon, 23 Jan 2023 21:57:24 +0100 (CET)
Message-ID: <20230123205515.059999893@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 23 Jan 2023 21:50:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Subject: [PATCH 3/6] ftrace/x86: Warn and ignore graph tracing when RCU is
 disabled
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

All RCU disabled code should be noinstr and hence we should never get
here -- when we do, WARN about it and make sure to not actually do
tracing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/ftrace.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -646,6 +646,9 @@ void prepare_ftrace_return(unsigned long
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		return;
 
+	if (WARN_ONCE(!rcu_is_watching(), "RCU not on for: %pS\n", (void *)ip))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, *parent);
 	if (bit < 0)
 		return;


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
