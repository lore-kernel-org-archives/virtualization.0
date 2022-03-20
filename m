Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA29C433EF
	for <virtualization@archiver.kernel.org>; Sun, 20 Mar 2022 19:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D893C4023B;
	Sun, 20 Mar 2022 19:08:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id foz6kPd3H0bw; Sun, 20 Mar 2022 19:08:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 53F3940019;
	Sun, 20 Mar 2022 19:08:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27E12C001A;
	Sun, 20 Mar 2022 19:08:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ABA0C000B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 19:08:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 590BB60B72
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 19:08:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HhFR_yL4hFbm
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 19:08:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
 [209.85.222.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5C3E6070A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 19:08:14 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id r127so10363899qke.13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 12:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=j9jB6hCoAeek2so+uIbbjJIZdsM49+J+dmzdAcWuE6U=;
 b=HxA4Xnxm9ANof+G0lj+y3UIJ/JNCU0UWIRZ6DhgZpDPU71JK5kr7l97+2Z6cCe7irM
 RuTnnOAqvgogeRz2SO4dzHsloOega5X2v51EMJGQjWNMzpcKCBiOXm21lKHPAAeWs9gs
 Zqchi6dFQHoHR5zgH/gtgniFNSW0a9c4wBMBJOzXdoXILTu5aTnyH0zT4NzB9CC7gv9m
 vdS993h0nVLrkhkEbCV6ytmvr3ze8YN9nioWgLVs/qAvDrqb7qU5GeL7JsKP7Q9aPDbM
 6Jn1crRjrY2XAUOs+4wCzvnyJcHy8jmZYg3xoOBnDGo+Ooa2cZh+f4axZpVCZW9COt2A
 4khg==
X-Gm-Message-State: AOAM5316dDY8xnIKtztCTf7x+3WLSXxGJFKQBid05iZyWxXwHWrhCd3G
 VdanxPYqZCyckA7l6Tni8w==
X-Google-Smtp-Source: ABdhPJwnjk5ENlSemC+yJtR3JNmQohdlidXxuypc1ZAitRfT9b5WukCjAwdyT7jKx+Dv6jF301Xvng==
X-Received: by 2002:a37:65c5:0:b0:67b:3232:8cc8 with SMTP id
 z188-20020a3765c5000000b0067b32328cc8mr10773814qkb.170.1647803293628; 
 Sun, 20 Mar 2022 12:08:13 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:c6d:21ec:c4f5:bb3:5269:3b0e])
 by smtp.gmail.com with ESMTPSA id
 v3-20020a05622a188300b002e1cbca8ea4sm10706141qtc.59.2022.03.20.12.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Mar 2022 12:08:12 -0700 (PDT)
Received: (nullmailer pid 3230186 invoked by uid 1000);
 Sun, 20 Mar 2022 19:08:10 -0000
Date: Sun, 20 Mar 2022 15:08:10 -0400
From: Rob Herring <robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: virtio,mmio: Allow setting devices
 'dma-coherent'
Message-ID: <Yjd7mhLw/aKVSsS7@robh.at.kernel.org>
References: <20220310013528.549030-1-robh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220310013528.549030-1-robh@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 devicetree@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
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

On Wed, 09 Mar 2022 19:35:27 -0600, Rob Herring wrote:
> 'virtio,mmio' devices are always coherent within a guest. As Arm DTs
> are default non-coherent, the 'dma-coherent' property needs to be set on
> the virtio device to mark them as such. This aligns with the QEMU 'virt'
> machine DTB.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/virtio/mmio.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
