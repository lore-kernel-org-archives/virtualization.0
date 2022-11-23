Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C91C433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 01:35:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C03061174;
	Wed, 23 Nov 2022 01:35:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C03061174
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=HP7scXWG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ieHVMHmqIVBi; Wed, 23 Nov 2022 01:35:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E024160AD8;
	Wed, 23 Nov 2022 01:35:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E024160AD8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B93FCC0033;
	Wed, 23 Nov 2022 01:35:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28481C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:35:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9B20820C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:35:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9B20820C3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=HP7scXWG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gdu5g4J5DvWZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:35:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A9D48206F
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A9D48206F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:35:35 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id w4so6539668plp.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 17:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aMXbvTa4szYt2+pP730kENx9BC6mONDNIAJzOhCO5eY=;
 b=HP7scXWGWUuUAQpBHAbYGT9Ro4FSzBvlteLDZXmRtKIZTW83yQz3QCmZa2e1V2+0x2
 Pw8YRUKvoQ4DiaSm/YAu6wmnyNScBLJZbD3KIrABeA6kImnOgusYWOUmR/kcS0XT8B9P
 1cL+hQNaxyuve1DQLJxDEdiV3tM0KQavM9pnRQl5dkjJUDRmOiJmgk/Snwqtq9fbneJ6
 501XaE1hYWbuRd4jlIvX1PvZl9pGuG5KgjbXC0nzOtGgAQfzAquf1FCtOSuDF4D8vTiR
 HsFLOv794pyzG5OBIwR2N/Q8Yj34VkSutSr3XEu/KkJ6LoDgNdzwSB8kRI/bCqRFYG1b
 9wQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMXbvTa4szYt2+pP730kENx9BC6mONDNIAJzOhCO5eY=;
 b=g/XXFqtcbWUw3gSAzRsf3NqwEMp3LVc7jRkOYxWKOzBoSybP7aQ50cA8hCnCOmLeis
 DOzAr/blZ2a7zGV81bWS7sGYaR1jsHlf8G551hDENQMiHxgIkSIzJSMANqR+Ayxu6Tva
 LVS8X3TaDcE0JLDxQ3O6vvD7JpIojvFBX016znfsNyJINZTcyfGHlyY7oMf0KdMh1H/o
 OHOOWoIRCsJbon52+bUDxTz8KiQv+0GjKopn5gR4mElpEGxPz96yqFnxzQCQxKnEE/nn
 PMzhMVMVQ4qZhQGii1vAsvh99i0JjDCPiMY78KUpkYtZE6NU+BPyEsJZfxajWL57hmis
 yUlQ==
X-Gm-Message-State: ANoB5pk24nfB+15KpAOvoSg69w6/qazrR3C9v4LaXxF37dXYsxzFoC26
 G2zzuSxKbyyMAvHI6tBA5+s=
X-Google-Smtp-Source: AA0mqf6x4fc4IKvIExC1o1e46QIsOPFQfVNfDh9OQF6vDoU8m9LQB2uyX84qmPAg+ZnqxdiG9ViVXg==
X-Received: by 2002:a17:902:f391:b0:186:ac81:2aa9 with SMTP id
 f17-20020a170902f39100b00186ac812aa9mr6832869ple.95.1669167334579; 
 Tue, 22 Nov 2022 17:35:34 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:af8d:6047:29d5:446c])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a17090abf8700b00218e5959bfbsm52591pjs.20.2022.11.22.17.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Nov 2022 17:35:33 -0800 (PST)
Date: Tue, 22 Nov 2022 17:35:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 6/9] dt-bindings: drop redundant part of title (end,
 part three)
Message-ID: <Y3144aAtCaejFDAC@google.com>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221121110615.97962-7-krzysztof.kozlowski@linaro.org>
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
 Rob Herring <robh+dt@kernel.org>, virtualization@lists.linux-foundation.org,
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

On Mon, Nov 21, 2022 at 12:06:12PM +0100, Krzysztof Kozlowski wrote:
>  .../bindings/input/touchscreen/cypress,cy8ctma140.yaml          | 2 +-
>  .../bindings/input/touchscreen/cypress,cy8ctma340.yaml          | 2 +-
>  .../devicetree/bindings/input/touchscreen/edt-ft5x06.yaml       | 2 +-
>  Documentation/devicetree/bindings/input/touchscreen/goodix.yaml | 2 +-
>  .../devicetree/bindings/input/touchscreen/himax,hx83112b.yaml   | 2 +-
>  .../devicetree/bindings/input/touchscreen/hycon,hy46xx.yaml     | 2 +-
>  .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml  | 2 +-
>  .../devicetree/bindings/input/touchscreen/melfas,mms114.yaml    | 2 +-
>  .../devicetree/bindings/input/touchscreen/mstar,msg2638.yaml    | 2 +-
>  .../devicetree/bindings/input/touchscreen/ti,tsc2005.yaml       | 2 +-
>  .../devicetree/bindings/input/touchscreen/touchscreen.yaml      | 2 +-
>  .../devicetree/bindings/input/touchscreen/zinitix,bt400.yaml    | 2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
