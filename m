Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DCDC4167B
	for <virtualization@archiver.kernel.org>; Wed, 14 Dec 2022 10:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E09B41477;
	Wed, 14 Dec 2022 10:56:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E09B41477
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZuHbhCVH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xvJb0Z65oLpz; Wed, 14 Dec 2022 10:56:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 408BF408A6;
	Wed, 14 Dec 2022 10:56:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 408BF408A6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D41A1C0033;
	Wed, 14 Dec 2022 10:56:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5955C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 10:56:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A30B81E98
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 10:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9A30B81E98
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=ZuHbhCVH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XldULdYJMt9G
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 10:56:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 54C8481E8F
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 54C8481E8F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 10:56:46 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id w23so2905885ply.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Dec 2022 02:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=++Gb2lBFkve8gSRO08jWImahxW9f7wYHqGKRXd6CCqk=;
 b=ZuHbhCVHQ5/Vbs7yHy20WY/2sODWYzCNxqrrUnPubbka9QwUiFyRa5t8+3IPkBYYn3
 6cU6EiIT/p7UoDbDYuw1+r7PXsDGq5eJeAXOsx/6e0StGgxj9xZ+9F1TuyRHkkkdUX0C
 m/HlkmP68kTOLdp64++soEzCWGFZ26LYRVWCd/UYlYmdfU7c+2lb0YjKC8VBQ0mVWCZM
 s0IHFJgxDRXU7bDCV13nK+I4Kru/sdZep1qCGtmsXOIj0hpMYrAZzo/MmoxNUN/+W1cE
 7kPReEeqtU53/7zapaXILjNjwWBbzyoc7OFg4JaOPnAX8NqB8kCimdqYsYn/b5PuNjNL
 XwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=++Gb2lBFkve8gSRO08jWImahxW9f7wYHqGKRXd6CCqk=;
 b=mKia+Jn7Yf9dre9IUjRZpAlaidBipJ3tkAiA/S8P+ArawkYCz4v/P36PzA6v/n/BaW
 dvSKugRyRZG6gu4ULXfhR+HQDcs5dywOVAK6AuK0OKQRP+hubzksw0BDH3S2o3fQGM3X
 GhZcSxcVSro5WR/D9yS7zYVYNkQA0iJ6KMyVbvAhcesAZxaIHr57NDnMxPMYNGUgjKbL
 3hdsam6mbRINba4oF/tr5vGSGeLT1BV4PdrnTYsKnda7zY/vOy7qRvcfjhE5tzsxsX31
 DhQ+MsXKcQF15TX6MnXcWRXHa/DcWTgbE1WZbgJLYD93ir64Fr+th3hVsIYzXkVQFsee
 Mswg==
X-Gm-Message-State: ANoB5pk0mUKpomSQXPslsB8WOAbP2uJbQJK/5pFJs6fLnSFHeEPIDEqD
 ziA2M76XhAVin481VPl50YglzQ==
X-Google-Smtp-Source: AA0mqf7D7DAodYs9+5h6TcqKnXht2atiHA5k/DDBcqIQMB3KebGhmUBUJ4B+4Xk+WZxsnbHSN1jOLw==
X-Received: by 2002:a17:902:f64b:b0:186:de2c:97e3 with SMTP id
 m11-20020a170902f64b00b00186de2c97e3mr23744609plg.54.1671015405704; 
 Wed, 14 Dec 2022 02:56:45 -0800 (PST)
Received: from localhost ([122.172.87.149]) by smtp.gmail.com with ESMTPSA id
 d22-20020a63fd16000000b00439c6a4e1ccsm8163703pgh.62.2022.12.14.02.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Dec 2022 02:56:44 -0800 (PST)
Date: Wed, 14 Dec 2022 16:26:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Wolfram Sang <wsa@kernel.org>, mst@redhat.com, asowang@redhat.com,
 Conghui <conghui.chen@intel.com>, linux-i2c@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jian Jun Chen <jian.jun.chen@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer list for virtio i2c
Message-ID: <20221214105642.3xagckvbbgu5mubl@vireshk-i7>
References: <20221214053631.3225164-1-conghui.chen@intel.com>
 <20221214063107.fazrfq3n26hw4ndl@vireshk-i7>
 <Y5mjcuCRP45ynJis@shikoro>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5mjcuCRP45ynJis@shikoro>
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

On 14-12-22, 11:20, Wolfram Sang wrote:
> Dunno if this is really a rule, but if a maintainer steps out and makes
> sure there is someone to pick up the work, this is more than welcome.
> Way better than a stale entry in the MAINTAINERS file.

Sure, a stale entry is always bad.

> I mean, it does not limit the chance to have further maintainers, for
> example. I believe in meritocracy here. Those who do and collaborate,
> shall get responsibility. If not, then not. We can fix this, too, if
> needed.
> 
> What is the reason for your question?

It was a general question that I asked myself and didn't know an
answer to. I wasn't sure if adding someone to be a maintainer here to
a driver, which they haven't contributed to until now (at least based
on open source commits), is right or not, since this isn't a stale
entry in MAINTAINERS anyway.

An entry as R: would be okay normally IMO, as this makes sure
interested party is kept aware of the development in the area. An M:
entry somehow gives a higher level of authority to the person and
without any prior contributions, it feels tricky at least.

Anyway, I don't have any objection to the patch at least as it was
primarily developed by Intel engineers.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
