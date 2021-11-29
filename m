Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEE7C433FE
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 15:44:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFEFD4022B;
	Mon, 29 Nov 2021 15:44:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fzMYJrs3xY4E; Mon, 29 Nov 2021 15:44:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 682934057A;
	Mon, 29 Nov 2021 15:44:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04778C003E;
	Mon, 29 Nov 2021 15:44:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36457C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2412F4022B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:44:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L7391vMsAJbY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:44:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 575314010F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 15:44:46 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id a9so37783688wrr.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 07:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=B8da+siVIv0pzlfj4HfAjs2ohs1r6S5Zmuk5YtIiRz8=;
 b=nmya3fMcW0VihAIYAjVCrQXx8UpPMQn4Kb9Go+fXFBR0qqr1Bcwl4N7q/NZIkO2zhY
 xk6fk28xgZdlqlZLweQuB4p/OYHcNZA5vGFEkHaEJ2Fk1GIlVmiaQDDfbmfah8J1DnEg
 ZAXvgbAIAxH07TbRTGvxpv/q7DrNKyBbeidLHEJMrOcE0gEytoqo/NNZsHyci6BOrmme
 nv8Ln89giidrpQlp8JlEf07GF7cMHEOfs3LosXgmBbUZCUrqGVqKU2uHm5mAb6s6vkNl
 51NSs70jfYHEFnYHJ1qnBQraUEjL/zlkA38n0IsOnnFRQn6bjg2uBul2+g3ql9LPMtbE
 9U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B8da+siVIv0pzlfj4HfAjs2ohs1r6S5Zmuk5YtIiRz8=;
 b=myHGcvxWAR0K2htOgg0FcdgBcOcQGtbe5uz/Gf5xFs5eyGWZzsSjVZbcIqi2qoiXTt
 6EKukNHSDcf6IK2mO1IPg/Z9WZmwNN13UPfi5XybpleKRmRSobGtxwBWpxwRB1yzoRql
 1FKAOAPxRXuL4qdcptJxMRiG0SQ3DJ9HVfkVlPxXkCcDvvbXrNdZ+B5r9pe69yKoAICZ
 BNdjUrsZvlEy1YqT+hxcsrChtaArWLudgIrmU58BjDUdj7/KSHEboWfdpLUukjUdPqyE
 64Uh4p6TFLHW+r4PejKWzTuQlDa8HSTN7IR5Ypq3Ia79zA5Ij9+BSy1nwKoigQyjctG3
 mLuQ==
X-Gm-Message-State: AOAM5300yh59a6YWPBmsETFfNCJ5mADKIP72UUUsNGoKSFa7vjO9+Yyz
 o/PimQU+HtJ3+f4YjDD2lOwGMQ==
X-Google-Smtp-Source: ABdhPJxq8YFXCB4qPdgyGJwD4lEAwTbefpdPX7TGV8LA3IIHoS3SGTWHixAF0+UGrq5fViHR1f49Fg==
X-Received: by 2002:adf:e291:: with SMTP id v17mr34981632wri.479.1638200684688; 
 Mon, 29 Nov 2021 07:44:44 -0800 (PST)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id o9sm14148758wrs.4.2021.11.29.07.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Nov 2021 07:44:44 -0800 (PST)
Date: Mon, 29 Nov 2021 15:44:22 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2 5/5] iommu/virtio: Support identity-mapped domains
Message-ID: <YaT1VvUvpKZhTWvc@myrica>
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-6-jean-philippe@linaro.org>
 <58572359-8232-3204-f69a-7f50b887a122@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <58572359-8232-3204-f69a-7f50b887a122@redhat.com>
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

On Sat, Nov 27, 2021 at 06:09:56PM +0100, Eric Auger wrote:
> > -			vdomain->viommu = 0;
> > +			vdomain->viommu = NULL;
> nit: that change could have been done in patch 2

Ah yes, I changed that in v2 but fixed up the wrong patch

> >  			return -EOPNOTSUPP;
> >  		}
> > -
> > -		vdomain->bypass = true;
> >  	}
> >  
> >  	return 0;
> Besides
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks!
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
