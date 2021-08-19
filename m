Return-Path: <SRS0=U4FE=NK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB47C4338F
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 01:42:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C61C610A1
	for <virtualization@archiver.kernel.org>; Thu, 19 Aug 2021 01:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7C61C610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3638F607EC;
	Thu, 19 Aug 2021 01:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5lJGE8mgG9Ii; Thu, 19 Aug 2021 01:42:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7E5CA60BB9;
	Thu, 19 Aug 2021 01:42:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B291C001A;
	Thu, 19 Aug 2021 01:42:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE5E9C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 01:42:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6FEF40275
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 01:42:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5FV20uE_rpBy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 01:42:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BFAA402D9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 01:42:15 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id y23so4313141pgi.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Aug 2021 18:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=vE2NquF8aYczXeoe6PGRGJC5TmHhDUeKxtlQ0G2jkj0=;
 b=TzkGaYSavbzKcla9b22EsIZ0UYcGwBCBQIe7qkkxrWrB9VDShq4qDo/WgRh2Ompz2v
 V1wAoaQfblkOpY5Tw0JpwU4pcsI9xRF8BvwvDxeEjv8WmlHw8IiYhCaCURe6N/IZVhsY
 Ad7YMItNSYzdTQwTXOIeo8ZOpP4MY0RDR1YQRUVIubHozViqgo8PifeL4s2Dmh42dwN4
 Y1REyb8/lkPkdqPUSo2o9YrtXfhGI4pM9rfANGyFthSOEC8GgJwwj4u6vEKSWNL8PPqV
 E0Bg7NHdpxsxFaxEjUPfmaposl06OVyYGBHh8PBmm9+TFXmyqlLBYVvAXJn5LbTcbTGy
 qv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=vE2NquF8aYczXeoe6PGRGJC5TmHhDUeKxtlQ0G2jkj0=;
 b=F954HPEt2A/Oo+vTqdE1I9IR9zRlmkUIkXdv6xjjnTUyupVEaBMEeI19sLaryAi85g
 l9JP9iYNzR16vNO2Cb4r3vhkKI6VPFJ3BRJgVYFKnxbB2mcth88btNaS5DSCuy3W9cqW
 D8EBLPugzw3834b4E811n1ca3dDII8Xd/77Dgp38kDvjWzFQFh4Hz29YseHLYxBy4ge1
 OTEfMIwgoitHZMzuj0RTq6O9GbO7NdVInvvOFtFsdm01Wxi4ru3MIK8f9k4/MKe4Nzhb
 nSk+GP8+U6qmz+3HwRnrzeBtQsGA9JEkO02gfaYRchgu7rg3T2fIChoxp6GRnTtsChWO
 YUpg==
X-Gm-Message-State: AOAM533NpoCF5Ai1wrDxlE/RwEEwHJDDlvpRWthC1dxoCgR4mqUWGqac
 gWanPEty6kWiHVLLEtO77AU=
X-Google-Smtp-Source: ABdhPJwc/9Y6Qg1flKQWhWZ4XJflaQczD3jDWqCEJHeKG8vExwOCWSrEETTQioJ+3wL3HUrYCxLX0A==
X-Received: by 2002:a63:1155:: with SMTP id 21mr11652333pgr.346.1629337334181; 
 Wed, 18 Aug 2021 18:42:14 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183])
 by smtp.gmail.com with ESMTPSA id t18sm1046591pfg.111.2021.08.18.18.42.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Aug 2021 18:42:13 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [kvm-unit-tests PATCH 0/6] Initial x86_64 UEFI support
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAA03e5H6mM0z5r4knbjHDLS4svLP6WQuhC_5BnSgCyXpRZgqAQ@mail.gmail.com>
Date: Wed, 18 Aug 2021 18:42:11 -0700
Message-Id: <0250F07B-AC9A-4110-B2F4-8537A40D8848@gmail.com>
References: <20210702114820.16712-1-varad.gautam@suse.com>
 <CAA03e5HCdx2sLRqs2jkLDz3z8SB9JhCdxGv7Y6_ER-kMaqHXUg@mail.gmail.com>
 <YRuURERGp8CQ1jAX@suse.de>
 <CAA03e5FTrkLpZ3yr3nBphOW3D+8HF-Wmo4um4MTXum3BR6BMQw@mail.gmail.com>
 <71db10eb-997f-aac1-5d41-3bcbc34c114d@suse.com>
 <CAA03e5H6mM0z5r4knbjHDLS4svLP6WQuhC_5BnSgCyXpRZgqAQ@mail.gmail.com>
To: Marc Orr <marcorr@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Cc: "Lendacky, Thomas" <thomas.lendacky@amd.com>,
 Andrew Jones <drjones@redhat.com>, Joerg Roedel <jroedel@suse.de>, "Singh,
 Brijesh" <brijesh.singh@amd.com>, kvm list <kvm@vger.kernel.org>,
 Tom Roeder <tmroeder@google.com>,
 "Hyunwook \(Wooky\) Baek" <baekhw@google.com>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 Zixuan Wang <zixuanwang@google.com>, Erdem Aktas <erdemaktas@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, bp@suse.de
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


> On Aug 18, 2021, at 6:32 PM, Marc Orr <marcorr@google.com> wrote:
> 
> This sounds great to us. We will also experiment with combining the
> two patchsets and report back when we have some experience with this.
> Though, please do also report back if you have an update on this
> before we do.

Just wondering (aka, my standard question): does it work on
bare-metal (putting aside tests that rely on test-devices)?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
