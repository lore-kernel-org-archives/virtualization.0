Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0252C43334
	for <virtualization@archiver.kernel.org>; Mon, 27 Jun 2022 09:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44131418C9;
	Mon, 27 Jun 2022 09:30:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 44131418C9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oV7q+l4R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HQW8kIZY-p8e; Mon, 27 Jun 2022 09:30:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 176B441878;
	Mon, 27 Jun 2022 09:30:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 176B441878
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE8A8C0039;
	Mon, 27 Jun 2022 09:30:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D87ADC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 09:30:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B38156107F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 09:30:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B38156107F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=casper.20170209 header.b=oV7q+l4R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ovdBHLUtga5p
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 09:30:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6023C61085
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6023C61085
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 09:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=IokvEg/kIxjdCTozh/TqGPoHY64HoI20u+uoITAFI+4=; b=oV7q+l4Rua4HzPC6b1q5Btq6wY
 BI5So1sA7UW9Nn2pxg0Yja6EZdZH69RNGRVbk+rve17K9JyEaRJHpZabTCPOewiopvWKXJdThI8Jy
 tKwuxq2Zq7A8pHhAzHApV7F0WxT/FWnT2AIbn0pB7B+B3NfLOdSMv2ph1jp1iwqofgetvI0C4Nghd
 HgdvDH/K/2bgcJLVwvZCAiVVCgsLna9F8SpbWIO052Rry94x5fKBuJP00zaw9e/yNCxoGayknXwUT
 ruo01fc8FRSUvp1Ra3a78LGoWG9leNDfB7r6uaIX7cEqUTYklW4GPI7Z9B7PUKOTc4oSu9jqCqwds
 4qL0IpWA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3]
 helo=noisy.programming.kicks-ass.net)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1o5l4X-00BEZD-Hr; Mon, 27 Jun 2022 09:30:21 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F132F30045A;
 Mon, 27 Jun 2022 11:30:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id DB8F020C57C6B; Mon, 27 Jun 2022 11:30:18 +0200 (CEST)
Date: Mon, 27 Jun 2022 11:30:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guo Hui <guohui@uniontech.com>
Subject: Re: [PATCH v2] x86/paravirt: useless assignment instructions cause
 Unixbench full core performance degradation
Message-ID: <Yrl4qoXcVj9Y6Cpa@hirez.programming.kicks-ass.net>
References: <f6b68466-968c-4a91-655a-23970280a072@redhat.com>
 <20220627021350.25714-1-guohui@uniontech.com>
 <YrlhGqqce0NCQ6hi@hirez.programming.kicks-ass.net>
 <3c020577-2045-fa12-9e33-65ece10bda30@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c020577-2045-fa12-9e33-65ece10bda30@uniontech.com>
Cc: jgross@suse.com, x86@kernel.org, hpa@zytor.com, pv-drivers@vmware.com,
 boqun.feng@gmail.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, amakhalov@vmware.com, longman@redhat.com,
 tglx@linutronix.de, will@kernel.org, wangxiaohua@uniontech.com
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

On Mon, Jun 27, 2022 at 05:18:02PM +0800, Guo Hui wrote:
> Ok thanks Peter, your suggestion is very good, I will modify my patch as you
> suggested.

Because it messes up the order in which people normally read text.
Why is top-posting such a bad thing?
Top-posting.
What is the most annoying thing in e-mail?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
