Return-Path: <SRS0=80gr=L4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F94C07E95
	for <virtualization@archiver.kernel.org>; Sun,  4 Jul 2021 08:31:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4508161452
	for <virtualization@archiver.kernel.org>; Sun,  4 Jul 2021 08:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4508161452
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0359240299;
	Sun,  4 Jul 2021 08:31:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ucFjUpacFgBH; Sun,  4 Jul 2021 08:31:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 56ECD40191;
	Sun,  4 Jul 2021 08:31:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17257C0010;
	Sun,  4 Jul 2021 08:31:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56D5EC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 08:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 354AE6061B
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 08:31:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8_gxTIS5kSo
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 08:30:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C364D60615
 for <virtualization@lists.linux-foundation.org>;
 Sun,  4 Jul 2021 08:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625387457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5mjv6RdL7FMrY4HG6p07wZrW4/GnliOhXTbPvIgXM+o=;
 b=H8THpi2wAXgD4xRxaIMpHH1/wIRiAf8o95SRKboOploAm87ookkwqHgBorKmJUj7dWPEic
 BVT1eleqQzftnHXhWo/b6XrKRyI94HSvXzNVECXCmcg5KQwIgoMXfvAKHxjK3afO7cx9YD
 gnACHFXL+ojo9LakNIpOSf0wxoWq0lc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-beXLaJuWOrCftTwWtlSfxw-1; Sun, 04 Jul 2021 04:30:56 -0400
X-MC-Unique: beXLaJuWOrCftTwWtlSfxw-1
Received: by mail-wm1-f71.google.com with SMTP id
 t82-20020a1cc3550000b02901ee1ed24f94so8204305wmf.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 04 Jul 2021 01:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5mjv6RdL7FMrY4HG6p07wZrW4/GnliOhXTbPvIgXM+o=;
 b=KuCu6TKMI9U7kb96bQvA0fy3uBmtOy9IDdUXM+w5HmIihQ+rcQvJjHErAMItLXhL+y
 /+FKx75P5ENGTKZHm547HyHgeHShjCgA4iZz42bqVkt5d+NcF5q8uib6U7EiaFxIuz8Y
 XwV90LrLCaS0iFoDJXuHkhYhU07WBnvYiMYKm2wt1wTiDGqHSizGnB4M8NZv7rgy9y1H
 k+8bkGvynnhHRNaBN/nR9bnAI1LuSOP+ht9KizQTW8fo8gzpUL6G3lrmZzB1kUTdDllC
 5EkE/Z82V/wHqxNoQGWqgdg15tRMk12eRkWCxxGDxyOk5XuQJd7GEi0ca9Jtjc6MQdbY
 o7EA==
X-Gm-Message-State: AOAM531AvPhryexEObTGr9xTkrB0Dn11OnGrxB0ETVkwZO9dnt/Yzg2J
 pRDbGJUqbTqhcdRunLykH3RRKoIn99Sx4sNA32xo/0DCCJ77mJBwV5HXJXRo89O6BAV+3mX3rSR
 CyvJKBXHLE7qKL4nXURB2x3rpGawDtaccISDc/jgPgg==
X-Received: by 2002:adf:e5c9:: with SMTP id a9mr8700542wrn.376.1625387455087; 
 Sun, 04 Jul 2021 01:30:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwxGgBxRdRHKsi3pLvnR9YQmU1IRGI0nidEiliUf/DDtuDrxohgpJHy7wgnQWR8PGRO13Hew==
X-Received: by 2002:adf:e5c9:: with SMTP id a9mr8700530wrn.376.1625387454934; 
 Sun, 04 Jul 2021 01:30:54 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
 by smtp.gmail.com with ESMTPSA id l10sm8293941wrt.49.2021.07.04.01.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jul 2021 01:30:54 -0700 (PDT)
Date: Sun, 4 Jul 2021 04:30:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v2 0/6] Improve SOCK_SEQPACKET receive logic
Message-ID: <20210704042843-mutt-send-email-mst@kernel.org>
References: <20210704080820.88746-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210704080820.88746-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Sun, Jul 04, 2021 at 11:08:13AM +0300, Arseny Krasnov wrote:
> 	This patchset modifies receive logic for SOCK_SEQPACKET.
> Difference between current implementation and this version is that
> now reader is woken up when there is at least one RW packet in rx
> queue of socket and data is copied to user's buffer, while merged
> approach wake up user only when whole message is received and kept
> in queue. New implementation has several advantages:
>  1) There is no limit for message length. Merged approach requires
>     that length must be smaller than 'peer_buf_alloc', otherwise
>     transmission will stuck.
>  2) There is no need to keep whole message in queue, thus no
>     'kmalloc()' memory will be wasted until EOR is received.
> 
>     Also new approach has some feature: as fragments of message
> are copied until EOR is received, it is possible that part of
> message will be already in user's buffer, while rest of message
> still not received. And if user will be interrupted by signal or
> timeout with part of message in buffer, it will exit receive loop,
> leaving rest of message in queue. To solve this problem special
> callback was added to transport: it is called when user was forced
> to leave exit loop and tells transport to drop any packet until
> EOR met.

Sorry about commenting late in the game.  I'm a bit lost


SOCK_SEQPACKET
Provides sequenced, reliable, bidirectional, connection-mode transmission paths for records. A record can be sent using one or more output operations and received using one or more input operations, but a single operation never transfers part of more than one record. Record boundaries are visible to the receiver via the MSG_EOR flag.

it's supposed to be reliable - how is it legal to drop packets?


> When EOR is found, this mode is disabled and normal packet
> processing started. Note, that when 'drop until EOR' mode is on,
> incoming packets still inserted in queue, reader will be woken up,
> tries to copy data, but nothing will be copied until EOR found.
> It was possible to drain such unneeded packets it rx work without
> kicking user, but implemented way is simplest. Anyway, i think
> such cases are rare.


>     New test also added - it tries to copy to invalid user's
> buffer.
> 
> Arseny Krasnov (16):
>  af_vsock/virtio/vsock: change seqpacket receive logic
>  af_vsock/virtio/vsock: remove 'seqpacket_has_data' callback
>  virtio/vsock: remove 'msg_count' based logic
>  af_vsock/virtio/vsock: add 'seqpacket_drop()' callback
>  virtio/vsock: remove record size limit for SEQPACKET
>  vsock_test: SEQPACKET read to broken buffer
> 
>  drivers/vhost/vsock.c                   |   2 +-
>  include/linux/virtio_vsock.h            |   7 +-
>  include/net/af_vsock.h                  |   4 +-
>  net/vmw_vsock/af_vsock.c                |  44 ++++----
>  net/vmw_vsock/virtio_transport.c        |   2 +-
>  net/vmw_vsock/virtio_transport_common.c | 103 ++++++++-----------
>  net/vmw_vsock/vsock_loopback.c          |   2 +-
>  tools/testing/vsock/vsock_test.c        | 120 ++++++++++++++++++++++
>  8 files changed, 193 insertions(+), 91 deletions(-)
> 
>  v1 -> v2:
>  Patches reordered and reorganized.
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> ---
>  cv.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 cv.txt
> 
> diff --git a/cv.txt b/cv.txt
> new file mode 100644
> index 000000000000..e69de29bb2d1
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
