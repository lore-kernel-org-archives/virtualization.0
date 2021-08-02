Return-Path: <SRS0=GDYi=MZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624CCC4320A
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 19:40:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15F4460725
	for <virtualization@archiver.kernel.org>; Mon,  2 Aug 2021 19:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15F4460725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D6797834F4;
	Mon,  2 Aug 2021 19:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ow1Wu5mYJrTY; Mon,  2 Aug 2021 19:40:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9090C833CD;
	Mon,  2 Aug 2021 19:40:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BD6CC0010;
	Mon,  2 Aug 2021 19:40:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE83BC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:40:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 913F5605BB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eRN393KOcdTB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:40:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com
 [209.85.166.171])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AF2B6066F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 19:40:50 +0000 (UTC)
Received: by mail-il1-f171.google.com with SMTP id c3so17510602ilh.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Aug 2021 12:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FJh25K50xXyjKPR6I/ZvrZUKOP39Op3Mf/ZgMwF4m0c=;
 b=GH/JiXO5bDxnfweQHtXXCH8wAIsH5B6HLq3T6Znw3geQ8Lnct1dp61G3rK5eWoYUq5
 Zx9UWyU0QKi2gmTRmvtj027hbxGyRhCqt81zz5gjs+TpHVDOw0YRR3bGEYoNp6vZUBop
 uI6wBU2cqC678ga48W50UpYCVc7upAgj6OkH6PJD11ZOCC/KKH03AQhjlTA781CbnvXr
 mLMBZ5RI4zrUpVTKNNZ1GJVFQNG9LDg3ECv/ywzINiZC8ORU5bJmi7jcxDJXNdBGfdtq
 qpkKZ5VeRbtJpajev8lOgUv+PykGhJmOs2kamCkGSRikSi0lEU8212k2S7z1jNOL85Fa
 l7Dg==
X-Gm-Message-State: AOAM531Fbi3LCajj9rfte9po6xpPlFiHDkO7jzGhvixb290MRW2QMS/m
 22OHxVb3f6uF1bNSOA3vxA==
X-Google-Smtp-Source: ABdhPJwvggXn5Z7YudjXgOND2Yw8VhbJaXRXS3FG2BPqNK8V+7I6XJDO/pfIwMzl2HHkidmpbOccyA==
X-Received: by 2002:a92:d790:: with SMTP id d16mr589527iln.185.1627933250278; 
 Mon, 02 Aug 2021 12:40:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id 125sm8031665iow.9.2021.08.02.12.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Aug 2021 12:40:49 -0700 (PDT)
Received: (nullmailer pid 1475877 invoked by uid 1000);
 Mon, 02 Aug 2021 19:40:48 -0000
Date: Mon, 2 Aug 2021 13:40:47 -0600
From: Rob Herring <robh@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/5] dt-bindings: virtio: Add binding for virtio devices
Message-ID: <YQhKP3CvvVR5VmIA@robh.at.kernel.org>
References: <cover.1627362340.git.viresh.kumar@linaro.org>
 <d8319fd18df7086b12cdcc23193c313893aa071a.1627362340.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d8319fd18df7086b12cdcc23193c313893aa071a.1627362340.git.viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Arnd Bergmann <arnd@kernel.org>, Bill Mills <bill.mills@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Enrico Weigelt,
 metux IT consult" <info@metux.net>
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

On Tue, 27 Jul 2021 10:53:48 +0530, Viresh Kumar wrote:
> Allow virtio device sub-nodes to be added to the virtio mmio or pci
> nodes. The compatible property for virtio device must be of the format
> "virtio,device<ID>", where ID is virtio device ID in hexadecimal format.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/virtio/mmio.yaml      |  3 +-
>  .../bindings/virtio/virtio-device.yaml        | 41 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
