Return-Path: <SRS0=zOA3=LF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB9C48BD1
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 03:39:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0A16613C3
	for <virtualization@archiver.kernel.org>; Fri, 11 Jun 2021 03:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0A16613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9819F83B57;
	Fri, 11 Jun 2021 03:39:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0lx6Hk7RjS59; Fri, 11 Jun 2021 03:39:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4178883B56;
	Fri, 11 Jun 2021 03:39:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14078C000D;
	Fri, 11 Jun 2021 03:39:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEE4CC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 03:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 872B2401C5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 03:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OhMAw6W2fy3A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 03:39:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9728C400BF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 03:39:32 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id e7so2135095plj.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 20:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SxxbAF3jaVNlurlddu+dUL7InQzwoLHvI2QS6L1ZxjQ=;
 b=BpsBGYsc3slgoB7ffao6X7asqYsjp6NuzRTK9sRNfRDGAbKOJwOk07koFr9cSJgJ1C
 zS8/elLhYZqjTn0hueib/5CkQFqxhqrPifwrvceCqxnNzhyBJEiHX3W7ygy81esbwu5s
 376cXmfHLiodod8ml8ifkYZOjjUdjM40YhDqma+KYO8E+xQri7K0gPITGNhSAm3NzsNi
 8fCJZQhCwz7zmobOpFIGlF74GGeYtPKcp58AG0VXzkLrXtTYAdbCtB/Xwldi2L+WI9Wg
 50QyhP5Nenm9EFuqhKd+Ah5wMUf4Hzf2o/iiCGHwr3AgeHXvgqqNqbO+A9DDZfBiHpu2
 uUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SxxbAF3jaVNlurlddu+dUL7InQzwoLHvI2QS6L1ZxjQ=;
 b=Nt6Vb+jPI2GmMYi4LWvOsxe7Q/Oc/NPdF14xoRCqA47pQ16/rESX7Akfhbjp5pBf7C
 AWxFsSfoGPfUrT28EN8OC8+nSIKw0g50RTg4MbIBMckLPHj9canbIMvOinqFnxhbHm2E
 shItjlZkwP2+zYrd5sWSd8HZg6tYOPAkwICjz0XNVJawMJ5bd6bB5XbGPhtTBEnn6mUR
 BPlLhNt9TIJ6yHNT4hBCQ9IeZtV5V9V5aqegTc8MGWqzbJypOTHHYTSp6jLeA3Tr7eKM
 e/REuyY6NrfLyxO3JgUYEwTx0VZPmC61rwJMUm/kpTRYXWttciWMfZ6e1Oj9CYEZ3Us3
 fabw==
X-Gm-Message-State: AOAM530zSqsFo/XToIKDc7lUH0Mv8ob3EbIW7LrfLyrgAwKf5E9b4d/O
 6JvTZ7l9gHIasK8lm79BL9lTCQ==
X-Google-Smtp-Source: ABdhPJyAC6rOPaOUyj6eu7wayFUFCspO1bzWLoCbHm6Ga4Glw+eFx85c6mzvlktHCLQ6inn1YqD6Dw==
X-Received: by 2002:a17:902:8e88:b029:ee:b947:d7df with SMTP id
 bg8-20020a1709028e88b02900eeb947d7dfmr1954566plb.48.1623382771923; 
 Thu, 10 Jun 2021 20:39:31 -0700 (PDT)
Received: from localhost ([136.185.134.182])
 by smtp.gmail.com with ESMTPSA id p11sm1342742pjj.43.2021.06.10.20.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 20:39:31 -0700 (PDT)
Date: Fri, 11 Jun 2021 09:09:29 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH V3 1/3] gpio: Add virtio-gpio driver
Message-ID: <20210611033929.ifnafw2gznjklnq2@vireshk-i7>
References: <cover.1623326176.git.viresh.kumar@linaro.org>
 <01000179f5da7763-2ea817c6-e176-423a-952e-de02443f71e2-000000@email.amazonses.com>
 <YMJOk6RWuztRNBXO@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YMJOk6RWuztRNBXO@myrica>
User-Agent: NeoMutt/20180716-391-311a52
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <vireshk@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-gpio@vger.kernel.org,
 stratos-dev@op-lists.linaro.org, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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

On 10-06-21, 19:40, Jean-Philippe Brucker wrote:
> On Thu, Jun 10, 2021 at 12:16:46PM +0000, Viresh Kumar via Stratos-dev wrote:

Fixed everything else you suggested.

> > +struct virtio_gpio_config {
> > +	char name[32];
> > +	__u16 ngpio;
> > +	__u16 padding;
> > +	__u32 gpio_names_size;
> > +	char gpio_names[0];
> 
> A variable-size array here will make it very difficult to append new
> fields to virtio_gpio_config, when adding new features to the device. (New
> fields cannot be inserted in between, since older drivers will expect
> existing fields at a specific offset.)

Yes, I thought about that earlier and though maybe we will be able to
play with that using the virtio-features, I mean a different layout of
config structure if we really need to add a field in config, based on
the feature flag.

> You could replace it with a reference to the string array, for example
> "__u16 gpio_names_offset" declaring the offset between the beginning of
> device-specific config and the string array.

But, I like this idea more and it does make it very flexible. Will
adapt to it.

> The 'name' field could also be indirect to avoid setting a fixed
> 32-char size, but that's not as important.

Yeah, 32 bytes is really enough. One won't be able to make any sense
out of a bigger name anyway :)

> > +} __packed;
> 
> No need for __packed, because the fields are naturally aligned (as
> required by the virtio spec)

Yeah, I know, but I tend to add that for structures which aren't very
simple (like the request/response ones), just to avoid human errors
and hours of debugging someone need to go through. __packed won't harm
at least :)

-- 
viresh
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
