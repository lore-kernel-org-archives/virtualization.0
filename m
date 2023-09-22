Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9217BE6FE52
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 15:41:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3881141E3B;
	Fri, 22 Sep 2023 15:41:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3881141E3B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=duQw8ZX1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qvz04od_qXhr; Fri, 22 Sep 2023 15:41:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 69ED541D9A;
	Fri, 22 Sep 2023 15:41:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69ED541D9A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E5D1C0071;
	Fri, 22 Sep 2023 15:41:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 423E2C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1BFF3401DD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:41:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BFF3401DD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=duQw8ZX1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jf9GVm_cUjjU
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:41:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5E7DE400BA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 15:41:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E7DE400BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h8GGyR26HgCvGZhzwOcL9OwZXNmbEGB0FfnJLE3ENiQ=;
 b=duQw8ZX1Apm8KXKSdN0EgOCoanMK1rlIACJFWVJiNhm+bv1u9OVBnf7N3nzUz8p3VeRChU
 OtiqGe7EZSo91sKTPHFu/WEB3bkDIkNUUMwkEpuFBt8gP1IN/9P5vLonvuglsPzdbVlG6R
 vmyZmquunYBQT+TOBOS8BTst+yWbMCE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-hDnFNL4LO7C-nDxq5a2JKQ-1; Fri, 22 Sep 2023 11:41:04 -0400
X-MC-Unique: hDnFNL4LO7C-nDxq5a2JKQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a647551b7dso499193466b.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 08:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397263; x=1696002063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8GGyR26HgCvGZhzwOcL9OwZXNmbEGB0FfnJLE3ENiQ=;
 b=ZuyBLLsmIq6tOpc7BSsyR5m6Td9XOPlCtUrnaxBmtzN5zUHq8DaRggjPKBm4SDx6WP
 H1LUIcNkMXhrL2yKkYBCL5puY9OcoFzpFffQp/a8BM1/bMfYWyKwWVzoa83JY3XRUtV2
 zXapFu/KzFnxhDCxwZ8OGIokJE6yLYO/otIdkzMVnZK7k99X44Xn9PZ5LVVK6DoETHO3
 /v2ey3S1i0kRi10Df0/QFMqlZ9IJUkUe3BHaI03qWFSLOuie2pRDbZi2KY8tZ4V2jB3v
 xLiknI+w6ITUkKhXTLLTF+A/xBsIpJMSmMCEcfJpAcyQOz5xKLurpDCmbdc/4ZDCAcn1
 NAug==
X-Gm-Message-State: AOJu0YyhGH7ehPLc4i75OE2EoEmOLEy/shGCr4TqHjPy/u0pg6TryBHk
 aplg/YEmqXm8OOJKLn4MngxcpHLdNYm21gTUe4rdR0DT45Qd+Ihxb5rkeo+ALZGGlHb20ogW0Qm
 U9eDsTzSt0VtV5tIWq2lL9+8dC3js+j+f0xO0oWyzJw==
X-Received: by 2002:a17:907:6d04:b0:9ae:6648:9b53 with SMTP id
 sa4-20020a1709076d0400b009ae66489b53mr3779632ejc.23.1695397263534; 
 Fri, 22 Sep 2023 08:41:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF6Im2F1q9fQJV66ag6DVrZfORAIji4sdcacv5WHHxSTwxyC0yMCUrXkbhWQkVCbgte5hXHQ==
X-Received: by 2002:a17:907:6d04:b0:9ae:6648:9b53 with SMTP id
 sa4-20020a1709076d0400b009ae66489b53mr3779605ejc.23.1695397263189; 
 Fri, 22 Sep 2023 08:41:03 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 lo18-20020a170906fa1200b0099bd1a78ef5sm2864932ejb.74.2023.09.22.08.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:41:02 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:40:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230922113941-mutt-send-email-mst@kernel.org>
References: <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230922111132-mutt-send-email-mst@kernel.org>
 <20230922151534.GR13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230922151534.GR13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jiri Pirko <jiri@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>
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

On Fri, Sep 22, 2023 at 12:15:34PM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 11:13:18AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 22, 2023 at 12:25:06PM +0000, Parav Pandit wrote:
> > > 
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Friday, September 22, 2023 5:53 PM
> > > 
> > > 
> > > > > And what's more, using MMIO BAR0 then it can work for legacy.
> > > > 
> > > > Oh? How? Our team didn't think so.
> > > 
> > > It does not. It was already discussed.
> > > The device reset in legacy is not synchronous.
> > > The drivers do not wait for reset to complete; it was written for the sw backend.
> > > Hence MMIO BAR0 is not the best option in real implementations.
> > 
> > Or maybe they made it synchronous in hardware, that's all.
> > After all same is true for the IO BAR0 e.g. for the PF: IO writes
> > are posted anyway.
> 
> IO writes are not posted in PCI.

Aha, I was confused. Thanks for the correction. I guess you just buffer
subsequent transactions while reset is going on and reset quickly enough
for it to be seemless then?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
