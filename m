Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15E9CD98FD
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 08:13:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68BA681E21;
	Wed, 11 Oct 2023 08:13:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68BA681E21
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MUMaD+3I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qjSTKA9G1Frd; Wed, 11 Oct 2023 08:13:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 016D181E1F;
	Wed, 11 Oct 2023 08:13:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 016D181E1F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A58CCC0071;
	Wed, 11 Oct 2023 08:13:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4C23C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E4F2408D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8E4F2408D8
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MUMaD+3I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W3GdOy9-aVfE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:13:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69944408D5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 08:13:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69944408D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697011980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KJR9k3TyCi9rex4tczfmOP96qxEW6csQZHxstTbn6es=;
 b=MUMaD+3ILRmAgYNpKt9kzVVevBvW+T5+YBgAYk5EVF3Ae5QVJCdfW7HUa7exd4HdgNEJQP
 wKUVQyn1/9iM43tb6PiZTbcFRLUCF7KekpbRyEcQEefpsQllbJLlRIcnGt/l2jgfLEfXSV
 Wo5wSUdCjqQzwFWcj+PWoe6mNzLU4bM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-T0Yil6C9MqSoUEF_ANMCLQ-1; Wed, 11 Oct 2023 04:12:58 -0400
X-MC-Unique: T0Yil6C9MqSoUEF_ANMCLQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50338ca1663so6336443e87.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 01:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697011977; x=1697616777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJR9k3TyCi9rex4tczfmOP96qxEW6csQZHxstTbn6es=;
 b=AyXqzP1lToHfMd9xZeeQBMMvZ7cnp/r29nCdjFqGNkBkvd5I3UiKW9cNR8i9PFxIla
 hReKblgEzeMBSrPPLNQ8oEADkymMPCov3UZZ6jbIhvT5cFBqa2KBXkS6ubralVgF5zPu
 piv6g46t4RINZbnX78J+NOhbz8MDaa/1v41Qq+2/uYz1+85YFSb4tOcmwoZTrjXk3w1V
 vy8TPRtCjOWkCb/metyUJMQwr45dARb3+eJkAr79q3O6K5ICd6y6cc6mHLk6A/Z4l9ma
 Wm9EsEOA8phOeTKX89kpUcHACdppt0SVVYfv66EGaIFr6IgCvq81Yyzx0ptW2EXvXZET
 WfRA==
X-Gm-Message-State: AOJu0YyFrADH/m/SONjNfbma58TvUK+CXmTcZ71sx/zxLtGhbO1ZxJAr
 JpDmSOxsqXHqvjBFCwiX6qzoGrdngMETX8R773+3Yl3oT4qFfx8Qu4uBSofcfsThEFJVrscLuL8
 miHTKxSIbtz2AE+hSU8zHoryOWXPP/YbrxNx689cUOQ==
X-Received: by 2002:a05:6512:1089:b0:503:3808:389a with SMTP id
 j9-20020a056512108900b005033808389amr21020378lfg.11.1697011977043; 
 Wed, 11 Oct 2023 01:12:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGvRlYTp7ZjpbVRDV35Dk+uDQKxvqQ4kOkBKv489ldCkGcUWPdwk4vXDctVI+NDSRdGsoUhw==
X-Received: by 2002:a05:6512:1089:b0:503:3808:389a with SMTP id
 j9-20020a056512108900b005033808389amr21020348lfg.11.1697011976624; 
 Wed, 11 Oct 2023 01:12:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a5d5407000000b00327df8fcbd9sm14814757wrv.9.2023.10.11.01.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 01:12:55 -0700 (PDT)
Date: Wed, 11 Oct 2023 04:12:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231011041155-mutt-send-email-mst@kernel.org>
References: <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
 <20231010105339-mutt-send-email-mst@kernel.org>
 <e979dfa2-0733-7f0f-dd17-49ed89ef6c40@nvidia.com>
 <20231010111339-mutt-send-email-mst@kernel.org>
 <20231010155937.GN3952@nvidia.com> <ZSY9Cv5/e3nfA7ux@infradead.org>
 <20231011021454-mutt-send-email-mst@kernel.org>
 <ZSZHzs38Q3oqyn+Q@infradead.org>
MIME-Version: 1.0
In-Reply-To: <ZSZHzs38Q3oqyn+Q@infradead.org>
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

On Tue, Oct 10, 2023 at 11:59:26PM -0700, Christoph Hellwig wrote:
> On Wed, Oct 11, 2023 at 02:43:37AM -0400, Michael S. Tsirkin wrote:
> > > Btw, what is that intel thing everyone is talking about?  And why
> > > would the virtio core support vendor specific behavior like that?
> > 
> > It's not a thing it's Zhu Lingshan :) intel is just one of the vendors
> > that implemented vdpa support and so Zhu Lingshan from intel is working
> > on vdpa and has also proposed virtio spec extensions for migration.
> > intel's driver is called ifcvf.  vdpa composes all this stuff that is
> > added to vfio in userspace, so it's a different approach.
> 
> Well, so let's call it virtio live migration instead of intel.
> 
> And please work all together in the virtio committee that you have
> one way of communication between controlling and controlled functions.
> If one extension does it one way and the other a different way that's
> just creating a giant mess.

Absolutely, this is exactly what I keep suggesting. Thanks for
bringing this up, will help me drive the point home!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
