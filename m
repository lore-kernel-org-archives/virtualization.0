Return-Path: <SRS0=DI/B=DA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66016C2D0E2
	for <virtualization@archiver.kernel.org>; Wed, 23 Sep 2020 20:54:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB91E214F1
	for <virtualization@archiver.kernel.org>; Wed, 23 Sep 2020 20:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB91E214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3F13086432;
	Wed, 23 Sep 2020 20:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jRb6CrYQtbiD; Wed, 23 Sep 2020 20:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 89E1B8626E;
	Wed, 23 Sep 2020 20:54:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B0DFC0859;
	Wed, 23 Sep 2020 20:54:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E250CC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 20:54:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CB60D228E7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 20:54:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Uq0Oi0xu3wek
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 20:54:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f195.google.com (mail-il1-f195.google.com
 [209.85.166.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 97EDA2045D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 20:54:35 +0000 (UTC)
Received: by mail-il1-f195.google.com with SMTP id f82so948588ilh.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 13:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d+sz3hgQEAMMDOvG0RAlSgcLLpJYw3j9zk3rcGcy++0=;
 b=iy1uVBrr8PDtcAAtkat35WcvLtlnEgSWxxlMLBwlyY5PXPcX7CKF09ZF8n/AGuwt44
 EPLwgpZzfT6k3lfMdA4nrgvwZLCPaheoJUGc6AC7bKeWBl3B7GVmnnePslM8oByjOX3s
 YrecxTMJxlFx87rcF2gZksfMINyk1L+g4Iwrpzh2jfzu+6G79fx3M9aXoG8UaugDKmZP
 7i5ZgGIHR2+qkTL+oppmgw6Ib3RGn/YKGSVZPPCE0ijLecL78wCNxYvPRj6NteGEezSt
 y/bll2CJjfddUOb15wnB88aG6fhEI+uBSLCACOY8WsXSi9gyOmQstwp2FzjasEdDd+Up
 89eg==
X-Gm-Message-State: AOAM533OU9jTiQ7oQAW/j2Oa/UNCk7Np2RwG1ouPEPbtMGGADe9Czvea
 Bbm3RqgN64Q4yrKdUmVYAQ==
X-Google-Smtp-Source: ABdhPJwhB3U+7nGpX1fOCxLfZQPy0Ana+7kdT7ZxdZzgBNG61Fg1tLqg9BV4if/p+1kRC6H1Is5gRQ==
X-Received: by 2002:a05:6e02:f48:: with SMTP id
 y8mr1415364ilj.103.1600894474882; 
 Wed, 23 Sep 2020 13:54:34 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id x1sm386462ilo.50.2020.09.23.13.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 13:54:34 -0700 (PDT)
Received: (nullmailer pid 1290212 invoked by uid 1000);
 Wed, 23 Sep 2020 20:54:33 -0000
Date: Wed, 23 Sep 2020 14:54:33 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH 6/7] dt-bindings: arm: Add virtio transport for SCMI
Message-ID: <20200923205433.GB1285024@bogus>
References: <20200918162311.254564-1-peter.hilber@opensynergy.com>
 <20200918165558.257086-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200918165558.257086-1-peter.hilber@opensynergy.com>
Cc: devicetree@vger.kernel.org, mikhail.golubev@opensynergy.com,
 souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
 virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 anton.yakovlev@opensynergy.com, sudeep.holla@arm.com, jean-philippe@linaro.org,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Sep 18, 2020 at 06:55:58PM +0200, Peter Hilber wrote:
> From: Igor Skalkin <igor.skalkin@opensynergy.com>
> 
> Document the properties for arm,scmi-virtio compatible nodes. The
> backing virtio SCMI device is described in patch [1].
> 
> [1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html
> 
> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      | 38 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 55deb68230eb..844ff3c40a49 100644
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
> @@ -21,6 +24,17 @@ The scmi node with the following properties shall be under the /firmware/ node.
>  	  supported.
>  - shmem : List of phandle pointing to the shared memory(SHM) area as per
>  	  generic mailbox client binding.
> +
> +Virtio transport:
> +
> +- compatible : shall be "arm,scmi-virtio".
> +- virtio_transport : phandle of the virtio device. This device must support one
> +                     virtqueue for transmitting commands ("tx", cmdq), and,
> +		     optionally, one more virtqueue for receiving notifications
> +		     and delayed responses ("rx", eventq).

Isn't what the virtio device provides discoverable? We don't have virtio 
protocols in DT for anything else. Why is SCMI special?

Rob
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
