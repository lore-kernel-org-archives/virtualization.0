Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAC5C07E95
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 14:03:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7488461279
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 14:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7488461279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 398B64030A;
	Tue, 13 Jul 2021 14:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mYwsQ3WBZuOv; Tue, 13 Jul 2021 14:03:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F7DE4034C;
	Tue, 13 Jul 2021 14:03:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73BB8C0010;
	Tue, 13 Jul 2021 14:03:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50333C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 14:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F696402E5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 14:03:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BtoTZrO5T4tZ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 14:03:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com
 [209.85.166.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 64548400E0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 14:03:30 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id y6so22180508ilj.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 07:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=W0tPxTxBFqwVjrERv5yBUzJYH1KOoxA14jOPXeTsapQ=;
 b=Qk+HJ5m4TQ+BMbB2sY4AtvNlW20WbAZZ8HcAF+BIqX+1+ZeOlBU+Ohw39U2eLsKRf+
 IFMEtXUHRy/lSTMwMDnuADz1o+cv/O+LwcpLDQj0YTYvkG3pdMM9mz5szvTuQjuY3IT3
 3fBxOuaTQr0un0pN7Ww8c/zPwMPbQM2w2VKCZEl9KRSq+kbcV/rxjiK274JSISw+FMFe
 Q35fDc448oJkVjSVpjlQvL+9qSxE4s3iCWdKH87P3qxQMkKNkkBEIhgASuZROsGuxaRQ
 bqxlQ1mdxATHw9+dI1A5JdH1IAUCk1jHn0uQeG8XLtMnfeSKIg6iSglSeLlNF4XFXVsG
 72CA==
X-Gm-Message-State: AOAM530raKopDTro0xIYH7Fug4aHypvNAfHO1gp4YkLCOUvEqDzj3XkL
 5HqeGKiKg4FUEJW9aCLO7A==
X-Google-Smtp-Source: ABdhPJwtHCLdHMImB7FGf/LTlwtrd/GDrGn+A00ynbPDFQORtkdIz28oeNvQHmIoGkb0xe9e6AIBjQ==
X-Received: by 2002:a92:3f08:: with SMTP id m8mr2957950ila.104.1626185009476; 
 Tue, 13 Jul 2021 07:03:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id e14sm9527471ilc.47.2021.07.13.07.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 07:03:28 -0700 (PDT)
Received: (nullmailer pid 129715 invoked by uid 1000);
 Tue, 13 Jul 2021 14:03:13 -0000
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
In-Reply-To: <268086e273df0c53e3a9a1e751304c63e50ebe12.1626173013.git.viresh.kumar@linaro.org>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <268086e273df0c53e3a9a1e751304c63e50ebe12.1626173013.git.viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/5] dt-bindings: gpio: Add bindings for gpio-virtio
Date: Tue, 13 Jul 2021 08:03:13 -0600
Message-Id: <1626184993.671493.129714.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, linux-gpio@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Arnd Bergmann <arnd@kernel.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, Bill Mills <bill.mills@linaro.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 13 Jul 2021 16:20:34 +0530, Viresh Kumar wrote:
> gpio-virtio represents a virtio GPIO controller and this patch adds
> binding for the same. The gpio-virtio subnode can be part of a
> virtio,mmio node and is based on its binding.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Depends on:
> 
> https://lore.kernel.org/lkml/7c716c2eb7ace5b5a560d8502af93101dbb53d24.1626170146.git.viresh.kumar@linaro.org/
> ---
>  .../devicetree/bindings/gpio/gpio-virtio.yaml | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/virtio/mmio.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
Documentation/devicetree/bindings/gpio/gpio-virtio.example.dts:19:18: fatal error: dt-bindings/virtio/virtio_ids.h: No such file or directory
   19 |         #include <dt-bindings/virtio/virtio_ids.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/gpio/gpio-virtio.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1504545

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
