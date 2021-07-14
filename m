Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25903C07E9A
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 08:20:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BCB613AF
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 08:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BCB613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82AF560A57;
	Wed, 14 Jul 2021 08:20:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xp90CWUv0Fva; Wed, 14 Jul 2021 08:20:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2B672605C8;
	Wed, 14 Jul 2021 08:20:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBAB5C001A;
	Wed, 14 Jul 2021 08:20:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6AF7C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 860EB4053F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:20:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KH4HRnaiRj8Y
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:20:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E4AC403DE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 08:20:43 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id v20so1956057eji.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=F8Io+rg1Po7RKIeX6xd4nWzyFfLG9bRShMsVJw7hf0Q=;
 b=BqDNNSk7ZSAQK4poF+WsKbLWA5YzfU2H6DRP7g8AhtSDx5oKXqIwkX0gVqTCYATcr6
 KdZNQhf6s/NGfcPR7o2nXA1mgBXVkIW0M/UZ3+t8xQbVX48lyvKTcbI5hpf3lcsDlluq
 ws/Jpup4YIz+yoWrpKldXbBmt9Su6Kr7udKSTTIXkAVmGiqUXOxIKBMuExp8lx/W+Dma
 Zmc60wFDKsTgka2ASyEWGzS2eqPr6GKDIYk5gBnrU3AGYkFP/JXIz/A83L1wX+N/Ty1e
 QESK19pnJYhm5QTym0rIpglmWTStHqJFnCF0KheLKuNv1HUlqrZZlyxwYvjuO9TBlI26
 a5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F8Io+rg1Po7RKIeX6xd4nWzyFfLG9bRShMsVJw7hf0Q=;
 b=fMn2FK8+sbWsFCBbwEgsZxCzmB7RiN4oZWFD2BcyskLQ1dN0t4bIIH5vgS2t7P+OS6
 mBoxujA+NkQpv69+rul/r4JxQ6cTddkoB2pFWr5gHjssdzXjgfSqMmXcb5cvVy0Hmoty
 ERaUA0+Y6g6BCqvPD8fqa81IKgrPk4DD4RG/BMIkNUNTIHnsoGBVP6GNev2NsfHJ2Af3
 uJXPgGilQdNHV3BErjOnDltHLXYJFPkVAUTr7An7lzYOefgYTeVA7xaxeZP7CauB9HnA
 gf4gUwfro3NW4+2lZ5ouwTCjgCBLjzMoY7ezV30pji22rT6pJPHaG9JvAk/m0upC27iw
 m4sQ==
X-Gm-Message-State: AOAM532EBJjNBPfE3mAqxUoiJ2m/eP0ELWWX94yhWxi6HCYaZI80ZN0q
 FI3Oedgcq338MKCvnsD3voBiDw==
X-Google-Smtp-Source: ABdhPJzyuroGTikKGPkfvMs8+Wj2CvFr44B6AtpScg3Pu1k9Wf/sWWAM9fXM7DM7RVR/SHddJJE5BQ==
X-Received: by 2002:a17:906:24c3:: with SMTP id
 f3mr11047240ejb.145.1626250841411; 
 Wed, 14 Jul 2021 01:20:41 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
 by smtp.gmail.com with ESMTPSA id s5sm602820edi.93.2021.07.14.01.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jul 2021 01:20:40 -0700 (PDT)
Date: Wed, 14 Jul 2021 10:20:21 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device
 subnode
Message-ID: <YO6eRXz/J1tPOi0P@myrica>
References: <cover.1626173013.git.viresh.kumar@linaro.org>
 <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
 <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
 <20210713151917.zouwfckidnjxvohn@vireshk-i7>
 <CAL_JsqL9255n5RT=Gq_uru7rEP0bSVcyfXEPRY4F0M4S2HPvTA@mail.gmail.com>
 <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Gve=M9GF-E+2OJED1Hd1qngxOkVSO15wB0jVWK8D0_Q@mail.gmail.com>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>, DTML <devicetree@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Bill Mills <bill.mills@linaro.org>
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

On Tue, Jul 13, 2021 at 10:34:03PM +0200, Arnd Bergmann wrote:
> > > Is it going to be a problem if two devices in kernel use the same
> > > of_node ?
> >
> > There shouldn't be. We have nodes be multiple providers (e.g clocks
> > and resets) already.
> 
> I think this would be a little different, but it can still work. There is in
> fact already some precedent of doing this, with Jean-Philippe's virtio-iommu
> binding, which is documented in both
> 
> Documentation/devicetree/bindings/virtio/iommu.txt
> Documentation/devicetree/bindings/virtio/mmio.txt
> 
> Unfortunately, those are still slightly different from where I think we should
> be going here, but it's probably close enough to fit into the general
> system.
> 
> What we have with virtio-iommu is two special hacks:
>  - on virtio-mmio, a node with 'compatible="virtio,mmio"' may optionally
>    have an '#iommu-cells=<1>', in which case we assume it's an iommu.
>  - for virtio-pci, the node has the standard PCI 'reg' property but a special
>    'compatible="virtio,pci-iommu"' property that I think is different from any
>    other PCI node.

Yes in retrospect I don't think the compatible property on the PCI
endpoint node is necessary nor useful, we could deprecate it. The OS gets
the IOMMU topology information early from 'iommus', 'iommu-map' and
'#iommu-cells' properties, which is the only reason we need this PCI
endpoint explicitly described in DT. The rest is discovered while probing
just like virtio-mmio.

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
