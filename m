Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC2DC433FE
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 14:14:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B4B610A1
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 14:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77B4B610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E69340630;
	Tue, 19 Oct 2021 14:14:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kx6mBjQPwFWw; Tue, 19 Oct 2021 14:14:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E693C40638;
	Tue, 19 Oct 2021 14:14:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9A67C000F;
	Tue, 19 Oct 2021 14:14:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4ACDC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 14:14:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9F0A24053B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 14:14:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5RKTJRSb-_F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 14:14:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DECF140534
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 14:14:28 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id d9so32531pfl.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=P3aFOrAVMeW3dg7UCLDtwTav45B+vnA1U2f1FHY1ecE=;
 b=ZrLSbYqk6HwF2MKuP6JHZLFgt5odRZM70L6wgkOkxf1uXD5hcl5owFLK62YepQdmCt
 DSnRy9R7Bi14qXQJwG/Ji9ibgB1UA2bBIPNwivw/CmIeUoY6vS/y1AyBMKdPWQ4nRiKo
 924z3ClveLyp2M2nMvlfAWb/8YKLKtQWGhi+qtMi4SLp9+ha/sTmsPRp15OLNS4TU24T
 cq6d834UYoMaBaUckQ6loqWSBMsBz6fHpe1Z22IG+PtuPAuIUDPTFQZLUoP/DorHhW4t
 Tjf+ybUomO17JYBI/CelCQLOhCLvqfZsZRp1H5ptBUCFHIRM+cQiod1qQemW9Xbyw7/5
 N1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=P3aFOrAVMeW3dg7UCLDtwTav45B+vnA1U2f1FHY1ecE=;
 b=hAAo9uJltcSsHPzhnM4QkY6+ps5SjlY6HaMou/771w17EvK++5k2hqRevshcLrTCOS
 0/NyOxDETZOH5SqM2lmJWuVqiAgbWCKR8hI5hHpXswz7BdGkviU3l5MURQjeQxm/+0Sw
 hr/bRXgdrWX+cXT0Ao/aTzr8M9C7ZmPRKFq9QVp68aJ2C5+IxIW+2x/HHblt2pzlpFhp
 CKA6tXzpXjWnU9a6skUjQ64DbtIRBcE73nslrBkralgNcB0HO3DO1+5E8R8DvEoBRMLu
 LNCMy9ODxmJdEU07LKGH0FQS1WnV2vaNapcSnd+sXQGYkKFBTx2EMUk3G+gx8gfpuEJR
 C1eA==
X-Gm-Message-State: AOAM531NliTVDmTjUoa4F3lK8CUZXeceCwvQQIgWn68jomm5ULwbL3BY
 S6N+59eWEunTsfeR3U4/NnnHtw==
X-Google-Smtp-Source: ABdhPJyOB1u4FJx3A72AZQFyFN/BxVUZq7/f7i2XVIE2wXvUpxFYNCvWwiJSasmViHMk3T5Y334d0Q==
X-Received: by 2002:aa7:9043:0:b0:44d:13c7:14a5 with SMTP id
 n3-20020aa79043000000b0044d13c714a5mr26622pfo.86.1634652868250; 
 Tue, 19 Oct 2021 07:14:28 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id bp19sm2729404pjb.46.2021.10.19.07.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 07:14:27 -0700 (PDT)
Date: Tue, 19 Oct 2021 19:44:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 jie.deng@intel.com, virtualization@lists.linux-foundation.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211019141424.2lqc5cd5adiqffur@vireshk-i7>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
 <20211019074647.19061-2-vincent.whitchurch@axis.com>
 <20211019080913.oajrvr2msz5enzvz@vireshk-i7>
 <YW6Rj/T6dWfMf7lU@kroah.com>
 <20211019094203.3kjzch7ipbdv7peg@vireshk-i7>
 <YW6owLxoYbxG5GxT@ninjato>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YW6owLxoYbxG5GxT@ninjato>
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

On 19-10-21, 13:15, Wolfram Sang wrote:
> 
> > The other side is the software that has access to the _Real_ hardware,
> > and so we should trust it. So we can have a actually have a completion
> > without timeout here, interesting.
> 
> So, if the other side gets a timeout talking to the HW, then the timeout
> error will be propagated?

It should be, ideally :)

> If so, then we may live with plain wait_for_completion().

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
