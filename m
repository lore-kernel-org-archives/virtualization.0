Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A5C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 10:47:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCD960F22
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 10:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FCD960F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6668A83AA2;
	Wed, 20 Oct 2021 10:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SqGkbNyyOB7D; Wed, 20 Oct 2021 10:47:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2010183A7E;
	Wed, 20 Oct 2021 10:47:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3200C0011;
	Wed, 20 Oct 2021 10:47:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A16AC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1516F40528
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XMXcrcLkKwaR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:47:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66B7E40424
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 10:47:12 +0000 (UTC)
Received: by mail-pg1-x52a.google.com with SMTP id f5so22121310pgc.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 03:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1TSBvBQA8kI7/EQ8+8MISIe+X1LmR0R1M6KJhiZdbho=;
 b=ct1uNESrIaobgUaR7vGp25KTJreEBOB3or6gUrv32EmtudAWNGnNpCb4FTr457gP2O
 6NW5jYl8ajoHl2r9WIffV3WB4kNgE9w7yy83Y4Etx79vkkMs9phnY3bpm5ntzf/1sHw0
 hPTfEUrdO86+9+sDzHBlat7nvIE94RdNVrJQAZOJC8UrZ8XfArqGbXZn7cmCyVSyM62Y
 qFzFTQ4nhn1mD+2aq9obIxT5/IqRMzac8lpVSKmvle7HV2geTJbv76nF0MlGeJOpwKTk
 d+kCV8vYmMGBnFo5lQeiH8DCQvdraZ9TOCWwsyyESMQR1BwiOw/mNNVrk528ZkHJyD4X
 WS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1TSBvBQA8kI7/EQ8+8MISIe+X1LmR0R1M6KJhiZdbho=;
 b=h1MYIaZjNSb+Rm202x0kivT+8FGQT2nKi7kCJqsIzdIRw1FCo+deuqJO61EBRvMYko
 4BxpB+Wb2Rf2cbcGPK8Xajgk1VMZ39hJysSRmCmvj4jPJmQgU2fpDeaTQ+a8NindKqiH
 X4pwqmh1SRfiEIYCi6olqqhm0i4/kfp0Q+yIPp+xtfaAsDJRuazGlaRefxwIFdy9Amjt
 Iz/d5VKqyasITGzFoRU+sUJZZm2rgd+3aDH0FIExpUQ8Zhi+AnZinxrjoAq1IIOIoGNz
 KdRdZrCWengqMw6/BKDhX/F3WXwdIj/XHG2qAKkLCH5gFxUly2tIMVoipbB9urMaKOEN
 k/PQ==
X-Gm-Message-State: AOAM533QLvEnz2tliPnT9dRmBlEo5WPOm+imzEDYHI+U2CpPXo03Qq4W
 /bitgVDRmqm/GZCQA0lpgfrUzw==
X-Google-Smtp-Source: ABdhPJxaLdJ/OxJPo3hbNu88Qkt7ECSU97PQAPCrbvcXEInQyh5N7LcufZL+eAND3ifiPqtz7Nl5yQ==
X-Received: by 2002:aa7:9823:0:b0:44d:2428:3b62 with SMTP id
 q3-20020aa79823000000b0044d24283b62mr5507496pfl.77.1634726831843; 
 Wed, 20 Oct 2021 03:47:11 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id g10sm2366308pfc.213.2021.10.20.03.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 03:47:11 -0700 (PDT)
Date: Wed, 20 Oct 2021 16:17:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: Re: [PATCH 2/2] i2c: virtio: fix completion handling
Message-ID: <20211020104709.k6oqo2gmegiwfre4@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-3-vincent.whitchurch@axis.com>
 <20211019082211.ngkkkxlfcrsvfaxg@vireshk-i7>
 <81ea2661-20f8-8836-5311-7f2ed4a1781f@intel.com>
 <20211020091721.7kcihpevzf7h4d62@vireshk-i7>
 <20211020103849.GA9985@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211020103849.GA9985@axis.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "wsa@kernel.org" <wsa@kernel.org>,
 kernel <kernel@axis.com>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
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

On 20-10-21, 12:38, Vincent Whitchurch wrote:
> I don't quite understand how that would be safe since
> virtqueue_add_sgs() can fail after a few iterations and all queued
> request buffers can have FAIL_NEXT set.  In such a case, we would end up
> waiting forever with your proposed change, wouldn't we?

Good point. I didn't think of that earlier.

I think a good simple way of handling this is counting the number of
buffers sent and received. Once they match, we are done. That
shouldn't break anything else I believe.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
