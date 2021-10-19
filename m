Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753EBC433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 14:37:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049296113B
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 14:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 049296113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCBA1406EB;
	Tue, 19 Oct 2021 14:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AItbzgL80g3R; Tue, 19 Oct 2021 14:37:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 691794069F;
	Tue, 19 Oct 2021 14:37:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E3D3C000F;
	Tue, 19 Oct 2021 14:37:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 701C3C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 14:37:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F14E83CC3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 14:37:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ivFtvvYL5cdA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 14:37:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A8ED83CC1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 14:37:52 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id kk10so108514pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=CIecaATj4T4Z7qYQY+MZOASityIhhLivg5T3isTLezg=;
 b=K+IX3Vwyw6PvNlEeKvoJECnjpAQ+tkGq8g2/R/3Z48+kM7c1VCYYreHnYbMVVFcOof
 uXLGvd/NkaIadqfUYAMerkL7JOTWBdXxnwHN7h2Q5GQSyoNPRzoHwNqVWloSN3/255CH
 SP+rJfm7Ec4Y32ZlfD/ieoW6c9JqcgMHE748Rudvu0cIPIwrwVPmY5kp6mDGOs7ZssjT
 MHByEPF1i2tmet0mT3njVAbtQdJTuVPG0vVYKccX49R5xQcEDuUXQKy5OSyz3fMXSUfJ
 iXsbXp/yXl77AovgvglF9qZ1jTiCaV71XNAaektdjAcWYR6d5TgCJbG8TnkAb7Onn7xJ
 7JsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CIecaATj4T4Z7qYQY+MZOASityIhhLivg5T3isTLezg=;
 b=EEXwuMQfkxEzJKPdvZHobNe2BoMB93f3VYSkAo15D6JisLcwr7ghsx+s9YkiQf2NxU
 zrHmVmDNhL7bGrLO5uYCpG/JbOOesXfgfR3usung4FBLbxp3EHv0v54bLnFUshD1/a4W
 xvL4rIV9gAPSqPzRvPUrh5SZzjCi/Bs/c+qUE1MXiV7PYmE70HjLBmhvWEBIcis1PGBE
 MIrK7Wtfy9qpoxr0m93/8uSlrHVI7hQ1Xejy3DtiwMhRaHf8b+x4zCMT04gX1QfekkiW
 GO1RxVjjOw3Ml6QJBCIS0aZ/0j18wSBrxmo94/XK9bdMpz0Fy/PbKeprdaSMQDbNu7fs
 15Tw==
X-Gm-Message-State: AOAM530kUGQhkBEtB5so3HtsGPeoI4c3gMUFjCU6IzDGQ1mzunAnsIH1
 7LUZ2VtALEDwfddGcIIvJzaqiQ==
X-Google-Smtp-Source: ABdhPJwi1zRSay/RiMuygWybe3OJlMn3edmEEKlLPd7Fpn5/Gz2ZpgAXfHwv4popfZhhKukTBL9uFg==
X-Received: by 2002:a17:90a:f292:: with SMTP id
 fs18mr128645pjb.229.1634654271626; 
 Tue, 19 Oct 2021 07:37:51 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id s20sm2167476pfk.131.2021.10.19.07.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 07:37:51 -0700 (PDT)
Date: Tue, 19 Oct 2021 20:07:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211019143748.wrpqopj2hmpvblh4@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-2-vincent.whitchurch@axis.com>
 <20211019080913.oajrvr2msz5enzvz@vireshk-i7>
 <YW6Rj/T6dWfMf7lU@kroah.com>
 <20211019094203.3kjzch7ipbdv7peg@vireshk-i7>
 <YW6pHkXOPvtidtwS@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YW6pHkXOPvtidtwS@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 wsa@kernel.org, kernel@axis.com, linux-i2c@vger.kernel.org
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

On 19-10-21, 13:16, Greg KH wrote:
> On Tue, Oct 19, 2021 at 03:12:03PM +0530, Viresh Kumar wrote:
> > On 19-10-21, 11:36, Greg KH wrote:
> > > What is the "other side" here?  Is it something that you trust or not?
> > 
> > Other side can be a remote processor (for remoteproc over virtio or
> > something similar), or traditionally it can be host OS or host
> > firmware providing virtualisation to a Guest running Linux (this
> > driver). Or something else..
> > 
> > I would incline towards "we trust the other side" here.
> 
> That's in contradition with what other people seem to think the virtio
> drivers are for, see this crazy thread for details about that:
> 	https://lore.kernel.org/all/20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> 
> You can "trust" the hardware, but also handle things when hardware is
> broken, which is most often the case in the real world.

That's what I was worried about when I got you in, broken or hacked :)

> So why is having a timeout a problem here?  If you have an overloaded
> system, you want things to time out so that you can start to recover.
> 
> And if that hardware stops working?  Timeouts are good to have, why not
> just bump it up a bit if you are running into it in a real-world
> situation?

I think it is set to HZ currently, though I haven't tried big
transfers but I still get into some issues with Qemu based stuff.
Maybe we can bump it up to few seconds :)

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
