Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871B8C636CD
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 13:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0A73813CB;
	Tue,  7 Feb 2023 13:00:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0A73813CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ztTs1ZC1iAS9; Tue,  7 Feb 2023 13:00:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BE23813D9;
	Tue,  7 Feb 2023 13:00:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BE23813D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E3CA2C0032;
	Tue,  7 Feb 2023 13:00:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D6A3C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 13:00:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 59D1840516
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 13:00:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 59D1840516
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K4RSFYAjND9T
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 13:00:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7015040232
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7015040232
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 13:00:27 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-16a10138faeso12561331fac.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 05:00:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=date:subject:message-id:references:in-reply-to:cc:to:from
 :mime-version:content-transfer-encoding:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kWODlwdvZsu0oLYsDwnCYHspujHUtXG5z9FcEcxyHyQ=;
 b=RGmRS7O4d9znJNQQkeXkiKE5B5dt2e6sC1Gx54qwj08z0pDLkZcEm7KrNZP1jDkgTt
 FzSCfmBiESr+GLLpHQvRm1CRq/LAZ5/SuToU7a4CNhykk8rOqyAZ3K3A7tPU3cQO1QDa
 Juh3Srk2SPDajsh2Jd9RRrBnotxdcU1hFH32KRk8S7J/RXNaHUE+AxP6ynW+SjqflYvr
 pJY+F02pA7D9aCi+ApD5XSqQadRGYRMTn1UUfFNdYST56bVx5awt5L0NrFg+kvEdWYlP
 7dOvRKEvcuYX/QUMJ1UwHVQ8hgxe8DacXPbKdKQLGkFcVUgVuxv+kCUHCDBH1fjUrgBX
 XeXg==
X-Gm-Message-State: AO0yUKVnD7kSEEhKap1LdvrFpvdxmleFvoJD3OpR4CPUZ1Uh0NBKW2fN
 1cwiyyk4zdbt3GBkR4xUcw==
X-Google-Smtp-Source: AK7set/AuiNu1wfO7TO0Yq1H8Nc2wRr3B6t1v/K4dh5V8fdcoownRf93LSBXHcp95e0D4fG4jyF4QQ==
X-Received: by 2002:a05:6870:c093:b0:163:b347:22fc with SMTP id
 c19-20020a056870c09300b00163b34722fcmr1511834oad.12.1675774826402; 
 Tue, 07 Feb 2023 05:00:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 i4-20020a056870044400b0016a694e7e2dsm1401439oak.39.2023.02.07.05.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Feb 2023 05:00:25 -0800 (PST)
Received: (nullmailer pid 3216438 invoked by uid 1000);
 Tue, 07 Feb 2023 13:00:23 -0000
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
In-Reply-To: <1675756199-5917-6-git-send-email-ssengar@linux.microsoft.com>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
 <1675756199-5917-6-git-send-email-ssengar@linux.microsoft.com>
Message-Id: <167577470818.3213850.12635304061765127789.robh@kernel.org>
Subject: Re: [PATCH v4 5/6] dt-bindings: hypervisor: VMBus
Date: Tue, 07 Feb 2023 07:00:23 -0600
Cc: devicetree@vger.kernel.org, wei.liu@kernel.org, ssengar@microsoft.com,
 linux-kernel@vger.kernel.org, haiyangz@microsoft.com,
 daniel.lezcano@linaro.org, decui@microsoft.com, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, robh+dt@kernel.org,
 dphadke@linux.microsoft.com, krzysztof.kozlowski+dt@linaro.org,
 tglx@linutronix.de, mikelley@microsoft.com
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


On Mon, 06 Feb 2023 23:49:58 -0800, Saurabh Sengar wrote:
> Add dt-bindings for Hyper-V VMBus.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  .../bindings/hypervisor/microsoft,vmbus.yaml       | 48 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
make[1]: *** Deleting file 'Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.example.dtb'
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/virtio/
MAINTAINERS: Documentation/devicetree/bindings/virtio/

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1675756199-5917-6-git-send-email-ssengar@linux.microsoft.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
