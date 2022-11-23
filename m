Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD5AC433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 01:36:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B103161184;
	Wed, 23 Nov 2022 01:36:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B103161184
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oUgfZGpf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JmJgLEQRnIkp; Wed, 23 Nov 2022 01:36:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 42A0861035;
	Wed, 23 Nov 2022 01:36:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42A0861035
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16D93C0033;
	Wed, 23 Nov 2022 01:36:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F0E5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:36:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D8EDE61035
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:36:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D8EDE61035
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uaDmqlbpiLVR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:36:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DA686117C
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2DA686117C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:36:15 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id q9so16012601pfg.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 17:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VnT85l1YGrgftRmY4cs0kf1GLdUSkFh5ZyBQMsB8/d8=;
 b=oUgfZGpfTt3n+gdaAcgz00Mug4dCBCNB/xDdXlVP+K6uV0glmqUHVVcqvQO8b0rrYS
 k3IzWT0SIbOyFZv/D/7QcoURlIYUwvOvNaTu7L+CZNAwJYt1nt0rIwdpZN55gZjFPVDI
 QJECxzixlHdMg1q1pT9qIYI9+GhiFa1fqTUgbMKyAYcqpJDuaoCiKXQVuUOwTk0jlTjZ
 3Uev4hAehD0PGurOWFjtKN6iyx6GnRSSpFJyRNen7Sb0J7XCDoK3YT/eXmH0m93Yr+Jz
 aTw2wWkj5t9YMQ8PpTDjD/+uILOjduYoHPN5Xsw8eSbyvQHXUtHPQgtQs1cq8HHs6mn/
 8jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnT85l1YGrgftRmY4cs0kf1GLdUSkFh5ZyBQMsB8/d8=;
 b=am8907WRkYW8iRkv8nyBk8lJBN1jS1rTkjinPcidBTApCwOU2x1CHRW7qY11BhPwug
 h6NSS3vYwW+TVI4DxdtTaD8aH7CWX6DIQ68xol2pffdl0lz+PSEoBz97y+AQblu4WcWR
 5/qN+sKGElY1BeOOx04K5Y5+AQRCBM4h29HunNRf870b0Hm1P/nQKUwv5izSxlI/HUPr
 RN7scuzog6bmSPiN67JqLXmDyK97sje5g755nww8I22gvoHWDPPmrGsvdbOnF6Ja8Yig
 ohQNcJB5cTQAu19ESF9aW1YpzXLgGR2PXGkv5z2zrXtc21t8CsIw9epqAMnu2ZOkfb2f
 jbSA==
X-Gm-Message-State: ANoB5pnnJSf5VnjNQ60cwXxXhxIATZJ1fwKUs8cxTIaf4DxOEyg4pqeK
 umxDKiWFq0JrXQcZEkfKm8Y=
X-Google-Smtp-Source: AA0mqf78pgAVtMq8pq+tCGwJHeM7QPMfI1EDDft+2+fSPKOuH2O4/vhP5xQpLF4Y0UoxHBvM5RyLQA==
X-Received: by 2002:a63:ff0b:0:b0:477:362d:85d3 with SMTP id
 k11-20020a63ff0b000000b00477362d85d3mr5493742pgi.395.1669167374414; 
 Tue, 22 Nov 2022 17:36:14 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:af8d:6047:29d5:446c])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170902b68500b00186b758c9fasm12680124pls.33.2022.11.22.17.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Nov 2022 17:36:13 -0800 (PST)
Date: Tue, 22 Nov 2022 17:36:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 7/9] dt-bindings: drop redundant part of title
 (beginning)
Message-ID: <Y315CQUTFYocBnfS@google.com>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221121110615.97962-8-krzysztof.kozlowski@linaro.org>
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

On Mon, Nov 21, 2022 at 12:06:13PM +0100, Krzysztof Kozlowski wrote:
>  Documentation/devicetree/bindings/input/gpio-keys.yaml          | 2 +-
>  Documentation/devicetree/bindings/input/microchip,cap11xx.yaml  | 2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
