Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88946C7EE25
	for <virtualization@archiver.kernel.org>; Wed,  7 Jun 2023 18:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0132360A67;
	Wed,  7 Jun 2023 18:29:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0132360A67
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Mo7738aD;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/h0BEeBY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RBteYkb8oEq0; Wed,  7 Jun 2023 18:29:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7781A60B49;
	Wed,  7 Jun 2023 18:29:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7781A60B49
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E19CC007A;
	Wed,  7 Jun 2023 18:29:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8ADF0C0029
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 18:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6525181DF3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 18:29:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6525181DF3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=Mo7738aD; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=/h0BEeBY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SJA4SRVBxlUI
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 18:29:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05BD381DE7
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 05BD381DE7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Jun 2023 18:29:36 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1686162573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vhANbTQxhW5giEgdQGefPD2Te4s/UC7F1qDEdOjzG0=;
 b=Mo7738aD+YotFaAvA5/ObujektbVcCYSas0zkHcEOWfQQrl8ZTc7i/g5UJWB/I7qd3aPpx
 D9IqLWq8iOUr1ZQqXlngl2cfBao8fNu4CGXKcpGjxggXz8HIfzDmo8h9tC//7H4DY4yI/g
 XQag2wldSYYM+/zTYUeIU22/CCMKNnrNQFMAYvEffPwFIY5450/eHdZ1quVfXMtlpfzkfm
 Xjb8T5mR1MBaMavj145MvDt1tuUUtB4EDj0IWGj8080CtI5KuD8T4VSfekn9sXObLqatQY
 /oNfNVpg7nj2VOqs5BMOldxSX1HC+9bjp7eFGMdHPj+7lZayUHPRYuHYvpk5eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1686162573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vhANbTQxhW5giEgdQGefPD2Te4s/UC7F1qDEdOjzG0=;
 b=/h0BEeBYLORpbcZp0MX6wq1y2VNw6+Wea4DCG/vpqwQeLOBfgwkSRAUP4ZtqpiT3J0Wu21
 xKOnKuP3naVH45BQ==
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] x86/fixmap: Unify FIXADDR_TOP
In-Reply-To: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
References: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
Date: Wed, 07 Jun 2023 20:29:32 +0200
Message-ID: <877csfjfcj.ffs@tglx>
MIME-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Usama Arif <usama.arif@bytedance.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Hou Wenlong <houwenlong.hwl@antgroup.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Brian Gerst <brgerst@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Juergen Gross <jgross@suse.com>, Alexey Makhalov <amakhalov@vmware.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw@amazon.co.uk>,
 "Mike Rapoport \(IBM\)" <rppt@kernel.org>
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

On Mon, May 15 2023 at 16:19, Hou Wenlong wrote:

> This patchset unifies FIXADDR_TOP as a variable for x86, allowing the
> fixmap area to be movable and relocated with the kernel image in the
> x86/PIE patchset [0]. This enables the kernel image to be relocated in
> the top 512G of the address space.

What for? What's the use case.

Please provide a proper argument why this is generally useful and
important.

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
