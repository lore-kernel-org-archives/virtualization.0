Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3B5C433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 14:47:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73466137D
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 14:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73466137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E813607F2;
	Thu, 15 Apr 2021 14:47:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1EXqjxmvhw_v; Thu, 15 Apr 2021 14:47:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D331607AD;
	Thu, 15 Apr 2021 14:47:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ADB8C0014;
	Thu, 15 Apr 2021 14:47:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47100C000C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 289FB84655
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:47:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N-Kmu0Np8uvR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:47:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 22417844D4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 14:47:20 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id s15so28418174edd.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=n4QXf+cOw2jRuJk6NYVPzxIPebbr2HANj3LDOYShp5I=;
 b=Jd109QuvoPbeOBhKixUtBt5/Xnwa4xQuAOpVjrA87QwRWKtQDFDLIibyYB0+5GQIEJ
 aHUKSd66q6DYdd5JpKX4S150mKovE2TxkNTVe3vl2MLvTAzMdKOrCTHKx25rOnCWhR/F
 OO4Cr2eqsGRjUtNMQeJd1kDyoNYi5qwmQzWyAgVUOQnLYaqJf3mXGFsDGn57h5DDvtGD
 KhoiVuXcprEmmgcifdilXVTen5ekgIhIs4/XfFslUGr+rZWJmekmcoEtSDRWtOdWei9G
 1YVduS3e4+0pra7kKAPLQTYuiyZs1aOvYfMfhDDV7Bo6XiJq/rMj/UIUDB3UkQewSxvl
 gPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=n4QXf+cOw2jRuJk6NYVPzxIPebbr2HANj3LDOYShp5I=;
 b=IX+JfrmaXJT3k6r2ZdOTbqd1oVnVNxbkcGJ2eDbjgPld56w8jlKXMBjhNFeaQ7H5mY
 IBzKaGjBAwvN9h1qWsypEtZmjZmQLMlsRZtA6lalyR8zLGE2HcHXcHC/Du/iozEwqtzE
 gwZmOzI5U329zuhvfHhCkkL+njIUYUfFy54KBM8IqhvdzsewxQoToYovXf8UEAx7iuyo
 LcuOcdxEnPOGybB8KPhjMoliUv3erv56a0ujCDDiK7U5DotBj2xYt8C/lRR9snlai7gD
 aUqHLppkaLUYHE4r3qabIT1EJZ+mC22hrPSlngdSgXiluq4RI/WJiEffsun0Z0MA7YDX
 ndew==
X-Gm-Message-State: AOAM530YUXSrHa++X6ZdY3tPVRejjsjNsCaPs3MiZmmhSvmkuuygXQR+
 W5UTIOxpC9XZtVonA1b44RSBrw==
X-Google-Smtp-Source: ABdhPJz2+0NTKepbuICEjxCSs4LahmAuUZrrzKCZRlpZy/ROS/vkdkyyfjikrFbRCEfvo5bTe/kvaA==
X-Received: by 2002:a05:6402:614:: with SMTP id
 n20mr4606117edv.58.1618498038320; 
 Thu, 15 Apr 2021 07:47:18 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id f10sm2627950edd.29.2021.04.15.07.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 07:47:17 -0700 (PDT)
Date: Thu, 15 Apr 2021 16:46:58 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH 2/3] ACPI: Add driver for the VIOT table
Message-ID: <YHhR4nSKYogouGMJ@myrica>
References: <20210316191652.3401335-1-jean-philippe@linaro.org>
 <20210316191652.3401335-3-jean-philippe@linaro.org>
 <cea43eef-35d2-b6c5-2bf0-ab7ba8473fb6@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cea43eef-35d2-b6c5-2bf0-ab7ba8473fb6@redhat.com>
Cc: lorenzo.pieralisi@arm.com, mst@redhat.com, robin.murphy@arm.com,
 joro@8bytes.org, rjw@rjwysocki.net, virtualization@lists.linux-foundation.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com, will@kernel.org, lenb@kernel.org
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

On Fri, Mar 19, 2021 at 11:44:26AM +0100, Auger Eric wrote:
> add some kernel-doc comments matching the explanation in the commit message?

Yes, I'll add some comments. I got rid of the other issues you pointed out
while reworking the driver, should be more straightforward now

Thanks,
Jean

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
