Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D59C7EE29
	for <virtualization@archiver.kernel.org>; Sat, 10 Jun 2023 18:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 67E6260FDB;
	Sat, 10 Jun 2023 18:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67E6260FDB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YCL2WcdN;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=S7g5PoBv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xFK80ZrHJqUB; Sat, 10 Jun 2023 18:47:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BA30260FD5;
	Sat, 10 Jun 2023 18:47:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA30260FD5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7EC16C0037;
	Sat, 10 Jun 2023 18:47:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7BD2C0029
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 18:47:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC012821DA
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 18:47:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC012821DA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=YCL2WcdN; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=S7g5PoBv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id binvejwJQ9J7
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 18:47:19 +0000 (UTC)
X-Greylist: delayed 00:09:58 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EB82821CE
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EB82821CE
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Jun 2023 18:47:18 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1686422239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N7WjIOv23GkoARnLqItYOF1clW2sOuIKmsM3GXO5Xpg=;
 b=YCL2WcdNIO0s3K7UdC06CzI1RNfJDkJe7HEF4v5qdxN8RrO3sAaq8xX62f444BjcyFpI8P
 dvsdlA/V4XzVxCD0n8uz5bQYGAgwsvDqWJ8rNLJDHj8k8iQwRRGGrRVWI0YDNiCXV818Ht
 GruRrk0/QYF97Rhj5uVOQfTLlEitAY6Rs+rjvdpG7tob605G0Kvr/fVugOur6hufdowyf4
 Ax62Ig7bPHia5hggr2KaWqBtF0qOBpkmhrvFk02kMofvAv6EhF1xBRXZSKW4DrYvu52o5K
 D3W+c9UFX4owv7UrRYBLocORMja3sAJWQxRmRkowpokWoNy9GULDK6NIlr681w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1686422239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N7WjIOv23GkoARnLqItYOF1clW2sOuIKmsM3GXO5Xpg=;
 b=S7g5PoBvQUVBSn498XvK9vJHSGy+5G3W0vpFYxeTng6YEJJyB4cAG/EGEkYC18Ui7RMwlG
 7oqYWL4zDKXltfCg==
To: Hou Wenlong <houwenlong.hwl@antgroup.com>, Dave Hansen
 <dave.hansen@intel.com>
Subject: Re: [PATCH RFC 0/4] x86/fixmap: Unify FIXADDR_TOP
In-Reply-To: <20230608093303.GA16983@k08j02272.eu95sqa>
References: <cover.1684137557.git.houwenlong.hwl@antgroup.com>
 <1f633e99-d294-6932-31e9-0eb158d030ea@intel.com>
 <20230608093303.GA16983@k08j02272.eu95sqa>
Date: Sat, 10 Jun 2023 20:37:18 +0200
Message-ID: <87y1kr88pt.ffs@tglx>
MIME-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org,
 Usama Arif <usama.arif@bytedance.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Brian Gerst <brgerst@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Juergen Gross <jgross@suse.com>, Alexey Makhalov <amakhalov@vmware.com>,
 linux-kernel@vger.kernel.org,
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

On Thu, Jun 08 2023 at 17:33, Hou Wenlong wrote:
> On Wed, Jun 07, 2023 at 08:49:15PM +0800, Dave Hansen wrote:
>> What problems does this patch set solve?  How might that solution be
>> visible to end users?  Why is this problem important to you?
>
> We want to build the kernel as PIE and allow the kernel image area,
> including the fixmap area, to be placed at any virtual address.

You are still failing to tell us why you want that and which problem
this solves. Just that fact that you want to something is not an
argument.

> We have also implemented a PV Linux guest based on PIE, which can be
> used in software virtualization similar to Lguest. PIE makes the guest
> kernel share the host kernel space similar to a normal userspace
> process.  Additionally, we are considering whether it is possible to
> use PIE and PVOPS to implement a user-mode kernel.

That solves what?

Thanks,

        tglx
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
