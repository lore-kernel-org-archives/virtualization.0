Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F848E7D0A2
	for <virtualization@archiver.kernel.org>; Thu, 21 Sep 2023 20:16:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2790613CC;
	Thu, 21 Sep 2023 20:16:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A2790613CC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cxM5dPtP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SMzhbQXfXcYk; Thu, 21 Sep 2023 20:16:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3452760E11;
	Thu, 21 Sep 2023 20:16:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3452760E11
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E872BC0071;
	Thu, 21 Sep 2023 20:16:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE1DDC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:16:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4DCC83CD7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:16:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A4DCC83CD7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cxM5dPtP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id orsRBfAAwc8s
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:16:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB45A83CB1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 20:16:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB45A83CB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695327394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=saWUZSrGIUgLKbATr2AiGYIolUiT02alWb7IzP9TXk0=;
 b=cxM5dPtPuM8jJR3AF5RotYxiHAb1dkKTX5Irx+U2Cv7lW/CpnJHxZMBC0pSFvIUWWe1Vcq
 rnehNlYSowllIKQgbqXwvp3SRzqmYjqCcRebxM+M832luf2zG07wrDe5qgowt7sgGSBUPP
 /WtfsiCDD0v1w+MxeDCdFbHTbuIRNAg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-HPPF1HOHOK67HPWmMcAyfA-1; Thu, 21 Sep 2023 16:16:31 -0400
X-MC-Unique: HPPF1HOHOK67HPWmMcAyfA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a355cf318so103799266b.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 13:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695327390; x=1695932190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saWUZSrGIUgLKbATr2AiGYIolUiT02alWb7IzP9TXk0=;
 b=dEGpj3aQQbCrd6ByzIlvyU5iXSrbwPJOl2uqOFU368EMujWS2Vz8X5dUy9Y7fe4cvX
 yOf96H/p3/ezedVX2RZJwYRdMi35g3IfmcAixyT/5Ig6ynjm9NC0XxC5194iJ5MMxgdR
 cbHVtcDyGjELmIuwGrzV2SzyNTxoaqEfRIenJsUUuw8MX05gF6jwGSuWzKKj4ul7SeUl
 TJ7W+QQSXO1BVmjLFsQD4LAQBNC3X6Fp6+gEyz+XaM3ggyYqRSryyffvqN1qmK+M0uzg
 9cx223HDco5dbHbfk4X+Q/b9MYW7GOe6puWlgVIYyBOs/r2Jj9xv5cImqR/hZCakK/om
 ND6w==
X-Gm-Message-State: AOJu0YxV/XhHm+IgD3LpuQ5T7frtNN+4T+YuvMU+IFiK7LTeLqD2Gn6V
 Dv81TQpLm5O63z7LNOaek0DFUb7wmF9Xkb+vf/qlQPOZHDdipi2a2zXHd1Ft7oSJyX4GUq/iH61
 JJg+XD4ClA+NUbNhomQ5HgIqnXU4VDpDK/78d3lFYrA==
X-Received: by 2002:a17:906:2112:b0:9ae:46c7:90fe with SMTP id
 18-20020a170906211200b009ae46c790femr4601443ejt.72.1695327390500; 
 Thu, 21 Sep 2023 13:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGkqXZayrmqEI+6vajAalt0bMQCUu66YrBGYtF+rfYkKFS9tp0WSXzHgpz2lWhey55wX1zpw==
X-Received: by 2002:a17:906:2112:b0:9ae:46c7:90fe with SMTP id
 18-20020a170906211200b009ae46c790femr4601417ejt.72.1695327390172; 
 Thu, 21 Sep 2023 13:16:30 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 rh27-20020a17090720fb00b0099b6becb107sm1543511ejb.95.2023.09.21.13.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 13:16:29 -0700 (PDT)
Date: Thu, 21 Sep 2023 16:16:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
Message-ID: <20230921155834-mutt-send-email-mst@kernel.org>
References: <20230921104350.6bb003ff.alex.williamson@redhat.com>
 <20230921165224.GR13733@nvidia.com>
 <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230921195345.GZ13733@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org, jiri@nvidia.com, leonro@nvidia.com
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

On Thu, Sep 21, 2023 at 04:53:45PM -0300, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 03:34:03PM -0400, Michael S. Tsirkin wrote:
> 
> > that's easy/practical.  If instead VDPA gives the same speed with just
> > shadow vq then keeping this hack in vfio seems like less of a problem.
> > Finally if VDPA is faster then maybe you will reconsider using it ;)
> 
> It is not all about the speed.
> 
> VDPA presents another large and complex software stack in the
> hypervisor that can be eliminated by simply using VFIO.

If all you want is passing through your card to guest
then yes this can be addressed "by simply using VFIO".

And let me give you a simple example just from this patchset:
it assumes guest uses MSIX and just breaks if it doesn't.
As VDPA emulates it can emulate INT#x for guest while doing MSI
on the host side. Yea modern guests use MSIX but this is about legacy
yes?


> VFIO is
> already required for other scenarios.

Required ... by some people? Most VMs I run don't use anything
outside of virtio.

> This is about reducing complexity, reducing attack surface and
> increasing maintainability of the hypervisor environment.
> 
> Jason

Generally you get better security if you don't let guests poke at
hardware when they don't have to. But sure, matter of preference -
use VFIO, it's great. I am worried about the specific patchset though.
It seems to deal with emulating virtio which seems more like a vdpa
thing. If you start adding virtio emulation to vfio then won't
you just end up with another vdpa? And if no why not?
And I don't buy the "we already invested in this vfio based solution",
sorry - that's not a reason upstream has to maintain it.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
