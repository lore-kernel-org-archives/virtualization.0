Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F957C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 03:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 068A982605;
	Thu, 25 Nov 2021 03:21:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6eF3J9zfI7J8; Thu, 25 Nov 2021 03:21:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 980D381D73;
	Thu, 25 Nov 2021 03:21:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5754FC002F;
	Thu, 25 Nov 2021 03:21:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1908C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 03:21:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CC86405E8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 03:21:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A-y9Av-lPVjg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 03:21:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AE3540526
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 03:21:23 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 cq22-20020a17090af99600b001a9550a17a5so6653680pjb.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 19:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kl9QFdxeQT+ZdNe5xXwILBYCvxJMvl+e0+hxIPhlJP4=;
 b=pY9LGPHk4GsETow/BIfhAVy1fXTYs03/BfFNQaCwQ1SISuth9VjsALMfDtZq9D9j9S
 57q+uDA5rg1jEJjrkHxKmjQNYOMln5BNr7w3l7J7ZALuGNHEOPgK2YpIFE2/DWh7ZS7I
 RXy+NTExlJBl8cwxLmBLHwH422jONNq4CUGBQm/TaQbto5AIH8l0a6kOrB6oE4ldrFFB
 c+UcJtGRmAhOmJJ+UYvchNkXNSgsazkwJFMZN9WTdQrJQSAlELG6x240gIc7Oz17nn6X
 S4PjitXePvbskGDuaqeTzEtXK3djDgrM9IND2Rc+E5/kGEjuEK/4WRISisYpuOyAmBin
 cEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kl9QFdxeQT+ZdNe5xXwILBYCvxJMvl+e0+hxIPhlJP4=;
 b=MEdXcfQyBEJhedXUDRAAr6D7TX7IjRKH3hDXoPKeI5rnZy9ve1OMXZA+UMqAC1HKEx
 mI2GE3akr47L5V0JbfNttVSzZjNcJeOcAXceqRyME4+7YHPprvSVSFk026CR04+OdZVV
 b6GEZ2bSQD2MpAsJ3LObNwJXYom12TK+sT27ix+PMm93sydLd08Tmk4oFM06rmXJJ3JG
 Y0JdvKPqPsU3XbRCYIb2zgdZOoO3tHuiSufsouELonvGD8EilwUtPrWiv7hethwUjCOS
 0dSzzMUhQxsuzZOi6ngnWRPu0vcbxOsT6FFZ/OgYy72lH6QNp+/qKs3pcQfmyo6fiwdF
 gz3w==
X-Gm-Message-State: AOAM531qtv2ule/nQy2YA/cw0ChZLj8/nmX6ieb8eJ+gNsLs3CdhWOD4
 B4Crz7oK31iS4d4R9eDKnaqQQg==
X-Google-Smtp-Source: ABdhPJxO6BHDZemocrThhO4FCIcZqEhKUZzepBue7p+e37VnZ16tNLPHS1GtahtspFNrmOnik+J2xA==
X-Received: by 2002:a17:90a:df88:: with SMTP id
 p8mr3090793pjv.32.1637810482599; 
 Wed, 24 Nov 2021 19:21:22 -0800 (PST)
Received: from localhost ([122.181.57.99])
 by smtp.gmail.com with ESMTPSA id h13sm824811pgg.16.2021.11.24.19.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 19:21:21 -0800 (PST)
Date: Thu, 25 Nov 2021 08:51:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-i2c: Fix buffer handling
Message-ID: <20211125032119.vklsh4yymwnalh5b@vireshk-i7>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
 <20211124185546-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211124185546-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, kernel@axis.com, linux-i2c@vger.kernel.org,
 conghui.chen@intel.com
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

On 24-11-21, 18:55, Michael S. Tsirkin wrote:
> On Thu, Nov 11, 2021 at 05:04:10PM +0100, Vincent Whitchurch wrote:
> > This fixes a couple of bugs in the buffer handling in virtio-i2c which can
> > result in incorrect data on the I2C bus or memory corruption in the guest.
> > 
> > I tested this on UML (virtio-uml needs a bug fix too, I will sent that out
> > later) with the device implementation in rust-vmm/vhost-device.
> > 
> > Changes in v2:
> > - Added Acked-by and Fixes tags
> 
> 
> What are the plans for this patchset?

Wolfram applied the first patch, but not the second.

Wolfram, you can apply that one as well, it looks okay.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
