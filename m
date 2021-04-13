Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A853C43461
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 22:11:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B82906103D
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 22:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82906103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A543845C4;
	Tue, 13 Apr 2021 22:11:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7iZ9aphnmiJO; Tue, 13 Apr 2021 22:11:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDBE7845BD;
	Tue, 13 Apr 2021 22:11:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF60DC000B;
	Tue, 13 Apr 2021 22:11:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06A48C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9C466072F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:11:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WnpsFjkLLISW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:11:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BCF376069C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 22:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618351892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FwHJYneX3jqLvQL75mdfgjni6//ZDHqX9VNzr6xXMHI=;
 b=Ww5cao2LWhWc2LhE2LaTl4pmHVINTUoqX7FAEjtB9RwBO1atKmCa3tZ4qu7PO6ryi8Nkay
 MqeCbjPz98Dc+lMZ33g222Afn0tL+NHOjM26TPCYK93BYwvOAvCgFxnD6B5ERBhzvuUqpI
 Ahq2nMi0OdMIhf1jcffIw5lXQQidew4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-GFFfNWFiMZm6eQErLLzABQ-1; Tue, 13 Apr 2021 18:11:30 -0400
X-MC-Unique: GFFfNWFiMZm6eQErLLzABQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 c15-20020a5d63cf0000b02900ffc164a0ccso64390wrw.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 15:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FwHJYneX3jqLvQL75mdfgjni6//ZDHqX9VNzr6xXMHI=;
 b=M2thGV1gcDobeU57OcKEarZbZKf+2ja+h+cfPAmLo3kScONw5LnZqM4LB8yQQrxWFb
 oLddjCKqSKwOhl2C4ros8WQNFKF/rEQ/MWfKHyqispMFHHKXkLCnm3gpXF8xIav7Xp7L
 nJsAVaCzrFNLxOznmIxs5tHrerT5d/ZAaqXLl3vtiScfJJn1NRDNgEwkB4fd33tjYWrZ
 i7Xx0kKnLrLdU5Rs2eS4jnCrRFOxEfOHY26j95JZeXAPF+sJJBP3mhYF8DFo1dsohobu
 u/zjthGd5ESuVNPoRzmLLkajO3FPtiC5m2vTY0y9WZHyd5WcvR3zGuxGRiNfLT5UQkC/
 PR3w==
X-Gm-Message-State: AOAM532IKP+jYel/XwxXRi8/bQ07/H6opgewAHXM347q5ZowbPVFVj4f
 F4/uHJypgHS+dyylZQ1mjg7/rUwgTHPuS3Us6hV4FUFvCaqFYaXKENiZBBqeqX+Q/RaNtkJmhLN
 nGDCQoXhtVyTSn3dVO3RTwENuuW+g92GlDstSrihTEA==
X-Received: by 2002:adf:e34f:: with SMTP id n15mr39188350wrj.224.1618351888721; 
 Tue, 13 Apr 2021 15:11:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5dnyOsFJS1wT/Ww00ClVTfJyI0R8HAlU1+tiUWsyxyQSYd5Kbxrzx0ZYgAtA0joZ160eBpQ==
X-Received: by 2002:adf:e34f:: with SMTP id n15mr39188335wrj.224.1618351888477; 
 Tue, 13 Apr 2021 15:11:28 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id b5sm20635800wri.57.2021.04.13.15.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 15:11:27 -0700 (PDT)
Date: Tue, 13 Apr 2021 18:11:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC v2 1/4] virtio: fix up virtio_disable_cb
Message-ID: <20210413180830-mutt-send-email-mst@kernel.org>
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-2-mst@redhat.com>
 <CA+FuTSe_SjUY4JxR6G9b8a0nx-MfQOkLdHJSzmjpuRG4BvsVPw@mail.gmail.com>
 <20210413153951-mutt-send-email-mst@kernel.org>
 <CA+FuTSd7qagJAN0wpvudvi2Rvxn-SvQaBZ1SU9rwdb1x0j1s3g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+FuTSd7qagJAN0wpvudvi2Rvxn-SvQaBZ1SU9rwdb1x0j1s3g@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

On Tue, Apr 13, 2021 at 05:44:42PM -0400, Willem de Bruijn wrote:
> On Tue, Apr 13, 2021 at 3:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 13, 2021 at 10:01:11AM -0400, Willem de Bruijn wrote:
> > > On Tue, Apr 13, 2021 at 1:47 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > virtio_disable_cb is currently a nop for split ring with event index.
> > > > This is because it used to be always called from a callback when we know
> > > > device won't trigger more events until we update the index.  However,
> > > > now that we run with interrupts enabled a lot we also poll without a
> > > > callback so that is different: disabling callbacks will help reduce the
> > > > number of spurious interrupts.
> > >
> > > The device may poll for transmit completions as a result of an interrupt
> > > from virtnet_poll_tx.
> > >
> > > As well as asynchronously to this transmit interrupt, from start_xmit or
> > > from virtnet_poll_cleantx as a result of a receive interrupt.
> > >
> > > As of napi-tx, transmit interrupts are left enabled to operate in standard
> > > napi mode. While previously they would be left disabled for most of the
> > > time, enabling only when the queue as low on descriptors.
> > >
> > > (in practice, for the at the time common case of split ring with event index,
> > > little changed, as that mode does not actually enable/disable the interrupt,
> > > but looks at the consumer index in the ring to decide whether to interrupt)
> > >
> > > Combined, this may cause the following:
> > >
> > > 1. device sends a packet and fires transmit interrupt
> > > 2. driver cleans interrupts using virtnet_poll_cleantx
> > > 3. driver handles transmit interrupt using vring_interrupt,
> > >     detects that the vring is empty: !more_used(vq),
> > >     and records a spurious interrupt.
> > >
> > > I don't quite follow how suppressing interrupt suppression, i.e.,
> > > skipping disable_cb, helps avoid this.
> > > I'm probably missing something. Is this solving a subtly different
> > > problem from the one as I understand it?
> >
> > I was thinking of this one:
> >
> >  1. device is sending packets
> >  2. driver cleans them at the same time using virtnet_poll_cleantx
> >  3. device fires transmit interrupts
> >  4. driver handles transmit interrupts using vring_interrupt,
> >      detects that the vring is empty: !more_used(vq),
> >      and records spurious interrupts.
> 
> I think that's the same scenario

Not a big difference I agree.

> >
> >
> > but even yours is also fixed I think.
> >
> > The common point is that a single spurious interrupt is not a problem.
> > The problem only exists if there are tons of spurious interrupts with no
> > real ones. For this to trigger, we keep polling the ring and while we do
> > device keeps firing interrupts. So just disable interrupts while we
> > poll.
> 
> But the main change in this patch is to turn some virtqueue_disable_cb
> calls into no-ops.

Well this was not the design. This is the main change:


@@ -739,7 +742,10 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)

        if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
                vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
-               if (!vq->event)
+               if (vq->event)
+                       /* TODO: this is a hack. Figure out a cleaner value to write. */
+                       vring_used_event(&vq->split.vring) = 0x0;
+               else
                        vq->split.vring.avail->flags =
                                cpu_to_virtio16(_vq->vdev,
                                                vq->split.avail_flags_shadow);


IIUC previously when event index was enabled (vq->event) virtqueue_disable_cb_split
was a nop. Now it sets index to 0x0 (which is a hack, but good enough
for testing I think).

> I don't understand how that helps reduce spurious
> interrupts, as if anything, it keeps interrupts enabled for longer.
> 
> Another patch in the series disable callbacks* before starting to
> clean the descriptors from the rx interrupt. That I do understand will
> suppress additional tx interrupts that might see no work to be done. I
> just don't entire follow this patch on its own.
> 
> *(I use interrupt and callback as a synonym in this context, correct
> me if I'm glancing over something essential)

It's the same for the pci transport.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
