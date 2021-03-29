Return-Path: <SRS0=wWNv=I3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BA2C433C1
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 16:23:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3BDB61581
	for <virtualization@archiver.kernel.org>; Mon, 29 Mar 2021 16:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BDB61581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C11240330;
	Mon, 29 Mar 2021 16:23:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AEKiheCAd8ld; Mon, 29 Mar 2021 16:23:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAEC840321;
	Mon, 29 Mar 2021 16:23:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACC94C000C;
	Mon, 29 Mar 2021 16:23:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09835C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA0D740321
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:23:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OPWEN6pnlcLe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:23:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD6F7402DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 16:23:22 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id g20so6910189wmk.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Mar 2021 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KPclp6vfsh1l0llxq/9bcQXpgR0clJ6jmS6dVL/hig8=;
 b=bj77tl0OjsgCgZLbOb3u3k145orUo71nkMcisB/6plOzX/M2mg3Z4Yb5uDisu9c4pB
 Y53SOJe4s4v6Mhp+CFbq6aMAtV0YnUliuYDu7EDJkfI1uYn+lEi44BJeUdxqKS/tx3ru
 OfU2m9joLw9o3CyDSRJhRXWyX6CADErtPac4qLPNqMsBYAMl4Ls7CdOHxBs62aYJ4XaJ
 yUgTz5aupJxIno4XKcDiaBivqeoEJ6rRqOkSeKzkD+lCKQV3ESKONlrbQU0ZLjQ3/915
 /Mff3SI799c/P5lsfxlGS62u7OScJZG9l13uwvkzhwn9CM6+aup1yF/Jf4SM0qj4lLMj
 WW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KPclp6vfsh1l0llxq/9bcQXpgR0clJ6jmS6dVL/hig8=;
 b=SAXkaEj4/zxyOqfelZwlI4HWEnhmBMywU/O2c84w53qRp1ESJ92uPH7bq66QYPaVxW
 PboV9yKI581IC9/JRPlEcq1O5yrpDr0IfLg1+hmdrzetP7mjgB7BxMzE7ee98gqakPLW
 WVcE87/RLseEMAwqju3wfWFPaWsIRRG7bXIkqEYTyCbKtsM9qml1YzAmFoqTR51kSvLI
 O4DDT9wIlih1YzDOGrEkWsFDZ5iVYSwiQk2m7LfAtDM+Pp0aTsRNTDlCrbHXL95L2qW0
 L144Gt1s0ADrwLzJpnsuVxR2k3F1C1RDdqEExDIrfhs2DeqMvGScKUt7f88Y8td9NsTL
 48lg==
X-Gm-Message-State: AOAM530pXXRcx7dM5tygvQQybVaSEjBVvOJzTU+du+skl6wpMVUDqME5
 jPT/uyn39bTL3Kf0AkLK1ddQnQ==
X-Google-Smtp-Source: ABdhPJwFilW/ot1hZMhT/JWnG2uNUr6y5QBKqC9sEGMBX6tvcW+gfCS/ourdvz2bsJ56tuVkYTAQEw==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr26138332wmk.30.1617035001094; 
 Mon, 29 Mar 2021 09:23:21 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id i8sm29594538wrx.43.2021.03.29.09.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Mar 2021 09:23:20 -0700 (PDT)
Date: Mon, 29 Mar 2021 18:23:02 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Kumar Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 15/15] iommu/virtio: Update fault type and reason
 info for viommu fault
Message-ID: <YGH+5pHtR6gWnimB@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-16-vivek.gautam@arm.com>
 <YD/GjQIKkaJ5+UJM@myrica>
 <d8a81406-12c6-a5e1-7297-49c1a0a800ab@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d8a81406-12c6-a5e1-7297-49c1a0a800ab@arm.com>
X-TUID: vOigyBwZv6w+
Cc: jacob.jun.pan@linux.intel.com, mst@redhat.com, joro@8bytes.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, yi.l.liu@intel.com,
 lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Mar 12, 2021 at 06:39:05PM +0530, Vivek Kumar Gautam wrote:
> To complete the page request we would also need to send the response back to
> the host from virtio backend when handling page request. So the virtio
> command should also be accompanied with a vfio api to send the page request
> response back to the host. Isn't it?
> This is where the host smmuv3 can send PRI_RESP command to the device to
> complete the page fault.

It looks like Eric already has this in the VFIO series:
https://lore.kernel.org/linux-iommu/20210223210625.604517-14-eric.auger@redhat.com/

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
