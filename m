Return-Path: <SRS0=nfYb=OU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1689BC433F5
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 08:49:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8E7619A6
	for <virtualization@archiver.kernel.org>; Thu, 30 Sep 2021 08:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF8E7619A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 800CA42531;
	Thu, 30 Sep 2021 08:49:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dLZae4RtYlqD; Thu, 30 Sep 2021 08:49:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 28251415C4;
	Thu, 30 Sep 2021 08:49:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00643C0011;
	Thu, 30 Sep 2021 08:49:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39DAFC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 08:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2904583FB1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 08:49:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d8GLzrDYaz7W
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 08:49:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E66F83FA9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 08:49:38 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 i6-20020a1c3b06000000b0030d05169e9bso5529777wma.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Sep 2021 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=W9cgTk6h0wqbwfayatXQtxHz8mob4jZCCoq7sCyhp1s=;
 b=eDUuL0ja//PuyQ4fz3l1hxyHwsDpNJ5f3l6+0Y2z6OfrW7O1uddJSWX4e7FGcFAMa1
 9LYUj8wO2yxSk/JUNdXvJq7aO5QrczADrIhrCk9uRBbQ4qb4YCaYdI/OVVhhAhSc5G8s
 f38pfWZD4da7JbtDolq6vbv3GKZ8vfXXVer4xPD4lYLWQ17RIz8v2SSckshCMfFywrWM
 UiwZcc3qwiw681dRJuv/gMZBn7y8RLyJtR85zXh0uCuxlNfSC+P54nKcc5Y5Owgqqw+o
 iI8GiFwU1oejKRoluZVITVWv/sZQoKnvBqERIZpoi/u+vWuFOaaQQIMW5dUWY+SfYO6U
 lExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W9cgTk6h0wqbwfayatXQtxHz8mob4jZCCoq7sCyhp1s=;
 b=vvhvncZJuFvgMlGUQuyxq7q69NRI9amkQXx7rEiyIBGd3Zw08psHfcueApbv7kvRsp
 oCq6z+hU4ouuX/vpjROhCgY6/iETSxd45q4OfyAdbZJNgAXUgo7aheQlo294E7IPrWlR
 n2/rkBX9gpogUsBqW36VtCmmoyUgX1fz3Dq4e7vW4x1f4Asn+apjM4M4rESQs39h3D3l
 YlZSLLT2Qd4w8USx/luD+NzCQQ8qkPnJSzWES5V4VwjgmNk79j70fg2fmVP+smZdYcaa
 po8nHiDR1OZ905apBIoyvEqlWRDEffBtqU99NrZwCdYbPjEkDIxoD/9vD1xwZ7iGrltF
 rstw==
X-Gm-Message-State: AOAM532Tgrs86Rhx5T2n0GDmjeaewMZheIAn6NobWzSFI+UMDP7Prrr4
 xe9ozxBAwsBUPmP2cRa1env02g==
X-Google-Smtp-Source: ABdhPJx7UmI5t0e1WRrw+EyEdQREOHgR4PKY+8e7EznFDej38q+RoHIFqgsrXw9rDiLo5EFXAV7sIg==
X-Received: by 2002:a7b:c948:: with SMTP id i8mr14365780wml.193.1632991777323; 
 Thu, 30 Sep 2021 01:49:37 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id n66sm2295448wmn.2.2021.09.30.01.49.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Sep 2021 01:49:36 -0700 (PDT)
Date: Thu, 30 Sep 2021 09:49:16 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Kumar Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 01/11] uapi/virtio-iommu: Add page request grp-id
 and flags information
Message-ID: <YVV6DD7zmy1MKva0@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-2-vivek.gautam@arm.com>
 <YUoBHA6NZaz8wlkA@myrica>
 <3b490967-58b5-7c4a-2275-250e26d24aeb@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3b490967-58b5-7c4a-2275-250e26d24aeb@arm.com>
Cc: jacob.jun.pan@linux.intel.com, mst@redhat.com, joro@8bytes.org,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux-foundation.org, yi.l.liu@intel.com,
 Lorenzo.Pieralisi@arm.com, robin.murphy@arm.com,
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

On Thu, Sep 30, 2021 at 10:26:35AM +0530, Vivek Kumar Gautam wrote:
> > I'm not sure why we made it 32-bit in Linux UAPI, it's a little wasteful.
> > PCIe PRGI is 9-bits and SMMU STAG is 16-bits. Since the scope of the grpid
> > is the endpoint, 16-bit means 64k in-flight faults per endpoint, which
> > seems more than enough.
> 
> Right, I will update this to 16-bits field. It won't be okay to update the
> iommu uAPI now, right?

Since there is no UAPI transport for the fault request/response at the
moment, it should be possible to update it.

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
