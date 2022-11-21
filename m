Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2735BC433FE
	for <virtualization@archiver.kernel.org>; Mon, 21 Nov 2022 13:33:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F6C4605AF;
	Mon, 21 Nov 2022 13:33:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F6C4605AF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lvV3Qxg-E2rR; Mon, 21 Nov 2022 13:33:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0430F605B1;
	Mon, 21 Nov 2022 13:33:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0430F605B1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA244C0032;
	Mon, 21 Nov 2022 13:33:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9BB3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 13:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 784EA605B1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 13:33:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 784EA605B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6mqoX9PN0BaY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 13:33:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E14F605AF
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E14F605AF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 13:33:26 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id e15so7213727qts.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 05:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W52hjy2XgXbLvoau/TZhYUdh0mFs9ky77EejBWrKJL0=;
 b=VMZ4iR9bya0QXe6ERMR6mHHHNri/8iICX1mErHH98K0STLuxaZG8+miB2IJrT63Z4C
 G13kgKOUotzxMz3JcaqzfW2PnljYrY2SPPyoYuCOtteWiXhNkm4H8zZyDIgbMfbzUQwv
 ME9Am/A8VwKTfuK8wEF9ckb4ioz+/0uXgmDKTqVTlQTrCsgkqsKOtdRcYO+C5TEzk3bO
 iWhjjw/4kjRncdnxk9RwSHHRFiIcerm4x/g5KnAygZ4bYz+9pI0eAGODseKbVKDcgvDF
 plGwvAn1am+bEBt3E2Q5I/mrD6n5XHr/H67sqn604K/8cghFpRliJPBD/9ozJKHL6OVA
 pbag==
X-Gm-Message-State: ANoB5pkS1TRQ60luvClZSITQs3y77SAyxWw7OgFwkp9weWQJKcJUCD2j
 IuwnnXdhtxyb66k26wj2PiwQ2YhIDTHFYg==
X-Google-Smtp-Source: AA0mqf6g5wUQyd7N9uWd8Qe+dXqdyFdZ3rg3k7hQ3k4UbjT+cJT4cuuVyT8Gj+nd9/qM2Y7xJGdODw==
X-Received: by 2002:ac8:687:0:b0:3a5:41fd:2216 with SMTP id
 f7-20020ac80687000000b003a541fd2216mr17743460qth.338.1669037605121; 
 Mon, 21 Nov 2022 05:33:25 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com.
 [209.85.128.170]) by smtp.gmail.com with ESMTPSA id
 cf11-20020a05622a400b00b0039ee562799csm6594272qtb.59.2022.11.21.05.33.23
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Nov 2022 05:33:23 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-39e61d2087dso37925477b3.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Nov 2022 05:33:23 -0800 (PST)
X-Received: by 2002:a81:4f4c:0:b0:357:66a5:bb25 with SMTP id
 d73-20020a814f4c000000b0035766a5bb25mr17212924ywb.383.1669037603130; Mon, 21
 Nov 2022 05:33:23 -0800 (PST)
MIME-Version: 1.0
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-8-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121110615.97962-8-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Nov 2022 14:33:11 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUtT3=F-3XLb604VUvKxNQBWK1y0rMnMn0kASKjQGw=3g@mail.gmail.com>
Message-ID: <CAMuHMdUtT3=F-3XLb604VUvKxNQBWK1y0rMnMn0kASKjQGw=3g@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] dt-bindings: drop redundant part of title
 (beginning)
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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

On Mon, Nov 21, 2022 at 12:09 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> The Devicetree bindings document does not have to say in the title that
> it is a "Devicetree binding", but instead just describe the hardware.
>
> Drop beginning "Devicetree bindings" in various forms:
>
>   find Documentation/devicetree/bindings/ -type f -name '*.yaml' \
>     -exec sed -i -e 's/^title: [dD]evice[ -]\?[tT]ree [bB]indings\? for \([tT]he \)\?\(.*\)$/title: \u\2/' {} \;
>
>   find Documentation/devicetree/bindings/ -type f -name '*.yaml' \
>     -exec sed -i -e 's/^title: [bB]indings\? for \([tT]he \)\?\(.*\)$/title: \u\2/' {} \;
>
>   find Documentation/devicetree/bindings/ -type f -name '*.yaml' \
>     -exec sed -i -e 's/^title: [dD][tT] [bB]indings\? for \([tT]he \)\?\(.*\)$/title: \u\2/' {} \;
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  .../devicetree/bindings/interrupt-controller/renesas,irqc.yaml  | 2 +-

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
