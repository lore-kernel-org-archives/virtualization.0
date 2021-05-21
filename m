Return-Path: <SRS0=ctfp=KQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51B4C4707A
	for <virtualization@archiver.kernel.org>; Fri, 21 May 2021 16:42:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682A9613C8
	for <virtualization@archiver.kernel.org>; Fri, 21 May 2021 16:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682A9613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B3DEE4059F;
	Fri, 21 May 2021 16:42:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YUexyoEO2d_J; Fri, 21 May 2021 16:42:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3812E405D5;
	Fri, 21 May 2021 16:42:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D126BC0022;
	Fri, 21 May 2021 16:42:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B0BAC0001;
 Fri, 21 May 2021 16:42:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E517A40232;
 Fri, 21 May 2021 16:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y5vLYWkD6zpr; Fri, 21 May 2021 16:42:21 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6D494022E;
 Fri, 21 May 2021 16:42:21 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so18547504otc.12; 
 Fri, 21 May 2021 09:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3uXCrfwflbJMKyoizw7GA0q9AX1L5xvF35SZVzuv9E4=;
 b=hDfKBs6PdJnwxXxhcWQiNty81ojHQPFICmsufJR4r+23GIBhgV2Lbwf2j1MubO4UYf
 xh1RHXv3nAP8tRlprurgiDMSic0gAqPlikKGSaMaYWFEXTHqhC5+uwU4B5ChEMdBxBne
 omTHhjV6Rx0FvBBliR1WCJgrjyG5kviPyGeWfAbOqeu3OVradCxKZ4RAv1mVTvje/ZIm
 LxdC/uBk1Q6omgvUJdoJHyf/vmB05I9/MbC0TMk9VrI/6Ikn3Jla6cakLwlnHcm23LmY
 ux4QPqWPcA8T6llIODJWdKCN/zdjtFYzp3IPxyQmQU0KV+QoC9ho6GfJLYmbZlFVTd9L
 YFnA==
X-Gm-Message-State: AOAM531m9ftLNfCQBkfo1hiuKuW9y6oSXjUP4pVsLmOmI9xwOAyBGE3L
 EqINLVGTB819qb9b7jIDTKNTqzY2wNK25nLqQ1w=
X-Google-Smtp-Source: ABdhPJxMRGdanl17OARb7DCS+ZzT5O3FDRmB93dTJ9tk7kP4k3enbgZYDKI5OAoTefUFUucCuw/QaF5cCRW+/jQ33L4=
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr8963159otq.260.1621615340788; 
 Fri, 21 May 2021 09:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
 <20210423113836.3974972-3-jean-philippe@linaro.org>
In-Reply-To: <20210423113836.3974972-3-jean-philippe@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 May 2021 18:42:09 +0200
Message-ID: <CAJZ5v0j=vqv3aJb_eitOVtpxgU3j5_j5hKPzyTEeHxfo_5MXdQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ACPI: Move IOMMU setup code out of IORT
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux-foundation.org,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 sebastien.boeuf@intel.com, Eric Auger <eric.auger@redhat.com>,
 Hanjun Guo <guohanjun@huawei.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
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

On Fri, Apr 23, 2021 at 1:57 PM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Some of the IOMMU setup code in IORT is fairly generic and can be reused
> by VIOT. Extract it from IORT.

Except that iort_iommu_configure_id() is not really generic AFAICS.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
