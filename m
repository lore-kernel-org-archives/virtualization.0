Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4612C636CC
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 18:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6A0D140AB5;
	Tue,  7 Feb 2023 18:35:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A0D140AB5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kiLhY6Xcyx06; Tue,  7 Feb 2023 18:35:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E901140A8E;
	Tue,  7 Feb 2023 18:35:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E901140A8E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6FDAC0032;
	Tue,  7 Feb 2023 18:35:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DAE7C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 18:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1FE2660D89
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 18:35:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FE2660D89
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bO3CaJhXUPCv
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 18:35:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BC1260BB1
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7BC1260BB1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 18:35:00 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 y81-20020a4a4554000000b0051a7cd153ddso730018ooa.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 10:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lmUJZFRlbRzZC0YLBDimsvsgtraFo5ZlVa8PFNVIqis=;
 b=RlJy4eiGWv1MU3l3zrUffmwQjNCcqo+SG8Lr9a22EWQP6y2oeg/CmOgY370U+AOk4C
 NKB0Xxaqt740hiOFXhzLjp0ryXNxB1T5NBZXquEaWdIevmXu5KKoJWyl3G1/wUn720qw
 oH5Gog3sE3s2hXM8+HWsAgu3a/tsNMB1oF+IjM9t1N4vcuQxbVovSFI89WYzqbbdM+Sb
 GZN6QAm83v6okpQo/4duwVr6GEY/Y+JsYRHsCSY8J+Z+S8sPWo5n7WAuRP0hQmRzn0y+
 oxSctax7pT/P/+r7NxkW3CaoacWXfpnh5eCJ9dx9eLGNFdh8gcOt4j/EEAM+5WCamJC8
 Wigw==
X-Gm-Message-State: AO0yUKUszuPvS8PEEpj5Yztxvce8uto/fT5BOnb215Vhnk9+PbNk1F9f
 +sEdV8xIuX2iBB2ZfOwPqg==
X-Google-Smtp-Source: AK7set8WYI0yMhZcAyVDo98cgFXsIl818m7fxZKDYCkOjHC0+0s2Z/ySRz0St+Ru1mLcVsJ+Zcp8yg==
X-Received: by 2002:a05:6820:502:b0:4ff:4687:dc6c with SMTP id
 m2-20020a056820050200b004ff4687dc6cmr2789900ooj.0.1675794899461; 
 Tue, 07 Feb 2023 10:34:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 d18-20020a4aa592000000b005176974faf3sm6330919oom.35.2023.02.07.10.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Feb 2023 10:34:59 -0800 (PST)
Received: (nullmailer pid 3944512 invoked by uid 1000);
 Tue, 07 Feb 2023 18:34:58 -0000
Date: Tue, 7 Feb 2023 12:34:58 -0600
From: Rob Herring <robh@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v4 5/6] dt-bindings: hypervisor: VMBus
Message-ID: <20230207183458.GA3753062-robh@kernel.org>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
 <1675756199-5917-6-git-send-email-ssengar@linux.microsoft.com>
 <167577470818.3213850.12635304061765127789.robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <167577470818.3213850.12635304061765127789.robh@kernel.org>
Cc: devicetree@vger.kernel.org, wei.liu@kernel.org, ssengar@microsoft.com,
 linux-kernel@vger.kernel.org, haiyangz@microsoft.com,
 daniel.lezcano@linaro.org, decui@microsoft.com, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, dphadke@linux.microsoft.com,
 krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de, mikelley@microsoft.com
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

On Tue, Feb 07, 2023 at 07:00:23AM -0600, Rob Herring wrote:
> 
> On Mon, 06 Feb 2023 23:49:58 -0800, Saurabh Sengar wrote:
> > Add dt-bindings for Hyper-V VMBus.
> > 
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  .../bindings/hypervisor/microsoft,vmbus.yaml       | 48 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> make[1]: *** Deleting file 'Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.example.dtb'
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1508: dt_binding_check] Error 2

You can ignore this, it's a problem with the CI job.

> 
> doc reference errors (make refcheckdocs):
> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/virtio/
> MAINTAINERS: Documentation/devicetree/bindings/virtio/

But this probably needs to be fixed.

Rob
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
