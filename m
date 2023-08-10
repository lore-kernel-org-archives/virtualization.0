Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A53C001DE
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 21:42:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E10D41DF6;
	Thu, 10 Aug 2023 21:42:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E10D41DF6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DgYXhQNa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4o_zR_94J1gB; Thu, 10 Aug 2023 21:42:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E882141DFB;
	Thu, 10 Aug 2023 21:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E882141DFB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6120C0071;
	Thu, 10 Aug 2023 21:42:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47EC6C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 21:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1913C4061F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 21:42:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1913C4061F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DgYXhQNa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rTGNm8O5qzsL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 21:42:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 47464400DC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 21:42:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47464400DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691703738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2HtcNk1A7Nq+3/V6wlbgltFs7j7KhU3JDIUkHEFT9ak=;
 b=DgYXhQNaXTFcSKkKxvrNJ/Z2kgbh9xhpxxykVQkFxFE/BZwBVj/CCxdG3PwsWVGiu9RV25
 n6ttrXQuECOOhr/v2jKq4LCneqTgJP2QPOxedFtxv3F7+qES9XgSqCrsi+oFBRtiP/thAp
 19dCqUcPiGIw0M7zS+EC6Yv2Km3D+Ns=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Rx4fxhrCPoyGzVV94IhENQ-1; Thu, 10 Aug 2023 17:42:16 -0400
X-MC-Unique: Rx4fxhrCPoyGzVV94IhENQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fe4bda379fso9029575e9.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 14:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691703735; x=1692308535;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HtcNk1A7Nq+3/V6wlbgltFs7j7KhU3JDIUkHEFT9ak=;
 b=DGF9/i/z0D3/HPKp2Soi0KPrIPiyIKcrb7cmXRkqG9CTn3WpzBuclmpNQynyJEPayb
 82YU1mqM7uS85IFfyp48SUX84ikDXduKEWWm5EXh2hA9/I1ptfX5ensJvB0HsOLNXzkW
 dyuDR9T72HVCG3WdJ3trNBz2ygO6O2mPqK1bMkh5/ntTsF8YEsCVdX8KhC9nPurU0gXz
 VG9tLS4fyMoz9On77t52pelu1kBKMMOim0KizVgMjAk6+87kt59iRB7xeAZONU24MDsN
 13qvHZ3208p2lc93dTVp901MK/ld+Nr8W12NLAI7theVGd5uYMm2+uREz0X14jwj/JMk
 Igpw==
X-Gm-Message-State: AOJu0YwgR75wRi06QrNDFgraT+mIcxTYaFJ8DjxdF4XrjF7y+6/gMBB5
 Dis7sYIA9WX+QJVFy4svuzFeaOUK0mdofGhhjS1GsvDJmMXFXNPOvPcMd66ui2pFmJbiJwRHYe9
 +quslRKsFZsmbxAeLefQJSnxGRqEBPhmdUH+EhUTGww==
X-Received: by 2002:a05:600c:218f:b0:3fc:186:284d with SMTP id
 e15-20020a05600c218f00b003fc0186284dmr107042wme.18.1691703735765; 
 Thu, 10 Aug 2023 14:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8OFCHupC30sqzZHz8wZXJmFsOw+UxdKSTyakavwrTBFMqwiyoteEVk+I7wC7S8jsf3rwrDQ==
X-Received: by 2002:a05:600c:218f:b0:3fc:186:284d with SMTP id
 e15-20020a05600c218f00b003fc0186284dmr107027wme.18.1691703735439; 
 Thu, 10 Aug 2023 14:42:15 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 y9-20020a7bcd89000000b003fba6a0c881sm6129528wmj.43.2023.08.10.14.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 14:42:14 -0700 (PDT)
Date: Thu, 10 Aug 2023 17:42:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230810174021-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230810142949.074c9430@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Maxime Coquelin <maxime.coquelin@redhat.com>, david.marchand@redhat.com
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

On Thu, Aug 10, 2023 at 02:29:49PM -0700, Jakub Kicinski wrote:
> On Thu, 10 Aug 2023 15:04:27 -0400 Michael S. Tsirkin wrote:
> > Another question is that with this userspace can inject
> > packets directly into net stack. Should we check CAP_NET_ADMIN
> > or such?
> 
> Directly into the stack? I thought VDUSE is vDPA in user space,
> meaning to get to the kernel the packet has to first go thru 
> a virtio-net instance.

yes. is that a sufficient filter in your opinion?

> Or you mean directly into the network?

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
