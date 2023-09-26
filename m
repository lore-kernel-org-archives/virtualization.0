Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6C8E7E626
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 11:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E07CD80EAA;
	Tue, 26 Sep 2023 11:49:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E07CD80EAA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d1jeYG8M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ThpW7zn92sBT; Tue, 26 Sep 2023 11:49:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8CDEB81234;
	Tue, 26 Sep 2023 11:49:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CDEB81234
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 540B0C0071;
	Tue, 26 Sep 2023 11:49:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30B4DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9B5741DB7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:49:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9B5741DB7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=d1jeYG8M
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KXO8hMAE6jAi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:49:23 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 133B741DB3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 11:49:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 133B741DB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695728961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rn26GZx7iEMFes15hPD/QXW1aPy6SBHdulzAjklMMFQ=;
 b=d1jeYG8MKPr6VXPId4Xzmxokxf4Zq/Au9cfsak6pUOQ/OKbeecIVsMebrsFNtp31DE8+7N
 oGtsEie8TgPF684PJZh1awE/uCJBsF5+dIHDdi26VKRldxnVstIH8GTjQO37kenn05UZix
 E3R5+QEaeiKXpzH8AsJPRuxjtFgkahE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-E0wg-2MZOrWOgM3HN7ALXw-1; Tue, 26 Sep 2023 07:49:20 -0400
X-MC-Unique: E0wg-2MZOrWOgM3HN7ALXw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso693450766b.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695728959; x=1696333759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rn26GZx7iEMFes15hPD/QXW1aPy6SBHdulzAjklMMFQ=;
 b=V5naEVCLiOqQLDOjFm+ZRc3T0e/BcbYiGC/WGtMQo9MZjAmXerI8O8qcuKsSispjRE
 6M2BGzh507TPCA+E1ofeWmNwzH745/siK6NO747fwE4GoFZqIdOxjoEpcbq1JlWZTRhn
 ExTDo4aapg7M+dR6KrXF+IFqEp+yVuLJmY05a+hjEBexSOlpuipsEBRSuzxtAfu3oR6y
 aDWhotxEZE8wLDt+hnWhS9Zr4MoBmaSo/UiNhssRCVG7tAVGrYlRORLZLYBAKRvNnWOE
 n5mdsyIlYCwo2Y1+sTKIvVFjs67ZV7RTZ8gI/NWjhQDnHT5yrmEDgeOVPSYWeLXDO//M
 lh2A==
X-Gm-Message-State: AOJu0YxxRZ52LxahTVA7lpT6JPnNycft4IeV+rZKy0VKFTQtc3XXIZQr
 z0kw6CJh8gnPMCkdzavrJ5c6Ii9k96Lademlb9qOGJ1VoLi6JdBQ4mbbMemiYtBS3ooXaS+gvPG
 VQmWgCUOUtK9iGp5ElKB1B4epyt9RvhSSB8HjCu6vSw==
X-Received: by 2002:a17:906:1bb1:b0:9ae:3d17:d5d0 with SMTP id
 r17-20020a1709061bb100b009ae3d17d5d0mr8592492ejg.31.1695728959724; 
 Tue, 26 Sep 2023 04:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh6wPENW7EVBACR9Vb/Wc56um6GyOBGTE8QTlhaORLYVTFCoMGcZFTrxB//pXG2+0p0JOmIg==
X-Received: by 2002:a17:906:1bb1:b0:9ae:3d17:d5d0 with SMTP id
 r17-20020a1709061bb100b009ae3d17d5d0mr8592474ejg.31.1695728959330; 
 Tue, 26 Sep 2023 04:49:19 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 l5-20020a170906a40500b009ae4ead6c01sm7633080ejz.163.2023.09.26.04.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 04:49:18 -0700 (PDT)
Date: Tue, 26 Sep 2023 07:49:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230926074520-mutt-send-email-mst@kernel.org>
References: <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuX5HJVBOw9E+skr=K=QzH3oyHK8gk-r0hAvi6Wm7OA7Q@mail.gmail.com>
 <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEv9_+6sYp1JZpCZr19csg0jO-jLVhuygWqm+s9mWr3Lew@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEv9_+6sYp1JZpCZr19csg0jO-jLVhuygWqm+s9mWr3Lew@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

On Tue, Sep 26, 2023 at 10:32:39AM +0800, Jason Wang wrote:
> It's the implementation details in legacy. The device needs to make
> sure (reset) the driver can work (is done before get_status return).

I think that there's no way to make it reliably work for all legacy drivers.

They just assumed a software backend and did not bother with DMA
ordering. You can try to avoid resets, they are not that common so
things will tend to mostly work if you don't stress them to much with
things like hot plug/unplug in a loop.  Or you can try to use a driver
after 2011 which is more aware of hardware ordering and flushes the
reset write with a read.  One of these two tricks, I think, is the magic
behind the device exposing memory bar 0 that you mention.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
