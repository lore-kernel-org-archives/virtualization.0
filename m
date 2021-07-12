Return-Path: <SRS0=5hAK=ME=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D87C07E99
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 16:29:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCF3361158
	for <virtualization@archiver.kernel.org>; Mon, 12 Jul 2021 16:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF3361158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D5CE40504;
	Mon, 12 Jul 2021 16:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sZwgri-CI028; Mon, 12 Jul 2021 16:29:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CA69B404E8;
	Mon, 12 Jul 2021 16:29:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7D4DC0010;
	Mon, 12 Jul 2021 16:29:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5CD3C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 16:29:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC1E540507
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 16:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jRvVq6AKkXcP
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 16:29:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52606404E8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626107376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TJmtx5S78DeUeOiaROIWgqckn0w0Vqgpgk4lj+SYH84=;
 b=OWKIE1Bh6PH6cf+yWClCtm2dN+jfusfpVZjN/azvZYm6LP8GXxoxpr1BfHeUbHY6QNgV3z
 l3u/mwiD8BHf9Ne0qPVej5ehdsbo9Sff/7eck5clXEetmWJCvWcWD+K9oNT2ljjLHLJVdW
 ZsQ+okMwAf5F7pSVZzYCP6pBzysQGFs=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-aWc8elpAMqW3ibYr0R1kdw-1; Mon, 12 Jul 2021 12:29:34 -0400
X-MC-Unique: aWc8elpAMqW3ibYr0R1kdw-1
Received: by mail-io1-f71.google.com with SMTP id
 i9-20020a0566021349b02904df6556dad4so12254835iov.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 09:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TJmtx5S78DeUeOiaROIWgqckn0w0Vqgpgk4lj+SYH84=;
 b=EmE4/ANBGiJQX3XPoCwaBGBdayHLeEuNcardiYyNoMl0rN5Lj0+BtTX+5/aRolQ8hb
 qUVTNwKL9gno/UC7bsyhsrzCEf2x7HmnYfhXK83J47OImoMXgQivcGl6dsScD3wbgBip
 3IDIuMAnvcO8rzw/gToPY5ujY1+ZYSThR1aGDefRkFnQ4Z+VCTxBRq9N3f5aoqrpCsJt
 P9f+dzbtjYowGyC6PrXGGmMxECddN8z4V4J3UTKZvyPG9FgMCnjnK1oiBKI2zZAT2Y+Q
 cDIZxBjjxNcpTlMm2ZbnP210eU+8p8FVCzUznoo9CdIZs3eLe4yMWLpDPmWpx8fWZQ8S
 YY7g==
X-Gm-Message-State: AOAM532QJGYNEGXWSrYJSKim7Q0X/MMBfh3BqUYSgz3rLZjUD2w0XAeT
 RrRHj1QQ5k31BouerRFfSp/P/UU7yVP3gjFO+S6BW1TKb9FQyex8/672cTk0ERTUWs4i+NXwMDe
 nUiGucG4k/2kcaZqWVNbRhw/MDaK9KRmTVESLptVIyQ==
X-Received: by 2002:a5d:9396:: with SMTP id c22mr1954803iol.204.1626107373566; 
 Mon, 12 Jul 2021 09:29:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwImilQcOnLt4sAj84ow/BK6iQ1ylqR4O4cCQi7qJ0WuQd4a7pAccIK5xQXdYHv+ORO5s/zdw==
X-Received: by 2002:a5d:9396:: with SMTP id c22mr1954792iol.204.1626107373284; 
 Mon, 12 Jul 2021 09:29:33 -0700 (PDT)
Received: from gator ([140.82.166.162])
 by smtp.gmail.com with ESMTPSA id x10sm751617ill.26.2021.07.12.09.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jul 2021 09:29:32 -0700 (PDT)
Date: Mon, 12 Jul 2021 18:29:30 +0200
From: Andrew Jones <drjones@redhat.com>
To: Varad Gautam <varad.gautam@suse.com>
Subject: Re: [kvm-unit-tests PATCH 0/6] Initial x86_64 UEFI support
Message-ID: <20210712162930.hhxv66geufxqe4vy@gator>
References: <20210702114820.16712-1-varad.gautam@suse.com>
MIME-Version: 1.0
In-Reply-To: <20210702114820.16712-1-varad.gautam@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pbonzini@redhat.com, bp@suse.de
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

On Fri, Jul 02, 2021 at 01:48:14PM +0200, Varad Gautam wrote:
> This series brings EFI support to a reduced subset of kvm-unit-tests
> on x86_64. I'm sending it out for early review since it covers enough
> ground to allow adding KVM testcases for EFI-only environments.
> 
> EFI support works by changing the test entrypoint to a stub entry
> point for the EFI loader to jump to in long mode, where the test binary
> exits EFI boot services, performs the remaining CPU bootstrapping,
> and then calls the testcase main().
> 
> Since the EFI loader only understands PE objects, the first commit
> introduces a `configure --efi` mode which builds each test as a shared
> lib. This shared lib is repackaged into a PE via objdump.
> 
> Commit 2-4 take a trip from the asm entrypoint to C to exit EFI and
> relocate ELF .dynamic contents.
> 
> Commit 5 adds post-EFI long mode x86_64 setup and calls the testcase.
> 
> Commit 6 patches out some broken tests for EFI. Testcases that refuse
> to build as shared libs are also left disabled, these need some massaging.
> 
> git tree: https://github.com/varadgautam/kvm-unit-tests/commits/efi-stub

Hi Varad,

Thanks for this. I haven't reviewed it in detail yet (I just got back from
vacation), but this looks like the right approach. In fact, I had started
going down the efi stub approach for AArch64 a while back as well, but the
effort got preempted by other work [again]. I'll try to allocate time to
play with this for x86 and to build on it for AArch64 in the coming weeks.

drew

> 
> Varad Gautam (6):
>   x86: Build tests as PE objects for the EFI loader
>   x86: Call efi_main from _efi_pe_entry
>   x86: efi_main: Get EFI memory map and exit boot services
>   x86: efi_main: Self-relocate ELF .dynamic addresses
>   cstart64.S: x86_64 bootstrapping after exiting EFI
>   x86: Disable some breaking tests for EFI and modify vmexit test
> 
>  .gitignore          |   2 +
>  Makefile            |  16 ++-
>  configure           |  11 ++
>  lib/linux/uefi.h    | 337 ++++++++++++++++++++++++++++++++++++++++++++
>  x86/Makefile.common |  45 ++++--
>  x86/Makefile.x86_64 |  43 +++---
>  x86/cstart64.S      |  78 ++++++++++
>  x86/efi.lds         |  67 +++++++++
>  x86/efi_main.c      | 167 ++++++++++++++++++++++
>  x86/vmexit.c        |   7 +
>  10 files changed, 741 insertions(+), 32 deletions(-)
>  create mode 100644 lib/linux/uefi.h
>  create mode 100644 x86/efi.lds
>  create mode 100644 x86/efi_main.c
> 
> -- 
> 2.30.2
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
