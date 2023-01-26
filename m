Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F23C61DA2
	for <virtualization@archiver.kernel.org>; Thu, 26 Jan 2023 15:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 486B961029;
	Thu, 26 Jan 2023 15:15:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 486B961029
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=tJ7KRCSZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XW5BPZXD8VLc; Thu, 26 Jan 2023 15:15:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E1C7060D6C;
	Thu, 26 Jan 2023 15:15:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E1C7060D6C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 351A8C0077;
	Thu, 26 Jan 2023 15:15:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91F13C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B7B041754
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B7B041754
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=tJ7KRCSZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T9I9B6v6Io5Q
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 097EC41738
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 097EC41738
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 15:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
 Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To;
 bh=LKrP1wtwDwtGfmqJdEblQavVdQZHYUX7Rw9EhYSY0po=; b=tJ7KRCSZonsBJNK0ODaA1eE1C1
 n727YqOhrfXU76hw15Bpd17NXo9uNPSGT0CA7UrrNT5L4l9pGO3lbXFBip6jtT3/B59UeWoTko2QR
 qb84FHcQDDdCmZBir+aqAV0lj/CqVS+40GvhCV1U0BmKOBcGjWVZeTeR4qDT0Sfiagb1af9JoGJOv
 OiA6BV9qbN0EooMWBslRFimVh9f3HsMoAhlP/Qu8DC8Bw1i/Ba2wwRBq8j96cGGWJae7XHaf0FyQh
 n0HoKdEPkIIXhjaGjYW4QBDOmnM0ECh716ZrDwhFrJ+fHegexZ8dtuOlt/cUzhya+SgnLyOwSmjTO
 vpdjbXKg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pL3xn-006qUP-F5; Thu, 26 Jan 2023 15:14:56 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 89D09302E1F;
 Thu, 26 Jan 2023 16:14:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
 id 1F1372084C4B1; Thu, 26 Jan 2023 16:14:53 +0100 (CET)
Message-ID: <20230126151323.643408110@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 26 Jan 2023 16:08:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Subject: [PATCH v2 6/9] x86/pvclock: improve atomic update of last_value in
 pvclock_clocksource_read
References: <20230126150829.087606759@infradead.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 peterz@infradead.org, lpieralisi@kernel.org, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, tglx@linutronix.de, vschneid@redhat.com,
 hpa@zytor.com, x86@kernel.org, Uros Bizjak <ubizjak@gmail.com>,
 pv-drivers@vmware.com, mingo@redhat.com, mgorman@suse.de, longman@redhat.com,
 frederic@kernel.org, linux-trace-kernel@vger.kernel.org, paulmck@kernel.org,
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

From: Uros Bizjak <ubizjak@gmail.com>

Improve atomic update of last_value in pvclock_clocksource_read:

- Atomic update can be skipped if the "last_value" is already
  equal to "ret".

- The detection of atomic update failure is not correct. The value,
  returned by atomic64_cmpxchg should be compared to the old value
  from the location to be updated. If these two are the same, then
  atomic update succeeded and "last_value" location is updated to
  "ret" in an atomic way. Otherwise, the atomic update failed and
  it should be retried with the value from "last_value" - exactly
  what atomic64_try_cmpxchg does in a correct and more optimal way.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230118202330.3740-1-ubizjak@gmail.com
---
 arch/x86/kernel/pvclock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index eda37df016f0..5a2a517dd61b 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -102,10 +102,9 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 	 */
 	last = atomic64_read(&last_value);
 	do {
-		if (ret < last)
+		if (ret <= last)
 			return last;
-		last = atomic64_cmpxchg(&last_value, last, ret);
-	} while (unlikely(last != ret));
+	} while (!atomic64_try_cmpxchg(&last_value, &last, ret));
 
 	return ret;
 }
-- 
2.39.0



_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
