Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E0CC11F68
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 07:21:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045AA613F3
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 07:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045AA613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B105E405EE;
	Fri,  2 Jul 2021 07:21:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id koUGSarI-1kO; Fri,  2 Jul 2021 07:21:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18084405DD;
	Fri,  2 Jul 2021 07:21:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC9BEC001A;
	Fri,  2 Jul 2021 07:21:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29EBFC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 07:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11229606B1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 07:21:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bVt0_Rv9RTt2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 07:21:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B82660679
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 07:21:30 +0000 (UTC)
Received: by mail-pf1-x434.google.com with SMTP id w22so4562573pff.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 02 Jul 2021 00:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=cTT5SBbgufyipfbulZ8UMd6eHUFijnnoOYYIn/7MP+o=;
 b=nFo7STRAeHl5/1sVuiyLsRIes/cEOzB6idGycA7fykYwfli+PR+4+ICCGHu+IR7SWr
 Glr9IqxTFZCmBRzjqDZs1GPdJduONKvf33/VV+ZYqujRcXyO2aAqsmUQcSLHtnaWc+JW
 DleBvWV/cShHHGvtf7+zKCA41D9ifMsq7VWJnEp1z6YDwXXfy9r+r5Py6YsbrMt4Uwqx
 0yQjMw6gsAg6WdsKFMwV7FtKg0Ku4kGxyN+2KHMVmHsD3b5xdSpt+uXnzInUk6UKrmnG
 Jtz779vpf4E7BPARlTn/tl5wAoVsrCwSOVS2lCqv1XWi2WWrgL3PMUsPSSl3n3/Epxol
 GeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cTT5SBbgufyipfbulZ8UMd6eHUFijnnoOYYIn/7MP+o=;
 b=DuMW1PPxLA+mCOJprhn5gjfPGIskWkBu9DK36Q2Wr6EQBjLjF0c1REjIgK0CmsimlK
 Wpor3/rxNTL5cy+kUKwVm327aG0LLHd1/KwLyLR38tQsQt9Ilf8bdQ3Xp62DjzzyvQqU
 DkjZAf4WgCEBq0ndzXYeFFWp94pd9mm4F6vjQHhY4n9c1pU9V5jhLv0eOQZgJaoTVZ7H
 xlu/ZMb+oc/q09C8uiZjtIiyyh6CpkPZZx5RoZYTmCbFCFPFK/EFz6aHTpitFcnVVbV2
 57PksjYdNP8LW6T5s+2sHHqo7xNaIyfPZZhiP9rn2kw7nXz37TaKw0A5607cyrDs6tnd
 e1dw==
X-Gm-Message-State: AOAM532feelYOC54P7ABDb8g7JVWX8LschJRB4gwE9f4lVJnZEyCV6FX
 4LtE7UCO/3YNRt94KCC/+RzD+A==
X-Google-Smtp-Source: ABdhPJzlpbJzMatPVcdFqFBjlHuIxZl7bMeIssuMT/0rPePDZsieD/P+Dj7GcAMS5kEGiURqgqE/xw==
X-Received: by 2002:a05:6a00:26c3:b029:304:8e6c:be0a with SMTP id
 p3-20020a056a0026c3b02903048e6cbe0amr4132940pfw.65.1625210489763; 
 Fri, 02 Jul 2021 00:21:29 -0700 (PDT)
Received: from localhost ([106.201.108.2])
 by smtp.gmail.com with ESMTPSA id c184sm2348185pfa.38.2021.07.02.00.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jul 2021 00:21:29 -0700 (PDT)
Date: Fri, 2 Jul 2021 12:51:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Deng <jie.deng@intel.com>
Subject: Re: [PATCH v11] i2c: virtio: add a virtio i2c frontend driver
Message-ID: <20210702072127.yzofc75cuuqtvzbn@vireshk-i7>
References: <510c876952efa693339ab0d6cc78ba7be9ef6897.1625104206.git.jie.deng@intel.com>
 <20210701040436.p7kega6rzeqz5tlm@vireshk-i7>
 <YN4WeJCepCrpylOD@kunai>
 <20210702045512.u4dvbapoc5a2a4jb@vireshk-i7>
 <409b6cc3-3339-61b2-7f42-0c69b6486bb3@intel.com>
 <20210702065625.qielhnfyrlvrtrkk@vireshk-i7>
 <bdea419c-b450-f6b1-fff3-7df077b2abfc@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bdea419c-b450-f6b1-fff3-7df077b2abfc@intel.com>
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

On 02-07-21, 15:15, Jie Deng wrote:
> Then what is the need to design this interface as "return the number of
> messages successfully
> processed, or a negative value on error". Just return success or fail is
> enough.

Right, that isn't clear to me as well. And so I asked Wolfram this yesterday.

I think it is left for the clients handle this, i.e. what they want to do with
it if something fails in between.

> Here, we didn't break the contract with the interface "master_xfer", so if
> there is a problem then
> the contract may be the problem.

So in your case here, either you should return 0 or nr (the number of transfers
requested) and anything else can only be sent if the host reports partial
failures.

Also, since this driver is pretty much independent of everything else, and won't
break anything in the kernel, there is still a good chance of getting it merged
for 5.14-rc1/2.. So it would be better if you resend the next version as soon as
possible :)

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
