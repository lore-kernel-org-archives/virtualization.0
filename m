Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8737C38142
	for <virtualization@archiver.kernel.org>; Tue, 31 Jan 2023 19:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4150060D96;
	Tue, 31 Jan 2023 19:57:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4150060D96
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p0VFuk7n6ZW7; Tue, 31 Jan 2023 19:57:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ABD7160AE7;
	Tue, 31 Jan 2023 19:57:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABD7160AE7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70D67C0033;
	Tue, 31 Jan 2023 19:57:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4674EC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 19:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0CCA360BEC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 19:57:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CCA360BEC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wk_cnrqQA4nl
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 19:57:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C0A0F60AE7
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C0A0F60AE7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 19:57:38 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-15f97c478a8so20785534fac.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Jan 2023 11:57:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=date:subject:message-id:references:in-reply-to:cc:to:from
 :mime-version:content-transfer-encoding:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m82eJrTLsCVv6+8d1tBF70ypw6dfuc3iNnRL2mCyZ7Q=;
 b=SPLJkipoaSfRJ65iaaPWEi5DO3w1l6Nyf8F6Ay31PuGc04zQIdKvYJI7ANa+1VFlJX
 cH+9658KwmAA0WYAhU7jteGY6GxZFXbUmMYQFZpMOYei3m6CSvl154UYFzjmM6m47ink
 /VQqYZCKKBMgoiapQVAt3iAhwcE3tK1lvJRkvTGCMfMC/VOA0p+T9BwcTsqPvU1YtgV9
 rXCtoMG195C+NjNHH3fpGz6RImbz/JNAsiC7PA/aDwt5LpnYax1ak3VLU2CdDQ6hdInd
 hnUUUnhJHs5zoiYswbHvxBfzjHiSj+pBh0lrEKrwZyTaCQjDHaoANFrZTEOsXygcTbvB
 77Dw==
X-Gm-Message-State: AO0yUKWXZXPN6mQzD0yhmH0kTwtLqOkBNtadI0mLC3MgkVX4oouQYFqX
 L2bqxDjk7Jj4vKX5LpJ66A==
X-Google-Smtp-Source: AK7set9mqa5Na5vbUcPoMSNwU8zMyBTBeTBDFDOv7+2/nvgRcTdmrhpji7/Gn0VRdn0ekPOq4E9Swg==
X-Received: by 2002:a05:6871:10e:b0:15e:db7e:b4dc with SMTP id
 y14-20020a056871010e00b0015edb7eb4dcmr8075396oab.35.1675195057458; 
 Tue, 31 Jan 2023 11:57:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 r12-20020a05687080cc00b00163af122666sm3197311oab.3.2023.01.31.11.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Jan 2023 11:57:37 -0800 (PST)
Received: (nullmailer pid 1853627 invoked by uid 1000);
 Tue, 31 Jan 2023 19:57:36 -0000
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
In-Reply-To: <1675188609-20913-5-git-send-email-ssengar@linux.microsoft.com>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
 <1675188609-20913-5-git-send-email-ssengar@linux.microsoft.com>
Message-Id: <167519443459.1836211.1945655170442861713.robh@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: hypervisor: Rename virtio to
 hypervisor
Date: Tue, 31 Jan 2023 13:57:36 -0600
Cc: devicetree@vger.kernel.org, wei.liu@kernel.org, ssengar@microsoft.com,
 mikelley@microsoft.com, haiyangz@microsoft.com, daniel.lezcano@linaro.org,
 decui@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org
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


On Tue, 31 Jan 2023 10:10:07 -0800, Saurabh Sengar wrote:
> Rename virtio folder to more generic hypervisor, so that this can
> accommodate more devices of similar type.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  .../devicetree/bindings/{virtio => hypervisor}/mmio.yaml        | 2 +-
>  .../devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml   | 2 +-
>  .../bindings/{virtio => hypervisor}/virtio-device.yaml          | 2 +-
>  MAINTAINERS                                                     | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml (95%)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml (98%)
>  rename Documentation/devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml (93%)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/i2c/i2c-virtio.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/virtio/virtio-device.yaml
./Documentation/devicetree/bindings/gpio/gpio-virtio.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/virtio/virtio-device.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-virtio.example.dtb: i2c: False schema does not allow {'compatible': ['virtio,device22'], '#address-cells': [[1]], '#size-cells': [[0]], 'light-sensor@20': {'compatible': ['dynaimage,al3320a'], 'reg': [[32]]}, '$nodename': ['i2c']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-virtio.example.dtb: gpio: False schema does not allow {'compatible': ['virtio,device29'], 'gpio-controller': True, '#gpio-cells': [[2]], 'interrupt-controller': True, '#interrupt-cells': [[2]], '$nodename': ['gpio']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hypervisor/virtio-device.example.dtb: i2c: False schema does not allow {'compatible': ['virtio,device22'], '$nodename': ['i2c']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml

doc reference errors (make refcheckdocs):
MAINTAINERS: Documentation/devicetree/bindings/virtio/

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1675188609-20913-5-git-send-email-ssengar@linux.microsoft.com

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
