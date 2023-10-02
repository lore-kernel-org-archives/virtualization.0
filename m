Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E1DE776CB
	for <virtualization@archiver.kernel.org>; Mon,  2 Oct 2023 22:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE21F819FC;
	Mon,  2 Oct 2023 22:30:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE21F819FC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SIEOssgf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UOCvN0MIF2AN; Mon,  2 Oct 2023 22:30:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 61F6781404;
	Mon,  2 Oct 2023 22:30:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 61F6781404
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45BA7C0039;
	Mon,  2 Oct 2023 22:30:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF862C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 22:30:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BB1AF60B8C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 22:30:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB1AF60B8C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SIEOssgf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vGGkMUkV16Wt
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 22:30:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A750260B2D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Oct 2023 22:30:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A750260B2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696285809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wbn3fa8P8IewLiEX3rTDe+XOocXVePLBhJKPnZQf5kQ=;
 b=SIEOssgfUKW7Ijyo5dpVHhpExnCQEtQTkajeKd3ar/Jyn37qTRTCYUAm5nJEP7o66eR7/n
 N+0SSvOajgDtcLDSR/J1KiMeCMwfPvktAMBr4eBo+evhYUvudLyeMCexYKvzBxwnYsW0gN
 yw+NkoSke8pexQ/ee4anwExyTtfjdAo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-3As5VrStMbepKZy0lnDy1g-1; Mon, 02 Oct 2023 18:30:08 -0400
X-MC-Unique: 3As5VrStMbepKZy0lnDy1g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-406227680a9so2137715e9.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Oct 2023 15:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696285807; x=1696890607;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbn3fa8P8IewLiEX3rTDe+XOocXVePLBhJKPnZQf5kQ=;
 b=D+Xgrrvf6IwS0lSwsKD6NbULcZj1ko3SR85l5UD7MoBqCcqwh6WEqqpW0JXJdch8xB
 Is+aWDYA/Fp5kPvUzTaE2e17+dd3D7zwVmBgjvS+L7SqUPLSrOnok12wqq5AJD8cqriQ
 UQyG4Btwv7YmRpt6sP5XvLpgGIYOxeEE9Mf9nwPOUWHJUBj46JyBxXpqFfPMTX/CMJmv
 A7s7MhxJYJHairNweKBe9J4VAUhLHiVx30OcGL0jgKdsYYNUFyOAhqhn0q2uE34YzZFq
 nhUQw3PPzzavD5gcERG660xad/9Z9llAiSUi91zFcekJSwUJBhOh6pds+AZ4o+ysOuPk
 qHRQ==
X-Gm-Message-State: AOJu0YyzuUxrMnQT+lYT5DiU9R+rO7dY5pni/8CQ4Ssy2KXXLHXvvvHH
 wJYckpGFkFjCCU083q/WY+6oCZaDTnqZHtKItDygDoyQFGYO0Gj5HBQEe6jjGKruC2WdbOAelIh
 k1h+ijUu8xQYWd6UJ7YbQkz+5YQKkAcKMaJrtIVTiyQ==
X-Received: by 2002:a05:600c:4750:b0:406:54e4:359c with SMTP id
 w16-20020a05600c475000b0040654e4359cmr12641733wmo.19.1696285806946; 
 Mon, 02 Oct 2023 15:30:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuaDhgwpzMP426f7VT7kXKb83tbiFTeg7u1xIljSoODijtyJKX8UEdZEjc/1qbOO4XnQAdUw==
X-Received: by 2002:a05:600c:4750:b0:406:54e4:359c with SMTP id
 w16-20020a05600c475000b0040654e4359cmr12641718wmo.19.1696285806567; 
 Mon, 02 Oct 2023 15:30:06 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 b13-20020a05600c11cd00b00405c33a9a12sm117791wmi.0.2023.10.02.15.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 15:30:05 -0700 (PDT)
Date: Mon, 2 Oct 2023 18:30:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] virtio_balloon: Fix endless deflation and inflation
 on arm64
Message-ID: <20231002182904-mutt-send-email-mst@kernel.org>
References: <20230831011007.1032822-1-gshan@redhat.com>
 <9efb4685-7c28-d51d-fd5b-aa2de8e5ded2@redhat.com>
 <53ec0cfb-37c8-f8e3-4cd3-53a390b2cd2b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <53ec0cfb-37c8-f8e3-4cd3-53a390b2cd2b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 zhenyzha@redhat.com, shan.gavin@gmail.com,
 virtualization@lists.linux-foundation.org
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

On Mon, Oct 02, 2023 at 01:50:45PM +0200, David Hildenbrand wrote:
> On 25.09.23 01:58, Gavin Shan wrote:
> > Hi David and Michael,
> > 
> > On 8/31/23 11:10, Gavin Shan wrote:
> > > The deflation request to the target, which isn't unaligned to the
> > > guest page size causes endless deflation and inflation actions. For
> > > example, we receive the flooding QMP events for the changes on memory
> > > balloon's size after a deflation request to the unaligned target is
> > > sent for the ARM64 guest, where we have 64KB base page size.
> > > 
> > >     /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
> > >     -accel kvm -machine virt,gic-version=host -cpu host          \
> > >     -smp maxcpus=8,cpus=8,sockets=2,clusters=2,cores=2,threads=1 \
> > >     -m 1024M,slots=16,maxmem=64G                                 \
> > >     -object memory-backend-ram,id=mem0,size=512M                 \
> > >     -object memory-backend-ram,id=mem1,size=512M                 \
> > >     -numa node,nodeid=0,memdev=mem0,cpus=0-3                     \
> > >     -numa node,nodeid=1,memdev=mem1,cpus=4-7                     \
> > >       :                                                          \
> > >     -device virtio-balloon-pci,id=balloon0,bus=pcie.10
> > > 
> > >     { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
> > >     {"return": {}}
> > >     {"timestamp": {"seconds": 1693272173, "microseconds": 88667},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272174, "microseconds": 89704},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272175, "microseconds": 90819},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272176, "microseconds": 91961},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272177, "microseconds": 93040},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> > >     {"timestamp": {"seconds": 1693272178, "microseconds": 94117},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> > >     {"timestamp": {"seconds": 1693272179, "microseconds": 95337},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272180, "microseconds": 96615},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> > >     {"timestamp": {"seconds": 1693272181, "microseconds": 97626},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272182, "microseconds": 98693},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> > >     {"timestamp": {"seconds": 1693272183, "microseconds": 99698},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272184, "microseconds": 100727},  \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272185, "microseconds": 90430},   \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     {"timestamp": {"seconds": 1693272186, "microseconds": 102999},  \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073676288}}
> > >        :
> > >     <The similar QMP events repeat>
> > > 
> > > Fix it by aligning the target up to the guest page size, 64KB in this
> > > specific case. With this applied, no flooding QMP events are observed
> > > and the memory balloon's size can be stablizied to 0x3ffe0000 soon
> > > after the deflation request is sent.
> > > 
> > >     { "execute" : "balloon", "arguments": { "value" : 1073672192 } }
> > >     {"return": {}}
> > >     {"timestamp": {"seconds": 1693273328, "microseconds": 793075},  \
> > >      "event": "BALLOON_CHANGE", "data": {"actual": 1073610752}}
> > >     { "execute" : "query-balloon" }
> > >     {"return": {"actual": 1073610752}}
> > > 
> > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
> > > ---
> > > v2: Align @num_pages up to the guest page size in towards_target()
> > >       directly as David suggested.
> > > ---
> > >    drivers/virtio/virtio_balloon.c | 6 +++++-
> > >    1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > 
> > If the patch looks good, could you please merge this to Linux 6.6.rc4 since
> > it's something needed by our downstream. I hope it can land upstream as early
> > as possible, thanks a lot.
> 
> @MST, I cannot spot it in your usual vhost git yet. Should I pick it up or
> what are your plans?

Yes - I merged it but I'm still testing my tree. Will be in
the next pull request.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
