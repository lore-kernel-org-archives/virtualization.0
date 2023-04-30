Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25816C77B73
	for <virtualization@archiver.kernel.org>; Sun, 30 Apr 2023 14:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9967C418F5;
	Sun, 30 Apr 2023 14:06:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9967C418F5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XYw/CfNo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id icoj0sdq6QqO; Sun, 30 Apr 2023 14:06:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BFA62418E4;
	Sun, 30 Apr 2023 14:06:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BFA62418E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B86EC0036;
	Sun, 30 Apr 2023 14:06:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EAF1DC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 14:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3833418F5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 14:06:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3833418F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9UtX3Wb8Qtcu
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 14:06:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B469418E4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7B469418E4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 14:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682863607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/qFwCkDXym+BO05vYF8vpXsanmPn3ffsSFSPl68Sv4Y=;
 b=XYw/CfNoqOxY6vkppd0il0Dg99SI+v1J3/1YUCsofcPnctsnzDTfg0zjMxTl24yWBBYyCG
 kwvbA+q/RINZcGSoSKduOiKttzO6O5DOcjbkW7LDa3eOLN4ESamfNOUXjemZtBXiPOOklF
 6CGduUcJ987g9tDn74UbMfjLNFf84vw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-HwpdNuOyNrWJxYu10qD_fA-1; Sun, 30 Apr 2023 10:06:45 -0400
X-MC-Unique: HwpdNuOyNrWJxYu10qD_fA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f315735edeso68216675e9.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Apr 2023 07:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682863604; x=1685455604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qFwCkDXym+BO05vYF8vpXsanmPn3ffsSFSPl68Sv4Y=;
 b=g+QX4g70KHky/F0ax158G+9swFkQr/6Yr3awAtoP7DAyxaDsTqPAFgAoAggjnzNk7e
 PpIxUrPccFhUm9jObt80rxEdm/Gve/JZ8BZefnxi5MLp23hUWk5BRxgnjJiZfsw3tV2r
 ZEZK0eNHVArcWpieymzp524tbtDxdHxpxVz8Xs7qe1VqngPPqfHgWyHfHvpCrg83IyNo
 VN/312ouiPF3cpEde3LGLYA3MKAUD+Ft3PpE4DlFLnchf2gpDQLGp4/k2EL24AEThhnl
 jptQJrlHvDQ/6iv95TIPMhxh7OgHlpb+NRjTK9rmHjhjHoGHpvHrsd0a8yGiwLBbifHn
 h7kA==
X-Gm-Message-State: AC+VfDxensZFJeIYPqgl22HYPm8NnZIX+yz3a7AB0xrNDLPp67afyhEz
 k/cJItNovQ6NpsuK25lft+RWNMQi0hhFhU26szPbtvVurs9KbV96JKV2pc++b3/5QCYoArTcWf1
 D/XiuJ/idIT9oM5WUhXH7pYFXd+GJY3aOvyPOR+yBbA==
X-Received: by 2002:a7b:c7c4:0:b0:3f1:6f57:6fd1 with SMTP id
 z4-20020a7bc7c4000000b003f16f576fd1mr8450911wmk.9.1682863604674; 
 Sun, 30 Apr 2023 07:06:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49qr4fnugfdl0poBdeno2pyYNH1DJqISB5JrW9YRnjnc+eSzsu886AyGUm1JWAYtIvaYCRKA==
X-Received: by 2002:a7b:c7c4:0:b0:3f1:6f57:6fd1 with SMTP id
 z4-20020a7bc7c4000000b003f16f576fd1mr8450897wmk.9.1682863604398; 
 Sun, 30 Apr 2023 07:06:44 -0700 (PDT)
Received: from redhat.com ([2.52.139.131]) by smtp.gmail.com with ESMTPSA id
 z23-20020a7bc7d7000000b003f1751016desm29757833wmk.28.2023.04.30.07.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Apr 2023 07:06:43 -0700 (PDT)
Date: Sun, 30 Apr 2023 10:06:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [RFC PATCH net 0/3] virtio-net: allow usage of small vrings
Message-ID: <20230430100535-mutt-send-email-mst@kernel.org>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Sun, Apr 30, 2023 at 04:15:15PM +0300, Alvaro Karsz wrote:
> At the moment, if a virtio network device uses vrings with less than
> MAX_SKB_FRAGS + 2 entries, the device won't be functional.
> 
> The following condition vq->num_free >= 2 + MAX_SKB_FRAGS will always
> evaluate to false, leading to TX timeouts.
> 
> This patchset attempts this fix this bug, and to allow small rings down
> to 4 entries.
> The first patch introduces a new mechanism in virtio core - it allows to
> block features in probe time.
> 
> If a virtio drivers blocks features and fails probe, virtio core will
> reset the device, re-negotiate the features and probe again.
> 
> This is needed since some virtio net features are not supported with
> small rings.
> 
> This patchset follows a discussion in the mailing list [1].
> 
> This fixes only part of the bug, rings with less than 4 entries won't
> work.

Why the difference?

> My intention is to split the effort and fix the RING_SIZE < 4 case in a
> follow up patchset.
> 
> Maybe we should fail probe if RING_SIZE < 4 until the follow up patchset?

I'd keep current behaviour.

> I tested the patchset with SNET DPU (drivers/vdpa/solidrun), with packed
> and split VQs, with rings down to 4 entries, with and without
> VIRTIO_NET_F_MRG_RXBUF, with big MTUs.
> 
> I would appreciate more testing.
> Xuan: I wasn't able to test XDP with my setup, maybe you can help with
> that?
> 
> [1] https://lore.kernel.org/lkml/20230416074607.292616-1-alvaro.karsz@solid-run.com/
> 
> Alvaro Karsz (3):
>   virtio: re-negotiate features if probe fails and features are blocked
>   virtio-net: allow usage of vrings smaller than MAX_SKB_FRAGS + 2
>   virtio-net: block ethtool from converting a ring to a small ring
> 
>  drivers/net/virtio_net.c | 161 +++++++++++++++++++++++++++++++++++++--
>  drivers/virtio/virtio.c  |  73 +++++++++++++-----
>  include/linux/virtio.h   |   3 +
>  3 files changed, 212 insertions(+), 25 deletions(-)
> 
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
