Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC552C77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 07:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C3848224B;
	Mon, 17 Apr 2023 07:12:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8C3848224B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P5XZgu8b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QO841kt2Xckf; Mon, 17 Apr 2023 07:12:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 983118226B;
	Mon, 17 Apr 2023 07:11:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 983118226B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 708D5C0036;
	Mon, 17 Apr 2023 07:11:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8770AC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:11:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 628E982293
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:11:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 628E982293
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mssUEmklMhAS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:11:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E0FE82284
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0E0FE82284
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 07:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681715515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3DxIGeDChpW+dCspX207xU3KDB22/OENqLPHBuTpQk8=;
 b=P5XZgu8buk/IbmF+FGv3d/35WEgzDbh1dBiHrQK1Q6NXtr8zYx+s760cucqQSjEPKy9jxf
 9gbCv/LzjvB0YeiRFUp1z2BWctj0IEYGahSTW/5ZTdEwV6Dz0z7dqb3kL+ZYqytDYHA3N+
 WQ2jV39S8l8ZMlNp+Rye1KPFai++2u0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-S_M9zWtkOmOpLsiO35__LQ-1; Mon, 17 Apr 2023 03:11:46 -0400
X-MC-Unique: S_M9zWtkOmOpLsiO35__LQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 x9-20020ac85f09000000b003e4ecb5f613so11515015qta.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 00:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681715506; x=1684307506;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3DxIGeDChpW+dCspX207xU3KDB22/OENqLPHBuTpQk8=;
 b=Xw9cTvpnhhOlKQQQlRLlNJKmqviTM9VGdBrQPAnhVDRzYu1G5bjMZTf3qUr4L5CDrI
 KN6xPyVKcQy1/YNRg95CofWszDhd2euZVcBFvWJ6QuZZSp9Yz3qhhAYPxpWnRJIHwuhe
 nY9fbntxnhwGX45lHpb3YuQqmGNL4F6ZMTCDnDmn4tDk55JtC0BgbsHzkaiF0P/7P9eD
 IXcc7FYbiBC2Mr1dFdrDzCOTK2hyOh1EnqQfHxIeT0CBFwC/thW1sRpfUwy+OO9AiOF7
 ZXBtmRGsZY0BZLhrva/a7qTH+7I8NWwDzLWCaB/nPw2VslFAxKCtGGgbNVFanIEkMXaS
 090w==
X-Gm-Message-State: AAQBX9dU9qFh5jKIEeR1ZgkXqsBinlL5sjP7b2+R/8KLL0bSRNleouVx
 jasdSupGpPmfyryiKYVAkEbVtNkFrFewSHEl7G/iX593FozVwLL9TzNYXMJJhoKr7q/t1Bg4Lj5
 wLvfXhW0JFnRj+Z99g2D5ZWdhC0HZPrAA90a1B3imDQ==
X-Received: by 2002:a05:622a:15c8:b0:3e6:7634:3d0a with SMTP id
 d8-20020a05622a15c800b003e676343d0amr20401069qty.1.1681715505867; 
 Mon, 17 Apr 2023 00:11:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRWAwroeDDp+zaMLOKHGqZ0C7Fj+pnRJZLP5CoVXzD2w0JJpOmAxj/pZFif7P2SmN4qP2jFA==
X-Received: by 2002:a05:622a:15c8:b0:3e6:7634:3d0a with SMTP id
 d8-20020a05622a15c800b003e676343d0amr20401058qty.1.1681715505638; 
 Mon, 17 Apr 2023 00:11:45 -0700 (PDT)
Received: from redhat.com ([185.199.103.251]) by smtp.gmail.com with ESMTPSA id
 z1-20020ac81001000000b003b9b8ec742csm3089121qti.14.2023.04.17.00.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Apr 2023 00:11:45 -0700 (PDT)
Date: Mon, 17 Apr 2023 03:11:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230417031052-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
 <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <1681713856.1928573-2-xuanzhuo@linux.alibaba.com>
 <AM0PR04MB4723EB7A5E42A090F63EEC11D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723EB7A5E42A090F63EEC11D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

On Mon, Apr 17, 2023 at 07:07:59AM +0000, Alvaro Karsz wrote:
> > Why tx timeout without frags?
> 
> Please see my response to Michael.
> 
> > > * Guest GSO/big MTU (without VIRTIO_NET_F_MRG_RXBUF?), we can't chain page size buffers anymore.
> > 
> > 
> > Or, we disable the GUEST_GSO, HOST_GSO......
> > 
> And disable VIRTIO_NET_F_MTU, quoting the spec:
> "A driver SHOULD negotiate VIRTIO_NET_F_MTU if the device offers it."

If you don't the nic can still get jumbo packets it will just drop them ...

> We can find a way around using buffers bigger than a page size like Michael implied.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
