Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8299DC001DF
	for <virtualization@archiver.kernel.org>; Thu,  3 Aug 2023 22:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DCBA2400D2;
	Thu,  3 Aug 2023 22:43:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DCBA2400D2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AdrcoKcY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L0kX3rKcYZKJ; Thu,  3 Aug 2023 22:43:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 17EFC41F7F;
	Thu,  3 Aug 2023 22:43:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17EFC41F7F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFEC3C0071;
	Thu,  3 Aug 2023 22:43:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2D8EC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 22:43:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 890B741F2E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 22:43:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 890B741F2E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DlVmbd2BKhy8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 22:43:00 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BB7941F08
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Aug 2023 22:43:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BB7941F08
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bba04b9df3so12899005ad.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Aug 2023 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691102580; x=1691707380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INe5iUN8OqFkxldA5UUSZCvoiHbOkh93tbzwvbZM2yg=;
 b=AdrcoKcYKsDTC2sk5II1JfGBSGWxn+Mf/Sxnutk3q1l506vOr49iIj/50hD798HN7F
 b0OZc7JKWeDh12FhSjL1Xl4BHhP+B9RobN0klmBuKMhnefOK9+UFoMYitJo0B22Um2dY
 eJvU1iwgwiD/b9pJcn2WLq9Pd4MHq6mJciEdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691102580; x=1691707380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INe5iUN8OqFkxldA5UUSZCvoiHbOkh93tbzwvbZM2yg=;
 b=UlZN8A6PKdI4DNisjpOkA61bG2tXx5e/EWl80/K26y/PrX064cmcNZ3FLGWbWtGOyi
 CGd5Cf2B1aIEIBa8Zsx1pYWn+9IBQg7tcTC1o3CQd+Sesadt8JKgspqaRyd6idK2uV7C
 DnHCwwEu/6AakclzyHs+yRAlnd7MZh976oKtMAY9tPI6Y67kX/MssJYYb0osRlLlrfTw
 Pw4PeZW2+6R5pEZZ5RYmVSm/fSdVQPaREScrnk3JjgXi0lfPg33QTSoxtWGxaNs9jwfH
 +IFfClzhNe0/VQoLU9yoQqc770jutb7u6l4zYfxBz9UfEKvT97WVnBQhTYyLO1HCqwLm
 odpg==
X-Gm-Message-State: AOJu0YwBO2eA5YYMnO0Z/cCnqSVjukrYldCWBwhLcd6K7u2WBrRnwVR/
 nVxdZ+nsJDHyhJL46er3Lw9p5g==
X-Google-Smtp-Source: AGHT+IFvgcDqbfRdpydPq4ink9vQ3N7ScSsxcZoM/8xiqyVFgUTfakh0jjBFWkrGAUhq6+xeRCxMNQ==
X-Received: by 2002:a17:903:2351:b0:1bb:a85c:23cc with SMTP id
 c17-20020a170903235100b001bba85c23ccmr141262plh.15.1691102579859; 
 Thu, 03 Aug 2023 15:42:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 p7-20020a170902bd0700b001bc2831e1a8sm355952pls.80.2023.08.03.15.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:42:59 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Juergen Gross <jgross@suse.com>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/paravirt: Fix tlb_remove_table function callback
 prototype warning
Date: Thu,  3 Aug 2023 15:42:49 -0700
Message-Id: <169110256709.2294259.13111562642254330671.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726231139.never.601-kees@kernel.org>
References: <20230726231139.never.601-kees@kernel.org>
MIME-Version: 1.0
Cc: x86@kernel.org, kernel test robot <lkp@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, llvm@lists.linux.dev,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ajay Kaher <akaher@vmware.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, linux-hardening@vger.kernel.org,
 Sami Tolvanen <samitolvanen@google.com>,
 Alexey Makhalov <amakhalov@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, 26 Jul 2023 16:11:43 -0700, Kees Cook wrote:
> Under W=1, this warning is visible in Clang 16 and newer:
> 
> arch/x86/kernel/paravirt.c:337:4: warning: cast from 'void (*)(struct mmu_gather *, struct page *)' to 'void (*)(struct mmu_gather *, void *)' converts to incompatible function type [-Wcast-function-type-strict]
>                            (void (*)(struct mmu_gather *, void *))tlb_remove_page,
>                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Add a direct wrapper instead, which will make this warning (and
> potential KCFI failures) go away.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] x86/paravirt: Fix tlb_remove_table function callback prototype warning
      https://git.kernel.org/kees/c/fcce1c6cb156

Take care,

-- 
Kees Cook

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
