Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25CBBC433F5
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 15:33:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BAB0640439;
	Mon, 29 Nov 2021 15:33:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bsFyBHqsiq_F; Mon, 29 Nov 2021 15:33:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 73C8F4043F;
	Mon, 29 Nov 2021 15:33:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7062C003E;
	Mon, 29 Nov 2021 15:33:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2B59C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ADADF6058D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NiBMvnuPH33f
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:33:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 82035600B5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:33:33 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id d24so37766193wra.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 07:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NTUQ6aLhKD5jn8vygozqrLUU4s5A3V1kXbkGA/ru7lM=;
 b=HVzF6BkeS36kyfG+xhXLEfxtbXCiiG/rILiuPP4Fm4PsRykXWuBQOq1ebLsVW5XbVC
 95EXaGYX2KadOC3OLsUpmCr+PV24wovvVOQp3WiFEj0qISMCqG/eEEArA3971cRC80/G
 dwZnChO8PzFenjS6ReFCoerZwcjT+q0Iaem5AslenQ04adryZLoV+Bk24/XbqGe6rApq
 a7ax2GcUHB2LobsfqLVVZaPPYpxF+dLCLAwVo1yGdD5SPA2++n6xpC6em3KJlK1p5+tl
 hN6nBA1G1gTQ7+yGf6VxKTly7FI28S4I9xeo+2RtIubH2IBmQ2RSq3IetRJ4Iv+X12F5
 OdAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NTUQ6aLhKD5jn8vygozqrLUU4s5A3V1kXbkGA/ru7lM=;
 b=3H3T2eIzOFAjJNNIU2MBBEolFTbrhjLKWwtaBgQupiY1g3c6iF7K/mn/vc8jqEgHR9
 KIdhkcRNHMrwgKa/CiKl0e1Fzu4jMyuytiVYLPhpJyR+Fx9u9+k5SU3DUgkVQ/fZjr0n
 Xp8ERM44cAeL3wDc+LZSHwOsgfc8Cwc6GSRNB9p6ZOa5/u+BCv22V0eJeYXMTi1knz3d
 /eyYvWL48JxWRx2KWEeot3zdmx/ge/Uxyf54JDWvjr647LRsW/oUDzZnxgKwWTfRlMKl
 AwJeQkIc9CtoOMiBKY1CBuCaGiEFcnj8MsgoWMzIxyaRlyOEboXYVSSXDYXK2V6x0r+h
 Yb3g==
X-Gm-Message-State: AOAM531lOR1EqsZb4Qb1DHyiOKAqLDT7pW4G6eY9B6zGRQE49B5Pgj2k
 xwzn+RkJPAwVzT7GUC4tm/Tm2A==
X-Google-Smtp-Source: ABdhPJyuq3ERsFsDH/xpS1bayhStVieKQtcrUQihIbVIry9BiRsUSwe1lWVq20WEpHG3+o4ITfyuAw==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr35021998wrt.419.1638200011561; 
 Mon, 29 Nov 2021 07:33:31 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id r8sm17738405wrz.43.2021.11.29.07.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Nov 2021 07:33:31 -0800 (PST)
Date: Mon, 29 Nov 2021 15:33:08 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 1/5] iommu/virtio: Add definitions for
 VIRTIO_IOMMU_F_BYPASS_CONFIG
Message-ID: <YaTytI6P3/HEwVrQ@myrica>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-2-jean-philippe@linaro.org>
 <b9068111-bc1e-cc0a-155d-04585d6f4138@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9068111-bc1e-cc0a-155d-04585d6f4138@redhat.com>
Cc: mst@redhat.com, joro@8bytes.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, will@kernel.org
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

Hi Eric,

On Sat, Nov 27, 2021 at 08:59:25AM +0100, Eric Auger wrote:
> > @@ -36,6 +37,8 @@ struct virtio_iommu_config {
> >  	struct virtio_iommu_range_32		domain_range;
> >  	/* Probe buffer size */
> >  	__le32					probe_size;
> > +	__u8					bypass;
> > +	__u8					reserved[7];
> in [PATCH v3] virtio-iommu: Rework the bypass feature I see
> 
> +  u8 bypass;
> +  u8 reserved[3];
> 
> What was exactly voted?

Good catch, this should be 3. It brings the config struct to 40 bytes,
which is the size compilers generate when there is no reserved field.

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
