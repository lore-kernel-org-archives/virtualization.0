Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD01CD98F3
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 06:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1BD9840569;
	Wed, 11 Oct 2023 06:43:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BD9840569
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hpAGODKu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XPhDcCpt224T; Wed, 11 Oct 2023 06:43:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5713740289;
	Wed, 11 Oct 2023 06:43:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5713740289
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E583C0039;
	Wed, 11 Oct 2023 06:43:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDD4FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 06:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B967940354
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 06:43:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B967940354
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S9UCIR5DiZ1c
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 06:43:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 691CE40289
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 06:43:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 691CE40289
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697006624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mJx1ZypuyCBhHofs+m0EruMV3iKJ6PM06dyDEb4T+8w=;
 b=hpAGODKumpydQt50JmAGepzvIvNCIgHBU0HW+hL3v5iLgmLRO6YzyHUsWlu7+VQdGjuJnr
 yfx+ZK2gl54UBRBDjy1oU55cCfeqf8/LuEV/5/z/D8+/FAuczQrCHX9yB0LDdBOUceRPEk
 eCo2sQ7jDvxF1BQS2ZXyqbiVoW9XUmg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-7M5sJdEQNpayANFb2VwVgQ-1; Wed, 11 Oct 2023 02:43:42 -0400
X-MC-Unique: 7M5sJdEQNpayANFb2VwVgQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d87abc226so144889f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 23:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697006621; x=1697611421;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJx1ZypuyCBhHofs+m0EruMV3iKJ6PM06dyDEb4T+8w=;
 b=Zf3V3t0aOGNVBP7IlAJlw8H95V2eI4J6RQJ5O37bi5rL9iBRv6DTEhVRdSfAK+ZbW7
 5yap5fbu2BCcNCRMV9lmmOSmA4HC6gRfkh0rsv/hNvYOzLnRDPJHexKwQSVXCWbKQBhy
 dLsAXY4gn3O58fk4hVxILrVpvm/p4cnvNURkkVmXf2e75zXsA47Qf1csb4CEDhZSwN/H
 41CIzqD2f0yzuUC+1R6pTmvFuv4z9kPv9nLDDfQxFgtrCrMTQLN/Ah258qyb+RMI20pX
 fuFzWsRlMc4FdCz8PUgjyKPtXGV5zDecZymKlJZal3qNMfn0ddRGvEQGCb0NKFyLorMj
 gu3Q==
X-Gm-Message-State: AOJu0YzzzNb8OsrMowts1Xv85HAcVWPDb91cBVnxl7UdFMAJX+kWJwED
 Nd+1HdTruXnDkdLwSy+ggTv10DO/rcc0j2bHQjbJmvaOM619/l66q3zJPv8e9cmqxatYPO9X662
 qwqNPuaGQArKTzkdEkCdtODPjVraxhbQK3OXJpEfTkg==
X-Received: by 2002:a05:6000:24d:b0:32d:84a3:f3fe with SMTP id
 m13-20020a056000024d00b0032d84a3f3femr691991wrz.41.1697006621585; 
 Tue, 10 Oct 2023 23:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8A2qvfZT9bfpQ4OGYXjkie2YsT/ReG59ydBRsD0X364kMDllO/yZ7REyYw6wH9Rau1hYO9g==
X-Received: by 2002:a05:6000:24d:b0:32d:84a3:f3fe with SMTP id
 m13-20020a056000024d00b0032d84a3f3femr691972wrz.41.1697006621226; 
 Tue, 10 Oct 2023 23:43:41 -0700 (PDT)
Received: from redhat.com ([147.235.219.90]) by smtp.gmail.com with ESMTPSA id
 r25-20020adfa159000000b0032d819a8900sm1706874wrr.27.2023.10.10.23.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 23:43:40 -0700 (PDT)
Date: Wed, 11 Oct 2023 02:43:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231011021454-mutt-send-email-mst@kernel.org>
References: <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZSY9Cv5/e3nfA7ux@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
 jiri@nvidia.com, leonro@nvidia.com
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

On Tue, Oct 10, 2023 at 11:13:30PM -0700, Christoph Hellwig wrote:
> On Tue, Oct 10, 2023 at 12:59:37PM -0300, Jason Gunthorpe wrote:
> > On Tue, Oct 10, 2023 at 11:14:56AM -0400, Michael S. Tsirkin wrote:
> > 
> > > I suggest 3 but call it on the VF. commands will switch to PF
> > > internally as needed. For example, intel might be interested in exposing
> > > admin commands through a memory BAR of VF itself.
> > 
> > FWIW, we have been pushing back on such things in VFIO, so it will
> > have to be very carefully security justified.
> > 
> > Probably since that is not standard it should just live in under some
> > intel-only vfio driver behavior, not in virtio land.
> 
> Btw, what is that intel thing everyone is talking about?  And why
> would the virtio core support vendor specific behavior like that?

It's not a thing it's Zhu Lingshan :) intel is just one of the vendors
that implemented vdpa support and so Zhu Lingshan from intel is working
on vdpa and has also proposed virtio spec extensions for migration.
intel's driver is called ifcvf.  vdpa composes all this stuff that is
added to vfio in userspace, so it's a different approach.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
