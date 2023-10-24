Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C35C07545
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 21:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A9AB43129;
	Tue, 24 Oct 2023 21:19:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A9AB43129
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=SB52f3i8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aHGu00EYo1Ue; Tue, 24 Oct 2023 21:19:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6EA7C430ED;
	Tue, 24 Oct 2023 21:19:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6EA7C430ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F0FEC0071;
	Tue, 24 Oct 2023 21:19:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1C85C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:19:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9A3964F04F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:19:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A3964F04F
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=SB52f3i8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wxegat70lj8l
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:19:11 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BF3F84F04C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 21:19:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF3F84F04C
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9e95aa02dso1729565ad.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698182351; x=1698787151;
 darn=lists.linux-foundation.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+cZiVId6MMrE0VNYNpV7bLYZrEWEZQeY5gw9zkpQIc=;
 b=SB52f3i8V04ZZtuJxJWX9n71QFPGDNSQFbCUZ+1Aci7OJ/D8g5EJq4Yhl4tpqLYHKd
 Ny56Q9o4Ym9xMBJPQIPUFxAbe3V65kSoPnqTADR3FKpt/M/AKEzSLZCU0w+R87gA6uvW
 FAfn8skQGRukToSOoljaFuFwYudbZrXgVt66o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698182351; x=1698787151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+cZiVId6MMrE0VNYNpV7bLYZrEWEZQeY5gw9zkpQIc=;
 b=RklXPdQGywBmW431K3PydG0213p/jf9g2uelO6+O23jyjAL6TE9quSuEAaLpDdEVu1
 2cqM+LZ6Wbrkqmi3vKXQju+QwF+csfEjH7WvKa7+VJum1JI8uz+aTndQj9F793f/cuAK
 jA+HigTkeNxwz6bt8Ly0sS43NmSLmr94gg+yIU5SxFssjNngo871HK1KzV76umtIF2t/
 qo+JEIsRySNn1W0zLSqRzdKpkH2x0SGxNhnDxXA6IqZmz/UCl0j+9SxyTlCeVa+Epm0Z
 XNOtShEZs5JqzWtU8Na5H3/ioQXrE33GfyAQSy5bciB9J5IwZnF+VOqTUT3fUOvDmFcv
 pIcg==
X-Gm-Message-State: AOJu0Yzd+3jgeKYwFjVlmy8m9VMGkaEBPvEky8Xp7FTAFNKr8E7I9YiN
 +KB4RkG9zKz7o3ZtvlSPtyOgJw==
X-Google-Smtp-Source: AGHT+IGjL3fm2X2hvJcIZ8vhkMxJoeoI99wJ8vtRUXaY4HddAxAKijf1XivLedwDrIyKkSWlkqxCEg==
X-Received: by 2002:a17:902:dac5:b0:1c0:cbaf:6954 with SMTP id
 q5-20020a170902dac500b001c0cbaf6954mr19334024plx.25.1698182351138; 
 Tue, 24 Oct 2023 14:19:11 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net.
 [198.0.35.241]) by smtp.gmail.com with ESMTPSA id
 h6-20020a170902f54600b001bb892a7a67sm7860951plf.1.2023.10.24.14.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 14:19:08 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Amit Shah <amit@kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] virtio_console: Annotate struct port_buffer with
 __counted_by
Date: Tue, 24 Oct 2023 14:18:56 -0700
Message-Id: <169818232963.2100071.8744701530771099437.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922175115.work.059-kees@kernel.org>
References: <20230922175115.work.059-kees@kernel.org>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, llvm@lists.linux.dev,
 Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Nathan Chancellor <nathan@kernel.org>, linux-hardening@vger.kernel.org,
 Tom Rix <trix@redhat.com>
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

On Fri, 22 Sep 2023 10:51:15 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct port_buffer.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] virtio_console: Annotate struct port_buffer with __counted_by
      https://git.kernel.org/kees/c/bf5abc17bc43

Take care,

-- 
Kees Cook

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
