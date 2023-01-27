Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6956DC38142
	for <virtualization@archiver.kernel.org>; Fri, 27 Jan 2023 11:12:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC54C417D4;
	Fri, 27 Jan 2023 11:12:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC54C417D4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YX1kyrjU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCdqSSZDhAeB; Fri, 27 Jan 2023 11:12:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 83097417CA;
	Fri, 27 Jan 2023 11:12:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 83097417CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68D52C0033;
	Fri, 27 Jan 2023 11:12:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97F72C0033
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F01661273
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:12:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F01661273
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YX1kyrjU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eg5qsNdAcxcE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:11:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 87F146125C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 87F146125C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674817918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DHdIigeHoqEjPUOvZqjrQoWLn5deR3YQuYptQY45zS0=;
 b=YX1kyrjUGB9CnVGZZrsAgZccqqGffNJdJDse3HVsdot5mRiABjrye8WmvNqCbZsCgo2QCr
 0iFCjF7eglcbBTTQDfv8C3/yzW9ojDq98XzzqJ5JknJgnAyDtVhjCilkzGg/lQ9GsPw5nH
 iiASuoaQ1uXoZR8qj8NAnxlUy/756Yw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-PHUXV75lN3iiL7rKPELOiA-1; Fri, 27 Jan 2023 06:11:57 -0500
X-MC-Unique: PHUXV75lN3iiL7rKPELOiA-1
Received: by mail-ej1-f71.google.com with SMTP id
 sc9-20020a1709078a0900b0086910fdf624so3238735ejc.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Jan 2023 03:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DHdIigeHoqEjPUOvZqjrQoWLn5deR3YQuYptQY45zS0=;
 b=sCg2XJYqrml+Vw9jbZgC0MFLssxqF0AqQlRt9X1sbN92jiYbx/WE+G2eIGbYAmP3yW
 ty1FX3Br1cc2FKPQuySM/n/Bx1m0vuPqbLJt9VONKg5TF6W7GcZNGf/YCY0Xb9l4c2rh
 hgUuchJUhp89zPKQoWHG5uyDYgW+wIAN28rk0KeLDF9psM7/CCmQkqp0lJAzZDoTytuH
 BOop3ixW6cLOXuf1Te6LEuJx7PUBQNHVHwv6bWXg/rnIZifHh7cAU7/jdkFJCuX7TyC7
 rfuuKoB5rm7IbeQ5nHRgYUf9Vh59YX28vuq2UDS9n301T+H8DUugWJuhzBa3/eesa9qj
 W53w==
X-Gm-Message-State: AFqh2kp7eh2PiW6pUpQgNVvax8P4VzcDDMHwxBIM6DgpxrjHR23Q89p0
 +4m3A7me6A3UGDkBzeJyYGScZn4PWXI/Fn1k1EKdPQJQq6xEBzOM2u5zZgQnTxoyqdJlPgslQOI
 WL6EkVtQnPa/U8HIfoeVy4xxI7OzwYwPDpDpGXvKoWA==
X-Received: by 2002:a17:907:9a09:b0:85d:3771:18b7 with SMTP id
 kr9-20020a1709079a0900b0085d377118b7mr42740080ejc.70.1674817915956; 
 Fri, 27 Jan 2023 03:11:55 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsScJCcghnX87V9jwJo9iQJunv09UWVsejj9/e/mmA0Ci2VvxS4YOTGCYGulNVAT6QXBdRv0w==
X-Received: by 2002:a17:907:9a09:b0:85d:3771:18b7 with SMTP id
 kr9-20020a1709079a0900b0085d377118b7mr42740046ejc.70.1674817915717; 
 Fri, 27 Jan 2023 03:11:55 -0800 (PST)
Received: from redhat.com ([2.52.137.69]) by smtp.gmail.com with ESMTPSA id
 y14-20020a17090668ce00b0084d3bf4498csm2082705ejr.140.2023.01.27.03.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jan 2023 03:11:55 -0800 (PST)
Date: Fri, 27 Jan 2023 06:11:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Zetao <lizetao1@huawei.com>
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
Message-ID: <20230127061055-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128042945-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20221128042945-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, rusty@rustcorp.com.au, ericvh@gmail.com,
 netdev@vger.kernel.org, linux_oss@crudebyte.com, linux-kernel@vger.kernel.org,
 davem@davemloft.net, linux-block@vger.kernel.org,
 v9fs-developer@lists.sourceforge.net, edumazet@google.com, stefanha@redhat.com,
 kuba@kernel.org, pbonzini@redhat.com, pabeni@redhat.com,
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

On Mon, Nov 28, 2022 at 05:14:44AM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 28, 2022 at 10:10:01AM +0800, Li Zetao wrote:
> > This patchset fixes similar issue, the root cause of the
> > problem is that the virtqueues are not stopped on error
> > handling path.
> 
> I've been thinking about this.
> Almost all drivers are affected.
> 
> The reason really is that it used to be the right thing to do:
> On legacy pci del_vqs writes 0
> into vq index and this resets the device as a side effect
> (we actually do this multiple times, what e.g. writes of MSI vector
>  after the 1st reset do I have no idea).
> 
> mmio ccw and modern pci don't.
> 
> Given this has been with us for a while I am inlined to look for
> a global solution rather than tweaking each driver.
> 
> Given many drivers are supposed to work on legacy too, we know del_vqs
> includes a reset for many of them. So I think I see a better way to do
> this:
> 
> Add virtio_reset_device_and_del_vqs()
> 
> and convert all drivers to that.
> 
> When doing this, we also need to/can fix a related problem (and related
> to the hardening that Jason Wang was looking into):
> virtio_reset_device is inherently racy: vq interrupts could
> be in flight when we do reset. We need to prevent handlers from firing in
> the window between reset and freeing the irq, so we should first
> free irqs and only then start changing the state by e.g.
> device reset.
> 
> 
> Quite a lot of core work here. Jason are you still looking into
> hardening?
> 

Li Zetao, Jason, any updates. You guys looking into this?


> 
> > Li Zetao (4):
> >   9p: Fix probe failed when modprobe 9pnet_virtio
> >   virtio-mem: Fix probe failed when modprobe virtio_mem
> >   virtio-input: Fix probe failed when modprobe virtio_input
> >   virtio-blk: Fix probe failed when modprobe virtio_blk
> > 
> >  drivers/block/virtio_blk.c    | 1 +
> >  drivers/virtio/virtio_input.c | 1 +
> >  drivers/virtio/virtio_mem.c   | 1 +
> >  net/9p/trans_virtio.c         | 1 +
> >  4 files changed, 4 insertions(+)
> > 
> > -- 
> > 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
