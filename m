Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CF1C433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 01:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32725414C5;
	Wed, 23 Nov 2022 01:34:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 32725414C5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=hm7Jpy1q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u5bl6GuI6efU; Wed, 23 Nov 2022 01:34:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 95371414EA;
	Wed, 23 Nov 2022 01:34:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95371414EA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C696C0033;
	Wed, 23 Nov 2022 01:34:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7B0EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E8A740BBC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:34:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E8A740BBC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=hm7Jpy1q
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HfRLgnkvQNkO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:34:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4A9240105
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D4A9240105
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:34:14 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id 130so15540684pgc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 17:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0o+4E907Zvvy6ni+QZQIz8xU1g4Q1COgvbgTOREnlPc=;
 b=hm7Jpy1qREkOXLdAWvAMk4d1oXJ4z39uVk6vVyHKQn0eiACmSjnmVu7+6OjCgem/Nj
 kIC38x4waRshCgVXkata3W3e+zYStDSXXa+t5TCqFTf+YGEaJ0BXaE2iJ5CtShcple2O
 iwGh1BBp3Yhs+WBZuM41+XKvZLKvIQ57B1cHClHhYA/rIet45eATH+Q1t1VffM+nGEC/
 NDtdh2cBSDnIS/UrQQME9RN7DUtHUWpEEKXZ/b0KvJ1Jm7ZGdb8CejVl0zVYrURNmyZV
 oz7vGFvTG3kFnf0zzHDMzJrbdT1rboYq6lrpnWNVWFdZLGnPVJ5ugRoImnF/aGQwpm7m
 jIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0o+4E907Zvvy6ni+QZQIz8xU1g4Q1COgvbgTOREnlPc=;
 b=7d65mCenWET87uNXIDXxJxwMEaRlpPTyFaZnD6I0RLTRWAqAUbKGZwxWETxHiEaGMt
 XZshP7lUsi0mgSfOGpD3+1fi0W/E4AlTCVAPNTIGlRmAPcicHKEduR8regbDEKDicr7s
 pRolNiyUlP5cPz20p11GYnSrKKkPMn38bp+q1UJ3oe+6oxesGDpwnxRUXtHiUnokTQnV
 B7WRG4LZVN867vzwa4kOoVfX4NaXVJNZmnpyzPFcs0dxhLILoh2u14MaqYHsUeOF2fXj
 q3TG53Z4bZ+yYiZTS1DM5YHH/W8t5/ZuMYTRa8soWXepcFglsPPK+KS325a/dInAGk8o
 lqow==
X-Gm-Message-State: ANoB5plm9/xnyOGXBykuVWaJ62QVEjrVR1txr75uc8cNb/bX9jCBJIOG
 m8kGKL8znWaWM6VOFV7LYJE=
X-Google-Smtp-Source: AA0mqf4fIComKK9aDbVNdnJistSL4pHYNFA0hnYz4EKVMEmSoZO0zdR4co1U6hu9d1BpJRYGfXKZAA==
X-Received: by 2002:a63:f00d:0:b0:458:f364:b00e with SMTP id
 k13-20020a63f00d000000b00458f364b00emr7084885pgh.577.1669167254077; 
 Tue, 22 Nov 2022 17:34:14 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:af8d:6047:29d5:446c])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a170902684600b001892af9472esm4174053pln.261.2022.11.22.17.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Nov 2022 17:34:13 -0800 (PST)
Date: Tue, 22 Nov 2022 17:34:08 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 4/9] dt-bindings: drop redundant part of title (end)
Message-ID: <Y314kIVvP+p2RIzp@google.com>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221121110615.97962-5-krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, linux-riscv@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-rtc@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
 linux-serial@vger.kernel.org, linux-input@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 virtualization@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Jonathan Cameron <jic23@kernel.org>
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

On Mon, Nov 21, 2022 at 12:06:10PM +0100, Krzysztof Kozlowski wrote:
>  .../devicetree/bindings/input/pine64,pinephone-keyboard.yaml    | 2 +-
>  .../devicetree/bindings/input/touchscreen/chipone,icn8318.yaml  | 2 +-
>  .../devicetree/bindings/input/touchscreen/pixcir,pixcir_ts.yaml | 2 +-
>  .../devicetree/bindings/input/touchscreen/silead,gsl1680.yaml   | 2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
