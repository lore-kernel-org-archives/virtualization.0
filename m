Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B6CC433ED
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 21:39:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9473A61263
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 21:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9473A61263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E98F83404;
	Mon, 17 May 2021 21:39:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJTFqlKtiJOH; Mon, 17 May 2021 21:39:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDD4A833CD;
	Mon, 17 May 2021 21:39:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1A99C000E;
	Mon, 17 May 2021 21:39:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11630C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 21:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF4954020A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 21:39:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HfxYfrOx1i5X
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 21:39:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0983040112
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 21:39:21 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id j75so7802867oih.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 14:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zWnED48EDpwnC0QrK/2GG96NIx3ZITF2lzNhyILVV74=;
 b=MN5YI2TEmyjhh25c5HM5DoRIjBHEYK4cXc+t9TLrlj0PA2ZuKabAapIzEcSR1sdDm4
 wxrelUhwKRE9fGqnheSfbziEKev24wSDiinz78AijCkOLpIrNeDWPOnegP7L0klJ9T5N
 k03mOtvvYobW1dB047UR7Ti4QnW1NvAEjut+ycr67YCsgKkvuj2nwqbfKGcJeU9J//hW
 qBbT8C8ZHXm6pXMaHE75mwPO/ufA+zbn5TrrwW/34g4H0eBBglS+OkizQqbPX50pl6KG
 pho8LPa/vEPaFNNvSTqDm2vuUFNbmG9kHB5Ar1Z3iUN8rDzguYEl1STgRmfkuyuQpR6M
 eWgg==
X-Gm-Message-State: AOAM530jlbhuW4kDY7SEmHOx//uLJrnUQCvRFnXQBC56lVYJRnTDtVfv
 DHgLR1lOiK147nBEFfui9w==
X-Google-Smtp-Source: ABdhPJxbbgK+3rR9bUWE5aQU5JbRSHEo1oLdNN62ukR0PSLUGUDbIGrEZdBl0bBU6Cnrxo6AJT4mEw==
X-Received: by 2002:aca:f44c:: with SMTP id s73mr1354014oih.142.1621287560921; 
 Mon, 17 May 2021 14:39:20 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id q1sm3470980otc.21.2021.05.17.14.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 14:39:19 -0700 (PDT)
Received: (nullmailer pid 3247628 invoked by uid 1000);
 Mon, 17 May 2021 21:39:18 -0000
Date: Mon, 17 May 2021 16:39:18 -0500
From: Rob Herring <robh@kernel.org>
To: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v3 10/12] dt-bindings: arm: Add virtio transport for
 SCMI
Message-ID: <20210517213918.GA3244026@robh.at.kernel.org>
References: <20210511002040.802226-1-peter.hilber@opensynergy.com>
 <20210511002040.802226-11-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210511002040.802226-11-peter.hilber@opensynergy.com>
Cc: devicetree@vger.kernel.org, mikhail.golubev@opensynergy.com,
 Vasyl Vavrychuk <Vasyl.Vavrychuk@opensynergy.com>, souvik.chakravarty@arm.com,
 Igor Skalkin <igor.skalkin@opensynergy.com>, virtio-dev@lists.oasis-open.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Cristian Marussi <cristian.marussi@arm.com>, sudeep.holla@arm.com,
 jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
 Andriy Tryshnivskyy <Andriy.Tryshnivskyy@opensynergy.com>
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

On Tue, May 11, 2021 at 02:20:38AM +0200, Peter Hilber wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> Document the properties for arm,scmi-virtio compatible nodes. The
> backing virtio SCMI device is described in patch [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html
> 
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> [ Peter: Adapted patch for submission to upstream. ]
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      | 35 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)

Seems like it may not be perfectly clear what properties apply or not 
for the different transports. Can you convert this to DT schema first.

> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 667d58e0a659..5d209ba666f6 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -13,6 +13,9 @@ the device tree.
>  Required properties:
>  
>  The scmi node with the following properties shall be under the /firmware/ node.
> +Some properties are specific to a transport type.
> +
> +shmem-based transports (mailbox, smc/hvc):
>  
>  - compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
>  - mboxes: List of phandle and mailbox channel specifiers. It should contain
> @@ -21,6 +24,15 @@ The scmi node with the following properties shall be under the /firmware/ node.
>  	  supported.
>  - shmem : List of phandle pointing to the shared memory(SHM) area as per
>  	  generic mailbox client binding.
> +
> +Virtio transport:
> +
> +- compatible : shall be "arm,scmi-virtio".
> +
> +The virtio transport only supports a single device.
> +
> +Additional required properties:
> +
>  - #address-cells : should be '1' if the device has sub-nodes, maps to
>  	  protocol identifier for a given sub-node.
>  - #size-cells : should be '0' as 'reg' property doesn't have any size
> @@ -50,7 +62,8 @@ Each protocol supported shall have a sub-node with corresponding compatible
>  as described in the following sections. If the platform supports dedicated
>  communication channel for a particular protocol, the 3 properties namely:
>  mboxes, mbox-names and shmem shall be present in the sub-node corresponding
> -to that protocol.
> +to that protocol. The virtio transport does not support dedicated communication
> +channels.
>  
>  Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
>  ------------------------------------------------------------
> @@ -129,7 +142,8 @@ Required sub-node properties:
>  [5] Documentation/devicetree/bindings/reset/reset.txt
>  [6] Documentation/devicetree/bindings/regulator/regulator.yaml
>  
> -Example:
> +Example (mailbox transport):
> +----------------------------
>  
>  sram@50000000 {
>  	compatible = "mmio-sram";
> @@ -237,3 +251,20 @@ thermal-zones {
>  		...
>  	};
>  };
> +
> +Example (virtio transport):
> +---------------------------
> +
> +virtio_mmio@4b001000 {
> +	compatible = "virtio,mmio";
> +	...
> +};
> +
> +firmware {
> +	...
> +	scmi {
> +		compatible = "arm,scmi-virtio";
> +		...
> +
> +The rest is similar to the mailbox transport example, when omitting the
> +mailbox/shmem-specific properties.
> -- 
> 2.25.1
> 
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
