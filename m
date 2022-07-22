Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0230C433EF
	for <virtualization@archiver.kernel.org>; Fri, 22 Jul 2022 12:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D096410E7;
	Fri, 22 Jul 2022 12:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D096410E7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=do/8TnvK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OCXDNfCzWiFv; Fri, 22 Jul 2022 12:15:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0715F41503;
	Fri, 22 Jul 2022 12:15:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0715F41503
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABB96C0033;
	Fri, 22 Jul 2022 12:15:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05315C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 12:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D027B60FEF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 12:15:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D027B60FEF
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=do/8TnvK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A_Q1wd6ieG3s
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 12:15:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68B0E6118F
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 68B0E6118F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 12:15:32 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id h9so6289401wrm.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Jul 2022 05:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=noJ5YRyhe+RjqdboryTi5z6xf7o4LJrrgEFCF/xsMl0=;
 b=do/8TnvKDPqiq04oB6iblm4eoL9maOANwJ66zyXGc+87ZpdEjDVD1hO1h7Oc/SHU83
 CTSSnJwv1G6+Euk9Rx3nUKho6jakd3T5+9JVPEZm3n7ERgzv0NhJ55vayMuOfXJA6F42
 Dhq5G+jWWtYJqYKIU9V5Rq1nmQKaSVMdZZxCItOLKMoLXMUsO9xfDFik1q+Fmvk++QW/
 Ubz89W9i/I7UgT05r9I2ehwvYi+M2ghRTM1RX1E0A8vzQ3lPxUBtBMo8QrqIHalCMP6D
 w2aQvibWCfuiiLj30//Qt6jFXh3ErHnRbvRYu7fqsYIsIy062ZgtphhVKapDFjlTJZBm
 cqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=noJ5YRyhe+RjqdboryTi5z6xf7o4LJrrgEFCF/xsMl0=;
 b=GU1KNU+FVPuDuG6kRy15zuDRiJiQeoHMkJ0LSpH9FYNlRvTamdabITLnT/tCMrX7kR
 6wsIaFPzN+IqzzMpR13ymLLjJ2fVt1t2sUCi6OXJ1VBtrvLmQOt6ts24D1/R/UofsFQd
 FExtGS24Rx6K8jGAdWX/RBNdDkxX5iFyO5d8qmY5FxPonKVMYw/O2pvyuo9h/Dc67f70
 NMMSlxx32xSHfPS4CJD/U+Nbb9Nd+Zq7/dQkNm226NifwnhFYI2++6CZN8lCTfB8+ufx
 t3rUfvC2cZvy5pGFW8Zwkq4rvPbJif/XBQkHTiaX2uHw02+ONAlfh9OIJgCuFhp2FafZ
 8JmQ==
X-Gm-Message-State: AJIora+VM8aBsNqxO6TkgDSmzToq4pEuGoRMk3g6Geb9R2iDYOiOXtaf
 wgbt0RwI/suEY1aLjfcT/0frHg==
X-Google-Smtp-Source: AGRyM1snKI1UDafrg4F/h41sKrFNtM3uw2vkeW9rDiQABcbivnISX8K/tLEz9yxrAS+ZuXhL0SpZ0g==
X-Received: by 2002:a05:6000:184c:b0:21d:beaf:c2d2 with SMTP id
 c12-20020a056000184c00b0021dbeafc2d2mr160812wri.562.1658492130476; 
 Fri, 22 Jul 2022 05:15:30 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 c185-20020a1c35c2000000b0039c5642e430sm4937033wma.20.2022.07.22.05.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Jul 2022 05:15:29 -0700 (PDT)
Date: Fri, 22 Jul 2022 13:15:05 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/virtio: Advertise IOMMU_CAP_CACHE_COHERENCY
Message-ID: <YtqUyXUlNc3YdxG0@myrica>
References: <20220714111059.708735-1-jean-philippe@linaro.org>
 <f701a947-3b93-d47e-f806-fd47d281d371@arm.com>
 <YtATYaBOz5UnTNC6@myrica>
 <ddd64256-7553-a1aa-ed63-2138d77ae6af@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ddd64256-7553-a1aa-ed63-2138d77ae6af@arm.com>
Cc: joro@8bytes.org, virtualization@lists.linux-foundation.org,
 eric.auger@redhat.com, iommu@lists.linux.dev, will@kernel.org
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

On Thu, Jul 14, 2022 at 02:39:32PM +0100, Robin Murphy wrote:
> > In the meantime we do need to restore VFIO support under virtio-iommu,
> > since userspace still expects that to work, and the existing use-cases are
> > coherent devices.
> 
> Yeah, I'm not necessarily against adding this as a horrible bodge for now -
> the reality is that people using VFIO must be doing it on coherent systems
> or it wouldn't be working properly anyway - as long as we all agree that
> that's what it is.
> 
> Next cycle I'll be sending the follow-up patches to bring
> device_iommu_capable() to its final form (hoping the outstanding VDPA patch
> lands in the meantime), at which point we get to sort-of-fix the SMMU
> drivers[1], and can do something similar here too. I guess the main question
> for virtio-iommu is whether it needs to be described/negotiated in the
> protocol itself, or can be reliably described by other standard firmware
> properties (with maybe just a spec not to clarify that coherency must be
> consistent).


What consumers of IOMMU_CAP_CACHE_COHERENCY now want to know, is whether
coherency is managed in HW for one particular endpoint, or if they need to
issue cache maintenance. The latter cannot be handled by VFIO since cache
maintenance is generally privileged.

So I had to list several possibilities regarding non-coherent accesses.
I don't think we need a spec change.

A. Accesses through physical IOMMU are never coherent
-----------------------------------------------------

In this case, translated accesses from the physical device can't access
memory coherently. The host would describe it using existing FW methods
(dma-coherent in DT, _CCA in ACPI) since it's also needed without a
vIOMMU.

No change needed for virtio-iommu, I think, it can support non-coherent
devices. It can also support mixing coherent and non-coherent devices in
the same domain, because domains just allow to multiplex map requests at
the moment. Since we allow sending the same map request onto two different
domains, one with coherent devices and one with non-coherent ones, then we
can also allow using a single domain for that. If the host cannot handle
this, it is allowed to reject attach requests for incompatible devices.

In Linux I think compatible() should include dev->dma_coherent after your
change, or the callers should check dev->dma_coherent themselves
(vfio-platform in particular)


B. Non-cacheable mappings
-------------------------

Here, accesses are normally coherent but the pIOMMU mappings may be
configured to be non-coherent (non-cacheable access type on Arm). If there
is an actual need for this, we could add a feature bit, a probe request
property and a map flag.

In Linux we may want to disallow !IOMMU_CACHE if the device is coherent,
since we don't support this case.


C. PCIe devices performing no-snoop accesses
--------------------------------------------

Accesses are normally coherent but the device may set a transaction bit
requesting the transaction to be non-coherent.

A guest can't enable and use no-snoop in a PCIe device without knowing
whether the system supports it. It's not discoverable on Arm, so a guest
can't use it. On x86 I think it's always supported but the pIOMMU may
enforce snoop (and the guest may be unable to perform cache maintenance?
I didn't follow the whole wbinvd discussions for lack of time).

The problem is the same without a vIOMMU, so I'd defer that to some
firmware method describing no-snoop.


D. Non-coherent virtio-iommu
----------------------------

Non-coherent virtqueues. It's not forbidden by the spec, and a transport
driver could support it, but it's a transport problem and virtio-iommu
doesn't need to know about it.


Did I forget anything?  Otherwise I don't think we need any spec change at
the moment. But when adding support for page tables, we'll have to
consider each of these cases since the guest will be able to set memory
attributes and will care about page walks coherency. That will be bundled
in a probe request along with the other page table information.

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
