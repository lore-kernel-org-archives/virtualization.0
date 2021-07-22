Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44472C63797
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 05:14:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA4E61264
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 05:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA4E61264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9826382ECF;
	Thu, 22 Jul 2021 05:14:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gbv2wr9b1Qws; Thu, 22 Jul 2021 05:14:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C31B82846;
	Thu, 22 Jul 2021 05:14:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF880C001A;
	Thu, 22 Jul 2021 05:14:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E160FC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 05:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFB5040206
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 05:14:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jDA2z_Ub4JxK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 05:14:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3461B401EB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 05:14:41 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 p5-20020a17090a8685b029015d1a9a6f1aso2612838pjn.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 22:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=x5SPZyEeIR7cDZy3lUojZmJw7O7Dz9BIOkg7BRhzZ2w=;
 b=bxJGU+QOwf3Ftj9yKJ3uVgM7FcgPQLcl11zYOrXuclg1uwqqHdVkAfbAmbiVMIAzoO
 FTvXRGr7731VeNA7/5RNTiVU5REGvxNLeS4BAPdJKSUKTlQqdrCasSAm1jJyvhtHjykq
 2B0q0XLD5tGB0LNrc5zHzfqJOWYVZKgLBcrBrqikptR0sQyps7KcsZZQZ3Pq7jGZB100
 ILfl+7IC0qiqO50fHamwHcBRRziKZXIJ95Z7utigNFPi9vVUYIyt/8S68hFDAU2/ZYYL
 /q51yoWGYe6nMZwGLfn6Pmn1h9If9SRTUxarGshuq1gJe5HfKD4KoIPaNJae6Iq42HLP
 mVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=x5SPZyEeIR7cDZy3lUojZmJw7O7Dz9BIOkg7BRhzZ2w=;
 b=MkOBFRMSKVyWXrFk/2HOewKveY6e22iG6pJVedmojcfobok0Cx55RTx4CjDNWpkE2T
 4d7429Wcf8gn05ZeY9A6Z/R8fHIR6A2n1GLYG43Thf3DJ8p7qh9db3rMK+NnCM75Sxa6
 sHH+5X0qJUkWdGvM728WkTnQEAzqhMJ4BBHsf5hpFVozo2olSKo19aAi6o2Iy1i3ciJ8
 ZI5lIU4ueM67w3CJLRkhctA+EDIJcyh62eZnMpPCc0COUJhETHcai+8IxzP/+1kiN3sq
 O6RNtLIpKBLHn8VallUY2MbqVOwl2Ooqt8so8SUdT9hdVfJALVzG92aW5Y/dDOvpgGkO
 cidw==
X-Gm-Message-State: AOAM531jHiirAQKenUumoqBjM84bAnsa3P1EmJCmFcrIthnkXsjNZpG9
 X/SvD6mYhwwGvZ0f9HUnvqKkcA==
X-Google-Smtp-Source: ABdhPJz+c56smMs/30jrQXG0ui77AzZEHDx4M8oXH02LK5FomM1u4knGmr1cv7pcbsAt2Rx58z/TYQ==
X-Received: by 2002:a17:90b:1041:: with SMTP id
 gq1mr7123687pjb.222.1626930880559; 
 Wed, 21 Jul 2021 22:14:40 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id 26sm15414111pjg.8.2021.07.21.22.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jul 2021 22:14:40 -0700 (PDT)
Date: Thu, 22 Jul 2021 10:44:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>, wsa@kernel.org
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210722051433.3f2ix75wbi5pphp2@vireshk-i7>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa+renesas@sang-engineering.com,
 linux-i2c@vger.kernel.org, stefanha@redhat.com, shuo.a.liu@intel.com,
 andriy.shevchenko@linux.intel.com, conghui.chen@intel.com
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

On 09-07-21, 10:25, Jie Deng wrote:
> Add an I2C bus driver for virtio para-virtualization.
> 
> The controller can be emulated by the backend driver in
> any device model software by following the virtio protocol.
> 
> The device specification can be found on
> https://lists.oasis-open.org/archives/virtio-comment/202101/msg00008.html.
> 
> By following the specification, people may implement different
> backend drivers to emulate different controllers according to
> their needs.
> 
> Co-developed-by: Conghui Chen <conghui.chen@intel.com>
> Signed-off-by: Conghui Chen <conghui.chen@intel.com>
> Signed-off-by: Jie Deng <jie.deng@intel.com>
> ---
> Changes v13 -> v14
> 	- Put the headers in virtio_i2c.h in alphabetical order.
> 	- Dropped I2C_FUNC_SMBUS_QUICK support.
> 	- Dropped few unnecessary variables and checks.
> 	- Use "num" everywhere instead of num or nr, to be consistent.
> 	- Added few comments which make the design more clear. 

Wolfram,

Is it still possible to queue this for 5.14 ?

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
