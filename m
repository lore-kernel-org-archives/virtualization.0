Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FA3C49EA6
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 19:23:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DC8613F3
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 19:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DC8613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5D8E1400B5;
	Thu, 24 Jun 2021 19:23:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tGjGdTEDCiXU; Thu, 24 Jun 2021 19:23:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 06691400E4;
	Thu, 24 Jun 2021 19:23:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE4DDC001A;
	Thu, 24 Jun 2021 19:23:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 865F4C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 19:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73A976068D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 19:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id koWyw9Qk1B2V
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 19:23:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com
 [209.85.166.174])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C5E960633
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 19:23:02 +0000 (UTC)
Received: by mail-il1-f174.google.com with SMTP id u2so7463329ilk.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 12:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FObiRZ7IWgSRqkULNo4SwrdAdxQlc/wqkjjpbgOxgV4=;
 b=b3TxwVH9tMdLVTDM90pOWxKq9g6wytIKkLYTWNrKi2gSoo78m2o6xBbdHCCH7E90tI
 gIHCQu0dT5XAViEHYjuwEahoZ5HOGug9VG0n8YYhuADsksTxw3iatC7BOOcTVBPOcWGl
 ZADNM5E3WU26jD20Ot9TDR0au0+m8p/OO8LBAmQVDemMh3xFzQbS0ydGzOXYlmaJ5rbr
 HcknB/VDK1qmr0wZ4FNDQIKg30zg3l1BtoOGD/l9gOetWsN44bCtwPB/hTvnVR+ZtzQq
 IEVF72daik/fE5i9LVVwT5/Z51sYULREnzHRecGciol6wkNUAFdEw1nulOLkLRfvQXrm
 vXeA==
X-Gm-Message-State: AOAM532p1Hkya0M29Fn9cngMi4zcnAz7h8njUBU6z4N8V8F7G4epJdSx
 WKRXaeh3ckRK02s0K6n18Q==
X-Google-Smtp-Source: ABdhPJzEjFxbj1rCOIu3LTYs/mTe8TlXtzHhyiSc9VVWPhi8Wdd79t+9mOKtZpPlJtZ1v+UpfuzJOg==
X-Received: by 2002:a05:6e02:190a:: with SMTP id
 w10mr4930148ilu.238.1624562581835; 
 Thu, 24 Jun 2021 12:23:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id c10sm55041ild.72.2021.06.24.12.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jun 2021 12:23:00 -0700 (PDT)
Received: (nullmailer pid 1842131 invoked by uid 1000);
 Thu, 24 Jun 2021 19:22:55 -0000
Date: Thu, 24 Jun 2021 13:22:55 -0600
From: Rob Herring <robh@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v4 13/16] dt-bindings: arm: Add virtio transport for SCMI
Message-ID: <20210624192255.GA1842097@robh.at.kernel.org>
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-14-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210611165937.701-14-cristian.marussi@arm.com>
Cc: jean-philippe@linaro.org, mikhail.golubev@opensynergy.com,
 f.fainelli@gmail.com, vincent.guittot@linaro.org, igor.skalkin@opensynergy.com,
 virtio-dev@lists.oasis-open.org, devicetree@vger.kernel.org,
 sudeep.holla@arm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Vasyl.Vavrychuk@opensynergy.com,
 Rob Herring <robh+dt@kernel.org>, peter.hilber@opensynergy.com,
 Andriy.Tryshnivskyy@opensynergy.com, james.quinlan@broadcom.com,
 Jonathan.Cameron@huawei.com, souvik.chakravarty@arm.com,
 etienne.carriere@linaro.org, linux-arm-kernel@lists.infradead.org
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

On Fri, 11 Jun 2021 17:59:34 +0100, Cristian Marussi wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> Document the properties for arm,scmi-virtio compatible nodes.
> The backing virtio SCMI device is described in patch [1].
> 
> While doing that, make shmem property required only for pre-existing
> mailbox and smc transports, since virtio-scmi does not need it.
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202102/msg00018.html
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: devicetree@vger.kernel.org
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> [ Peter: Adapted patch for submission to upstream. ]
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> [ Cristian: converted to yaml format, moved shmen required property. ]
> Co-developed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v3 --> V4
> - convertd to YAML
> - make shmem required only for pre-existing mailbox and smc transport
> - updated VirtIO specification patch message reference
> - dropped virtio-mmio SCMI device example since really not pertinent to
>   virtio-scmi dt bindings transport: it is not even referenced in SCMI
>   virtio DT node since they are enumerated by VirtIO subsystem and there
>   could be PCI based SCMI devices anyway.
> ---
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
