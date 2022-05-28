Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7753C433EF
	for <virtualization@archiver.kernel.org>; Sat, 28 May 2022 13:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F13E84CE8;
	Sat, 28 May 2022 13:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tp2jjm7lT0bN; Sat, 28 May 2022 13:53:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0488E849B5;
	Sat, 28 May 2022 13:53:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D86B1C0032;
	Sat, 28 May 2022 13:53:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15A3FC002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 May 2022 13:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9F6F40639
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 May 2022 13:53:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K2nx0RwmnTxE
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 May 2022 13:53:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B34140629
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 May 2022 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=qpQj5MjTNJML+OFknsg22dZadcY9+XhnQrHO9aSW5+0=; b=ZTCcJJF0o5zT1aupPPSo9PI56J
 eiI2prcX18jjDr3Kcu0W7XQfdvpGCiKls6zPH2BEjxsfUSMaNRRwqxYAGZSh4KAiCGmoJzSmqPkBK
 vghBfemqJxYwYtdQtV1okw2mi0axifZU6UL9ADNr+EHMuLaEh0kbSR27o/UiYjjmcVdlBC1QQ2bJx
 guBEY50a0s16Rs4giRar+iynbO27b2jIw6pq5dBCV4Fwtr3GpyQZ4TqgEx0OYdnZ0Waf1laJwqrfC
 yjm/Wmq573LAE3kOdVq6yru/SRLkIP6aun8hcTvU6YtT9MycgfdAdARJXfwwo2KMKE9UBheBIYinn
 /4Kzkavg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=worktop.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nuws6-002tyG-1W; Sat, 28 May 2022 13:52:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
 id A376E980DC1; Sat, 28 May 2022 15:52:47 +0200 (CEST)
Date: Sat, 28 May 2022 15:52:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shreenidhi Shedi <yesshedi@gmail.com>
Subject: Re: [PATCH v3] x86/vmware: use unsigned integer for shifting
Message-ID: <YpIpL728ii08D9uK@worktop.programming.kicks-ass.net>
References: <20220527175737.915284-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220527175737.915284-1-sshedi@vmware.com>
Cc: x86@kernel.org, hpa@zytor.com, Shreenidhi Shedi <sshedi@vmware.com>,
 pv-drivers@vmware.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 amakhalov@vmware.com, tglx@linutronix.de
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

On Fri, May 27, 2022 at 11:27:37PM +0530, Shreenidhi Shedi wrote:
> From: Shreenidhi Shedi <sshedi@vmware.com>
> 
> Shifting signed 32-bit value by 31 bits is implementation-defined
> behaviour. Using unsigned is better option for this.

The kernel builds with -fno-strict-overflow and as such this behaviour
is well defined.

> Fixes: 4cca6ea04d31 ("x86/apic: Allow x2apic without IR on VMware platform")

Nothing broken, therefore nothing fixed.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
