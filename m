Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594D1C43217
	for <virtualization@archiver.kernel.org>; Mon, 28 Nov 2022 10:15:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB237414E0;
	Mon, 28 Nov 2022 10:15:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CB237414E0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MgJzCBvo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xSuklaLYLgyB; Mon, 28 Nov 2022 10:14:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DF02A409DB;
	Mon, 28 Nov 2022 10:14:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF02A409DB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B95B6C0033;
	Mon, 28 Nov 2022 10:14:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D1B8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EEFE160B50
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:14:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EEFE160B50
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MgJzCBvo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kSFn7V2_mHZd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:14:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FB3260A9F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1FB3260A9F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669630494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBqAwBRWRjtW0ICmoI0uX4BeXltXbya2cc38sf5NvgE=;
 b=MgJzCBvoH7BvQI8C1BhL7qz3xgJXeFQffTVHuDuSBYN/LLIyUBx77bQawCAU3Xw3vUYluj
 8vi1mmt9/Je0VOCI2SVaaDmyx1MZtKlz4LY8fvtVADuOFV+Dz/jw9RHgL/aS6b6ceO/8Fx
 TkcOQ/ruTC/9dJ5ItSWhnFXVD2BLn+k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-Dh5W1HB4ND6RC08anQru7w-1; Mon, 28 Nov 2022 05:14:45 -0500
X-MC-Unique: Dh5W1HB4ND6RC08anQru7w-1
Received: by mail-wr1-f69.google.com with SMTP id
 g14-20020adfa48e000000b00241f94bcd54so1747786wrb.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Nov 2022 02:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBqAwBRWRjtW0ICmoI0uX4BeXltXbya2cc38sf5NvgE=;
 b=YZzu1zXB/EIji7XhyE4ob9SJOZW8riwayIHBJGI/bQ9Q4AOuI7A/RjMNiRH/7YtKHt
 TzU4L5CjWkFZjfm3Aow7EdoIfJkhM8o6Ghfsnc9i8/P9qAEw7Wu3SiiyG7mGWcJtErzI
 2FfLcrToGOvONQf4KHpHOucmVInkPV/KvKLDOYzy/2yQ+PmLh34TSTzLgXYaw/2XDsI1
 dfEYgFDGY4sveiHliEK2ruLnRhUrtwEh97qWrT4OtMCsMpaG2dXSkz4CJSCzEpu/S/p6
 mNVVa1jxbO473SlxXeh7MTAnsMBd1ddEugDV3/FAHSDRmdHko0zSjjw8dlKRwUWFyeLz
 hD3w==
X-Gm-Message-State: ANoB5plYxpMgZ0UbCvLi4FHO/JwUnsvQ7jZOnfnIC2dg5HLcsOTE+B2n
 WDR2Ig2snRAPXr8kKO3j2qi5YLEzX9fTN1CqCTEl0SWedOo+38ucsi6cyskiP9qhSnV1oP1dQjM
 7Yi2k+DWpwWh0c0c5z9ZTfHqX3j2joDh8lsB6zJwytw==
X-Received: by 2002:adf:f302:0:b0:242:1dbc:2d29 with SMTP id
 i2-20020adff302000000b002421dbc2d29mr318231wro.609.1669630484333; 
 Mon, 28 Nov 2022 02:14:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ewYVQblwq/AEaxJGpgSzFXdQ+34eT0h/HaNR6C/0BgeFYG90YGVYdSwR7BSPWiouADYG5SQ==
X-Received: by 2002:adf:f302:0:b0:242:1dbc:2d29 with SMTP id
 i2-20020adff302000000b002421dbc2d29mr318211wro.609.1669630484132; 
 Mon, 28 Nov 2022 02:14:44 -0800 (PST)
Received: from redhat.com ([2.52.149.178]) by smtp.gmail.com with ESMTPSA id
 a12-20020adfe5cc000000b0022cc3e67fc5sm10146135wrn.65.2022.11.28.02.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Nov 2022 02:14:43 -0800 (PST)
Date: Mon, 28 Nov 2022 05:14:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Zetao <lizetao1@huawei.com>
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
Message-ID: <20221128042945-mutt-send-email-mst@kernel.org>
References: <20221128021005.232105-1-lizetao1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20221128021005.232105-1-lizetao1@huawei.com>
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

On Mon, Nov 28, 2022 at 10:10:01AM +0800, Li Zetao wrote:
> This patchset fixes similar issue, the root cause of the
> problem is that the virtqueues are not stopped on error
> handling path.

I've been thinking about this.
Almost all drivers are affected.

The reason really is that it used to be the right thing to do:
On legacy pci del_vqs writes 0
into vq index and this resets the device as a side effect
(we actually do this multiple times, what e.g. writes of MSI vector
 after the 1st reset do I have no idea).

mmio ccw and modern pci don't.

Given this has been with us for a while I am inlined to look for
a global solution rather than tweaking each driver.

Given many drivers are supposed to work on legacy too, we know del_vqs
includes a reset for many of them. So I think I see a better way to do
this:

Add virtio_reset_device_and_del_vqs()

and convert all drivers to that.

When doing this, we also need to/can fix a related problem (and related
to the hardening that Jason Wang was looking into):
virtio_reset_device is inherently racy: vq interrupts could
be in flight when we do reset. We need to prevent handlers from firing in
the window between reset and freeing the irq, so we should first
free irqs and only then start changing the state by e.g.
device reset.


Quite a lot of core work here. Jason are you still looking into
hardening?



> Li Zetao (4):
>   9p: Fix probe failed when modprobe 9pnet_virtio
>   virtio-mem: Fix probe failed when modprobe virtio_mem
>   virtio-input: Fix probe failed when modprobe virtio_input
>   virtio-blk: Fix probe failed when modprobe virtio_blk
> 
>  drivers/block/virtio_blk.c    | 1 +
>  drivers/virtio/virtio_input.c | 1 +
>  drivers/virtio/virtio_mem.c   | 1 +
>  net/9p/trans_virtio.c         | 1 +
>  4 files changed, 4 insertions(+)
> 
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
