Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E7AC77B7A
	for <virtualization@archiver.kernel.org>; Fri, 19 May 2023 11:04:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7552611A5;
	Fri, 19 May 2023 11:04:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7552611A5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=fgD3+fCl;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=dFs0aALa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aItW2ReMQ4fr; Fri, 19 May 2023 11:04:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F23C2611AA;
	Fri, 19 May 2023 11:04:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F23C2611AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8715C0036;
	Fri, 19 May 2023 11:04:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0863EC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 11:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A768083163
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 11:04:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A768083163
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de
 header.a=rsa-sha256 header.s=fm3 header.b=fgD3+fCl; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=dFs0aALa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bhQW9SDpLjb6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 11:04:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4851081E0E
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4851081E0E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 11:04:30 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 888FD5C018C;
 Fri, 19 May 2023 07:04:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Fri, 19 May 2023 07:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1684494265; x=1684580665; bh=/C
 wla6Z93CmdqEZ213cheaHU/C7xFoaUH7cr2bjxpHQ=; b=fgD3+fClg58VBaUs//
 zaPCHvCJP5VwPquLsJQCejG585X4z+0cgq8+PVQLQhfsm5YWTZtpvK/KaaglSt4v
 AZlDlbvGF3uoZD3fC2SSE25eKMeiJ6Wom5J1YcG2GkUcncWYRhxQyk68GPcM/VQp
 34Ei3ImxNpBRwXdc9tym77ZcH2TZYznA5nJLd0dV2c5Gry+glxktVg9gmMI9439a
 f3L5sFm8wopBNd1vAmNNyXTneaLVTBRRVuEaIadcCeApET3YIvFnFJalDw9tA0h/
 2TZol3iqiGR+i22jK3aoA3M0ZmXVLJnvyzijOnDj+ydVHvdZRUx6GiucYtjtNpoN
 JBTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1684494265; x=1684580665; bh=/Cwla6Z93Cmdq
 EZ213cheaHU/C7xFoaUH7cr2bjxpHQ=; b=dFs0aALapqY2/RKBVBoRgsFC+kwwn
 aghUbwauR7c1rX0XPL5DOBgegPR2+r/bkGNCHfJxUzqFkNmnzE8s/4FBbZi5lUoP
 nAOFrE15xfCXbV5De8PpVHEPPQaEzx07LPV8M2YiUR692Ae414HT9CDIPsp6/adS
 ri78lMwnrM8+0M82lszLmKjmmPSM5wfqXIhxwrHo/HhPJmcwFpyMcgcL4OhJuOKD
 iQ+iy6dLE5E+W30aMejTZcd8FnCpaTSh3UIXb6IRU53VnkL0NvNyaDJ3yMEEg3jy
 Amhm2R5vJ7t1jx6KTPd6J1GyNs70g8SgYMjfUjxhve2s0eAY/TVDwYw5g==
X-ME-Sender: <xms:t1dnZJJPaJ2g_2nxuUp5GipLJ04nJ7R8n701jCM3WJMdOGe7-3CtvQ>
 <xme:t1dnZFIpdftyeukP7ox0wWnWvdRtWV5S4-6mNAnBSP0uR5dlSKF5AEHwrDn2R_GBj
 PS_1pR-COVEJwI7y-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgfeeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
 nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
 htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
 teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:t1dnZBuc-n5XDtHdGoa_Vunbhz_oDVhyhorHNRW0yPyAxt_gejgLQg>
 <xmx:t1dnZKYlvNBeT1qmqCedxwoaVPlHQKmXv30SdUKAdaGMxpMsm1ja6g>
 <xmx:t1dnZAbwOs_Q1raPox-9GKEVt3JVUpAGWNgWD_H68sPb8ESiQXlXfg>
 <xmx:uVdnZLvOcIo3POIIQLS4ujcc4StrWhcyu6DRLzy0SJ32ArlhSgUt0g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 9A414B60089; Fri, 19 May 2023 07:04:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <1f771dae-1bc7-4fd3-8514-613cf3b12e1a@app.fastmail.com>
In-Reply-To: <cabdd839-71d5-aabb-aee6-d37ebcabf2ab@intel.com>
References: <20230516193549.544673-1-arnd@kernel.org>
 <20230516193549.544673-11-arnd@kernel.org>
 <cabdd839-71d5-aabb-aee6-d37ebcabf2ab@intel.com>
Date: Fri, 19 May 2023 13:04:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dave Hansen" <dave.hansen@intel.com>, "Arnd Bergmann" <arnd@kernel.org>, 
 x86@kernel.org
Subject: Re: [PATCH 10/20] x86: xen: add missing prototypes
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, linux-pci@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
 linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 platform-driver-x86@vger.kernel.org, Juergen Gross <jgross@suse.com>,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Andy Shevchenko <andy@infradead.org>
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

On Thu, May 18, 2023, at 19:28, Dave Hansen wrote:
> On 5/16/23 12:35, Arnd Bergmann wrote:
>> 
>> arch/x86/xen/enlighten_pv.c:1233:34: error: no previous prototype for 'xen_start_kernel' [-Werror=missing-prototypes]
>> arch/x86/xen/irq.c:22:14: error: no previous prototype for 'xen_force_evtchn_callback' [-Werror=missing-prototypes]
>> arch/x86/xen/mmu_pv.c:358:20: error: no previous prototype for 'xen_pte_val' [-Werror=missing-prototypes]
>> arch/x86/xen/mmu_pv.c:366:20: error: no previous prototype for 'xen_pgd_val' [-Werror=missing-prototypes]
>
> What's the deal with this one?
>
> The patch is doing a bunch functions on top of the ones from the commit
> message.  Were you just showing a snippet of what the actual set of
> warnings is?

I missed this one going through the changelogs before sending them out,
I thought I had added a proper text to each one, but it fell through the
cracks. I've followed up with a v2 patch that has a proper changelog
now.

      Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
