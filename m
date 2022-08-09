Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2DFC19F2D
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 07:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4EB0409A6;
	Tue,  9 Aug 2022 07:20:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C4EB0409A6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xN4KUUb5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jcdTDjWpVQ-t; Tue,  9 Aug 2022 07:20:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D675D40055;
	Tue,  9 Aug 2022 07:20:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D675D40055
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AAE98C0033;
	Tue,  9 Aug 2022 07:20:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82A3AC0033
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 07:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5665C40144
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 07:20:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5665C40144
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=xN4KUUb5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aGyaeCiZPzau
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 07:20:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73A27400F8
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 73A27400F8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 07:20:52 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id v3so13384573wrp.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=nDZGjC3d6RgPiYxCgLnPjqhoXy38nST01tp2NFMdLgY=;
 b=xN4KUUb5LpDRsXDr3lg6VqfiiGJiAKnuy4OZkG8jx1/2Heekel3ys6nLkYYNoK6MiQ
 tEBcu5S5opzm2fPc+3FFmoClgEfRYpsvPM2BKrPp6quT426U1LXghDTLf2eSzG8FKRPU
 7jkicc6XssGkFQRU3KtP4P4Gju3ebDqXaqouM/CCZPp07GXJTXx9b+mC0puznB4+DTqN
 Ld8RB/cqU2XQ/R78lAQg/0oZRszHYNaJEEtWvc5nF35NISlUXUEmC51qfir5OeO2srFJ
 m5FXiL/1kSfn+poFKNQHXg1kTunibiDTeqMn9+YsCithA3QLL4lyGOtIs6HdZryQCWP7
 NccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nDZGjC3d6RgPiYxCgLnPjqhoXy38nST01tp2NFMdLgY=;
 b=WY6afw6rpT0R0P0WTAipzCo+4ry9VZB3XkcxH3BPfHrW7Q7CQ0V5dWFe9UZx3MWUF+
 Xvz5Y7PNYmSxlafjK4uLorNS2z3yjF9dAtQcIr9PqRgLtdJcmWzBKs9eDK7CdkdAXg49
 B5riCnP1kh2XUxUV4AN/F+GaM+YsVZdkNjEyctgQbpTKAikA11Zxw8DKHM5FkZj0jkkN
 OTHDahgbb2hT/01Z+Pgscq/KFDAO1IH87XcFFJyYzy/lTjB9fKiKTzE9lt8kD/2ZIE2f
 N86MqtnS+YWMLwyWnffN27IwmvtLHD1kJ+JSJuXFzihIhgva1bDTPptQxfbFOAMd7LG+
 lSRQ==
X-Gm-Message-State: ACgBeo0lyaC3XbF5PmeWwKI86a9KCOZlT1yITMb3xrkJnkeDRkf4okUH
 +dASwfXUT2DMuEkD13LLPpkHMw==
X-Google-Smtp-Source: AA6agR6QHnlDD3qjHO/gSC+OOdUtehf/UYh9OOQN8/22GLn0m55iV4WWOcGucEL0AAtwWiy4oMW0jw==
X-Received: by 2002:adf:d1c1:0:b0:220:5ec3:fb62 with SMTP id
 b1-20020adfd1c1000000b002205ec3fb62mr13237098wrd.69.1660029650688; 
 Tue, 09 Aug 2022 00:20:50 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c501200b003a2d47d3051sm17651203wmr.41.2022.08.09.00.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 00:20:50 -0700 (PDT)
Date: Tue, 9 Aug 2022 08:20:48 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] iommu/virtio: Do not dereference fwnode in struct
 device
Message-ID: <YvIK0KMi1yECL9vc@myrica>
References: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220801165142.20898-1-andriy.shevchenko@linux.intel.com>
Cc: Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>
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

On Mon, Aug 01, 2022 at 07:51:42PM +0300, Andy Shevchenko wrote:
> In order to make the underneath API easier to change in the future,
> prevent users from dereferencing fwnode from struct device.
> Instead, use the specific device_match_fwnode() API for that.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 08eeafc9529f..9fe723f55213 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -925,7 +925,7 @@ static struct virtio_driver virtio_iommu_drv;
>  
>  static int viommu_match_node(struct device *dev, const void *data)
>  {
> -	return dev->parent->fwnode == data;
> +	return device_match_fwnode(dev->parent, data);
>  }
>  
>  static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
> -- 
> 2.35.1
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
