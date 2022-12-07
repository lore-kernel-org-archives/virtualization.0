Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9C8C352A1
	for <virtualization@archiver.kernel.org>; Wed,  7 Dec 2022 05:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B743E40B33;
	Wed,  7 Dec 2022 05:57:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B743E40B33
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dNrjSp0p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y3ojY_XoWvmp; Wed,  7 Dec 2022 05:56:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3E078405D0;
	Wed,  7 Dec 2022 05:56:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E078405D0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F69DC0032;
	Wed,  7 Dec 2022 05:56:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03984C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 05:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB9E981F7E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 05:56:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CB9E981F7E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dNrjSp0p
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XHxIn0tuSk_7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 05:56:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB85E81F7C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DB85E81F7C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Dec 2022 05:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670392615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lU+AyjZqCt5Zscy5OezHUmjY2MSPGosbS0p0NXtwsxU=;
 b=dNrjSp0puLXGE767gV+66g0kcC9YPRTb+DfSuVOu42108qj67woMJo1zLrfRGz3Pz02mPI
 GL91BS/kQC9peeI3Le+8ZKUt5wDOk573ntBjccWqZNTI1PVes+9owlto6KuPju8+gxG4fI
 7YyFQCIYzGSLad7O1NieZPihKQxJAxc=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-39-lzdGTj0YMOGrzFWSJ1QfUQ-1; Wed, 07 Dec 2022 00:56:54 -0500
X-MC-Unique: lzdGTj0YMOGrzFWSJ1QfUQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-142a7a82700so7575101fac.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Dec 2022 21:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lU+AyjZqCt5Zscy5OezHUmjY2MSPGosbS0p0NXtwsxU=;
 b=bWrHPobzPOBbKTk8ibl/l/lKcQcB8M8oIcpQD2YnrhM2nYqStDIZqwxGIiXI4gVV9m
 a6lKFkSmQ3W0bYMonykMN3aBkDZPZdiQD3nVlr0v6OMicWMpi2bJ7fbx6VJKPXBRxvAb
 +zukG1n+GznN0U/lyqfCXej+quMdTZ6gky+jRYl6e3uaAXEe5B8mcFPB34pxNClGfCUx
 ePGQxFxyhZlJFi/zw9PNrvNeP/2vInK+1w/H5uYTZ7T8igT1OgsAjbQb7BhezlMfEfAZ
 jyvRf8nO2mYNWXDgES0uW4kUFKZOAImr/jyUuXPFf2qJz3VvEdmQcSBY6kWdGDqtHQ5N
 Gyuw==
X-Gm-Message-State: ANoB5pnd/mYd6vvSQ9Tq5qY5U64xqy+bmyZcS6TC4ypYdP8W2/QW8YIT
 aaarCNMsn1CSQUHgkkFEIsH73pVKGaTQJdSU8GlIPxIEcp+1UjUMywkOw2wvVqgaNRALzcKw7fd
 sOGuJ9gB/0ecwjU0wZ+K4mP36uxxF3OtVRnBfulNcPErLbstsnqQfZFkFNA==
X-Received: by 2002:a05:6870:b9b:b0:144:b22a:38d3 with SMTP id
 lg27-20020a0568700b9b00b00144b22a38d3mr5150121oab.280.1670392613463; 
 Tue, 06 Dec 2022 21:56:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf77QPIsbA8jEogUQu/a5zSH+M+Eph6ulRoBolrhbx2gABP5M6e6zVN5P1JJfcS1nZURmB/WGzpOSOSC55QC1yk=
X-Received: by 2002:a05:6870:b9b:b0:144:b22a:38d3 with SMTP id
 lg27-20020a0568700b9b00b00144b22a38d3mr5150114oab.280.1670392613277; Tue, 06
 Dec 2022 21:56:53 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-2-xieyongji@bytedance.com>
 <20221206081847.GA8771@lst.de>
 <CACycT3sXHGQt_V=rgwvEv4v8+oUaAOu1T=tWrKePdybMHagzng@mail.gmail.com>
 <20221206084736.GA9507@lst.de>
 <CACycT3uk4FCswFj8VqqPDgdEM73iqMnYSL8j6DYxCiy1FNSvHQ@mail.gmail.com>
In-Reply-To: <CACycT3uk4FCswFj8VqqPDgdEM73iqMnYSL8j6DYxCiy1FNSvHQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Dec 2022 13:56:42 +0800
Message-ID: <CACGkMEtXiEk72coPnzKmFyTYun_9H+Gm-Hmj68R4x4sb4rp+aw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] genirq/affinity:: Export
 irq_create_affinity_masks()
To: Yongji Xie <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>
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

On Tue, Dec 6, 2022 at 5:28 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Tue, Dec 6, 2022 at 4:47 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Dec 06, 2022 at 04:40:37PM +0800, Yongji Xie wrote:
> > > With the vDPA framework, some drivers (vduse, vdpa-sim) can create
> > > software-defined virtio devices and attach them to the virtio bus.
> > > This kind of virtio device is not a pci device or a platform device.
> > > So it would be needed to export this function if we want to implement
> > > the automatic affinity management for the virtio device driver which
> > > is binded to this device.
> >
> > Why are these devices even using interrupts?
>
> They don't use interrupt. But they use a bound workqueue to run the
> interrupt callback. So the driver needs an algorithm to choose which
> cpu to run the interrupt callback. Then we found the existing
> interrupt affinity spreading mechanism is very suitable for this
> scenario, so we try to export this function to reuse it.
>
> > The whjole vdpa thing
> > is a mess, I also still need to fix up the horrible abuse of the DMA
> > API for something that isn't even DMA, and this just seems to spread
> > that same mistake even further.

I think it's mostly an issue of some vDPA parents, not the vDPA
itself. I had patches to get rid of the DMA API for vDPA simulators.
Will post.

>
> We just want to reuse this algorithm. And it is completely independent
> of the IRQ subsystem. I guess it would not mess things up.

I think so, it's about which CPU do we want to run the callback and
the callback is not necessarily triggered by an IRQ.

Thanks

>
> Thanks,
> Yongji
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
