Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF4C433FE
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 09:21:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9204C61175
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 09:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9204C61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4405180E10;
	Tue,  9 Nov 2021 09:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id urWo3fd3UBtS; Tue,  9 Nov 2021 09:21:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F254E80E24;
	Tue,  9 Nov 2021 09:21:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C9862C0019;
	Tue,  9 Nov 2021 09:21:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45BF6C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 09:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A9D980E10
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 09:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MH_lGCicwv75
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 09:21:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C80E80E03
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 09:21:25 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id q17so7739383plr.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Nov 2021 01:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VlGCNRAbCJyOrMfe7yxeDHsKpbkWTi/DwMsr2rG9iqc=;
 b=B95rJf9LytoLokK4d2RM8YJBBo4V8DR5ompwAnjsPSqwzZVa115Ghf4W56fi0ft+E0
 35y1LF46wO/OwVi06+GEPUZZsIibfDLlJfdUDMq0CDM+dB7FgFxOvHBowuLvTco/+j2U
 ou8+FMi/9w/x2GNWN/gSnCAQ8rhCd4/Ki9xFSQwf03YHH4wxDxwRlAUHMoXjINAd6r1w
 nxUdC0r/hSmvRcvkLwWhpp4536sybMkBSbPflcKFVQcTbxjPG92tTuMbJrO0T5nwhvBc
 8mVNlhVuSx4WFG/OE39swxHOS+yB8PXsS8lO2w6X/JryM/hEFUpGOXU9ZjfZbe0cuIst
 Nn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VlGCNRAbCJyOrMfe7yxeDHsKpbkWTi/DwMsr2rG9iqc=;
 b=y8knqjJPDz29GyM533V/jKNR4+uHYLJtsQA6ar984kmxIsZlRMwEQ/nVvOmf1lQb16
 F2GZBVQztpy96pYvjelKVSKJQkSp4adW0TuE38VGOAIpCb1F+L5VHyPscVWBjiNo/tqr
 Ko28gkt9kLHmHkzNDXdxp/aByDsub+HRi2yZFeCNqD7TQMLGbvcC0vVeZdhFenoL1TJl
 VhdUU8gLR8z/UMWRHwK7lhzOAJnRAlW/wGHHp4emiKTTPeN9xRiMs2OpKrrRXaY7ao/T
 d41trE3OcxxSb+vstkHL7fupzK2+YUu2AlVE9InMa6CX13G+w7nDt91tA2IeiM24xITM
 xGIA==
X-Gm-Message-State: AOAM531aLwwSYZD1njA8z2bomW7QR5owEVNJJGZHjqT5siVwEYn9FSTJ
 D/UPv1ehCYxNEdBlaDGTtuH/HQ==
X-Google-Smtp-Source: ABdhPJw4O+6Tc+jEcuEXkZG0VHy4lKkRci/QQtKyux1NreMeQ+csadk5zJ+tJlCUoZid6Vr7YVigBw==
X-Received: by 2002:a17:90b:38cd:: with SMTP id
 nn13mr5320131pjb.175.1636449685513; 
 Tue, 09 Nov 2021 01:21:25 -0800 (PST)
Received: from localhost ([223.226.77.81])
 by smtp.gmail.com with ESMTPSA id y28sm7457013pfa.208.2021.11.09.01.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Nov 2021 01:21:25 -0800 (PST)
Date: Tue, 9 Nov 2021 14:51:23 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: cgel.zte@gmail.com
Subject: Re: [PATCH] drivers:gpio: Remove unneeded semicolon
Message-ID: <20211109092123.ao6x4imbx5zg4pl2@vireshk-i7>
References: <20211109082357.131251-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211109082357.131251-1-chi.minghao@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Cc: vireshk@kernel.org, linus.walleij@linaro.org,
 Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
 chiminghao <chi.minghao@zte.com.cn>, virtualization@lists.linux-foundation.org,
 linux-gpio@vger.kernel.org, info@metux.net, brgl@bgdev.pl
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

On 09-11-21, 08:23, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>
> 
> Fix the following coccicheck REVIEW:
> ./drivers/gpio/gpio-virtio.c:437:2-3 REVIEW Unneeded semicolon
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
> ---
>  drivers/gpio/gpio-virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index aeec4bf0b625..84f96b78f32a 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -434,7 +434,7 @@ static void virtio_gpio_event_vq(struct virtqueue *vq)
>  		ret = generic_handle_domain_irq(vgpio->gc.irq.domain, gpio);
>  		if (ret)
>  			dev_err(dev, "failed to handle interrupt: %d\n", ret);
> -	};
> +	}
>  }
>  
>  static void virtio_gpio_request_vq(struct virtqueue *vq)

A similar patch was already reviewed earlier:

https://lore.kernel.org/all/1636344232-56537-1-git-send-email-yang.lee@linux.alibaba.com/

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
