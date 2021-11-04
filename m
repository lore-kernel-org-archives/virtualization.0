Return-Path: <SRS0=bIcn=PX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2284EC433EF
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 09:17:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4BF60EB4
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 09:17:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE4BF60EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E54F40114;
	Thu,  4 Nov 2021 09:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k5vktrtv5Qdd; Thu,  4 Nov 2021 09:17:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D06A4400BA;
	Thu,  4 Nov 2021 09:17:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1E9DC0012;
	Thu,  4 Nov 2021 09:17:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 775EFC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 09:17:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4ED85814B5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 09:17:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="HMOzE6zE";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="HT4ndX4i"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dn0Wqjdorrgm
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 09:17:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96F6981551
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 09:17:04 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1636017420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t+oc8R2xCoaL4W6NcZKyQyEStrvA2epN1TLGjnE40QE=;
 b=HMOzE6zEHuGzoWlUkObWAe1RWBaejOZ1B+CTGzdToY327nxws5Kz3BpG6XHG7vyzwxtFno
 enO854UQ6XdoM2xXbvm/NclTW6fv81xLZEvOK8k9lsmhOCRMByi54NH1jjRczxPwfRF9RH
 NfueZriC/AMq/IYGOMB+Tcn/C38kN6Qn+DV9t9PoazF80uHd6qDHJHsBiUgorIECnqYcGJ
 vOKvD9vNNrfRzfFQXzeePy9oq0sPiZW7MYShwRk+Ed8JQlPsMiQlbC0cvvkFRcjnpPUW7N
 pOqAxLu7+li5At6XKmpLzO3w3xFb+4gxSXVVh4rNjiC0qnSJbAYeQxmbmEc+xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1636017420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t+oc8R2xCoaL4W6NcZKyQyEStrvA2epN1TLGjnE40QE=;
 b=HT4ndX4iQMojyhKsqdtAqwTBLq4MHo+xGydmuqF/WwEgNxJUjF421IGG/j2AbFjHoKIg2L
 bl1qXQgDAJsQIWCg==
To: Juergen Gross <jgross@suse.com>, X86 ML <x86@kernel.org>, Linux
 Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: Which tree for paravirt related patches?
In-Reply-To: <60a2037d-2d4d-e9e9-edfd-b889c4bd3fb6@suse.com>
References: <60a2037d-2d4d-e9e9-edfd-b889c4bd3fb6@suse.com>
Date: Thu, 04 Nov 2021 10:17:00 +0100
Message-ID: <874k8s5lgz.ffs@tglx>
MIME-Version: 1.0
Cc: Dave Hansen <dave.hansen@linux.intel.com>, IngoMolnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Jan Beulich <JBeulich@suse.com>
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

Juergen,

On Thu, Nov 04 2021 at 06:53, Juergen Gross wrote:

> A recent patch modifying the core paravirt-ops functionality is
> highlighting some missing MAINTAINERS information for PARAVIRT_OPS:
> there is no information which tree is to be used for taking those
> patches per default. In the past this was mostly handled by the tip
> tree, and I think this is fine.
>
> X86 maintainers, are you fine with me modifying the PARAVIRT_OPS entry
> to add the x86 ML and the tip tree? This way such patches will be
> noticed by you and can be handled accordingly.

Sure.

> An alternative would be to let me carry those patches through the Xen
> tree, but in lots of those patches some core x86 files are being touched
> and I think the tip tree is better suited for paravirt handling.

Fair enough.

> And please, could you take a look at:
>
> https://lore.kernel.org/virtualization/b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com/
>
> This patch was the one making me notice the problem.

Will do.

Thanks,

        Thomas
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
