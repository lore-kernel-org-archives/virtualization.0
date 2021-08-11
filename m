Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54728C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 05:39:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB76260E09
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 05:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB76260E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A49BD831F8;
	Wed, 11 Aug 2021 05:39:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kqV9D9zRbN7Q; Wed, 11 Aug 2021 05:39:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E5C182C33;
	Wed, 11 Aug 2021 05:39:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8DEAC001A;
	Wed, 11 Aug 2021 05:39:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78BE1C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 05:39:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7554D404A5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 05:39:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1MkEYT6KcaER
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 05:38:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9567D40435
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 05:38:57 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 w13-20020a17090aea0db029017897a5f7bcso2856563pjy.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 22:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=9C16aGrQd4DbmatTkdrN+5r9o60LDqyKnHni66oi5yA=;
 b=ay0Z1NCDG8WPAn0RRxsixr6dpvr8p3y035Y6DM7CKPLF66XtxVf/sGr/q2+7hVyGVL
 xcflIio6ixnfRRGtcl/5KkgLtZOB7FIEkp1fyih99x8YgYKnxcwd4L96wIA66wTHDsS6
 De+km3kdPeHefFd9x6AgF1K79DBr4IUgdVRzH6rJTP0gfnRgWkwSaUCSdvIsdz0pE29k
 Or/CuxzYPn3vrRDz3/rr4lIpxBYsK1B96T2ed09VcExRXsLwDGAfGQu9RLou53lMuYy+
 mDzGmi1oL4rp6XLd3heku9vLzLtzx9jnhtzCLTovxxPd6wZpbQxYW6reVTjUdWqNGGVL
 6/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9C16aGrQd4DbmatTkdrN+5r9o60LDqyKnHni66oi5yA=;
 b=fAiUY+uPHJZ6Hej9pTP7zs4nrCNN2AsrXJnjgJ4LjTwRAMMGABa45vF2uH6x3tFntZ
 HAs6xL4VGr2xUoJhUQDvpHOvSckFzFlt1UqlZ6S3ucCss+PnzudxqMbdG0cofHvPBnod
 Aa6rcBIEJE9tZRfra+PrsWwWj51NsJiRyPm0+WCKb6qIfa7HC517kCb2a3koOtN75Ngt
 QTXJu1qJETvep6rmZoleTjeT75r+X2smCT9wP9KZdfgAFMTJ0JWiMwFVLgIeaXqJ7Fod
 Tpk+EmR4mz3Bmcc4OokUregUfKfj8wt0JkpMXIq81hcPKvPlC51EpV79qG1rj+2AYKE4
 F5sg==
X-Gm-Message-State: AOAM533Xf9Jw4eboRWtsVLW/BbkJL4HXKkYrrpKaVbL8Nc+MWTDKAqqY
 dGnW50IRK5HSEtsry3BsGecvUA==
X-Google-Smtp-Source: ABdhPJz670d+mhV5NHPn4IBMMT7nwf5ci7sI0cLkCTuYIabeyKuBFTWpGjH65c1d6erAUk37z2/Zog==
X-Received: by 2002:a17:902:9897:b029:12d:17ac:3d40 with SMTP id
 s23-20020a1709029897b029012d17ac3d40mr14926473plp.67.1628660336982; 
 Tue, 10 Aug 2021 22:38:56 -0700 (PDT)
Received: from localhost ([122.172.201.85])
 by smtp.gmail.com with ESMTPSA id o9sm27927871pfh.217.2021.08.10.22.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Aug 2021 22:38:56 -0700 (PDT)
Date: Wed, 11 Aug 2021 11:08:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V4 0/5] virtio: Add virtio-device bindings
Message-ID: <20210811053854.37uf55p62r525ees@vireshk-i7>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <20210804035623.flacrogemvjina3o@vireshk-i7>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210804035623.flacrogemvjina3o@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, linux-gpio@vger.kernel.org,
 linux-i2c@vger.kernel.org, "Enrico Weigelt, metux IT consult" <info@metux.net>
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

On 04-08-21, 09:26, Viresh Kumar wrote:
> Michael,
> 
> I hope you will be picking this series (Now that it is reviewed by
> others) ? Just so you know, Wolfram needs the 4th patch, 4/5, to base
> the virtio-i2c driver over it and has requested an immutable branch
> for the same.

Michael, we need an immutable branch with the following patch:

  uapi: virtio_ids: Sync ids with specification

This will enable Wolfram to apply the I2C driver for 5.15-rc1 and
maybe Linus as well for the GPIO driver.

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
