Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFABC6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 20:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC1B7405F9;
	Thu, 16 Mar 2023 20:15:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC1B7405F9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=UCErDsgc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5XgIEMlPrjsB; Thu, 16 Mar 2023 20:15:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B0BB4046D;
	Thu, 16 Mar 2023 20:15:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B0BB4046D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EF92C0071;
	Thu, 16 Mar 2023 20:15:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6C17C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8AF238202C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:14:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8AF238202C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=UCErDsgc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ckQMzFXQwTV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:14:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9BB948202B
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9BB948202B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=uumsoE6D078n3Znb9lWlQ23wdndeL/MyNVNgOHTci4k=; b=UCErDsgcv7bKm/5iSSe5MimD6y
 b9BkntdBeNrc8Mc/5IZJXQmszCddZBvuYVzu4SKjicMbUA+NNk1RRLBP4Gdr2SnNrKNHAPkJkY01l
 pH4n90Alv8BmD4xRvnUo6MS0wM/fMR2nYDQvH7YqkmZyt+l8cui10VDNGXcyIw1q2buP4ugFN1LVj
 zx3mmof/zWL30x14FQRo7AESd4BYxJdCuo1ZluPDY1QCELsXbakI5jsniUIdHP8JsEIuG7YeEF7kz
 SEP2Fm0eYexrICINiYJpG88qZFHsE7jeeavZh2M/htZrjZ76qvMq1xcvRizHsVGPLacF5cCZJrEnd
 OJwQZaEQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pctzU-00F9Gl-4M; Thu, 16 Mar 2023 20:14:24 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6DC8300328;
 Thu, 16 Mar 2023 21:14:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 9C754212FCF5C; Thu, 16 Mar 2023 21:14:21 +0100 (CET)
Date: Thu, 16 Mar 2023 21:14:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: convert simple paravirt functions to asm
Message-ID: <20230316201421.GA2060174@hirez.programming.kicks-ass.net>
References: <20230308154210.18454-1-jgross@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230308154210.18454-1-jgross@suse.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, Mar 08, 2023 at 04:42:10PM +0100, Juergen Gross wrote:

> +DEFINE_PARAVIRT_ASM(pv_native_irq_disable, "cli", .text);
> +DEFINE_PARAVIRT_ASM(pv_native_irq_enable, "sti", .text);
> +DEFINE_PARAVIRT_ASM(pv_native_read_cr2, "mov %cr2, %rax", .text);

per these v, the above ^ should be in .noinstr.text

> -static noinstr unsigned long pv_native_read_cr2(void)
> -static noinstr void pv_native_irq_enable(void)
> -static noinstr void pv_native_irq_disable(void)


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
