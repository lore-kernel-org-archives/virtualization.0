Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51800C433F5
	for <virtualization@archiver.kernel.org>; Mon, 28 Mar 2022 20:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E068860B19;
	Mon, 28 Mar 2022 20:43:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bMZEUvvQVCka; Mon, 28 Mar 2022 20:43:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 658FB60655;
	Mon, 28 Mar 2022 20:43:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 427D5C002C;
	Mon, 28 Mar 2022 20:43:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD64FC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C87FD4016C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qiCdBN-fStmC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:43:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A542640117
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648500187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PJEPbSEt0O6lWWC+/4/A5CGukD+9ye2bG6M4HjxFpHI=;
 b=VokgyMEoNeXACqeY7cBSnVAuQEbnXhkyfjX85Hykn8cb+g4KzL3K+A+4Gc1msISb8RHk6A
 cD/xnmgquUZl317dSEfL5RVfFhFyPDzSu89eGzozPeA+BAkBk4D16ZJFc8bQpxJWuAxql1
 fUGLGkzKkeut3ztZBisdFUbrDOc0mRU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-L9zzqmYOOxqOYl5xcq7egQ-1; Mon, 28 Mar 2022 16:43:06 -0400
X-MC-Unique: L9zzqmYOOxqOYl5xcq7egQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 o10-20020a1c4d0a000000b0038c6e5fcbaeso203074wmh.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 13:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PJEPbSEt0O6lWWC+/4/A5CGukD+9ye2bG6M4HjxFpHI=;
 b=p5qLz1oo4qBaYK2jBhAgUO7DnoaSkOR6HfQYf3v53YjqP0cYvrcJ4vSDRXnEC8hoMX
 8f6PjkGo2GhCu0/BvGD7cmhrRLZaM0X+Y5k4/OwUHPiwPzFkecZ/xQU+uxcluyaiwgjo
 BErh2PytpQ43DCbM8bcdGSn9hw0PcDUxwahb5Fm/xZblTtAmboCrw3PmLccM9sG/eyAQ
 mPryFNztqd2/W0Trn2qPn34IOtgEq8WjR+Kl0YFl1tdl6B1sD8dpwVBUujBiFQkImE2f
 sLKQAxUNooAwb5g7l9pVjZGmzAJeO+SfUZEHwa/M3cJsbFKTeMNQUTzUid8z2IWk5xdy
 S0Ug==
X-Gm-Message-State: AOAM531s2Cq360pHokP5tmlrN/I0vDv25/muy24C5xSIqaQ3wsN5zyDo
 ZEb0BDAOwCyis6Ev+r5djrsZH/dAzsBFh6ofJ/pSw2QH04qcvIKJgmlpZX1ZUE0ZCmyVx1uyLop
 epOf5LNA0fEhQuAdXLyKxqIOMQ1vvyNyH903StVzEhQ==
X-Received: by 2002:a7b:c341:0:b0:37b:ed90:7dad with SMTP id
 l1-20020a7bc341000000b0037bed907dadmr1467630wmj.138.1648500184530; 
 Mon, 28 Mar 2022 13:43:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqJ51NlOZBInKiTlBe3giVlBSqn5C3pjZeP3UUXO1W7rcm9wq0r9ipgX192N0DSiX3l8eE+Q==
X-Received: by 2002:a7b:c341:0:b0:37b:ed90:7dad with SMTP id
 l1-20020a7bc341000000b0037bed907dadmr1467606wmj.138.1648500184334; 
 Mon, 28 Mar 2022 13:43:04 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 l20-20020a05600c1d1400b0038cba2f88c0sm616358wms.26.2022.03.28.13.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 13:43:03 -0700 (PDT)
Date: Mon, 28 Mar 2022 16:42:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Minghao Xue <quic_mingxue@quicinc.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: virtio: mmio: add optional
 wakeup-source property
Message-ID: <20220328164228-mutt-send-email-mst@kernel.org>
References: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
MIME-Version: 1.0
In-Reply-To: <20220325015945.GA17578@mingxue-gv.qualcomm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: jean-philippe@linaro.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 robh+dt@kernel.org, quic_ztu@quicinc.com
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

On Fri, Mar 25, 2022 at 09:59:45AM +0800, Minghao Xue wrote:
> Some systems want to set the interrupt of virtio_mmio device
> as a wakeup source. On such systems, we'll use the existence
> of the "wakeup-source" property as a signal of requirement.
> 
> Signed-off-by: Minghao Xue <quic_mingxue@quicinc.com>

I don't have enough of a clue about dt to review this.
Pls get some acks from people with DT expertise.

> ---
> v1 -> v2: rename property from "virtio,wakeup" to "wakeup-source"
> 
>  Documentation/devicetree/bindings/virtio/mmio.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> index 4b7a027..160b21b 100644
> --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> @@ -31,6 +31,10 @@ properties:
>      description: Required for devices making accesses thru an IOMMU.
>      maxItems: 1
>  
> +  wakeup-source:
> +    type: boolean
> +    description: Required for setting irq of a virtio_mmio device as wakeup source.
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.7.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
