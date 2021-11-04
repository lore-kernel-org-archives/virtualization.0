Return-Path: <SRS0=bIcn=PX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B216C433F5
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 09:18:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12852611C1
	for <virtualization@archiver.kernel.org>; Thu,  4 Nov 2021 09:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12852611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF61080BE1;
	Thu,  4 Nov 2021 09:18:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PCj7dweRH_GT; Thu,  4 Nov 2021 09:18:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7037C80BB3;
	Thu,  4 Nov 2021 09:18:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 067D5C0012;
	Thu,  4 Nov 2021 09:18:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2615FC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 09:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07E4940463
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 09:18:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="r5olXBSm";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="B64qHNyB"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7qaSi516EAe0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 09:18:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CE5C40438
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 09:18:26 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1636017504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GczxBPQS1aWLkGQ/wyV5Px0pkwVjRf/kfMmmLUyHdQ=;
 b=r5olXBSmQCbu8oOwspom3OtmhhKCStXJkIlebYFkcAz/rl7xPX0gLZn/wk3WKqvSWMXZSt
 cnhtY/FoNEVVJ9nU5feJ3eSkJYwOqllYxlA+rEbVl7+w6C8InV3oixjt4IV9Vc+paYf5t1
 gwj1jRI1qNN05T4ngu7XEgW+lpVH/nPsroi1dIkYr6jlOHEy6Ob/aSylBaoLjme7Z48RrY
 MmUpMwRr82oowEJ9DoWbCSp0odgedLjB2ZROE/MLrxDf4SS7m1XyxbrKW7UY0Zsg/xluDw
 H5of7LxpUkpuq4LsI2xtcdyETXKIR9bRseFzbrCY+VaXFt1K0afeLEbRquMzRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1636017504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1GczxBPQS1aWLkGQ/wyV5Px0pkwVjRf/kfMmmLUyHdQ=;
 b=B64qHNyBpCZ0eJMX9FKx+z6CSX4qAoFkGx1xyuxS/tm4s9yJqopBWFhgrxA2Kt8y/NAShn
 lBV5YlJ6BO1vOWCw==
To: Juergen Gross <jgross@suse.com>, X86 ML <x86@kernel.org>, Linux
 Virtualization <virtualization@lists.linux-foundation.org>
Subject: Re: Which tree for paravirt related patches?
In-Reply-To: <874k8s5lgz.ffs@tglx>
References: <60a2037d-2d4d-e9e9-edfd-b889c4bd3fb6@suse.com>
 <874k8s5lgz.ffs@tglx>
Date: Thu, 04 Nov 2021 10:18:24 +0100
Message-ID: <87zgqk46u7.ffs@tglx>
MIME-Version: 1.0
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, IngoMolnar <mingo@redhat.com>,
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

On Thu, Nov 04 2021 at 10:17, Thomas Gleixner wrote:

CC+ x86, peterz

> Juergen,
>
> On Thu, Nov 04 2021 at 06:53, Juergen Gross wrote:
>
>> A recent patch modifying the core paravirt-ops functionality is
>> highlighting some missing MAINTAINERS information for PARAVIRT_OPS:
>> there is no information which tree is to be used for taking those
>> patches per default. In the past this was mostly handled by the tip
>> tree, and I think this is fine.
>>
>> X86 maintainers, are you fine with me modifying the PARAVIRT_OPS entry
>> to add the x86 ML and the tip tree? This way such patches will be
>> noticed by you and can be handled accordingly.
>
> Sure.
>
>> An alternative would be to let me carry those patches through the Xen
>> tree, but in lots of those patches some core x86 files are being touched
>> and I think the tip tree is better suited for paravirt handling.
>
> Fair enough.
>
>> And please, could you take a look at:
>>
>> https://lore.kernel.org/virtualization/b8192e8a-13ef-6ac6-6364-8ba58992cd1d@suse.com/
>>
>> This patch was the one making me notice the problem.
>
> Will do.
>
> Thanks,
>
>         Thomas
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
