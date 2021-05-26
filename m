Return-Path: <SRS0=MQJa=KV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2950C47082
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 10:05:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F4261440
	for <virtualization@archiver.kernel.org>; Wed, 26 May 2021 10:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F4261440
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 550A8404B2;
	Wed, 26 May 2021 10:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WvrUvczLelbK; Wed, 26 May 2021 10:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 143324041C;
	Wed, 26 May 2021 10:05:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF5A6C0022;
	Wed, 26 May 2021 10:05:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B5FBC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 10:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5017C60009
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 10:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C7LCA41v-Kij
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 10:05:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7709A605B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 10:05:26 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id i13so643571edb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=wN1QhgZSLh/Q1cWPqcMwfOkLFO+D9Okqk24H5LLAjws=;
 b=nPXeq6WiNxgg6lSxeUnm2xUIASnDhmktguH8A6hssAjEktOyNSvFrXb7nk9Jwtb+NO
 yFRlCwYbpgu1I3XfvONpplYhusGl1LZzYH8skxO3FMlur4Ub99+Y+fFTNkOsTrN5w38z
 OVf9eYTP/FPPU3gd8SPWnmbwhEmLy2lOF0pC3GW4VrVUrahiv7yYM6zET6w7Z3my6L0S
 cHNhcGsinerK+PASVPV7OHMOudUBIlgvybDpP7ziWJzNizZCFYD1ZSZ3if2EX1bSR+BK
 ZxzluxhQR+3Vc6n46FiKg0ibO/Yga0tgQunYLwLIIwStAZJn5nD7INiwGK+RxyPP0Qb4
 pUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wN1QhgZSLh/Q1cWPqcMwfOkLFO+D9Okqk24H5LLAjws=;
 b=ZnWVcDmVVj81lPue3mbgIFhyZM046A4FapQmF5h6s498hptHEYJoD0Wa6wDv9kGW0N
 K0i0LC4BnVtlsCKsgzSikKY7E8ltzEwTNxW7rhufEgny/RV1qtpianSivS1o3LqnvZyA
 FKwzOYv2y6T4NeY2PsR12PG5XZ3Tnz28+ZpCVrINRw7XgSwjPvFINJ3HyXNjFqpoBA0c
 XjetLjIgUej/YlZFqrTOrZyloqKDQc2LfBttyCGQZDPmZXm1W8LJVXb76j5l4QamB9eL
 kFhKoWPY1On/UZriyxr+IUh/R5gGSEAL8shdhPRxeS6WPNrrq8dyfS9MG8NLX9YbAvBA
 njTw==
X-Gm-Message-State: AOAM533FR6dXIIWU+5ACng7h/8114yN/BxExIGHfXSzDpCD3CDcFfrAM
 UIoDanPJEVGVSv/wNFzU9qosDA==
X-Google-Smtp-Source: ABdhPJwLqgT0dI13/qQ6yT3UWt2a30pzQv780qX8pFwjZ6m2oIQpbMs47aFTz509ycnSHGVFoSWOMw==
X-Received: by 2002:a50:bf0f:: with SMTP id f15mr34885274edk.205.1622023525169; 
 Wed, 26 May 2021 03:05:25 -0700 (PDT)
Received: from myrica (adsl-84-226-106-126.adslplus.ch. [84.226.106.126])
 by smtp.gmail.com with ESMTPSA id k22sm10054730ejz.108.2021.05.26.03.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 03:05:24 -0700 (PDT)
Date: Wed, 26 May 2021 12:05:06 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/6] ACPI: Move IOMMU setup code out of IORT
Message-ID: <YK4dUpIS5LJmAU2s@myrica>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
 <20210423113836.3974972-3-jean-philippe@linaro.org>
 <CAJZ5v0j=vqv3aJb_eitOVtpxgU3j5_j5hKPzyTEeHxfo_5MXdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j=vqv3aJb_eitOVtpxgU3j5_j5hKPzyTEeHxfo_5MXdQ@mail.gmail.com>
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

On Fri, May 21, 2021 at 06:42:09PM +0200, Rafael J. Wysocki wrote:
> On Fri, Apr 23, 2021 at 1:57 PM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Some of the IOMMU setup code in IORT is fairly generic and can be reused
> > by VIOT. Extract it from IORT.
> 
> Except that iort_iommu_configure_id() is not really generic AFAICS.

I'll clarify the commit message: the parts of iort_iommu_configure_id()
that set up the IOMMU infrastructure can be extracted and reused by VIOT.
The rest of the function, that iterates over the IORT subtables, is
specific to the driver.

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
