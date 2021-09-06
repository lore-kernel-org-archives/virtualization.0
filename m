Return-Path: <SRS0=ZzT7=N4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79D0C433F5
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 04:43:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3026D61039
	for <virtualization@archiver.kernel.org>; Mon,  6 Sep 2021 04:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3026D61039
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB9A640428;
	Mon,  6 Sep 2021 04:43:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ZIILg7v_Ehw; Mon,  6 Sep 2021 04:43:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8BD324041E;
	Mon,  6 Sep 2021 04:43:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62E96C0010;
	Mon,  6 Sep 2021 04:43:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97679C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 04:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6AA7160656
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 04:43:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UTHS7LLDqlQg
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 04:43:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B1CC860633
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 04:43:10 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so3511347pjr.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 05 Sep 2021 21:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=3zWdOueDKtAVWRvfy9UP9yg3qL1geWqf5YsZ2lnxtUo=;
 b=pHag5NqN7NmLLdCbx6/9eOnpQtF7ZlLiKc0HpXCLEHtYhFph+QMys170qxyVKIziAJ
 enhc3w7ko88B/HrujeSJFW01Tsp70YxHU5h7+qcxRx/yPlTwmNSRAygOJ/VqxGqskb78
 n8uNACU1NwyC3ZYEZa3Zvk2c+yxY/GkY692LDiF6q15ZWgGC74nDpAXLre+X+TESFFnL
 DMkSwFFLmbQlek3KbcJp8a/1dp0UEvsdaG1SQv9RSw0l9n26nA05ViLHUoE2ydq/s842
 jpLOLaILRNKQHmHgsHh1CiqQpd1G8rrWRD6m0F8jrPKzpRL3gtF128GTM3KoKaW4P0yj
 Cslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=3zWdOueDKtAVWRvfy9UP9yg3qL1geWqf5YsZ2lnxtUo=;
 b=kwYGq7vFQrUo7EViVSJzH72HeiQR+QjUufz9yf554X/lpVZnMOEPQ/Fu2MmpUeAhRQ
 HjEb6LmOK2XFPQzAzH5iybsIB/hIHQw0UEc/RjpBVyCdsrlGKcOHUBQVo8L9uux9oOBJ
 rRZT+5x4dIA4O3QAiBaVKjV3ThjP26M2St0e3v+KTFhuQLLYRAKz6C8tkn4lCdzKyvLH
 nuDOnOK9/tyX7C1OMQQTWtyLFTpKJlQkdJFP6cZBi8bZa11xxzxsQeesR5l42bePjJ5J
 2HkGI9MnRD1wMbBNFRi919TTDUcSpSsGDSvF2x8ICLrhFeEbJTAN1HVjwyCKyQFowHDI
 Xd1w==
X-Gm-Message-State: AOAM532Mjy/zCIXM3PALe9HHEYfAwpmyCqhf9bc2zB7XJDY9evBSyD+y
 w3G3vAX09U6fc3+cFWlaPw+NWA==
X-Google-Smtp-Source: ABdhPJwe0pj97liB4LbsuYiSoF/Xal92iCreh5AfSiBr0sUl9OcHufz0zEsxfvXQheepjecetEIs7w==
X-Received: by 2002:a17:90b:4b4f:: with SMTP id
 mi15mr11975932pjb.120.1630903390124; 
 Sun, 05 Sep 2021 21:43:10 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id m28sm7594271pgl.9.2021.09.05.21.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Sep 2021 21:43:09 -0700 (PDT)
Date: Mon, 6 Sep 2021 10:13:07 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v14] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210906044307.se4dcld2wlblieyv@vireshk-i7>
References: <984ebecaf697058eb73389ed14ead9dd6d38fb53.1625796246.git.jie.deng@intel.com>
 <20210904160059-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210904160059-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-391-311a52
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
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

On 04-09-21, 16:01, Michael S. Tsirkin wrote:
> Same as with qemu bits, I am confused as to what is the status
> of proposed spec changes and whether the driver will work
> with them.

This is already merged as well.

The current version simply fails to transmit the messages in case the
length of a buffer is 0. I have patch ready to make it work with the
proposed spec changes, just waiting for them to be accepted.

> Let's let the dust settle on them then, then
> resubmit?

It doesn't break anything for now since we don't have much users and
we know zero length transfers don't work. I will submit the necessary
changes once spec is finalized.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
