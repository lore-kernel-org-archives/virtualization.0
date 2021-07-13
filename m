Return-Path: <SRS0=VeF6=MF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FE3C07E95
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 14:03:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FDD61279
	for <virtualization@archiver.kernel.org>; Tue, 13 Jul 2021 14:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FDD61279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB180606B8;
	Tue, 13 Jul 2021 14:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8t07RrEcjSt3; Tue, 13 Jul 2021 14:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 542EA60839;
	Tue, 13 Jul 2021 14:03:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39ADCC0010;
	Tue, 13 Jul 2021 14:03:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEA1EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 14:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF1E7400B9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 14:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NisG8ABdWwgY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 14:03:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CD3340242
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 14:03:23 +0000 (UTC)
Received: by mail-il1-f179.google.com with SMTP id y6so22180062ilj.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 07:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=rrdiKpMGTcNX/oecvUxIZ+HcSY5J/MLTnT7FsikOG0g=;
 b=OSX7qc/gak0igEjgEkOCc/+dw5Xv6aG2HK/jPVBtRixV9F0c3KmO1gjL05kW2c6fJo
 okxLzUpUz8/97Hqo02t6EgCjGOiC3Qn+4bA1gSmBed8KqeIzSOqatkmMeZ02OeqS8D0n
 RA4qMRq6+bHgFfcJTNENVcGIsCQOoWg7ySHSYUOjpLGjprLXTzWuMPmKXFpZXoYDy0FI
 nKch6lgn+ID39HQStFa8iXkcX9bOq8vXA/2yrVkMuh1GhV2qW2Y8BvQyE5IQKYIEefcS
 gNxbAFAXm8O2qTUYf8AQ072Mo9YU2BcRu1GRShL+3CIM9NYMj0pOZ1GSw6Qp6hZRYerV
 diFA==
X-Gm-Message-State: AOAM531DOfH5dJ2i6YEGAeFOFabU4S3P6hg0Lh0YBJmkrrJ6rr4OLw27
 2wyUAoE+z2wfUbRXHOkJ9Q==
X-Google-Smtp-Source: ABdhPJzonXO+4ZfWz8P78P+ikyRaaY9YHUrrlWmavAu+ibX9HKMQRFdOhnXkLxc2XaT8jK4JxU+Blw==
X-Received: by 2002:a92:a30d:: with SMTP id a13mr3116852ili.236.1626185003183; 
 Tue, 13 Jul 2021 07:03:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id r16sm4229865iln.30.2021.07.13.07.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 07:03:22 -0700 (PDT)
Received: (nullmailer pid 129713 invoked by uid 1000);
 Tue, 13 Jul 2021 14:03:13 -0000
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
In-Reply-To: <e650cecb3bc6a0ed16eb37460ac57cb191ba92e4.1626173013.git.viresh.kumar@linaro.org>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <e650cecb3bc6a0ed16eb37460ac57cb191ba92e4.1626173013.git.viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/5] dt-bindings: i2c: Add bindings for i2c-virtio
Date: Tue, 13 Jul 2021 08:03:13 -0600
Message-Id: <1626184993.664261.129712.nullmailer@robh.at.kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Wolfram Sang <wsa@kernel.org>,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-i2c@vger.kernel.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Bill Mills <bill.mills@linaro.org>
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

On Tue, 13 Jul 2021 16:20:32 +0530, Viresh Kumar wrote:
> i2c-virtio represents a virtio I2C device and this patch adds binding
> for the same. The i2c-virtio subnode can be part of a virtio,mmio node
> and is based on its binding.
> 
> Cc: Wolfram Sang <wsa@kernel.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/i2c/i2c-virtio.yaml   | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Unknown file referenced: [Errno 2] No such file or directory: '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/virtio/mmio.yaml'
xargs: dt-doc-validate: exited with status 255; aborting
Documentation/devicetree/bindings/i2c/i2c-virtio.example.dts:19:18: fatal error: dt-bindings/virtio/virtio_ids.h: No such file or directory
   19 |         #include <dt-bindings/virtio/virtio_ids.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/i2c/i2c-virtio.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1504542

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
