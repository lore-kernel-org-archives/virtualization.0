Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D66C11F69
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 04:55:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 995AF61413
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 04:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 995AF61413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5023F83D62;
	Fri,  2 Jul 2021 04:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wWlHHuVJwOoY; Fri,  2 Jul 2021 04:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E271083D4E;
	Fri,  2 Jul 2021 04:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC5EBC0010;
	Fri,  2 Jul 2021 04:55:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 176D4C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 04:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E30A3400F4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 04:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ZkPD4vffJNx
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 04:55:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BB21400DD
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 04:55:15 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id g24so5680523pji.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jul 2021 21:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8wdpYac922+2MTlxWPHYisZu+1HjHabMF9049YmCpVc=;
 b=q8GcCDdQAmEIRNwTEc0ZT49UMheJANOM3BeGBqt9HosmhwUlxPmIw4hRgwbWvVxFqZ
 SwlkUrDAWtNPIN8GjI5y7UtinPZLnE1UHs7BX0U0rH0bh0rG+7or/oR1+K+VABxk53xQ
 0rCiZxsSOMfj97YIrPhbLL0D+ynBVYw1e0yyEmG0xVhfd3QvZXToGH/K8+g4LSTMTnsw
 BCbNisHE30++nWDIxXBye6EtG8echBFZQbeWYPsxU+FPnvG5OUlW3ZWuSBvwHhNhsdoW
 j9xrJOTTBnjzuUwaVcgnJKH+GDMfu7TDAtK3sF/R5NdJruCSIXiaQ6CRpxFRQgYp3YId
 wAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8wdpYac922+2MTlxWPHYisZu+1HjHabMF9049YmCpVc=;
 b=jAXiX6sda+Ze2UV08MUTaQfCMgqrl8vPto+ZMKSXRXDp2ts2Oda7PCYHCR2nTdgY5y
 bvo2KgXljElfJR7QdfM2/mW2wXYA1YfaeIgOqa71Byn1knOwz0or5MJZNsHVN+hKxfLM
 AGXHe6RolJvD5al3R04fX8pgXdw8sD253NospDemYvy8ChB2M2IDRcjlFf18ZZsOMpw3
 uoH0eKX9vyFPpzJpoSmAI9vKTB9QoygQuWU6UTTuspDqe1U6oF1GJETotxL3ZrISQnTR
 l2Up5WplNF9hdZVyIJOBWOBYY7/Tk+KBjY8gJDSHrF04/BjmhXWcgJLZgcB4TGZnyZ1t
 jWTw==
X-Gm-Message-State: AOAM5321wkdcYodLkDVeWv17+fm6pIGIkf6bhO+LkzwmpHPhAVER6ypI
 ljsEngUQFujyjHuptjIKdd2kvA==
X-Google-Smtp-Source: ABdhPJznt1hF1UhbLKd6O/yeO2rtrvTkZBeGb4a5GgpM31uoykKdAXgmMBRg83/pWoJpJgqh1pi2vg==
X-Received: by 2002:a17:903:1ce:b029:128:e252:4480 with SMTP id
 e14-20020a17090301ceb0290128e2524480mr2821877plh.74.1625201715380; 
 Thu, 01 Jul 2021 21:55:15 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id cx5sm3347132pjb.1.2021.07.01.21.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jul 2021 21:55:14 -0700 (PDT)
Date: Fri, 2 Jul 2021 10:25:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, Jie Deng <jie.deng@intel.com>,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, arnd@arndb.de,
 jasowang@redhat.com, andriy.shevchenko@linux.intel.com,
 yu1.wang@intel.com, shuo.a.liu@intel.com, conghui.chen@intel.com,
 stefanha@redhat.com
Subject: Re: [PATCH v11] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210702045512.u4dvbapoc5a2a4jb@vireshk-i7>
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
 <20210701040436.p7kega6rzeqz5tlm@vireshk-i7>
 <YN4WeJCepCrpylOD@kunai>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YN4WeJCepCrpylOD@kunai>
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

On 01-07-21, 21:24, Wolfram Sang wrote:
> 
> > I just noticed this now, but this function even tries to send data
> > partially, which isn't right. If the caller (i2c device's driver)
> > calls this for 5 struct i2c_msg instances, then all 5 need to get
> > through or none.. where as we try to send as many as possible here.
> > 
> > This looks broken to me. Rather return an error value here on success,
> > or make it complete failure.
> > 
> > Though to be fair I see i2c-core also returns number of messages
> > processed from i2c_transfer().
> > 
> > Wolfram, what's expected here ? Shouldn't all message transfer or
> > none?
> 
> Well, on a physical bus, it can simply happen that after message 3 of 5,
> the bus is stalled, so we need to bail out.

Right, and in that case the transfer will have any meaning left? I believe it
needs to be fully retried as the requests may have been dependent on each other.

> Again, I am missing details of a virtqueue, but I'd think it is
> different. If adding to the queue fails, then it probably make sense to
> drop the whole transfer.

Exactly my point.

> Of course, it can later happen on the physical bus of the host, though,
> that the bus is stalled after message 3 of 5, and I2C_RDWR will bail
> out.

Basically we fail as soon as we know something is not right, correct?

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
