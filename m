Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA45AC05027
	for <virtualization@archiver.kernel.org>; Sun, 29 Jan 2023 05:50:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EF5660E85;
	Sun, 29 Jan 2023 05:50:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6EF5660E85
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MLV/P/Rd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uVMFpNSrwEhk; Sun, 29 Jan 2023 05:50:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E9FA460D57;
	Sun, 29 Jan 2023 05:50:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9FA460D57
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB678C0033;
	Sun, 29 Jan 2023 05:50:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B1EDC002B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07A0881E13
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:50:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07A0881E13
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MLV/P/Rd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MnQAmeHGSZz2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:50:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B74DB81DFC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B74DB81DFC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Jan 2023 05:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674971443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ESfJeO4v/Sc9kZuGNKusexDTFykbAPKz0X+uhnEfDU=;
 b=MLV/P/Rdubq5VcL7aPcEpSPNS8/P6co70ymJohI84/ffAPeYeKeI+9TvQ+faXRDdtoW8Le
 OlV4y0hJC0PqYecotHk+uRu3b3vxP5pqsX8XsAV5Mr+a7k2RRupJ1Ijfn03khcJEZTxtKr
 uAOMlzf6WN4AraIQeg4sRxoYxJUYYeI=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-601-sBFMBhr6OdK9_t4QooZM1w-1; Sun, 29 Jan 2023 00:50:41 -0500
X-MC-Unique: sBFMBhr6OdK9_t4QooZM1w-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-15fddea3ee9so3115299fac.21
 for <virtualization@lists.linux-foundation.org>;
 Sat, 28 Jan 2023 21:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ESfJeO4v/Sc9kZuGNKusexDTFykbAPKz0X+uhnEfDU=;
 b=68AcDaTk5TkBnQ9yjTznvgMiZsojBTgwtLvsAo+NXyjisJpxRUNbwQgiB0pdX3GuZ1
 EOoHmIbqYWzwFFo7M8OwgUMxhiYKaO7v3W74dFfRJId4+45a7lbmcs1kCZgwHWaseQrl
 +JWZVlFUYi8g5rtby8bl1L0ocIQ+HwEhGmBhRECUCWBJzOQhKuCe4Y2pdZEriKRFVoRy
 Rbt0f5rPvpP0M4d5BWXhNVIMcyiEoia7HtmHSo9Rv/yozhnXjk47nTqGTC+84kY8uuke
 WGd7A7vgYbuZrpDHCfFIJiZlh/HDvkJXHEHr9xlQNdjLpCRmMpErKqJsdxX3JWO7mek6
 oezA==
X-Gm-Message-State: AO0yUKVNh8tMWwh8hH2Q+CNFg/1DlhZJWmEXWjiCpGTutFO8waIUAwyl
 6x8nh16AyPdCc8nCQIUK2pDkbpyEolvpz25ovJ03H17r8Zfk06xUwEPY+kw/uPvdPlpJa2W4ByU
 wYUHQoVgP0VJ2lQtFlY33urYO/VtmaqxJl4fcoEn04RQ8Qs1atH8ReIaMWw==
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr115420oao.35.1674971440529; 
 Sat, 28 Jan 2023 21:50:40 -0800 (PST)
X-Google-Smtp-Source: AK7set+UoO/1kphXCPY28/DKX9hwQUG6JjAGE74TUF7dLTKDNr1tk08D4Bhi3bKgLWdo5+0Rqlh3eus5Dyvey48IMPg=
X-Received: by 2002:a05:6870:959e:b0:163:9cea:eea7 with SMTP id
 k30-20020a056870959e00b001639ceaeea7mr115403oao.35.1674971440262; Sat, 28 Jan
 2023 21:50:40 -0800 (PST)
MIME-Version: 1.0
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128042945-mutt-send-email-mst@kernel.org>
 <20230127061055-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230127061055-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 29 Jan 2023 13:50:29 +0800
Message-ID: <CACGkMEszd0O-juD93nMQEmOA0w+rq_pE-je5xj+XkMc7nwUR4w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: axboe@kernel.dk, rusty@rustcorp.com.au, ericvh@gmail.com,
 netdev@vger.kernel.org, linux_oss@crudebyte.com,
 Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 v9fs-developer@lists.sourceforge.net, edumazet@google.com, stefanha@redhat.com,
 kuba@kernel.org, pbonzini@redhat.com, pabeni@redhat.com, davem@davemloft.net
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

On Fri, Jan 27, 2023 at 7:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Nov 28, 2022 at 05:14:44AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Nov 28, 2022 at 10:10:01AM +0800, Li Zetao wrote:
> > > This patchset fixes similar issue, the root cause of the
> > > problem is that the virtqueues are not stopped on error
> > > handling path.
> >
> > I've been thinking about this.
> > Almost all drivers are affected.
> >
> > The reason really is that it used to be the right thing to do:
> > On legacy pci del_vqs writes 0
> > into vq index and this resets the device as a side effect
> > (we actually do this multiple times, what e.g. writes of MSI vector
> >  after the 1st reset do I have no idea).
> >
> > mmio ccw and modern pci don't.
> >
> > Given this has been with us for a while I am inlined to look for
> > a global solution rather than tweaking each driver.
> >
> > Given many drivers are supposed to work on legacy too, we know del_vqs
> > includes a reset for many of them. So I think I see a better way to do
> > this:
> >
> > Add virtio_reset_device_and_del_vqs()
> >
> > and convert all drivers to that.
> >
> > When doing this, we also need to/can fix a related problem (and related
> > to the hardening that Jason Wang was looking into):
> > virtio_reset_device is inherently racy: vq interrupts could
> > be in flight when we do reset. We need to prevent handlers from firing in
> > the window between reset and freeing the irq, so we should first
> > free irqs and only then start changing the state by e.g.
> > device reset.
> >
> >
> > Quite a lot of core work here. Jason are you still looking into
> > hardening?
> >
>
> Li Zetao, Jason, any updates. You guys looking into this?

At least I will continue the work of IRQ hardening. And this work
could be done on top.

Thanks

>
>
> >
> > > Li Zetao (4):
> > >   9p: Fix probe failed when modprobe 9pnet_virtio
> > >   virtio-mem: Fix probe failed when modprobe virtio_mem
> > >   virtio-input: Fix probe failed when modprobe virtio_input
> > >   virtio-blk: Fix probe failed when modprobe virtio_blk
> > >
> > >  drivers/block/virtio_blk.c    | 1 +
> > >  drivers/virtio/virtio_input.c | 1 +
> > >  drivers/virtio/virtio_mem.c   | 1 +
> > >  net/9p/trans_virtio.c         | 1 +
> > >  4 files changed, 4 insertions(+)
> > >
> > > --
> > > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
