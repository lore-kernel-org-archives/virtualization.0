Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C625C11F66
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 11:16:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD27B61D03
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 11:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD27B61D03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76F40607C8;
	Tue, 29 Jun 2021 11:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ahSH2Cv8smqO; Tue, 29 Jun 2021 11:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 13B886065F;
	Tue, 29 Jun 2021 11:16:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9FB1C001A;
	Tue, 29 Jun 2021 11:16:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6F94C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 11:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1B6F402C2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 11:16:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uXIgDMcP8D9y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 11:16:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48B8D4011B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 11:16:33 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 cs1-20020a17090af501b0290170856e1a8aso1660645pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 04:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xjV/iKi34jYFMReQkJHVyPn/3R5zf+ElzbUkU1MRvAQ=;
 b=dKJFli8NYw/mQKH3Kw4Xh/mZ1c75VxNBWzg2+Q31Y4qkdcoAI/y405XkWNU8+TlS4f
 zX3H5e5QzRv47ovxV/fZR0a2D8g1VDKvN37yUK9i7Lk3xCny/f5logx3MyHjdJO00P8e
 u3Js/sBNx6gl08KPRHp6lzQsxUCb60h+4Ep1hlpzJTACykLZhadUKt+onNeH3ossfpx7
 INL/XMqjN/KfiLrBaVcUGAIokQh9Bxz4z2/9ESGXFmx7KQFDFzuT64+WsCU/yR+1eyVR
 RQ8nO2Gz2D4W46BWxZDzoNW6tUm6i4eTxkp4IyfBwzJ6ZvZlzrNZUifZ/BmrVwPdXlq/
 gAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xjV/iKi34jYFMReQkJHVyPn/3R5zf+ElzbUkU1MRvAQ=;
 b=l9DPa583M68ppOPSToxXnAs+MbZCRGZCFkbOTwCNeUKB+QdZigJjaDxr1cx6vRII6H
 bC07iPlHXRiU4fFKDJNFjR++S+aaPuZEOhqCBx2n+5zMT8LszKu4nSV+C+4J8dDQvWzJ
 BsiwC+zARbMZbnUXf/2eV6htmDDvs9SvnzS38VpzSLxRf5qMSorMd6kQ8INUHvC/9QNU
 bxBSf19CaY+fSDsyL2yAS4WuFuiCBZSZDPDu395wxHErbiBbVyIDTsrrikPM21hWTPuu
 A9igYtlCgP7ejVV3syjwXUz7Nka+G6JD519u6ubBQdgAT9haY6EU6VAPqOaqUSbf4/GM
 O6vA==
X-Gm-Message-State: AOAM533zF4Uet1d/DBMYDg/xpYgE0FM0S61XAOqieB0DAad2pf3hmibX
 wXiOORrocKEvQkAzAJuTLvBsXg==
X-Google-Smtp-Source: ABdhPJy+UGCUCuflwbi6dPqqusA18cX4k4AwlBxGfReRGnObOnWyb1uOJgfgGDyhAKi/3y/XEkRRMw==
X-Received: by 2002:a17:903:18e:b029:127:a5ba:7243 with SMTP id
 z14-20020a170903018eb0290127a5ba7243mr22916869plg.4.1624965392695; 
 Tue, 29 Jun 2021 04:16:32 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id u11sm17854532pjf.46.2021.06.29.04.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jun 2021 04:16:32 -0700 (PDT)
Date: Tue, 29 Jun 2021 16:46:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com,
 arnd@arndb.de, kblaiech@mellanox.com, jarkko.nikula@linux.intel.com,
 Sergey.Semin@baikalelectronics.ru, rppt@kernel.org,
 loic.poulain@linaro.org, tali.perry1@gmail.com,
 u.kleine-koenig@pengutronix.de, bjorn.andersson@linaro.org,
 yu1.wang@intel.com, shuo.a.liu@intel.com, stefanha@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210629111630.badum3mtumcujbyk@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato>
 <20210629101627.kwc2rszborc3kvjs@vireshk-i7>
 <YNr0uDx1fv+Gjd7m@ninjato>
 <20210629103014.nlk3mpetydc4mi6l@vireshk-i7>
 <YNr5Jf3WDTH7U5b7@ninjato> <YNr5ZRhT3qn+e9/m@ninjato>
 <20210629105649.nt63mxtiy6u7de3g@vireshk-i7>
 <YNr/2E/T4FRjLOgy@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YNr/2E/T4FRjLOgy@ninjato>
User-Agent: NeoMutt/20180716-391-311a52
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

On 29-06-21, 13:11, Wolfram Sang wrote:
> 
> > The case when ``length of \field{write_buf}''=0, and at the same time,
> > ``length of \field{read_buf}''=0 is called not-a-read-write request
> > and result for such a request is I2C device specific.
> 
> Obviously, I don't know much about the specs and their wording. Still I
> wonder if we can't call it a zero length transfer?

Maybe that.

> This is allowed by
> the I2C standard and SMBus has even a proper name for it (SMBUS_QUICK).
> From my point of view, I would not say it is device specific because
> devices are expected to ACK such a message.

Actually we should skip the last line from my diff, i.e. completely
drop "and result for such a request is I2C device specific".

The device (host in virtio spec terminology) still needs to return
success/failure as it does for other requests. Nothing special here.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
