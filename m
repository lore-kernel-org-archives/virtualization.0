Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F02BC48BE8
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 08:25:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 175F761396
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 08:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 175F761396
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAB01828AF;
	Fri, 18 Jun 2021 08:25:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8xf-kPaMN-11; Fri, 18 Jun 2021 08:25:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 71D4082BBC;
	Fri, 18 Jun 2021 08:25:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E846C000D;
	Fri, 18 Jun 2021 08:25:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17538C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 08:25:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC95282BBC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 08:25:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yrue_dZ1DseF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 08:25:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5137C828AF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 08:25:12 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A08591FDF6;
 Fri, 18 Jun 2021 08:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624004708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l6MJAIsLVgqXfW5lwfZV7HOLJW17Cm0NEkHH1qVZkSE=;
 b=e2K8BVdia2rtzCx8g9U0y0K5QFEUTW6+tRBPdUKB1/9rUgIoHo69R4uqIfzkQYeVzE5Vnp
 qHZ+KH7deAYpjZj5NgxCopEAM7/qSVz8W26Yrcjik7+6jfSLnq2Ilc8w8Obg3edPP7I0ia
 sp+YXzpmdkpkG/3juEFrbxx70lq/rX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624004708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l6MJAIsLVgqXfW5lwfZV7HOLJW17Cm0NEkHH1qVZkSE=;
 b=05L887bTpKMQfMGEUgoeZ0S9x5jtN6qake3lq4t7r92HDvG2EfnO3sp26PCC6HgXQlFqw5
 l1RrDidk2KmJJzBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id D3D7C118DD;
 Fri, 18 Jun 2021 08:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624004708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l6MJAIsLVgqXfW5lwfZV7HOLJW17Cm0NEkHH1qVZkSE=;
 b=e2K8BVdia2rtzCx8g9U0y0K5QFEUTW6+tRBPdUKB1/9rUgIoHo69R4uqIfzkQYeVzE5Vnp
 qHZ+KH7deAYpjZj5NgxCopEAM7/qSVz8W26Yrcjik7+6jfSLnq2Ilc8w8Obg3edPP7I0ia
 sp+YXzpmdkpkG/3juEFrbxx70lq/rX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624004708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l6MJAIsLVgqXfW5lwfZV7HOLJW17Cm0NEkHH1qVZkSE=;
 b=05L887bTpKMQfMGEUgoeZ0S9x5jtN6qake3lq4t7r92HDvG2EfnO3sp26PCC6HgXQlFqw5
 l1RrDidk2KmJJzBg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id mnUcMmNYzGCmfgAALh3uQQ
 (envelope-from <jroedel@suse.de>); Fri, 18 Jun 2021 08:25:07 +0000
Date: Fri, 18 Jun 2021 10:25:06 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 1/2] x86/sev: Make sure IRQs are disabled while GHCB
 is active
Message-ID: <YMxYYkawXh1kZ/jf@suse.de>
References: <20210616184913.13064-1-joro@8bytes.org>
 <20210616184913.13064-2-joro@8bytes.org>
 <YMtjoLLQpKyveVlS@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YMtjoLLQpKyveVlS@hirez.programming.kicks-ass.net>
Cc: kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Arvind Sankar <nivedita@alum.mit.edu>, hpa@zytor.com,
 Jiri Slaby <jslaby@suse.cz>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 David Rientjes <rientjes@google.com>, Martin Radev <martin.b.radev@gmail.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook <keescook@chromium.org>,
 Cfir Cohen <cfir@google.com>, linux-coco@lists.linux.dev,
 Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Juergen Gross <jgross@suse.com>, Mike Stunes <mstunes@vmware.com>,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Erdem Aktas <erdemaktas@google.com>
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

On Thu, Jun 17, 2021 at 05:00:48PM +0200, Peter Zijlstra wrote:
> I think this is broken, at this point RCU is quite dead on this CPU and
> local_irq_save/restore include tracing and all sorts.
> 
> Also, shouldn't IRQs already be disabled by the time we get here?

Yes it is, I removed these calls, made __sev_get/put_ghcb() noinstr
instead of __always_inline and put instrumentation_begin()/end() around
the panic() call in __sev_get_ghcb().

Regards,

	Joerg
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
