Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDD8C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:32:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F08460BE3;
	Mon, 15 Aug 2022 21:32:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6F08460BE3
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ao1NyTdv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ocr1329rxSGd; Mon, 15 Aug 2022 21:32:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D2BD960783;
	Mon, 15 Aug 2022 21:32:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2BD960783
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0DFBC0033;
	Mon, 15 Aug 2022 21:32:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B54FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5E8BD60BE3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:32:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5E8BD60BE3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ts3PWg59n_L4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:32:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EC2160BD6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EC2160BD6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660599135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C5E1PnMcfUBlqR4DgvXh0RULdXNDlbBNqvxltGmBpAA=;
 b=ao1NyTdvX2vv5oM20vq4sXffeBk+83fp9G1XvfAdjhOigQ5zUC2l2R+lI6cblQGz5Xv1Nh
 DsZycGScAJBvDrMy5H43LxSL7MKX8KYBIH4efYwv+cLtHKS3zcivGMpY1XGjrx3wDZiyG5
 LJ6InFib9w80aKCcC/XupYgt3xnSyZw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-LJJmPaDaMluR9JIrm6A-3Q-1; Mon, 15 Aug 2022 17:32:14 -0400
X-MC-Unique: LJJmPaDaMluR9JIrm6A-3Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 az42-20020a05600c602a00b003a552086ba9so9213092wmb.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 14:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=C5E1PnMcfUBlqR4DgvXh0RULdXNDlbBNqvxltGmBpAA=;
 b=bVm4OFdxE8qXVySdaDKnu3nnd+/jLpBhN+E05Teib0fQXJgWhnvaGTaPqa585ZOpvz
 kc+7AYtS7GAxOhcdMfshzhmHg8CvnqDXqtztm1z6+f9naMNLfEmSUTCW2iUrZKSIzNci
 pfeAguVDxKR6m6hb6PfMjP4HoKTdjoVYJaRNlsB507tIY9PcV4T3Ebx7fJiuN119pS2r
 SzFeOTPciE2Dd0FOoPCKFspoG6p3kmw0QDPBx74roj0GdR3oFqIiZm7cZTlJ769q8lIS
 RdG2kCLeTuPvNhddX1A6oqQtoje8ei9w+ZcgDLgaWy7GHfB3qEnEqBIXBZxmfEYYJEJZ
 3rrw==
X-Gm-Message-State: ACgBeo3BKqNZgxBlrGVn3GDoPmOGPG/rVSBjU+WJAgkaolwiT3YOoMxG
 VQo2woony1WAy3lKlMGONy+ByiVBCIHg+Oyy32P2YaNmvhLRLA6KPiTYGyKMGcu+aHFgS02ljcq
 Gj6vONbbyRx0yfLhAPgamMtyzBfvAgsmxVSH061wQ7w==
X-Received: by 2002:a7b:cb0e:0:b0:3a5:afff:d520 with SMTP id
 u14-20020a7bcb0e000000b003a5afffd520mr16640113wmj.3.1660599131760; 
 Mon, 15 Aug 2022 14:32:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5my+YWP5JS5ii6nnYx6L/bxpBqCs3VguhrRqaU9wVo6Wtqyap4pIk+XVs3eMaM58GGNIiRvA==
X-Received: by 2002:a7b:cb0e:0:b0:3a5:afff:d520 with SMTP id
 u14-20020a7bcb0e000000b003a5afffd520mr16640100wmj.3.1660599131522; 
 Mon, 15 Aug 2022 14:32:11 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 q13-20020a056000136d00b00224f5bfa890sm7444926wrz.97.2022.08.15.14.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 14:32:10 -0700 (PDT)
Date: Mon, 15 Aug 2022 17:32:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andres Freund <andres@anarazel.de>
Subject: Re: upstream kernel crashes
Message-ID: <20220815170444-mutt-send-email-mst@kernel.org>
References: <20220815034532-mutt-send-email-mst@kernel.org>
 <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
 <20220815042623-mutt-send-email-mst@kernel.org>
 <FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE@anarazel.de>
 <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de>
 <20220815124748-mutt-send-email-mst@kernel.org>
 <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
 <20220815161423-mutt-send-email-mst@kernel.org>
 <20220815205330.m54g7vcs77r6owd6@awork3.anarazel.de>
MIME-Version: 1.0
In-Reply-To: <20220815205330.m54g7vcs77r6owd6@awork3.anarazel.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

On Mon, Aug 15, 2022 at 01:53:30PM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-15 16:21:51 -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 15, 2022 at 10:46:17AM -0700, Andres Freund wrote:
> > > Hi,
> > >
> > > On 2022-08-15 12:50:52 -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Aug 15, 2022 at 09:45:03AM -0700, Andres Freund wrote:
> > > > > Hi,
> > > > >
> > > > > On 2022-08-15 11:40:59 -0400, Michael S. Tsirkin wrote:
> > > > > > OK so this gives us a quick revert as a solution for now.
> > > > > > Next, I would appreciate it if you just try this simple hack.
> > > > > > If it crashes we either have a long standing problem in virtio
> > > > > > code or more likely a gcp bug where it can't handle smaller
> > > > > > rings than what device requestes.
> > > > > > Thanks!
> > > > >
> > > > > I applied the below and the problem persists.
> > > > >
> > > > > [...]
> > > >
> > > > Okay!
> > >
> > > Just checking - I applied and tested this atop 6.0-rc1, correct? Or did you
> > > want me to test it with the 762faee5a267 reverted? I guess what you're trying
> > > to test if a smaller queue than what's requested you'd want to do so without
> > > the problematic patch applied...
> > >
> > >
> > > Either way, I did this, and there are no issues that I could observe. No
> > > oopses, no broken networking. But:
> > >
> > > To make sure it does something I added a debugging printk - which doesn't show
> > > up. I assume this is at a point at least earlyprintk should work (which I see
> > > getting enabled via serial)?
> > >
> 
> > Sorry if I was unclear.  I wanted to know whether the change somehow
> > exposes a driver bug or a GCP bug. So what I wanted to do is to test
> > this patch on top of *5.19*, not on top of the revert.
> 
> Right, the 5.19 part was clear, just the earlier test:
> 
> > > > > On 2022-08-15 11:40:59 -0400, Michael S. Tsirkin wrote:
> > > > > > OK so this gives us a quick revert as a solution for now.
> > > > > > Next, I would appreciate it if you just try this simple hack.
> > > > > > If it crashes we either have a long standing problem in virtio
> > > > > > code or more likely a gcp bug where it can't handle smaller
> > > > > > Thanks!
> 
> I wasn't sure about.
> 
> After I didn't see any effect on 5.19 + your patch, I grew a bit suspicious
> and added the printks.
> 
> 
> > Yes I think printk should work here.
> 
> The reason the debug patch didn't change anything, and that my debug printk
> didn't show, is that gcp uses the legacy paths...

Wait a second. Eureka I think!

So I think GCP is not broken.
I think what's broken is this patch:

commit cdb44806fca2d0ad29ca644cbf1505433902ee0c
Author: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date:   Mon Aug 1 14:38:54 2022 +0800

    virtio_pci: support the arg sizes of find_vqs()


Specifically:

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 2257f1b3d8ae..d75e5c4e637f 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -112,6 +112,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
                                  unsigned int index,
                                  void (*callback)(struct virtqueue *vq),
                                  const char *name,
+                                 u32 size,
                                  bool ctx,
                                  u16 msix_vec)
 {
@@ -125,10 +126,13 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
        if (!num || vp_legacy_get_queue_enable(&vp_dev->ldev, index))
                return ERR_PTR(-ENOENT);
 
+       if (!size || size > num)
+               size = num;
+
        info->msix_vector = msix_vec;
 
        /* create the vring */
-       vq = vring_create_virtqueue(index, num,
+       vq = vring_create_virtqueue(index, size,
                                    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
                                    true, false, ctx,
                                    vp_notify, callback, name);

   

So if you pass the size parameter for a legacy device it will
try to make the ring smaller and that is not legal with
legacy at all. But the driver treats legacy and modern
the same, it allocates a smaller queue anyway.


Lo and behold, I pass disable-modern=on to qemu and it happily
corrupts memory exactly the same as GCP does.


So the new find_vqs API is actually completely broken, it can not work for
legacy at all and for added fun there's no way to find out
that it's legacy. Maybe we should interpret the patch

So I think I will also revert

04ca0b0b16f11faf74fa92468dab51b8372586cd..fe3dc04e31aa51f91dc7f741a5f76cc4817eb5b4







> If there were a bug in the legacy path, it'd explain why the problem only
> shows on gcp, and not in other situations.
> 
> I'll queue testing the legacy path with the equivalent change.
> 
> - Andres
> 
> 
> Greetings,
> 
> Andres Freund

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
