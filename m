Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C025C6377D
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 06:11:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC21961264
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 06:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC21961264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EF60606F3;
	Thu, 22 Jul 2021 06:11:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XY0FRue7sFyy; Thu, 22 Jul 2021 06:11:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3BF5B605E1;
	Thu, 22 Jul 2021 06:11:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 107B4C001A;
	Thu, 22 Jul 2021 06:11:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CA5FC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 06:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FAA160617
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 06:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ivkzKMKBXob2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 06:11:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 13C69605E1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 06:11:35 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 j8-20020a17090aeb08b0290173bac8b9c9so2778089pjz.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Jul 2021 23:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=5cK/GjjXslo6GmhOaYGYgEeJORqH/6loH5RcftK4HU0=;
 b=sNFeP8gsrg5VCxm8rqifewFeatxucPeFT8QEFd5cHlvPnxDGYlqnnKYLg+/mZOBh3V
 CekjXrhczXfkr2iNaSB6W8rWUmHAet4VscoEFL0AxiE9nbEs9oJIBany+LvtbYG7FrUc
 Jw565w2BlZDy5hT+ZL/hzLtLDs7UhDamlxcQbn9ItGvEKbqihRsPUMqc5D4lK31eE//F
 lS0ODkg7FIALkXk18t7MF1EHSOEK3hYf68fnBKu1wVHjDBdpcWUyZkgHgaDfg2A3IbOM
 v9sUmK94nsKDYack8MCse8YMfsQ0WP92vv5RlI9kGXshr0CnNHD8SOp8MmT9xvmbYGp5
 RAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5cK/GjjXslo6GmhOaYGYgEeJORqH/6loH5RcftK4HU0=;
 b=JP47U6COFpQAmudPREOtOTfDtp2viXZbcgqhFe8Mdo64NMKYZaNXELf7FyhbCLivxo
 JpcB/xlFCV8dwHK353+izUM7qNzBUUlR74DAjT67bG09cOq0xtip3S/zCLzXln0PiwUr
 3f62f75Z0QS181h4TKLs3G5QaEIcWv0iZFNkmAzJ8aAMz/Q0THdaG63tmPUPYxk1ZKwe
 gGJ4apD9GOe2jMMWM0hlaa7Ym4wK+Z/kj3396P6wAv7viwtdBPQgOuKXnFb9uD0MB/BR
 4YGW0izYfqAGP9npOqTRcfXHWjaAuJsVhiAZIiHLv8AwfZxYgsi2d8PDDJOysHgcqYvc
 yQDA==
X-Gm-Message-State: AOAM531hXVkef2pKxDn2jc6GwSkj9BJBDGzxHSJa8RHmuTPczWlHSM36
 LCFTzK4PdTvz84FtlOtLNhscbA==
X-Google-Smtp-Source: ABdhPJzsWABQoKOw3MzOV+BFwPL/nvqeS+gihVIl55DIiQN+F2diI2HTBaXl4hz/H55Mrjp2n4llLA==
X-Received: by 2002:a05:6a00:1895:b029:32c:b091:ebc with SMTP id
 x21-20020a056a001895b029032cb0910ebcmr41234478pfh.4.1626934295257; 
 Wed, 21 Jul 2021 23:11:35 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id 202sm29390372pfx.75.2021.07.21.23.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jul 2021 23:11:32 -0700 (PDT)
Date: Thu, 22 Jul 2021 11:41:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210722061130.yb7z7povshgtbi7z@vireshk-i7>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
 <20210722051433.3f2ix75wbi5pphp2@vireshk-i7>
 <YPkK7RlufYj1b+2f@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YPkK7RlufYj1b+2f@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: arnd@arndb.de, mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, wsa@kernel.org,
 wsa+renesas@sang-engineering.com, linux-i2c@vger.kernel.org,
 stefanha@redhat.com, shuo.a.liu@intel.com, andriy.shevchenko@linux.intel.com,
 conghui.chen@intel.com, yu1.wang@intel.com
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

On 22-07-21, 08:06, Greg KH wrote:
> No new features are allowed for 5.14, you know this.  It's but fixes
> only now.

I was trying to be (overly) optimistic here since this was a fairly
independent driver which won't break anything else, and had been
pending on the list since many months now.

But yeah, I know the rule and understand its purpose :)

5.15 it is then.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
