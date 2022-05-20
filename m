Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0DBC433F5
	for <virtualization@archiver.kernel.org>; Fri, 20 May 2022 14:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B30C60E48;
	Fri, 20 May 2022 14:10:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2XD4AtlAajox; Fri, 20 May 2022 14:10:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9CB7C60C1A;
	Fri, 20 May 2022 14:10:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B834C0039;
	Fri, 20 May 2022 14:10:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24E98C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 14:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 055FD400D2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 14:10:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=alien8.de
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EbjV6eNyGuRQ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 14:10:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B61084037E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 May 2022 14:10:13 +0000 (UTC)
Received: from zn.tnic (p200300ea974657be329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ea:9746:57be:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFFDC1EC0432;
 Fri, 20 May 2022 16:10:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1653055805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=Jw8Jjz7F/KFwbNnn4srCQ68W2G6++y7u/dhV8E5+6KU=;
 b=YKuNyQq5+Wxqlgq1j8eVsbNGFuG5GC1HPYPlVA+ej5bySjFRaLngXPzI4psfQR3nBHlDBK
 GV7UiNzmKppbzkLPb/pZSShOdrqGaB5sS9eO9qvw8S9cTWXe9HlYBuw8M6tPM6+crkuVbG
 nrM+PcXEst6/DRTQD3iDchGEzopo0qc=
Date: Fri, 20 May 2022 16:10:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shreenidhi Shedi <yesshedi@gmail.com>
Subject: Re: [PATCH v1] x86/vmware: use unsigned integer for shifting
Message-ID: <YoehOWHN7h8cFBK5@zn.tnic>
References: <20220520114712.595583-1-sshedi@vmware.com>
 <YoeA4pf5OWxfjE0J@zn.tnic>
 <f05264ce-e90f-0b1a-4796-ec1f3b75c09c@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f05264ce-e90f-0b1a-4796-ec1f3b75c09c@gmail.com>
Cc: x86@kernel.org, amakhalov@vmware.com, Shreenidhi Shedi <sshedi@vmware.com>,
 pv-drivers@vmware.com, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
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

On Fri, May 20, 2022 at 07:33:30PM +0530, Shreenidhi Shedi wrote:
> I deliberately did it because I was lacking clarity on using my org
> mail & personal mail id.

You could have a look at Documentation/process/submitting-patches.rst
and everything under Documentation/process/ in case you don't know what
to do.

Using checkpatch.pl on your patch before submitting it, is also
something you should do.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
