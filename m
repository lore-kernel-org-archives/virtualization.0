Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6647C25B4E
	for <virtualization@archiver.kernel.org>; Tue, 24 Jan 2023 14:45:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5993E61063;
	Tue, 24 Jan 2023 14:45:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5993E61063
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=i0YMl4H0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J1Wtsi2uRN2f; Tue, 24 Jan 2023 14:45:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CDD1060AC0;
	Tue, 24 Jan 2023 14:45:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDD1060AC0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B480CC0033;
	Tue, 24 Jan 2023 14:45:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5302C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A235081E1A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A235081E1A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=i0YMl4H0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8TvuTR3ZrAgj
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:45:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7295780DA6
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7295780DA6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Jan 2023 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=eA3jWjQCsaXuex737PYn1zrT0M5qTbaDIBSPCUlVDsw=; b=i0YMl4H0Tpp+J+qXHd3MZ+ZHEI
 hs/7dJiIdRGD0/TiQGg0NFONmko92fDUJ4AubYMGqa6gc0agQlfzopu+pWMdZnnzKxwccufwMIYrU
 ClpQiGyv6OLZGvM7WorTpI/EaX1kSWeiy/6PEw75g19P1+p2e6RSfFbOotaQ06+fX2/cgL/FtfbtZ
 aiAcxPawZOuKyHHRyVYxomM3UzUeqHVNlOnHa7540fgMhqgZs2d7+jxX3LOwTmArB7v7VySuvOcaW
 jCAUeGZxAuKc46C/X36RB0qw19xOwBay+soy3RV1jEhInSalJCtjqI1VOajgawdVUvrJNFvucjDHQ
 zMyhMRrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pKKXO-0057eL-0Z; Tue, 24 Jan 2023 14:44:38 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 415DE30036B;
 Tue, 24 Jan 2023 15:44:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 26A232C217298; Tue, 24 Jan 2023 15:44:35 +0100 (CET)
Date: Tue, 24 Jan 2023 15:44:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/6] ftrace/x86: Warn and ignore graph tracing when RCU
 is disabled
Message-ID: <Y8/u00WHGElMDjoo@hirez.programming.kicks-ass.net>
References: <20230123205009.790550642@infradead.org>
 <20230123205515.059999893@infradead.org>
 <20230123165304.370121e7@gandalf.local.home>
 <20230123170753.7ac9419e@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230123170753.7ac9419e@gandalf.local.home>
Cc: mark.rutland@arm.com, juri.lelli@redhat.com, daniel.lezcano@linaro.org,
 wanpengli@tencent.com, kvm@vger.kernel.org, rafael@kernel.org,
 pv-drivers@vmware.com, dave.hansen@linux.intel.com,
 virtualization@lists.linux-foundation.org, bsegall@google.com,
 amakhalov@vmware.com, will@kernel.org, vschneid@redhat.com, hpa@zytor.com,
 x86@kernel.org, mingo@kernel.org, mgorman@suse.de,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 boqun.feng@gmail.com, bp@alien8.de, vincent.guittot@linaro.org,
 boris.ostrovsky@oracle.com, dietmar.eggemann@arm.com, jgross@suse.com,
 seanjc@google.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 mhiramat@kernel.org, pbonzini@redhat.com, bristot@redhat.com
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

On Mon, Jan 23, 2023 at 05:07:53PM -0500, Steven Rostedt wrote:

> Actually, perhaps we can just add this, and all you need to do is create
> and set CONFIG_NO_RCU_TRACING (or some other name).

Elsewhere I've used CONFIG_ARCH_WANTS_NO_INSTR for this.

Anyway, I took it for a spin and it .... doesn't seems to do the job.

With my patch the first splat is

  "RCU not on for: cpuidle_poll_time+0x0/0x70"

While with yours I seems to get the endless:

  "WARNING: suspicious RCU usage"

thing. Let me see if I can figure out where it goes side-ways.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
