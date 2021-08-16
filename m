Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F5AC4320A
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 07:26:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481BA61ABD
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 07:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 481BA61ABD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0641660672;
	Mon, 16 Aug 2021 07:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VA9QSD9WzrQt; Mon, 16 Aug 2021 07:26:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9022F605A9;
	Mon, 16 Aug 2021 07:26:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 672DFC001A;
	Mon, 16 Aug 2021 07:26:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 327A0C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 07:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1314B4029F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 07:26:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8EtrE2aNOdyZ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 07:26:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E73364029D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 07:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629098796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FA3O9kq9zZ4zw2PdWas27IkNRNFWE0SHht5f8XnWK9Q=;
 b=fYMVLS7V3PlRNwsckrzlqWwOy37g0iU7zPSoxCreZq8yZdgRwKTde3Y9xI+K0CHvOS/2W0
 Q+rq/Z/Ww3ES7kGmpzizBLVy7IqbpvB0Ah2ZUrFkS9r37+ZVgWeGCymnp2dvnZW61p1ieK
 /5Hc7NX9Iry+uKcmbCXuIJHAKNy9s0s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-JMQvRazFOD2TE-zK2gvuhg-1; Mon, 16 Aug 2021 03:26:33 -0400
X-MC-Unique: JMQvRazFOD2TE-zK2gvuhg-1
Received: by mail-ej1-f72.google.com with SMTP id
 zp23-20020a17090684f7b02905a13980d522so4354546ejb.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 00:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FA3O9kq9zZ4zw2PdWas27IkNRNFWE0SHht5f8XnWK9Q=;
 b=HPsGHvp4/BzcBcxQpqE/ASt3qBPR0+jXZh8HFAEkNAH/PKCxMdAzuMKSqHBUGzPkSF
 Sli2v1W8nTb/zfJrQMisMUdTb7TMO1i1qqR4ZHiGdZ7ODtaboZ2AykAO7uYttwhJo8G5
 ZDmMGdM7yCAzpZ18s658NWylm6/3nfpWkBTZDIYPuTk6S0ZBz+sWCmO0OtzKo5aOe0SC
 4Ekaa+E4ocw9mg5xcgcn+g5Dw2h1LhICLRPQVdfiEQGEt1u27Okn/8QZfgi5+RrBN9Qa
 uQAIRuV/3oCwEOJAsXWnl1ar/G4mL+jjTYWPHKE5VMUmMbJ5KhDiMDf3qC65E/uNOLvE
 YcNg==
X-Gm-Message-State: AOAM532PPuvyKXr5LXtIJD6evm/1+deLn1I1EGosOY9wOwMZ47L/d+Oi
 Qn5k9pPyi4hfL0pFdiDaaiugwRlr7w7SbBwd+iDCxnX/IPu64TT0gJ+DZfGBCBkJssPa1bxQO7L
 OsglK3gCJJCscAxdOXqpJfg+tp63IR14TpmNvh1sKIQ==
X-Received: by 2002:a17:906:a044:: with SMTP id
 bg4mr14805760ejb.312.1629098792228; 
 Mon, 16 Aug 2021 00:26:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhkRj547CYPZat8QFWt2HQ16Cy9ciBgzRnXN1/vV8WNUA6TfT0SSqTWAmEddXG8z5naMHWyA==
X-Received: by 2002:a17:906:a044:: with SMTP id
 bg4mr14805735ejb.312.1629098792020; 
 Mon, 16 Aug 2021 00:26:32 -0700 (PDT)
Received: from gator.home (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
 by smtp.gmail.com with ESMTPSA id v13sm3339551ejx.24.2021.08.16.00.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 00:26:31 -0700 (PDT)
Date: Mon, 16 Aug 2021 09:26:29 +0200
From: Andrew Jones <drjones@redhat.com>
To: Marc Orr <marcorr@google.com>
Subject: Re: [kvm-unit-tests PATCH 0/6] Initial x86_64 UEFI support
Message-ID: <20210816072629.zbxooxhr3mkxuwbx@gator.home>
References: <20210702114820.16712-1-varad.gautam@suse.com>
 <CAA03e5HCdx2sLRqs2jkLDz3z8SB9JhCdxGv7Y6_ER-kMaqHXUg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAA03e5HCdx2sLRqs2jkLDz3z8SB9JhCdxGv7Y6_ER-kMaqHXUg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Lendacky, Thomas" <thomas.lendacky@amd.com>,
 Joerg Roedel <jroedel@suse.de>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 kvm list <kvm@vger.kernel.org>, Tom Roeder <tmroeder@google.com>,
 "Hyunwook \(Wooky\) Baek" <baekhw@google.com>,
 virtualization@lists.linux-foundation.org, Zixuan Wang <zixuanwang@google.com>,
 Erdem Aktas <erdemaktas@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 bp@suse.de
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

On Fri, Aug 13, 2021 at 11:44:39AM -0700, Marc Orr wrote:
> On Fri, Jul 2, 2021 at 4:48 AM Varad Gautam <varad.gautam@suse.com> wrote:
> >
> > This series brings EFI support to a reduced subset of kvm-unit-tests
> > on x86_64. I'm sending it out for early review since it covers enough
> > ground to allow adding KVM testcases for EFI-only environments.
> >
> > EFI support works by changing the test entrypoint to a stub entry
> > point for the EFI loader to jump to in long mode, where the test binary
> > exits EFI boot services, performs the remaining CPU bootstrapping,
> > and then calls the testcase main().
> >
> > Since the EFI loader only understands PE objects, the first commit
> > introduces a `configure --efi` mode which builds each test as a shared
> > lib. This shared lib is repackaged into a PE via objdump.
> >
> > Commit 2-4 take a trip from the asm entrypoint to C to exit EFI and
> > relocate ELF .dynamic contents.
> >
> > Commit 5 adds post-EFI long mode x86_64 setup and calls the testcase.
> >
> > Commit 6 patches out some broken tests for EFI. Testcases that refuse
> > to build as shared libs are also left disabled, these need some massaging.
> >
> > git tree: https://github.com/varadgautam/kvm-unit-tests/commits/efi-stub
> 
> Thanks for this patchset. My colleague, Zixuan Wang
> <zixuanwang@google.com>, has also been working to extend
> kvm-unit-tests to run under UEFI. Our goal is to enable running
> kvm-unit-tests under SEV-ES.
> 
> Our approach is a bit different. Rather than pull in bits of the EFI
> library and Linux EFI ABI, we've elected to build the entire
> kvm-unit-tests binaries as an EFI app (similar to the ARM approach).
> 
> To date, we have _most_ x86 test cases (39/44) working under UEFI and
> we've also got some of the test cases to boot under SEV-ES, using the
> UEFI #VC handler.
> 
> We will post our patchset as soon as possible (hopefully by Monday) so
> that the community can see our approach. We are very eager to see
> kvm-unit-tests running under SEV-ES (and SNP) and are happy to work
> with you all on either approach, depending on what the community
> thinks is the best approach.
> 
> Thanks in advance,
> Marc
>

Hi Marc,

I'm definitely eager to see your approach. I was actually working on
a second version of EFI support for ARM using the stub approach like
this series before getting perpetually sidetracked. I've been wanted
to experiment with Varad's code to continue that, but haven't been
able to find the time. I'm curious if you considered the stub approach
as well, but then opted for the app approach in the end. I was
leaning towards the stub approach to avoid the gnu-efi dependency.

Thanks,
drew

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
