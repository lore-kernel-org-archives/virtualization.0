Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2103CC11F6A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 06:56:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCD861413
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 06:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCD861413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B0D283C2F;
	Fri,  2 Jul 2021 06:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kl9Wsxda_mqd; Fri,  2 Jul 2021 06:56:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3596C83C1B;
	Fri,  2 Jul 2021 06:56:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 054C4C0010;
	Fri,  2 Jul 2021 06:56:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3BD4C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DFFCD4065D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:56:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pVk45Jhs4qw7
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:56:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CC3A44065C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 06:56:28 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id a2so8682179pgi.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 01 Jul 2021 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=bRTZFZ1E3CpWrLbQ7HRC4Me3IA6jdcuP5hZkPy8aTqQ=;
 b=cPTSpOr4Y/ib3p0oVnLcMOPoCVA4W1519zFDRhfxi/uCtnS57a1MfwBzYEH9JJnTXg
 8MzSrGxsX9E/7tvsWnkkpL2FdMmKxWCRn05paSKE7R0C7X12dizUgxonJ/cZhu3p8Pi6
 ZxOF5CxF+VsXgzt3zYkNvbGKfbfnvf0Xmgg6g83a/CUV3Kk2Sm8hBbuXWQOTJbQOpL4D
 2u7ZKhxrMgTlFp9gvGFE7htnxEWSMikZM+7ae7FovIVVaSzPKEih1VWpYHaqqKB0z/7m
 elg+D+S/qK8GfNncidfw2annOuFP6gf7Gqdnruf5ENF55lVCzRCCOHr2pA4KZ1agDDMu
 HNWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=bRTZFZ1E3CpWrLbQ7HRC4Me3IA6jdcuP5hZkPy8aTqQ=;
 b=DOHez0y0iyf9sfk2/WwJRhDfbz6WNolwKztjO4cMrOlFTJ9HqLiKYHalUFhBmldl8c
 R13QMnp1ZDWDM00R6cRTSK6kVKxL0SrqspTiGvsp/+c9iExnIGUB72UMRtxObYUtP6Id
 WRwRb6PEPJ8al/fncfJQW4oSU2DkSUsC/3+PNgKkPQTgODuvN7bmuVj1x4Et1IhErRmH
 qHIdtP3zN1HZ11NOs7b6GU6C9TpvrBsD/kCc1mDcQBORnYj6ZHEED3kdPt5Y8z/qiN3z
 wHDIwwyBFvnVmcYVJBAJFi/r2BmlEXKZazEo5ijEiAS91TxmjZxwyPxA7EHZ30F9itMh
 2MyA==
X-Gm-Message-State: AOAM531DjuZ2KTJMyhBGkkZoFHWAbKUW8lJplQlBFJqeYCbo5KibhA2Z
 GyjEb2btl8mIR07oJhY0BqDwkA==
X-Google-Smtp-Source: ABdhPJxavtN37ys1rmwQed3n/qbrHe7nbn8CnsVNS+IEutFRk9yJ8cEvH5dkgIHmH2s1Uoq0OvHW1A==
X-Received: by 2002:a65:6544:: with SMTP id a4mr286407pgw.280.1625208988205;
 Thu, 01 Jul 2021 23:56:28 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id p29sm2206840pfq.55.2021.07.01.23.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jul 2021 23:56:27 -0700 (PDT)
Date: Fri, 2 Jul 2021 12:26:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v11] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210702065625.qielhnfyrlvrtrkk@vireshk-i7>
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
 <20210701040436.p7kega6rzeqz5tlm@vireshk-i7>
 <YN4WeJCepCrpylOD@kunai>
 <20210702045512.u4dvbapoc5a2a4jb@vireshk-i7>
 <409b6cc3-3339-61b2-7f42-0c69b6486bb3@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <409b6cc3-3339-61b2-7f42-0c69b6486bb3@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: yu1.wang@intel.com, arnd@arndb.de, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, stefanha@redhat.com,
 shuo.a.liu@intel.com, andriy.shevchenko@linux.intel.com,
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

On 02-07-21, 14:52, Jie Deng wrote:
> This is not efficient. If adding the ith request to the queue fails, we can
> still send
> 
> the requests before it.

Not really. Normally the requests which are sent together by clients, are linked
together, like a state machine. So if the first one is sent, but not the second
one, then there is not going to be any meaningful result of that.

The i2c core doesn't club requests together from different clients in a single
i2c_transfer() call. So you must assume i2c_transfer(), irrespective of the
number of underlying messages in it, as atomic. If you fail, the client is going
to retry everything again or assume it failed completely.

> We don't need to know if it fails here (adding to
> the queue)
> 
> or there (later in the host). The "master_xfer" just need to return final
> number of
> 
> messages successfully processed.

No, that isn't going to help and it is rather inefficient, trying to send
transfer when we already know part of it failed.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
