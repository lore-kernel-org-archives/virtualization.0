Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75339C6FA82
	for <virtualization@archiver.kernel.org>; Thu, 22 Sep 2022 15:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0545861145;
	Thu, 22 Sep 2022 15:54:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0545861145
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=U7d/4vDI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OT1wLTwscRbM; Thu, 22 Sep 2022 15:54:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 141FA61131;
	Thu, 22 Sep 2022 15:54:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 141FA61131
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D57AFC0033;
	Thu, 22 Sep 2022 15:54:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F1B5C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 15:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 56AB383E5D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 15:54:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56AB383E5D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=U7d/4vDI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aYxR6SZBOBS9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 15:54:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D5B983DF3
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D5B983DF3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 15:54:15 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 n40-20020a05600c3ba800b003b49aefc35fso1626532wms.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Sep 2022 08:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=iYg1FzmqdVObBIGDrpXK8/12CqSCWXQixjeTyrRH2G0=;
 b=U7d/4vDIwSQRsJWGFVcpBJeAOdN+sAQbKSb2o3nU1ltmtMKJJVczpUw7YYI8Rp74sL
 JQcG/1ES6hfniQSgvRaC72caMaBHZL38ZnNycbQzppt7QHkRPD8wgJoQsxAdPpDlo+3T
 zUwdSISD/mv3037nwO3v+J98i5U7ZLMI2lD3PgRYiZrYcLHaV9pj2NTnkMUHO5r0LSv+
 2rjoEs1vnqJzFjONPC18v2wuGjyGYDAd2G1QCgmgKFMKhCiIkVS9BXiYvky8OSOVqGgf
 rlyIMYqPpaKgrPtzTRMOFX4ZaRhOU/sKH3nQrbmM/H/CfaA1iTI2Ob6iy9qn8VXs0DSS
 /16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=iYg1FzmqdVObBIGDrpXK8/12CqSCWXQixjeTyrRH2G0=;
 b=1jzBtlKYABJ3Y2N00dK+BLK429hj7cNX/4ySu9lQ/hZhaylDgvEoEI/dj4peAsDI4A
 HTleI/u6QlJcYbyQVYe9t9dBF2G4zFpTq5mAQOZR6B20li4Diml8tAg0q75Rj9h/4oBz
 pYc3DKYNhjqoVB7vdwOuFqema8+7jJOcvz3X0YS4nrCWlSUpjoe9XV0RhGIlwwI0B5B7
 xSSQfcuazMVTsEpeVJAgXATBoknBicm1vntkhQy/qV3ZUn0rTvmA0jyboIZIvHcAMZFH
 FLhJBnJbV/oF+vmxQnFYLMTBJQejsNh6aCbQr4QOESzVx6TaBJxIIymMuiNLDsQnTlYa
 yJJA==
X-Gm-Message-State: ACrzQf3RfQP5YWEmSR1fxETkxDDZ5ymPhcTk6jCQpQz5E6AaO/YZ+NE9
 Yb20f1LUfAvZ1lM1Rzkcu4VZ1A==
X-Google-Smtp-Source: AMsMyM5Mx5ZdCtIHnwDfOXcEuZUtP46bEwkTkCYte68YDHl4EU5xMMSzyd1IY3MjD8FrepyHgbOsow==
X-Received: by 2002:a05:600c:1da8:b0:3b4:8fd6:5132 with SMTP id
 p40-20020a05600c1da800b003b48fd65132mr2877306wms.99.1663862053559; 
 Thu, 22 Sep 2022 08:54:13 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 o2-20020a05600c510200b003a540fef440sm6961727wms.1.2022.09.22.08.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Sep 2022 08:54:13 -0700 (PDT)
Date: Thu, 22 Sep 2022 16:54:09 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: virtio: Convert virtio,pci-iommu to DT schema
Message-ID: <YyyFISBBUgeAOocY@myrica>
References: <20220916132229.1908841-1-jean-philippe@linaro.org>
 <6f692ece-b3ac-4115-370a-3c5e255dd0f8@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6f692ece-b3ac-4115-370a-3c5e255dd0f8@linaro.org>
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

On Sun, Sep 18, 2022 at 10:23:06AM +0100, Krzysztof Kozlowski wrote:
> > +required:
> 
> Also: compatible
> 
> > +  - reg
> > +  - '#iommu-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pcie0 {
> 
> Node name: pcie
> 
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +
> 
> device_type and then you will see a bunch of warnings.

Right, I think I wanted to avoid pulling the whole PCIe baggage because it
requires a lot of properties that aren't relevant to the example. But
having tried it it's not too bad, and it ensures we validate the child
node.

Thanks,
Jean

> 
> > +        /*
> > +         * The IOMMU manages all functions in this PCI domain except
> > +         * itself. Omit BDF 00:01.0.
> > +         */
> > +        iommu-map = <0x0 &iommu0 0x0 0x8
> > +                     0x9 &iommu0 0x9 0xfff7>;
> > +
> > +        /* The IOMMU programming interface uses slot 00:01.0 */
> > +        iommu0: iommu@1,0 {
> > +            compatible = "pci1af4,1057";
> > +            reg = <0x800 0 0 0 0>;
> > +            #iommu-cells = <1>;
> > +        };
> > +    };
> > +
> > +    pcie1 {
> 
> Node name: pcie (so probably you will need unit address and reg)
> 
> > +        /*
> > +         * The IOMMU also manages all functions from this domain,
> > +         * with endpoint IDs 0x10000 - 0x1ffff
> > +         */
> > +        iommu-map = <0x0 &iommu0 0x10000 0x10000>;
> > +    };
> > +
> > +    ethernet {
> > +        /* The IOMMU manages this platform device with endpoint ID 0x20000 */
> > +        iommus = <&iommu0 0x20000>;
> > +    };
> > +
> > +...
> 
> 
> Best regards,
> Krzysztof
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
