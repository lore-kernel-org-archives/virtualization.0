Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD45CC77B75
	for <virtualization@archiver.kernel.org>; Fri, 19 May 2023 12:09:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3252141605;
	Fri, 19 May 2023 12:09:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3252141605
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=Q0MlMmxT;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=rt1BNYex
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ssh8jZ4KrPUd; Fri, 19 May 2023 12:09:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0B0D440C1B;
	Fri, 19 May 2023 12:09:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B0D440C1B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6FF2C0035;
	Fri, 19 May 2023 12:09:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D253CC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 12:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AC9948300C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 12:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC9948300C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de
 header.a=rsa-sha256 header.s=fm3 header.b=Q0MlMmxT; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=rt1BNYex
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0yoQcck_FnYo
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 12:09:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B67E183004
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B67E183004
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 May 2023 12:09:34 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id AC3AD5C0208;
 Fri, 19 May 2023 08:09:33 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Fri, 19 May 2023 08:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm3; t=1684498173; x=1684584573; bh=Mx
 aybIo+rxpirmU88Zvah8XfxfWvwDtpl+cNoSkys6I=; b=Q0MlMmxTzyw4pVVcJT
 vRqaslXkNToR2VaA4IHp2uzwMBULCK8c/Sxfynl9jnpFU5Oeb/24g73/8G2VcEMe
 GHJz37cuzeUD0J8zSy96C0q06yH5b0NYLYhaWn1Gw0LDYgl3zuB8ruBcheCitHnb
 oEz9J2qJ4iS/mhfdVw1BhrWZyZbuaN92Wd4Ns1DOvhwXE0dZEf387chWc1qNPvA7
 H6LeV3AEaLZ3wIAIievFk9VXl4/o5oNpipBDcCmKN05sLL2BwTEPCmjK2IV/OmoV
 ehq/Hcy4ULr/4ilyo7AGGTveSq5qN9w/6o90ZYcpQhCvG1Fc5t2twZRNORTKjrk+
 i6Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1684498173; x=1684584573; bh=MxaybIo+rxpir
 mU88Zvah8XfxfWvwDtpl+cNoSkys6I=; b=rt1BNYexiUNroHAALgEkYqfePno/6
 XwxxgFiiA/Wbfk6hTu/XlsXLpj2AHFEuRDmj8gEVhc6SQdZ+PpfN5LOu72VUeQ9+
 y6HkzIq9c2aK8wyOuJTxVTj9nErufpZ5PcVxle9HXA9TfrFSnW+uaPpPlyO2Ceid
 Nq2uMrvdwvogH385uqOMUcv+nw9gADpplGLQQvcHLwSkeghzTZwikd2RghzmIra5
 kT91kkOSEcJ3Cm2ptafQldBC85kh7Ch2Nsk9MatlA38qTzcYrL6g4GF9GsbeeEAL
 pjztTxP5cRHtNfbhFK7i7HyixdZzM2u3vpo0Ij/FyoEjhsgGDuAN+0LPw==
X-ME-Sender: <xms:_GZnZJnWZB2IyypOr_yRnE0D3CvKXbEq05w1xtt0PEPHojUtrJ9MMQ>
 <xme:_GZnZE3xvucdo-tfM8QW2EAJZB2cLg5FK-b55YHFAak6yQxPgdokQkFRcuORdo1-b
 j0iVbQuppIa6aIaKBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedggeelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
 nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
 htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
 teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:_GZnZPpDdGmXZCCb7m59J49-q5TnDSqQBwV6B31eJLU3NxqW9Mifmg>
 <xmx:_GZnZJn57hY2WDzP4ha-F1l54B-WWf1X7xyQqCE9g3bQ7QrrPpXeig>
 <xmx:_GZnZH2AT3tC_hFcIMFDqo84dtlpJ0mh489IMmq_BtxdyO71BrapSA>
 <xmx:_WZnZLLmQYCUSB-Wfx2NvnHGRoXma16YUbBHKSLs0RdQMpJEHg4p2w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 147E1B6008D; Fri, 19 May 2023 08:09:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <9aaed1c3-9a7d-4348-b15f-2bb9be654bef@app.fastmail.com>
In-Reply-To: <a78d9dcd-0bc1-7e98-a8f1-e5d6cd0c09a3@intel.com>
References: <20230516193549.544673-1-arnd@kernel.org>
 <a78d9dcd-0bc1-7e98-a8f1-e5d6cd0c09a3@intel.com>
Date: Fri, 19 May 2023 14:09:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dave Hansen" <dave.hansen@intel.com>, "Arnd Bergmann" <arnd@kernel.org>, 
 x86@kernel.org
Subject: Re: [PATCH 00/20] x86: address -Wmissing-prototype warnings
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

On Thu, May 18, 2023, at 23:56, Dave Hansen wrote:
> On 5/16/23 12:35, Arnd Bergmann wrote:
>> 
>> All of the warnings have to be addressed in some form before the warning
>> can be enabled by default.
>
> I picked up the ones that were blatantly obvious, but left out 03, 04,
> 10, 12 and 19 for the moment.

Ok, thanks!

I've already sent a fixed version of patch 10, let me know if you
need anything else for the other ones.

> BTW, I think the i386 allyesconfig is getting pretty lightly tested
> these days.  I think you and I hit the same mlx4 __bad_copy_from()
> compile issue.

I did all my testing on randconfig builds, so I probably caught a lot
of the more obscure corner cases, but it doesn't always hit everything
that is in allyesconfig/allmodconfig.

       Arnd
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
