Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C21BC77B72
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 15:17:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D9F04288D;
	Fri, 14 Apr 2023 15:17:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D9F04288D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DOaKY7KM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C49El63P306y; Fri, 14 Apr 2023 15:17:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4D23342862;
	Fri, 14 Apr 2023 15:17:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D23342862
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CF38C0037;
	Fri, 14 Apr 2023 15:17:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF6B5C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 15:17:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B30DB60B48
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 15:17:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B30DB60B48
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=DOaKY7KM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XBQ943N5_BpS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 15:17:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F13260A6A
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F13260A6A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 15:17:36 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id v10so3927199wmn.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1681485454; x=1684077454;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LiiGjyqX4o159cvbNlKsXJAHA/ueLUd6Q3sCWwwpz5Y=;
 b=DOaKY7KMiuRzv77phiJcAAJ0NvzAbTEawUceJCq6OubBbrOFy3Y2WowDMWM1MdGYR3
 qnxbuVikIfwiaWU3C/6stDlcrBYUtEJPZC6mXfRzfuRNK1brACCZs8MqXBEc8IqMZheI
 OoWJkk6gu7SDNrsmn4lCNzIOyj6jABoMy3GDDBFa1fJz40ZVsCmKSbFNvSbb1MHdqYlp
 782o1F334MH2N07jMwV2b4JQVr9ztDdcdcwufcgZ2rq0bOXHMrWvDwQWE1kepwuQKTvG
 iu5v4ZDskKltIMbH1D19AeTWfSDxUKF4ulyKN1T/UUaFGah5Elk+bCXeFQyc7lmYPPJd
 EIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681485454; x=1684077454;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiiGjyqX4o159cvbNlKsXJAHA/ueLUd6Q3sCWwwpz5Y=;
 b=VLKqsCXE02zyAhpVpO/eslp22TDaP+T1K80UCRy/nsuxSCmzLMFzgU4rEqe0OHNZ41
 M96wuAdBeSdEC5eoAZF52iswL4sisr2al6lK8VfZNqxb5RR/rgkcqCprMgahZCz7C3rB
 gI3bqUXRJMSZP7Q85hm0JYVNnEo1EyGOA1CjpDjgPytKXqUL6MisJRi7o3ywBmkiQ/Ob
 AdbVvsUdymTRrN24LiSCfcdQDyBOYdqGwrfZvk5GhKlma6MfggNr9eU4/+ldqvMC6c+k
 naalnBex0Ofi9yQGiYTQ79nn0lGiUCIXY6NGtHTDbTyMFoUatUjYHOV1cH8AyWadITuh
 A6Ag==
X-Gm-Message-State: AAQBX9eoesrbNOizilp7RA2CEOBPCJ5gZWf/OB3m0F+cKtt3U4Sk4b2h
 eVZW+sw/7HpnzMWvc+SQg3mpsA==
X-Google-Smtp-Source: AKy350bQFzW/yiQUVEbMS8iwEGtjIIv6F3QJDvhfsmxOMugGGxPwOpR0bNIgwlJINtCCORADLPrWlg==
X-Received: by 2002:a05:600c:21cf:b0:3ef:3ce6:7c54 with SMTP id
 x15-20020a05600c21cf00b003ef3ce67c54mr4860044wmj.35.1681485454655; 
 Fri, 14 Apr 2023 08:17:34 -0700 (PDT)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c228800b003edef091b17sm4508021wmf.37.2023.04.14.08.17.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Apr 2023 08:17:34 -0700 (PDT)
Date: Fri, 14 Apr 2023 16:17:35 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: virtio-iommu hotplug issue
Message-ID: <20230414151735.GA4145625@myrica>
References: <15bf1b00-3aa0-973a-3a86-3fa5c4d41d2c@daynix.com>
 <20230413104041.GA3295191@myrica>
 <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c6fb5a06-aa7e-91f9-7001-f456b2769595@daynix.com>
Cc: qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 virtio-dev@lists.oasis-open.org
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

On Thu, Apr 13, 2023 at 08:01:54PM +0900, Akihiko Odaki wrote:
> Yes, that's right. The guest can dynamically create and delete VFs. The
> device is emulated by QEMU: igb, an Intel NIC recently added to QEMU and
> projected to be released as part of QEMU 8.0.

Ah great, that's really useful, I'll add it to my tests

> > Yes, I think this is an issue in the virtio-iommu driver, which should be
> > sending a DETACH request when the VF is disabled, likely from
> > viommu_release_device(). I'll work on a fix unless you would like to do it
> 
> It will be nice if you prepare a fix. I will test your patch with my
> workload if you share it with me.

I sent a fix:
https://lore.kernel.org/linux-iommu/20230414150744.562456-1-jean-philippe@linaro.org/

Thank you for reporting this, it must have been annoying to debug

Thanks,
Jean

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
