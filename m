Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5A1ECAAD8
	for <virtualization@archiver.kernel.org>; Wed, 14 Sep 2022 09:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 537AA8145E;
	Wed, 14 Sep 2022 09:49:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 537AA8145E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ExcJVlbc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pAbANRhDdY_n; Wed, 14 Sep 2022 09:49:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 53DEB8142C;
	Wed, 14 Sep 2022 09:49:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 53DEB8142C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34B5DC0033;
	Wed, 14 Sep 2022 09:49:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F6DAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 09:49:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61627416E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 09:49:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61627416E9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ExcJVlbc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fduSphGdnEla
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 09:49:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A1CE416DD
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A1CE416DD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 09:49:49 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id t7so24753259wrm.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=bbq4/4T4JjPGUfth20drkaf18DSxlzxy1kFL2s5Skkk=;
 b=ExcJVlbc0ZagiH+Rt7hA0bIVbTU/NxhHDjFnmOG97vfk7AfET8oP8YY+6s84+Q+Kob
 AJ5rZVaCR4FSyyotJ+Um7fBWBWoMhnq6QmyyFF+rO62RqwDs2N4Cn46ksL+KGnpwh78j
 S9EN8XhjlqB4zz8tP/9vhz/LY6UjBPfju8CSPIQ4BAqdnZkjw88ejZd09ya3aFzcPlFx
 1+nPK7TEXW2EAEnjLYIuPT+P98eFpC+AhVnQvUCuPinG4F1UA1iUwSzMXBNZ6rOAIuA5
 rt96dfG3b4g5SHEDUERGZ840y1RY/kPx0dSau+lT3vebZafJpjfn+RBOIRHaCUGx6/1o
 JI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=bbq4/4T4JjPGUfth20drkaf18DSxlzxy1kFL2s5Skkk=;
 b=Nv7PVAeksqnq0uwmQwSYK4FlBkOjqMZiDZTY4QJwXhZOAiWuA8felNm5RMAuoR32wf
 kqwfpgRgau6BRZ9lCXB0A/IqVykCtWOXAD0jiFHin4zLLCWXyI0MNtqxG8csLqiBLMF8
 7VQOComflb+0ay7mEdSVrEVxJ0XBqTKnflV6mGPjay9smIX/nZkmcYOlfvEZntTeUuJL
 1Zr1qHx4XkUc33DVtE9sTYRuPdFbdAPNRvHlza9H9FuRCh1FYpA4k4GUp/UELIa9RP/0
 fhR3dDTrbln/yxVa66eUYywd13+t/H2g8M22uXQWot0ANcR3p37QYsjrVUWIkQ3Pucki
 mxcQ==
X-Gm-Message-State: ACgBeo2j/EjeOqfYgUJ+x+1iqwb3DofhbHi4tdTbTspAGw1kLi/mFzEu
 5jDRZQ4xs5K6Ly/6LkskAcjprg==
X-Google-Smtp-Source: AA6agR44NE7mkRWSZbkSxz7tUVdtOhV3Q3E9t0A41MbdOWdyWfvzOmpa8UdB3Zu6U/6tZw10e5zx/A==
X-Received: by 2002:adf:e199:0:b0:228:60f6:f775 with SMTP id
 az25-20020adfe199000000b0022860f6f775mr20581130wrb.478.1663148987482; 
 Wed, 14 Sep 2022 02:49:47 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 v12-20020adfe4cc000000b00228c8ed21c8sm13192128wrm.17.2022.09.14.02.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Sep 2022 02:49:47 -0700 (PDT)
Date: Wed, 14 Sep 2022 10:49:42 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 4/5] iommu: Regulate errno in ->attach_dev callback
 functions
Message-ID: <YyGjtsB2Yq4fQICS@myrica>
References: <20220913082448.31120-1-nicolinc@nvidia.com>
 <20220913082448.31120-5-nicolinc@nvidia.com>
 <YyB3F/o3RfymqiFW@myrica> <YyGaqsXSDMn8R12R@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyGaqsXSDMn8R12R@nvidia.com>
Cc: heiko@sntech.de, konrad.dybcio@somainline.org, bjorn.andersson@linaro.org,
 linux-tegra@vger.kernel.org, thierry.reding@gmail.com, will@kernel.org,
 zhang.lyra@gmail.com, joro@8bytes.org, jon@solid-run.com, jonathanh@nvidia.com,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev, agross@kernel.org,
 Nicolin Chen <nicolinc@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 yangyingliang@huawei.com, orsonzhai@gmail.com, dwmw2@infradead.org,
 linux-arm-msm@vger.kernel.org, vdumpa@nvidia.com,
 christophe.jaillet@wanadoo.fr, baolin.wang@linux.alibaba.com,
 thunder.leizhen@huawei.com, matthias.bgg@gmail.com, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, yong.wu@mediatek.com,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 shameerali.kolothum.thodi@huawei.com, robdclark@gmail.com,
 suravee.suthikulpanit@amd.com, linux-mediatek@lists.infradead.org,
 sricharan@codeaurora.org, baolu.lu@linux.intel.com
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

On Wed, Sep 14, 2022 at 06:11:06AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 13, 2022 at 01:27:03PM +0100, Jean-Philippe Brucker wrote:
> > I think in the future it will be too easy to forget about the constrained
> > return value of attach() while modifying some other part of the driver,
> > and let an external helper return EINVAL. So I'd rather not propagate ret
> > from outside of viommu_domain_attach() and finalise().
> 
> Fortunately, if -EINVAL is wrongly returned it only creates an
> inefficiency, not a functional problem. So we do not need to be
> precise here.

Ah fair. In that case the attach_dev() documentation should indicate that
EINVAL is a hint, so that callers don't rely on it (currently words "must"
and "exclusively" indicate that returning EINVAL for anything other than
device-domain incompatibility is unacceptable). The virtio-iommu
implementation may well return EINVAL from the virtio stack or from the
host response.

Thanks,
Jean

> 
> > Since we can't guarantee that APIs like virtio or ida won't ever return
> > EINVAL, we should set all return values:
> 
> I dislike this alot, it squashes all return codes to try to optimize
> an obscure failure path :(
> 
> Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
