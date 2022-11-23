Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C874CC433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 01:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B18841955;
	Wed, 23 Nov 2022 01:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B18841955
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=AJd4p4Y1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9geXZNWSI2qr; Wed, 23 Nov 2022 01:37:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C0A34194B;
	Wed, 23 Nov 2022 01:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C0A34194B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74729C0033;
	Wed, 23 Nov 2022 01:37:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8287DC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:37:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4C1E44194E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:37:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C1E44194E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ANRHPnL2vX-s
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:37:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8BAD74194B
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8BAD74194B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 01:37:23 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id 83so317383pfy.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Nov 2022 17:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=57QTDQNjua4bD17eBQRGR4QYAKmDZiaeZv3y3ThjHNA=;
 b=AJd4p4Y1GJ2PPHHqMJkt2vAn6ERqJlfv48oiJrZolP8/Sh1CAzdLzBPA6Y9SygNMOB
 ZL09xzKfYY7O9Doh92VB3jb6Ja8HBaQeBTEaB8nC72ZjmyawK/usRw5XgujG3BFx/tAa
 YQzpVS/GviFMu850709iF5BIFlEAro2HnvijgpS0DgkaoVdPf+crlJ8hgf6xE8Hefq+w
 79hHmd2FIBoMnyNG0wJ0UGHjyN8DYJcXF/xPRlPXnE/3S7V0L3QNV1H73/xPNO9zBSaj
 Pg4w7ZIQmKiJxfxA9pfQlebDCPWdCV3XIz9WLiDa5A8wWXQqx8dPEJlxFOfUf9f5WHlm
 xytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57QTDQNjua4bD17eBQRGR4QYAKmDZiaeZv3y3ThjHNA=;
 b=z/TvWmE2zPmrC4SpQVLFr+t5IZRdakwkpcrB2mvDOiqny3d1TdgtzHIyKBWemA21+g
 meIf4SxCEoJshsB3qrzpJqXeoK5cN5/tR4d7ddMcyX/wR6xJbV4tF7SiuflAfr4mC3Zp
 03w6L9YwqH5ywESg3264YP8zS70PP21h31jp+7cD8/+gFcbP9VRwxXsXM5CDLelYlDy7
 eBoc/xtwLSFaGcQw8tQvdZujexefYspuOEp6Xm3YuTI5erioVguvj5YOO3T44zmgK2H9
 tnvDDMN0vc8cxd5/hq+WNBs0odZCrW8gAutLptWbMjGhXKAGRADySLs70BXxUIFTQkpz
 cxGA==
X-Gm-Message-State: ANoB5pncuip8v37Cqeryc12znUAvyVn2imZHLSfx0Bdsqwh3ZcPV7hKN
 8qKYJ7jv0sX6fg+2gn0Kkdg=
X-Google-Smtp-Source: AA0mqf547JrxZeSVmkQLdlrpalzLSYM74m3LOUHFPzZ3vcYEWkifg+t/S5X1eHUvslK9HNQURfIwrg==
X-Received: by 2002:a63:de14:0:b0:477:4a61:eb99 with SMTP id
 f20-20020a63de14000000b004774a61eb99mr16322572pgg.48.1669167442801; 
 Tue, 22 Nov 2022 17:37:22 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:af8d:6047:29d5:446c])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a17090a674400b002189ab866bfsm204545pjm.5.2022.11.22.17.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Nov 2022 17:37:22 -0800 (PST)
Date: Tue, 22 Nov 2022 17:37:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 9/9] dt-bindings: drop redundant part of title (manual)
Message-ID: <Y315Ta+ST067iVmh@google.com>
References: <20221121110615.97962-1-krzysztof.kozlowski@linaro.org>
 <20221121110615.97962-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221121110615.97962-10-krzysztof.kozlowski@linaro.org>
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

On Mon, Nov 21, 2022 at 12:06:15PM +0100, Krzysztof Kozlowski wrote:
>  Documentation/devicetree/bindings/input/fsl,scu-key.yaml        | 2 +-
>  Documentation/devicetree/bindings/input/matrix-keymap.yaml      | 2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
