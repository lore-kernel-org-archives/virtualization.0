Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2689AC56202
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 10:25:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CDA20857
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 10:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpGjTGcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CDA20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D570B86D53;
	Wed, 25 Nov 2020 10:25:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9tG6hO726cyb; Wed, 25 Nov 2020 10:25:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 917F486D18;
	Wed, 25 Nov 2020 10:25:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CAA9C0891;
	Wed, 25 Nov 2020 10:25:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC831C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 10:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 92A772750D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 10:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uPwCHJItxr9Q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 10:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id CAE85274E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 10:25:23 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id j19so2066746pgg.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l8KWwZXjo+ebfysMFihw4Nq0NqQCdpcD4ow0OUA1KW4=;
 b=DpGjTGcbKs/0CQJBWrroVcD6FjXCf2LxZJTLiE/33p3a1xJtylQsUi/ijQKyYoSMyR
 CX48GAFaeIUTvp+IJUMMCyiryasym19bIX8w4Q2pkkTLCAA3ej2YLz/PVdHZ4t8TSLSL
 fXTxX4V0rnqDe0fqEDn9+2oCcCIkk0ZlhGSgxLgCO+vVWAVke8yRmsLAWgY1ZqYaTTGL
 jV9lOIoj7DBROZZU2My468qUuPfJkCmtHS9yAv+CzuWVtlV66JLUDEnBwclu+63sRldb
 7k7yvllj1Ie7NAtGZScSoP3eomQOAOj6h9y9LRrLe3d2BU9l5UQAxLyTHjO72m2UFE+H
 YYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l8KWwZXjo+ebfysMFihw4Nq0NqQCdpcD4ow0OUA1KW4=;
 b=QTu02TOXccSaNapeWwfqgIxs/YvVrsyTovcrO0eJO6aDu1m1vijrrS7lB22o3C0Qun
 FMFt4bZcK6l5FuHF4qpai8ufTQ67/zlvdho8WSVKe+yYu7GDA6T+HMzYP/AURHRs7m/z
 xgq58fZDgADUBQ8ckNNAGOeOVkaaVb+gGwVp6IoWR/WRce5sppjz8fzz+Y0LhUiZbMPO
 NGpcalXKDonIl2YB2UxjBhpMK72pAiAJ+MNXNIfvDyFsfii6TS1ro4z7KgI7n1r2ashh
 eND3IoO7oU19f/aU2XrXmDF6iewWgQshUSUj+gyvQX5IvuRMPF9bqDGrc5PX542he7Kl
 UBow==
X-Gm-Message-State: AOAM530g83Hcz89Girwaz5b+7GqUtu5ssKAnVFrOxCi5u3mvllNW/Iaf
 /dADbTzITXAw8YD+sxsZ/aA1iQvFlGcvM+14rWo=
X-Google-Smtp-Source: ABdhPJztDYKFeiNJoCZRoJswecvAifKS4CNRAYgSUYCvFDnZC10zVxlGuKWwFPpkps/QTlATHUXrZ2BwVgZlAtQ9LZI=
X-Received: by 2002:a17:90a:d90a:: with SMTP id
 c10mr3350899pjv.129.1606299923331; 
 Wed, 25 Nov 2020 02:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20201124170744.112180-1-wei.liu@kernel.org>
 <20201124170744.112180-17-wei.liu@kernel.org>
In-Reply-To: <20201124170744.112180-17-wei.liu@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 25 Nov 2020 12:26:12 +0200
Message-ID: <CAHp75Vew+yjUkcfSx33KjhPLriH6wrYWixAtn9mASRFqe4+c+Q@mail.gmail.com>
Subject: Re: [PATCH v3 16/17] x86/ioapic: export a few functions and data
 structures via io_apic.h
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Joerg Roedel <jroedel@suse.de>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 YueHaibing <yuehaibing@huawei.com>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jon Derrick <jonathan.derrick@intel.com>
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

On Wed, Nov 25, 2020 at 1:46 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> We are about to implement an irqchip for IO-APIC when Linux runs as root
> on Microsoft Hypervisor. At the same time we would like to reuse
> existing code as much as possible.
>
> Move mp_chip_data to io_apic.h and make a few helper functions
> non-static.

> +struct mp_chip_data {
> +       struct list_head irq_2_pin;
> +       struct IO_APIC_route_entry entry;
> +       int trigger;
> +       int polarity;
> +       u32 count;
> +       bool isa_irq;
> +};

Since I see only this patch I am puzzled why you need to have this in
the header?
Maybe a couple of words in the commit message to elaborate?

-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
