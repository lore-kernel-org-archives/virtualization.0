Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1928EC77B7A
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 16:49:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90AC461441;
	Thu, 18 May 2023 16:49:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 90AC461441
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jkffKmiv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FmIFD123V9ey; Thu, 18 May 2023 16:49:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F242161416;
	Thu, 18 May 2023 16:49:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F242161416
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CEF9DC0036;
	Thu, 18 May 2023 16:49:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91EC7C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 16:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6019D81E7B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 16:49:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6019D81E7B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=jkffKmiv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MzY5ovoQVcmQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 16:49:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB4FA81E60
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AB4FA81E60
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 16:49:36 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3093d10442aso1518305f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 09:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684428574; x=1687020574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AM8DwTmosLNfh4+dWykqnnp3+AvL+dO94NEcMeQYDFQ=;
 b=jkffKmivCJNFzoQ6z0jsuQ5OnNUV5s7hDGPvgf502x3D56V4OZ9auOZcWvEUFF+cu5
 8Bqzvq5wySx+SiLdeLdGNJYKOBq6L0BhG3Vb3hSZFZP79+k9eN4YkE5U92VREm7o8lWw
 yWmJrf52yWPr5YCVg18BLi0hjqS/8Im/oTiO5W7fBVOEvoYqljLM76wz9skAAJIwBM9V
 /2W2q/uS8iNZ+qjIDhvjh9AhHmm9zozY4c5x3z7RX0p4vZahyMTXon2PTgKkZQG7lGW1
 LQpd7pxqDlGbUgLIviL4Z+/DvvS2tburMNKQ/CYy70SEk8A9NdQWEZYhujMuahMAQiyz
 9StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684428574; x=1687020574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AM8DwTmosLNfh4+dWykqnnp3+AvL+dO94NEcMeQYDFQ=;
 b=cND9dCVLLMgS0U+Z8Qwabh/hCsmng0Q7b0ReRp9IWGbanmvT27tPnWchOnplHm0wxL
 073lPVwdbRSg6vy2bVFhd3o1vAWiNjVtMyoV+LRpm8L1+O1D9IVVQyGTd+VcLz+6qZ74
 PgEnN/5kdeg9tLQ8pd9XiNySZWW0k4dbzoOPL2Bmvve4OtrQKgeoCxichHAZGkec2jld
 2g/aSi7M5kuvsRlbjzVNBcu8aO+aUoO9kiu74OhvIp4TDJjTn6GHKYXM416aKl2C8TPf
 k+zOnBjcP/KX3hRYRlblcnpS/4y2Wq8PQIES2F57QBzQ3+9+qFOljNw7bzaMTpb8JLLG
 gKmQ==
X-Gm-Message-State: AC+VfDzKnMh8ZaFy1Q7meq3D3R4RmQo5k3reevB9L6HUh/XpsLseLL0x
 El6HaDurAiQmSNr/dhEr2lRIig==
X-Google-Smtp-Source: ACHHUZ7/wGIKmYno/qEiN1QV7YGyBQN5K4Nr3OQzJ53R0OvyhypPiOw2/5mRgNMSCEwVBuOW1B6WKA==
X-Received: by 2002:a5d:4041:0:b0:309:732:86df with SMTP id
 w1-20020a5d4041000000b00309073286dfmr1915516wrp.58.1684428574676; 
 Thu, 18 May 2023 09:49:34 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
 by smtp.gmail.com with ESMTPSA id
 e2-20020adfe382000000b00304832cd960sm2726216wrm.10.2023.05.18.09.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:49:34 -0700 (PDT)
Date: Thu, 18 May 2023 17:49:37 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] iommu/virtio: Detach domain on endpoint release
Message-ID: <20230518164937.GA2934820@myrica>
References: <20230414150744.562456-1-jean-philippe@linaro.org>
 <20230510081157.GA3326511@myrica> <ZGT+44a6RYZ999kz@nvidia.com>
 <20230518135638.GB2587493@myrica> <ZGYvMDbkBN+2UgzG@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZGYvMDbkBN+2UgzG@nvidia.com>
Cc: akihiko.odaki@daynix.com, will@kernel.org, joro@8bytes.org,
 virtualization@lists.linux-foundation.org, eric.auger@redhat.com,
 iommu@lists.linux.dev, robin.murphy@arm.com
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

On Thu, May 18, 2023 at 10:59:12AM -0300, Jason Gunthorpe wrote:
> On Thu, May 18, 2023 at 02:56:38PM +0100, Jean-Philippe Brucker wrote:
> > > Can you wrapper this into a BLOCKED domain like we are moving drivers
> > > toward, and then attach the blocked domain instead of introducing this
> > > special case?
> > 
> > Yes, I think the way the virtio-iommu driver should implement BLOCKED
> > domains is initially clearing the global-bypass bit, and then issuing
> > DETACH requests when the core asks to attach a BLOCKED domain. This has
> > the same effect as issuing an ATTACH request with an empty domain, but
> > requires fewer resources in the VMM.
> 
> Does that exclude identity though?

No, identity attaches a domain with the ATTACH_F_BYPASS flag (or an
identity-mapped domain if the feature is missing), it doesn't rely on
global-bypass.

> 
> It seems like the protocol should not have an implicit operation like
> this, the desired translation mode should always be made
> explicit.

I probably misunderstood your plan for BLOCKED. This particular patch is
about removing devices from the machine, for example PCIe hot-unplug. So I
thought you were suggesting the core will at some point attach a BLOCKED
domain to a device being removed, in order to block translation while the
device is being removed and while a new one is being plugged in with the
same RID. For that case I think DETACH, rather than ATTACH an empty
domain, makes more sense. Otherwise with the same reasoning we'd need to
attach all 4 billion endpoint IDs to an empty domain at boot which isn't
feasible. In addition I don't think we'll want to force the VMMs to keep
endpoint ID state internally after destroying devices, though that does
need to be specified one way or another.

If BLOCKED is only for transient states, for example while a struct device
is not bound to a driver, then attaching an empty domain works and is
simpler to implement. Probably the best is to implement BLOCKED this way
and still call DETACH in the release_device() op.

In any case, it shouldn't make a difference to the core. I'll see which
one is better for the VMMs.

Thanks,
Jean

> Having a boot time default makes sense, but there is little
> reason for an OS to go back to the boot time default...
> 
> Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
