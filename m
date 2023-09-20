Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10959CE79DF
	for <virtualization@archiver.kernel.org>; Wed, 20 Sep 2023 14:53:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84B4C81C19;
	Wed, 20 Sep 2023 14:53:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84B4C81C19
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=qal6/LGd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZQpa58NJuahX; Wed, 20 Sep 2023 14:53:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 27D0C839DC;
	Wed, 20 Sep 2023 14:53:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 27D0C839DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 042DCC0039;
	Wed, 20 Sep 2023 14:53:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE991C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 14:53:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABFDC61314
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 14:53:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABFDC61314
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=qal6/LGd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZRDj_Gr8Njfn
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 14:53:35 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 402AD612FB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 14:53:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 402AD612FB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=GyiHhTkxOm0E3nJZzmdSc55EE6M80FFoZ8Fg8eF69QI=; b=qal6/LGdy1+KLISPaYnZD8Qx03
 0sPsW4Hb98j/QISugyJf8X+fjehOvS9Ll09sNhQBGt4zYCqJLS05+5zcypr1lxzUUBMMzVD94e3dM
 WsEbCy3MXmjjSIbGTjummdcpDaTg/Q5P6+27Ache2MDt+PDg7wvaaYBxEqYwmH7IH6z3v4Nrab3kH
 jumgDPBEh8iwGY7QxhMaZVdU9o7YOZ+lp8opCiziKvMXLydIfARsPghjuMR+QFMMUTvGJiINVUWkL
 bzeShoJxnjyr3LqxNC1fTfMdieOivUFEv0jhy8CMnJm5sqI4skd6Rbs5aAGT9J8EfMFToJBwbaylz
 Z9nmpmCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1qiyZT-006Oz0-BC; Wed, 20 Sep 2023 14:52:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
 id 04996300348; Wed, 20 Sep 2023 16:52:55 +0200 (CEST)
Date: Wed, 20 Sep 2023 16:52:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [RFC PATCH 1/3] x86/paravirt: move some functions and defines to
 alternative
Message-ID: <20230920145254.GC6687@noisy.programming.kicks-ass.net>
References: <20230608140333.4083-1-jgross@suse.com>
 <20230608140333.4083-2-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230608140333.4083-2-jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Alexey Makhalov <amakhalov@vmware.com>, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Wanpeng Li <wanpengli@tencent.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Thu, Jun 08, 2023 at 04:03:31PM +0200, Juergen Gross wrote:
> As a preparation for replacing paravirt patching completely by
> alternative patching, move some backend functions and #defines to
> alternative code and header.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
