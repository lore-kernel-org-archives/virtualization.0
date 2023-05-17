Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE72AC77B7F
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 10:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C7FC820ED;
	Wed, 17 May 2023 10:13:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C7FC820ED
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jBHB2kr7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZJXIqcxbAlKa; Wed, 17 May 2023 10:13:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9B41481E67;
	Wed, 17 May 2023 10:13:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B41481E67
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72446C0037;
	Wed, 17 May 2023 10:13:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B548C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 10:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6008D60E65
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 10:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6008D60E65
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jBHB2kr7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y3gX46578WVO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 10:13:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C18FB60E51
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C18FB60E51
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684318405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I2wx/HsJhUUdqsz7R5qMuiWwVG1FuENAd62XK76/qS8=;
 b=jBHB2kr7ujd9dBQWoXyd2YhhgsbPfmqs9Pb7NX+x/l+NNCmCxKTtX7OIGeWhfWdmJik4Ar
 +PaPptjSyNPmpTLdmxj5p3OFsTms80oKpJhE9mcB6+uf/0IsapvvzTiA7SnIt4y4W8dTA5
 obywxjkXHvAmYYFXIfjsUdDyGKdBfnk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-3YPI-PwkMaWxGagFcSjAXQ-1; Wed, 17 May 2023 06:13:24 -0400
X-MC-Unique: 3YPI-PwkMaWxGagFcSjAXQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f33f8ffa37so2208925e9.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 03:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684318403; x=1686910403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2wx/HsJhUUdqsz7R5qMuiWwVG1FuENAd62XK76/qS8=;
 b=TAktXAKokth3mQU4vN5pYAh3KgKGrQc2eGVrSG5XZkTWVcvJ1pVbHC2Zwx4hwkwNjQ
 +Y5Yb2LCKy8QldwTA4ouuom2PpmeZEUpCMwJcUa7qpfxWLy5p5dAAqweiG+30gBIe0rs
 mgcBY1DDmP8jnpp3JxTEAoBmVmTCK2MGr8+IrM5dKj7Jgqjia6OL6zphMSQL/Ss418Y5
 JncAMwnwHJ+HYld1jYkazL/1WF2Sy/mG3YanYlP1bx2yYjyZdViJHIWfLvGHEcyCb1Ql
 yCTlpi3gXyfxA2QJPzvHmstIjHU8iJksZdaQpn+Ko2vgE1f4/Q37ScyhMkwrIyw21Aak
 hC9g==
X-Gm-Message-State: AC+VfDwZXfucnkfXLUb2NRvcIQVwOW/Mot7cnO5oZ6+8qfGxINfBwhHh
 IDOSBL5QAioX/mTRAAalocOzqq7UTWxGWfLY90MnOs+l1KMiK7nFDhJ1QAgYuh1teG+0X76OjVB
 lc1VT7pSOzzzgD3brHe0Khlw3EBBlMuMKevBsuUkjMQ==
X-Received: by 2002:a7b:c846:0:b0:3f5:1980:ad43 with SMTP id
 c6-20020a7bc846000000b003f51980ad43mr2663452wml.31.1684318403019; 
 Wed, 17 May 2023 03:13:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73+Ow9A8iGZ2I7XMdEwZHisBEr3+oOaglzf/0hAGadudfZm+Nhadvv93jmpnbpOJYRyatYsA==
X-Received: by 2002:a7b:c846:0:b0:3f5:1980:ad43 with SMTP id
 c6-20020a7bc846000000b003f51980ad43mr2663436wml.31.1684318402615; 
 Wed, 17 May 2023 03:13:22 -0700 (PDT)
Received: from redhat.com ([2.52.6.43]) by smtp.gmail.com with ESMTPSA id
 f21-20020a7bcc15000000b003f31d44f0cbsm1765534wmh.29.2023.05.17.03.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 03:13:21 -0700 (PDT)
Date: Wed, 17 May 2023 06:13:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: Re: Re: Re: [PATCH v2 0/2] virtio: abstract virtqueue related
 methods
Message-ID: <20230517061152-mutt-send-email-mst@kernel.org>
References: <20230517025424.601141-1-pizhenwei@bytedance.com>
 <20230516234444-mutt-send-email-mst@kernel.org>
 <8f3ca136-0276-49ca-d703-715c83cff557@bytedance.com>
 <20230516235541-mutt-send-email-mst@kernel.org>
 <949dd4db-89ea-4331-5fa7-700f96874ab3@bytedance.com>
 <20230517020947-mutt-send-email-mst@kernel.org>
 <b0b69e9d-da8a-791b-545f-c521dc752b88@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <b0b69e9d-da8a-791b-545f-c521dc752b88@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Wed, May 17, 2023 at 02:21:09PM +0800, zhenwei pi wrote:
> On 5/17/23 14:10, Michael S. Tsirkin wrote:
> > On Wed, May 17, 2023 at 12:58:10PM +0800, zhenwei pi wrote:
> > > On 5/17/23 11:57, Michael S. Tsirkin wrote:
> > > > On Wed, May 17, 2023 at 11:51:03AM +0800, zhenwei pi wrote:
> > > > > 
> > > > > 
> > > > > On 5/17/23 11:46, Michael S. Tsirkin wrote:
> > > > > > On Wed, May 17, 2023 at 10:54:22AM +0800, zhenwei pi wrote:
> > > > > > > v1 -> v2:
> > > > > > > - Suggested by MST, use fast path for vring based performance
> > > > > > > sensitive API.
> > > > > > > - Reduce changes in tools/virtio.
> > > > > > > 
> > > > > > > Add test result(no obvious change):
> > > > > > > Before:
> > > > > > > time ./vringh_test --parallel
> > > > > > > Using CPUS 0 and 191
> > > > > > > Guest: notified 10036893, pinged 68278
> > > > > > > Host: notified 68278, pinged 3093532
> > > > > > > 
> > > > > > > real	0m14.463s
> > > > > > > user	0m6.437s
> > > > > > > sys	0m8.010s
> > > > > > > 
> > > > > > > After:
> > > > > > > time ./vringh_test --parallel
> > > > > > > Using CPUS 0 and 191
> > > > > > > Guest: notified 10036709, pinged 68347
> > > > > > > Host: notified 68347, pinged 3085292
> > > > > > > 
> > > > > > > real	0m14.196s
> > > > > > > user	0m6.289s
> > > > > > > sys	0m7.885s
> > > > > > > 
> > > > > > > v1:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > 3 weeks ago, I posted a proposal 'Virtio Over Fabrics':
> > > > > > > https://lists.oasis-open.org/archives/virtio-comment/202304/msg00442.html
> > > > > > > 
> > > > > > > Jason and Stefan pointed out that a non-vring based virtqueue has a
> > > > > > > chance to overwrite virtqueue instead of using vring virtqueue.
> > > > > > > 
> > > > > > > Then I try to abstract virtqueue related methods in this series, the
> > > > > > > details changes see the comment of patch 'virtio: abstract virtqueue related methods'.
> > > > > > > 
> > > > > > > Something is still remained:
> > > > > > > - __virtqueue_break/__virtqueue_unbreak is supposed to use by internal
> > > > > > >      virtio core, I'd like to rename them to vring_virtqueue_break
> > > > > > >      /vring_virtqueue_unbreak. Is this reasonable?
> > > > > > 
> > > > > > Why? These just set a flag?
> > > > > > 
> > > > > 
> > > > > Rename '__virtqueue_break' to 'vring_virtqueue_break', to make symbols
> > > > > exported from virtio_ring.ko have unified prefix 'vring_virtqueue_xxx'.
> > > > 
> > > > I just do not see why you need these callbacks at all.
> > > > 
> > > 
> > > I use these callbacks for break/unbreak device like:
> > > static inline void virtio_break_device(struct virtio_device *dev)
> > > {
> > > 	struct virtqueue *vq;
> > > 
> > > 	spin_lock(&dev->vqs_list_lock);
> > > 	list_for_each_entry(vq, &dev->vqs, list) {
> > > 		vq->__break(vq);
> > > 	}
> > > 	spin_unlock(&dev->vqs_list_lock);
> > > }
> > 
> > why do this? backend knows they are broken.
> > 
> 
> I grep 'virtio_break_device' in the latest code:
> arch/um/drivers/virtio_uml.c:1147:	virtio_break_device(&vu_dev->vdev);
> arch/um/drivers/virtio_uml.c:1285:	virtio_break_device(&vu_dev->vdev);
> drivers/crypto/virtio/virtio_crypto_core.c:269:	
> virtio_break_device(vcrypto->vdev);
> drivers/s390/virtio/virtio_ccw.c:1251:			virtio_break_device(&vcdev->vdev);
> drivers/s390/virtio/virtio_ccw.c:1268:		virtio_break_device(&vcdev->vdev);
> drivers/firmware/arm_scmi/virtio.c:489:
> virtio_break_device(vioch->vqueue->vdev);
> drivers/char/virtio_console.c:1956:	virtio_break_device(vdev);
> 
> Some virtio drivers use 'virtio_break_device'...

You should read the code and understand what it does,
not just grep things and make assumptions.
What virtio_break_device does is stop linux from sending
new requests.


> > > > > > > - virtqueue_get_desc_addr/virtqueue_get_avail_addr/virtqueue_get_used_addr
> > > > > > >      /virtqueue_get_vring is vring specific, I'd like to rename them like
> > > > > > >      vring_virtqueue_get_desc_addr. Is this reasonable?
> > > > > > > - there are still some functions in virtio_ring.c with prefix *virtqueue*,
> > > > > > >      for example 'virtqueue_add_split', just keep it or rename it to
> > > > > > >      'vring_virtqueue_add_split'?
> > > > > > > zhenwei pi (2):
> > > > > > >      virtio: abstract virtqueue related methods
> > > > > > >      tools/virtio: implement virtqueue in test
> > > > > > > 
> > > > > > >     drivers/virtio/virtio_ring.c | 285 +++++-----------------
> > > > > > >     include/linux/virtio.h       | 441 +++++++++++++++++++++++++++++++----
> > > > > > >     include/linux/virtio_ring.h  |  26 +++
> > > > > > >     tools/virtio/linux/virtio.h  | 355 +++++++++++++++++++++++++---
> > > > > > >     4 files changed, 807 insertions(+), 300 deletions(-)
> > > > > > > 
> > > > > > > -- 
> > > > > > > 2.20.1
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > zhenwei pi
> > > > 
> > > 
> > > -- 
> > > zhenwei pi
> > 
> 
> -- 
> zhenwei pi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
