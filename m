Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8EAECAAD4
	for <virtualization@archiver.kernel.org>; Sat,  3 Sep 2022 04:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 448B64154D;
	Sat,  3 Sep 2022 04:35:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 448B64154D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=dkim header.b=ZnwSSY9N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wbTkCg-oV4sG; Sat,  3 Sep 2022 04:35:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 973E3410D2;
	Sat,  3 Sep 2022 04:35:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 973E3410D2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CCE9C0032;
	Sat,  3 Sep 2022 04:35:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE1D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Sep 2022 04:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74E6360AC1
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Sep 2022 04:35:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74E6360AC1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de
 header.a=rsa-sha256 header.s=dkim header.b=ZnwSSY9N
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 37kYKPufT2aM
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Sep 2022 04:35:36 +0000 (UTC)
X-Greylist: delayed 00:07:11 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1CA0F60A66
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1CA0F60A66
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Sep 2022 04:35:36 +0000 (UTC)
Received: from nazgul.tnic (unknown [84.201.196.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 388361EC068C;
 Sat,  3 Sep 2022 06:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1662179297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=CgxVGHbcD6eBLXY0Rv8tA3Z9PMAyTxATsYR3svKe7OY=;
 b=ZnwSSY9N+SjfnUMLmSNNXiiMfoCC6xe5ndI41dF/pnrKq5y+iOXVkImza9x1/eVvm7Vq6B
 btQI0n1TumNj7EfMoSrhKrr3I2IQ/IZAwdSGLGTJnM4HmmZ4XTTarbeEID+Z+g+ty3W9OC
 z16HA8GL3jtpTh5lF70Z/wz2MlBR21c=
Date: Sat, 3 Sep 2022 06:28:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Bill Wendling <morbo@google.com>
Subject: Re: [PATCH 1/2] x86/paravirt: clean up typos and grammaros
Message-ID: <YxLX5i0aUoe9zBsx@nazgul.tnic>
References: <20220902213750.1124421-1-morbo@google.com>
 <20220902213750.1124421-2-morbo@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220902213750.1124421-2-morbo@google.com>
Cc: Juergen Gross <jgross@suse.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 llvm@lists.linux.dev, Alexey Makhalov <amakhalov@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

On Fri, Sep 02, 2022 at 09:37:49PM +0000, Bill Wendling wrote:
> Drive-by clean up of the comment.
> 
> [ Impact: cleanup]

We used to do that type of "impact" tagging years ago but we stopped.
Where did you dig this out from?

:)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
