Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF3CC05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 10:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D95960AFF;
	Thu,  2 Feb 2023 10:57:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6D95960AFF
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W29bVnF9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OhDCsSTr7yn4; Thu,  2 Feb 2023 10:57:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E05B4606ED;
	Thu,  2 Feb 2023 10:57:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E05B4606ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5578C0032;
	Thu,  2 Feb 2023 10:57:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E249FC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:57:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C376A81F35
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:57:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C376A81F35
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W29bVnF9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ipY4Y5-DZqzn
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:57:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85F1F812F0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 85F1F812F0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675335426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLgisAhVhjxaFOYw08tk2NZkXdHAeHPvk91YSYHYTNo=;
 b=W29bVnF9nIRsBC4C0eECS/EYKXKvBDL9SIZ6IGx7F2hFo2DOwsDGBhbBUaXhU+hAi3aWCw
 Q/m9A45WwImHvH8z/f5BUViEVbxcC7vMlQk2Fa/+ai/hT5uz/1YgyN0i9QW59mdDASZ/XW
 nO5/kiksBatPcHcENTUlGflMkafct3s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-357-NN_kcX0JOnCQf2GNErP4Lw-1; Thu, 02 Feb 2023 05:57:05 -0500
X-MC-Unique: NN_kcX0JOnCQf2GNErP4Lw-1
Received: by mail-wm1-f69.google.com with SMTP id
 e38-20020a05600c4ba600b003dc434dabbdso2627266wmp.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 02:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLgisAhVhjxaFOYw08tk2NZkXdHAeHPvk91YSYHYTNo=;
 b=b8nMsyizwnMZupQjQ0b+lsPXaRhHB/ok1C6OL+B4MJH7kBWDJFqtQfgKoV5d4pR2uB
 1g3Jhxo7EXFHcExGbfS5lpno98k3q9E81ClL1BcSSN0K7Jv7YiwI98o9Z7qorANrkyyF
 pOfZjODnDRZNyc9insrMVb+LLG+u+q/1n4B06KAIuDnPcMsPmg1kxBjhPYihb49rFODU
 tKzy64hoMOXfalkd9eaHwyzLatoVT5Qiy8P4zXS0KZvlviAt9gRbI8CrCRDnwRloTY0o
 ySL26uNbVc4W7D4LwjvG3iUyPQoRgFQEwFsAEPjUXyb0EATI4G9lpcKstC4VrdgpYV7l
 G9tg==
X-Gm-Message-State: AO0yUKVCBj/+FJdlM20/87KYuOSobn4IiNG4KChXS64XrC3q7jzd0+rx
 D/Am1nyx0Lr2HiElBrGTczFsU92Ab5CnWTHEfgL2vIUhlmRfeP79qgwYnNGOvpEf0nWYXuW9qgk
 AImsipGXFuOp1MCxsiBscXLKPOPHt7klL0d9e2U5YTQ==
X-Received: by 2002:a05:600c:3b0c:b0:3d2:813:138a with SMTP id
 m12-20020a05600c3b0c00b003d20813138amr1515650wms.35.1675335424012; 
 Thu, 02 Feb 2023 02:57:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/psrnYQSpicehicPlykAuaLwGGouzJxfU7GSH68r+uUKziLdcFHTfe7pPMuUCzZZ/UZoUzFw==
X-Received: by 2002:a05:600c:3b0c:b0:3d2:813:138a with SMTP id
 m12-20020a05600c3b0c00b003d20813138amr1515635wms.35.1675335423854; 
 Thu, 02 Feb 2023 02:57:03 -0800 (PST)
Received: from redhat.com ([2a02:14f:1fc:826d:55d8:70a4:3d30:fc2f])
 by smtp.gmail.com with ESMTPSA id
 j25-20020a05600c1c1900b003daf6e3bc2fsm6888625wms.1.2023.02.02.02.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 02:57:03 -0800 (PST)
Date: Thu, 2 Feb 2023 05:56:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 0/2] virtio-net: close() to follow mirror of open()
Message-ID: <20230202055630-mutt-send-email-mst@kernel.org>
References: <20230202050038.3187-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230202050038.3187-1-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: hawk@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 ast@kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, bpf@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Thu, Feb 02, 2023 at 07:00:36AM +0200, Parav Pandit wrote:
> Hi,
> 
> This two small patches improves ndo_close() callback to follow
> the mirror sequence of ndo_open() callback. This improves the code auditing
> and also ensure that xdp rxq info is not unregistered while NAPI on
> RXQ is ongoing.


Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'm guessing -net and 1/2 for stable?

> Please review.
> 
> Patch summary:
> patch-1 ensures that xdp rq info is unregistered after rq napi is disabled
> patch-2 keeps the mirror sequence for close() be mirror of open()
> 
> Parav Pandit (2):
>   virtio-net: Keep stop() to follow mirror sequence of open()
>   virtio-net: Maintain reverse cleanup order
> 
>  drivers/net/virtio_net.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> -- 
> 2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
