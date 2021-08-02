Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730C6C432BE
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 19:41:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E2AB60E09
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 19:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E2AB60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08A918354B;
	Mon,  2 Aug 2021 19:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3QiY4c6Z2U51; Mon,  2 Aug 2021 19:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C27AA83547;
	Mon,  2 Aug 2021 19:41:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E7A4C0010;
	Mon,  2 Aug 2021 19:41:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5769EC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46C876066F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yPhyYHvaS4WQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:41:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 237AF605BB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:41:17 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id h18so17496702ilc.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 12:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=t22Mw5fsW12nTc3NS3Ax8f5t27g1cdS7MTqs7qAg1c4=;
 b=OTudMjAIUXhJsAWWsyQ1M5k04UufNHasypKpCUi72nX4xxoj2gWwp8g05xyJVxL8WJ
 HODmZpjUCi1rtp1tVJhpuIybXBIWrxZLhcnL04zadXOFO6/asXfIDZWSPL7vGo4Zog3w
 yhTZ3diCDdMm5irxnWshtQVbfm1/XRJ3wo9YVS2TKaFQKyOV6Z/nPujjTI+D+vsx/W2V
 nqGOzmoIYd7A8oi7sKdLRFA96Zae0LB6uhmOwsmLMPKxYz/oVPU/FKpIbvhhKWpZHx9B
 +dACYdhdVEk6tU8K9ElIJXpw89pghk2zS2c6dwhroJfkcO4/xCKPuS/v3w7mjoNT/7aX
 yEFA==
X-Gm-Message-State: AOAM530cty0fRkIq4JWpnQxYij+H+TvnmQ15VbfK+SCO1Ko6/YJjPU63
 xo1FdbxWI99cEpkrrCqANQ==
X-Google-Smtp-Source: ABdhPJx6dao4W2VJ96dqV2lg5KOP4zvTBc3DlEOFZP3Xa1KIf1LuX/EUnSG2QPx1ZEyoHnPPXAb+hg==
X-Received: by 2002:a92:d451:: with SMTP id r17mr1650251ilm.109.1627933276312; 
 Mon, 02 Aug 2021 12:41:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id z11sm7545105ioh.14.2021.08.02.12.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 12:41:15 -0700 (PDT)
Received: (nullmailer pid 1476648 invoked by uid 1000);
 Mon, 02 Aug 2021 19:41:13 -0000
Date: Mon, 2 Aug 2021 13:41:13 -0600
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 2/5] dt-bindings: i2c: Add bindings for i2c-virtio
Message-ID: <YQhKWWi1g+nqSAqX@robh.at.kernel.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <33c317b95097ce491845c697db1e8285e3ec1d41.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33c317b95097ce491845c697db1e8285e3ec1d41.1627362340.git.viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
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

On Tue, 27 Jul 2021 10:53:49 +0530, Viresh Kumar wrote:
> This patch adds binding for virtio I2C device, it is based on
> virtio-device bindings.
> 
> Acked-by: Wolfram Sang <wsa@kernel.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/i2c/i2c-virtio.yaml   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
