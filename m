Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD43C4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 05:28:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CEF60E52
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 05:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3CEF60E52
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C5388356C;
	Fri, 23 Jul 2021 05:28:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LRr2zOoeUAkH; Fri, 23 Jul 2021 05:28:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5BCBD8375B;
	Fri, 23 Jul 2021 05:28:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CF8DC001A;
	Fri, 23 Jul 2021 05:28:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 911D8C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 05:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B3C78375B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 05:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t5JfzGDByPLg
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 05:28:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 485548356C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 05:28:35 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id a20so2108935plm.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 22:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=J87f8T10lgtVuzcfK6rQXH+rwvV/4HwvhXrz0f4FLD0=;
 b=JWPEJ8wVPzIVjSi6bXQsG2CTcz6zWW9SQbNjgvUnbVzcB05X8Ar0CMyPUPh/oIS0XL
 UO0Y3LRoOmlpfGLQQP6oRTVzyGWhcrZqZNWFOPJiElfej2LRbRH71xEr46axPvjfwuab
 eIQPLafyxTXrQmXOft4lzdMAbg2cMdi+BncNS4HukrXy/df8nXM0k6IjwLxJAWS47fj3
 7svNWv28SdZBoM+MuW6ZjxBSEP0zZWt7rKizRWqjdWZkrBdVsYCJ6G5D9eLUpsiV8OpW
 Wt4s7Fsb9SE88DmXMHWcEYHqU4Euj/xsKus6niUK336f4oRWDodSrcChvD7UxJaTAG3u
 POGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=J87f8T10lgtVuzcfK6rQXH+rwvV/4HwvhXrz0f4FLD0=;
 b=CBMVdqNXGQkRtzpDgKv+x5pQBfJljtWFeDmrY///c+Jc3nhIc9MGlfhyBwGhXuH9Yj
 rD3S4DndJOr1YRpkxWgjkIwjj+yEtT+FMCnFUqEMTH9FQPBG45Zxtw1XvSPGyB2wEgH8
 y7AJeGGxmEWO2bGtgW76ACrO+vRdkJbAhdjLGaaZQYLZWhWfzkqBqVUNfTW7IV5u3bIA
 7zyLsS0MN4wdd2/SGqo0wxLiQwTUUXHVpO/PvSD3eeWSX02+RDrXvTE4wj76zOW7/jFd
 kPKO0d2KyFhRUVw1ut8fwkBulMhE826AaDJHGPXzT0VjqLWvWSmqZsRW6jb7ukEVo/mV
 tHMw==
X-Gm-Message-State: AOAM5319AX7iOXJLbBPBtxSzJTIOYfieCj6KOz7T4dE6qUyu4SLu5PPP
 iY7nE34BZTsiyKjqpmTfYiuEyg==
X-Google-Smtp-Source: ABdhPJwrlLG2ErWx84N6cAS6kFP1mW+MQT2AXD6jNUD9UMF3uahmb2g3KxWWnPrca6tjN2zQvYsJMA==
X-Received: by 2002:a65:434c:: with SMTP id k12mr3332536pgq.17.1627018114572; 
 Thu, 22 Jul 2021 22:28:34 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id b7sm31767619pfl.195.2021.07.22.22.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jul 2021 22:28:33 -0700 (PDT)
Date: Fri, 23 Jul 2021 10:58:32 +0530
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
Message-ID: <20210723052832.kmi2654q2bufu45w@vireshk-i7>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNrw4rxihFLuqLtY@ninjato>
 <20210629101627.kwc2rszborc3kvjs@vireshk-i7>
 <YNr0uDx1fv+Gjd7m@ninjato>
 <20210629103014.nlk3mpetydc4mi6l@vireshk-i7>
 <YNr5Jf3WDTH7U5b7@ninjato> <YNr5ZRhT3qn+e9/m@ninjato>
 <20210705121832.fmye5xnlbydoc5ir@vireshk-i7>
 <YPmLoeLSPS1tfYUK@ninjato>
 <20210723022836.ews7bshlwcsaktud@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210723022836.ews7bshlwcsaktud@vireshk-i7>
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

On 23-07-21, 07:58, Viresh Kumar wrote:
> Would need a spec update, which I am going to send.
> 
> We would also need another update to spec to make the Quick thing
> working. Lemme do it separately and we merge the latest version of the
> driver for linux-next until then.
> 
> I checked the code with i2cdetect -q and it worked fine, I was
> required to do some changes to the backend (and spec) to make it work.
> I will propose the changes to the spec first for the same.

I have sent all the necessary changes for the spec here:

https://lists.oasis-open.org/archives/virtio-dev/202107/msg00167.html

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
