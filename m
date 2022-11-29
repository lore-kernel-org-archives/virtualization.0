Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D644EC4332F
	for <virtualization@archiver.kernel.org>; Tue, 29 Nov 2022 03:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44EE881DF1;
	Tue, 29 Nov 2022 03:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44EE881DF1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gfa7O35W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8IXXSj8G7XtA; Tue, 29 Nov 2022 03:37:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC23A81DCB;
	Tue, 29 Nov 2022 03:37:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC23A81DCB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82B83C0032;
	Tue, 29 Nov 2022 03:37:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D305CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 03:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A7F9404DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 03:37:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A7F9404DD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gfa7O35W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C6d_zOpeWfnm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 03:37:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 60EA540116
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60EA540116
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Nov 2022 03:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669693042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjWTah+2EKxcXo7oWQgA5SpjVxywoPSBhBg+WInwWOQ=;
 b=gfa7O35WEZiNpPLNiD4W1HnSy6Ac64D4P4fMl/Zml/QvKCZHx3T30QQtfufXzIu/ho3wAe
 q6jyY2C2uqvfAzqFcl5RbguTZjKnPvk8lRhT82blzDNjRkUqrZ0CG5b8Kg/mNh76i0yuVX
 dkg4xJokGvxULV4qVbchNxdLn92bj3U=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-RzYIpCeHNGmbt7f2mwSsGg-1; Mon, 28 Nov 2022 22:37:21 -0500
X-MC-Unique: RzYIpCeHNGmbt7f2mwSsGg-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-143248a54e5so7453564fac.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 19:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DjWTah+2EKxcXo7oWQgA5SpjVxywoPSBhBg+WInwWOQ=;
 b=tyl/UE8tIcdcYhgK1fOp7UGNqLPqducW3ymG5+4oJTr33+Q7am4r3wloClZFjuigVY
 goYo/ID5fCYRONchg8HeGrOOj+zzmxGsyaNy5A213QcTGzbZXpYJ7Xk4UmfncDr87Xc2
 Iea4pU3sm3NGK2WC8e3aBJdCwhSEq+EsUEajWinrk7bUnlv99ohnFudISS0VRVzgua3E
 qlFNFLWBnWIv8zEpuwQxIznXrfQMZJYBUp77TYG4KJ+tq8DDAjPmq7gY7b2feu6+yB4N
 cAR8WPUHSQYeutrEFDfeXTUTXuIypvUicM3PjXGomg5fHtA8/DxOjq9P35mxbXkByGEK
 7OjQ==
X-Gm-Message-State: ANoB5pmozAiiCmCjtWM15doKVVRCKr9DllkSypDR7StJPYi5qCJW8W7i
 NXwWO7kOANbHrFlrSGu1ic7DN3BlmWCvhSaQnylAHpsu1i/G84qlfVqsAzArJAs9wDFrh6pXMg3
 Oufo+cPl8Z8XF4Fj/uMB7fYcGpdAmPVXaVfwoSCW/MLKPsCdrzj7i0gw9cA==
X-Received: by 2002:a9d:4f07:0:b0:66c:64d6:1bb4 with SMTP id
 d7-20020a9d4f07000000b0066c64d61bb4mr27085071otl.201.1669693040567; 
 Mon, 28 Nov 2022 19:37:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6EmIDabO2AHcWjiaME3fUs69AGG9zkVypks4R3pv1UesNWwbFvYcjoNz9Z4Pyc98HwSff6j5CYa7YoG0PBT3E=
X-Received: by 2002:a9d:4f07:0:b0:66c:64d6:1bb4 with SMTP id
 d7-20020a9d4f07000000b0066c64d61bb4mr27085052otl.201.1669693040323; Mon, 28
 Nov 2022 19:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128042945-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221128042945-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 29 Nov 2022 11:37:09 +0800
Message-ID: <CACGkMEtuOk+wyCsvY0uayGAvy926G381PC-csoXVAwCfiKCZQw@mail.gmail.com>
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

On Mon, Nov 28, 2022 at 6:14 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
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
> into vq index

into vq address actually?

> and this resets the device as a side effect

I think there's no guarantee for a device to do this.

> (we actually do this multiple times, what e.g. writes of MSI vector
>  after the 1st reset do I have no idea).
>
> mmio ccw and modern pci don't.
>
> Given this has been with us for a while I am inlined to look for
> a global solution rather than tweaking each driver.

But do we still need patches for -stable at least?

>
> Given many drivers are supposed to work on legacy too, we know del_vqs
> includes a reset for many of them. So I think I see a better way to do
> this:
>
> Add virtio_reset_device_and_del_vqs()

What's the difference with the current del_vqs method? Is this something like:

virtio_reset_device();
config->del_vqs();

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

Yes.

>
>
> Quite a lot of core work here. Jason are you still looking into
> hardening?

Yes, last time we've discussed a solution that depends on the first
kick to enable the interrupt handler. But after some thought, it seems
risky since there's no guarantee that the device work in this way.

One example is the current vhost_net, it doesn't wait for the kick to
process the rx packets. Any more thought on this?

Thanks


>
>
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
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
