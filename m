Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70B4C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 20:09:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87727605A7;
	Tue, 26 Apr 2022 20:09:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XOq421vKocCu; Tue, 26 Apr 2022 20:09:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A8A860706;
	Tue, 26 Apr 2022 20:09:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFD5DC0039;
	Tue, 26 Apr 2022 20:09:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92AC7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 20:09:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A09040A42
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 20:09:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xe_RwuY387-U
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 20:09:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D85640275
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 20:09:48 +0000 (UTC)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 79D091EC013E;
 Tue, 26 Apr 2022 22:09:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1651003781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=g+qc3MZ0SQsvosVVg7h3CKtzDX+zr1LTTY7ud+C7p94=;
 b=GUxKH9o77tdVt0rqwRSeU3fUYAlvlTkvhwr15Rs40kD2dZ5yKdFvRJGFXCxpUNV0SFsxwP
 qnW2VQIe8J1Jp1dpOAts0sf+yiOAUT8Ifyc51B8XqFD9D6wCAYxIZvFYhvIJ/MM2DIKunD
 VXk4NdNk5fEXgr1gM1va5FIoRXXStNc=
Date: Tue, 26 Apr 2022 22:09:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 1/2] kernel: add platform_has() infrastructure
Message-ID: <YmhRgn896loDHofa@zn.tnic>
References: <20220426134021.11210-1-jgross@suse.com>
 <20220426134021.11210-2-jgross@suse.com> <YmgsYvWQchxub8cW@zn.tnic>
 <YmhNxnHMe/of4rDD@osiris>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmhNxnHMe/of4rDD@osiris>
Cc: linux-hyperv@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, Dexuan Cui <decui@microsoft.com>,
 Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <olekstysh@gmail.com>,
 Sven Schnelle <svens@linux.ibm.com>
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

On Tue, Apr 26, 2022 at 09:53:42PM +0200, Heiko Carstens wrote:
> > You probably should make that thing static and use only accessors to
> > modify it in case you wanna change the underlying data structure in the
> > future.
>
> That would add another indirection, which at least I think is not
> necessary and would make it less likely that this infrastructure is
> used.

So if you want to have a single variable which contains platform feature
bits, you don't need any platform_<bla> accessors but use this variable
directly.

I'd prefer the accessors any day of the week, though.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
