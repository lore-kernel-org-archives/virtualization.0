Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5565DC32771
	for <virtualization@archiver.kernel.org>; Mon, 26 Sep 2022 18:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8AB260F47;
	Mon, 26 Sep 2022 18:40:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D8AB260F47
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qely_u5kZAeg; Mon, 26 Sep 2022 18:40:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0CB2A606F5;
	Mon, 26 Sep 2022 18:40:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CB2A606F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB2C0C0032;
	Mon, 26 Sep 2022 18:40:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4562AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:40:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17E57417DE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:40:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17E57417DE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dcZYy2goZUKe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:39:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1718F40010
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1718F40010
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 18:39:59 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-13122bfaea6so5346951fac.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Sep 2022 11:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=jOftl44zGA/j7b6jC5BfWvHZRnHvotAovSxfOgGEkoo=;
 b=VaJVk1mm+kkgxHbsw0++Et5Xv4QZhPlq0W9swPknDViL/xJuiOJluwL54IznC9H18p
 5f+cwWA40NC7Gn+IOVvVW7rNY4/clDBqPvI22MP2aZpEDI5+AXU3P5JGPR45HUi6608b
 /beGr8jdBmMESfkpVL6T5iljRBujrItZlTECCE4xmwI9ovkKu7o2shrclGl3qar+vUG/
 dEedV9ocLrqSEaatiL54QBhzARLZgAu0G92eyJ+Hm1XWdcR2ohytT2DdKfecIMKvcaNc
 oED7LsgJsPPFa0fJ5SGlh0+Swy50vSm97Qjv0QSDCTPARePnRejmL1fVW3F5BEmOLqse
 63JA==
X-Gm-Message-State: ACrzQf1JXziOAF+s/5QiokbfEF7mj+xoL/B/L7jHdGf/zXXra5/PDHtK
 R6CzvXaQ6xlMzeL3LCPaFQ==
X-Google-Smtp-Source: AMsMyM6CJ/qhJwuMc45cCjEUUDZtxi2hbfOF0apEHjAHZOF15YxgXO5YHOoCtO/8OFgsZ1yuZ+HEBg==
X-Received: by 2002:a05:6870:c22a:b0:127:cba8:6b19 with SMTP id
 z42-20020a056870c22a00b00127cba86b19mr51044oae.151.1664217597994; 
 Mon, 26 Sep 2022 11:39:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 l19-20020a4ae2d3000000b0044884c40c8asm6934334oot.30.2022.09.26.11.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Sep 2022 11:39:57 -0700 (PDT)
Received: (nullmailer pid 2547832 invoked by uid 1000);
 Mon, 26 Sep 2022 18:39:57 -0000
Date: Mon, 26 Sep 2022 13:39:57 -0500
From: robh@kernel.org
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: virtio: Convert virtio,pci-iommu to DT
 schema
Message-ID: <20220926183957.GA2547766-robh@kernel.org>
References: <20220923074435.420531-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220923074435.420531-1-jean-philippe@linaro.org>
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
 virtualization@lists.linux-foundation.org
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

On Fri, 23 Sep 2022 08:44:38 +0100, Jean-Philippe Brucker wrote:
> Convert the binding that describes the virtio-pci based IOMMU to DT
> schema. Change the compatible string to "pci<vendor>,<device>", which is
> defined by the PCI Bus Binding, but keep "virtio,pci-iommu" as an option
> for backward compatibility.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v3: Renamed file and type to pci-iommu
> v2: https://lore.kernel.org/linux-devicetree/20220922161644.372181-1-jean-philippe@linaro.org/
> ---
>  .../devicetree/bindings/virtio/iommu.txt      |  66 ------------
>  .../devicetree/bindings/virtio/pci-iommu.yaml | 101 ++++++++++++++++++
>  2 files changed, 101 insertions(+), 66 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/virtio/pci-iommu.yaml
> 

Applied, thanks!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
