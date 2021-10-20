Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C03C433F5
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 06:41:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4A760F56
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 06:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA4A760F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 90D9260752;
	Wed, 20 Oct 2021 06:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sextMCwHHZzq; Wed, 20 Oct 2021 06:41:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 48F1260806;
	Wed, 20 Oct 2021 06:41:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20C34C0011;
	Wed, 20 Oct 2021 06:41:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91443C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 06:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7CC42838D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 06:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XrRhKyQa4n9w
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 06:41:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D1970838B3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 06:41:31 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id oa4so1775204pjb.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 23:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=otIQhWkkiTUCK7A8zqj4dcMFSS7Btq7zBo70rVUTfH8=;
 b=pWiezsUCqWZue+ySifqtIfn3GEltgU49NBeZJ+/Mv7Zujj8l7Hm2jNPzH1bwOCVyMz
 D3Jv+BmNDsABGLssv1QgrbFUey1rHeejyYKgEe3hSaQXr5VVyOmfRyleS8xqu+tsa6ri
 rSKJvS9KSGbUnl12IStEH9pKrF2nY4ABM+I7zdTF0lmYLCF897/7uTh1W9wnslSdAPY1
 R1q37pYCFuF33Fig2IqlydmRz9Su1RpohkNZ1/bp8L0tuDdf61TjEIVJ8/epYfcYu7rN
 5swcvM3pm3s1Ezx+L73ZOdOEm41/+lFGWGqcXeQAMSXOyzNNorHrOZWaruylo9qJ69AX
 i6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=otIQhWkkiTUCK7A8zqj4dcMFSS7Btq7zBo70rVUTfH8=;
 b=6AAYuB/AY/SMS2sIDe7svaV7gb54XWSYlHxkhu4qIakuhN9msazf7Ze/m0G0t2yVGg
 N7BtRGUCOTXWZA9yG4wImZcwt2uegH+GlvYtAClNGr6iyTeVSWgfKauiSRniRdOGobOg
 12n9hbM1A2JW8RoGnmGmDZX2GCVgmTPs1plsLmaoxj+m1e47EccQVg9NCmwL80ijPEum
 aklYCrgIY3j5gM2lSG/KktbXoxwNFgh4/NEjsFdWgTqAX2QZmZhQ1jFgRNZhWRyRRgSO
 1hWFk4YlKNO1j7NhUtyaGX+ZiTKWyk9qKgvaNO7hn0fDKO6xTcuTYIB5hXradVpDGabl
 6pkA==
X-Gm-Message-State: AOAM531DaKm6jni7t8gImklL6JFvuGZPxajja54RgjeSVor6VitNhYWU
 3NRn9R59/iI8j2EGJUjRexMJOw==
X-Google-Smtp-Source: ABdhPJzoKP4oeBg3gPjvGCznKOoVE1EtsQzbyyfVfWYL0UiXmVZmMMyypeV17+qxmo+F/34/IEinCA==
X-Received: by 2002:a17:90b:17c9:: with SMTP id
 me9mr5163946pjb.197.1634712091178; 
 Tue, 19 Oct 2021 23:41:31 -0700 (PDT)
Received: from localhost ([106.201.113.61])
 by smtp.gmail.com with ESMTPSA id l6sm4665309pjy.23.2021.10.19.23.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 23:41:30 -0700 (PDT)
Date: Wed, 20 Oct 2021 12:11:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211020064128.y2bjsbdmpojn7pjo@vireshk-i7>
References: <20211019074647.19061-2-vincent.whitchurch@axis.com>
 <20211019080913.oajrvr2msz5enzvz@vireshk-i7>
 <YW6Rj/T6dWfMf7lU@kroah.com>
 <20211019094203.3kjzch7ipbdv7peg@vireshk-i7>
 <YW6pHkXOPvtidtwS@kroah.com>
 <20211019143748.wrpqopj2hmpvblh4@vireshk-i7>
 <YW8LFTcBuN1bB3PD@ninjato>
 <94aa39ab-4ed6-daee-0402-f58bfed0cadd@intel.com>
 <YW+q1yQ8MuhHINAs@kroah.com>
 <8e182ea8-5016-fa78-3d77-eefba7d58612@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8e182ea8-5016-fa78-3d77-eefba7d58612@intel.com>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Greg KH <gregkh@linuxfoundation.org>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 kernel@axis.com, linux-i2c@vger.kernel.org
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

On 20-10-21, 14:35, Jie Deng wrote:
> Yes, but we need to know what's the best value to be configured for a
> specific "other side".
> 
> I think the "other side" should be more aware of what value is reasonable to
> be used.

If we _really_ need that, then it would require an update to the
specification first.

I am not sure if the other side is the only party in play here. It
depends on the entire setup and not just the hardware device.
Specially with virtualisation things become really slow because of
context switches, etc. It may be better for the guest userspace to
decide on the value.

Since this is specially for virtualisation, the kernel may set the
value to few HZ by default, lets say 10 (Yeah its really high) :).

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
