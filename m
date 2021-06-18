Return-Path: <SRS0=81yh=LM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61867C49361
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 07:54:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186676109E
	for <virtualization@archiver.kernel.org>; Fri, 18 Jun 2021 07:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186676109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34EBC40563;
	Fri, 18 Jun 2021 07:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wQ0FSMzsV-lj; Fri, 18 Jun 2021 07:54:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 99D77403D7;
	Fri, 18 Jun 2021 07:54:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 096BAC000B;
	Fri, 18 Jun 2021 07:54:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95270C000D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:54:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 839894027C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:54:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AwIpkP9IHsFO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:54:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B935840221
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 07:54:49 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id w21so7382264edv.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=o2WQZjhwoaHMxBb+srOde8YwelPLzLRldEZbtvlgRGU=;
 b=k1T0ECGGh1W0dhEm5YpW3R4tr4w2ouXUmoAkc4fnu+nm3wfGl1D/XzfrjxPVvNpD9R
 GUN87sw+XheVvqk6OE0++OuYZdogI1z1/Z+Lp7EcaWueCIl0eiIDcgBLTpL+k3ODqRRi
 o1irouPqfd1Q1/YN2nVPDXvXxcg204pgHRGlmEY1D6DM1HPSCvgbILp/o8l/Wvkr0Iw3
 rGuOE9LxvMTkCXpX5w0+1LTUHt3sZIF4mC2s2Skw8CTsGlTa12/M8ao345z4GdUAlnPd
 JDFt5F5xmanD8rpTrdfn3E8eDxfl207dVuGecnb6ZmTyEXAW4IxIunr2hSUFxui1Sf+u
 +S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o2WQZjhwoaHMxBb+srOde8YwelPLzLRldEZbtvlgRGU=;
 b=qju85uhtZLhWonejvCWwBy5lS4CWQd5BBMCQoKZvAwzxQkGNpBbgvBuMBpnDeVUd8v
 ClRW0MPzzHLBIT7IV2oYz5G/ljata7kiIM6v/wpZCSzbwnNj89Hf1aMOAG8TddhhfbQi
 HsDkhfgaHrPTCnHkA3ZFpgg1ELacadQbzRE6RlgOjIRhUgQm6a8Lw+8AHaSUqyhy7ftW
 v7aMncsahtfhqXADFp8loSuNMoJ8HNPqo6/nRDRC7UgcEd999Tw1HSoXmgyXmjg/J7ij
 o0grrzqwEL1CQsc7dYr7p/0r2fZ/9bQZhRh/SoCXJmfrwIXvgOeFs5KNFfm1avW3jQQh
 FFdA==
X-Gm-Message-State: AOAM5335CniRNp3XIG8xs702QZjPaoIafga1fE+WIAdxakZE+5+Q9pmr
 8j58AbbgFoHzkcOf5IIp6SughA==
X-Google-Smtp-Source: ABdhPJw47GTVGsZ2XZZsLWgVTPMHWXGLZ9JfMKbH6mO4cozlyWGnWGY9YGBYGbYr6USC4QNEMkKYww==
X-Received: by 2002:a05:6402:4395:: with SMTP id
 o21mr3261040edc.163.1624002887797; 
 Fri, 18 Jun 2021 00:54:47 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id j22sm680988eje.123.2021.06.18.00.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jun 2021 00:54:47 -0700 (PDT)
Date: Fri, 18 Jun 2021 09:54:28 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 3/6] ACPI: Add driver for the VIOT table
Message-ID: <YMxRNHVjKk3H6r7t@myrica>
References: <20210610075130.67517-1-jean-philippe@linaro.org>
 <20210610075130.67517-4-jean-philippe@linaro.org>
 <CAJZ5v0gTZDyEC7MuBEv2gg6Usq+PD-WEQJbiAqKrFC3KV-M52g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gTZDyEC7MuBEv2gg6Usq+PD-WEQJbiAqKrFC3KV-M52g@mail.gmail.com>
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

On Thu, Jun 17, 2021 at 01:50:59PM +0200, Rafael J. Wysocki wrote:
> > diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> > index be7da23fad76..b835ca702ff0 100644
> > --- a/drivers/acpi/bus.c
> > +++ b/drivers/acpi/bus.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/dmi.h>
> >  #endif
> >  #include <linux/acpi_iort.h>
> > +#include <linux/acpi_viot.h>
> >  #include <linux/pci.h>
> >  #include <acpi/apei.h>
> >  #include <linux/suspend.h>
> > @@ -1339,6 +1340,7 @@ static int __init acpi_init(void)
> >         pci_mmcfg_late_init();
> >         acpi_iort_init();
> >         acpi_scan_init();
> > +       acpi_viot_init();
> 
> Is there a specific reason why to call it right here?
> 
> In particular, does it need to be called after acpi_scan_init()?  And
> does it need to be called before the subsequent functions?  If so,
> then why?

It does need to be called after acpi_scan_init(), because it relies on
struct device and their fwnode to be initialized. In particular to find a
PCI device we call pci_get_domain_bus_and_slot(), which needs the PCI
topology made available by acpi_scan_init().

It does not need to be before the subsequent functions however, I can move
it at the end.

> > +void __init acpi_viot_init(void)
> > +{
> > +       int i;
> > +       acpi_status status;
> > +       struct acpi_table_header *hdr;
> > +       struct acpi_viot_header *node;
> > +
> > +       status = acpi_get_table(ACPI_SIG_VIOT, 0, &hdr);
> > +       if (ACPI_FAILURE(status)) {
> > +               if (status != AE_NOT_FOUND) {
> > +                       const char *msg = acpi_format_exception(status);
> > +
> > +                       pr_err("Failed to get table, %s\n", msg);
> > +               }
> > +               return;
> > +       }
> > +
> > +       viot = (void *)hdr;
> > +
> > +       node = ACPI_ADD_PTR(struct acpi_viot_header, viot, viot->node_offset);
> > +       for (i = 0; i < viot->node_count; i++) {
> > +               if (viot_parse_node(node))
> > +                       return;
> > +
> > +               node = ACPI_ADD_PTR(struct acpi_viot_header, node,
> > +                                   node->length);
> > +       }
> 
> Do you still need the table after the above is complete?  If not,
> release the reference on it acquired above.

We don't need the table anymore, I'll drop the reference

Thanks,
Jean

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
